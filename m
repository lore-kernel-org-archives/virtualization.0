From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 09:54:51 +0100
Message-ID: <C28C34EB.101FE%keir__5247.58632896027$1181120132$gmane$org@xensource.com>
References: <46668EC6.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759919AbXFFIzK@vger.kernel.org>
In-Reply-To: <46668EC6.76E4.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 6/6/07 09:39, "Jan Beulich" <jbeulich@novell.com> wrote:

> The issue is
> that on that system, transition into ACPI mode takes over 600ms (SMM
> execution, and hence no interrupts delivered during that time), and with
> Xen using the PIT (PM timer support was added by Keir as a result of this,
> but that doesn't cure the problem here, it just reduces the likelihood it'll
> be encountered) platform time and local time got pretty much out of sync.

If you have an ACPI PM timer in your system (and if you have SMM then your
system is almost certainly modern enough to have one) then surely the
problem is fixed for all practical purposes? The problem was overflow of a
fixed-width platform counter. The PIT wraps every ~50ms, but the ACPI PM
timer will wrap only every ~4s. It would be quite unreasonable for SMM to
take the CPU away for multiple seconds, even as a one-time boot operation.

 -- Keir
