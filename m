Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98EDC6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 06:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2262983E3A;
	Fri, 23 Sep 2022 06:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2262983E3A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HIeqR/yl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amrWKUvm5eIK; Fri, 23 Sep 2022 06:02:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A7DFC83E2A;
	Fri, 23 Sep 2022 06:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7DFC83E2A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70D8CC0033;
	Fri, 23 Sep 2022 06:02:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10540C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 06:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCCE4417E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 06:02:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCCE4417E2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HIeqR/yl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4_e0tLbj_5Jc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 06:02:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFDC2417DE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFDC2417DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 06:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663912947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3IPZIViS4Ehcp5VyQpTJokrVDcTNM6JBlKQ6cmqx6Eg=;
 b=HIeqR/yluLQK/fGhtcHsH/jppqQt7VnyzBLqnn5OXI+/3b3SX2ikuk+oIIE3bK+BRrCOPh
 hR5OnfXClr/PPpMdBd70QaqjmBUE4NM6eE7HXY7bEYx6eedhwW7D5yOJXdJfK+1+z03y0K
 W+fcfbYHbo9sRp6783TdUWqVJmPcsfg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-ohK65B_rNOKS_zA0TfkvaA-1; Fri, 23 Sep 2022 02:02:26 -0400
X-MC-Unique: ohK65B_rNOKS_zA0TfkvaA-1
Received: by mail-wr1-f70.google.com with SMTP id
 c21-20020adfa315000000b0022adc2a2edaso3656934wrb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 23:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=3IPZIViS4Ehcp5VyQpTJokrVDcTNM6JBlKQ6cmqx6Eg=;
 b=WNpKMazlzecJZEGMY+4Zdq/OpNcWmdV4qu+fvBXHYvqpQZOuMEA94GIqSHh6UWKbtf
 wyFcCV3S8whYWE+0jHlq7Y1vU112df8uMpSWwoKxWvdcq0geNWsDdypTGvD/In3enWIA
 RdlQ8fULeVxdjv8plZegXO796elYEaYpGvbz3rqxuYbu2+/IyOQmey4SNLyz4hMtA+Xm
 bBhaLVxo0fGRTl6hIyUXpmAH8fDc77ujJIJ2KTMNHhGv/wuRIB1hhtHOBC4qK6w5BTlQ
 jgF95NDz/r6rU12VOxoaEXOnHb5jQbDs+Q+Kee607lVSVTzdzwwrphmecxlMR+DU1sgX
 0/9w==
X-Gm-Message-State: ACrzQf0hbmnEmhU2Lwx4NVgHT8stFShVLq4g0uR4G8J8KLLAkPf3wsAM
 bbArDtrLe1Etd10hNJNcKaUHR3WWsvq+EVv4JKY5f3Rgtk/JQccqUGpZu7SpG5hVxUt1IgpBOS9
 UGsG/e8I+QaaRi1HuPfrfaMW0rbQyJkxBYQuuONGjeQ==
X-Received: by 2002:a05:600c:a14e:b0:3b4:7ff1:299b with SMTP id
 ib14-20020a05600ca14e00b003b47ff1299bmr11662759wmb.18.1663912944916; 
 Thu, 22 Sep 2022 23:02:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ymiD/JjW0/10qYEPpnxqqVn13EXaa7UiNYBzJ8kJXzL5E7/HMzI4GRAAwbQT8mN8rCwznZA==
X-Received: by 2002:a05:600c:a14e:b0:3b4:7ff1:299b with SMTP id
 ib14-20020a05600ca14e00b003b47ff1299bmr11662745wmb.18.1663912944625; 
 Thu, 22 Sep 2022 23:02:24 -0700 (PDT)
Received: from redhat.com ([2.55.16.18]) by smtp.gmail.com with ESMTPSA id
 v26-20020a7bcb5a000000b003b462b314e7sm1511744wmj.16.2022.09.22.23.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 23:02:24 -0700 (PDT)
Date: Fri, 23 Sep 2022 02:02:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH v3] vdpa/ifcvf: fix the calculation of queuepair
Message-ID: <20220923020122-mutt-send-email-mst@kernel.org>
References: <20220923010356.2084-1-angus.chen@jaguarmicro.com>
 <21c4c74a-e340-0aaf-80b4-413d968144c5@intel.com>
 <20220923013055-mutt-send-email-mst@kernel.org>
 <5494f583-1672-2246-9030-5b8b870ad430@intel.com>
MIME-Version: 1.0
In-Reply-To: <5494f583-1672-2246-9030-5b8b870ad430@intel.com>
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

On Fri, Sep 23, 2022 at 01:43:36PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/23/2022 1:32 PM, Michael S. Tsirkin wrote:
> > On Fri, Sep 23, 2022 at 11:21:41AM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 9/23/2022 9:03 AM, Angus Chen wrote:
> > > > The queuepair should be divided by 2 and
> > > > it should not be hw->nr_vring when multi-queue feature was enabled
> > > This is not about MQ, even no MQ, there are still space in the cap storing
> > > (though invalid)queue states that can be addressed.
> > > So I think just describe q_pair_id = qid / 2 here.
> > hmm without MQ qid is always 0 or 1 so the old calculation
> > and the new one give the same result right?
> Yes, if no MQ, the queue pair id is always 0. The original code
> is buggy anyway, we need the queue pair id = qid /2 even without MQ.
> 
> If there are 8 queues, even no MQ feature bit negotiated, the HW
> still stores the queue states though invalid but can be addressed.
> 
> And we are working on a new layout of this LM cap/bar.
> > I guess this is what Angus Chen meant.
> > Would you mind writing a good commit log for us then?
> I think it can be as easy as:
> The q_pair_id to address a queue pair in the lm bar should be
> calculated by queue_id / 2 than queue_id / nr_vring

English requires "rather than" and not "than" here. Otherwise, ok.
Angus Chen could you post v4 with this corrected and Lingshan Zhu's
ack included please?

> Thanks,
> Zhu Lingshan
> > 
> > > for the code change:
> > > Acked-by: Zhu Lingshan<lingshan.zhu@intel.com>
> > > 
> > > Thanks
> > > > Fixes: 2ddae773c93b ("vDPA/ifcvf: detect and use the onboard number of queues directly")
> > > > 
> > > > changes in v2:
> > > >       - add commitid which to be fixed
> > > >       - no code changes
> > > > 
> > > > changes in v3:
> > > >       - updated commit log with more info, addressing comments by MST
> > > >       - no code changes
> > > > 
> > > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > > ---
> > > >    drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++--
> > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> > > > index 75a703b803a2..3e4486bfa0b7 100644
> > > > --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> > > > +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> > > > @@ -323,7 +323,7 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
> > > >    	u32 q_pair_id;
> > > >    	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> > > > -	q_pair_id = qid / hw->nr_vring;
> > > > +	q_pair_id = qid / 2;
> > > >    	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> > > >    	last_avail_idx = vp_ioread16(avail_idx_addr);
> > > > @@ -337,7 +337,7 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
> > > >    	u32 q_pair_id;
> > > >    	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> > > > -	q_pair_id = qid / hw->nr_vring;
> > > > +	q_pair_id = qid / 2;
> > > >    	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> > > >    	hw->vring[qid].last_avail_idx = num;
> > > >    	vp_iowrite16(num, avail_idx_addr);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
