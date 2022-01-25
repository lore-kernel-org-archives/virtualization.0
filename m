Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CE4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 19:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B4D74035C;
	Tue, 25 Jan 2022 19:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXXu0YCgUlBe; Tue, 25 Jan 2022 19:31:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5417F4032E;
	Tue, 25 Jan 2022 19:31:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 299A5C0039;
	Tue, 25 Jan 2022 19:31:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79E62C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 671364013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYjYRZW2FBGl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:31:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67B5D40004
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643139076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1y3rvxPiO/9emawQnXo32bBBh9nL/eYXEjpNfFj991A=;
 b=Nk+tST7EQbFkKCFPsTteHqqK0xS5J2+bhekpjpLt+FnUzLNStSIjuz5xchMs+WbjeEpEUH
 e5gkIF75Q59oqznyBI5hnwhS7QnXTreCdu+kfQdxhqmgGPde52gQXJchb+EY6fd8eGl+14
 T76QKAbWdcSZFbsxDE6veGyFSdccl/E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-gXXWLY9DNRaxkh1bEcdQFg-1; Tue, 25 Jan 2022 14:31:14 -0500
X-MC-Unique: gXXWLY9DNRaxkh1bEcdQFg-1
Received: by mail-ej1-f72.google.com with SMTP id
 13-20020a170906328d00b006982d0888a4so3841987ejw.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 11:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1y3rvxPiO/9emawQnXo32bBBh9nL/eYXEjpNfFj991A=;
 b=URQYUdLpMvNUNANOUiX+Tf/K51tzZ1tVX7FJQy1C11V3i9QZ54U0184tVL7acWjVY+
 b0A852XaK/76VRkffYbc+AmXq3EsGk8fDdi8/GT3AJ9txvoR2MfxID4s2rT+IenvVqOU
 ZohXp9Blu80Ye8V5o1I4C86X+QRnCpibIe99uOQpeWY+/Ju0MISnaTfJGGoW8yq4gR/9
 KtIIk96gfk9BKlZgZ9nNRsVo7ptEoB1ybmIhIBzhGgAdvSK0TtnuwHy125ZeQYki88Sd
 F4EenxKCobo6mzD0diAwug56EHCccrVq73agld9UZx+VvU3TLOb5g9plklTngNHm59a3
 fgMA==
X-Gm-Message-State: AOAM533C3fe72zilvmqI+07JJzlT5oWKpTNhXxC9q1uCgVTNaPec0gUK
 J+uMci7cdSKRn1M3TI7/P/GELIMxxj0b5wovFpyLrBMKCn66B+kj/daMiUc6SK/eiZ0X8CXL5QU
 LYvh+pP0SukZSCyNM6bZZcief6xgbPgy78Wv/WQ43QA==
X-Received: by 2002:a17:907:7f11:: with SMTP id
 qf17mr11316191ejc.76.1643139073415; 
 Tue, 25 Jan 2022 11:31:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZcH0aJ/a9DBOcxqASffCbpLGVyuJBXzBRwot1LsOd1f4QjOwT+3Ljc8MBb8XNCWiArZCXLA==
X-Received: by 2002:a17:906:175b:: with SMTP id
 d27mr17480756eje.476.1643139052011; 
 Tue, 25 Jan 2022 11:30:52 -0800 (PST)
Received: from redhat.com ([176.12.185.204])
 by smtp.gmail.com with ESMTPSA id o11sm8670746edh.75.2022.01.25.11.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 11:30:48 -0800 (PST)
Date: Tue, 25 Jan 2022 14:30:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V2 3/4] vhost_vdpa: don't setup irq offloading when
 irq_num < 0
Message-ID: <20220125143008-mutt-send-email-mst@kernel.org>
References: <20220125091744.115996-1-lingshan.zhu@intel.com>
 <20220125091744.115996-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220125091744.115996-4-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Jan 25, 2022 at 05:17:43PM +0800, Zhu Lingshan wrote:
> When irq number is negative(e.g., -EINVAL), the virtqueue
> may be disabled or the virtqueues are sharing a device irq.
> In such case, we should not setup irq offloading for a virtqueue.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vhost/vdpa.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 851539807bc9..909891d518e8 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -96,6 +96,9 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
>  	if (!ops->get_vq_irq)
>  		return;
>  
> +	if (irq < 0)
> +		return;
> +
>  	irq = ops->get_vq_irq(vdpa, qid);

So it's used before it's initialized. Ugh.
How was this patchset tested?

>  	irq_bypass_unregister_producer(&vq->call_ctx.producer);
>  	if (!vq->call_ctx.ctx || irq < 0)
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
