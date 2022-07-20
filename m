Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5619C43334
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EE0C6106E;
	Wed, 20 Jul 2022 06:03:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EE0C6106E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J6cBw3mZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TneRpQaU-piB; Wed, 20 Jul 2022 06:03:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5E1760D5A;
	Wed, 20 Jul 2022 06:03:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5E1760D5A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D8DBC0033;
	Wed, 20 Jul 2022 06:03:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE37C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 06:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD33C61006
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 06:03:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD33C61006
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lgpf4vBXl-2q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 06:03:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1283A60D5A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1283A60D5A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 06:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658296981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5qSlOOqa9pjYDS1sew6GhfkwCDtmx0x/6i+h3cZ9Bmk=;
 b=J6cBw3mZogdbp+iKODvVuwuZn+gSSjdwzCmynn8sHRpRQwCYC/A/s47ggpFAlAo09+TwEA
 Tm/bZQKm6NPG2dKLSs5VdNnEfebP+drmCLnEYbnM6kKDndYKSgrHSfeiW15EO2UFxy5oJq
 sdgZfU8nt0g5W1RAHC+qcJIMWNDHMEM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-TVuR5YZhPx-KyQ1nFXUAkA-1; Wed, 20 Jul 2022 02:02:54 -0400
X-MC-Unique: TVuR5YZhPx-KyQ1nFXUAkA-1
Received: by mail-lj1-f198.google.com with SMTP id
 v24-20020a2e9258000000b0025dd6cdd737so81290ljg.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 23:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5qSlOOqa9pjYDS1sew6GhfkwCDtmx0x/6i+h3cZ9Bmk=;
 b=pwe0MNcsFkscA8YBn5uLMtDUz546237zQk96mstew8BZtmTKD+4w64pAhTOJnOIKXT
 qhK6w4syHxnzqHWlmsDzQo3zZ6Vumz2kfaUFEzgpayV4Ru1yhGe0dQ3jpl/eiDZnYOIB
 NbRlS2C0NNHtaOY6cfG+unsJbtb3a/pi9B93ffLOZr4pLH+CoKIgAWPmETBSRwxwMnq+
 Yn5YJXFYTq+HY8xGqvUVASnE5szcRTiGs13Xkg/AsSKR/L1504GT7gmQPwRJy1Q7HFqB
 QCp7omiv8QXnChwmlygDtW5MxTDgxga9WnmQkTep0lFTeiWZIHIzGiase5yNaAK9z7mi
 MdjQ==
X-Gm-Message-State: AJIora/7StY9clPGFmdVlPg3sBr68yjnMPgkvd6RmQrp2uQhzsG+n+ca
 7trbLrJEGO9whof04+TFoJ3iM/xfENkmolPReImznWzzj7TYqK/xJxNdCGsma+f4ZN+S0k2flJh
 O0qROgMj1aMazNO5+Th8ZTFREqUoI8hCd3rj+v+a7YbDv68AHO21ArPsokA==
X-Received: by 2002:a2e:1451:0:b0:25d:7899:eddc with SMTP id
 17-20020a2e1451000000b0025d7899eddcmr15522170lju.251.1658296971817; 
 Tue, 19 Jul 2022 23:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCT3a+QjzGD1xM3FZeEHdTLeQ5Zd53UwxVpJR1nmyG+13WdVT95LePIzIgq7ki9IQVh+FaiaxUX+Nhr6op0l0=
X-Received: by 2002:a2e:1451:0:b0:25d:7899:eddc with SMTP id
 17-20020a2e1451000000b0025d7899eddcmr15522161lju.251.1658296971533; Tue, 19
 Jul 2022 23:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044144.90-1-xieyongji@bytedance.com>
 <20220720044144.90-2-xieyongji@bytedance.com>
In-Reply-To: <20220720044144.90-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Jul 2022 14:02:40 +0800
Message-ID: <CACGkMEsx1QAkK0UHSmzj0=sm_RwY0PiG02gZa-Mff_Wsf022yQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] vduse: Remove unnecessary spin lock protection
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, songmuchun@bytedance.com
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

On Wed, Jul 20, 2022 at 12:42 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Now we use domain->iotlb_lock to protect two different
> variables: domain->bounce_maps->bounce_page and
> domain->iotlb. But for domain->bounce_maps->bounce_page,
> we actually don't need any synchronization between
> vduse_domain_get_bounce_page() and vduse_domain_free_bounce_pages()
> since vduse_domain_get_bounce_page() will only be called in
> page fault handler and vduse_domain_free_bounce_pages() will
> be called during file release.
>
> So let's remove the unnecessary spin lock protection in
> vduse_domain_get_bounce_page(). Then the usage of
> domain->iotlb_lock could be more clear: the lock will be
> only used to protect the domain->iotlb.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 6daa3978d290..bca1f0b8850c 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -211,17 +211,14 @@ static struct page *
>  vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
>  {
>         struct vduse_bounce_map *map;
> -       struct page *page = NULL;
> +       struct page *page;
>
> -       spin_lock(&domain->iotlb_lock);
>         map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>         if (!map->bounce_page)
> -               goto out;
> +               return NULL;
>
>         page = map->bounce_page;
>         get_page(page);
> -out:
> -       spin_unlock(&domain->iotlb_lock);
>
>         return page;
>  }
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
