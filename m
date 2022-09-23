Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592FFECAAD8
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 04:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBD344174E;
	Fri, 23 Sep 2022 04:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBD344174E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8k8jRSX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmcYAeBwtmHK; Fri, 23 Sep 2022 04:10:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1277B416B4;
	Fri, 23 Sep 2022 04:10:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1277B416B4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCD91C0033;
	Fri, 23 Sep 2022 04:10:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7191DC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FDE6404F1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:10:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FDE6404F1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=C8k8jRSX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRh9B4JQl2Po
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:10:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9189040185
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9189040185
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663906212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMXdjZ1KChOL3DavUbR7ZamTi59OU0WQ5y3GCtlqYWk=;
 b=C8k8jRSXb4g2aUJQfDQK7x5+Eo5/i/unOnrLkjVVKd1IYFY0RITpUmHW0z0TjF638+WAJB
 TrX1ur8e2jSK0Fjt3MdEoOrsm1gsAHcimK4fYQDVve8SLlzbdG49ViFjgRTqXMld0/WMnw
 V9HzXe7Qs+03P/jhJD6Hbf52K/x6Cmc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-R1Peh2Y_NtKEH3f4lgheAg-1; Fri, 23 Sep 2022 00:10:11 -0400
X-MC-Unique: R1Peh2Y_NtKEH3f4lgheAg-1
Received: by mail-ot1-f70.google.com with SMTP id
 61-20020a9d0843000000b0065bed802a93so980771oty.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 21:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=iMXdjZ1KChOL3DavUbR7ZamTi59OU0WQ5y3GCtlqYWk=;
 b=Y/8UGmBgQ7koV9OwgTvdyGXu3fglvBs2SpMziO/8DjribUnhHONXsD3lBr0RE2CKvq
 UJGol4pG3BMflaV2PW8ozTenVKyONXe4V+jWHRx1V068Pjs3Y/7QIXyyKGDVXomR9g1J
 /lnU8EmTf0SxqlHDxuO4e1tEcy7k9c1OgScsGRhmX13qLnhGUiU7mcW33oh9qKe/fZhC
 KUfNy+oNtqNNXELE4OidOcQT31BIXa3y2xxQP7bJzLRpyO4gbfcBIFJileDX37InK1B6
 VIbGt1AH1rqpKQFyejz7kBOtD98uqMhSxFtDzIDLTuY1CZgdtqEoDP5KFgTil8GqoZQJ
 GRYw==
X-Gm-Message-State: ACrzQf1jebL+EryZ5MeXDgjPa1jq0wHGsSmYKfCXTLs4dtom2ycmlkqS
 2Os371drWVRFZ79Vllfc8ViQBcZKR14YQP4/XOjj5taQ3fp5x0bwWyBMNfPrqcw9LWb1a4VhNHI
 YmzxAQPuoJs9bJRDBCCzSrDFrb+VCwEvegNMFg19ih944LCxdzPRm17+2+Q==
X-Received: by 2002:a05:6830:1550:b0:659:68f7:492b with SMTP id
 l16-20020a056830155000b0065968f7492bmr3148423otp.237.1663906210553; 
 Thu, 22 Sep 2022 21:10:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5i9RoeqJ6jrEsU8zOFR5b2t36LKCRNF/bbCLV1uvgQVS5mtiTUR/pC4+U8NxOMzRo4MhTIV3bYRtazkQle3S4=
X-Received: by 2002:a05:6830:1550:b0:659:68f7:492b with SMTP id
 l16-20020a056830155000b0065968f7492bmr3148412otp.237.1663906210370; Thu, 22
 Sep 2022 21:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220923035228.2145-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20220923035228.2145-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Sep 2022 12:09:59 +0800
Message-ID: <CACGkMEvuJTiPZa9XZwrv-Cbj-E1ZW+eFD8AWrz0Ww_pqpgECiQ@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa/ifcvf: avoid waste ioremap area of vdpa hot
 migration
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Fri, Sep 23, 2022 at 11:53 AM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> The array capacity should be queuepair,

If this is true, we need a better name for the ifcvf_vring_lm_cfg structure.

Thanks

> and the queuepairs should
> be half of IFCVF_MAX_QUEUES without control queue,
> or should be (IFCVF_MAX_QUEUES+1)/2 with the control queue.
> So the definition of ifcvf_lm_cfg waste some memory,
> and it will waste some ioremap area also.
>
> Fixes: 2ddae773c93b ("vDPA/ifcvf: detect and use the onboard number of queues directly")
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> index f5563f665cc6..563c04f9b7ac 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> @@ -104,7 +104,7 @@ struct ifcvf_vring_lm_cfg {
>
>  struct ifcvf_lm_cfg {
>         u8 reserved[IFCVF_LM_RING_STATE_OFFSET];
> -       struct ifcvf_vring_lm_cfg vring_lm_cfg[IFCVF_MAX_QUEUES];
> +       struct ifcvf_vring_lm_cfg vring_lm_cfg[(IFCVF_MAX_QUEUES+1)/2];
>  };
>
>  struct ifcvf_vdpa_mgmt_dev {
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
