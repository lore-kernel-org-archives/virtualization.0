From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2 4/5] rpmsg: update documentation
Date: Mon, 25 May 2020 14:10:35 -0600
Message-ID: <20200525201035.GB9309@xps15>
References: <20200525144458.8413-1-guennadi.liakhovetski@linux.intel.com>
 <20200525144458.8413-5-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200525144458.8413-5-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 25, 2020 at 04:44:57PM +0200, Guennadi Liakhovetski wrote:
> rpmsg_create_ept() takes struct rpmsg_channel_info chinfo as its last
> argument, not a u32 value.
> 
> Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> ---
>  Documentation/rpmsg.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/rpmsg.txt b/Documentation/rpmsg.txt
> index 24b7a9e..4f9bc4f 100644
> --- a/Documentation/rpmsg.txt
> +++ b/Documentation/rpmsg.txt
> @@ -194,7 +194,7 @@ Returns 0 on success and an appropriate error value on failure.
>  
>    struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_channel *rpdev,
>  		void (*cb)(struct rpmsg_channel *, void *, int, void *, u32),
> -		void *priv, u32 addr);
> +		void *priv, struct rpmsg_channel_info chinfo);

The second argument, i.e *cb is also wrong.  The first argument to the function
pointer is a struct rpmsg_device rather than a rpmsg_channel.  Please fix that
while at it by simply using "rpmsg_rx_cb_t cb", the same way it is in
linux/rpmsg.h.

Thanks,
Mathieu

>  
>  every rpmsg address in the system is bound to an rx callback (so when
>  inbound messages arrive, they are dispatched by the rpmsg bus using the
> -- 
> 1.9.3
> 
