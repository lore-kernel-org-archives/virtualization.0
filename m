Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E7AC433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 06:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABD0C6FC7B;
	Fri, 14 Jan 2022 06:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJDBR03QS2wT; Fri, 14 Jan 2022 06:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 432D760AB7;
	Fri, 14 Jan 2022 06:18:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11EE6C0030;
	Fri, 14 Jan 2022 06:18:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1787BC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E24AD84D18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JENUqC6aqGj4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:18:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B87E84D17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642141099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YawaJX8lTftoOW61Y7U6IA50jMGmbdQaYnSxlW1+tHw=;
 b=Lr89x363kqibVEWDLQkPayvAR3KlXa89xR5Nt8ZBwPTuG8LpNHHnPBs0OElPUF3Mv9dYTz
 m7UFCufut7k565Idrbih+ciUNjd6yLNWomVxJkzZNCOCTTptB981h0Qu/W2JRoScXU0wax
 ToY6lUYSXup/7c2YtjKFsDItV+JcgLs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-zFe_mSMsM62YsJDJDI0nrQ-1; Fri, 14 Jan 2022 01:18:13 -0500
X-MC-Unique: zFe_mSMsM62YsJDJDI0nrQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 q14-20020ac246ee000000b0042c02909ed4so5508084lfo.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 22:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YawaJX8lTftoOW61Y7U6IA50jMGmbdQaYnSxlW1+tHw=;
 b=otKQqUVCo07wGo/opJNjSdQma0zhXb/rpM+ke2nmmJHQ7QiGMQ5NCBNej1wJ5cP/Zb
 S5X+flx/H0GgvgG+YRv8e/ToyUUOg/KAE3D7jwkjgnb915T99MSFGeecWyfwyG0W7wZI
 sSvf/USqAdbKz0Ua1PcBR8WRW0TL73Z9MfOCzvr7sjYy/foUnBVTnTuySit5EP6VBaGn
 1iCL4G+v54gMM+Zoqr2VZT/b+65o4CokY/il9RoFZxSV9Jlz0UbB9CV2IXSWQRULI+yF
 iR6CsaK127MiqzJjzQzmoL7A/oTUehhz5lcadI/VrCmFk95Vw40eFItzpCLL0/Bn1WDe
 JXtg==
X-Gm-Message-State: AOAM531D5qCe6l0l20VpDtLBGnhNcj2PJ4gew81cZu52eG98a1sa/ZbI
 7M0oei7CyU5xcmz3TRbJP6QEAj6Kwuqd7TbC/K6bV5CM8+p0CTOrJnO5zI0pvDsIwipGJz/EuMI
 kfbkYDi0Mcs9rZCPYAd8IFqkdK9HAb38UhwqMBvSBTn7FP0MSGVRG0Hc3bw==
X-Received: by 2002:a2e:8645:: with SMTP id i5mr2054348ljj.420.1642141092220; 
 Thu, 13 Jan 2022 22:18:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6Nfbams2KnY3qknpeMJm2YPphc5XVQuPf+9aKqnItDdPeixnxkwbf4f/KJ8Znvhi0j4XtHNEKy5oo568WAt4=
X-Received: by 2002:a2e:8645:: with SMTP id i5mr2054339ljj.420.1642141092040; 
 Thu, 13 Jan 2022 22:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20220113145642.205388-1-sgarzare@redhat.com>
In-Reply-To: <20220113145642.205388-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Jan 2022 14:18:01 +0800
Message-ID: <CACGkMEsqY5RHL=9=iny6xRVs_=EdACUCfX-Rmpq+itpdoT_rrg@mail.gmail.com>
Subject: Re: [RFC PATCH] vhost: cache avail index in vhost_enable_notify()
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Thu, Jan 13, 2022 at 10:57 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> In vhost_enable_notify() we enable the notifications and we read
> the avail index to check if new buffers have become available in
> the meantime. In this case, the device would go to re-read avail
> index to access the descriptor.
>
> As we already do in other place, we can cache the value in `avail_idx`
> and compare it with `last_avail_idx` to check if there are new
> buffers available.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Patch looks fine but I guess we won't get performance improvement
since it doesn't save any userspace/VM memory access?

Thanks

> ---
>  drivers/vhost/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..07363dff559e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>                        &vq->avail->idx, r);
>                 return false;
>         }
> +       vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>
> -       return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
> +       return vq->avail_idx != vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
