From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH ]:Staging: hv: Allocate the vmbus irq dynamically
Date: Tue, 15 Feb 2011 16:59:28 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56233F9714A@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <1297782937-24082-1-git-send-email-kys@microsoft.com>
 <20110215155954.GA32313@suse.de>
 <FB42D5CCD7B5934EB1827DB5ED9B850E07085DA1@TK5EX14MBXC104.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <FB42D5CCD7B5934EB1827DB5ED9B850E07085DA1@TK5EX14MBXC104.redmond.corp.microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>, Greg KH <gregkh@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Hashir Abdi <habdi@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: KY Srinivasan
> Sent: Tuesday, February 15, 2011 8:54 AM
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Tuesday, February 15, 2011 11:00 AM
> > To: KY Srinivasan
> > Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> > virtualization@lists.osdl.org; Haiyang Zhang; Hank Janssen
> > Subject: Re: [PATCH ]:Staging: hv: Allocate the vmbus irq dynamically
> >

> > And why are you still printing this out for the whole world to see?
> Greg, this patch addressed a specific comment with regards dynamically
> allocate the irq.
> Hank is working on a patch to address the various DPRINTS in the code.

Before the end of the week I will submit two patches for this;

	Remove DPRINT and change it to printk
	Remove excessive printouts on startup of vmbus

Hank.
