Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628B9C64EC4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 14:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB310419B4;
	Thu,  9 Mar 2023 14:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB310419B4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U5Xyb6M9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E05d-JgMS1Iz; Thu,  9 Mar 2023 14:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 302A5419B8;
	Thu,  9 Mar 2023 14:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 302A5419B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00CD6C0035;
	Thu,  9 Mar 2023 14:27:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2365C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 14:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A12680E71
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 14:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A12680E71
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U5Xyb6M9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zdqtNKbX0rYF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 14:27:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7D3680E2C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7D3680E2C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678372060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X64yDT1qbQqLHrg6VjGfDyT5JAa4uYAV+oClT7eM/V8=;
 b=U5Xyb6M9sx3ZnG3AkkkeRxuGw8OL0d3PHceKO4M8eqQlxIGLDGcZl1HIj4lhtlNfP/2Z0U
 Si2wUmV1qbbMuGFw47/ngOwmDFoO9Xh0wdbmkWC9Wl+ctMrTbgIcfxbx3r7I/f4UJy4i6M
 tBlvfLVPiD6bYBO9tGg0oKR2G3ZQV5w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-v2ecEbKiPp-c7gzm8MRfQw-1; Thu, 09 Mar 2023 09:27:39 -0500
X-MC-Unique: v2ecEbKiPp-c7gzm8MRfQw-1
Received: by mail-ed1-f69.google.com with SMTP id
 v11-20020a056402348b00b004ce34232666so3189003edc.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 06:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678372058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X64yDT1qbQqLHrg6VjGfDyT5JAa4uYAV+oClT7eM/V8=;
 b=4zGy5fSoL+we92cH71dB/5pQG+6ulFJDp5k2TSDOf3gQNSsn+3WyXAYqOMoi0jdhec
 8t4O8E/4WQfRpGvwegdxUDYp5HwV+gvq0YQzGqnIeqR/2l9u5rOqZJ/w2oNp1xnEVb7x
 Tyhg3wx1Es12tz566hmlZHQjUe9Ke23WRtUnbBfvxKMI1ewYzlwu6LgaKJgpofwppxcM
 +N11BGd85ITac0rI7wE7UVfAOw6tx8DdOlpa8shf2A3GlZEaR3dZVr/kdbJl/+ePhaLW
 Em4S0UiNi4ycEPim2mTqG5R6jmWNTM+OLDTEVCmER+jxQvG1NS7cZtDBC9RjSOHDHWya
 xMCw==
X-Gm-Message-State: AO0yUKV4FeRY2WBoVGadMXR7Z2DyDW2jjm2+rQBgqP+26xsz7oxicZdF
 DRuB6x4wU69ijF/36ifQBuR9zVt/zyOLuUm3/ffF/kSnnUdH6wcR2fuduBSHDM81ISBOukY9DsU
 CXCLt0RM/+fbGhLEbfeOjoOoKhZ5O2ahA5K85lUwkQA==
X-Received: by 2002:aa7:d9c9:0:b0:4c4:95dc:8ca3 with SMTP id
 v9-20020aa7d9c9000000b004c495dc8ca3mr20101674eds.3.1678372058299; 
 Thu, 09 Mar 2023 06:27:38 -0800 (PST)
X-Google-Smtp-Source: AK7set9D8nabB9iY3r4jaEXDO9TGivRn4pr0Eq4UI8PDhiVLU6127g5JYtsbf4fDObCwWL41FTtJgA==
X-Received: by 2002:aa7:d9c9:0:b0:4c4:95dc:8ca3 with SMTP id
 v9-20020aa7d9c9000000b004c495dc8ca3mr20101660eds.3.1678372058022; 
 Thu, 09 Mar 2023 06:27:38 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 k21-20020a05640212d500b004aee4e2a56esm9610095edx.0.2023.03.09.06.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 06:27:37 -0800 (PST)
Date: Thu, 9 Mar 2023 09:27:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH 3/3] virtio_ring: Use const to annotate read-only pointer
 params
Message-ID: <20230309092451-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-4-feliu@nvidia.com>
 <CACGkMEsMQZb6cMPmf8MxrhNhLGGzYRm_=1e8PCUt+1-DExaStg@mail.gmail.com>
 <55af3dc3-ed82-c22a-1205-0a1b8315c88f@nvidia.com>
 <20230308091442-mutt-send-email-mst@kernel.org>
 <23961926-f975-54fd-6537-42a53ef34503@nvidia.com>
 <20230308092541-mutt-send-email-mst@kernel.org>
 <ZAmlwyVfz+IK1b6T@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAmlwyVfz+IK1b6T@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, Bodong Wang <bodong@nvidia.com>,
 Gavin Li <gavinl@nvidia.com>
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

On Thu, Mar 09, 2023 at 10:24:19AM +0100, Jiri Pirko wrote:
> >Nice but the bigger problem is not the mistake - it is the posting of
> >untested code. It might be an ok thing to do - as long as you make it
> >super abundantrly clear that this is what it is, and explain why
> >you are posting it now and not after testing.
> 
> Isn't there some ci running with posted patches here? That would uncover
> it right away. In netdev world, this is very convenient. Example:
> https://patchwork.kernel.org/project/netdevbpf/list/?series=727865
> Patch won't apply.

It is a best effort thing and is not an excuse to post untested patches
for review. If I see a patch I expect that the author made sure
the patch does what it's supposed to do.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
