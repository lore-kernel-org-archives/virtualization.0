Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87707C433EF
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 06:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2873240159;
	Tue, 24 May 2022 06:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MmmU4hJBKVNJ; Tue, 24 May 2022 06:32:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A4CAA400AF;
	Tue, 24 May 2022 06:32:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61611C0039;
	Tue, 24 May 2022 06:32:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 225EBC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 06:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9DF2416CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 06:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-J3P5VYL1yE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 06:32:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1058C416BA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 06:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653373973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nrMEoijBijbNU22Jw7uLctg18ZKd9qcLuQqiF8bfzeA=;
 b=FcOOWBNwKdNCubFkUoU1mNQmnqBhhw57taeGUO6aZb5s5tRz6w0/sSE4Y5Za70M25Md8fb
 dyCgUwdWmmQICwgAR/haQ71nSFCtxRSjZWjy3fI0hH1fJvBIzf9BwxE6qS8dBhINIlMbI4
 PPUdpiAdsxDByE0Dfxdz3vrrPiGPmoY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-cZc9hCOSNSOJDowYZlY09Q-1; Tue, 24 May 2022 02:32:50 -0400
X-MC-Unique: cZc9hCOSNSOJDowYZlY09Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 d2-20020a2e8902000000b00253bba7ce10so3355467lji.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 23:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nrMEoijBijbNU22Jw7uLctg18ZKd9qcLuQqiF8bfzeA=;
 b=QYvYpbD4dCXFDremp5GKrVaYbu63MCbEQ7SZV9Jj9XTtGdxJPzdRIMsWbvAbehZ4aM
 Eo/449Bh/LbTNxSH+EESrUQIPOHSTtUnBjdpGw9oO5NYTrkmpNGLWYmWzbH5jZsUWEy8
 hb4liqnKAIW5JoolTv98cw1fumxAhOscXmly6pvkUBPtRAclAjKXMftD2hrS0ujf294e
 NHRKjD/+7MqId6miKBzlstrQRFueEI9BhIKc3HfiGzWYwzVwfLNU7rDm0lb9F0UKhifG
 t9AWB/8TbeGRb5OJAFzdT5uA4PYMyeZ1wWZsXcr9yq1hxsyWo+Clhh8asB62lC+nwFg4
 rmoQ==
X-Gm-Message-State: AOAM5323rvDWZujDTHH7QhZ4SC1yivMlP/cXJEc1MwXB66qaN8PWKL+j
 eIaS26jfLVfigL0VGhDw59uKdDfn2XNsLCdIfE6ve0Hvt9LAx0fTwJHmbS3VF6CMVq2ySR8SS4+
 0nv/0HNWZRJCNzG6ltDMhbm8lZPmiYEOAWg+ZJExv7DBEIYSws4rvTvi3AA==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr18397483lfa.210.1653373947593; 
 Mon, 23 May 2022 23:32:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPr5MZulLAmUF36ndBcQvv5GpAsz3ZbjIsNO7uECdQvD1+fXPY2pDSbULh5wOJKZ1HOh0Jhzb32Huft5Msonw=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr18397473lfa.210.1653373947411; Mon, 23
 May 2022 23:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <068d2824cf592748cbd9b75cf4cb6c29600e213c.1653224817.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <068d2824cf592748cbd9b75cf4cb6c29600e213c.1653224817.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 May 2022 14:32:16 +0800
Message-ID: <CACGkMEtAP_8vNS_JeqOa+ezL=Ngsvk0-B-Pth=nw9rA8g=C10Q@mail.gmail.com>
Subject: Re: [PATCH] virtio-crypto: Fix an error handling path in
 virtio_crypto_alg_skcipher_close_session()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Dan Carpenter <dan.carpenter@oracle.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, May 22, 2022 at 9:07 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Now that a private buffer is allocated (see commit in the Fixes tag),
> it must be released in all error handling paths.
>
> Add the missing goto to avoid a leak in the error handling path.
>
> Fixes: 42e6ac99e417 ("virtio-crypto: use private buffer for control request")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index e553ccadbcbc..e5876286828b 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -239,7 +239,8 @@ static int virtio_crypto_alg_skcipher_close_session(
>                 pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
>                         ctrl_status->status, destroy_session->session_id);
>
> -               return -EINVAL;
> +               err = -EINVAL;
> +               goto out;
>         }
>
>         err = 0;
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
