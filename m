From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 9/10] Vmi timer update.patch
Date: Tue, 10 Apr 2007 15:28:06 -0700
Message-ID: <461C0F76.1070308@vmware.com>
References: <200704100006.l3A06RUR020644@zach-dev.vmware.com>
	<20070410023702.GJ10574@sequoia.sous-sol.org>
	<461BC373.10306@vmware.com>
	<20070410172429.GN10574@sequoia.sous-sol.org>
	<461C084C.9020009@vmware.com> <461C0CB4.9000407@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <461C0CB4.9000407@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Thomas Gleixner <tglx@linutronix.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Why not submit a patch to do what you need here?  (The Geode comment is
> a bit worrying though.)
>   =


Why should VMI add workaround into PIT code?  PIT code wants to know =

nothing about VMI.  It understands PIT timers on hardware.  VMI, on the =

other hand, is special - it knows exactly what hardware platform it has =

and can manipulate hardware freely.  On a generic platform, surely touch =

PIT I/O ports would be quite ill behavior.  But side effects of that on =

a vastly restricted platform are predictable based on the hardware and =

kernel, and we would not add a workaround outside of VMI unless it was =

really necessary or generally useful.

Zach
