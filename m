Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C5DC6FA8B
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 09:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5C4141946;
	Thu, 22 Sep 2022 09:06:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5C4141946
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7OIx0kt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MTrcUXCMqL9a; Thu, 22 Sep 2022 09:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E81684195C;
	Thu, 22 Sep 2022 09:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E81684195C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DCD3C0033;
	Thu, 22 Sep 2022 09:06:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84982C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58CA4404EC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58CA4404EC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=e7OIx0kt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rdX01O70DcOq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:06:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 175AE40385
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 175AE40385
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663837598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QpX5+jRQQM4gLhFsY3s1wkRXSP5truCHuQtraY1seBA=;
 b=e7OIx0ktd0Qrmp1/DV0Q9HM3qxtsDxogJULuqryBHjRuWvaqLojg5H+wZjAM+rVipSXJR9
 n66ILR5IdsehI7j0oKn98CvjyLWGK1Rz8uW993EfurVl1p4vENxKVNWEujRrP60bkjBCAj
 0stJ0rKYZFyAnu1b2p7nscZ2+P+e5MA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-464-bx93lyXtOiWativhIguWYw-1; Thu, 22 Sep 2022 05:06:29 -0400
X-MC-Unique: bx93lyXtOiWativhIguWYw-1
Received: by mail-wm1-f71.google.com with SMTP id
 v62-20020a1cac41000000b003b4fca0e80cso1678898wme.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=QpX5+jRQQM4gLhFsY3s1wkRXSP5truCHuQtraY1seBA=;
 b=dHudVZV2lcmxhRergtm+K+k3YIkYsqsDDhPRlUMfImF+eIA0NGrB+DORLvoYaphuki
 8I91UTnC/1HiGfXMeLrLR0g4rYJXHCD5K2ELzH2aVMlhSGqrXojoNAwOFJepkJNlXrnY
 tquBarH+v8fnHrXG7sml130kJxPb4krBCVG4bv6EqNa6OcvZs9DKTalJnYlKV+dS0fnU
 YE4hYmiMvWdw3Oo/MExpnfkzX3i3VS1ZT6sc5mT48peaTvKjYPbowNvStIWtTrQyFrVQ
 gauCUQafPykFoe48S9Ux6oemRAK+SgJQ6D4JYmC36WOAsGRMcZ+YGn8YGAOg37pnRLy4
 XQag==
X-Gm-Message-State: ACrzQf3Jwn/S7jtN9gA0WaSUJk6JCaJai3oLEnvcdnmBPuFBbNJNsA+A
 +R/W6gQnofSE1+1aoEzbxRqpau0xXXKefjTa142yt1QXzh5jCnfA9rg8/g6PxdjaL6/zBb7xa5V
 8jI8dlaDvyYZaRh1FOuBdfN3c/c64BybmouCL0kl7dg==
X-Received: by 2002:adf:d209:0:b0:228:6298:f288 with SMTP id
 j9-20020adfd209000000b002286298f288mr1276710wrh.386.1663837588082; 
 Thu, 22 Sep 2022 02:06:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6aE3Dngp0W4fl0G05LroeRdFZf6Hx0aSaJlH3a8TRIqagcqWtx0X/1mtRiGnwTWfCHRfcGPg==
X-Received: by 2002:adf:d209:0:b0:228:6298:f288 with SMTP id
 j9-20020adfd209000000b002286298f288mr1276686wrh.386.1663837587749; 
 Thu, 22 Sep 2022 02:06:27 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 t126-20020a1c4684000000b003b32aa0fabcsm5136628wma.4.2022.09.22.02.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 02:06:27 -0700 (PDT)
Date: Thu, 22 Sep 2022 05:06:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH]     vDPA/ifcvf: fix the Calculation of queuepair
Message-ID: <20220922050156-mutt-send-email-mst@kernel.org>
References: <TY2PR06MB34246957523C124C501790CD854E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB34246957523C124C501790CD854E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Zhu Lingshan <lingshan.zhu@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Thu, Sep 22, 2022 at 08:55:26AM +0000, Angus Chen wrote:
> >From 4f65eae86ab15d7abb8bd30401187cb195dfd27b Mon Sep 17 00:00:00 2001
> From: "angus.chen" <angus.chen@jaguarmicro.com>
> Date: Thu, 22 Sep 2022 14:47:28 +0800
> Subject: [PATCH]     vDPA/ifcvf: fix the Calculation of queuepair
> 
>         The queuepair should be divided by 2


this is just repeating what the patch does.
can you include more info pls?

Documentation/process/5.Posting.rst says among other things:

To that end, the summary line should describe the effects of and motivation
for the change as well as possible given the one-line constraint.  The
detailed description can then amplify on those topics and provide any
needed additional information.  If the patch fixes a bug, cite the commit
which introduced the bug if possible (and please provide both the commit ID
and the title when citing commits).  If a problem is associated with
specific log or compiler output, include that output to help others
searching for a solution to the same problem.  If the change is meant to
support other changes coming in later patch, say so.  If internal APIs are
changed, detail those changes and how other developers should respond.  In
general, the more you can put yourself into the shoes of everybody who will
be reading your changelog, the better that changelog (and the kernel as a
whole) will be.

 

> Signed-off-by: angus.chen <angus.chen@jaguarmicro.com>

Format should be

Angus Chen <angus.chen@jaguarmicro.com>

Also pls drop leading space.


> ---
> drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
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


Pls CC more widely.
$ ./scripts/get_maintainer.pl -f drivers/vdpa/ifcvf/ifcvf_base.c
"Michael S. Tsirkin" <mst@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS,commit_signer:6/6=100%)
Jason Wang <jasowang@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS,commit_signer:1/6=17%)
Zhu Lingshan <lingshan.zhu@intel.com> (commit_signer:5/6=83%,authored:5/6=83%,added_lines:102/102=100%,removed_lines:108/109=99%)
Stefano Garzarella <sgarzare@redhat.com> (commit_signer:1/6=17%)
Tom Rix <trix@redhat.com> (commit_signer:1/6=17%)
Colin Ian King <colin.king@intel.com> (authored:1/6=17%)
virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND NET DRIVERS)

Thanks!

BTW, Zhu Lingshan, would you like to be listed a patch reviewer in
MAINTAINERS so people rememeber to CC you? You are working a lot on this
driver.



> --

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
