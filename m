From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] virtual: Documentation: simplify and generalize
	paravirt_ops.txt
Date: Tue, 10 Feb 2015 16:29:43 -0800
Message-ID: <1423614583-31024-1-git-send-email-mcgrof__45006.6294208684$1423634929$gmane$org@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, chrisw@sous-sol.org, akataria@vmware.com, jeremy@goop.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, kvm@vger.kernel.org, mcgrof@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Isaku Yamahata <yamahata@valinux.co.jp>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The general documentation we have for pv_ops is currenty present
on the IA64 docs, but since this documentation covers IA64 xen
enablement and IA64 Xen support got ripped out a while ago
through commit d52eefb47 present since v3.14-rc1 lets just
simplify, generalize and move the pv_ops documentation to a
shared place.

Cc: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 Documentation/ia64/paravirt_ops.txt    | 137 ---------------------------------
 Documentation/virtual/00-INDEX         |   3 +
 Documentation/virtual/paravirt_ops.txt |  32 ++++++++
 MAINTAINERS                            |   2 +-
 4 files changed, 36 insertions(+), 138 deletions(-)
 delete mode 100644 Documentation/ia64/paravirt_ops.txt
 create mode 100644 Documentation/virtual/paravirt_ops.txt

diff --git a/Documentation/ia64/paravirt_ops.txt b/Documentation/ia64/paravirt_ops.txt
deleted file mode 100644
index 39ded02..0000000
--- a/Documentation/ia64/paravirt_ops.txt
+++ /dev/null
@@ -1,137 +0,0 @@
-Paravirt_ops on IA64
-====================
-                          21 May 2008, Isaku Yamahata <yamahata@valinux.co.jp>
-
-
-Introduction
-------------
-The aim of this documentation is to help with maintainability and/or to
-encourage people to use paravirt_ops/IA64.
-
-paravirt_ops (pv_ops in short) is a way for virtualization support of
-Linux kernel on x86. Several ways for virtualization support were
-proposed, paravirt_ops is the winner.
-On the other hand, now there are also several IA64 virtualization
-technologies like kvm/IA64, xen/IA64 and many other academic IA64
-hypervisors so that it is good to add generic virtualization
-infrastructure on Linux/IA64.
-
-
-What is paravirt_ops?
----------------------
-It has been developed on x86 as virtualization support via API, not ABI.
-It allows each hypervisor to override operations which are important for
-hypervisors at API level. And it allows a single kernel binary to run on
-all supported execution environments including native machine.
-Essentially paravirt_ops is a set of function pointers which represent
-operations corresponding to low level sensitive instructions and high
-level functionalities in various area. But one significant difference
-from usual function pointer table is that it allows optimization with
-binary patch. It is because some of these operations are very
-performance sensitive and indirect call overhead is not negligible.
-With binary patch, indirect C function call can be transformed into
-direct C function call or in-place execution to eliminate the overhead.
-
-Thus, operations of paravirt_ops are classified into three categories.
-- simple indirect call
-  These operations correspond to high level functionality so that the
-  overhead of indirect call isn't very important.
-
-- indirect call which allows optimization with binary patch
-  Usually these operations correspond to low level instructions. They
-  are called frequently and performance critical. So the overhead is
-  very important.
-
-- a set of macros for hand written assembly code
-  Hand written assembly codes (.S files) also need paravirtualization
-  because they include sensitive instructions or some of code paths in
-  them are very performance critical.
-
-
-The relation to the IA64 machine vector
----------------------------------------
-Linux/IA64 has the IA64 machine vector functionality which allows the
-kernel to switch implementations (e.g. initialization, ipi, dma api...)
-depending on executing platform.
-We can replace some implementations very easily defining a new machine
-vector. Thus another approach for virtualization support would be
-enhancing the machine vector functionality.
-But paravirt_ops approach was taken because
-- virtualization support needs wider support than machine vector does.
-  e.g. low level instruction paravirtualization. It must be
-       initialized very early before platform detection.
-
-- virtualization support needs more functionality like binary patch.
-  Probably the calling overhead might not be very large compared to the
-  emulation overhead of virtualization. However in the native case, the
-  overhead should be eliminated completely.
-  A single kernel binary should run on each environment including native,
-  and the overhead of paravirt_ops on native environment should be as
-  small as possible.
-
-- for full virtualization technology, e.g. KVM/IA64 or
-  Xen/IA64 HVM domain, the result would be
-  (the emulated platform machine vector. probably dig) + (pv_ops).
-  This means that the virtualization support layer should be under
-  the machine vector layer.
-
-Possibly it might be better to move some function pointers from
-paravirt_ops to machine vector. In fact, Xen domU case utilizes both
-pv_ops and machine vector.
-
-
-IA64 paravirt_ops
------------------
-In this section, the concrete paravirt_ops will be discussed.
-Because of the architecture difference between ia64 and x86, the
-resulting set of functions is very different from x86 pv_ops.
-
-- C function pointer tables
-They are not very performance critical so that simple C indirect
-function call is acceptable. The following structures are defined at
-this moment. For details see linux/include/asm-ia64/paravirt.h
-  - struct pv_info
-    This structure describes the execution environment.
-  - struct pv_init_ops
-    This structure describes the various initialization hooks.
-  - struct pv_iosapic_ops
-    This structure describes hooks to iosapic operations.
-  - struct pv_irq_ops
-    This structure describes hooks to irq related operations
-  - struct pv_time_op
-    This structure describes hooks to steal time accounting.
-
-- a set of indirect calls which need optimization
-Currently this class of functions correspond to a subset of IA64
-intrinsics. At this moment the optimization with binary patch isn't
-implemented yet.
-struct pv_cpu_op is defined. For details see
-linux/include/asm-ia64/paravirt_privop.h
-Mostly they correspond to ia64 intrinsics 1-to-1.
-Caveat: Now they are defined as C indirect function pointers, but in
-order to support binary patch optimization, they will be changed
-using GCC extended inline assembly code.
-
-- a set of macros for hand written assembly code (.S files)
-For maintenance purpose, the taken approach for .S files is single
-source code and compile multiple times with different macros definitions.
-Each pv_ops instance must define those macros to compile.
-The important thing here is that sensitive, but non-privileged
-instructions must be paravirtualized and that some privileged
-instructions also need paravirtualization for reasonable performance.
-Developers who modify .S files must be aware of that. At this moment
-an easy checker is implemented to detect paravirtualization breakage.
-But it doesn't cover all the cases.
-
-Sometimes this set of macros is called pv_cpu_asm_op. But there is no
-corresponding structure in the source code.
-Those macros mostly 1:1 correspond to a subset of privileged
-instructions. See linux/include/asm-ia64/native/inst.h.
-And some functions written in assembly also need to be overrided so
-that each pv_ops instance have to define some macros. Again see
-linux/include/asm-ia64/native/inst.h.
-
-
-Those structures must be initialized very early before start_kernel.
-Probably initialized in head.S using multi entry point or some other trick.
-For native case implementation see linux/arch/ia64/kernel/paravirt.c.
diff --git a/Documentation/virtual/00-INDEX b/Documentation/virtual/00-INDEX
index e952d30..af0d239 100644
--- a/Documentation/virtual/00-INDEX
+++ b/Documentation/virtual/00-INDEX
@@ -2,6 +2,9 @@ Virtualization support in the Linux kernel.
 
 00-INDEX
 	- this file.
+
+paravirt_ops.txt
+	- Describes the Linux kernel pv_ops to support different hypervisors
 kvm/
 	- Kernel Virtual Machine.  See also http://linux-kvm.org
 uml/
diff --git a/Documentation/virtual/paravirt_ops.txt b/Documentation/virtual/paravirt_ops.txt
new file mode 100644
index 0000000..d4881c0
--- /dev/null
+++ b/Documentation/virtual/paravirt_ops.txt
@@ -0,0 +1,32 @@
+Paravirt_ops
+============
+
+Linux provides support for different hypervisor virtualization technologies.
+Historically different binary kernels would be required in order to support
+different hypervisors, this restriction was removed with pv_ops.
+Linux pv_ops is a virtualization API which enables support for different
+hypervisors. It allows each hypervisor to override critical operations and
+allows a single kernel binary to run on all supported execution environments
+including native machine -- without any hypervisors.
+
+pv_ops provides a set of function pointers which represent operations
+corresponding to low level critical instructions and high level
+functionalities in various areas. pv-ops allows for optimizations at run
+time by enabling binary patching of the low-ops critical operations
+at boot time.
+
+pv_ops operations are classified into three categories:
+
+- simple indirect call
+  These operations correspond to high level functionality where it is
+  known that the overhead of indirect call isn't very important.
+
+- indirect call which allows optimization with binary patch
+  Usually these operations correspond to low level critical instructions. They
+  are called frequently and are performance critical. The overhead is
+  very important.
+
+- a set of macros for hand written assembly code
+  Hand written assembly codes (.S files) also need paravirtualization
+  because they include sensitive instructions or some of code paths in
+  them are very performance critical.
diff --git a/MAINTAINERS b/MAINTAINERS
index cee31c9..0df4446 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7267,7 +7267,7 @@ M:	Alok Kataria <akataria@vmware.com>
 M:	Rusty Russell <rusty@rustcorp.com.au>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
-F:	Documentation/ia64/paravirt_ops.txt
+F:	Documentation/virtual/paravirt_ops.txt
 F:	arch/*/kernel/paravirt*
 F:	arch/*/include/asm/paravirt.h
 
-- 
2.2.2
