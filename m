From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 12/49] Staging: hv: storvsc: Add a DMI signature to
 support auto-loading
Date: Wed, 8 Jun 2011 02:44:35 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480813DFC1@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-1-git-send-email-kys@microsoft.com>
 <1307400613-13234-12-git-send-email-kys@microsoft.com>
 <20110606231259.GA18222@infradead.org>
 <6E21E5352C11B742B20C142EB499E0480813D84D@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <20110607185813.GA3531@kroah.com>
 <6E21E5352C11B742B20C142EB499E0480813DD09@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <20110607222444.GA26968@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110607222444.GA26968@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, June 07, 2011 6:25 PM
> To: KY Srinivasan
> Cc: Christoph Hellwig; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> Abhishek Kane (Mindtree Consulting PVT LTD)
> Subject: Re: [PATCH 12/49] Staging: hv: storvsc: Add a DMI signature to support
> auto-loading
> 
> On Tue, Jun 07, 2011 at 10:19:06PM +0000, KY Srinivasan wrote:
> > Thanks Greg. Can you give me some pointers here as to what needs to be
> > done here. Looking at the code for virtio, it looks like I would need to add stuff
> > to scripts/mod/file2alias.c as well as to include/linux/mod_devicetable.h. Will
> you
> > accept patches for these files to support an ID space for Hyper-V vmbus drivers.
> 
> Yes, I will take patches for those files to implement this.
> 
> Along with those files, you also need a way to tell userspace that new
> UIDS are found before the individual drivers are loaded.  Hopefully you
> can do that now, but if not, it will need to be implemented.

Could you elaborate on what user level changes I will have to do.

Thanks,

K. Y
