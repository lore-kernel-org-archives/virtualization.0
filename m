Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE54C61DA4
	for <virtualization@archiver.kernel.org>; Mon, 13 Mar 2023 21:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2CB3417A7;
	Mon, 13 Mar 2023 21:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2CB3417A7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dSev7wAI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DeepvPwo6jrr; Mon, 13 Mar 2023 21:44:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39CE4417A2;
	Mon, 13 Mar 2023 21:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39CE4417A2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 199F0C0071;
	Mon, 13 Mar 2023 21:44:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C195BC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88AED417A3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:44:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88AED417A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QotW8C-FOy6s
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A94D8417A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A94D8417A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 21:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678743887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R8Ygv9XT//l9G7UqZBUN6H6NBd2FUFkKFx8kVmgcHO8=;
 b=dSev7wAIAoFAujaTgpyMrO2KaRFO5LLYLX8rWMKR/A1Z7jxK0JU/CEVGvkob9fZAu55LJn
 3OXnuPBGV6nDgeP7VIHAFLrmMtRLhwczNiFc5PwPJRpiOB+Rb1esVlAt3Ru1YLigXU8Yil
 MIZuhtlPsMMrl7VS6arM8KgNLqTzrQo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-H0PHFPfbPDm4p3WRe3vdWA-1; Mon, 13 Mar 2023 17:44:46 -0400
X-MC-Unique: H0PHFPfbPDm4p3WRe3vdWA-1
Received: by mail-wm1-f72.google.com with SMTP id
 bi27-20020a05600c3d9b00b003e9d0925341so4626635wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 14:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678743885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R8Ygv9XT//l9G7UqZBUN6H6NBd2FUFkKFx8kVmgcHO8=;
 b=fjEBWQa0S9Z5j1/QkCHGNz3EMRjI1aGaJ8EhS7A8i0K4SEjkaYtzwSOAFdHjL/UEtA
 1xZ6QDmS8U6TKR9c9Vy7Jl/8RQUNvgx5liNFHa0I7cTT5cJ05JgcQh3mIlymqEYBTW0a
 c2qPLtzhbl2dcrl4IcqELXpSEF5yGGVuFjALxZtb22jjia15CvUfZT6LZLWgxDVu9Y+x
 NP+qxOmjqlIu1f6fA21npIQMt6d9z7p7VpbgPRERxXxU4QblFJdvmX91zxGEP8J8evho
 /X/5NEPyh4NbvLX3PkMu+0nEZmCy11wlb2Afpskg+5F/hsflUS2/VPWrhHg1B984Llpi
 fIow==
X-Gm-Message-State: AO0yUKUDLvLoV/kVa5DEom2NqNJnxkmGYA11jLYp+5NCWwZlyoyA9vei
 412FUgeN+VQwzcgm34/wdhbmU0c/Rp/1WulXNrxtVmdYFSUV+TqPPvybdQx+9yOfIRCPTjOofDe
 D+RW5J2uxNeixG6/JY7WGbbS9dHKI0G4xu7rEjb7FDg==
X-Received: by 2002:a05:600c:3504:b0:3ea:d620:579b with SMTP id
 h4-20020a05600c350400b003ead620579bmr11591035wmq.0.1678743885125; 
 Mon, 13 Mar 2023 14:44:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set8M++TOjlN3dPQoFDsaIQYe+u1EuZhLTzUvyYF9uiz52zXcJ9nOQ3EzRp63CfgxicSSamOmzw==
X-Received: by 2002:a05:600c:3504:b0:3ea:d620:579b with SMTP id
 h4-20020a05600c350400b003ead620579bmr11591014wmq.0.1678743884817; 
 Mon, 13 Mar 2023 14:44:44 -0700 (PDT)
Received: from redhat.com ([2.52.26.7]) by smtp.gmail.com with ESMTPSA id
 a3-20020a05600c224300b003ed29189777sm816403wmm.47.2023.03.13.14.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Mar 2023 14:44:44 -0700 (PDT)
Date: Mon, 13 Mar 2023 17:44:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Message-ID: <20230313174313-mutt-send-email-mst@kernel.org>
References: <20230312083920.2300028-1-elic@nvidia.com>
 <20230312083920.2300028-2-elic@nvidia.com>
 <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230312122355-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548140734E1A0A8A2FD2CE30DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230313172309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481766116A2C074EDA7B3CCDCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481766116A2C074EDA7B3CCDCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "perezma@redhat.com" <perezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Mon, Mar 13, 2023 at 09:34:50PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, March 13, 2023 5:24 PM
> > I mean if this is claiming to fix a performance regression it should have a Fixes:
> > tag with the commit that introduced the regression.
> 
> The fixes tag should be,
> 
> Fixes: deeacf35c922d ("vdpa/mlx5: support device features provisioning")
> 
> Eli,
> Please add.

Hmm okay so to make sure, before this commit device by default
is created without mrg buffers? With the commit it's created
with and what the change does it revert the default
back to what it was?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
