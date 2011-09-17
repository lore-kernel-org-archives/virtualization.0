From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 06/20] Staging: hv: util: Properly handle util services
 in the util driver
Date: Sat, 17 Sep 2011 13:26:19 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081E774A@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-6-git-send-email-kys@microsoft.com>
 <20110916180311.GB25531@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110916180311.GB25531@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Friday, September 16, 2011 2:03 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 06/20] Staging: hv: util: Properly handle util services in the
> util driver
> 
> On Tue, Sep 13, 2011 at 10:59:42AM -0700, K. Y. Srinivasan wrote:
> >  static int __init init_hyperv_utils(void)
> >  {
> > -	int ret;
> >  	pr_info("Registering HyperV Utility Driver\n");
> 
> All of these "registering" and "unregistering" messages should be
> removed, they do nothing but clutter up the logs and are pointless.  You
> can find this information out any time you want by looking in sysfs
> instead of trying to parse random strings out of the kernel log.

I was just trying to preserve the messages that were being put out
In the existing code. I will get rid of these messages and send you updated
patches.

Regards,

K. Y
