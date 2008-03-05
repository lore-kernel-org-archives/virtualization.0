From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [Lguest] networking in lguest: strange error: lguest: Guest
	moved used index from 6 to 256
Date: Thu, 06 Mar 2008 01:30:49 +0200
Message-ID: <1204759849.4708.36.camel__46594.1260722049$1204760387$gmane$org@localhost.localdomain>
References: <1204560316.47cc21bc513ed@webmail.alinto.com>
	<200803052206.31266.rusty@rustcorp.com.au>
	<1204758239.4708.25.camel@localhost.localdomain>
	<47CF2871.4070302@us.ibm.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GX8nzkmESIKGfVphMk3E"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47CF2871.4070302@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Avi Kivity <avik@qumranet.com>, lguest@ozlabs.org, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


--=-GX8nzkmESIKGfVphMk3E
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, 2008-03-05 at 17:10 -0600, Anthony Liguori wrote:
> Dor Laor wrote:
> > Seems to work reliably with kvm, should do the same trick for lguest.
> > You can download it from
> > git://kvm.qumranet.com/home/dor/src/kvm-guest-drivers-linux
> >
> > Anthony, you can update your mercurial repository with our changes.
> >   
> 
> Hrm, I thought we were standardizing on 
> http://www.kernel.org/pub/scm/virt/kvm/kvm-guest-drivers-linux.git
> 

Better this way, attached 3 patches needed for compilation.

> I'll just kill my mercurial repository.
> Regards,
> 
> Anthony Liguori
> 
> > Cheers,
> > Dor
> >
> >
> >   
> >> Thanks for the report,
> >> Rusty.
> >> _______________________________________________
> >> Lguest mailing list
> >> Lguest@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/lguest
> >>     
> >
> >   
> 

--=-GX8nzkmESIKGfVphMk3E
Content-Disposition: attachment; filename=0001-Backward-compat-to-replace-napi-in-rx_schedule.patch
Content-Type: application/mbox; name=0001-Backward-compat-to-replace-napi-in-rx_schedule.patch
Content-Transfer-Encoding: 7bit

From 803214241ba3750fc945c271e4a422389b0d8fdb Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Mon, 3 Mar 2008 17:28:57 +0200
Subject: [PATCH 1/3] Backward compat to replace napi in *rx_schedule*

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 hack-module.awk |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/hack-module.awk b/hack-module.awk
index 580090b..bd63fb9 100644
--- a/hack-module.awk
+++ b/hack-module.awk
@@ -45,8 +45,8 @@
     print "		return 1;";
     print "	}";
     print "";
-    print "	no_work = vi->rvq->vq_ops->enable_cb(vi->rvq);";
     print "	netif_rx_complete(vi->dev);";
+    print "	no_work = vi->rvq->vq_ops->enable_cb(vi->rvq);";
     print "";
     print "	if (!no_work && netif_rx_reschedule(vi->dev, received)) {";
     print "		skb = NULL;";
@@ -62,6 +62,32 @@
     virtnet_poll = 1
 }
 
+/\tnetif_rx_schedule\(/ {
+    print "#ifdef COMPAT_napi";
+    print "	vi->rvq->vq_ops->enable_cb(vi->rvq);";
+    print "	if (netif_rx_schedule_prep(vi->dev)) {";
+    print "		vi->rvq->vq_ops->disable_cb(vi->rvq);";
+    print "		__netif_rx_schedule(vi->dev);";
+    print "	} else";
+    print "		vi->rvq->vq_ops->enable_cb(vi->rvq);";
+    print "#else";
+    need_endif = 1
+}
+
+/netif_rx_schedule_prep/ {
+    print "#ifdef COMPAT_napi";
+    print "\tif (netif_rx_schedule_prep(vi->dev)) {";
+    print "#else";
+    need_endif = 1
+}
+
+/__netif_rx_schedule/ {
+    print "#ifdef COMPAT_napi";
+    print "\t\t__netif_rx_schedule(vi->dev);";
+    print "#else";
+    need_endif = 1
+}
+
 /dev->stats/ {
     print "#ifndef COMPAT_net_stats";
     need_endif = 1
-- 
1.5.4.1


--=-GX8nzkmESIKGfVphMk3E
Content-Disposition: attachment; filename=0002-Move-COMPAT_csum_offset-to-kernels-.24-Also-add-e.patch
Content-Type: application/mbox; name=0002-Move-COMPAT_csum_offset-to-kernels-.24-Also-add-e.patch
Content-Transfer-Encoding: 7bit

From 22b2b6c7b480bc712f93e48816675d88162b8963 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Wed, 5 Mar 2008 16:40:29 +0200
Subject: [PATCH 2/3] Move COMPAT_csum_offset to kernels < .24 Also add #else for initializing the virtio_net_hdr

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 external-module-compat.h |    4 ++--
 hack-module.awk          |    5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/external-module-compat.h b/external-module-compat.h
index 75c4fd0..9c93464 100644
--- a/external-module-compat.h
+++ b/external-module-compat.h
@@ -63,6 +63,8 @@ do {							\
 } while(0)
 #define netif_rx_schedule(dev, napi) netif_rx_schedule(dev)
 
+#define COMPAT_csum_offset
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,23)
 
 #define scsi_cmd_ioctl(filp, rq, gendisk, cmd, data) \
@@ -85,8 +87,6 @@ do {							\
 #define list_first_entry(ptr, type, member) \
 	list_entry((ptr)->next, type, member)
 
-#define COMPAT_csum_offset
-
 static inline void * __must_check krealloc(const void *data, size_t size,
 					   gfp_t gfp)
 {
diff --git a/hack-module.awk b/hack-module.awk
index bd63fb9..41ba60d 100644
--- a/hack-module.awk
+++ b/hack-module.awk
@@ -106,7 +106,10 @@
 }
 
 /ip_summed == CHECKSUM_PARTIAL\)/ {
-    print "#ifndef COMPAT_csum_offset";
+    print "#ifdef COMPAT_csum_offset";
+    print "\thdr->flags = 0;"
+    print "\thdr->csum_offset = hdr->csum_start = 0;"
+    print "#else"
     need_endif_indent_brace = 1;
 }
 
-- 
1.5.4.1


--=-GX8nzkmESIKGfVphMk3E
Content-Disposition: attachment; filename*0=0003-Backport-skb_transport_header-as-a-BUG.-Since-kvm-h.patc; filename*1=h
Content-Type: application/mbox; name=0003-Backport-skb_transport_header-as-a-BUG.-Since-kvm-h.patch
Content-Transfer-Encoding: 7bit

From ef53854dcc94e8bb4257e3da344345e68bc92cef Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Wed, 5 Mar 2008 18:27:49 +0200
Subject: [PATCH 3/3] Backport skb_transport_header as a BUG.. Since kvm host side does not support GSO anyway the simplest/fastest thing is to backport the relative new skb_transport_header as BUG.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 external-module-compat.h |    1 +
 hack-module.awk          |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/external-module-compat.h b/external-module-compat.h
index 9c93464..ff2f4ca 100644
--- a/external-module-compat.h
+++ b/external-module-compat.h
@@ -79,6 +79,7 @@ do {							\
 #define COMPAT_INIT_WORK
 #define COMPAT_f_dentry
 #define COMPAT_net_stats
+#define COMPAT_transport_header
 
 #define __maybe_unused
 
diff --git a/hack-module.awk b/hack-module.awk
index 41ba60d..9e7ef0e 100644
--- a/hack-module.awk
+++ b/hack-module.awk
@@ -113,6 +113,13 @@
     need_endif_indent_brace = 1;
 }
 
+/skb_transport_header/ {
+    print "#ifdef COMPAT_transport_header";
+    print "BUG();";
+    print "#else";
+    need_endif = 1;
+}
+
 { sub(/\<pci_dev->revision\>/, "pci_dev_revision(pci_dev)") }
 
 { print }
-- 
1.5.4.1


--=-GX8nzkmESIKGfVphMk3E
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--=-GX8nzkmESIKGfVphMk3E--
