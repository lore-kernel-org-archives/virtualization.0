Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393EBC6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 05:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9AF660D56;
	Fri, 23 Sep 2022 05:32:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9AF660D56
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/c1+ENZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNTixvs3K-z7; Fri, 23 Sep 2022 05:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 45E9160C1C;
	Fri, 23 Sep 2022 05:32:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45E9160C1C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C713C0033;
	Fri, 23 Sep 2022 05:32:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9CC8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C04E9417FC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:32:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C04E9417FC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/c1+ENZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5MMyWhQy2FwL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:32:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDC8F417FA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDC8F417FA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 05:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663911160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NZP5Fo4I/eSaHhTzPLS+tQ1+9fzrWUAlobqLMC7ZNcw=;
 b=Z/c1+ENZjQkmTRu3mWcDxPnVruKoK9Wd6XFfrkptxP+RFFOGMwbNS2fw3xlk6weZxdY+/U
 vDwPU+AGEhSDQDhWuTImkvD1osELID3VWuHRjHCt4sCIQb6n13F97j0SK9qCKLkKAN2wd6
 k9a9IMiQYuuW5GmeeSvSU+pzFe3BOLk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-543-jQUc63-5M6ugPWVNslc-bw-1; Fri, 23 Sep 2022 01:32:37 -0400
X-MC-Unique: jQUc63-5M6ugPWVNslc-bw-1
Received: by mail-ej1-f70.google.com with SMTP id
 qf40-20020a1709077f2800b0077b43f8b94cso5304954ejc.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 22:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=NZP5Fo4I/eSaHhTzPLS+tQ1+9fzrWUAlobqLMC7ZNcw=;
 b=Fstco882EyadCjwekvYddXM4HHJ/aVbJkvCp3padFxLIpaggUabxOQCw6SA0bN32H9
 sIcw7cKMphr9cFW86KFcCEXOn1d2dNlswmWfPvxJ4cnRgnAvGlYqhNczUtKfHjTfrq0d
 sHlBndmClxM9ah6uQolu7zUnyb1WRDLwt8viRTHnQQ5LV1nTnByo5JivcIkNzVJl8owl
 pxPnNIjVU4t6EFD3bmipDFPGXf/uxRRRDLAUeIJGoPXWuzWHiPvNNenAn8S+yNPX5rKe
 ZU9L8ykI7rPyIRa3J0QTBFoBGmO+LjwE7OK/OYDnFg0188Bsk2uIHiShf8YwO+scNeON
 6Elw==
X-Gm-Message-State: ACrzQf3iZScG8A078Znvb1Uu57keN3d/BLwy1FMOJBqENoFOFO1X2HiF
 xpDHFZN2RkCybLBky1GEIE9zn5nxuY+ksSDUUxt0Vt02KQeKwrS52go1BJJyw23J4P5/vBQsfAL
 /dQ1UZnj9AnSRsj/JtPR3H/B3tVA67CDevxlo+NnVLg==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id
 wu11-20020a170906eecb00b0073c5bcb8eb3mr5597532ejb.284.1663911156405; 
 Thu, 22 Sep 2022 22:32:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4/2cnXUMQwSilxLWC8W1kst2y6ipwRkSGD+8utcoVXAHp0REvZI1M4CBE2OGvKXND/ut+1jQ==
X-Received: by 2002:a17:906:eecb:b0:73c:5bcb:8eb3 with SMTP id
 wu11-20020a170906eecb00b0073c5bcb8eb3mr5597524ejb.284.1663911156210; 
 Thu, 22 Sep 2022 22:32:36 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 g18-20020a056402115200b00456ced2b26csm135207edw.8.2022.09.22.22.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 22:32:35 -0700 (PDT)
Date: Fri, 23 Sep 2022 01:32:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH v3] vdpa/ifcvf: fix the calculation of queuepair
Message-ID: <20220923013055-mutt-send-email-mst@kernel.org>
References: <20220923010356.2084-1-angus.chen@jaguarmicro.com>
 <21c4c74a-e340-0aaf-80b4-413d968144c5@intel.com>
MIME-Version: 1.0
In-Reply-To: <21c4c74a-e340-0aaf-80b4-413d968144c5@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org,
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

On Fri, Sep 23, 2022 at 11:21:41AM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/23/2022 9:03 AM, Angus Chen wrote:
> > The queuepair should be divided by 2 and
> > it should not be hw->nr_vring when multi-queue feature was enabled
> This is not about MQ, even no MQ, there are still space in the cap storing
> (though invalid)queue states that can be addressed.
> So I think just describe q_pair_id = qid / 2 here.

hmm without MQ qid is always 0 or 1 so the old calculation
and the new one give the same result right?
I guess this is what Angus Chen meant.
Would you mind writing a good commit log for us then?

> for the code change:
> Acked-by: Zhu Lingshan<lingshan.zhu@intel.com>
> 
> Thanks
> > Fixes: 2ddae773c93b ("vDPA/ifcvf: detect and use the onboard number of queues directly")
> > 
> > changes in v2:
> >      - add commitid which to be fixed
> >      - no code changes
> > 
> > changes in v3:
> >      - updated commit log with more info, addressing comments by MST
> >      - no code changes
> > 
> > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > ---
> >   drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> > index 75a703b803a2..3e4486bfa0b7 100644
> > --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> > +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> > @@ -323,7 +323,7 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
> >   	u32 q_pair_id;
> >   	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> > -	q_pair_id = qid / hw->nr_vring;
> > +	q_pair_id = qid / 2;
> >   	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> >   	last_avail_idx = vp_ioread16(avail_idx_addr);
> > @@ -337,7 +337,7 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
> >   	u32 q_pair_id;
> >   	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> > -	q_pair_id = qid / hw->nr_vring;
> > +	q_pair_id = qid / 2;
> >   	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> >   	hw->vring[qid].last_avail_idx = num;
> >   	vp_iowrite16(num, avail_idx_addr);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
