Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1344CC4332F
	for <virtualization@archiver.kernel.org>; Wed,  4 Jan 2023 13:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82DD0819E6;
	Wed,  4 Jan 2023 13:58:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82DD0819E6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YvWQ4V9j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XngjNEvnDo-q; Wed,  4 Jan 2023 13:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1E26819B8;
	Wed,  4 Jan 2023 13:58:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1E26819B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEC17C0033;
	Wed,  4 Jan 2023 13:58:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CAFBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 13:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6819940170
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 13:58:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6819940170
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YvWQ4V9j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LodBf215YT4D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 13:58:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6595A40162
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6595A40162
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jan 2023 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672840704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2g7AQiyMo+zQG4hJLCNXn/Y1FS2CxkIcwqayTLaqHw=;
 b=YvWQ4V9jLkSyHtLRS5eC+w4UoB8jYXiP4L/Aig/+YS0RymviWQ/20Y9CAeOOmBxEORKwet
 es4EBnDq9zt2m5jlAIfBLnunIOWNB765x5NodYILqCtT4ZF9c99fNFXil8t+K53VL7Vv86
 FDZ5Qe3r3Uq4u2Sq4VqG+SWLpzHf+r4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-Ji3ZiZG3P7218iWGv-ZP9A-1; Wed, 04 Jan 2023 08:58:23 -0500
X-MC-Unique: Ji3ZiZG3P7218iWGv-ZP9A-1
Received: by mail-wm1-f70.google.com with SMTP id
 c7-20020a1c3507000000b003d355c13ba8so18154149wma.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Jan 2023 05:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2g7AQiyMo+zQG4hJLCNXn/Y1FS2CxkIcwqayTLaqHw=;
 b=VCo4Wsp0yldeMwafnbuWw8zMytLp5bUIULbApJLhHEFojioyjHi3YGODxaefHjpAVA
 710/TWemqYOmuxilPqfn0q3nvIjm5fBOp0o19WuENKurVAfIfy2OPNekoOPMRhrrsFPt
 yKEmOgy790M/BQi/AVGxxSwYUdNHOCjPjgEcRW6/HcD+hrZoZ0QdlhBr91Xz9it6LPta
 KePKZGSkkoT0/xxe9jGd7gdzCbyKqtY3yblgN7yKwzhin5RZ5K1Az2jfNls36i9iMnMu
 8vOHx8oBtI6j5ntMTmgaSnYTtGrgrgSDyLB0px3Jx+wIOBkFirNK4XPVe6BdxBVGRM47
 /xfg==
X-Gm-Message-State: AFqh2kpeSbH0Q4eJny8YDqVRab+iGT5GBq4wyLrN+a9a+WnKxuwmLP8P
 PTRCbTN1rx8YCcJvtmaP8nSAz6/1dkMrFQ2tq4dZV/je0R+Kjrf0eOaGzjTtSYh8D/IlVCpZtft
 r6yobCHfSGStKpA4qaCbrPvMJ3Zwts1YOsg0psdJNDQ==
X-Received: by 2002:adf:c644:0:b0:29f:9df0:a6b2 with SMTP id
 u4-20020adfc644000000b0029f9df0a6b2mr5619449wrg.64.1672840702661; 
 Wed, 04 Jan 2023 05:58:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuK7jM77xJpOfWK6+w0fu2Xj6muiZi/o2lgkHUF2s7iQgthdchD8fTt/oLTToMpN4rq7X5Q2w==
X-Received: by 2002:adf:c644:0:b0:29f:9df0:a6b2 with SMTP id
 u4-20020adfc644000000b0029f9df0a6b2mr5619439wrg.64.1672840702443; 
 Wed, 04 Jan 2023 05:58:22 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 o5-20020adfe805000000b0028cc9d2ec1csm20665518wrm.54.2023.01.04.05.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jan 2023 05:58:21 -0800 (PST)
Date: Wed, 4 Jan 2023 08:58:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH -next] vdpa/mlx5: fix check wrong pointer in
 mlx5_vdpa_add_mac_vlan_rules()
Message-ID: <20230104085605-mutt-send-email-mst@kernel.org>
References: <20230104074418.1737510-1-yangyingliang@huawei.com>
 <DM8PR12MB5400CDBCE2E0150F50E2224FABF59@DM8PR12MB5400.namprd12.prod.outlook.com>
 <DM8PR12MB540012D1421616399D0903CCABF59@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB540012D1421616399D0903CCABF59@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Yang Yingliang <yangyingliang@huawei.com>
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

On Wed, Jan 04, 2023 at 11:41:31AM +0000, Eli Cohen wrote:
> I see these patches were not sent yet.
> Michael/Yang Yinglliang, isn't it better to send a fixed patch instead of sending the original and fix on top of it?

depends on the severity of the fix. in this case it seems to leak
uninitialized stack data to userspace, so I'd say it's best to
squash in the fix.
keep signed-off by of the fixup contributor so they get attribution.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
