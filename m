From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 05/22] Staging: hv: Get rid of the forward declaration of
 blkvsc_init_rw()
Date: Wed, 20 Apr 2011 13:35:06 -0700
Message-ID: <20110420203506.GA15317@kroah.com>
References: <1302125655-10741-1-git-send-email-kys@microsoft.com>
 <1302125720-10808-1-git-send-email-kys@microsoft.com>
 <1302125720-10808-5-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1302125720-10808-5-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 06, 2011 at 02:35:03PM -0700, K. Y. Srinivasan wrote:
> Get rid of the forward declaration of blkvsc_init_rw() by moving the
> code around.

This patch fails to apply:

Applying: Staging: hv: Get rid of the forward declaration of blkvsc_init_rw()
error: patch failed: drivers/staging/hv/blkvsc_drv.c:1000
error: drivers/staging/hv/blkvsc_drv.c: patch does not apply
Patch failed at 0005 Staging: hv: Get rid of the forward declaration of blkvsc_init_rw()

So I'll stop at this patch in the series.

Care to redo all of the other patches you have sent me that I have not
applied today so that I can?

thanks,

greg k-h
