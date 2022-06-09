Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B1BC43334
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 01:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D414F41610;
	Thu,  9 Jun 2022 01:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CKwtLX0Z2Wna; Thu,  9 Jun 2022 01:02:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D18A8415CC;
	Thu,  9 Jun 2022 01:02:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EF65C0039;
	Thu,  9 Jun 2022 01:02:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B840C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 01:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A61B40AF9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 01:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u8hyRSuTRrRN
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 01:02:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 549A740AE2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 01:02:17 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 d12-20020a17090abf8c00b001e2eb431ce4so19804300pjs.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Jun 2022 18:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=VhCSI4/82p7maI+6hlpm39k7fZXsdvnmQOl9zbSCHak=;
 b=Kx2ZWz/2O8/FyqkIAzfWB3nPuVCn1WoKkcUfxzFGZUaAomsE01EcPN5ZWNlFJcLOT2
 2D74wXTyQCgqGl4cL+LMwuTPgsj1g0zkvTpZV/7jSSDf1eBJaGvycPwUrcpOzs1mbxnE
 aQfgbRwexqw5Jl2Meuqwh99hihxeNWN4kIJ0vS88GlpNPDigi8Gk+FcOnQoTQmmi/ebo
 Yeg9BjYAm87Zf8UPkbGs67JgX2Nc9vkucKujrU950le5hWcSOtp6nb5ZqMcOBpGgLXH6
 L77Rvf4Gmo1fKKC/Gl5DLfVgbAPCSKK0A/+MnXP++8RWgc6dbxRzlAHJyuNyl+i8Fc3N
 Si+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VhCSI4/82p7maI+6hlpm39k7fZXsdvnmQOl9zbSCHak=;
 b=FmnLmOA8DB6D2vsivB4krax1zft6akn++/Vej9MjW8JrxjC8ME8dbhF2s8MSobG4YD
 qATABVECcLIBe6ZPXruA4jzNHaAX5R/hRP1nQi1oqdDrXnPqjZ/qfTM5+PdJm8nBT1EI
 B2gwYksGWVcNUDTuqeCtSP6qwNuEc3WDYS4Wed8pwMswG1gppmvzvtMSKIsX2pQPvFeG
 j0ph0mJFGCtFUDSqj8flpZd9Ztz2nVoiEKoZjXM69szXTrccNvUquUdsS1Qo7maGXPdv
 u6mFSlJBTCewjKB5VrVTRAWBTsHAe8QjbPGgxvKvDNqNz8LWKFsqJmMC4FROJzfTUAxZ
 xrPQ==
X-Gm-Message-State: AOAM531/Uw4y8sH5R8Eplrz9FV7YjeLRSzMsbTDtjhXj706EFI5xXdsb
 XkYQ8+v9GMe+Jak8BI8vK4zQiA==
X-Google-Smtp-Source: ABdhPJzPbYlu81kIpByG9BMXMf41AW8Z/E2L0Wt/v+mXSqWzgIZA4Diie6fnPh+SLJDwLNhS0n6FpQ==
X-Received: by 2002:a17:903:230e:b0:166:3781:1e50 with SMTP id
 d14-20020a170903230e00b0016637811e50mr36887944plh.20.1654736536513; 
 Wed, 08 Jun 2022 18:02:16 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id
 x193-20020a6286ca000000b0051ceaa47cbdsm484753pfd.79.2022.06.08.18.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jun 2022 18:02:15 -0700 (PDT)
Message-ID: <e1a2af04-ef33-60df-0ada-a17a7d508344@bytedance.com>
Date: Thu, 9 Jun 2022 08:57:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: PING: RE: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
Content-Language: en-US
To: "mst@redhat.com" <mst@redhat.com>
References: <20220527084734.2649594-1-pizhenwei@bytedance.com>
 <20220527084734.2649594-2-pizhenwei@bytedance.com>
 <848d579e2c504ba493cd57510a7ff3b0@huawei.com>
 <b2ee77ae-2044-32b4-20c5-43fa78e8213c@bytedance.com>
 <39f884dbc25d4b0cbec510ab090e6778@huawei.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <39f884dbc25d4b0cbec510ab090e6778@huawei.com>
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

Hi, Michael

QEMU side was reviewed by Gonglei a week ago. To avoid this to be 
ignored, PING!

On 5/31/22 20:08, Gonglei (Arei) wrote:
> 
> 
>> -----Original Message-----
>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>> Sent: Tuesday, May 31, 2022 9:48 AM
>> To: Gonglei (Arei) <arei.gonglei@huawei.com>
>> Cc: qemu-devel@nongnu.org; mst@redhat.com;
>> virtualization@lists.linux-foundation.org; helei.sig11@bytedance.com;
>> berrange@redhat.com
>> Subject: Re: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
>>
>> On 5/30/22 21:31, Gonglei (Arei) wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>>>> Sent: Friday, May 27, 2022 4:48 PM
>>>> To: mst@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>
>>>> Cc: qemu-devel@nongnu.org; virtualization@lists.linux-foundation.org;
>>>> helei.sig11@bytedance.com; berrange@redhat.com; zhenwei pi
>>>> <pizhenwei@bytedance.com>
>>>> Subject: [PATCH v8 1/1] crypto: Introduce RSA algorithm
>>>>
>>>>
>>> Skip...
>>>
>>>> +static int64_t
>>>> +virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
>>>> +               struct virtio_crypto_akcipher_create_session_req
>>>> *sess_req,
>>>> +               uint32_t queue_id, uint32_t opcode,
>>>> +               struct iovec *iov, unsigned int out_num) {
>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
>>>> +    CryptoDevBackendSessionInfo info = {0};
>>>> +    CryptoDevBackendAsymSessionInfo *asym_info;
>>>> +    int64_t session_id;
>>>> +    int queue_index;
>>>> +    uint32_t algo, keytype, keylen;
>>>> +    g_autofree uint8_t *key = NULL;
>>>> +    Error *local_err = NULL;
>>>> +
>>>> +    algo = ldl_le_p(&sess_req->para.algo);
>>>> +    keytype = ldl_le_p(&sess_req->para.keytype);
>>>> +    keylen = ldl_le_p(&sess_req->para.keylen);
>>>> +
>>>> +    if ((keytype != VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC)
>>>> +         && (keytype !=
>> VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE)) {
>>>> +        error_report("unsupported asym keytype: %d", keytype);
>>>> +        return -VIRTIO_CRYPTO_NOTSUPP;
>>>> +    }
>>>> +
>>>> +    if (keylen) {
>>>> +        key = g_malloc(keylen);
>>>> +        if (iov_to_buf(iov, out_num, 0, key, keylen) != keylen) {
>>>> +            virtio_error(vdev, "virtio-crypto asym key incorrect");
>>>> +            return -EFAULT;
>>>
>>> Memory leak.
>>>
>>>> +        }
>>>> +        iov_discard_front(&iov, &out_num, keylen);
>>>> +    }
>>>> +
>>>> +    info.op_code = opcode;
>>>> +    asym_info = &info.u.asym_sess_info;
>>>> +    asym_info->algo = algo;
>>>> +    asym_info->keytype = keytype;
>>>> +    asym_info->keylen = keylen;
>>>> +    asym_info->key = key;
>>>> +    switch (asym_info->algo) {
>>>> +    case VIRTIO_CRYPTO_AKCIPHER_RSA:
>>>> +        asym_info->u.rsa.padding_algo =
>>>> +            ldl_le_p(&sess_req->para.u.rsa.padding_algo);
>>>> +        asym_info->u.rsa.hash_algo =
>>>> +            ldl_le_p(&sess_req->para.u.rsa.hash_algo);
>>>> +        break;
>>>> +
>>>> +    /* TODO DSA&ECDSA handling */
>>>> +
>>>> +    default:
>>>> +        return -VIRTIO_CRYPTO_ERR;
>>>> +    }
>>>> +
>>>> +    queue_index = virtio_crypto_vq2q(queue_id);
>>>> +    session_id =
>>>> + cryptodev_backend_create_session(vcrypto->cryptodev,
>>>> &info,
>>>> +                     queue_index, &local_err);
>>>> +    if (session_id < 0) {
>>>> +        if (local_err) {
>>>> +            error_report_err(local_err);
>>>> +        }
>>>> +        return -VIRTIO_CRYPTO_ERR;
>>>> +    }
>>>> +
>>>> +    return session_id;
>>>
>>> Where to free the key at both normal and exceptional paths?
>>>
>>
>> Hi, Lei
>>
>> The key is declared with g_autofree:
>> g_autofree uint8_t *key = NULL;
>>
> 
> OK. For the patch:
> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> 
> 
> Regards,
> -Gonglei
>      
> 

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
