From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks
Date: Tue, 14 Oct 2008 19:18:51 +1100
Message-ID: <1223972331.8157.331.camel@pasglop>
References: <200806031444.21945.borntraeger@de.ibm.com>
	 <200810130951.31733.borntraeger@de.ibm.com>
	 <1223944714.8157.300.camel@pasglop>
	 <200810140842.31806.borntraeger@de.ibm.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756852AbYJNIWb@vger.kernel.org>
In-Reply-To: <200810140842.31806.borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2008-10-14 at 08:42 +0200, Christian Borntraeger wrote:
> Am Dienstag, 14. Oktober 2008 schrieb Benjamin Herrenschmidt:
> > 
> > > Hmmm. 
> > > Can you try if this patch fixes the lockdep trace?
> > 
> > Yup, the patch fixes it, I'll commit it via the powerpc.git tree if you
> > don't have any objection.
> 
> Sure, go ahead.

Allright, I have a batch about ready to go to Linus, so I'll add that
and ask him to pull tomorrow.

Thanks,
Ben.
