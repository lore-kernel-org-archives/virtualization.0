Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70F6ECAAD8
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 05:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A64A417D8;
	Fri, 23 Sep 2022 05:26:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A64A417D8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MXjrZ6yu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E87DO8sA0sxX; Fri, 23 Sep 2022 05:26:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 23CE0416A5;
	Fri, 23 Sep 2022 05:26:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23CE0416A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4160C0033;
	Fri, 23 Sep 2022 05:26:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 416FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05AA660C24
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:26:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05AA660C24
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=MXjrZ6yu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RRxyba87cOW3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:26:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 392EF60B79
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 392EF60B79
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663910761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZHyNjpH4r8VK/ozK2kV+F9eO6qw2Krmw4g1+JEj2Ug=;
 b=MXjrZ6yuw5mLTdCy6dr/gGHcgfEB9xDhYiuPmnp88p8CRGKy9QoauIGYbGIwPVKYVIJnr1
 xfs0UKpXkPKaLBP0Gg1qlWnPpHdp7B7h2A5Onz3kCBMLsRGD4zTS4q0dYfGbYfRMDWG4ZI
 PVPSx2m7NCvqb72a9PmC7N8evKcCgls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-HbhpuO_uM5-LTkk4WUGfIw-1; Fri, 23 Sep 2022 01:26:00 -0400
X-MC-Unique: HbhpuO_uM5-LTkk4WUGfIw-1
Received: by mail-wr1-f72.google.com with SMTP id
 h20-20020adfaa94000000b0022af8c26b72so3622017wrc.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 22:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=lZHyNjpH4r8VK/ozK2kV+F9eO6qw2Krmw4g1+JEj2Ug=;
 b=Aa7Jkrq/nyOWb4cRYLNKzC3WpVA0Duos/ErF57JFayjQi96wBsLGn+daT1u92X5D1M
 3oEdBy0Hc3F5YPpMv2v09jxNMqlrOUCqNuKPuwe8gh/so0uPo691koZebxe6sk/Yv/Qs
 b0GQMUgJcki/LkuJle+ooS4kqA8GAfnDdSx9OkS/aiyx3/eD1tyUTP1uNujeBd2qQvwb
 BGI7mvTl7sKThLhH1q2n4BKjplBFSQqrE1+nN7ld8h0TRVhFYWQHMT9GKclNMYU0jCIH
 KKsl3/FToaYaq2o/z4m9mESVlnF0ut1n2PIHHEI3zJb6xS3+DXZmu/gzWyTq+RIxzCsp
 9abg==
X-Gm-Message-State: ACrzQf2XfKS10E9BNqlj1jkI1Mw2LFT1HkOS/d+v27KR9d20vdmn79bI
 Uyad4jvHpPeEaB1SyhPqPsvdAvwT0vSIAv9zXGmV2UovVHmQzpr1m7eTvLNj1p9JhO980M0y94p
 ehxd9paAY/TKQWeeZMapJPfK/QJ5ONFIQPWqJHidYQA==
X-Received: by 2002:a05:600c:2188:b0:3b4:9725:7941 with SMTP id
 e8-20020a05600c218800b003b497257941mr11250804wme.175.1663910759771; 
 Thu, 22 Sep 2022 22:25:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4X2tsdlRjZnV7n5mFj9Ybe3MIr6g2hvMU00hWdQuPVozypVvVCvJJJhqlHnn1oPwgSdRKXZQ==
X-Received: by 2002:a05:600c:2188:b0:3b4:9725:7941 with SMTP id
 e8-20020a05600c218800b003b497257941mr11250796wme.175.1663910759500; 
 Thu, 22 Sep 2022 22:25:59 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 h3-20020adffd43000000b0022a2f4fa042sm6606988wrs.103.2022.09.22.22.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 22:25:58 -0700 (PDT)
Date: Fri, 23 Sep 2022 01:25:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] vDPA/ifcvf: fix the
 Calculation of queuepair
Message-ID: <20220923012532-mutt-send-email-mst@kernel.org>
References: <TY2PR06MB34246957523C124C501790CD854E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20220922050156-mutt-send-email-mst@kernel.org>
 <33788b06-6c12-a9e3-4ae3-c817c0842bd3@intel.com>
 <20220922061655-mutt-send-email-mst@kernel.org>
 <b85f98df-62a5-7312-fcdb-12a6f1c61ae4@intel.com>
 <TY2PR06MB342409D370DB503BD8CAC751854E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB342409D370DB503BD8CAC751854E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
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

On Thu, Sep 22, 2022 at 10:52:05AM +0000, Angus Chen wrote:
> 
> 
> 
> On 9/22/2022 6:17 PM, Michael S. Tsirkin wrote:
> > On Thu, Sep 22, 2022 at 06:07:58PM +0800, Zhu, Lingshan wrote:
> >>
> >> On 9/22/2022 5:06 PM, Michael S. Tsirkin wrote:
> >>> On Thu, Sep 22, 2022 at 08:55:26AM +0000, Angus Chen wrote:
> >>>> >From 4f65eae86ab15d7abb8bd30401187cb195dfd27b Mon Sep 17 00:00:00 
> >>>> >2001
> >>>> From: "angus.chen" <angus.chen@jaguarmicro.com>
> >>>> Date: Thu, 22 Sep 2022 14:47:28 +0800
> >>>> Subject: [PATCH]     vDPA/ifcvf: fix the Calculation of queuepair
> >>>>
> >>>>           The queuepair should be divided by 2
> >>> this is just repeating what the patch does.
> >>> can you include more info pls?
> >>>
> >>> Documentation/process/5.Posting.rst says among other things:
> >>>
> >>> To that end, the summary line should describe the effects of and 
> >>> motivation for the change as well as possible given the one-line 
> >>> constraint.  The detailed description can then amplify on those 
> >>> topics and provide any needed additional information.  If the patch 
> >>> fixes a bug, cite the commit which introduced the bug if possible 
> >>> (and please provide both the commit ID and the title when citing 
> >>> commits).  If a problem is associated with specific log or compiler 
> >>> output, include that output to help others searching for a solution 
> >>> to the same problem.  If the change is meant to support other 
> >>> changes coming in later patch, say so.  If internal APIs are 
> >>> changed, detail those changes and how other developers should 
> >>> respond.  In general, the more you can put yourself into the shoes 
> >>> of everybody who will be reading your changelog, the better that 
> >>> changelog (and the kernel as a
> >>> whole) will be.
> >>>
> >>>
> >>>> Signed-off-by: angus.chen <angus.chen@jaguarmicro.com>
> >>> Format should be
> >>>
> >>> Angus Chen <angus.chen@jaguarmicro.com>
> >>>
> >>> Also pls drop leading space.
> >>>
> >>>
> >>>> ---
> >>>> drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++--
> >>>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c 
> >>>> b/drivers/vdpa/ifcvf/ifcvf_base.c index 75a703b803a2..3e4486bfa0b7 
> >>>> 100644
> >>>> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> >>>> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> >>>> @@ -323,7 +323,7 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
> >>>>           u32 q_pair_id;
> >>>>
> >>>>           ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> >>>> -       q_pair_id = qid / hw->nr_vring;
> >>>> +       q_pair_id = qid / 2;
> >> Yes, this should be 2 and actually this cap never work as expected, 
> >> we are re-designing this.
> > Do you ack this patch then?
> Yes,
> 
> Thank you ,should I resend a patch again without style problem?

If you have the time - it's easier for me if you do, yes.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
