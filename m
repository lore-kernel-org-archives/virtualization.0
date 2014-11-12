From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v4 4/6] hw_random: fix unregister race.
Date: Wed, 12 Nov 2014 12:47:25 +0800
Message-ID: <20141112044725.GA24812@gondor.apana.org.au>
References: <1415030186-18303-1-git-send-email-akong@redhat.com>
	<1415030186-18303-5-git-send-email-akong@redhat.com>
	<20141110134727.GA8578@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141110134727.GA8578@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 10, 2014 at 09:47:27PM +0800, Herbert Xu wrote:
> On Mon, Nov 03, 2014 at 11:56:24PM +0800, Amos Kong wrote:
> >
> > @@ -98,6 +99,8 @@ static inline void cleanup_rng(struct kref *kref)
> >  =

> >  	if (rng->cleanup)
> >  		rng->cleanup(rng);
> =

> You need a compiler barrier here to prevent reordering.

Michael B=FCsch pointed out that we should actually have a memory
barrier here.  I thought we didn't need it because I was only
worried about the code in my original complaint.  However, expecting
driver writers to use correct synchronisation primitives is surely
asking too much.

So let's add an smp_wmb() here to ensure all side-effects of
cleanup is visible.

Thanks,
-- =

Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
