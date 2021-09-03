Return-Path: <SRS0=H6i0=NZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA05CC433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 09:04:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBD6610A1
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 09:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BBD6610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E88880FF2;
	Fri,  3 Sep 2021 09:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VluVZ3oHDB82; Fri,  3 Sep 2021 09:04:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C067B80E48;
	Fri,  3 Sep 2021 09:04:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A00DCC0010;
	Fri,  3 Sep 2021 09:04:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F102BC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 09:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2AE480E48
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 09:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xIhv2m665gr7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 09:04:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE82B80E41
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630659886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a35OZamz4FhULMDWjA+MIpzd8IbhFlUnBRFIx65TG18=;
 b=Zt4azUur3K5JP76jjkcBUcrgj6sagIWwhRb0BV5U+R5pIrRdRakAjFcJI1tzEXaapHvLrl
 TbnOMZcS6p3bMn2mO24JsecV+eewtVDR/gSXmRtT/smdc3ZMOvZXNuwlfORkVw6ScxSkVI
 UkHHszdLfi+GH1LqODC/M0yQe2JJy7g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-DP2I7o7XPeC_GVyl6HTYgg-1; Fri, 03 Sep 2021 05:04:44 -0400
X-MC-Unique: DP2I7o7XPeC_GVyl6HTYgg-1
Received: by mail-wr1-f70.google.com with SMTP id
 102-20020adf82ef000000b001576e345169so1355867wrc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Sep 2021 02:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a35OZamz4FhULMDWjA+MIpzd8IbhFlUnBRFIx65TG18=;
 b=rhL1sRlkuNcw3vCOGY6kc14HhSUgPoC6+C4LnQ/Gu36W7hTCvMCkOiA8UeHsI6y4jF
 OH4yHaIucpANL9zT1lE0KhJk+Cfib40831qKqS4A9/YeGZaxQvfL+E70HV6eGULb3x/H
 zrB/StiHn7kH+K7B1/Z8pPNpJmNvyia3kbKIm6HtjzPa1ALzX0eWDfCZFit4tCl/6EwM
 1b78QhfO+H43zKeNQcAJ0alR/778nMJcmX+IKjF2vSWsAV0XCAduAkLFSNiv9QQtHnKK
 mKvkcr7dkFQREOUSf2qvIYzVGiWGmNSBs0QpkAUufm4pihImBtbEHuUazVFWTjZN8m/s
 kfBA==
X-Gm-Message-State: AOAM530FAIEZLEV4np74PCFlFp5jm7/qQPCS0PdD/uDfOlUdDMUIR/g9
 xowfuDN8WMnjsEMJ6OgVU5Nby6oKWaAR45bAhM3AAMbij+tp91ssCPmSctukhHBR5JFik96ynQt
 kwId9IefUydnDmKNKJpk47bv+TWyVRGfwOhk4XtIzPw==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr7316051wmj.4.1630659883798;
 Fri, 03 Sep 2021 02:04:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq1o45OPMNe+RtszcnJRaHC5co9mJquGrSZkuN/bgyyco2U6W6QjJBBk7GWQODKEhxLdyBqQ==
X-Received: by 2002:a7b:cd82:: with SMTP id y2mr7316037wmj.4.1630659883591;
 Fri, 03 Sep 2021 02:04:43 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207f:7f47:ccd3:7600:6a2d:c5a])
 by smtp.gmail.com with ESMTPSA id h8sm3665497wmb.35.2021.09.03.02.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 02:04:42 -0700 (PDT)
Date: Fri, 3 Sep 2021 05:04:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio-blk: remove unneeded "likely" statements
Message-ID: <20210903050418-mutt-send-email-mst@kernel.org>
References: <20210830120111.22661-1-mgurtovoy@nvidia.com>
 <YTDnD1c8rk3SWcx9@stefanha-x1.localdomain>
 <6800aad7-038a-b251-4ad5-3dc005b0a8a1@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <6800aad7-038a-b251-4ad5-3dc005b0a8a1@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, oren@nvidia.com
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

On Thu, Sep 02, 2021 at 10:13:04PM +0300, Max Gurtovoy wrote:
> 
> On 9/2/2021 6:00 PM, Stefan Hajnoczi wrote:
> > On Mon, Aug 30, 2021 at 03:01:11PM +0300, Max Gurtovoy wrote:
> > > Usually we use "likely/unlikely" to optimize the fast path. Remove
> > > redundant "likely" statements in the control path to ease on the code.
> > > 
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > It would be nice to tweak the commit description before merging this. I
> > had trouble parsing the second sentence. If I understand correctly the
> > purpose of this patch is to make the code simpler and easier to read:
> > 
> >    s/ease on the code/simplify the code and make it easier to read/
> 
> I'm ok with this change in commit message.
> 
> MST,
> 
> can you apply this change if you'll pick this commit ?
> 
> -Max.


Just repost with a fixed commit log pls, easier for me.
Thanks!

> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
