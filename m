From: Greg KH <gregkh@suse.de>
Subject: Re: Hyper-V TODO file
Date: Tue, 4 Oct 2011 10:04:15 -0700
Message-ID: <20111004170415.GA1320@suse.de>
References: <1316708240-25048-1-git-send-email-kys@microsoft.com>
 <20110922170450.GA4490@suse.de>
 <6E21E5352C11B742B20C142EB499E048081E935D@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110922173618.GA5624@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 04, 2011 at 01:59:56PM +0000, KY Srinivasan wrote:
> Greg, sometime back you checked in the changes to the TODO file reflecting
> that there are no outstanding vmbus related issues. What is the process now
> for getting the vmbus (and util) drivers out of staging. Let me know if there is 
> something I can do to help this along.  As you know, we had posted the network 
> driver for public review a while ago (several months ago) and we have addressed 
> all the review comments we got. Any guidance on what we should do next would be
> greatly appreciated.

At this point in time, just ask me, and I will move the files.

So, to confirm, you want to have the following files moved to
drivers/hv/:
	drivers/staging/hv/Kconfig (part of this file)
	drivers/staging/hv/Makefile (part of this file)
	drivers/staging/hv/vmbus_drv.c
	drivers/staging/hv/hv.c
	drivers/staging/hv/connection.c
	drivers/staging/hv/channel.c
	drivers/staging/hv/channel_mgmt.c
	drivers/staging/hv/ring_buffer.c
	drivers/staging/hv/hv_util.c
	drivers/staging/hv/hv_kmp.c
	drivers/staging/hv/hv_kvp.h
	drivers/staging/hv/hyperv_vmbus.h

The following file moved to include/linux/:
	drivers/staging/hv/hyperv.h
(I think there is stuff in there that can go into hyperv_vmbus.h as it's
not needed in the "global" directory, but I can do that movement.)

The following file moved to tools/hv/:
	drivers/staging/hv/tools/*

And the following files modified to tie drivers/hv/ into the build service:
	drivers/Makefile
	drivers/Kconfig

Is all of that correct?

thanks,

greg k-h
