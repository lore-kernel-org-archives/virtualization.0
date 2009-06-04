From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Wed, 03 Jun 2009 21:56:21 -0700 (PDT)
Message-ID: <20090603.215621.136203134.davem__22610.493846196$1244091466$gmane$org@davemloft.net>
References: <200906041324.59118.rusty@rustcorp.com.au>
	<20090603.210054.18839960.davem@davemloft.net>
	<4A275380.1050601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A275380.1050601@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: eric.dumazet@gmail.com
Cc: libertas-dev@lists.infradead.org, dcbw@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, rolandd@cisco.com, divy@chelsio.com, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 04 Jun 2009 06:54:24 +0200

> We also can avoid the sock_put()/sock_hold() pair for each tx packet,
> to only touch sk_wmem_alloc (with appropriate atomic_sub_return() in sock_wfree()
> and atomic_dec_test in sk_free
> 
> We could initialize sk->sk_wmem_alloc to one instead of 0, so that
> sock_wfree() could just synchronize itself with sk_free()

Excellent idea Eric.

> Patch will follow after some testing

I look forward to it :-)
