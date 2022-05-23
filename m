Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4786EC4332F
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 00:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D552340A06;
	Mon, 23 May 2022 00:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cGPNUd45ONLK; Mon, 23 May 2022 00:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 702AB400FB;
	Mon, 23 May 2022 00:04:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 443F5C0039;
	Mon, 23 May 2022 00:04:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BC3CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 00:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58B1640151
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 00:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLi_o--98BlR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 00:04:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 21011400FB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 00:04:30 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id b135so506391pfb.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 May 2022 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=UOkp6y7r1hyFZ2vnER+rfHPHB1ZMRtCyHLtXupopRVs=;
 b=L5norIkD2/0eKjGrCfCgo8okCTMPpLZnVhagra8ytcJ+NqzPu6x/2R7NqJL+m4eVM3
 m+chb5S0ZTZ746sExJuRMGC/HY3Z+uBdGOR8VlAQVpyYQTsvERx1/wX5ahxmFKV/0q0U
 w8gqzzNr/AaXQWTA7ukpK0LQhkvmnwAgt079bzOrbu+6Ozi5p7GUywbW3rM5Ck7HN7WN
 qek8AVXXIEVsi88DuzdLagpD627tlhH51VD2bRw5oAx1tbs1ypNg8XOBRXlgZ2+h4Lmw
 reS53S3vnpRkDq9pMiCwM0tFKvONa+ArjAcY5LxMWlWKaDDDdyMUBJVisMSS70LkGYQQ
 yKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=UOkp6y7r1hyFZ2vnER+rfHPHB1ZMRtCyHLtXupopRVs=;
 b=oEZIFfM5+UsyerszbZhPlYH8NYSRknKG5K4EVv8gnVp4km0iqGGAK/j/BnmC4SMhgp
 Jfuj3K4MQFUHm+w9MbMOwsHuJ48WUtuSbOFz7Imwoy/Ok6zDjWfgcHyy/pW0pi81Gttt
 OuP/WYEj/9aavbo3uhCf0dfXLIBrv6uwEAHANzqvaI2ZXy15XYWcsmvmtxoLeL9sbkym
 yZlS8bIN0mJN4fSQ7QpfYGcpXhgWMj46+irdftOmZFmYGy3Oluxn4/dUqeOFv44MFEl5
 AmyCBLdZ7ks8W8LM3aFnjvDEQ76fUIjh80vpRStcUlE1scZKZriFATsgyWKX9PnhfitY
 c59Q==
X-Gm-Message-State: AOAM5304QRgx84S5YVBNkR43dSh25IVcjMdDUCmo3i+Wk7yWdmCXcNhS
 rM1wJ04cNmL1OaV1alwVGO2DJA==
X-Google-Smtp-Source: ABdhPJyieONJVyrim8+r73DTQxdtaOachQAxcnAsYPRbDhwAjKhsWoR+2/4pBO5djbaQpNB7VNd92Q==
X-Received: by 2002:a63:581:0:b0:3f2:6b21:4733 with SMTP id
 123-20020a630581000000b003f26b214733mr18172416pgf.90.1653264269517; 
 Sun, 22 May 2022 17:04:29 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.239])
 by smtp.gmail.com with ESMTPSA id
 mj10-20020a17090b368a00b001cd4989ff44sm5762831pjb.11.2022.05.22.17.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 May 2022 17:04:28 -0700 (PDT)
Message-ID: <bf18d5b7-5364-79d2-5b57-df9dc4b284a5@bytedance.com>
Date: Mon, 23 May 2022 08:00:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] virtio-crypto: Fix an error handling path in
 virtio_crypto_alg_skcipher_close_session()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>
References: <068d2824cf592748cbd9b75cf4cb6c29600e213c.1653224817.git.christophe.jaillet@wanadoo.fr>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <068d2824cf592748cbd9b75cf4cb6c29600e213c.1653224817.git.christophe.jaillet@wanadoo.fr>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 dan.carpenter@oracle.com
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



On 5/22/22 21:07, Christophe JAILLET wrote:
> Now that a private buffer is allocated (see commit in the Fixes tag),
> it must be released in all error handling paths.
> 
> Add the missing goto to avoid a leak in the error handling path.
> 
> Fixes: 42e6ac99e417 ("virtio-crypto: use private buffer for control request")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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


This looks good to me, thanks!
Acked-by: zhenwei pi <pizhenwei@bytedance.com>

-- 
zhenwei pi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
