Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18A1C6FA82
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 11:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 726A44038E;
	Thu, 22 Sep 2022 11:43:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 726A44038E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U4wHSpTL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5GqwPvdGOtl; Thu, 22 Sep 2022 11:43:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E631D40121;
	Thu, 22 Sep 2022 11:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E631D40121
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9627C0033;
	Thu, 22 Sep 2022 11:43:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BB65C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 11:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAE0941525
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 11:43:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAE0941525
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U4wHSpTL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HWgUQiCDd-WH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 11:43:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C289641507
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C289641507
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663847026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fCLumkiNy7g9hgchWen2TN3wKn0Cpbdq3VQkTU+S+PM=;
 b=U4wHSpTLjs5erMD5K73W6ImcZlzcAlI4Q5UsrjcEcVsXXN5XaNvI1s706mAtlgZ8qzjhJQ
 Md0dbWKyNt7FMda2gSoSINy/M39R79dpvWbc0Vkvz3adn7RwbK0lral7KR0alvS8tkJTMs
 lA33X2QHlC5sIYRLbtsSs1O4U1QCIdo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-156-HICDpptPP0enZdffgPI_rg-1; Thu, 22 Sep 2022 07:43:45 -0400
X-MC-Unique: HICDpptPP0enZdffgPI_rg-1
Received: by mail-wr1-f69.google.com with SMTP id
 m29-20020adfa3dd000000b00224f577fad1so3161130wrb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 04:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=fCLumkiNy7g9hgchWen2TN3wKn0Cpbdq3VQkTU+S+PM=;
 b=C67tKRKi19eWjgcgb8pjurYsaNUcHHFJLR1bv9aMgvyDbwbs3vHivbxLPuh5MS5jaP
 q8vvhRU1Hj/e79sYSO8kcYOPfXESCpyNxFilCxDGJd7DiRedkLouBnDiNWZta+r58PZN
 0hQENsMPRCvReQv8/c8svqKWQYuxUhxsIHpZmdjECLlNLZLCb6MaZqQgu2L+1Um/UjgD
 yohAPwE9RaA8MSvo65OU49SLMXU4bx8ud1vcyEW0lkYCQgDowMOofNeNCPokeQnPnQ8l
 Gs2EvnUo5AhuXMBEu5NWV/UMEgmXQ+XJKrk1phnqj5nxicT6rltbovxIVs0MUdDHa+CW
 YoeA==
X-Gm-Message-State: ACrzQf0J6LPgIG/a/HbZUisGHDN/oAg2pvgzTSg686f5nbgOSdceWIdB
 D71/HojL5CIYl3EvugjjnSTiuLpLOVUVi5qTHRLKyM1SfWbPh+VTlwa6y1p3jhO3xyyY+yC8E3f
 QjtcX3R6SoAm44Nybn8Z8jatFz8GQvUUCAWk+MTuCxA==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id
 i1-20020a5d5581000000b0020ffc517754mr1840743wrv.413.1663847024276; 
 Thu, 22 Sep 2022 04:43:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66R6qEXiuR4DP+a4M4bl8sNUr2Jnt+K2xpT7kKcsHMsCsMvMW/QL4afJ7Ddl9qw0I7r02tng==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id
 i1-20020a5d5581000000b0020ffc517754mr1840720wrv.413.1663847024062; 
 Thu, 22 Sep 2022 04:43:44 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 e18-20020a05600c4b9200b003b486027c8asm5369787wmp.20.2022.09.22.04.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 04:43:42 -0700 (PDT)
Date: Thu, 22 Sep 2022 07:43:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] vDPA/ifcvf: fix the Calculation of queuepair
Message-ID: <20220922073959-mutt-send-email-mst@kernel.org>
References: <20220922110017.2054-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20220922110017.2054-1-angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lingshan.zhu@intel.com, virtualization@lists.linux-foundation.org
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

Thanks! Let's see if we get an ack.
Minor things for the future (in case a new version will be needed):


Subject should include the patch version. Also pls avoid
capital letters in the middle of the sentence. E.g.

[PATCH v3] vDPA/ifcvf: fix the calculation of queuepair


On Thu, Sep 22, 2022 at 07:00:17PM +0800, Angus Chen wrote:
> The queuepair should be divided by 2
> It should not be hw->nr_vring when multi-queue feature was enabled
> fix  commit 2ddae773c93b ("detect and use the onboard number ")

An extra " " here at the end.

It's also a good idea to add:

Fixes: 2ddae773c93b ("detect and use the onboard number")

> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>


> ---

A good thing to add here is a changelog.
In this case the patch is unchanged, so you would write:

changes in v2:
- updated commit log with more info, addressing comments by MST
- no code changes


add more versions to this as you are revising the patch.


>  drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 75a703b803a2..3e4486bfa0b7 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -323,7 +323,7 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
>  	u32 q_pair_id;
>  
>  	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> -	q_pair_id = qid / hw->nr_vring;
> +	q_pair_id = qid / 2;
>  	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
>  	last_avail_idx = vp_ioread16(avail_idx_addr);
>  
> @@ -337,7 +337,7 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
>  	u32 q_pair_id;
>  
>  	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> -	q_pair_id = qid / hw->nr_vring;
> +	q_pair_id = qid / 2;
>  	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
>  	hw->vring[qid].last_avail_idx = num;
>  	vp_iowrite16(num, avail_idx_addr);
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
