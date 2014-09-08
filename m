From: Amos Kong <akong@redhat.com>
Subject: Re: [PATCH] virtio-rng: complete have_data completion in removing
	device
Date: Mon, 8 Sep 2014 23:29:51 +0800
Message-ID: <20140908152951.GA28459@zen.redhat.com>
References: <1407260115-26767-1-git-send-email-akong@redhat.com>
	<20140806080541.GA3304@z.redhat.com>
	<20140806082529.GC25951@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140806082529.GC25951@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 06, 2014 at 01:55:29PM +0530, Amit Shah wrote:
> On (Wed) 06 Aug 2014 [16:05:41], Amos Kong wrote:
> > On Wed, Aug 06, 2014 at 01:35:15AM +0800, Amos Kong wrote:
> > > When we try to hot-remove a busy virtio-rng device from QEMU monitor,
> > > the device can't be hot-removed. Because virtio-rng driver hangs at
> > > wait_for_completion_killable().
> > > 
> > > This patch fixed the hang by completing have_data completion before
> > > unregistering a virtio-rng device.
> > 
> > Hi Amit,
> > 
> > Before applying this patch, it's blocking insider wait_for_completion_killable()                     
> > Applied this patch, wait_for_completion_killable() returns 0,
> > and vi->data_avail becomes 0, then rng_get_date() will return 0.
> 
> Thanks for checking this.
> 
> > Is it expected result?
> 
> I think what will happen is vi->data_avail will be set to whatever it
> was set last.  In case of a previous successful read request, the
> data_avail will be set to whatever number of bytes the host gave.  On
> doing a hot-unplug on the succeeding wait, the value in data_avail
> will be re-used, and the hwrng core will wrongly take some bytes in
> the buffer as input from the host.
> 
> So, I think we need to set vi->data_avail = 0; before calling
> wait_event_completion_killable().
> 
> 		Amit

In my latest debugging, I found the hang is caused by unexpected reading
when we started to remove the device.

I have two draft fix, 1) is skip unexpected reading by checking a
remove flag. 2) is unregistering device at the beginning of
remove_common(). I think second patch is better if it won't cause
new problem.

The original patch (complete in remove_common()) is still necessary.

Test results: hotplug issue disappeared (dd process will quit).


diff --git a/drivers/char/hw_random/virtio-rng.c
b/drivers/char/hw_random/virtio-rng.c
index 2e3139e..028797c 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -35,6 +35,7 @@ struct virtrng_info {
        unsigned int data_avail;
        int index;
        bool busy;
+        bool remove;
        bool hwrng_register_done;
 };
 
@@ -68,6 +69,9 @@ static int virtio_read(struct hwrng *rng, void *buf,
size_t size, bool wait)
        int ret;
        struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
 
+        if (vi->remove)
+               return 0;
+
        if (!vi->busy) {
                vi->busy = true;
                init_completion(&vi->have_data);
@@ -137,6 +141,8 @@ static void remove_common(struct virtio_device
*vdev)
 {
        struct virtrng_info *vi = vdev->priv;
 
+       vi->remove = true;
+       complete(&vi->have_data);
        vdev->config->reset(vdev);
        vi->busy = false;
        if (vi->hwrng_register_done)


diff --git a/drivers/char/hw_random/virtio-rng.c
b/drivers/char/hw_random/virtio-rng.c
index 2e3139e..9b8c2ce 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -137,10 +137,11 @@ static void remove_common(struct virtio_device
*vdev)
 {
        struct virtrng_info *vi = vdev->priv;
 
-       vdev->config->reset(vdev);
-       vi->busy = false;
        if (vi->hwrng_register_done)
                hwrng_unregister(&vi->hwrng);
+       complete(&vi->have_data);
+       vdev->config->reset(vdev);
+       vi->busy = false;
        vdev->config->del_vqs(vdev);
        ida_simple_remove(&rng_index_ida, vi->index);
        kfree(vi);
