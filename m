From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch 14/33] xen: xen time implementation
Date: Wed, 06 Jun 2007 11:30:28 +0200
Message-ID: <46669AD4.76E4.0078.0@novell.com>
References: <46668EC6.76E4.0078.0@novell.com>
	<C28C34EB.101FE%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C28C34EB.101FE%keir@xensource.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>, Keir Fraser <keir@xensource.com>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

>>> Keir Fraser <keir@xensource.com> 06.06.07 10:54 >>>
>On 6/6/07 09:39, "Jan Beulich" <jbeulich@novell.com> wrote:
>
>> The issue is
>> that on that system, transition into ACPI mode takes over 600ms (SMM
>> execution, and hence no interrupts delivered during that time), and =
with
>> Xen using the PIT (PM timer support was added by Keir as a result of =
this,
>> but that doesn't cure the problem here, it just reduces the likelihood =
it'll
>> be encountered) platform time and local time got pretty much out of =
sync.
>
>If you have an ACPI PM timer in your system (and if you have SMM then =
your
>system is almost certainly modern enough to have one) then surely the
>problem is fixed for all practical purposes? The problem was overflow of =
a
>fixed-width platform counter. The PIT wraps every ~50ms, but the ACPI PM
>timer will wrap only every ~4s. It would be quite unreasonable for SMM to
>take the CPU away for multiple seconds, even as a one-time boot operation.=


No, I don't think the problem's gone with the PM timer - it is just much =
less
likely. Since you depend on the TSC (which must generally be assumed be
unsyncronized across CPUs) and on the error correction factor (which shows
non-zero values every few seconds), getting the interpolated times on two
CPUs out of sync is still possible, and given the way the time keeping =
code
works even being off by just a single nanosecond may be fatal.

Jan
