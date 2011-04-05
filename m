From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/22] Staging: hv: Cleanup-storage-drivers-phase-III
Date: Tue, 5 Apr 2011 13:58:37 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E04802BFE3@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1301331615-26226-1-git-send-email-kys@microsoft.com>
 <20110405045904.GA4635@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110405045904.GA4635@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Sorry for the confusion Greg. I reworked some patches in Phase-II cleanup and I was meaning to resend them before you began applying the patches, That is the reason for the problem you are encountering. I just resent the Phase II series. If you can back out the phase II that you have applied and apply the ones I resent, everything should apply cleanly. Once again, I sorry for creating additional work for you.

Regards,

K. Y

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, April 05, 2011 12:59 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 00/22] Staging: hv: Cleanup-storage-drivers-phase-III
> 
> On Mon, Mar 28, 2011 at 10:00:15AM -0700, K. Y. Srinivasan wrote:
> > This patch-set deals with some of the style isues in blkvsc_drv.c. We also
> > get rid most of the "dead code" in this file:
> >
> > 	1) Get rid of most of the forward declarations in this file.
> > 	   The only remaining forward declarations are to deal with
> > 	   circular dependencies.
> >
> > 	2) Get rid of most of the dead code in the file. Some of
> > 	   the functions in this file are place holders - they are not
> > 	   fuly implementedi yet (blkvsc_ioctl(), blkvsc_media_changed().
> > 	   We have retained some comments/dead code, to help us in the
> > 	   final implementation.
> 
> For some reason, this patch series fails to apply after the first one.
> So I've not applied any of them, care to resync and resend?
> 
> thanks,
> 
> greg k-h
