From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH 1/3] hw_random: allow RNG devices to give early
	randomness after a delay
Date: Fri, 18 Jul 2014 14:57:37 +0530
Message-ID: <20140718092737.GD15020@grmbl.mre>
References: <cover.1405277045.git.amit.shah@redhat.com>
	<685be569a29015d3ee56cc3f782d81cae06d52b9.1405277045.git.amit.shah@redhat.com>
	<20140714123700.GP13108@titan.lakedaemon.net>
	<20140714124246.GA1520@grmbl.mre>
	<20140718085626.GA15020@grmbl.mre>
	<20140718091408.GA17266@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140718091408.GA17266@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>, Jason Cooper <jason@lakedaemon.net>, keescook@chromium.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 18 Jul 2014 [17:14:08], Herbert Xu wrote:
> On Fri, Jul 18, 2014 at 02:26:26PM +0530, Amit Shah wrote:
> >
> > > Sounds like a good idea to me.  Though, changes in core.c that
> > > increase the time in hwrng_register() or hwrng_init() may not get
> > > noticed by rng drivers and they may suddenly start failing for no
> > > apparent reason.  Seems like a far stretch, though.  Does anyone else
> > > have an opinion on this?
> > 
> > Herbert, do you have any preference?
> 
> So it's only virtio-rng that's a problem, right? How about if we
> abuse the scan hook in virtio and move the hwrng_register there?

Oops, I had completely missed the scan hook, and looks like it was
added for exactly the purpose we want here (so we won't even be
abusing it!)

Thanks!

I'll post the patches when the one to revert gets an upstream commit
id.

		Amit
