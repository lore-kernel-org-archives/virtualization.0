From: Nicolas Kaiser <nikai@nikai.net>
Subject: Re: [PATCH 1/5] staging: hv: fix some white spaces in netvsc driver
Date: Fri, 17 Jun 2011 18:03:24 +0200
Message-ID: <20110617180324.1eeb2ea0@absol.kitzblitz>
References: <1308322688-9796-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308322688-9796-1-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Haiyang Zhang <haiyangz@microsoft.com>:
> diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
> index 0ae35e7..b6e1fb9 100644
> --- a/drivers/staging/hv/netvsc.c
> +++ b/drivers/staging/hv/netvsc.c
> @@ -525,10 +525,10 @@ int netvsc_send(struct hv_device *device,
>  						  (unsigned long)packet);
>  	} else {
>  		ret = vmbus_sendpacket(device->channel, &sendMessage,
> -				       sizeof(struct nvsp_message),
> -				       (unsigned long)packet,
> -				       VM_PKT_DATA_INBAND,
> -				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +				sizeof(struct nvsp_message),
> +				(unsigned long)packet,
> +				VM_PKT_DATA_INBAND,
> +				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);

Why? The arguments were nicely aligned.

Best regards,
Nicolas Kaiser
