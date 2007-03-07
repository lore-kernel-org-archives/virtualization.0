From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Tue, 06 Mar 2007 21:10:37 -0800
Message-ID: <45EE494D.6090403@goop.org>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	 <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	 <20070306084647.GA16280@elte.hu>  <45ED2C82.3080008@vmware.com>	 <1173178774.24738.311.camel@localhost.localdomain>	 <45EDD82F.90204@vmware.com>	 <1173225182.24738.507.camel@localhost.localdomain>	 <45EE0628.1080108@goop.org>  <45EE08E8.2020008@vmware.com> <1173228544.24738.514.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964826AbXCGFKk@vger.kernel.org>
In-Reply-To: <1173228544.24738.514.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: Dan Hecht <dhecht@vmware.com>, Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, ak@suse.de, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner wrote:
> Ooops. I completely forgot, that you get the absolute expiry time
> already in ktime_t format (nanoseconds) when dev->set_next_event() is
> called.
>
> 	dev->next_event = expires;
>
> is done right before the call. 
>
> So it's already there for free.
>   

OK, but a trap for young players (ie, me): the absolute time is in ns
since kernel boot, but the hypervisor wants an absolute time in ns since
system boot.  Everything works reasonably well for the first guest
started early, so be sure to take a snapshot of hypervisor time early in
order to get the correction...

    J
