Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE6C19F21
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 11:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3159583E8B;
	Thu, 28 Jul 2022 11:29:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3159583E8B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oy00/r6M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FwYbx5XmT6OK; Thu, 28 Jul 2022 11:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A623083E8C;
	Thu, 28 Jul 2022 11:29:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A623083E8C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DC47C0033;
	Thu, 28 Jul 2022 11:29:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D39C1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 11:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A10FA40B72
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 11:29:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A10FA40B72
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oy00/r6M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oREg4GtwRA5S
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 11:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FEDA4010C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FEDA4010C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659007739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cZB1NG+wVsDb0xqERERb42QqEfgIFEymoWIE95OHxNE=;
 b=Oy00/r6MZDqaeBl8Qckd3Q5hFyco1JL9jybNudhxK0q36kR3CZbFR+T3u7IFfLTcrh0CDM
 Nd1XLMVfm3EJ7H8r6hvkTzk+xvhAynf42wQzLUUm3PoHnLC2j/HPZdgu0fLjZ+hsQOuKkI
 jzgIy5Eh/yr3atiz1nJaqV3eAKU/IIk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-y0tdDmdmPuuV7Y4HM4aLyg-1; Thu, 28 Jul 2022 07:28:58 -0400
X-MC-Unique: y0tdDmdmPuuV7Y4HM4aLyg-1
Received: by mail-wr1-f70.google.com with SMTP id
 r29-20020adfb1dd000000b0021f0bfc13d0so24807wra.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 04:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=cZB1NG+wVsDb0xqERERb42QqEfgIFEymoWIE95OHxNE=;
 b=5FvKKeBCg5U4ZqWaENWAP/9GVZ1KFlgBxFPy0NEdMHpIrCZJ1dvIlOU0TZuZvn4254
 cD+jzMyRrr27sKq5SBOSmq7Q5fFQy+mnk8jgAFElF1RxnFzPpQmQ1XGVdFilmfFS2pUz
 WgkbUd7TEV/NVglXPr8+fGi4pXyaSlbl9wHy1pE8C7df/xY73rRlmdb2hPMljAIrmata
 DV63xzu+a+6yiLm8MurQZ5ST7eNqtIA+ubUQb7IAUhw9IhtSReXx2Y3gV/mFnWFhz4Xd
 OFWuitJ3Q9eWAVms7B/ZmiiTj7gfIusseXyya4klwr23wu14N9UXylriQ93FtQDqoWAw
 IcSw==
X-Gm-Message-State: AJIora+yJ5bgj6JIFsvQ1brz2Stf9ChUb9WXO/uCIZpugj1t7cC5ugOs
 uRvl0rr65s35aCuHJI547xdzB/7DKyhmxWbaCsReu8KmyEksoiknG4zR5GIIiIqVEy23Eg6jgpA
 twdkbraXlwpFNnw1XIRif59dFGoj2Q3vS0/Qt2Rlung==
X-Received: by 2002:a5d:6e88:0:b0:21a:3403:9aa0 with SMTP id
 k8-20020a5d6e88000000b0021a34039aa0mr17809327wrz.379.1659007736928; 
 Thu, 28 Jul 2022 04:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vxboBdk2/f/LHiGoeMb/B/17fMKTO59R2yOdFyOV29cB/H+Dp+idgxc+NPtGMu/logDW1VrA==
X-Received: by 2002:a5d:6e88:0:b0:21a:3403:9aa0 with SMTP id
 k8-20020a5d6e88000000b0021a34039aa0mr17809298wrz.379.1659007736541; 
 Thu, 28 Jul 2022 04:28:56 -0700 (PDT)
Received: from redhat.com ([2.54.183.236]) by smtp.gmail.com with ESMTPSA id
 j10-20020adff54a000000b0021eddf38b2asm781887wrp.41.2022.07.28.04.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jul 2022 04:28:55 -0700 (PDT)
Date: Thu, 28 Jul 2022 07:28:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: spec clarification (was Re: [PATCH V3 4/6] vDPA: !FEATURES_OK
 should not block querying device config space)
Message-ID: <20220728072137-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
 <c8bd5396-84f2-e782-79d7-f493aca95781@redhat.com>
 <f3fd203d-a3ad-4c36-ddbc-01f061f4f99e@oracle.com>
 <CACGkMEtvVOtqAgY4Yzt_4=t8yfGJho4d9C=X8MQhW0ZKw1sDNA@mail.gmail.com>
 <2dfff5f3-3100-4a63-6da3-3e3d21ffb364@oracle.com>
MIME-Version: 1.0
In-Reply-To: <2dfff5f3-3100-4a63-6da3-3e3d21ffb364@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 virtio-comment@lists.oasis-open.org,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 virtio@lists.oasis-open.org, Eli Cohen <elic@nvidia.com>
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

On Thu, Jul 28, 2022 at 01:20:26AM -0700, Si-Wei Liu wrote:
> Hi Michael,
> 
> Could you please comment on the different wording between "exist" and "valid"
> in spec? Having seen quite a few relevant discussions regarding MTU validation
> and VERSION_1 negotiation on s390, I was in the impression this is not the
> first time people getting confused because of ambiguity of random wording
> without detailed example helping to clarify around the context, or due lack of
> clear definition set ahead. I like your idea to keep things consistent
> (conditional depending on feature presence), however, without proper
> interpretation of how spec is supposed to work, we are on a slippery slope
> towards inconsistency.
> 
> On 7/28/2022 12:36 AM, Jason Wang wrote:
> 
>         And looking at:
> 
>         "The mac address field always exists (though is only valid if
>         VIRTIO_NET_F_MAC is set), and status only exists if VIRTIO_NET_F_STATUS
>         is set."
> 
>         It appears to me there's a border line set between "exist" and "valid".
>         If I understand the spec wording correctly, a spec-conforming device
>         implementation may or may not offer valid status value in the config
>         space when VIRTIO_NET_F_STATUS is offered, but before the feature is
>         negotiated.
> 
>     That's not what I read, maybe Michael can clarify this.
> 
> 
> 
> And Jason and I find below normatives are conflict with each other.
> 
>         "The device MUST allow reading of any device-specific configuration
>         field before FEATURES_OK is set by the driver. This includes fields
>         which are conditional on feature bits, as long as those feature bits are
>         offered by the device."


So I proposed this back in April:

https://lists.oasis-open.org/archives/virtio-comment/202201/msg00068.html

I intended this for 1.2 but it quickly became clear it won't make it
in time. Working on reviving the proposal and addressing the comments.




> 
>     ...
> 
>         And also there are special cases where the read of specific
>         configuration space field MUST be deferred to until FEATURES_OK is set:
> 
>         "If the VIRTIO_BLK_F_CONFIG_WCE feature is negotiated, the cache mode
>         can be read or set through the writeback field. 0 corresponds to a
>         writethrough cache, 1 to a writeback cache11. The cache mode after reset
>         can be either writeback or writethrough. The actual mode can be
>         determined by reading writeback after feature negotiation."
>         "The driver MUST NOT read writeback before setting the FEATURES_OK
>         device status bit."
> 
>     This seems to conflict with the normatives I quoted above, and I don't
>     get why we need this.
> 
> 
> 
> Thanks,
> -Siwei


The last one I take to mean writeback is special.
I am not sure why it should be. Paolo you proposed this text could
you comment please?

Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
