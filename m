From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Sat, 4 Jul 2009 17:09:10 +0800
Message-ID: <20090704090910.GA2185__4373.97327409617$1246698717$gmane$org@gondor.apana.org.au>
References: <20090703075530.GA25190@gondor.apana.org.au>
	<20090703.200254.172991821.davem@davemloft.net>
	<20090704030830.GA32442@gondor.apana.org.au>
	<20090703.201347.146036232.davem@davemloft.net>
	<20090704074245.GA1615@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090704074245.GA1615@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: patrick.ohly@intel.com, libertas-dev@lists.infradead.org, dcbw@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, rolandd@cisco.com, divy@chelsio.com, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 04, 2009 at 03:42:45PM +0800, Herbert Xu wrote:
> 
> Here's an idea: We let the sender decide whether we need to enable
> notification.  This decision would be carried as a flag in the skb.
> For example, UDP would set this flag when its socket buffer is close
> to capacity.  Routing would set this flag per NAPI run, etc.

Actually it doesn't even matter for routing because only those
that are charged by the skb's or the pages care and they're the
only ones that would need to set this.

One potential problem is if the socket is constantly running
close to capacity, but that should only happen if the device
TX queue is also close to capacity which means that the qdisc
queue should be non-empty.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
