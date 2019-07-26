From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v2 06/35] crypto: Use kmemdup rather than duplicating its
	implementation
Date: Fri, 26 Jul 2019 22:32:02 +1000
Message-ID: <20190726123202.GA8187__6520.95365091867$1564144351$gmane$org@gondor.apana.org.au>
References: <20190703162708.32137-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190703162708.32137-1-huangfq.daxian@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: aymen.sghaier@nxp.com, horia.geanta@nxp.com, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org, huangfq.daxian@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Fuqian Huang <huangfq.daxian@gmail.com> wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>  - Fix a typo in commit message (memset -> memcpy)
> 
> drivers/crypto/caam/caampkc.c              | 11 +++--------
> drivers/crypto/virtio/virtio_crypto_algs.c |  4 +---
> 2 files changed, 4 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
