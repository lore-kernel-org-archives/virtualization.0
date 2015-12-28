From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH] virtio: make find_vqs() checkpatch.pl-friendly
Date: Mon, 28 Dec 2015 10:44:35 -0800
Message-ID: <20151228184435.GH16437__29957.6198253364$1451352389$gmane$org@tuxbot>
References: <1450342423-18150-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1450342423-18150-1-git-send-email-stefanha@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu 17 Dec 00:53 PST 2015, Stefan Hajnoczi wrote:

> checkpatch.pl wants arrays of strings declared as follows:
> 
>   static const char * const names[] = { "vq-1", "vq-2", "vq-3" };
> 
> Currently the find_vqs() function takes a const char *names[] argument
> so passing checkpatch.pl's const char * const names[] results in a
> compiler error due to losing the second const.
> 
> This patch adjusts the find_vqs() prototype and updates all virtio
> transports.  This makes it possible for virtio_balloon.c, virtio_input.c,
> virtgpu_kms.c, and virtio_rpmsg_bus.c to use the checkpatch.pl-friendly
> type.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn

> ---
> Compile-tested drivers/virtio/ but not the more exotic source files in this
> patch.
> 
>  drivers/gpu/drm/virtio/virtgpu_kms.c   | 2 +-
>  drivers/misc/mic/card/mic_virtio.c     | 2 +-
>  drivers/remoteproc/remoteproc_virtio.c | 2 +-
>  drivers/rpmsg/virtio_rpmsg_bus.c       | 2 +-
>  drivers/s390/virtio/kvm_virtio.c       | 2 +-
>  drivers/s390/virtio/virtio_ccw.c       | 2 +-
>  drivers/virtio/virtio_balloon.c        | 2 +-
>  drivers/virtio/virtio_input.c          | 2 +-
>  drivers/virtio/virtio_mmio.c           | 2 +-
>  drivers/virtio/virtio_pci_common.c     | 4 ++--
>  drivers/virtio/virtio_pci_common.h     | 2 +-
>  drivers/virtio/virtio_pci_modern.c     | 2 +-
>  include/linux/virtio_config.h          | 2 +-
>  13 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 06496a1..4150873 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -130,7 +130,7 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>  	static vq_callback_t *callbacks[] = {
>  		virtio_gpu_ctrl_ack, virtio_gpu_cursor_ack
>  	};
> -	static const char *names[] = { "control", "cursor" };
> +	static const char * const names[] = { "control", "cursor" };
>  
>  	struct virtio_gpu_device *vgdev;
>  	/* this will expand later */
> diff --git a/drivers/misc/mic/card/mic_virtio.c b/drivers/misc/mic/card/mic_virtio.c
> index e486a0c..f6ed57d 100644
> --- a/drivers/misc/mic/card/mic_virtio.c
> +++ b/drivers/misc/mic/card/mic_virtio.c
> @@ -311,7 +311,7 @@ unmap:
>  static int mic_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			struct virtqueue *vqs[],
>  			vq_callback_t *callbacks[],
> -			const char *names[])
> +			const char * const names[])
>  {
>  	struct mic_vdev *mvdev = to_micvdev(vdev);
>  	struct mic_device_ctrl __iomem *dc = mvdev->dc;
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index e1a1023..e44872f 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -147,7 +147,7 @@ static void rproc_virtio_del_vqs(struct virtio_device *vdev)
>  static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		       struct virtqueue *vqs[],
>  		       vq_callback_t *callbacks[],
> -		       const char *names[])
> +		       const char * const names[])
>  {
>  	struct rproc *rproc = vdev_to_rproc(vdev);
>  	int i, ret;
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 73354ee..1fcd27c 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -945,7 +945,7 @@ static void rpmsg_ns_cb(struct rpmsg_channel *rpdev, void *data, int len,
>  static int rpmsg_probe(struct virtio_device *vdev)
>  {
>  	vq_callback_t *vq_cbs[] = { rpmsg_recv_done, rpmsg_xmit_done };
> -	const char *names[] = { "input", "output" };
> +	static const char * const names[] = { "input", "output" };
>  	struct virtqueue *vqs[2];
>  	struct virtproc_info *vrp;
>  	void *bufs_va;
> diff --git a/drivers/s390/virtio/kvm_virtio.c b/drivers/s390/virtio/kvm_virtio.c
> index 53fb975..1d060fd 100644
> --- a/drivers/s390/virtio/kvm_virtio.c
> +++ b/drivers/s390/virtio/kvm_virtio.c
> @@ -255,7 +255,7 @@ static void kvm_del_vqs(struct virtio_device *vdev)
>  static int kvm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			struct virtqueue *vqs[],
>  			vq_callback_t *callbacks[],
> -			const char *names[])
> +			const char * const names[])
>  {
>  	struct kvm_device *kdev = to_kvmdev(vdev);
>  	int i;
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index b2a1a81..5a433ae 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -635,7 +635,7 @@ out:
>  static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			       struct virtqueue *vqs[],
>  			       vq_callback_t *callbacks[],
> -			       const char *names[])
> +			       const char * const names[])
>  {
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	unsigned long *indicatorp = NULL;
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7efc329..d0f0817c 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -388,7 +388,7 @@ static int init_vqs(struct virtio_balloon *vb)
>  {
>  	struct virtqueue *vqs[3];
>  	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
> -	const char *names[] = { "inflate", "deflate", "stats" };
> +	static const char * const names[] = { "inflate", "deflate", "stats" };
>  	int err, nvqs;
>  
>  	/*
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index c96944b..350a2a5 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -170,7 +170,7 @@ static int virtinput_init_vqs(struct virtio_input *vi)
>  	struct virtqueue *vqs[2];
>  	vq_callback_t *cbs[] = { virtinput_recv_events,
>  				 virtinput_recv_status };
> -	static const char *names[] = { "events", "status" };
> +	static const char * const names[] = { "events", "status" };
>  	int err;
>  
>  	err = vi->vdev->config->find_vqs(vi->vdev, 2, vqs, cbs, names);
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index f499d9d..745c6ee 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -482,7 +482,7 @@ error_available:
>  static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		       struct virtqueue *vqs[],
>  		       vq_callback_t *callbacks[],
> -		       const char *names[])
> +		       const char * const names[])
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>  	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 78f804a..36205c2 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -296,7 +296,7 @@ void vp_del_vqs(struct virtio_device *vdev)
>  static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			      struct virtqueue *vqs[],
>  			      vq_callback_t *callbacks[],
> -			      const char *names[],
> +			      const char * const names[],
>  			      bool use_msix,
>  			      bool per_vq_vectors)
>  {
> @@ -376,7 +376,7 @@ error_find:
>  int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		struct virtqueue *vqs[],
>  		vq_callback_t *callbacks[],
> -		const char *names[])
> +		const char * const names[])
>  {
>  	int err;
>  
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index b976d96..2cc2522 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -139,7 +139,7 @@ void vp_del_vqs(struct virtio_device *vdev);
>  int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		       struct virtqueue *vqs[],
>  		       vq_callback_t *callbacks[],
> -		       const char *names[]);
> +		       const char * const names[]);
>  const char *vp_bus_name(struct virtio_device *vdev);
>  
>  /* Setup the affinity for a virtqueue:
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 8e5cf19..c0c11fa 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -418,7 +418,7 @@ err_new_queue:
>  static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			      struct virtqueue *vqs[],
>  			      vq_callback_t *callbacks[],
> -			      const char *names[])
> +			      const char * const names[])
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtqueue *vq;
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index e5ce8ab..6e6cb0c 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -70,7 +70,7 @@ struct virtio_config_ops {
>  	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
>  			struct virtqueue *vqs[],
>  			vq_callback_t *callbacks[],
> -			const char *names[]);
> +			const char * const names[]);
>  	void (*del_vqs)(struct virtio_device *);
>  	u64 (*get_features)(struct virtio_device *vdev);
>  	int (*finalize_features)(struct virtio_device *vdev);
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
