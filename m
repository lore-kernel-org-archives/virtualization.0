From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Thu, 4 Jun 2009 13:24:57 +0930
Message-ID: <200906041324.59118.rusty__9693.24465045265$1244087771$gmane$org@rustcorp.com.au>
References: <200905292344.56814.rusty@rustcorp.com.au>
	<200906012157.29465.rusty@rustcorp.com.au>
	<4A26E4FD.5010405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A26E4FD.5010405@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: libertas-dev@lists.infradead.org, Dan Williams <dcbw@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Roland Dreier <rolandd@cisco.com>, Divy Le Ray <divy@chelsio.com>, Pavel Emelianov <xemul@openvz.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 4 Jun 2009 06:32:53 am Eric Dumazet wrote:
> Rusty Russell a =E9crit :
> > On Sat, 30 May 2009 12:41:00 am Eric Dumazet wrote:
> >> For TCP, I agree your patch is a huge benefit, since its paced by remo=
te
> >> ACKS and window control
> >
> > I doubt that.  There'll be some cache friendliness, but I'm not sure
> > it'll be measurable, let alone "huge".
...
> We can see sock_wfree() being number 2 on the profile, because it touches
> three cache lines per socket and transmited packet in TX completion
> handler.

Interesting, I take it back: got some "after" stats as well?

> Also, taking a reference on socket for each xmit packet in flight is very
> expensive, since it slows down receiver in __udp4_lib_lookup(). Several
> cpus are fighting for sk->refcnt cache line.

Now we have decent dynamic per-cpu, we can finally implement bigrefs.  More =

obvious for device counts than sockets, but perhaps applicable here as well?

Rusty.
