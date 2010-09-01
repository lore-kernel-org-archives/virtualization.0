From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/5] staging: hv: Fixed lockup problem with
 bounce_buffer scatter list - RESEND
Date: Wed, 01 Sep 2010 09:38:11 -0700
Message-ID: <1283359091.1797.179.camel@Joe-Laptop>
References: <4C7D4667.5040102@sailtheuniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C7D4667.5040102@sailtheuniverse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@sailtheuniverse.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2010-08-31 at 11:13 -0700, Hank Janssen wrote:

> diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
[]
> -			request->DataBuffer.PfnArray[i] =
> -					page_to_pfn(sg_page((&sgl[i])));
> +			request->DataBuffer.PfnArray[i] = 
> +				page_to_pfn(sg_page((&sgl[i])));

I did a bit of a doubletake reading this last change.

This isn't actually a part of your fix and it introduces
a whitespace error.
