From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Fri, 3 Jul 2009 15:55:30 +0800
Message-ID: <20090703075530.GA25190__12179.3050705039$1246607834$gmane$org@gondor.apana.org.au>
References: <20090602.171418.186096253.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090602.171418.186096253.davem@davemloft.net>
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

David Miller <davem@davemloft.net> wrote:
>
>> I think I'll do this in the driver for now, and let's revisit doing it 
>> generically later?
> 
> That might be the best course of action for the time being.
> This whole area is a rat's nest.

Calling skb_orphan like this should be forbidden.  Apart from the
problems already raised, it is a sign that the driver is trying to
paper over a more serious issue of not cleaning up skb's timely.

Yes skb_orphan will work for the cases where calling the skb
destructor allows forward progress, but for the cases where you
really need to the skb to be freed (e.g., iSCSI or Xen), this
simply doesn't work.

So anytime someone tries to propose such a solution it is a sign
that they have bigger problems.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
