From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [patch 3/4] Locally disable the softlockup watchdog rather than
	touching it
Date: Wed, 28 Mar 2007 09:33:52 -0400
Message-ID: <460A6EC0.4020701@redhat.com>
References: <20070327214919.800272641@goop.org>
	<20070327215828.085422178@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070327215828.085422178@goop.org>
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
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, John Hawkes <hawkes@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>
List-Id: virtualization@lists.linuxfoundation.org



Jeremy Fitzhardinge wrote:
>
> I haven't really worked out how this should interact with the nmi
> watchdog; touch_nmi_watchdog() still ends up calling
> touch_softlockup_watchdog(), so there's still some redundancy here.
>
>   =


touch_nmi_watchdog is attempting to tickle _all_ CPUs softlockup watchdogs.

Currently, the code is incorrect -- it is calling =

touch_softlockup_watchdog which touches only the current CPU's =

softlockup watchdog.

I don't like the idea of having touch_softlockup_watchdog exported with =

your new code -- we still have two methods of effecting the softlockup =

watchdog and that's confusing and its going to cause serious problems =

down the road.  The nmi watchdog code seems fine with just touching the =

CPU's nmi watchdogs.

Is there a reason that you're pushing the enable/disable?  All the cases =

called out seem to be just fine with calls to either effect that CPU's =

softlockup watchdog or doing all CPU's softlockup watchdogs.  I'm not =

sure I see the benefit of complicating the softlockup watchdog code with =

this ...

I agree with the first patch of this set -- it makes sense.  But beyond =

that I'm not convinced the rest of the code is needed ... IMO.

P.
