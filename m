From: Will Deacon <will@kernel.org>
Subject: [PATCH 00/18] Allow architectures to override __READ_ONCE()
Date: Tue, 30 Jun 2020 18:37:16 +0100
Message-ID: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

Hi everyone,

This is the long-awaited version two of the patches I previously
posted in November last year:

  https://lore.kernel.org/lkml/20191108170120.22331-1-will@kernel.org/

I ended up parking the series while the READ_ONCE() implementation was
being overhauled, but with that merged during the recent merge window
and LTO patches being posted again [1], it was time for a refresh.

The patches allow architectures to provide their own implementation of
__READ_ONCE(). This serves two main purposes:

  1. It finally allows us to remove [smp_]read_barrier_depends() from the
     Linux memory model and make it an implementation detail of the Alpha
     back-end.

  2. It allows arm64 to upgrade __READ_ONCE() to have RCpc acquire
     semantics when compiling with LTO, since this may enable compiler
     optimisations that break dependency ordering and therefore we
     require fencing to ensure ordering within the CPU.

Both of these are implemented by this series.

I've kept Paul's acks from v1 since, although the series has changed
somewhat, the patches with his Ack have not changed materially in my
opinion. I will drop them if anybody objects.

In terms of merging this, my preference would be a stable branch in the
arm64 tree, which others can pull in as they need it.

Cheers,

Will

[1] https://lore.kernel.org/r/20200624203200.78870-1-samitolvanen@google.com

Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org>
Cc: linux-alpha@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: kernel-team@android.com

--->8

SeongJae Park (1):
  Documentation/barriers/kokr: Remove references to
    [smp_]read_barrier_depends()

Will Deacon (17):
  tools: bpf: Use local copy of headers including uapi/linux/filter.h
  compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h
  asm/rwonce: Allow __READ_ONCE to be overridden by the architecture
  alpha: Override READ_ONCE() with barriered implementation
  asm/rwonce: Remove smp_read_barrier_depends() invocation
  vhost: Remove redundant use of read_barrier_depends() barrier
  alpha: Replace smp_read_barrier_depends() usage with smp_[r]mb()
  locking/barriers: Remove definitions for [smp_]read_barrier_depends()
  Documentation/barriers: Remove references to
    [smp_]read_barrier_depends()
  tools/memory-model: Remove smp_read_barrier_depends() from informal
    doc
  include/linux: Remove smp_read_barrier_depends() from comments
  checkpatch: Remove checks relating to [smp_]read_barrier_depends()
  arm64: Reduce the number of header files pulled into vmlinux.lds.S
  arm64: alternatives: Split up alternative.h
  arm64: cpufeatures: Add capability for LDAPR instruction
  arm64: alternatives: Remove READ_ONCE() usage during patch operation
  arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y

 .../RCU/Design/Requirements/Requirements.rst  |   2 +-
 Documentation/memory-barriers.txt             | 156 +---------
 .../translations/ko_KR/memory-barriers.txt    | 146 +--------
 arch/alpha/include/asm/atomic.h               |  16 +-
 arch/alpha/include/asm/barrier.h              |  61 +---
 arch/alpha/include/asm/pgtable.h              |  10 +-
 arch/alpha/include/asm/rwonce.h               |  19 ++
 arch/arm64/Kconfig                            |   3 +
 arch/arm64/include/asm/alternative-macros.h   | 276 ++++++++++++++++++
 arch/arm64/include/asm/alternative.h          | 267 +----------------
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/insn.h                 |   3 +-
 arch/arm64/include/asm/kernel-pgtable.h       |   2 +-
 arch/arm64/include/asm/memory.h               |  11 +-
 arch/arm64/include/asm/rwonce.h               |  63 ++++
 arch/arm64/include/asm/uaccess.h              |   1 +
 arch/arm64/kernel/alternative.c               |   7 +-
 arch/arm64/kernel/cpufeature.c                |  10 +
 arch/arm64/kernel/entry.S                     |   1 +
 arch/arm64/kernel/vdso/Makefile               |   2 +-
 arch/arm64/kernel/vdso32/Makefile             |   2 +-
 arch/arm64/kernel/vmlinux.lds.S               |   1 -
 arch/arm64/kvm/hyp-init.S                     |   1 +
 drivers/vhost/vhost.c                         |   5 -
 include/asm-generic/Kbuild                    |   1 +
 include/asm-generic/barrier.h                 |  17 --
 include/asm-generic/rwonce.h                  |  82 ++++++
 include/linux/compiler.h                      |  83 +-----
 include/linux/percpu-refcount.h               |   2 +-
 include/linux/ptr_ring.h                      |   2 +-
 mm/memory.c                                   |   2 +-
 scripts/checkpatch.pl                         |   9 +-
 tools/bpf/Makefile                            |   3 +-
 tools/include/uapi/linux/filter.h             |  90 ++++++
 .../Documentation/explanation.txt             |  26 +-
 35 files changed, 617 insertions(+), 768 deletions(-)
 create mode 100644 arch/alpha/include/asm/rwonce.h
 create mode 100644 arch/arm64/include/asm/alternative-macros.h
 create mode 100644 arch/arm64/include/asm/rwonce.h
 create mode 100644 include/asm-generic/rwonce.h
 create mode 100644 tools/include/uapi/linux/filter.h

-- 
2.27.0.212.ge8ba1cc988-goog
