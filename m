Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E76DC43217
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 06:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E4A060E87;
	Tue,  8 Mar 2022 06:16:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5ogITAvFwL2; Tue,  8 Mar 2022 06:16:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F3D660B6F;
	Tue,  8 Mar 2022 06:16:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17077C0012;
	Tue,  8 Mar 2022 06:16:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACACCC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87620404C5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VxJ23OxUEr_5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:16:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52689408C5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 06:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646720172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5ugwLO4/RAIk+A33RH1Nda04XboyFL8Xk9nspKrv+Q=;
 b=K4QH60aeAhkevNPKH9zPRCBRHA6Z0ts6BpRqyWNMXD27cOSN2g0HlHl3M4lAzHqvUzKq8a
 /fqkAWcESi2czZBnGLv1AOUYQoKHxCYdFsqMeMDYhhkk9zbliXyiDbTzLcZxKn442tChnD
 0C0qQftxPJFFgjKkuE0ppe1Z4KQsAmQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-ogXoZnbqOv27WrcvSDd0Bg-1; Tue, 08 Mar 2022 01:16:10 -0500
X-MC-Unique: ogXoZnbqOv27WrcvSDd0Bg-1
Received: by mail-lf1-f71.google.com with SMTP id
 w16-20020a0565120b1000b004458c29db0aso4477206lfu.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Mar 2022 22:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c5ugwLO4/RAIk+A33RH1Nda04XboyFL8Xk9nspKrv+Q=;
 b=BcRUpB0v8twRfRITRW1fT89JCsYWqbxoH2fljibW3ggL4Kb+YjXqU9IjXH8LifjTp4
 j3eykXjMnYnl0KBHtTa4KIuJ18UlOX/FcHvPiwGkCaTZ5IQzf5m8k8Ez/B8CKgmusf3b
 TsvoceK5Ygojbp9JlabFJF/HHUtGec8tvqxEoCQezTo4Z5h/sSWpIMJjCD/xsCXztYZh
 EA7Nuwm5hJrxaf7FH92CjUe8fA992rtETypEt948RrUX4jDLtEsc5EHbeZ5U7SPkfr/f
 llL1trgr7rNMKSgyhy5CBPwoaKVntEU08rLwmhznh45U74CqsQPOFQwcETlarx0v52W3
 AJxw==
X-Gm-Message-State: AOAM532snfhtrkCKG9cPOyIo1iDxpBFW8JVPVso6XecTOJyVyL0w5HnP
 8fwNqk5nZgzlFC7Mv0Hd4qB96oZ0Exbje0vR7XqvTQVDWZiSLVm0iQN+wbR/LFv1ftVBTvOjmxk
 4tPomA2KEiGdb676OybXJBVZCA/ftPAx5hEVU+e5lVdNAiZvCaRSyenZSzg==
X-Received: by 2002:a2e:9045:0:b0:247:da7d:a460 with SMTP id
 n5-20020a2e9045000000b00247da7da460mr9533958ljg.300.1646720168191; 
 Mon, 07 Mar 2022 22:16:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxait3lv+dLzC+BdDFV83vSleLNh5HIk4y197ubAHp3aPkfzkCIzF+1Ixw1dsakTX8Qi9vOeSnOuGXbcvWoGxY=
X-Received: by 2002:a2e:9045:0:b0:247:da7d:a460 with SMTP id
 n5-20020a2e9045000000b00247da7da460mr9533952ljg.300.1646720167963; Mon, 07
 Mar 2022 22:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20220307191757.3177139-1-lee.jones@linaro.org>
In-Reply-To: <20220307191757.3177139-1-lee.jones@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Mar 2022 14:15:56 +0800
Message-ID: <CACGkMEsjmCNQPjxPjXL0WUfbMg8ARnumEp4yjUxqznMKR1nKSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
To: Lee Jones <lee.jones@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Mar 8, 2022 at 3:18 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> vhost_vsock_handle_tx_kick() already holds the mutex during its call
> to vhost_get_vq_desc().  All we have to do here is take the same lock
> during virtqueue clean-up and we mitigate the reported issues.
>
> Also WARN() as a precautionary measure.  The purpose of this is to
> capture possible future race conditions which may pop up over time.
>
> Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
>
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/vhost/vhost.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe28..ef7e371e3e649 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>         int i;
>
>         for (i = 0; i < dev->nvqs; ++i) {
> +               /* No workers should run here by design. However, races have
> +                * previously occurred where drivers have been unable to flush
> +                * all work properly prior to clean-up.  Without a successful
> +                * flush the guest will malfunction, but avoiding host memory
> +                * corruption in those cases does seem preferable.
> +                */
> +               WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> +

I don't get how this can help, the mutex could be grabbed in the
middle of the above and below line.

> +               mutex_lock(&dev->vqs[i]->mutex);
>                 if (dev->vqs[i]->error_ctx)
>                         eventfd_ctx_put(dev->vqs[i]->error_ctx);
>                 if (dev->vqs[i]->kick)
> @@ -700,6 +709,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>                 if (dev->vqs[i]->call_ctx.ctx)
>                         eventfd_ctx_put(dev->vqs[i]->call_ctx.ctx);
>                 vhost_vq_reset(dev, dev->vqs[i]);
> +               mutex_unlock(&dev->vqs[i]->mutex);
>         }

I'm not sure it's correct to assume some behaviour of a buggy device.
For the device mutex, we use that to protect more than just err/call
and vq.

Thanks

>         vhost_dev_free_iovecs(dev);
>         if (dev->log_ctx)
> --
> 2.35.1.616.g0bdcbb4464-goog
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
