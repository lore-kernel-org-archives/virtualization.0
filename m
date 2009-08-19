From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Tue, 18 Aug 2009 20:34:54 -0700 (PDT)
Message-ID: <20090818.203454.222985629.davem__25949.1959507161$1250652924$gmane$org@davemloft.net>
References: <20090705033408.GB7430@gondor.apana.org.au>
	<20090817.184712.180559154.davem@davemloft.net>
	<20090819031926.GA17367@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090819031926.GA17367@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: herbert@gondor.apana.org.au
Cc: patrick.ohly@intel.com, libertas-dev@lists.infradead.org, dcbw@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, rolandd@cisco.com, divy@chelsio.com, xemul@openvz.org
List-Id: virtualization@lists.linuxfoundation.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 19 Aug 2009 13:19:26 +1000

> I'm in the process of repeating the same experiment with cxgb3
> which hopefully should let me turn interrupts off on descriptors
> while still reporting completion status.

Ok, I look forward to seeing your work however it turns out.

Once I see what you've done, I'll give it a spin on niu.
