Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D80C433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 02:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B86264288B;
	Wed, 12 Jan 2022 02:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id md1GXh4uX-sG; Wed, 12 Jan 2022 02:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 741AB42886;
	Wed, 12 Jan 2022 02:34:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ABC4C002F;
	Wed, 12 Jan 2022 02:34:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91852C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E72540937
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:34:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GKmo8QHnU3A8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:34:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F85F40924
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641954892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJ7Tqm/ydIVHzOTArHLGWyexjU4+EfM8kItXP8w0p4E=;
 b=TjvVe7qzy7S7GCcFspwzJ1n8BfaIui4MHkEOLFkAB98N2q76FHvID+5yFUJ/yEO+BQM0YN
 xsqIOJcRFLKR4BebI+FGjBbJ8BKV1WWTPtayi0o+duzGjpCAlUluqVIojdMZkOxGvSOTu0
 rInFkODWY+xspMdxI5pnHajxBWtKRiw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-Qn8TxoaCP0m5DGD0KOwrXQ-1; Tue, 11 Jan 2022 21:34:51 -0500
X-MC-Unique: Qn8TxoaCP0m5DGD0KOwrXQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 d25-20020a194f19000000b0042b469bd916so620670lfb.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 18:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rJ7Tqm/ydIVHzOTArHLGWyexjU4+EfM8kItXP8w0p4E=;
 b=VKzcTYZ52YvBmKronFF67k69i+FM7w7TxK8VyBTby1AwKi+X3ewp6VKbxvxi4NAxAl
 7y2uRl6pSM2pZWbd3slJSJzog7TwxWLMw09Vq7ptVwimTC+cleTTwltXGVKlqbKf95Ut
 kpTB/sRpbq5iewUG0Bh/lFnJ+fF2HAEdqZo2znqLWJHQ700G7adLQcCTxNIIpSYYHevQ
 TR+M5WGoACjvnrEbdv+PlbuBm6ADpAl2KfGnsody0hS5M89Wph/MorfIqJ5ExUxDslxe
 M7Fej1acSy44I8aq+UHdc9C0P2R/ZgZ7I3Fy9I3cq/buacNVHC/kPkcNDWxlebFWnYXE
 vang==
X-Gm-Message-State: AOAM532/iMEaFgd7vcomV08dzeYl0WrgFl8DMM1A2U7ZDYLalCOUsCKd
 L6OLoDll+3RnA+w1WtRFk3gsJfzKZjF3nkEElAML+VWRNu+kv/lbX8oxo8BgKVZi+vJwXTU4kpd
 q7U9eNNBrXXN2ZqD9JTjdH+eRtdSZRjJbAKGhhnPwfNtRXO+xwGtaAVM03Q==
X-Received: by 2002:a19:f705:: with SMTP id z5mr5277447lfe.580.1641954890127; 
 Tue, 11 Jan 2022 18:34:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMAx55K4LgWep1Ey6Ohbpnuo9MfAKGuRGWVUgSuAVrLEWOlHNiRGZdkbf5qSaCAih8htiN47TVrkQAVptqpOY=
X-Received: by 2002:a19:f705:: with SMTP id z5mr5277436lfe.580.1641954889952; 
 Tue, 11 Jan 2022 18:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-3-elic@nvidia.com>
In-Reply-To: <20220111183400.38418-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 10:34:39 +0800
Message-ID: <CACGkMEuE7gfDTX+ADNd8DTGvm4Vvypei=CO=0FSqjdGZ1n5Acw@mail.gmail.com>
Subject: Re: [PATCH 2/4] vdpa: Protect vdpa reset with cf_mutex
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Wed, Jan 12, 2022 at 2:34 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Call reset using the wrapper function vdpa_reset() to make sure the
> operation is serialized with cf_mutex.
>
> This comes to protect from the following possible scenario:
>
> vhost_vdpa_set_status() could call the reset op. Since the call is not
> protected by cf_mutex, a netlink thread calling vdpa_dev_config_fill
> could get passed the VIRTIO_CONFIG_S_FEATURES_OK check in
> vdpa_dev_config_fill() and end up reporting wrong features.
>
> Fixes: 5f6e85953d8f ("vdpa: Read device configuration only if FEATURES_OK")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 0ed6cbadb52d..851539807bc9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -178,7 +178,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>                         vhost_vdpa_unsetup_vq_irq(v, i);
>
>         if (status == 0) {
> -               ret = ops->reset(vdpa);
> +               ret = vdpa_reset(vdpa);
>                 if (ret)
>                         return ret;
>         } else
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
