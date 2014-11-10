From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v4 4/6] hw_random: fix unregister race.
Date: Mon, 10 Nov 2014 21:47:27 +0800
Message-ID: <20141110134727.GA8578@gondor.apana.org.au>
References: <1415030186-18303-1-git-send-email-akong@redhat.com>
	<1415030186-18303-5-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1415030186-18303-5-git-send-email-akong@redhat.com>
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
Cc: m@bues.ch, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mb@bu3sch.de, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 03, 2014 at 11:56:24PM +0800, Amos Kong wrote:
>
> @@ -98,6 +99,8 @@ static inline void cleanup_rng(struct kref *kref)
>  
>  	if (rng->cleanup)
>  		rng->cleanup(rng);

You need a compiler barrier here to prevent reordering.

> +	rng->cleanup_done = true;

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
