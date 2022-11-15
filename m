Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDB6C433FE
	for <virtualization@archiver.kernel.org>; Tue, 15 Nov 2022 06:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2AE9040445;
	Tue, 15 Nov 2022 06:28:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2AE9040445
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dHp3mrD8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qY_08U0yDtbr; Tue, 15 Nov 2022 06:28:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A9AB840125;
	Tue, 15 Nov 2022 06:28:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9AB840125
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78C6CC0033;
	Tue, 15 Nov 2022 06:28:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F4BFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 06:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D705240133
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 06:28:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D705240133
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dHp3mrD8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KmnjYg0gigKP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 06:28:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D61524012D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D61524012D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Nov 2022 06:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668493701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gaUjUy0cAk82v0uahWp+GaCbWFfU6R/rouT9IrYbegg=;
 b=dHp3mrD8rnntxE+qqoSBT5qz88BXPqPITd34Umj+GxodiPAF7rYHAiI8/zPjX1RwG9nxOP
 NyPrycwFp5uHxcdIvg1NNMdjCS4KZQNx9/iCrfRq58ObKsfWOrXxF/YIJHY74Flz63nDp4
 HlTmmgTfwyCm4sSvlJ2PcWjlDR+Y0dI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-361-QWRCM7-lNIuF0wnJlCZJ8Q-1; Tue, 15 Nov 2022 01:28:13 -0500
X-MC-Unique: QWRCM7-lNIuF0wnJlCZJ8Q-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-13ba8947e4cso6360329fac.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 22:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gaUjUy0cAk82v0uahWp+GaCbWFfU6R/rouT9IrYbegg=;
 b=H8eltwId6di5Rqqalt1ZFxRc494/hUOeZRJ6dfE07XlhJr/gjEyBqMEDB0dCikfMR7
 US/vJO7hE33RYnGsVlfEy+lMIFjHNhUsLds4JgZ3AEcjvoIaIDggN/O2YuaMdZrrbelr
 030RHI2qMcPqj0Iie+J7/IGtJPMd7siBBIPwRM9NPJzIPThGwTGCE+CzX8mRyzrJ8jP6
 fx+Z01+VWM2EJx278SGmrgbTqaWLrEvGGghznAkgc80CeC1GrYvd/D+xB25087GOf0F9
 ykpw5RN1QvKHKLlbURY8gcR/CHo+aAxs9Zu4+ykr8SxtfkRD3Xhu4LFuMnHeK85/1hL5
 e99A==
X-Gm-Message-State: ANoB5pniYwnxjdyJ8SoysypVlaSWl2EyO7tKc0NpjdWAN15A9XpE1fpj
 LapswzGdMAAlQyX3RYVESJmzzxPTEoL+4mya9t///9NDbgu0dgJf+Vr9Md+k/qP0G2pspX1r/Vk
 d4NVYJdvZot/xEn3W5OjbScf3BcBTMsNBNgB/HKIPBjP9vCjVnPIdQNxTXw==
X-Received: by 2002:a05:6870:638b:b0:132:7b3:29ac with SMTP id
 t11-20020a056870638b00b0013207b329acmr20142oap.35.1668493681906; 
 Mon, 14 Nov 2022 22:28:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5tUUvRnolsxfw39pTuYChdskbYVUQhRqzQkqzCLPFMem0cs5JPJwzFU6g3NP1ms1xyZbrMZ2DrwHkNEwFVECw=
X-Received: by 2002:a05:6870:638b:b0:132:7b3:29ac with SMTP id
 t11-20020a056870638b00b0013207b329acmr20136oap.35.1668493681696; Mon, 14 Nov
 2022 22:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20221114110740.537276-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20221114110740.537276-1-weiyongjun@huaweicloud.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Nov 2022 14:27:50 +0800
Message-ID: <CACGkMEvTnjO7eunS42WeAs4hG=zLWVmHmaRXaAvzhCy4QnCc=g@mail.gmail.com>
Subject: Re: [PATCH] virtio-crypto: fix memory leak in
 virtio_crypto_alg_skcipher_close_session()
To: Wei Yongjun <weiyongjun@huaweicloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, zhenwei pi <pizhenwei@bytedance.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 14, 2022 at 7:26 PM Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
>
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> 'vc_ctrl_req' is alloced in virtio_crypto_alg_skcipher_close_session(),
> and should be freed in the invalid ctrl_status->status error handling
> case. Otherwise there is a memory leak.
>
> Fixes: 0756ad15b1fe ("virtio-crypto: use private buffer for control request")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

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
