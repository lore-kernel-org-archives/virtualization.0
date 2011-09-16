From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 06/20] Staging: hv: util: Properly handle util services
 in the util driver
Date: Fri, 16 Sep 2011 20:03:11 +0200
Message-ID: <20110916180311.GB25531@kroah.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-6-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315936796-20662-6-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 13, 2011 at 10:59:42AM -0700, K. Y. Srinivasan wrote:
>  static int __init init_hyperv_utils(void)
>  {
> -	int ret;
>  	pr_info("Registering HyperV Utility Driver\n");

All of these "registering" and "unregistering" messages should be
removed, they do nothing but clutter up the logs and are pointless.  You
can find this information out any time you want by looking in sysfs
instead of trying to parse random strings out of the kernel log.

greg k-h
