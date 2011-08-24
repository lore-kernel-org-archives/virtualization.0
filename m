From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 019/117] Staging: hv: vmbus: Cleanup vmbus_uevent() code
Date: Wed, 24 Aug 2011 14:12:43 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B26EC@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-19-git-send-email-kys@microsoft.com>
 <20110823224932.GF9641@kroah.com>
 <6E21E5352C11B742B20C142EB499E048081B2356@TK5EX14MBXC126.redmond.corp.microsoft.com>
 <20110824030025.GD30779@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110824030025.GD30779@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, August 23, 2011 11:00 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 019/117] Staging: hv: vmbus: Cleanup vmbus_uevent() code
> 
> On Wed, Aug 24, 2011 at 12:38:09AM +0000, KY Srinivasan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:greg@kroah.com]
> > > Sent: Tuesday, August 23, 2011 6:50 PM
> > > To: KY Srinivasan
> > > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > > devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> > > Subject: Re: [PATCH 019/117] Staging: hv: vmbus: Cleanup vmbus_uevent()
> code
> > >
> > > On Fri, Jul 15, 2011 at 10:46:07AM -0700, K. Y. Srinivasan wrote:
> > > > Now generate appropriate uevent based on the modalias string. As part of
> this,
> > > > cleanup the existing uevent code.
> > >
> > > Note, you just change the user api here, did you have tools that relied
> > > on the old format?  If so, they just broke :(
> >
> > Prior to this, I don't think autoloading worked the way it should for these
> > modules.
> 
> It didn't?  How did the mouse driver get autoloaded then, through the
> pci/dmi tables?

You are right, prior to this all drivers were loaded using pci/dmi signatures.

Regards,

K. Y
