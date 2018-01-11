From: Fabien DESSENNE <fabien.dessenne@st.com>
Subject: Re: [PATCH 6/6] crypto: stm32-cryp: convert to the new crypto engine
	API
Date: Thu, 11 Jan 2018 07:45:25 +0000
Message-ID: <2b382b5d-8dc5-b414-99d5-d42c1ed6a3cf__39621.9497932636$1515656716$gmane$org@st.com>
References: <20180103201109.16077-1-clabbe.montjoie@gmail.com>
	<20180103201109.16077-7-clabbe.montjoie@gmail.com>
	<ccffd847-3df7-d690-4102-5a10f6439f87@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ccffd847-3df7-d690-4102-5a10f6439f87@st.com>
Content-Language: en-US
Content-ID: <5758224F1ECE1448A16066F9657450AA@st.com>
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

(Adding my tested by)


On 10/01/18 15:25, Fabien DESSENNE wrote:
>
> On 03/01/18 21:11, Corentin Labbe wrote:
>> This patch convert the stm32-cryp driver to the new crypto engine API.
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Tested-by: Fabien Dessenne <fabien.dessenne@st.com>

>> ---
>>    drivers/crypto/stm32/stm32-cryp.c | 21 ++++++++++++++++-----
>>    1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
>> index cf1dddbeaa2c..99e0473ef247 100644
>> --- a/drivers/crypto/stm32/stm32-cryp.c
>> +++ b/drivers/crypto/stm32/stm32-cryp.c
>> @@ -91,6 +91,7 @@
>>    #define _walked_out             (cryp->out_walk.offset - cryp->out_sg->offset)
>>    
>>    struct stm32_cryp_ctx {
>> +	struct crypto_engine_reqctx enginectx;
>>    	struct stm32_cryp       *cryp;
>>    	int                     keylen;
>>    	u32                     key[AES_KEYSIZE_256 / sizeof(u32)];
>> @@ -494,10 +495,20 @@ static int stm32_cryp_cpu_start(struct stm32_cryp *cryp)
>>    	return 0;
>>    }
>>    
>> +static int stm32_cryp_cipher_one_req(struct crypto_engine *engine,
>> +				     void *areq);
> Merge these 2 lines in a single one
>
>> +static int stm32_cryp_prepare_cipher_req(struct crypto_engine *engine,
>> +					 void *areq);
>> +
>>    static int stm32_cryp_cra_init(struct crypto_tfm *tfm)
>>    {
>> +	struct stm32_cryp_ctx *ctx = crypto_tfm_ctx(tfm);
>> +
>>    	tfm->crt_ablkcipher.reqsize = sizeof(struct stm32_cryp_reqctx);
>>    
>> +	ctx->enginectx.op.do_one_request = stm32_cryp_cipher_one_req;
>> +	ctx->enginectx.op.prepare_request = stm32_cryp_prepare_cipher_req;
>> +	ctx->enginectx.op.unprepare_request = NULL;
>>    	return 0;
>>    }
>>    
>> @@ -695,14 +706,17 @@ static int stm32_cryp_prepare_req(struct crypto_engine *engine,
>>    }
>>    
>>    static int stm32_cryp_prepare_cipher_req(struct crypto_engine *engine,
>> -					 struct ablkcipher_request *req)
>> +					 void *areq)
>>    {
>> +	struct ablkcipher_request *req = container_of(areq, struct ablkcipher_request, base);
>   > 80 characters (CHECKPATCH)
>
>> +
>>    	return stm32_cryp_prepare_req(engine, req);
>>    }
>>    
>>    static int stm32_cryp_cipher_one_req(struct crypto_engine *engine,
>> -				     struct ablkcipher_request *req)
>> +				     void *areq)
> Merge these 2 lines in a single one
>
>>    {
>> +	struct ablkcipher_request *req = container_of(areq, struct ablkcipher_request, base);
>   > 80 characters (CHECKPATCH)
>
>>    	struct stm32_cryp_ctx *ctx = crypto_ablkcipher_ctx(
>>    			crypto_ablkcipher_reqtfm(req));
>>    	struct stm32_cryp *cryp = ctx->cryp;
>> @@ -1104,9 +1118,6 @@ static int stm32_cryp_probe(struct platform_device *pdev)
>>    		goto err_engine1;
>>    	}
>>    
>> -	cryp->engine->prepare_cipher_request = stm32_cryp_prepare_cipher_req;
>> -	cryp->engine->cipher_one_request = stm32_cryp_cipher_one_req;
>> -
>>    	ret = crypto_engine_start(cryp->engine);
>>    	if (ret) {
>>    		dev_err(dev, "Could not start crypto engine\n");
