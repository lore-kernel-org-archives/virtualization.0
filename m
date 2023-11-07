Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F03C4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 13:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBDA34214F;
	Tue,  7 Nov 2023 13:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBDA34214F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Du1cAgkx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9QaMQp-Lu-5M; Tue,  7 Nov 2023 13:28:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4308A417F5;
	Tue,  7 Nov 2023 13:28:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4308A417F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29966C0039;
	Tue,  7 Nov 2023 13:28:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C21E0C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 13:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 905E7613E8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 13:28:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 905E7613E8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Du1cAgkx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jM_PYt4LHrqP
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 13:28:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5D0F60ADC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 13:28:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5D0F60ADC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699363720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfimE53Fve5aGuDWfThDIn9D2hKcZVuah28LMBgDfqs=;
 b=Du1cAgkx8o0qrdFCK8+flLbPBe7aIPLuzxWegqe05nCBzIJ1S6w1amwb1Y+WJSXtf8K4TX
 2Hl18/I5JPzCBly3VbrWpjtP1cb/9mSuAuZNfgLXdsTDTz4XGypRz5p4NZI5bfR4f7OjKF
 FEMHN/ITLc/qUo3HHjbFa5+YlFitM3o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-MH8XMvWrOS2Nuv3GwYjLaQ-1; Tue, 07 Nov 2023 08:28:38 -0500
X-MC-Unique: MH8XMvWrOS2Nuv3GwYjLaQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40853e14f16so36090085e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Nov 2023 05:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699363717; x=1699968517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfimE53Fve5aGuDWfThDIn9D2hKcZVuah28LMBgDfqs=;
 b=Jm/uTTaE3Oycxd2vLfr2Z1WnYfc7eBAY8UXhoHntiQ1kDQpWqpF6/kCM5wpaAzp5/H
 mZfhfv3Bmyvahmbuna2mIwEkBnY9lbxoCE93wW8kEO53X5ksq2hBbbo2KUR+2wj92L0L
 CgZwB7YdWhA8VJBvbEoPlXOTouwfDZoBks9uGZUZ2JnXc+PkuI0aGA/zk6Ddqtx+NLD0
 SGdf9VPHWvkdrTPqmY4sPJpBlIXahzi5ZkS2Qb2Gj7Vfrxt+2F4qJtEjEzOIvIvX0ANJ
 EbrYZDxLcVHCf6AotZTfcFFbwmZuKDfDi5OJcleDYq8wt5aIPIMjNtO6VR3hc2bgYUwL
 Mhvw==
X-Gm-Message-State: AOJu0YyJzZM1qxrMo69uBevGyWxp9T53X9tOsXw08HzyurKWk9R6G7u6
 UdqIBbTnrr+RoHHHKkufwZ30YJa3QgKo6tzoCxFeEIvoST5iZfAe8Wbjtz8SIo5rihvLkZWvdhW
 3b3W+LQr+BsG8XWWJ/ORaBrvTX2mNIMVKaHV1Nv1DQA==
X-Received: by 2002:a05:600c:45cc:b0:405:75f0:fd31 with SMTP id
 s12-20020a05600c45cc00b0040575f0fd31mr2326522wmo.31.1699363717314; 
 Tue, 07 Nov 2023 05:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtC5KDdpuy2FXN8TvtT5NUe+9K52kc66AxdSuH43yqMhhnPmYpxrxy7CAZjiRPuu1mZVAilg==
X-Received: by 2002:a05:600c:45cc:b0:405:75f0:fd31 with SMTP id
 s12-20020a05600c45cc00b0040575f0fd31mr2326504wmo.31.1699363716906; 
 Tue, 07 Nov 2023 05:28:36 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
 by smtp.gmail.com with ESMTPSA id
 g23-20020a7bc4d7000000b004063cd8105csm15206763wmk.22.2023.11.07.05.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 05:28:36 -0800 (PST)
Date: Tue, 7 Nov 2023 08:28:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107082343-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231107124902.GJ4488@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, Cindy Lu <lulu@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 02:30:34AM -0500, Michael S. Tsirkin wrote:
> > On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> > > 
> > > Hi All
> > > This code provides the iommufd support for vdpa device
> > > This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> > > v6,6-rc3
> > > Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 
> > 
> > What kind of problems? Understanding that will make it easier
> > to figure out whether this is worth reviewing.
> 
> IMHO, this patch series needs to spend more time internally to Red Hat
> before it is presented to the community. It is too far away from
> something worth reviewing at this point.
> 
> Jason

I am always trying to convince people to post RFCs early
instead of working for months behind closed doors only
to be told to rewrite everything in Rust.

Why does it have to be internal to a specific company?
I see Yi Liu from Intel is helping Cindy get it into shape
and that's classic open source ethos.

I know some subsystems ignore the RFC tag but I didn't realize
iommu is one of these. Is that really true?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
