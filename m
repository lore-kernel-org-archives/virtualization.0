From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 31/32] xen: --- drivers/net/xen-netfront.c | 6 +++--- 1 file changed, 3 insertions(+), 3 deletions(-)
Date: Tue, 1 May 2007 23:45:53 -0700
Message-ID: <20070502064553.GA2819@sequoia.sous-sol.org>
References: <20070429172916.861677000@goop.org> <E1Hj8PR-0007wA-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992800AbXEBGrm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1Hj8PR-0007wA-00@gondolin.me.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, ak@suse.de, akpm@linux-foundation.org, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org
List-Id: virtualization@lists.linuxfoundation.org

* Herbert Xu (herbert@gondor.apana.org.au) wrote:
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > ===================================================================
> > --- a/drivers/net/xen-netfront.c
> > +++ b/drivers/net/xen-netfront.c
> > @@ -1213,10 +1213,10 @@ static int netif_poll(struct net_device 
> 
> Any reason why xen-netfront isn't just in a single patch? It makes
> it a bit hard to review having it scattered around like this.

It simply maps directly to the patch queue.  We do go back and fold
things in and that should probably be done again, I agree.

thanks,
-chris
