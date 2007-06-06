From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 10:56:34 +0100
Message-ID: <C28C4362.1021C%keir__29641.740959096$1181123884$gmane$org@xensource.com>
References: <46669AD4.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46669AD4.76E4.0078.0@novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <jbeulich@novell.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On 6/6/07 10:30, "Jan Beulich" <jbeulich@novell.com> wrote:

>> If you have an ACPI PM timer in your system (and if you have SMM then your
>> system is almost certainly modern enough to have one) then surely the
>> problem is fixed for all practical purposes? The problem was overflow of a
>> fixed-width platform counter. The PIT wraps every ~50ms, but the ACPI PM
>> timer will wrap only every ~4s. It would be quite unreasonable for SMM to
>> take the CPU away for multiple seconds, even as a one-time boot operation.
> 
> No, I don't think the problem's gone with the PM timer - it is just much less
> likely. Since you depend on the TSC (which must generally be assumed be
> unsyncronized across CPUs) and on the error correction factor (which shows
> non-zero values every few seconds), getting the interpolated times on two
> CPUs out of sync is still possible, and given the way the time keeping code
> works even being off by just a single nanosecond may be fatal.

If the error across CPUS is +/- just a few microseconds at worst then having
the clocksource clamp to no less than the last timestamp returned seems a
reasonable fix. Time won't 'stop' for longer than the cross-CPU error, and
that should always be a tiny value.

 -- Keir
