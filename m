From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [patch 3/4] Locally disable the softlockup watchdog rather than
	touching it
Date: Wed, 28 Mar 2007 10:51:18 -0400
Message-ID: <460A80E6.9040003@redhat.com>
References: <20070327214919.800272641@goop.org>
	<20070327215828.085422178@goop.org>
	<460A6EC0.4020701@redhat.com> <460A7F57.9020006@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <460A7F57.9020006@goop.org>
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
> Prarit Bhargava wrote:
>   =

>> I don't like the idea of having touch_softlockup_watchdog exported
>> with your new code -- we still have two methods of effecting the
>> softlockup watchdog and that's confusing and its going to cause
>> serious problems down the road.
>>     =

>
> It's legacy.  There are a few places where it wasn't obvious to me how
> to replace the touch_softlockup_watchdog, so I left them for now.  But
> ideally I think they should all go away.
>
>   =

>> Is there a reason that you're pushing the enable/disable?  All the
>> cases called out seem to be just fine with calls to either effect that
>> CPU's softlockup watchdog or doing all CPU's softlockup watchdogs.
>>     =

>
> Doing all CPUs is meaningless to me.  How does that make sense?  It
>   =


You don't have to do them all -- you could do one with (as in my =

previous patch -- which I'm not married to BTW ;) )

touch_cpu_softlockup_watchdog()

and all with

touch_softlockup_watchdog()

> Zach has reported seeing spurious softlockup messages on idle machines
> running under a hypervisor.  And there was also the discussion about how
> to deal with a flash update system in which all CPUs are taken over by
> the bios for a long period of time, which was causing softlockup to
> trigger.  It seemed to me that these could all be dealt with in much the
> same way, and that disable/enable semantics for dealing with
> long-running timer holdoffs is more natural than trying to work out how
> to periodically touch the watchdog timer.
>
>   =

But wouldn't a call to touch_[cpu_]softlockup_watchdog at the end of the =

flash update fix the problem?  And ditto for all other areas of the =

kernel where we know we're holding off scheduling?

P.


>     J
>   =
