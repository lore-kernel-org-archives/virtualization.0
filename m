From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 019/117] Staging: hv: vmbus: Cleanup vmbus_uevent() code
Date: Tue, 23 Aug 2011 15:49:32 -0700
Message-ID: <20110823224932.GF9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-19-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-19-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 15, 2011 at 10:46:07AM -0700, K. Y. Srinivasan wrote:
> Now generate appropriate uevent based on the modalias string. As part of this,
> cleanup the existing uevent code.

Note, you just change the user api here, did you have tools that relied
on the old format?  If so, they just broke :(

> +	for (i = 0; i < (sizeof(struct hv_vmbus_device_id) * 2); i += 2)
> +		sprintf(&alias_name[i], "%02x", dev->dev_type.b[i/2]);

Don't we have a type for printing out a uuid already?

And what's with the jumping by 2 yet dividing?  What am I missing here?

greg k-h
