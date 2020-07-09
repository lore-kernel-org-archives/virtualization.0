From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] crypto: virtio - constify features[] and id_table[]
Date: Thu, 9 Jul 2020 22:55:00 +1000
Message-ID: <20200709125500.GE31057@gondor.apana.org.au>
References: <20200701202936.44156-1-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-crypto-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200701202936.44156-1-rikard.falkeborn@gmail.com>
Sender: linux-crypto-owner@vger.kernel.org
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, arei.gonglei@huawei.com, davem@davemloft.net, virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 01, 2020 at 10:29:36PM +0200, Rikard Falkeborn wrote:
> features[] and id_table[] are not modified and can be made const to
> allow the compiler to put them in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>   11534    2056     160   13750    35b6 drivers/crypto/virtio/virtio_crypto_core.o
> 
> After:
>    text    data     bss     dec     hex filename
>   11630    1992     128   13750    35b6 drivers/crypto/virtio/virtio_crypto_core.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
