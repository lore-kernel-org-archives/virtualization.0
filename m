From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 9/10] Vmi timer update.patch
Date: Tue, 10 Apr 2007 15:16:20 -0700
Message-ID: <461C0CB4.9000407@goop.org>
References: <200704100006.l3A06RUR020644@zach-dev.vmware.com>
	<20070410023702.GJ10574@sequoia.sous-sol.org>
	<461BC373.10306@vmware.com>
	<20070410172429.GN10574@sequoia.sous-sol.org>
	<461C084C.9020009@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Thomas Gleixner <tglx@linutronix.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
>        /*
>         * Avoid unnecessary state transitions, as it confuses
>         * Geode / Cyrix based boxen.
>         */
>        case CLOCK_EVT_MODE_SHUTDOWN:
>                if (evt->mode =3D=3D CLOCK_EVT_MODE_UNUSED)
>                        break;
>        case CLOCK_EVT_MODE_UNUSED:
>                if (evt->mode =3D=3D CLOCK_EVT_MODE_SHUTDOWN)
>                        break;
>        case CLOCK_EVT_MODE_ONESHOT:
>                /* One shot setup */
>                outb_p(0x38, PIT_MODE);
>
> So switching from PIT to VMI does not disable PIT timer interrupts. =

> Thus I have to keep this part of the patch.

Why not submit a patch to do what you need here?  (The Geode comment is
a bit worrying though.)

    J
