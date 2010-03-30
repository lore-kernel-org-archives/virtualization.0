From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 4/4] virtio: disable multiport console support.
Date: Tue, 30 Mar 2010 11:59:17 +0530
Message-ID: <20100330062917.GC28273@amit-x200.redhat.com>
References: <201003301549.43186.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201003301549.43186.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Mar 30 2010 [15:49:43], Rusty Russell wrote:
> Unfortunately there proved to be at least one bug which requires an
> ABI change, so we're best off not introducing multiport support until
> 2.6.35.
> 
> While I generally left the multiport code paths intact, I really wanted
> to remove the ABI defines from the header, which meant some quite deep cuts.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> To: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/virtio_console.c  |  274 -----------------------------------------
>  include/linux/virtio_console.h |   19 --
>  2 files changed, 4 insertions(+), 289 deletions(-)

Instead of this big patch that causes a lot of churn (and we'll have to
re-introduce most of this later anyway), how about this one? Less churn,
same effect (tested, works fine):


From 3d12454057e618d58a8bb203197cfaa351e8aee8 Mon Sep 17 00:00:00 2001
From: Amit Shah <amit.shah@redhat.com>
Date: Tue, 30 Mar 2010 11:42:59 +0530
Subject: [PATCH] virtio: console: Disable multiport support

The host and guest currently enumerate ports independently.  This can
lead to problems after several hot-plug/unplug operations and
migrations.  The fix is to let the management software instantiate ports
at fixed locations and the host lets the guest know which 'id' to add a
new port to.

Since this is an intrusive change, and we don't want to support the
current ABI, disable multiport support for now and re-enable it for the
next merge window with the other changes.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 44288ce..c51eb5e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1418,6 +1418,8 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	multiport = false;
 	portdev->config.nr_ports = 1;
 	portdev->config.max_nr_ports = 1;
+#if 0
+	/* Multiport will be enabled after some design fixes */
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
 		multiport = true;
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
@@ -1443,6 +1445,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 	/* Let the Host know we support multiple ports.*/
 	vdev->config->finalize_features(vdev);
+#endif
 
 	err = init_vqs(portdev);
 	if (err < 0) {
@@ -1525,7 +1528,6 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
-	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
 static struct virtio_driver virtio_console = {
-- 
1.6.2.5
