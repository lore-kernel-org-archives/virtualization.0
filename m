From: Amit Shah <amit.shah@redhat.com>
Subject: Re: When I boot two virtio-rng devices, guest will hang
Date: Mon, 28 Jul 2014 13:25:14 +0530
Message-ID: <20140728075514.GB3797@grmbl.mre>
References: <20140728073242.GD2683@z.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140728073242.GD2683@z.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, kvm@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On (Mon) 28 Jul 2014 [15:32:42], Amos Kong wrote:
> QEMU commandline:
> 
> ./x86_64-softmmu/qemu-system-x86_64 --enable-kvm   -m 2000 -drive file=/images/nolvm.qcow2 --kernel /home/devel/linux/arch/x86/boot/bzImage -append "ro root=/dev/sda1 console=ttyS0,115200"  -monitor unix:/tmp/m,nowait,server -device virtio-net-pci,netdev=h0,vectors=17,mq=on,id=n0 -netdev tap,id=h0,queues=8 -device virtio-net-pci,netdev=h1,vectors=0,mq=on,id=n1 -netdev tap,id=h1,queues=8  -vnc :0 -mon chardev=qmp,mode=control,pretty=on -chardev socket,id=qmp,host=localhost,port=1234,server,nowait -serial stdio -object rng-random,filename=/dev/urandom,id=rng0   -device virtio-rng-pci,rng=rng0,id=h0 -object rng-random,filename=/dev/urandom,id=rng1   -device virtio-rng-pci,rng=rng1,id=h1
> 
> It works when I only add one virtio-rng device. Did you touch this
> problem?
> 
> I'm using latest net-next/master (ac3d2e5a9ef2f4d8f57c50070c4883ecb7cec29f)

<snip>
> [    0.223503] Non-volatile memory driver v1.3
> [    1.172293] tsc: Refined TSC clocksource calibration: 2893.436 MHz
> qemu: terminating on signal 2           <---------- (I have to cancel QEMU process by Ctrl + C)

This looks similar to what I saw when driver asks for randomness from the host
before probe is completed.

Does the following patch help?

While the driver is setup (DRIVER_OK is set), the vqs aren't marked
usable before the probe for the other device finishes as well.  That's
not a scenario I considered.  We can try to put this patch in 3.16,
but it won't be applicable for 3.17, where this is handled the proper
way.  Also, 3.15 isn't affected, since that doesn't have multi-device
support.

Also attaching a patch that enables traces in qemu so it's easier to
see what's going on.


diff --git a/drivers/char/hw_random/virtio-rng.c
b/drivers/char/hw_random/virtio-rng.c
index e9b15bc..124cac5 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -34,12 +34,11 @@ struct virtrng_info {
        unsigned int data_avail;
        struct completion have_data;
        bool busy;
+       bool probe_done;
        char name[25];
        int index;
 };
 
-static bool probe_done;
-
 static void random_recv_done(struct virtqueue *vq)
 {
        struct virtrng_info *vi = vq->vdev->priv;
@@ -73,7 +72,7 @@ static int virtio_read(struct hwrng *rng, void *buf,
-size_t size, bool wait)
         * Don't ask host for data till we're setup.  This call can
         * happen during hwrng_register(), after commit d9e7972619.
         */
-       if (unlikely(!probe_done))
+       if (unlikely(!vi->probe_done))
                return 0;
 
        if (!vi->busy) {
@@ -146,7 +145,7 @@ static int probe_common(struct virtio_device
*vdev)
                return err;
        }
 
-       probe_done = true;
+       vi->probe_done = true;
        return 0;
 }
 

		Amit

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-virtio-rng-add-some-trace-events.patch"

From ec1aa555b67628beefa0ac6902baa2cc2e156f58 Mon Sep 17 00:00:00 2001
Message-Id: <ec1aa555b67628beefa0ac6902baa2cc2e156f58.1406533638.git.amit.shah@redhat.com>
From: Amit Shah <amit.shah@redhat.com>
Date: Mon, 21 Jul 2014 14:46:28 +0530
Subject: [PATCH 1/1] virtio-rng: add some trace events

Add some trace events to virtio-rng for easier debugging

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 hw/virtio/virtio-rng.c | 7 +++++++
 trace-events           | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 7c5a675..4a6472b 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -16,6 +16,7 @@
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
 #include "qom/object_interfaces.h"
+#include "trace.h"
 
 static bool is_guest_ready(VirtIORNG *vrng)
 {
@@ -24,6 +25,7 @@ static bool is_guest_ready(VirtIORNG *vrng)
         && (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         return true;
     }
+    trace_virtio_rng_guest_not_ready(vrng);
     return false;
 }
 
@@ -62,6 +64,7 @@ static void chr_read(void *opaque, const void *buf, size_t size)
         offset += len;
 
         virtqueue_push(vrng->vq, &elem, len);
+        trace_virtio_rng_pushed(vrng, len);
     }
     virtio_notify(vdev, vrng->vq);
 }
@@ -81,7 +84,11 @@ static void virtio_rng_process(VirtIORNG *vrng)
         quota = MIN((uint64_t)vrng->quota_remaining, (uint64_t)UINT32_MAX);
     }
     size = get_request_size(vrng->vq, quota);
+
+    trace_virtio_rng_request(vrng, size, quota);
+
     size = MIN(vrng->quota_remaining, size);
+
     if (size) {
         rng_backend_request_entropy(vrng->rng, size, chr_read, vrng);
     }
diff --git a/trace-events b/trace-events
index 11a17a8..99f39ac 100644
--- a/trace-events
+++ b/trace-events
@@ -41,6 +41,11 @@ virtio_irq(void *vq) "vq %p"
 virtio_notify(void *vdev, void *vq) "vdev %p vq %p"
 virtio_set_status(void *vdev, uint8_t val) "vdev %p val %u"
 
+# hw/virtio/virtio-rng.c
+virtio_rng_guest_not_ready(void *rng) "rng %p: guest not ready"
+virtio_rng_pushed(void *rng, size_t len) "rng %p: %zd bytes pushed"
+virtio_rng_request(void *rng, size_t size, unsigned quota) "rng %p: %zd bytes requested, %u bytes quota left"
+
 # hw/char/virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
 virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
-- 
1.9.3


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--opJtzjQTFsWo+cga--
