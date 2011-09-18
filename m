From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] Staging: hv: util: Perform some service specific
 init/deinit in probe/remove
Date: Sun, 18 Sep 2011 10:53:13 -0700
Message-ID: <1316368394.4916.2.camel@Joe-Laptop>
References: <1316367053-700-1-git-send-email-kys@microsoft.com>
	 <1316367095-739-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316367095-739-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2011-09-18 at 10:31 -0700, K. Y. Srinivasan wrote:
> In preparation for modifying the util driver to fully conform to the
> Linux Driver Model,
[]
> diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
[]
>  static const struct hv_vmbus_device_id id_table[] = {
>  	/* Shutdown guid */
>  	{ VMBUS_DEVICE(0x31, 0x60, 0x0B, 0X0E, 0x13, 0x52, 0x34, 0x49,
> -		       0x81, 0x8B, 0x38, 0XD9, 0x0C, 0xED, 0x39, 0xDB) },
> +		       0x81, 0x8B, 0x38, 0XD9, 0x0C, 0xED, 0x39, 0xDB)
> +	  .driver_data = (unsigned long)&util_shutdown },

Isn't this a kernel_ulong_t ?

> +	  .driver_data = (unsigned long)&util_timesynch },

etc.
