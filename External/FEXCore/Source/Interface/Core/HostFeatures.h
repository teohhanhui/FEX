#pragma once
#include <cstdint>

namespace FEXCore {
class HostFeatures final {
  public:
    HostFeatures();

    /**
     * @brief Backend features that change how codegen is generated from IR
     *
     * Specifically things that affect the IR->Codegen process
     * Not the x86->IR process
     */
    uint32_t DCacheLineSize{};
    uint32_t ICacheLineSize{};
    bool SupportsAES{};
    bool SupportsCLZERO{};
    bool SupportsAtomics{};
    bool SupportsRCPC{};
};
}
