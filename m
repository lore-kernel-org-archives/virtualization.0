From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Wrappers for vringh (was Re: [PATCHv2 vringh 1/3] remoteproc: Add
	support for vringh (Host vrings))
Date: Wed, 27 Feb 2013 13:01:26 +0100
Message-ID: <CAJK669Zdw+F8F8EUc__6rHscFdP4tCa8dDB+6LZ_abx2efyMHA@mail.gmail.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, virtualization <virtualization@lists.linux-foundation.org>, Ido Yariv <ido@wizery.com>, Erwan Yvin <erwan.yvin@stericsson.com>, Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 22, 2013 at 1:42 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Ohad Ben-Cohen <ohad@wizery.com> writes:
>> On Thu, Feb 21, 2013 at 8:37 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> What do you think about creating some virtio-level wrappers for the
>> vringh handlers?
>>
>> I don't think we're going to stop with caif as the only vringh user,
>> and it could be nice if we follow the virtio spirit of decoupling the
>> drivers from the low level implementation. It sure did prove itself
>> when the remoteproc use cases started showing up, and it's neat.
>
> The problem space is a bit different.  My immediate concern is getting
> vhost (and thus vhost_net/blk) to use vringh: I wanted to unify the
> in-userspace and in-kernelspace ring implementations.  We don't have
> that issue in virtqueue.c.
>
> vhost is (will be) the higher abstraction for in-userspace rings,
> perhaps we want an equivalent for in-kernelspace rings.  I'm happy to
> look at patches, but I don't immediately see what it would look like...

I'm not sure if the tight binding between vringh and remoteproc is
a big problem. I think the most obvious use-case for kernel vringh is
when they are instantiated from remoteproc.

But if we where to make wrappers, how about something like this?

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 29b9104..ca257d8 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -53,0 +54,8 @@
+ * @find_vrh: find the host vrings and instantiate them
+ *     vdev: the virtio_device
+ *     nhvrs: the number of host vrings to find
+ *     hvrs: on success, includes new host vrings
+ *     callbacks: array of driver callbacks, for each host vring
+ *             include a NULL entry for vqs that do not need a callback
+ *     Returns 0 on success or error status
+ * @del_vrh: free the host vrings found by find_vrh().
@@ -55,0 +64 @@ typedef void vq_callback_t(struct virtqueue *);
+typedef void vrh_callback_t(struct virtio_device *, struct vringh *);
@@ -72,0 +82,4 @@ struct virtio_config_ops {
+       int (*find_vrh) (struct virtio_device *, unsigned nhvrs,
+                        struct vringh *vrhs[],
+                        vrh_callback_t *callbacks[]);
+       int (*del_vrhs)(struct virtio_device *);
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 4c4c918..78aecc9 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -52,0 +53,3 @@ struct vringh {
+
+       /* The function to call when buffers are available */
+       void (*notify)(struct vringh *);


diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index d4f339c..e657277 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -433,0 +434,2 @@ static int cfv_probe(struct virtio_device *vdev)
+       struct vringh *vrhs;
+       vrh_callback_t *vrh_cbs = cfv_recv;
@@ -446,2 +448,2 @@ static int cfv_probe(struct virtio_device *vdev)
-       cfv->vr_rx = rproc_virtio_new_vringh(vdev, RX_RING_INDEX, cfv_recv);
-       if (!cfv->vr_rx)
+       err = vdev->config->find_vrh(vdev, 1, &cfv->vr_rx, &vrh_cbs);
+       if (err)
@@ -504 +506 @@ static int cfv_probe(struct virtio_device *vdev)
-       rproc_virtio_kick_vringh(vdev, RX_RING_INDEX);
+       cfv->vr_rx->notify(cfv->vr_rx);
@@ -522 +524 @@ static void cfv_remove(struct virtio_device *vdev)
-       rproc_virtio_del_vringh(vdev, RX_RING_INDEX);
+       vdev->config->del_vrhs(cfv->vdev);

Thanks,
Sjur
