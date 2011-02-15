From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH ]:Staging: hv: Allocate the vmbus irq dynamically
Date: Tue, 15 Feb 2011 17:28:32 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56233F97247@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <1297782937-24082-1-git-send-email-kys@microsoft.com>
	<20110215155954.GA32313@suse.de>
	<FB42D5CCD7B5934EB1827DB5ED9B850E07085DA1@TK5EX14MBXC104.redmond.corp.microsoft.com>
	<8AFC7968D54FB448A30D8F38F259C56233F9714A@TK5EX14MBXC114.redmond.corp.microsoft.com>
	<20110215172253.GB18437@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110215172253.GB18437@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg KH <gregkh@suse.de>
Cc: Hashir Abdi <habdi@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Mike Sterling <Mike.Sterling@microsoft.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Tuesday, February 15, 2011 9:23 AM
> > Before the end of the week I will submit two patches for this;
> >
> > 	Remove DPRINT and change it to printk
> 
> No, use dev_dbg() and friends instead of "raw" printk() calls.
> 

Will do, you caught me just as I was starting the conversion :)

> > 	Remove excessive printouts on startup of vmbus
> 
> That would be nice to see.  There should be almost nothing outputed by
> these drivers on "normal" operation.

Agreed.

Hank.
