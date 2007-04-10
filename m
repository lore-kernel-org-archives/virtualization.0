From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 9/10] Vmi timer update.patch
Date: Tue, 10 Apr 2007 15:28:44 -0700
Message-ID: <20070410222844.GN19575@sequoia.sous-sol.org>
References: <200704100006.l3A06RUR020644@zach-dev.vmware.com>
	<20070410023702.GJ10574@sequoia.sous-sol.org>
	<461BC373.10306@vmware.com>
	<20070410172429.GN10574@sequoia.sous-sol.org>
	<461C084C.9020009@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <461C084C.9020009@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Zachary Amsden (zach@vmware.com) wrote:
> Yes, but unfortunately that is a nop:
> =

>         /*
>          * Avoid unnecessary state transitions, as it confuses
>          * Geode / Cyrix based boxen.
>          */
>         case CLOCK_EVT_MODE_SHUTDOWN:
>                 if (evt->mode =3D=3D CLOCK_EVT_MODE_UNUSED)
>                         break;
>         case CLOCK_EVT_MODE_UNUSED:
>                 if (evt->mode =3D=3D CLOCK_EVT_MODE_SHUTDOWN)
>                         break;

This one should be fallthrough case during exchange (mode =3D=3D PERIODIC)

>         case CLOCK_EVT_MODE_ONESHOT:
>                 /* One shot setup */
>                 outb_p(0x38, PIT_MODE);
> =

> So switching from PIT to VMI does not disable PIT timer interrupts.  =

> Thus I have to keep this part of the patch.

Oh, I was looking at this (x86_64 work I have here):

	case CLOCK_EVT_MODE_SHUTDOWN:
	case CLOCK_EVT_MODE_UNUSED:
		outb_p(0x30, PIT_MODE);
		outb_p(0, PIT_CH0);	/* LSB */
		outb_p(0, PIT_CH0);	/* MSB */
		break;

That's mode 0, not mode 5, but I think the end result is the same.
