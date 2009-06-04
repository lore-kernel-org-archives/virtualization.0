From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Wed, 03 Jun 2009 21:00:54 -0700 (PDT)
Message-ID: <20090603.210054.18839960.davem__29748.7171054401$1244088087$gmane$org@davemloft.net>
References: <200906012157.29465.rusty@rustcorp.com.au>
	<4A26E4FD.5010405@gmail.com>
	<200906041324.59118.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906041324.59118.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: eric.dumazet@gmail.com, libertas-dev@lists.infradead.org, dcbw@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, rolandd@cisco.com, divy@chelsio.com, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 4 Jun 2009 13:24:57 +0930

> On Thu, 4 Jun 2009 06:32:53 am Eric Dumazet wrote:
>> Also, taking a reference on socket for each xmit packet in flight is very
>> expensive, since it slows down receiver in __udp4_lib_lookup(). Several
>> cpus are fighting for sk->refcnt cache line.
> 
> Now we have decent dynamic per-cpu, we can finally implement bigrefs.  More 
> obvious for device counts than sockets, but perhaps applicable here as well?

It might be very beneficial for longer lasting, active, connections, but
for high connection rates it's going to be a lose in my estimation.
