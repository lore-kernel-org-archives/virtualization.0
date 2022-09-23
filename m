Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C325EC6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 05:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3ACB540571;
	Fri, 23 Sep 2022 05:31:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3ACB540571
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FE/SyWqc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nndZ5ylg6grH; Fri, 23 Sep 2022 05:31:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1E304011B;
	Fri, 23 Sep 2022 05:31:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1E304011B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 831C8C0033;
	Fri, 23 Sep 2022 05:31:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31A36C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFA1160C2A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:31:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFA1160C2A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FE/SyWqc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPPtCXC3vght
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:31:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB78460C1C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB78460C1C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663911061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvifYnkLWYO2bXC/7ltG4c70mXOytWC7kpAsk2dhpwc=;
 b=FE/SyWqcRH+zRVtbbOryL2LNgi6g/ovx3Rdk091cfoF3lgkpRsB/SGllu7RFE0OY2S8gTr
 obnX3CsGC7eA3qBZni6/RbHMhj5n2sgn+bvTdUtJ/21PZgH+qHDXATFpaI5LwiOo2RX9H6
 42Stal/oXTjhxO7XsrAI6ivKQmkRNPw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-9oHtslB8OsazwqXgog41ww-1; Fri, 23 Sep 2022 01:30:53 -0400
X-MC-Unique: 9oHtslB8OsazwqXgog41ww-1
Received: by mail-ej1-f71.google.com with SMTP id
 sc14-20020a1709078a0e00b007827a349e0bso886695ejc.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 22:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=pvifYnkLWYO2bXC/7ltG4c70mXOytWC7kpAsk2dhpwc=;
 b=PoTndWRdabsKGy96QtIGoDs46d8j1IfgeNo6TV3qVm5e+xWibgTjN00QQoVibReIOL
 LXHmfFqV1XFDIyT/HVZwDKEZwR39ZJxlOenPm+sRjAhudunhWaBNYtZyEzGMl19Uh+zd
 YrroUoFSQlO2GZ94ehwLWsQBe1UoqYg8WnxmIVAwk+Jho8A8V4ilHkIohRBm90DrouDd
 TIg6PSTLyzB6AOzxMj/nEsp3DpjaONG/meI7AwdL/K2mWI2sXU/HEqar+XH/o2/e0/Zn
 xcjJWOgFZsw9bXlQfdfeyRiI5bmSUK4PbsxV2H/uQeIioZxmhJKJ9apbnaQYu0yF1a46
 H6zw==
X-Gm-Message-State: ACrzQf1euPlNaZuv+FPwYs+7HmRy6ewa1QYKBY92JhgO6zA37hmdQ0bB
 89hpH6xiFAIDG6ov4//1RCRyvoUCI/vtbWZtsJ652laQySPDPUvMsR4YuyHzqNOOrw0Bmk/ocvo
 Uyy9o6Gw47tH7P+IHN6pN5gZhUN2DDu0Y5SjH3Z6oeA==
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id
 wt6-20020a170906ee8600b0074189bc27a1mr5667495ejb.725.1663911051953; 
 Thu, 22 Sep 2022 22:30:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6y/d3W6+kz7xXp65IP+HQK0+lSXFdEI0uodUsgq3seuKMBVeKzW7S9+ssF3wmrJEsJFPtUzA==
X-Received: by 2002:a17:906:ee86:b0:741:89bc:27a1 with SMTP id
 wt6-20020a170906ee8600b0074189bc27a1mr5667486ejb.725.1663911051771; 
 Thu, 22 Sep 2022 22:30:51 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 f19-20020a056402195300b004531b137e4bsm4967406edz.67.2022.09.22.22.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 22:30:51 -0700 (PDT)
Date: Fri, 23 Sep 2022 01:30:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH v3] vdpa/ifcvf: fix the calculation of queuepair
Message-ID: <20220923012834-mutt-send-email-mst@kernel.org>
References: <20220923010356.2084-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20220923010356.2084-1-angus.chen@jaguarmicro.com>
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

On Fri, Sep 23, 2022 at 09:03:56AM +0800, Angus Chen wrote:
> The queuepair should be divided by 2 and
> it should not be hw->nr_vring when multi-queue feature was enabled
> 
> Fixes: 2ddae773c93b ("vDPA/ifcvf: detect and use the onboard number of queues directly")
> 
> changes in v2:
>     - add commitid which to be fixed
>     - no code changes
> 
> changes in v3:
>     - updated commit log with more info, addressing comments by MST
>     - no code changes

Note the changelog should go after -- not before that.
And all tags such as Fixes: and Signed-off-by: be together
without empty lines separating them.

> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

and if code is unchanged then it's acceptable (and preferred) to carry forward
acks from previous versions, such as the one from Zhu Lingshan.
same if code is changed but trivially.

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
