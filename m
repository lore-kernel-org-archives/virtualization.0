From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [RFC 11/12] rpmsg: increase buffer size and reduce buffer number
Date: Thu, 4 Jun 2020 13:58:39 -0600
Message-ID: <20200604195839.GA26734@xps15>
References: <20200529073722.8184-1-guennadi.liakhovetski@linux.intel.com>
 <20200529073722.8184-12-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200529073722.8184-12-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Guennadi,

On Fri, May 29, 2020 at 09:37:21AM +0200, Guennadi Liakhovetski wrote:
> It is hard to imagine use-cases where 512 buffers would really be
> needed, whereas 512 bytes per buffer might be too little. Change this
> to use 16 16KiB buffers instead.
> 
> Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> ---
>  include/linux/virtio_rpmsg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
> index 679be8b..1add468 100644
> --- a/include/linux/virtio_rpmsg.h
> +++ b/include/linux/virtio_rpmsg.h
> @@ -72,8 +72,8 @@ enum rpmsg_ns_flags {
>   * can change this without changing anything in the firmware of the remote
>   * processor.
>   */
> -#define MAX_RPMSG_NUM_BUFS	512
> -#define MAX_RPMSG_BUF_SIZE	512
> +#define MAX_RPMSG_NUM_BUFS	(512 / 32)
> +#define MAX_RPMSG_BUF_SIZE	(512 * 32)

These have been a standard in the rpmsg protocol since the inception of the
subsystem 9 years ago and can't be changed without serious impact to existing
implementations.

I suggest to dynamically set the number and size of the buffers to use
based on the value of virtio_device_id::device.  To do that please spin
off a new function, something like rpmsg_get_buffer_size(), and in there use
the device ID to fetch the numbers based on vdev->id->device.  That way the
rpmsg driver can be used by multiple clients and the specifics of the buffers
adjusted without impact to other users.

Thanks,
Mathieu

>  
>  /* Address 53 is reserved for advertising remote services */
>  #define RPMSG_NS_ADDR		53
> -- 
> 1.9.3
> 
