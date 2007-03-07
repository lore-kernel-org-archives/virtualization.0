From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 19:56:49 +0100
Message-ID: <1173293809.24738.673.camel@localhost.localdomain>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>
	 <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>
	 <20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>
	 <1173178774.24738.311.camel@localhost.localdomain>
	 <45EDD82F.90204@vmware.com>
	 <1173225182.24738.507.camel@localhost.localdomain>
	 <45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>
	 <1173228544.24738.514.camel@localhost.localdomain>
	 <45EE0D10.7070807@vmware.com>
	 <1173230305.24738.529.camel@localhost.localdomain>
	 <45EE1EA3.90803@vmware.com>
	 <1173256666.24738.576.camel@localhost.localdomain>
	 <45EEF966.6060902@goop.org>  <Line.LNX.4.64.0703071304080.1851@d.namei>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965458AbXCGSum@vger.kernel.org>
In-Reply-To: <Line.LNX.4.64.0703071304080.1851@d.namei>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-03-07 at 13:11 -0500, James Morris wrote:
> On Wed, 7 Mar 2007, Jeremy Fitzhardinge wrote:
> 
> > I was very pleased when I saw the clocksource/event mechanisms go into
> > the kernel because it means different hypervisors can have a clock*
> > implementation to match their own particular time model/interface
> > without having to clutter up the pv_ops interface, and still have a
> > well-defined interface to the rest of the kernel's time infrastructure.
> 
> It seems to me that it could be useful to have a library of common virtual 
> time code (entirely separate from pv_ops), to avoid re-implementing some 
> apparently common requirements, such as: handling TSC frequency changes, 
> stolen time accounting, synthetic programmable clockevent etc.

Yes please. Expose sane emulated silicon to the kernel core and maintain
your hypervisor decisions behind that silicon instead of exposing us to
10 different silicon versions with 20 bugs each.

	tglx
