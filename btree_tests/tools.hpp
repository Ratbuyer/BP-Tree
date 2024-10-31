#include <vector>
#include <mutex>
#include <algorithm>
#include <stdexcept>
#include <condition_variable>

template <typename T>
class ThreadSafeVector {
private:
    std::vector<T> data;
    mutable std::mutex vecMutex;

public:
    // Insert a new element in a thread-safe manner
    void push_back(const T& value) {
        std::lock_guard<std::mutex> lock(vecMutex);
        data.push_back(value);
    }

    // Get the maximum element in the vector in a thread-safe manner
    T get_max() const {
        std::lock_guard<std::mutex> lock(vecMutex);
        if (data.empty()) {
            throw std::runtime_error("Vector is empty");
        }
        return *std::max_element(data.begin(), data.end());
    }

    // Get the percentile element in a thread-safe manner
    T get_percentile(double percentile) const {
        std::lock_guard<std::mutex> lock(vecMutex);
        if (data.empty()) {
            throw std::runtime_error("Vector is empty");
        }
        if (percentile < 0.0 || percentile > 100.0) {
            throw std::invalid_argument("Percentile must be between 0 and 100");
        }

        // Make a copy of the data and sort it to find the percentile
        std::vector<T> sortedData = data;
        std::sort(sortedData.begin(), sortedData.end());

        // Calculate the index for the percentile
        size_t index = static_cast<size_t>((percentile / 100.0) * (sortedData.size() - 1));
        return sortedData[index];
    }

    void print_percentile(double percentile) const {
        std::lock_guard<std::mutex> lock(vecMutex);
        if (data.empty()) {
            return;
        }
        if (percentile < 0.0 || percentile > 100.0) {
            return;
        }

        // Make a copy of the data and sort it to find the percentile
        std::vector<T> sortedData = data;
        std::sort(sortedData.begin(), sortedData.end());

        // Calculate the index for the percentile
        size_t index = static_cast<size_t>((percentile / 100.0) * (sortedData.size() - 1));
        std::cout << "Percentile " << percentile << ": " << sortedData[index] << std::endl;
    }

    // Get the size of the vector (for testing purposes)
    size_t size() const {
        std::lock_guard<std::mutex> lock(vecMutex);
        return data.size();
    }
};