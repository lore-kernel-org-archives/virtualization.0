From: KY Srinivasan <kys@microsoft.com>
Subject: RE: Hyper-V TODO file
Date: Fri, 2 Sep 2011 14:09:54 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B5F87@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314829011-28922-1-git-send-email-kys@microsoft.com>
 <alpine.LNX.2.00.1108311907130.20924@linux>
 <20110901203113.GA15259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110901203113.GA15259@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, Peter Foley <pefoley2@verizon.net>
Cc: "gregkh@suse.de" <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Thursday, September 01, 2011 4:31 PM
> To: Peter Foley
> Cc: KY Srinivasan; gregkh@suse.de; Linux Kernel Mailing List;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: Hyper-V TODO file
> 
> On Wed, Aug 31, 2011 at 07:11:39PM -0400, Peter Foley wrote:
> > On Wed, 31 Aug 2011, K. Y. Srinivasan wrote:
> > > Greg, as I have been pestering you for some time now, we are very
> interested in
> > > exiting staging and we are willing to dedicate the necessary development
> > > resources to address whatever issues that may still be pending. So, your help
> > > in identifying what needs to be done will be greatly appreciated. To that end,
> > > I think it will be useful to update the TODO file to reflect the current state of
> > > the drivers. Let us know how we should proceed here.
> >
> > An issue I've come across in the hyper-v drivers is the forced modular
> > build. You might want to see if the "depends on m" is still needed.
> 
> Ah, good point, KY, can you try this out and see if that can be changed?
> If not, something is wrong and that needs to get fixed.

I will check it and let you know. If there are issues, I fill fix them

Regards,

K. Y
