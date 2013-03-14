From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V2 WIP 0/2] vhost-scsi: new device supporting the
	tcm_vhost Linux kernel module
Date: Thu, 14 Mar 2013 17:25:42 +0800
Message-ID: <20130314092542.GB7892@hj.localdomain>
References: <1363069782-10735-1-git-send-email-asias@redhat.com>
	<20130314042514.GA28504@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130314042514.GA28504@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 14, 2013 at 12:25:14PM +0800, Asias He wrote:
> On Tue, Mar 12, 2013 at 02:29:40PM +0800, Asias He wrote:
> > This is on top of Paolo and Nick's work.
> > 
> > Current status:
> > Works now (guest boots fine, no hang any more) with seabios's virtio-scsi disabled.
> > Rebased to latest qemu.org/master
> > Change details are in commit log.
> > 
> > TODO:
> > Make seabios happy.
> 
> Some updates:
> 
> In seabios, src/virtio-scsi.c:virtio_scsi_cmd()
> 
>     vring_kick(ioaddr, vq, 1);
>     /* Wait for reply */
>     while (!vring_more_used(vq))  ------------>>> we hang here
>         usleep(5);
> 
> In tcm_vhost:
> we got: vhost_get_vq_desc: head: -14, out: 0 in: 81216
> 
> The vring buffer provided by seabios is not correct?

More updates:

Basically, seabios + tcm_vhost works now, with the attached qemu and
seabios patches.

We still have one more issue, vhost_verify_ring_mappings fails.

I am seeing this without the comment out hack.

   Unable to map ring buffer for ring 2
   qemu-system-x86_64: /root/src/qemu/hw/vhost.c:426: vhost_set_memory:
   Assertion `r >= 0' failed.


> > Paolo Bonzini (2):
> >   virtio-scsi: create VirtIOSCSICommon
> >   vhost-scsi: new device supporting the tcm_vhost Linux kernel module
> > 
> >  hw/Makefile.objs           |   5 +-
> >  hw/s390x/s390-virtio-bus.c |  35 +++++++
> >  hw/vhost-scsi.c            | 242 +++++++++++++++++++++++++++++++++++++++++++++
> >  hw/vhost-scsi.h            |  64 ++++++++++++
> >  hw/virtio-pci.c            |  59 +++++++++++
> >  hw/virtio-scsi.c           | 199 +++++++++----------------------------
> >  hw/virtio-scsi.h           | 129 ++++++++++++++++++++++++
> >  include/qemu/osdep.h       |   4 +
> >  8 files changed, 586 insertions(+), 151 deletions(-)
> >  create mode 100644 hw/vhost-scsi.c
> >  create mode 100644 hw/vhost-scsi.h
> > 
> > -- 
> > 1.8.1.4
> > 
> 
> -- 
> Asias

--------------- 8 ---------------> qemu patch:
diff --git a/hw/vhost.c b/hw/vhost.c
index 4d6aee3..0c52ec4 100644
--- a/hw/vhost.c
+++ b/hw/vhost.c
@@ -421,10 +421,12 @@ static void vhost_set_memory(MemoryListener *listener,
         return;
     }
 
+#if 0
     if (dev->started) {
         r = vhost_verify_ring_mappings(dev, start_addr, size);
         assert(r >= 0);
     }
+#endif
 
     if (!dev->log_enabled) {
         r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);

--------------- 8 ---------------> seabios patch:
diff --git a/src/virtio-scsi.c b/src/virtio-scsi.c
index 879ddfb..4de1255 100644
--- a/src/virtio-scsi.c
+++ b/src/virtio-scsi.c
@@ -147,6 +147,9 @@ init_virtio_scsi(struct pci_device *pci)
         goto fail;
     }
 
+    vp_set_status(ioaddr, VIRTIO_CONFIG_S_ACKNOWLEDGE |
+                  VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK);
+
     int i, tot;
     for (tot = 0, i = 0; i < 256; i++)
         tot += virtio_scsi_scan_target(pci, ioaddr, vq, i);
@@ -154,8 +157,6 @@ init_virtio_scsi(struct pci_device *pci)
     if (!tot)
         goto fail;
 
-    vp_set_status(ioaddr, VIRTIO_CONFIG_S_ACKNOWLEDGE |
-                  VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK);
     return;
 
 fail:
diff --git a/src/virtio-scsi.h b/src/virtio-scsi.h
index bbfbf30..96c3701 100644
--- a/src/virtio-scsi.h
+++ b/src/virtio-scsi.h
@@ -26,7 +26,7 @@ struct virtio_scsi_req_cmd {
     u8 prio;
     u8 crn;
     char cdb[VIRTIO_SCSI_CDB_SIZE];
-};
+} __attribute__((packed));
 
 /* This is the first element of the "in" scatter-gather list. */
 struct virtio_scsi_resp_cmd {
@@ -36,7 +36,7 @@ struct virtio_scsi_resp_cmd {
     u8 status;
     u8 response;
     u8 sense[VIRTIO_SCSI_SENSE_SIZE];
-};
+} __attribute__((packed));
 
 #define VIRTIO_SCSI_S_OK            0

-- 
Asias
