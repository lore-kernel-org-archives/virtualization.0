From: rusty@rustcorp.com.au
Subject: [patch 09/43] lguest: lguest.txt update
Date: Wed, 26 Sep 2007 16:36:27 +1000
Message-ID: <20070926063646.533383441@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lguest.txt-update.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

o Describe the new split configurations
o Highlight code documentation in drivers/lguest/README
o Point out necessity of having a getty on /dev/hvc0
o Remove gratuitous "m" in example
o Don't discuss I/O model here, stick to user documentation.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 Documentation/lguest/lguest.txt |   66 ++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 38 deletions(-)

===================================================================
--- a/Documentation/lguest/lguest.txt
+++ b/Documentation/lguest/lguest.txt
@@ -6,7 +6,7 @@ Linux developers and users to experiment
 Linux developers and users to experiment with virtualization with the
 minimum of complexity.  Nonetheless, it should have sufficient
 features to make it useful for specific tasks, and, of course, you are
-encouraged to fork and enhance it.
+encouraged to fork and enhance it (see drivers/lguest/README).
 
 Features:
 
@@ -23,19 +23,30 @@ Developer features:
 
 Running Lguest:
 
-- Lguest runs the same kernel as guest and host.  You can configure
-  them differently, but usually it's easiest not to.
+- The easiest way to run lguest is to use same kernel as guest and host.
+  You can configure them differently, but usually it's easiest not to.
 
   You will need to configure your kernel with the following options:
 
-  CONFIG_HIGHMEM64G=n ("High Memory Support" "64GB")[1]
-  CONFIG_TUN=y/m ("Universal TUN/TAP device driver support")
-  CONFIG_EXPERIMENTAL=y ("Prompt for development and/or incomplete code/drivers")
-  CONFIG_PARAVIRT=y ("Paravirtualization support (EXPERIMENTAL)")
-  CONFIG_LGUEST=y/m ("Linux hypervisor example code")
+  "General setup":
+     "Prompt for development and/or incomplete code/drivers" = Y
+        (CONFIG_EXPERIMENTAL=y)
 
-  and I recommend:
-  CONFIG_HZ=100 ("Timer frequency")[2]
+  "Processor type and features":
+     "Paravirtualized guest support" = Y
+        "Lguest guest support" = Y
+     "High Memory Support" = off/4GB
+     "Alignment value to which kernel should be aligned" = 0x100000
+        (CONFIG_PARAVIRT=y, CONFIG_LGUEST_GUEST=y, CONFIG_HIGHMEM64G=n and
+         CONFIG_PHYSICAL_ALIGN=0x100000)
+
+  "Device Drivers":
+     "Network device support"
+        "Universal TUN/TAP device driver support" = M/Y
+           (CONFIG_TUN=m)
+     "Virtualization"
+        "Linux hypervisor example code" = M/Y
+           (CONFIG_LGUEST=m)
 
 - A tool called "lguest" is available in this directory: type "make"
   to build it.  If you didn't build your kernel in-tree, use "make
@@ -51,14 +61,17 @@ Running Lguest:
 	  dd if=/dev/zero of=rootfile bs=1M count=2048
 	  qemu -cdrom image.iso -hda rootfile -net user -net nic -boot d
 
+  Make sure that you install a getty on /dev/hvc0 if you want to log in on the
+  console!
+
 - "modprobe lg" if you built it as a module.
 
 - Run an lguest as root:
 
-      Documentation/lguest/lguest 64m vmlinux --tunnet=192.168.19.1 --block=rootfile root=/dev/lgba
+      Documentation/lguest/lguest 64 vmlinux --tunnet=192.168.19.1 --block=rootfile root=/dev/lgba
 
    Explanation:
-    64m: the amount of memory to use.
+    64: the amount of memory to use, in MB.
 
     vmlinux: the kernel image found in the top of your build directory.  You
        can also use a standard bzImage.
@@ -99,31 +112,7 @@ Running Lguest:
   "--sharenet=<filename>": any two guests using the same file are on
   the same network.  This file is created if it does not exist.
 
-Lguest I/O model:
+There is a helpful mailing list at http://ozlabs.org/mailman/listinfo/lguest
 
-Lguest uses a simplified DMA model plus shared memory for I/O.  Guests
-can communicate with each other if they share underlying memory
-(usually by the lguest program mmaping the same file), but they can
-use any non-shared memory to communicate with the lguest process.
-
-Guests can register DMA buffers at any key (must be a valid physical
-address) using the LHCALL_BIND_DMA(key, dmabufs, num<<8|irq)
-hypercall.  "dmabufs" is the physical address of an array of "num"
-"struct lguest_dma": each contains a used_len, and an array of
-physical addresses and lengths.  When a transfer occurs, the
-"used_len" field of one of the buffers which has used_len 0 will be
-set to the length transferred and the irq will fire.
-
-Using an irq value of 0 unbinds the dma buffers.
-
-To send DMA, the LHCALL_SEND_DMA(key, dma_physaddr) hypercall is used,
-and the bytes used is written to the used_len field.  This can be 0 if
-noone else has bound a DMA buffer to that key or some other error.
-DMA buffers bound by the same guest are ignored.
-
-Cheers!
+Good luck!
 Rusty Russell rusty@rustcorp.com.au.
-
-[1] These are on various places on the TODO list, waiting for you to
-    get annoyed enough at the limitation to fix it.
-[2] Lguest is not yet tickless when idle.  See [1].

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
