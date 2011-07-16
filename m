From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 088/117] Staging: hv: netvsc: Inline the code for
 free_net_device()
Date: Sat, 16 Jul 2011 13:33:42 +0300
Message-ID: <20110716103342.GJ18655@shale.localdomain>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-88-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-88-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 15, 2011 at 10:47:16AM -0700, K. Y. Srinivasan wrote:
> -static void free_net_device(struct netvsc_device *device)
> -{
> -	WARN_ON(atomic_read(&device->refcnt) != 0);
> -	device->dev->ext = NULL;

device->dev->ext points to device.  We set it NULL here to prevent
a use after free bug.  What prevents that in the new code?

> -	kfree(device);
> -}

regards,
dan carpenter
