Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEC4C43217
	for <virtualization@archiver.kernel.org>; Tue, 15 Nov 2022 01:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 991BE4086E;
	Tue, 15 Nov 2022 01:11:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 991BE4086E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=iyzZeB2H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QN8W586X7vyH; Tue, 15 Nov 2022 01:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D0BFA40865;
	Tue, 15 Nov 2022 01:10:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0BFA40865
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E9C7C0032;
	Tue, 15 Nov 2022 01:10:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29A18C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 01:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E51CD608D8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 01:10:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E51CD608D8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
 header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=iyzZeB2H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zYiGb4HuNO7b
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 01:10:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4B79607DE
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4B79607DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 01:10:55 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id k22so12699185pfd.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 17:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZoxcZLmzsq83+rHNWuzABJOjX7MklD2wIzx4GvWNeCY=;
 b=iyzZeB2HIwzW+rGfh2nFI825HJA5s0hyO6y42jBoY4eYD7JAzLEiLIkC3NSVG78BKc
 mQDssF8RtvFCb/94yM35OxP/RSkKEbFVbHiZ5dm12cGVH6D1/2beJ4aIRJWivDKN0UMJ
 A/ovm6OMDHgEYtFRVJ9zjFLQi5oFATo1c9dQX8fGpnRXsgfxVx2fihRBk8w3xZwCN2YD
 q2BOce+mDlq76+h6kfh4/NwAmgBcGMUFzyXQHzaljFRlH2XwDgg9BRkM4QiM5TR+Y262
 TD1V6CO87waIBRLqhxMozbhWNrV8oEG8ndSF16TyCrwcPLt11GPyftBFvLk5f52TACV1
 9OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoxcZLmzsq83+rHNWuzABJOjX7MklD2wIzx4GvWNeCY=;
 b=Fr4iw2RYzjhKiWQcbMs+HhxlPK+PVLeYOWKaG7wGFPmfpkq/2ou6bCycWseTTiWtvb
 TOWflsrb0qr6+WsQ0iRbYX/A7jc1gkRXELCDpJps+DcNZaUBXGSCSkVJ6/GkZiGHP52I
 JNGCqA3ZyIR5nVADXUlajCQm4FPoGjP0LpHjDlRT+BxOGlBiBKf0PT8K3dNxdhRhUb7F
 QRXQsGc83I2MxSy0RUibIrsc/9uwhd+M6nxMetNiSFxMfVead3dcPre3Mo5+Y+qeXq1/
 LCJJYn2L7X/mvsi7jljPomkUQRtvtVxeS0b1deaAZ4vjRqkq+Qi+eoGArXekstFrioI6
 oKnQ==
X-Gm-Message-State: ANoB5plcDsOKQ1NtRDGw1mYxEmjpC1riHYn8UCxphLeo1coLiqAX5hzo
 RDF0dKnotWb5IhnKNOQI9P95VA==
X-Google-Smtp-Source: AA0mqf6zb5XJbo4C55nIh4hVOYh8QQgkeOw7vEH2RSrP44ZAkXBsW4BJ0KfNo6XrDl9r1B+8HiqGkg==
X-Received: by 2002:a63:d457:0:b0:476:837b:7a08 with SMTP id
 i23-20020a63d457000000b00476837b7a08mr6159794pgj.430.1668474654884; 
 Mon, 14 Nov 2022 17:10:54 -0800 (PST)
Received: from [10.3.43.196] ([63.216.146.186])
 by smtp.gmail.com with ESMTPSA id
 jm5-20020a17090304c500b00186b758c9fasm8201015plb.33.2022.11.14.17.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Nov 2022 17:10:54 -0800 (PST)
Message-ID: <0cc9f344-44ff-284f-391e-dcf756d74471@bytedance.com>
Date: Tue, 15 Nov 2022 09:09:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] virtio-crypto: fix memory leak in
 virtio_crypto_alg_skcipher_close_session()
To: Wei Yongjun <weiyongjun@huaweicloud.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>
References: <20221114110740.537276-1-weiyongjun@huaweicloud.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20221114110740.537276-1-weiyongjun@huaweicloud.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 virtualization@lists.linux-foundation.org,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

Looks good to me, thanks!

Acked-by: zhenwei pi<pizhenwei@bytedance.com>

On 11/14/22 19:07, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> 'vc_ctrl_req' is alloced in virtio_crypto_alg_skcipher_close_session(),
> and should be freed in the invalid ctrl_status->status error handling
> case. Otherwise there is a memory leak.
> 
> Fixes: 0756ad15b1fe ("virtio-crypto: use private buffer for control request")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index e553ccadbcbc..e5876286828b 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -239,7 +239,8 @@ static int virtio_crypto_alg_skcipher_close_session(
>   		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
>   			ctrl_status->status, destroy_session->session_id);
>   
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto out;
>   	}
>   
>   	err = 0;

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
