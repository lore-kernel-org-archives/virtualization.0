From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v2 3/5] rpmsg: move common structures and defines to
 headers
Date: Mon, 25 May 2020 14:06:11 -0600
Message-ID: <20200525200611.GA9309@xps15>
References: <20200525144458.8413-1-guennadi.liakhovetski@linux.intel.com>
 <20200525144458.8413-4-guennadi.liakhovetski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200525144458.8413-4-guennadi.liakhovetski@linux.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: kvm@vger.kernel.org, linux-remoteproc@vger.kernel.org, virtualization@lists.linux-foundation.org, sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Guennadi,

On Mon, May 25, 2020 at 04:44:56PM +0200, Guennadi Liakhovetski wrote:
> virtio_rpmsg_bus.c keeps RPMsg protocol structure declarations and
> common defines like the ones, needed for name-space announcements,
> internal. Move them to common headers instead.
> 
> Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 78 +-------------------------------------
>  include/linux/virtio_rpmsg.h     | 81 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/rpmsg.h       |  3 ++
>  3 files changed, 86 insertions(+), 76 deletions(-)
>  create mode 100644 include/linux/virtio_rpmsg.h
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 07d4f33..f3bd050 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -25,7 +25,9 @@
>  #include <linux/virtio.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_config.h>
> +#include <linux/virtio_rpmsg.h>
>  #include <linux/wait.h>
> +#include <uapi/linux/rpmsg.h>
>  
>  #include "rpmsg_internal.h"
>  
> @@ -69,58 +71,6 @@ struct virtproc_info {
>  	struct rpmsg_endpoint *ns_ept;
>  };
>  
> -/* The feature bitmap for virtio rpmsg */
> -#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> -
> -/**
> - * struct rpmsg_hdr - common header for all rpmsg messages
> - * @src: source address
> - * @dst: destination address
> - * @reserved: reserved for future use
> - * @len: length of payload (in bytes)
> - * @flags: message flags
> - * @data: @len bytes of message payload data
> - *
> - * Every message sent(/received) on the rpmsg bus begins with this header.
> - */
> -struct rpmsg_hdr {
> -	u32 src;
> -	u32 dst;
> -	u32 reserved;
> -	u16 len;
> -	u16 flags;
> -	u8 data[];
> -} __packed;
> -
> -/**
> - * struct rpmsg_ns_msg - dynamic name service announcement message
> - * @name: name of remote service that is published
> - * @addr: address of remote service that is published
> - * @flags: indicates whether service is created or destroyed
> - *
> - * This message is sent across to publish a new service, or announce
> - * about its removal. When we receive these messages, an appropriate
> - * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
> - * or ->remove() handler of the appropriate rpmsg driver will be invoked
> - * (if/as-soon-as one is registered).
> - */
> -struct rpmsg_ns_msg {
> -	char name[RPMSG_NAME_SIZE];
> -	u32 addr;
> -	u32 flags;
> -} __packed;
> -
> -/**
> - * enum rpmsg_ns_flags - dynamic name service announcement flags
> - *
> - * @RPMSG_NS_CREATE: a new remote service was just created
> - * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> - */
> -enum rpmsg_ns_flags {
> -	RPMSG_NS_CREATE		= 0,
> -	RPMSG_NS_DESTROY	= 1,
> -};
> -
>  /**
>   * @vrp: the remote processor this channel belongs to
>   */
> @@ -134,36 +84,12 @@ struct virtio_rpmsg_channel {
>  	container_of(_rpdev, struct virtio_rpmsg_channel, rpdev)
>  
>  /*
> - * We're allocating buffers of 512 bytes each for communications. The
> - * number of buffers will be computed from the number of buffers supported
> - * by the vring, upto a maximum of 512 buffers (256 in each direction).
> - *
> - * Each buffer will have 16 bytes for the msg header and 496 bytes for
> - * the payload.
> - *
> - * This will utilize a maximum total space of 256KB for the buffers.
> - *
> - * We might also want to add support for user-provided buffers in time.
> - * This will allow bigger buffer size flexibility, and can also be used
> - * to achieve zero-copy messaging.
> - *
> - * Note that these numbers are purely a decision of this driver - we
> - * can change this without changing anything in the firmware of the remote
> - * processor.
> - */
> -#define MAX_RPMSG_NUM_BUFS	(512)
> -#define MAX_RPMSG_BUF_SIZE	(512)
> -
> -/*
>   * Local addresses are dynamically allocated on-demand.
>   * We do not dynamically assign addresses from the low 1024 range,
>   * in order to reserve that address range for predefined services.
>   */
>  #define RPMSG_RESERVED_ADDRESSES	(1024)
>  
> -/* Address 53 is reserved for advertising remote services */
> -#define RPMSG_NS_ADDR			(53)
> -
>  static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept);
>  static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
>  static int virtio_rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len,
> diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
> new file mode 100644
> index 00000000..bf2fd69
> --- /dev/null
> +++ b/include/linux/virtio_rpmsg.h
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef _LINUX_VIRTIO_RPMSG_H
> +#define _LINUX_VIRTIO_RPMSG_H
> +
> +#include <linux/mod_devicetable.h>
> +
> +/* Address 53 is reserved for advertising remote services */
> +#define RPMSG_NS_ADDR			(53)
> +
> +/*
> + * We're allocating buffers of 512 bytes each for communications. The
> + * number of buffers will be computed from the number of buffers supported
> + * by the vring, upto a maximum of 512 buffers (256 in each direction).
> + *
> + * Each buffer will have 16 bytes for the msg header and 496 bytes for
> + * the payload.
> + *
> + * This will utilize a maximum total space of 256KB for the buffers.
> + *
> + * We might also want to add support for user-provided buffers in time.
> + * This will allow bigger buffer size flexibility, and can also be used
> + * to achieve zero-copy messaging.
> + *
> + * Note that these numbers are purely a decision of this driver - we
> + * can change this without changing anything in the firmware of the remote
> + * processor.
> + */
> +#define MAX_RPMSG_NUM_BUFS	512
> +#define MAX_RPMSG_BUF_SIZE	512
> +
> +/**
> + * struct rpmsg_hdr - common header for all rpmsg messages
> + * @src: source address
> + * @dst: destination address
> + * @reserved: reserved for future use
> + * @len: length of payload (in bytes)
> + * @flags: message flags
> + * @data: @len bytes of message payload data
> + *
> + * Every message sent(/received) on the rpmsg bus begins with this header.
> + */
> +struct rpmsg_hdr {
> +	u32 src;
> +	u32 dst;
> +	u32 reserved;
> +	u16 len;
> +	u16 flags;
> +	u8 data[];
> +} __packed;
> +
> +/**
> + * struct rpmsg_ns_msg - dynamic name service announcement message
> + * @name: name of remote service that is published
> + * @addr: address of remote service that is published
> + * @flags: indicates whether service is created or destroyed
> + *
> + * This message is sent across to publish a new service, or announce
> + * about its removal. When we receive these messages, an appropriate
> + * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
> + * or ->remove() handler of the appropriate rpmsg driver will be invoked
> + * (if/as-soon-as one is registered).
> + */
> +struct rpmsg_ns_msg {
> +	char name[RPMSG_NAME_SIZE];
> +	u32 addr;
> +	u32 flags;
> +} __packed;
> +
> +/**
> + * enum rpmsg_ns_flags - dynamic name service announcement flags
> + *
> + * @RPMSG_NS_CREATE: a new remote service was just created
> + * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> + */
> +enum rpmsg_ns_flags {
> +	RPMSG_NS_CREATE		= 0,
> +	RPMSG_NS_DESTROY	= 1,
> +};
> +

I have started reviewing this set and comments will (likely) come over a few
days.

For this file, I would have appreciated seeing the structure and defines laid
out in the same order in this file as they were in virtio_rpmsg_bus.c.  That way
I don't have to check every item to make sure nothing has been missed.  Not a
big problem but something to consider for the next revivions.  

The good thing is that it did not break my complation so with above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +#endif
> diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> index e14c6da..d669c04 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -24,4 +24,7 @@ struct rpmsg_endpoint_info {
>  #define RPMSG_CREATE_EPT_IOCTL	_IOW(0xb5, 0x1, struct rpmsg_endpoint_info)
>  #define RPMSG_DESTROY_EPT_IOCTL	_IO(0xb5, 0x2)
>  
> +/* The feature bitmap for virtio rpmsg */
> +#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> +
>  #endif
> -- 
> 1.9.3
> 
