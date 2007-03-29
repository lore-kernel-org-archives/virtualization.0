From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [LGUEST] updated nohz/hrtimer WIP patches (v04)
Date: Thu, 29 Mar 2007 12:24:02 -0700
Message-ID: <460C1252.6040503@goop.org>
References: <Line.LNX.4.64.0703261148040.13138@d.namei>
	<Line.LNX.4.64.0703291151270.12641@d.namei>
	<460BED15.9040301@goop.org>
	<Line.LNX.4.64.0703291509470.14851@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Line.LNX.4.64.0703291509470.14851@d.namei>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Morris <jmorris@namei.org>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

James Morris wrote:
> Yep, it's as simple as possible now, and absolute time something to =

> investigate along with time synchronization between the host and the =

> guest (which we effectively avoid at this point).
>   =


There doesn't need to be any time synchronization; you just need a way
to get at the hypervisor's current clock.  You end up doing the
hypervisor_clock() + delta yourself anyway, but at least its under your
control.

> 'delta' is limited to 2^32 nanoseconds on 32-bit, which is not enough to =

> be useful (I really don't understand why the API is like this).  So, =

> instead, the 64-bit ktime_t delta is derived.

It means the max delta between timer interrupts is ~4 seconds, but
that's not too bad.  The clock infrastructure will sort out resetting
the timer to do longer delays.  It probably isn't terribly useful to do
longer delays than that, because you need to deal with drift between the
kernel's clocksource and the timer.

    J
