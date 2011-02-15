From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH ]:Staging: hv: Allocate the vmbus irq dynamically
Date: Tue, 15 Feb 2011 19:09:34 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56233F97479@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <1297782937-24082-1-git-send-email-kys@microsoft.com>
 <20110215155954.GA32313@suse.de>
 <FB42D5CCD7B5934EB1827DB5ED9B850E07085DA1@TK5EX14MBXC104.redmond.corp.microsoft.com>
 <8AFC7968D54FB448A30D8F38F259C56233F9714A@TK5EX14MBXC114.redmond.corp.microsoft.com>
 <20110215172253.GB18437@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: KY Srinivasan <kys@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Hashir Abdi <habdi@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org


> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Tuesday, February 15, 2011 9:23 AM
> > > Before the end of the week I will submit two patches for this;
> > >
> > > 	Remove DPRINT and change it to printk
> >
> > No, use dev_dbg() and friends instead of "raw" printk() calls.
> >
> 
> Will do, you caught me just as I was starting the conversion :)

While cleaning this up there are a few places in vmbus and channel behavior
where it is not in a device context. Are printk's okay in that context?

The three drivers network/SCSI and Block of course will use dev_XX family.

Hank.
