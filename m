Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1213C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 04:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 754B9417AF;
	Wed, 27 Apr 2022 04:23:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id seieH0UK9ZKN; Wed, 27 Apr 2022 04:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C64A3417AA;
	Wed, 27 Apr 2022 04:22:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C5ACC0032;
	Wed, 27 Apr 2022 04:22:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7A1AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A168060E5E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aLCGDKzIyuVW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:22:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE16460E38
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 04:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651033374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKatoHCuChnV5P++UEo+XINquKqFQYRhvvehVy2DaeI=;
 b=W9Z6OVyJhmyrOywb/VfM8wuW7yycgqU0K71xqqZ+4Vj1rTiCmGR+oGKfiVUWA0MVkHBCPv
 g0ZBjimDhwd3dyNJexB1NOfFC3DuqTwXaDIs8M1VmZOHaQLlNry8lCaUVK5eq9cJQmopD8
 FfPFRW36buGcN1BhdN8g9Fwb/csOgCM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-a85HH-9ePUKo15xpRpHDJw-1; Wed, 27 Apr 2022 00:22:53 -0400
X-MC-Unique: a85HH-9ePUKo15xpRpHDJw-1
Received: by mail-lj1-f198.google.com with SMTP id
 v1-20020a2e2f01000000b0024da499933dso282286ljv.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 21:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yKatoHCuChnV5P++UEo+XINquKqFQYRhvvehVy2DaeI=;
 b=S9AqmS+pPpHHi1QSaIPHkIaQaO6r09sH+yediQ9akw3GxNS49Byl1Mh749k4p775nc
 C3EE/sB8WB8TEbwvlVzZgNdoFVsIap4l1UYoBtuoooexvdfcKRw2c5IFAUIjf8T95FpJ
 ZpBMqritZuPQpFaJ7txEtI8/MmGAaB0JgkPriENvvu6hCcrW9gzLZ84qASr5Rs+fkOpK
 dzYOcUh+zVpyGgyLsiHbv1hHWyy+Aj67z+Nu2GHv8vjgAWAht+sD3BCkHIQwkI9yj+3Q
 L5rOtj6Wb3fmEzLmu4d47AbOJg3djdNtlTuRLecgIMifnEQyJ1RDKyPXw1KF/506n9xd
 SkYw==
X-Gm-Message-State: AOAM531I4hvr6DnX46xNw+nIfWVynpJ02olhF+Bbyb2QYSmZIl5rPqi9
 y37rc8ykC42X6ouWKdAF9txUTq6T5xR6+K4PL3Gj7TupzhPvQBaq3kKFCcR9FuB1u1xrCd00LJP
 7LGXr4aMacEmqEb3lwExguQtDYaF3uroqcvtXznR5zVDpP3ilIZnDxx33dA==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr18857947lfv.257.1651033371625; 
 Tue, 26 Apr 2022 21:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoKiZRBjrtWpC+KrgtfMsl6pwDB0owXqJM3JzrerMHXaOMCp70SA4MM483v59xZhvDer9Z/U2i7rLMSft14EI=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr18857939lfv.257.1651033371435; Tue, 26
 Apr 2022 21:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220424072806.1083189-1-lingshan.zhu@intel.com>
In-Reply-To: <20220424072806.1083189-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Apr 2022 12:22:40 +0800
Message-ID: <CACGkMEts+u6gnm1hsT=vhgiHE5CiYns4mydTtnr3LkZMJEzVGA@mail.gmail.com>
Subject: Re: [PATCH] vDPA/ifcvf: fix uninitialized config_vector warning
To: Zhu Lingshan <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, mst <mst@redhat.com>
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

On Sun, Apr 24, 2022 at 3:36 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> Static checkers are not informed that config_vector is controlled
> by vf->msix_vector_status, which can only be
> MSIX_VECTOR_SHARED_VQ_AND_CONFIG, MSIX_VECTOR_SHARED_VQ_AND_CONFIG
> and MSIX_VECTOR_DEV_SHARED.
>
> This commit uses an "if...elseif...else" code block to tell the
> checkers that it is a complete set, and config_vector can be
> initialized anyway
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 4366320fb68d..9172905fc7ae 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -290,16 +290,16 @@ static int ifcvf_request_config_irq(struct ifcvf_adapter *adapter)
>         struct ifcvf_hw *vf = &adapter->vf;
>         int config_vector, ret;
>
> -       if (vf->msix_vector_status == MSIX_VECTOR_DEV_SHARED)
> -               return 0;
> -
>         if (vf->msix_vector_status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
> -               /* vector 0 ~ vf->nr_vring for vqs, num vf->nr_vring vector for config interrupt */
>                 config_vector = vf->nr_vring;
> -
> -       if (vf->msix_vector_status ==  MSIX_VECTOR_SHARED_VQ_AND_CONFIG)
> +       else if (vf->msix_vector_status ==  MSIX_VECTOR_SHARED_VQ_AND_CONFIG)
>                 /* vector 0 for vqs and 1 for config interrupt */
>                 config_vector = 1;
> +       else if (vf->msix_vector_status == MSIX_VECTOR_DEV_SHARED)
> +               /* re-use the vqs vector */
> +               return 0;
> +       else
> +               return -EINVAL;
>
>         snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
>                  pci_name(pdev));
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
