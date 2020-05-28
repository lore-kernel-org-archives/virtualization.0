From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v3 4/5] rpmsg: update documentation
Date: Thu, 28 May 2020 13:26:14 -0600
Message-ID: <CANLsYkxMiEABD+fhcCB7-r5bs4RSzY_qE09BVpaQ0C94BCWnfg@mail.gmail.com>
References: <20200527180541.5570-1-guennadi.liakhovetski@linux.intel.com> <20200527180541.5570-5-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200527180541.5570-5-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc <linux-remoteproc@vger.kernel.org>, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 27 May 2020 at 12:05, Guennadi Liakhovetski
<guennadi.liakhovetski@linux.intel.com> wrote:
>
> rpmsg_create_ept() takes struct rpmsg_channel_info chinfo as its last
> argument, not a u32 value. The first two arguments are also updated.
>
> Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> ---
>  Documentation/rpmsg.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/rpmsg.txt b/Documentation/rpmsg.txt
> index 24b7a9e..1ce353c 100644
> --- a/Documentation/rpmsg.txt
> +++ b/Documentation/rpmsg.txt
> @@ -192,9 +192,9 @@ Returns 0 on success and an appropriate error value on failure.
>
>  ::
>
> -  struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_channel *rpdev,
> -               void (*cb)(struct rpmsg_channel *, void *, int, void *, u32),
> -               void *priv, u32 addr);
> +  struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
> +                                         rpmsg_rx_cb_t cb, void *priv,
> +                                         struct rpmsg_channel_info chinfo);
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  every rpmsg address in the system is bound to an rx callback (so when
>  inbound messages arrive, they are dispatched by the rpmsg bus using the
> --
> 1.9.3
>
