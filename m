From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [3/6] [TUN]: Fix GSO mapping
Date: Thu, 29 May 2008 20:38:30 +1000
Message-ID: <20080529103830.GA19601@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418031444.GA18041@gondor.apana.org.au>
	<20080418031554.GA18071@gondor.apana.org.au>
	<20080418031722.GB18071@gondor.apana.org.au>
	<1212057171.21998.2.camel@muff>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1212057171.21998.2.camel@muff>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 29, 2008 at 11:32:51AM +0100, Mark McLoughlin wrote:
> 
> Subject: [PATCH 1/1] tun: Do not use kmap_atomic() since memcpy_fromiovec() can sleep
> 
> Signed-off-by: Mark McLoughlin <markmc@redhat.com>

Good catch!

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
