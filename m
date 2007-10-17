From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: LFENCE instruction (was: [rfc][patch 3/3] x86: optimise
	barriers)
Date: Wed, 17 Oct 2007 13:51:17 +0800
Message-ID: <E1Ii1oL-0005I3-00__26708.2503218719$1192600516$gmane$org@gondolin.me.apana.org.au>
References: <20071016002229.GA5851@wotan.suse.de>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20071016002229.GA5851@wotan.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nick Piggin <npiggin@suse.de>
Cc: virtualization <virtualization@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, mikulas@artax.karlin.mff.cuni.cz, arjan@infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Nick Piggin <npiggin@suse.de> wrote:
>
> Also, for non-wb memory. I don't think the Intel document referenced
> says anything about this, but the AMD document says that loads can pass
> loads (page 8, rule b).
> 
> This is why our rmb() is still an lfence.

BTW, Xen (in particular, the code in drivers/xen) uses mb/rmb/wmb
instead of smp_mb/smp_rmb/smp_wmb when it accesses memory that's
shared with other Xen domains or the hypervisor.

The reason this is necessary is because even if a Xen domain is
UP the hypervisor might be SMP.

It would be nice if we can have these adopt the new SMP barriers
on x86 instead of the IO ones as they currently do.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
