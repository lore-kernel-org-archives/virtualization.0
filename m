From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 1/4] vhost: convert VHOST_VSOCK_SET_RUNNING to a
 generic ioctl
Date: Thu, 23 Jul 2020 10:34:35 +0200
Message-ID: <20200723083435.3rjn5qiqhxcvxxwk@steredhat.lan>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
 <20200722150927.15587-2-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200722150927.15587-2-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 22, 2020 at 05:09:24PM +0200, Guennadi Liakhovetski wrote:
> VHOST_VSOCK_SET_RUNNING is used by the vhost vsock driver to perform
> crucial VirtQueue initialisation, like assigning .private fields and
> calling vhost_vq_init_access(), and clean up. However, this ioctl is
> actually extremely useful for any vhost driver, that doesn't have a
> side channel to inform it of a status change, e.g. upon a guest
> reboot. This patch makes that ioctl generic, while preserving its
> numeric value and also keeping the original alias.
> 
> Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> ---
>  include/uapi/linux/vhost.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 0c2349612e77..5d9254e2a6b6 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -95,6 +95,8 @@
>  #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
>  #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
>  
> +#define VHOST_SET_RUNNING _IOW(VHOST_VIRTIO, 0x61, int)
> +
>  /* VHOST_NET specific defines */
>  
>  /* Attach virtio net ring to a raw socket, or tap device.
> @@ -116,7 +118,7 @@
>  /* VHOST_VSOCK specific defines */
>  
>  #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
> -#define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
> +#define VHOST_VSOCK_SET_RUNNING		VHOST_SET_RUNNING
>  
>  /* VHOST_VDPA specific defines */
>  
> -- 
> 2.27.0
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
