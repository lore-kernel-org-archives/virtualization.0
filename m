Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A136EECAAD8
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 04:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 237BC83DF2;
	Fri, 23 Sep 2022 04:18:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 237BC83DF2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cmF1noO/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQqX-5_ykQ9T; Fri, 23 Sep 2022 04:18:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B981A83323;
	Fri, 23 Sep 2022 04:18:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B981A83323
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3931C0071;
	Fri, 23 Sep 2022 04:18:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82607C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 505D360C30
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:18:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 505D360C30
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cmF1noO/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6pUwlVHP5dFl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:18:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9ECF960C2A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ECF960C2A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 04:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663906697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ho/GHYB/STQpwQXMDeeSjtbJmn/yPbbsf4/Tcj1OOIU=;
 b=cmF1noO/a1ScCcON32CYmPhwP85P/cxFzlj4gZQDXylW+OacM/TZwtd8Xv4AqPnWH98BPz
 QyfFqOjZV1uPhUK+l3iSTJgHEw/rHzmmgpSaemS9T6krT8knQCutEa51B3HiVDtXHOWYlg
 jH/i+Ii05ECsvseSGPenDPAuJ98ZzIw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-K0e7rx1POMCuilmu2IN9ww-1; Fri, 23 Sep 2022 00:18:16 -0400
X-MC-Unique: K0e7rx1POMCuilmu2IN9ww-1
Received: by mail-ot1-f69.google.com with SMTP id
 a11-20020a9d6e8b000000b00656442abf2eso5493046otr.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 21:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Ho/GHYB/STQpwQXMDeeSjtbJmn/yPbbsf4/Tcj1OOIU=;
 b=YzKx5jPnv/M+2Zs9Z34TIEocelZTsPFrBTeCj+//xrpqO+bpeLqe2bnswrIbK4qLVD
 Ghz7GBKZFvc15vKix7QHV7i5FmBPFkhoHyzmKfg3akPnoCYmfJO+nilUYx77MbApZwoP
 KjF8ZekqIc2/tEYM3JBUd6fh5NzuUL5Sk+R7zdUqwxDoObZpkO1Vtczo+fGERnFGOsN3
 T0jCjuS7JDRl3sQZ8RKfB5i3udCsd4HdQ8U4XNMyAeSYGEXijvw8xLxzb8b0Veu+t8sa
 v6BCFpbR0XdcEV3gtQiF5CJn2t8mb2sT9pU+fgFIbdhJ1nt7dxfiBBaYJgxbFPZy5FjB
 TUvA==
X-Gm-Message-State: ACrzQf391o0g1FwHRDiSB17UHneXJC8qufuV23f5UOAlESy5EVcZYDLw
 yvSH7h9cSLTltZaa4TrEw9pzgFAJo3dxu+PA7TA4dR6NjSI8BjcETUJbCSumjQNJRqGW8sSFya1
 03qpAC/+OgMwy8kOssjRNfRbYqJAGH+iVY5gOLxaX0qcJvTHtnkU94+42rg==
X-Received: by 2002:a05:6870:73cd:b0:12a:dff3:790a with SMTP id
 a13-20020a05687073cd00b0012adff3790amr10029063oan.35.1663906695727; 
 Thu, 22 Sep 2022 21:18:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54fSZlN5UzqEiq1elGzyQ2vJyawQCrSlY2dU1zDkgqGIDMP/9dKC/eb8xbVjWEOa+q2ywQXKwk/tq2rPEVre8=
X-Received: by 2002:a05:6870:73cd:b0:12a:dff3:790a with SMTP id
 a13-20020a05687073cd00b0012adff3790amr10029051oan.35.1663906695477; Thu, 22
 Sep 2022 21:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220923035228.2145-1-angus.chen@jaguarmicro.com>
 <CACGkMEvuJTiPZa9XZwrv-Cbj-E1ZW+eFD8AWrz0Ww_pqpgECiQ@mail.gmail.com>
 <c33e4352-2b6a-1af4-3f7e-9bd8f3a2213d@intel.com>
In-Reply-To: <c33e4352-2b6a-1af4-3f7e-9bd8f3a2213d@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Sep 2022 12:18:04 +0800
Message-ID: <CACGkMEv-z+8_9AqpfienCHT2iFDPeBhUApCO=+j2o7C=u4RF6A@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa/ifcvf: avoid waste ioremap area of vdpa hot
 migration
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

On Fri, Sep 23, 2022 at 12:15 PM Zhu, Lingshan <lingshan.zhu@intel.com> wrote:
>
>
>
> On 9/23/2022 12:09 PM, Jason Wang wrote:
> > On Fri, Sep 23, 2022 at 11:53 AM Angus Chen <angus.chen@jaguarmicro.com> wrote:
> >> The array capacity should be queuepair,
> > If this is true, we need a better name for the ifcvf_vring_lm_cfg structure.
> Not true AFAIK. And we are re-designing this cap.
>
> Thanks
> Zhu Lingshan

Ok, but I think we still need to keep this for backward compatibility
and need to differ the generations via some Intel specific registers.

Thanks

> >
> > Thanks
> >
> >> and the queuepairs should
> >> be half of IFCVF_MAX_QUEUES without control queue,
> >> or should be (IFCVF_MAX_QUEUES+1)/2 with the control queue.
> >> So the definition of ifcvf_lm_cfg waste some memory,
> >> and it will waste some ioremap area also.
> >>
> >> Fixes: 2ddae773c93b ("vDPA/ifcvf: detect and use the onboard number of queues directly")
> >> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> >> ---
> >>   drivers/vdpa/ifcvf/ifcvf_base.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> >> index f5563f665cc6..563c04f9b7ac 100644
> >> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> >> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> >> @@ -104,7 +104,7 @@ struct ifcvf_vring_lm_cfg {
> >>
> >>   struct ifcvf_lm_cfg {
> >>          u8 reserved[IFCVF_LM_RING_STATE_OFFSET];
> >> -       struct ifcvf_vring_lm_cfg vring_lm_cfg[IFCVF_MAX_QUEUES];
> >> +       struct ifcvf_vring_lm_cfg vring_lm_cfg[(IFCVF_MAX_QUEUES+1)/2];
> >>   };
> >>
> >>   struct ifcvf_vdpa_mgmt_dev {
> >> --
> >> 2.17.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
