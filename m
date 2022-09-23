Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C00ECAAD8
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 04:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2747960C28;
	Fri, 23 Sep 2022 04:13:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2747960C28
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WicySdiq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hr3QCBc8XGh4; Fri, 23 Sep 2022 04:13:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8510860C23;
	Fri, 23 Sep 2022 04:13:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8510860C23
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58303C0033;
	Fri, 23 Sep 2022 04:13:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68884C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3797A4051B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:13:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3797A4051B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WicySdiq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JoZh0JCw20Il
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:13:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E3A4404F1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E3A4404F1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663906395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mn+NyNmyJQw0IFOEbbtkaPU0D2r4VaVBA2wwXQWRN/I=;
 b=WicySdiq55EXJVfUsMWKxM7VSu32Ic2guVfCoBzv76AalxahJQfgqlO+qUUDkXsAAOfdVp
 Ik3i7t3t0r6M/EwLlGifytaAnvbD+cxplOZV+JM0kV5KkOXGrAFR44xLxCEyQVbg9yYwdh
 ZsWLMzY2P6gxYeEp7/cuTQIAQAWES2g=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-hQaQiHXFPIS1l2WQmompkA-1; Fri, 23 Sep 2022 00:13:06 -0400
X-MC-Unique: hQaQiHXFPIS1l2WQmompkA-1
Received: by mail-ot1-f70.google.com with SMTP id
 v20-20020a9d4e94000000b00656078cd676so5416002otk.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 21:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Mn+NyNmyJQw0IFOEbbtkaPU0D2r4VaVBA2wwXQWRN/I=;
 b=WVR/atIuQdmB7yI058d0K3yZaVQGTBHpkZJh0J1lJCLvkYJ0J1Tyj6Igl7V86isvGI
 DaVE/b/9NH2eQ5pMaAj06zdnOqK9fT7GspOKRtVmy2+SUwtbQsbwmEXN+65GcEfSYju0
 +GSJKH70YAbr51LrasPjVf1DZLOR5SFstCGNtKyFTAr7/88Uvr25hOGvipAiKK/w2CNO
 DnCXsD43WftFz8Wz71pM8melkh6h8Lcl53WJidJwRnpT/smzey87EWNKe3IFjamtcTGV
 5WJcLfWBUrYVztQ1zZpZEz8wxyh1lo8g8CNeYFt4fO2XTuECDn3IAuaQO6mhLq+iBjHz
 PUmQ==
X-Gm-Message-State: ACrzQf3gh5rCHUAgt2hnoLqv4bHb+fTBhfU50B7uOuCWTPHiexSZdBot
 ftBq9G3gm+Go4YUDcGg7r+gf3TsFNAYzkMRP61KA1H/8vmqPTSs0NMerGgGXbbw1mDaJEFygPem
 elfDl9ajrOhBe7UdLwpTyIlFAqabJY7ekuha3YOMi6MYtDmnYJcFrz7eimQ==
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr3058948oiv.280.1663906385914; 
 Thu, 22 Sep 2022 21:13:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6tkZ6XRsQpsQeKRRwObUFnf/RvH958pJCdn3Q9FwqTBNfui4nrqFCeZR7R9w/BUwRYCUg5KgwtQkLhszqJJC4=
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr3058943oiv.280.1663906385741; Thu, 22
 Sep 2022 21:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220922110017.2054-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20220922110017.2054-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Sep 2022 12:12:54 +0800
Message-ID: <CACGkMEv=fJrj_sCiA+zRKd7NXkJsjnbvKyAV88Bw2s_JZeYBqA@mail.gmail.com>
Subject: Re: [PATCH] vDPA/ifcvf: fix the Calculation of queuepair
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

On Thu, Sep 22, 2022 at 7:00 PM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> The queuepair should be divided by 2
> It should not be hw->nr_vring when multi-queue feature was enabled
> fix  commit 2ddae773c93b ("detect and use the onboard number ")
>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

Fixed tags should be placed above SOB. Please refer to how it is done
in other commits or Documentation/process/submitting-patches.rst.

Others look good.

Thanks

> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 75a703b803a2..3e4486bfa0b7 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -323,7 +323,7 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
>         u32 q_pair_id;
>
>         ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> -       q_pair_id = qid / hw->nr_vring;
> +       q_pair_id = qid / 2;
>         avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
>         last_avail_idx = vp_ioread16(avail_idx_addr);
>
> @@ -337,7 +337,7 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
>         u32 q_pair_id;
>
>         ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> -       q_pair_id = qid / hw->nr_vring;
> +       q_pair_id = qid / 2;
>         avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
>         hw->vring[qid].last_avail_idx = num;
>         vp_iowrite16(num, avail_idx_addr);
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
