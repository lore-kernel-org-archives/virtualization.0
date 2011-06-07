From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 12/49] Staging: hv: storvsc: Add a DMI signature to
 support auto-loading
Date: Tue, 7 Jun 2011 22:19:06 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480813DD09@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-12-git-send-email-kys@microsoft.com>
 <20110606231259.GA18222@infradead.org>
 <6E21E5352C11B742B20C142EB499E0480813D84D@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <20110607185813.GA3531@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110607185813.GA3531@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, June 07, 2011 2:58 PM
> To: KY Srinivasan
> Cc: Christoph Hellwig; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> Abhishek Kane (Mindtree Consulting PVT LTD)
> Subject: Re: [PATCH 12/49] Staging: hv: storvsc: Add a DMI signature to support
> auto-loading
> 
> On Tue, Jun 07, 2011 at 02:54:25PM +0000, KY Srinivasan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Christoph Hellwig [mailto:hch@infradead.org]
> > > Sent: Monday, June 06, 2011 7:13 PM
> > > To: KY Srinivasan
> > > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > > devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> > > Abhishek Kane (Mindtree Consulting PVT LTD)
> > > Subject: Re: [PATCH 12/49] Staging: hv: storvsc: Add a DMI signature to
> support
> > > auto-loading
> > >
> > > On Mon, Jun 06, 2011 at 03:49:36PM -0700, K. Y. Srinivasan wrote:
> > > > To support auto-loading the storvsc driver, add a DMI signature.
> > >
> > > The storvsc driver is not a DMI driver, but a vmbus driver.  As such it
> > > should have a vmbus table that is used for autoloading, not a dmi one.
> > >
> >
> > A while ago, Greg introduced DMI signatures to these drivers to support
> > auto-loading. This signature is not used for anything else. For some reason,
> > this storvsc driver was missing this signature. I added it again to only support
> > auto-loading.
> 
> Yes, that was there to solve the original problem of autoloading the
> driver.
> 
> But Christoph is correct here, the vmbus needs a way to autoload its own
> drivers based on the GUID signatures of the devices it finds on the
> hyperv bus.  So the correct thing to do in the long-run is to implement
> this (which is one of the things the bus needs to do before it can move
> out of staging).
> 
> I'll take this patch as-is for now though, as it does solve the
> immediate issue.

Thanks Greg. Can you give me some pointers here as to what needs to be
done here. Looking at the code for virtio, it looks like I would need to add stuff
to scripts/mod/file2alias.c as well as to include/linux/mod_devicetable.h. Will you
accept patches for these files to support an ID space for Hyper-V vmbus drivers.

Regards,

K. Y
