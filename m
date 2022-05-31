Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9E7C433EF
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 01:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E1BA41BE6;
	Tue, 31 May 2022 01:51:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkFjD8nNMaKc; Tue, 31 May 2022 01:51:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9883B41BE5;
	Tue, 31 May 2022 01:51:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7871BC0039;
	Tue, 31 May 2022 01:51:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F9F7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 01:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FAF860648
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 01:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMz-7VkrMFBG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 01:51:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5513160634
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 01:51:43 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 gc3-20020a17090b310300b001e33092c737so828439pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=KmXOhOKHGR1vGePMG8VRHG4c52PZJ9+TG/+1WQ5Zjj0=;
 b=YmA+1r+7grFxgBZ5EytDPadjP2fm3hIUtwTniDELQlZ6ExHSvcawoPiSH3Y2RTcnBX
 K7+uewQxw0kPMMtcrAldq8FWWgIbkThUbuKbcvai2Kyj3r12iKoGgxuT66aDUcZntK1f
 mqVATkfwMFjmQMIFqcWgBFe1UM3/bwMQNd4hFXE7wsG39F4OUgGjJBQjOcK9gNjJ11E6
 nRPa01iGVXeWgR4gUbs89f1HlVNWGJaQ2KUssLseIZm2RbQBztd+9ZqkTAH+5BHxl4fv
 PwoGM/txw0J/T3P1Y4Q/L8gSSjkh18E3pP8AlPPeayRFbbXw1T3kxn+OQTsc650SPXQV
 uTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=KmXOhOKHGR1vGePMG8VRHG4c52PZJ9+TG/+1WQ5Zjj0=;
 b=t9OcX0UKgkXIb+dDKV3m4U827EGE7/1u5daEUSXeBviCbByAeMyXFA1IaDkWX6zZk6
 IyaVJAjsST9lflbKrimT2IfzHx0rspvFudFbzOFtCcN+LzbODVuWrioY3bZ2ED1q62Lo
 CKDZhAJjFxxE/Y7FLnC6yan8upsAJ6jY7Dscv+gXWz/S4H59bsZRH6QpZzIvcjxSl+ed
 u/DxzFI8Yia4VRwuVVGnj7lzBIHqjVIShNtzmPHWAwhUiuQ2l2+bTQFmuUyZIpuzri29
 yhsywvGfBWDCfCSv3r4EduqLZE3nj8Phm1jc9XqWAp3dDlcOmvYvtCL9NAP+4l629R1U
 ncIg==
X-Gm-Message-State: AOAM533IyklJn3VcMz7h0MgCY2ASfWu1tlW3WrDFIgAarqyFGWgexuYR
 LEllmJDEiWRW1sA6tystBWTl9A==
X-Google-Smtp-Source: ABdhPJx+3iY92taAy6pVX7D+ECDjEuy9jyUENbikEfIoPMi5rinonne48/JeuRQmz5BxgnmUPTMY3A==
X-Received: by 2002:a17:90a:2c43:b0:1e0:b3fe:1bf5 with SMTP id
 p3-20020a17090a2c4300b001e0b3fe1bf5mr26049348pjm.27.1653961902534; 
 Mon, 30 May 2022 18:51:42 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.233])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a170902bb8200b0016191b843e2sm9792155pls.235.2022.05.30.18.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 18:51:41 -0700 (PDT)
Message-ID: <b2ee77ae-2044-32b4-20c5-43fa78e8213c@bytedance.com>
Date: Tue, 31 May 2022 09:47:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: RE: [PATCH v8 1/1] crypto: Introduce RSA algorithm
Content-Language: en-US
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20220527084734.2649594-1-pizhenwei@bytedance.com>
 <20220527084734.2649594-2-pizhenwei@bytedance.com>
 <848d579e2c504ba493cd57510a7ff3b0@huawei.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <848d579e2c504ba493cd57510a7ff3b0@huawei.com>
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
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

On 5/30/22 21:31, Gonglei (Arei) wrote:
> 
> 
>> -----Original Message-----
>> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
>> Sent: Friday, May 27, 2022 4:48 PM
>> To: mst@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>
>> Cc: qemu-devel@nongnu.org; virtualization@lists.linux-foundation.org;
>> helei.sig11@bytedance.com; berrange@redhat.com; zhenwei pi
>> <pizhenwei@bytedance.com>
>> Subject: [PATCH v8 1/1] crypto: Introduce RSA algorithm
>>
>>
> Skip...
> 
>> +static int64_t
>> +virtio_crypto_create_asym_session(VirtIOCrypto *vcrypto,
>> +               struct virtio_crypto_akcipher_create_session_req
>> *sess_req,
>> +               uint32_t queue_id, uint32_t opcode,
>> +               struct iovec *iov, unsigned int out_num) {
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(vcrypto);
>> +    CryptoDevBackendSessionInfo info = {0};
>> +    CryptoDevBackendAsymSessionInfo *asym_info;
>> +    int64_t session_id;
>> +    int queue_index;
>> +    uint32_t algo, keytype, keylen;
>> +    g_autofree uint8_t *key = NULL;
>> +    Error *local_err = NULL;
>> +
>> +    algo = ldl_le_p(&sess_req->para.algo);
>> +    keytype = ldl_le_p(&sess_req->para.keytype);
>> +    keylen = ldl_le_p(&sess_req->para.keylen);
>> +
>> +    if ((keytype != VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC)
>> +         && (keytype != VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE)) {
>> +        error_report("unsupported asym keytype: %d", keytype);
>> +        return -VIRTIO_CRYPTO_NOTSUPP;
>> +    }
>> +
>> +    if (keylen) {
>> +        key = g_malloc(keylen);
>> +        if (iov_to_buf(iov, out_num, 0, key, keylen) != keylen) {
>> +            virtio_error(vdev, "virtio-crypto asym key incorrect");
>> +            return -EFAULT;
> 
> Memory leak.
> 
>> +        }
>> +        iov_discard_front(&iov, &out_num, keylen);
>> +    }
>> +
>> +    info.op_code = opcode;
>> +    asym_info = &info.u.asym_sess_info;
>> +    asym_info->algo = algo;
>> +    asym_info->keytype = keytype;
>> +    asym_info->keylen = keylen;
>> +    asym_info->key = key;
>> +    switch (asym_info->algo) {
>> +    case VIRTIO_CRYPTO_AKCIPHER_RSA:
>> +        asym_info->u.rsa.padding_algo =
>> +            ldl_le_p(&sess_req->para.u.rsa.padding_algo);
>> +        asym_info->u.rsa.hash_algo =
>> +            ldl_le_p(&sess_req->para.u.rsa.hash_algo);
>> +        break;
>> +
>> +    /* TODO DSA&ECDSA handling */
>> +
>> +    default:
>> +        return -VIRTIO_CRYPTO_ERR;
>> +    }
>> +
>> +    queue_index = virtio_crypto_vq2q(queue_id);
>> +    session_id = cryptodev_backend_create_session(vcrypto->cryptodev,
>> &info,
>> +                     queue_index, &local_err);
>> +    if (session_id < 0) {
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +        }
>> +        return -VIRTIO_CRYPTO_ERR;
>> +    }
>> +
>> +    return session_id;
> 
> Where to free the key at both normal and exceptional paths?
> 

Hi, Lei

The key is declared with g_autofree:
g_autofree uint8_t *key = NULL;

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
