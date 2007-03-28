From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [patch 3/4] Locally disable the softlockup watchdog rather than
	touching it
Date: Wed, 28 Mar 2007 11:27:34 -0400
Message-ID: <460A8966.6090208@redhat.com>
References: <20070327214919.800272641@goop.org>
	<20070327215828.085422178@goop.org>
	<460A6EC0.4020701@redhat.com> <460A7F57.9020006@goop.org>
	<460A80E6.9040003@redhat.com> <460A8820.3060708@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <460A8820.3060708@goop.org>
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

>> You don't have to do them all -- you could do one with (as in my
>> previous patch -- which I'm not married to BTW ;) )
>>
>> touch_cpu_softlockup_watchdog()
>>
>> and all with
>>
>> touch_softlockup_watchdog()
>>     =

>
> Well, I think changing the meaning of touch_softlockup_watchdog() for
> all existing callers is wrong - even if you change most of them to refer
> to the cpu-local function.  =

Hmmm .... it was suggested to me that I should mimic what =

touch_nmi_watchdog() does.

> There are definitely specific occasions on
> which touching all CPUs is the right thing to do, but not in the general
> case.
>   =


Yep.  That's why I have both a single cpu touch and the whole shebang :)

> The only thing I really care about in my patches is ignoring stolen
> time.  It may be that fixing that is enough to fix the reported problems
> with spurious watchdog messages on tickless idle CPUs.
>
>   =


>     J
>   =
