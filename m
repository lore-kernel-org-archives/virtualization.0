From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 12:11:44 -0800
Message-ID: <45EF1C80.50900@goop.org>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	<20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>	<1173178774.24738.311.camel@localhost.localdomain>	<45EDD82F.90204@vmware.com>	<1173225182.24738.507.camel@localhost.localdomain>	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>	<1173228544.24738.514.camel@localhost.localdomain>	<45EE0D10.7070807@vmware.com>	<1173230305.24738.529.camel@localhost.localdomain>	<45EE1EA3.90803@vmware.com>	<1173256666.24738.576.camel@localhost.localdomain>	<45EEF966.6060902@goop.org>	<Line.LNX.4.64.0703071304080.1851@d.namei> <45EF0CF5.5090305@goop.org> <45EF175D.6030609@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992541AbXCGULs@vger.kernel.org>
In-Reply-To: <45EF175D.6030609@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Hecht <dhecht@vmware.com>
Cc: James Morris <jmorris@namei.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> Jeremy, I saw you sent out the Xen version earlier, thanks.  Here's
> ours for reference (please excuse any formating issues); it's also
> lean. We'll send out a proper patch later after some more testing:

So the interrupt side of the clockevent comes through the virtual apic? 
Where does evt->handle_event get called?

    J
