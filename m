From: Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH 1/6] Documentation: crypto: document crypto engine API
Date: Wed, 10 Jan 2018 14:13:13 +0000
Message-ID: <849600f6-3082-c090-205d-75e3d14b38f9__24334.0424764485$1515593547$gmane$org@st.com>
References: <20180103201109.16077-1-clabbe.montjoie@gmail.com>
	<20180103201109.16077-2-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180103201109.16077-2-clabbe.montjoie@gmail.com>
Content-Language: en-US
Content-ID: <7F40C7A090D5EA46A917E9A48DE4386C@st.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Corentin Labbe <clabbe.montjoie@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "jasowang@redhat.com" <jasowang@redhat.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "mst@redhat.com" <mst@redhat.com>
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Corentin,


Thank you for this new version which I have testes successfully with the 
stm32 hash & cryp drivers.

As a general comment on this patchset, I would say that it does not 
cover all async requests: typically I need (for the pending stm32 cryp 
driver uprade) to use CryptoEngine to process AEAD requests which is not 
covered here.

Could you please consider adding the 'transfer' and 'finalize' EXPORTed 
functions for aead requests? (the implementation is quite trivial)

Have also a look at struct acomp_req (acompress.h) and struct 
kpp_request (kpp.h) which also use "struct crypto_async_request base"


BR

Fabien


On 03/01/18 21:11, Corentin Labbe wrote:
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>   Documentation/crypto/crypto_engine.rst | 46 ++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 Documentation/crypto/crypto_engine.rst
>
> diff --git a/Documentation/crypto/crypto_engine.rst b/Documentation/crypto/crypto_engine.rst
> new file mode 100644
> index 000000000000..b0ed37f9fb0c
> --- /dev/null
> +++ b/Documentation/crypto/crypto_engine.rst
> @@ -0,0 +1,46 @@
> +=============
> +CRYPTO ENGINE
> +=============
> +
> +Overview
> +--------
> +The crypto engine API (CE), is a crypto queue manager.
> +
> +Requirement
> +-----------
> +You have to put at start of your tfm_ctx the struct crypto_engine_reqctx
> +struct your_tfm_ctx {
> +        struct crypto_engine_reqctx enginectx;
> +        ...
> +};
> +Why: Since CE manage only crypto_async_request, it cannot know the underlying
> +request_type and so have access only on the TFM.
> +So using container_of for accessing __ctx is impossible.
> +Furthermore, the crypto engine cannot know the "struct your_tfm_ctx",
> +so it must assume that crypto_engine_reqctx is at start of it.
> +
> +Order of operations
> +-------------------
> +You have to obtain a struct crypto_engine via crypto_engine_alloc_init().
> +And start it via crypto_engine_start().
> +
> +Before transferring any request, you have to fill the enginectx.
> +- prepare_request: (taking a function pointer) If you need to do some processing before doing the request
> +- unprepare_request: (taking a function pointer) Undoing what's done in prepare_request
> +- do_one_request: (taking a function pointer) Do encryption for current request
> +
> +Note: that those three functions get the crypto_async_request associated with the received request.
> +So your need to get the original request via container_of(areq, struct yourrequesttype_request, base);
> +
> +When your driver receive a crypto_request, you have to transfer it to
> +the cryptoengine via one of:
> +- crypto_transfer_cipher_request_to_engine()
> +- crypto_transfer_skcipher_request_to_engine()
> +- crypto_transfer_akcipher_request_to_engine()
> +- crypto_transfer_hash_request_to_engine()
> +
> +At the end of the request process, a call to one of the following function is needed:
> +- crypto_finalize_cipher_request
> +- crypto_finalize_skcipher_request
> +- crypto_finalize_akcipher_request
> +- crypto_finalize_hash_request
