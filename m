From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with callbacks
Date: Tue, 14 Oct 2008 08:42:31 +0200
Message-ID: <200810140842.31806.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com> <200810130951.31733.borntraeger@de.ibm.com> <1223944714.8157.300.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755733AbYJNGnY@vger.kernel.org>
In-Reply-To: <1223944714.8157.300.camel@pasglop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Linux PPC devel <linuxppc-dev@ozlabs.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 14. Oktober 2008 schrieb Benjamin Herrenschmidt:
> 
> > Hmmm. 
> > Can you try if this patch fixes the lockdep trace?
> 
> Yup, the patch fixes it, I'll commit it via the powerpc.git tree if you
> don't have any objection.

Sure, go ahead.
