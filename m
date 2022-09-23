Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEF7C6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 10:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61E3F408EA;
	Fri, 23 Sep 2022 10:40:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61E3F408EA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hqhyi+Sz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUeepMdKpUBC; Fri, 23 Sep 2022 10:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E5D5C40906;
	Fri, 23 Sep 2022 10:40:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5D5C40906
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A53FEC0033;
	Fri, 23 Sep 2022 10:40:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8914C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 10:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C389160D9C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 10:40:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C389160D9C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hqhyi+Sz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HSwItbsDxoHJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 10:40:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96A3460D75
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96A3460D75
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663929604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xMAKGkj7Yax6y0yOMS9ZFwgWcguV4qPckJ0Do1V9zs=;
 b=hqhyi+SzgAAK6szbE0ujNlENhxPl5AO32ju8hW0k+X7ZvB8/O69uInnhbbo9h7HtN5OYhc
 3rkx7ObmFFh2jXAH99Yxdr/UneS9ngaZHnMeHrzqHY+0XhOLkVXCjiDt+3EbtVYTp1XCdK
 AL0Tp6Nr5Id28Jn5ot6/PqbpJK3m1gA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-sWkTKkAbPeCabdtA2prAWA-1; Fri, 23 Sep 2022 06:40:03 -0400
X-MC-Unique: sWkTKkAbPeCabdtA2prAWA-1
Received: by mail-wm1-f72.google.com with SMTP id
 h133-20020a1c218b000000b003b3263d477eso5362850wmh.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 03:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=4xMAKGkj7Yax6y0yOMS9ZFwgWcguV4qPckJ0Do1V9zs=;
 b=ul2APNohYRA0lzxYwWFWLswgrydm85JxdZnFq4vsRgHek8X/QDhUi4IWdeIkgLBh7Y
 N0uJiLLomdk9nWxOw4rRFnBox2pRae1nH1H+VGEaXBt3WVOl3u1JMFzrK3LM3wwIQu/c
 OEJj88QUCAyy7iHvnNw+ub3jVQq79rUKiI0ba35MRwTpGNLc09xrMaWtOTuSjbtw15+n
 5kzfjJEOs8s6wUxt0fT1vkzqQl/pMN3b06fi8ZLhbhuEwiydAZg6DDu7GtpwgKclDHAX
 HSRVGlzdHNaFSjHtTyurY7Xva+xj+g46AdSVHP6Af4HRSoxwhgpJkEXterktUhrD+wHs
 /jdA==
X-Gm-Message-State: ACrzQf2VhoSW+ADEevy1wALH/AlMLbG/zug/YjiXda4Y25rGFYGNfonP
 cqNXKuTR7Mc6HT02NaI8gBKFZ4OEBnsd5ubJ+kZjWMrolny3kL/OutEcayGxyzV2lmN3hb2rYxd
 irX0lL1zZeiPT6MCkR3hd2vSJlB7HOTp3/rWZpgWwsw==
X-Received: by 2002:a05:600c:2608:b0:3b4:8dac:342a with SMTP id
 h8-20020a05600c260800b003b48dac342amr5338714wma.102.1663929602074; 
 Fri, 23 Sep 2022 03:40:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7O3KnOukAwnQRAMxP1XtnPJZ/hfcq51rgU+jgOMfGZZWnKsBltfCDtppPt8SHphkYJHUaipg==
X-Received: by 2002:a05:600c:2608:b0:3b4:8dac:342a with SMTP id
 h8-20020a05600c260800b003b48dac342amr5338694wma.102.1663929601852; 
 Fri, 23 Sep 2022 03:40:01 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 ba30-20020a0560001c1e00b00228655a5c8fsm6982557wrb.28.2022.09.23.03.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Sep 2022 03:40:01 -0700 (PDT)
Date: Fri, 23 Sep 2022 06:39:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH v5] vdpa/ifcvf: fix the calculation of queuepair
Message-ID: <20220923063643-mutt-send-email-mst@kernel.org>
References: <20220923091218.209-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20220923091218.209-1-angus.chen@jaguarmicro.com>
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

On Fri, Sep 23, 2022 at 05:12:18PM +0800, Angus Chen wrote:
> The q_pair_id to address a queue pair in the lm bar should be
> calculated by queue_id / 2 rather than queue_id / nr_vring.
> 
> changes in v2:
> 	- add commitid which to be fixed
> 	- Acked by Zhu Lingshan <lingshan.zhu@intel.com>
> 	- no code changes
> 
> changes in v3:
> 	- updated commit log with more info, addressing comments by MST
> 	- no code changes
> 
> changes in v4:
> 	- updated commit log with Correct syntax, addressing comments by
> 	- Zhu,Lingsha and MST and Jason Wang <jasowang@redhat.com>
> 	- no code changes
> 
> changes in v5:
> 	- add Acked and reviewed log of community

changelog after --- pls. if you want to keep changelog in git,
you add it in a note in git, not in commit log.

I can fix that no need to repost.

> Fixes: 2ddae773c93b ("vDPA/ifcvf: detect and use the onboard number of queues directly")
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
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
