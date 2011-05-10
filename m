From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 115/206] Staging: hv: Use completion abstraction in
 struct netvsc_device
Date: Tue, 10 May 2011 03:06:46 -0400
Message-ID: <20110510070646.GB13847@infradead.org>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-115-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1304978288-22999-115-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> -	net_device->wait_condition = 0;
>  	ret = vmbus_sendpacket(device->channel, init_packet,
>  			       sizeof(struct nvsp_message),
>  			       (unsigned long)init_packet,
> @@ -272,10 +272,8 @@ static int netvsc_init_recv_buf(struct hv_device *device)
>  		goto cleanup;
>  	}
>  
> -	wait_event_timeout(net_device->channel_init_wait,
> -			net_device->wait_condition,
> -			msecs_to_jiffies(1000));
> -	BUG_ON(net_device->wait_condition == 0);
> +	t = wait_for_completion_timeout(&net_device->channel_init_wait, HZ);
> +	BUG_ON(t == 0);

I don't think you want a BUG_ON here, but rather fail the
initialization.

Also I think you really should add synchronous versions of
vmbus_sendpacket*, to the vmbus core so that all the synchronous waiting
can be consolidated into a few helpers instead of needing to opencode
it everywhere.
