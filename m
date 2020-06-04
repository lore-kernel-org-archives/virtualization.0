From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [RFC 12/12] rpmsg: add a device ID to also bind to the ADSP
 device
Date: Thu, 4 Jun 2020 14:01:56 -0600
Message-ID: <20200604200156.GB26734@xps15>
References: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
 <20200529073722.8184-13-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200529073722.8184-13-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 29, 2020 at 09:37:22AM +0200, Guennadi Liakhovetski wrote:
> The ADSP device uses the RPMsg API to connect vhost and VirtIO SOF
> Audio DSP drivers on KVM host and guest.
> 
> Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index f3bd050..ebe3f19 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -949,6 +949,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
>  
>  static struct virtio_device_id id_table[] = {
>  	{ VIRTIO_ID_RPMSG, VIRTIO_DEV_ANY_ID },
> +	{ VIRTIO_ID_ADSP, VIRTIO_DEV_ANY_ID },

I am fine with this patch but won't add an RB because of the (many) checkpatch
errors.  Based on the comment I made on the previous set seeing those was
unexpected.

Thanks,
Mathieu

>  	{ 0 },
>  };
>  
> -- 
> 1.9.3
> 
