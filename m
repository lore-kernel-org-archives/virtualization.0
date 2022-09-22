Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855B3C6FA86
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 10:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0A0E83295;
	Thu, 22 Sep 2022 10:17:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0A0E83295
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpcgeBXE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jK9dYVtjcHdW; Thu, 22 Sep 2022 10:17:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 79D63831E3;
	Thu, 22 Sep 2022 10:17:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79D63831E3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F482C0033;
	Thu, 22 Sep 2022 10:17:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4EFDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A28EB831E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:17:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A28EB831E3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TIKK2Fl2uOLg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 650B983295
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 650B983295
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663841864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xYAWMYtKx14XpEbuo541IBKVUWrXtl8A3POq2pvQ/fo=;
 b=SpcgeBXER1t5Ak+gHeHzPeseysOMunIGFxL3mu6hjY3K03FX7OX4QnWy68ppOmpr1U+oZf
 iNw49zmPK067ngnTylZIZ20b897gORE1hvp0KgL+yJskrRSgxKku8CWf0LTp7Wbbr8Lxvt
 SX3dSiEi0lB9CUNgav/eROVCE4eEkIU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-MZu-F2p2NFmxl9SLwnYrPQ-1; Thu, 22 Sep 2022 06:17:41 -0400
X-MC-Unique: MZu-F2p2NFmxl9SLwnYrPQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 z16-20020a05640235d000b0045485e4a5e0so5312578edc.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 03:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=xYAWMYtKx14XpEbuo541IBKVUWrXtl8A3POq2pvQ/fo=;
 b=0tUEPTXJxLurO6JDgzf/+Fi8G9+4m/wLAwcGitB2ISOIk7JE6sosVyIzDBNEzbrVcC
 3P1CUEPSa9CdTB/Jao2q3d6eUr/QccVZQWztIGmGx6kCx4tnHyfDe+yXhdDjj6Bd+91R
 Cd8ZRgHPMxW2jEk7/5WEgQU2r4yxF3cgD/pJBQLHj0zUVk+vGv6m9djz4mYLzPnYr8Q6
 aah7bv+Bf91U/sxoadweTAtqCEb+AgCPT1JMQgSayi9kAJtSs9ZQvIW+1Uqy2GJhiceP
 8dIxxhaz45SnUZGJibiGBg9CpuI/IfRmGz4nEFPK5bWOLNqZpNIxCrK7hIEQwaB36nTR
 apsQ==
X-Gm-Message-State: ACrzQf32KMWEugqTe9EqB1f6+CzcPOVbU6xbB7fvl2PUf1ZWwktNSLJD
 oyLKebFKrYWLmi4tWxjacrEy9SCVWDTa7JbZqLWqI2ajC5VhSFtXWpngUtBHDZyUrmtbSfQWHCd
 IlODieZ+3B4/jmnNyLTDVIs/+uO5rrHl1M+EuMzmkpQ==
X-Received: by 2002:aa7:da4f:0:b0:44e:864b:7a3e with SMTP id
 w15-20020aa7da4f000000b0044e864b7a3emr2536249eds.378.1663841860610; 
 Thu, 22 Sep 2022 03:17:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4IrF5jltUfakAQ+x2COJ0LsEwbx1jBLmLGhIJbY/qTe0ZLCp+tl1BIRRQ+zdkvBQttGPj7PA==
X-Received: by 2002:aa7:da4f:0:b0:44e:864b:7a3e with SMTP id
 w15-20020aa7da4f000000b0044e864b7a3emr2536238eds.378.1663841860421; 
 Thu, 22 Sep 2022 03:17:40 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 f14-20020a17090631ce00b0074ae59d85a4sm2479994ejf.20.2022.09.22.03.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 03:17:39 -0700 (PDT)
Date: Thu, 22 Sep 2022 06:17:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH] vDPA/ifcvf: fix the Calculation of queuepair
Message-ID: <20220922061655-mutt-send-email-mst@kernel.org>
References: <TY2PR06MB34246957523C124C501790CD854E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20220922050156-mutt-send-email-mst@kernel.org>
 <33788b06-6c12-a9e3-4ae3-c817c0842bd3@intel.com>
MIME-Version: 1.0
In-Reply-To: <33788b06-6c12-a9e3-4ae3-c817c0842bd3@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Angus Chen <angus.chen@jaguarmicro.com>
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

On Thu, Sep 22, 2022 at 06:07:58PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/22/2022 5:06 PM, Michael S. Tsirkin wrote:
> > On Thu, Sep 22, 2022 at 08:55:26AM +0000, Angus Chen wrote:
> > > >From 4f65eae86ab15d7abb8bd30401187cb195dfd27b Mon Sep 17 00:00:00 2001
> > > From: "angus.chen" <angus.chen@jaguarmicro.com>
> > > Date: Thu, 22 Sep 2022 14:47:28 +0800
> > > Subject: [PATCH]     vDPA/ifcvf: fix the Calculation of queuepair
> > > 
> > >          The queuepair should be divided by 2
> > 
> > this is just repeating what the patch does.
> > can you include more info pls?
> > 
> > Documentation/process/5.Posting.rst says among other things:
> > 
> > To that end, the summary line should describe the effects of and motivation
> > for the change as well as possible given the one-line constraint.  The
> > detailed description can then amplify on those topics and provide any
> > needed additional information.  If the patch fixes a bug, cite the commit
> > which introduced the bug if possible (and please provide both the commit ID
> > and the title when citing commits).  If a problem is associated with
> > specific log or compiler output, include that output to help others
> > searching for a solution to the same problem.  If the change is meant to
> > support other changes coming in later patch, say so.  If internal APIs are
> > changed, detail those changes and how other developers should respond.  In
> > general, the more you can put yourself into the shoes of everybody who will
> > be reading your changelog, the better that changelog (and the kernel as a
> > whole) will be.
> > 
> > 
> > > Signed-off-by: angus.chen <angus.chen@jaguarmicro.com>
> > Format should be
> > 
> > Angus Chen <angus.chen@jaguarmicro.com>
> > 
> > Also pls drop leading space.
> > 
> > 
> > > ---
> > > drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> > > index 75a703b803a2..3e4486bfa0b7 100644
> > > --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> > > +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> > > @@ -323,7 +323,7 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
> > >          u32 q_pair_id;
> > > 
> > >          ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> > > -       q_pair_id = qid / hw->nr_vring;
> > > +       q_pair_id = qid / 2;
> Yes, this should be 2 and actually this cap never work as expected, we are
> re-designing this.

Do you ack this patch then?

> > >          avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> > >          last_avail_idx = vp_ioread16(avail_idx_addr);
> > > 
> > > @@ -337,7 +337,7 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
> > >          u32 q_pair_id;
> > > 
> > >          ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> > > -       q_pair_id = qid / hw->nr_vring;
> > > +       q_pair_id = qid / 2;
> > >          avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> > >          hw->vring[qid].last_avail_idx = num;
> > >          vp_iowrite16(num, avail_idx_addr);
> > 
> > Pls CC more widely.
> > $ ./scripts/get_maintainer.pl -f drivers/vdpa/ifcvf/ifcvf_base.c
> > "Michael S. Tsirkin" <mst@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS,commit_signer:6/6=100%)
> > Jason Wang <jasowang@redhat.com> (maintainer:VIRTIO CORE AND NET DRIVERS,commit_signer:1/6=17%)
> > Zhu Lingshan <lingshan.zhu@intel.com> (commit_signer:5/6=83%,authored:5/6=83%,added_lines:102/102=100%,removed_lines:108/109=99%)
> > Stefano Garzarella <sgarzare@redhat.com> (commit_signer:1/6=17%)
> > Tom Rix <trix@redhat.com> (commit_signer:1/6=17%)
> > Colin Ian King <colin.king@intel.com> (authored:1/6=17%)
> > virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND NET DRIVERS)
> > 
> > Thanks!
> > 
> > BTW, Zhu Lingshan, would you like to be listed a patch reviewer in
> > MAINTAINERS so people rememeber to CC you? You are working a lot on this
> > driver.
> sure, please add me in the list.
> 
> Thanks
> Zhu Lingshan
> > 
> > 
> > 
> > > --

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
