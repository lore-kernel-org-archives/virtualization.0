From: David Miller <davem@davemloft.net>
Subject: Re: [2/2] [NET] link_watch: Remove delay for up even when we're
 down
Date: Tue, 08 May 2007 18:36:46 -0700 (PDT)
Message-ID: <20070508.183646.130238577.davem@davemloft.net>
References: <463F95C3.60407@goop.org>
	<20070508121322.GA21647@gondor.apana.org.au>
	<20070508121609.GA24763@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20070508121609.GA24763@gondor.apana.org.au>
Sender: netdev-owner@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: jeremy@goop.org, hch@infradead.org, ak@suse.de, akpm@linux-foundation.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk, netdev@vger.kernel.org, jeff@garzik.org, shemminge@linux-foundation.org, rusty@rustcorp.com.au, Keir.Fraser@cl.cam.ac.uk
List-Id: virtualization@lists.linuxfoundation.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 8 May 2007 22:16:09 +1000

> [NET]: Remove link_watch delay for up even when we're down
> 
> Currently all link carrier events are delayed by up to a second
> before they're processed to prevent link storms.  This causes
> unnecessary packet loss during that interval.
> 
> In fact, we can achieve the same effect in preventing storms by
> only delaying down events and unnecssary up events.  The latter
> is defined as up events when we're already up.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Also applied, thanks Herbert.
