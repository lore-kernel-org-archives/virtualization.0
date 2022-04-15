Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C303DC433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 10:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64E58610D1;
	Fri, 15 Apr 2022 10:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NsHpXxsEeTbL; Fri, 15 Apr 2022 10:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D044A61056;
	Fri, 15 Apr 2022 10:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EBEFC002F;
	Fri, 15 Apr 2022 10:53:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46BC2C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 10:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23BE2419C4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 10:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A972OBPU2ejw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 10:53:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D76A1419BA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 10:53:55 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id s137so7034323pgs.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=v25j9pVEhbMktYwFx92BN9tsBGsH4edaYFgugzwOmUg=;
 b=JF6Lff8ej65NV8siYjJEr1UptUhgsK9nkctiMIF6kYuiLMwCctA6LfpEnOUDjMP1k/
 jtsvMSfv+ZNGSJobTkvFny2Yq3SrjOr1ML2JcKGhWcsIWaKTVS+7Arv6eQGw/St1Akz2
 Qk9QtAg2a1vmCriFGXLP0AcXB2zSNXdJmllBpt5NTWbpKP6mfwxrX+yoy0evrF82WMAd
 jmaYnZMAUO3zH/ulivIy3e4QZQpEoR/wtq0oWM2HtZVTjDiLlnQ0Es0z+I+1/BWd90/k
 WVJFKPidBKmubDP6Yl0gjAg+cTe1lFZW89P6Ql4+bjxpAUakgfP3ZIJ8jCVSEtOXQikg
 RIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=v25j9pVEhbMktYwFx92BN9tsBGsH4edaYFgugzwOmUg=;
 b=hKuFoo8Zo3a5FhCw8ngEQYM+xn+II3hovn55f9H5UvjDwpqNPswcEOCzAr2xDpTnZq
 2gkmtJ3wl6lLcQL8ruBqEJcNjM/bX01ciDZR/X7MuQkVSX3IqTp670y63UxCCJuwVd0S
 SRSQAXExxJ4RNfLahpqFoTIh2F+IT6F05gV8aKlqfDcvJ+2gZ8W3hdFVBgGCJOBwZIiL
 4zLizC+HQwPsBQm3EpwPI4vly2oUpBTE92g3Hy8YVvaXjPfIOyPolCuLXGOoFtb4+Twe
 +fbSCoswwrr9sVTwWgX2ZUYW5FNlYhWx98XYcVwybQgzwTzN0Z3aC2EdLfPX0L2TpR25
 2NPQ==
X-Gm-Message-State: AOAM531gS0eIMfIDa/+LG6dP/h6qbaiuzbAYtxViOz1ZA+T/zhR130uW
 QFyPCJ5zCkRC7nHSZAGbHnkGoA==
X-Google-Smtp-Source: ABdhPJxWIf7LR4JpBEFnUEq+V6Xq/jXOi/zsLN03YsTXVQIlDSn8WU1ApikzlPvI8wLmMMMs86txcQ==
X-Received: by 2002:a65:5b84:0:b0:398:fd62:6497 with SMTP id
 i4-20020a655b84000000b00398fd626497mr5861213pgr.179.1650020034979; 
 Fri, 15 Apr 2022 03:53:54 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 mq6-20020a17090b380600b001c6357f146csm9572238pjb.12.2022.04.15.03.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Apr 2022 03:53:54 -0700 (PDT)
Message-ID: <eba72a32-aa94-0d9c-b927-a9e6b965ca44@bytedance.com>
Date: Fri, 15 Apr 2022 18:50:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Re: [PATCH 1/4] virtio-crypto: wait ctrl queue instead of busy
 polling
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220415064136.304661-1-pizhenwei@bytedance.com>
 <20220415064136.304661-2-pizhenwei@bytedance.com>
 <20220415042555-mutt-send-email-mst@kernel.org>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220415042555-mutt-send-email-mst@kernel.org>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 davem@davemloft.net, helei.sig11@bytedance.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 4/15/22 16:41, Michael S. Tsirkin wrote:
>> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> index f3ec9420215e..bf7c1aa4be37 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> @@ -102,107 +102,100 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>>   {
>>   	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
>>   	struct virtio_crypto *vcrypto = ctx->vcrypto;
>> +	struct virtio_crypto_ctrl_request *vc_ctrl_req = NULL;
> 
> this is initialized down the road, I think you can skip = NULL here.
> 
OK.
>>   	uint8_t *pkey;
>> -	unsigned int inlen;
>> -	int err;
>> +	int err = -ENOMEM;
> 
> I would assign this in the single case where this value is used.
> 
OK
>>   	unsigned int num_out = 0, num_in = 0;
>> +	int node = dev_to_node(&vcrypto->vdev->dev);
>>   
> are you sure it is
> better to allocate close to device and not to current node
> which is the default?
>
Also with this part:
  /* Internal representation of a data virtqueue */
@@ -65,11 +66,6 @@ struct virtio_crypto {
  	/* Maximum size of per request */
  	u64 max_size;

-	/* Control VQ buffers: protected by the ctrl_lock */
-	struct virtio_crypto_op_ctrl_req ctrl;
-	struct virtio_crypto_session_input input;
-	struct virtio_crypto_inhdr ctrl_status;
-
  	unsigned long status;
  	atomic_t ref_count;

Orignally virtio crypto driver allocates ctrl&input&ctrl_status 
per-device, and protects this with ctrl_lock. This is the reason why the 
control queue reaches the bottleneck of performance. I'll append this in 
the next version in commit message.

Instead of the single request buffer, declare struct 
virtio_crypto_ctrl_request {
         struct virtio_crypto_op_ctrl_req ctrl;
         struct virtio_crypto_session_input input;
         struct virtio_crypto_inhdr ctrl_status;
	... }

The motivation of this change is to allocate buffer from the same node 
with device during control queue operations.

> 
>>   	pkey = kmemdup(key, keylen, GFP_ATOMIC);
>>   	if (!pkey)
>>   		return -ENOMEM;
>>   
>> -	spin_lock(&vcrypto->ctrl_lock);
>> -	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
>> -	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
>> -	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>> +	vc_ctrl_req = kzalloc_node(sizeof(*vc_ctrl_req), GFP_KERNEL, node);
>> +	if (!vc_ctrl_req)
>> +		goto out;
> 
> do you need to allocate it with kzalloc?
> is anything wrong with just keeping it part of device?
> even if yes this change is better split in a separate patch, would make the patch smaller.
Because there are padding field in 
virtio_crypto_op_ctrl_req&virtio_crypto_session_input, I suppose the 
original version also needs to clear padding field.
So I use kzalloc to make sure that the padding field gets cleared.
If this is reasonable, to separate this patch is OK to me, or I append 
this reason into commit message and comments in code.

>> +
>> +void virtcrypto_ctrlq_callback(struct virtqueue *vq)
>> +{
>> +	struct virtio_crypto *vcrypto = vq->vdev->priv;
>> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
>> +	unsigned long flags;
>> +	unsigned int len;
>> +
>> +	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
>> +	do {
>> +		virtqueue_disable_cb(vq);
>> +		while ((vc_ctrl_req = virtqueue_get_buf(vq, &len)) != NULL) {
> 
> 
> you really need to break out of this loop if vq is broken,
> virtqueue_get_buf will keep returning NULL in this case.
> 
I'm a little confused here, if virtqueue_get_buf return NULL, this loop 
will break. Could you please give me more hints?
> 
>> +			spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
>> +			if (vc_ctrl_req->ctrl_cb)
>> +				vc_ctrl_req->ctrl_cb(vc_ctrl_req);
>> +			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
>> +		}
>> +		if (unlikely(virtqueue_is_broken(vq)))
>> +			break;
>> +	} while (!virtqueue_enable_cb(vq));
>> +	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> 
> speaking of which existing code does not handle vq broken case
> all that well but it looks like this patch makes it a bit worse.
> want to try fixing? basically report an error ...
> 
>if virtqueue is broken, I can print log.

>> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
>> index c6f482db0bc0..e668d4b1bc6a 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_core.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
>> @@ -73,7 +73,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
>>   		goto err_names;
>>   
>>   	/* Parameters for control virtqueue */
>> -	callbacks[total_vqs - 1] = NULL;
>> +	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
>>   	names[total_vqs - 1] = "controlq";
>>   
>>   	/* Allocate/initialize parameters for data virtqueues */
>> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>> index a618c46a52b8..b8999dab3e66 100644
>> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
>> +	err = 0;
>> +out:
>> +	kfree_sensitive(vc_ctrl_req);
> 
> it is interesting that you use kfree_sensitive here. why is that?
> is there in fact anything sensitive here? if yes this is a security
> improvement and might need its own patch, or at least documentation.
>

OK, kfree is good enough here, I'll fix this.


Thanks a lot!


-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
