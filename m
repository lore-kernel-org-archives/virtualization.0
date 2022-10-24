Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE9CECDFA1
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 08:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 097854031C;
	Mon, 24 Oct 2022 08:44:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 097854031C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCskc9VT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xiNhN6sjemyR; Mon, 24 Oct 2022 08:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F713400AD;
	Mon, 24 Oct 2022 08:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F713400AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16BA4C0033;
	Mon, 24 Oct 2022 08:44:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0D8BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C05960AE8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C05960AE8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCskc9VT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nfSf3gQm1qaC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C41760634
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C41760634
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666601036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=37cunLzz/xjWAuAYxixh7mVEDXes8SvYGmLQAkvvjj8=;
 b=MCskc9VTfkoJIyCEaC4EyR4v2xfAK+aJLx3dgd+RewmyKW1ilsFs2TyeWXqs62U7walVxQ
 88kTe4gtR8Pj6FWTeoaGtEZxNliN+dvuyQj4FfQmcdrm18/7OydJPdiyof6GgILa/kM9Bv
 +9VfXnNSOy04Ai4hWUTrHiPWHpXFhR0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-489-mcZ5gIQPP5-jnqp75V6lDA-1; Mon, 24 Oct 2022 04:43:54 -0400
X-MC-Unique: mcZ5gIQPP5-jnqp75V6lDA-1
Received: by mail-ot1-f72.google.com with SMTP id
 t3-20020a9d66c3000000b0066198cb63e6so5262702otm.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 01:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=37cunLzz/xjWAuAYxixh7mVEDXes8SvYGmLQAkvvjj8=;
 b=TOuW2IQh/bhjzlcz57J3pzqOGuijLg/uQXs70U1C485fYMxQqSr4pTAy/NGxqQ9Pq6
 1o9JZ60U1bJzhwa9aFyEKwdh8UCzSPgIWmzcV5/XPYLIRFLCCXdVVUoMZtHN8Iy9HKTV
 IpJCKYIncyI4z635Yc9awY6hZzQdqDImpvW7ql2qgGaz72YfTTb+MLATZ2fhzmwm0DLC
 Uoj+ULAVti79+eRKRSSzqe4P+Wgff3XbbGEsIXvF+EYitkpkqeD4jS27Al0qYZ/SjE7k
 U3nyRCW/jNYEYpafVQgq6NNveYtmW55dT8zVbMcn1z0Q6oywyfMr0xc6P6Sr8NqrYAN/
 XP2A==
X-Gm-Message-State: ACrzQf1U0QN13q9i8Px4EhVFQvUPF+OqpCV5uk3K3b07S42xjPxfmOQm
 71szxgZSFeFkZxIww1xa+OLNpzDMYMjPZixoFXYmQytX2Ddox0qzL8B0YZOAXxSrU+AkkfnSR7f
 hkyPdQcbYXLJV9aXmesS7OaNJX5eKBI1QZo/xhrp97RRr2OIP4pxP4NimHQ==
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr29381418oiw.35.1666601033732; 
 Mon, 24 Oct 2022 01:43:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6QOmcnUd5hsVuCK9YTa0H35I4j6OIckxitomGIVwkIozvSpd6Oxb10S0EmlqXL99JCxWV7DfRYCqWBwZ+iStY=
X-Received: by 2002:a05:6808:1483:b0:354:a36e:5b with SMTP id
 e3-20020a056808148300b00354a36e005bmr29381408oiw.35.1666601033493; Mon, 24
 Oct 2022 01:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666392237-4042-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Oct 2022 16:43:40 +0800
Message-ID: <CACGkMEt-TiJ6LQczo4fY_eY9jWdDGVt_ZNXM8Eq3qkbNvLJmUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] vdpa: save vdpa_dev_set_config in struct
 vdpa_device
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> In order to allow live migration orchestration software to export the
> initial set of vdpa attributes with which the device was created, it
> will be useful if the vdpa tool can report the config on demand with
> simple query. This will ease the orchestration software implementation
> so that it doesn't have to keep track of vdpa config change, or have
> to persist vdpa attributes across failure and recovery, in fear of
> being killed due to accidental software error.
>
> This commit attempts to make struct vdpa_device contain the struct
> vdpa_dev_set_config, where all config attributes upon vdpa creation
> are carried over. Which will be used in subsequent commits.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>  include/linux/vdpa.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4..9f519a3 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -58,6 +58,16 @@ struct vdpa_vq_state {
>         };
>  };
>
> +struct vdpa_dev_set_config {
> +       u64 device_features;
> +       struct {
> +               u8 mac[ETH_ALEN];
> +               u16 mtu;
> +               u16 max_vq_pairs;
> +       } net;
> +       u64 mask;
> +};
> +
>  struct vdpa_mgmt_dev;
>
>  /**
> @@ -77,6 +87,8 @@ struct vdpa_vq_state {
>   * @nvqs: maximum number of supported virtqueues
>   * @mdev: management device pointer; caller must setup when registering device as part
>   *       of dev_add() mgmtdev ops callback before invoking _vdpa_register_device().
> + * @init_cfg: initial device config on vdpa creation; useful when instantiating
> + *            device with identical config is needed, e.g. migration.
>   */
>  struct vdpa_device {
>         struct device dev;
> @@ -91,6 +103,7 @@ struct vdpa_device {
>         struct vdpa_mgmt_dev *mdev;
>         unsigned int ngroups;
>         unsigned int nas;
> +       struct vdpa_dev_set_config init_cfg;
>  };
>
>  /**
> @@ -103,16 +116,6 @@ struct vdpa_iova_range {
>         u64 last;
>  };
>
> -struct vdpa_dev_set_config {
> -       u64 device_features;
> -       struct {
> -               u8 mac[ETH_ALEN];
> -               u16 mtu;
> -               u16 max_vq_pairs;
> -       } net;
> -       u64 mask;
> -};
> -
>  /**
>   * Corresponding file area for device memory mapping
>   * @file: vma->vm_file for the mapping
> --
> 1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
