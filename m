Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0404CC7EE25
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 16:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 887DE600CD;
	Fri,  9 Jun 2023 16:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 887DE600CD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eoI0pVUE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z3nRVVYxKVMH; Fri,  9 Jun 2023 16:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 362C06058D;
	Fri,  9 Jun 2023 16:15:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 362C06058D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E431BC007A;
	Fri,  9 Jun 2023 16:15:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 494AAC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20E8241909
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20E8241909
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eoI0pVUE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QYPV9EDG9rnp
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:15:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46FD542046
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46FD542046
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686327339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zf+FUtkC9mqfdsOZpegOnxW/GOPDHVBl0ir+KIUQ12Q=;
 b=eoI0pVUE+Jm5ts2vlMVQ1ve2KduSVCIIs1HOgIn1dRFKX7A6UQlhSCbpRoFPo050ohxxCQ
 rA9omNKAjJ6aWFf6SmmOgBX87Ifr2xB3nV3NmPbVMdUVn+7D7EdIGxbITo3jEg+KVLrkTw
 Jw8Of5POYT8v7NUJKBk96x3MXOBs1Ng=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-BEEy99eMP7WBn2IP2ZDDrQ-1; Fri, 09 Jun 2023 12:15:38 -0400
X-MC-Unique: BEEy99eMP7WBn2IP2ZDDrQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f73283f6c7so13470435e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 09:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686327336; x=1688919336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zf+FUtkC9mqfdsOZpegOnxW/GOPDHVBl0ir+KIUQ12Q=;
 b=PfyFnbYVH9R0lSP4IUCWUuq1vgBjPz06jXxfvVCufY9zhC3Sn+Mjf331zzZ3bukq69
 zq6NSVlylBfM+YC2nsLSLIolGmzKUj96E83R086nxG2FYMh4n+5Y0lDzFG41AzCL+Sxa
 XYFg2ynMrHOC0d65qElxrEPbtDxshMmhEITs9diJv56e4e4nrMG8bz6UwjRdfITrlqS2
 6B6U+AqS5NL6vCfy21o5Me5eLpedjefPOmFB28fry+a1Z1+fTn8J17n97mi3LwPoCp7s
 /5Z+CvrgKF1ncwL6wLbwmDzqxAaeLq8Ix/+5ri/k4a+1dYK3b0SYNDUr30w+6bbRb8PB
 TWZQ==
X-Gm-Message-State: AC+VfDxHKGv6b+Z1L82vMGlypZO3d8Z7l6O41fTVOpCKpE1oiExSwT9f
 YK6Xd8trb52H5w13WRRsGjiGUk4chO7bH+x1pLmdTmvwt26wJkqJxVevhpVvIwXTrpY/SzpUnIT
 fYFCnzVA8ecdFCCmAcLHxnSzIExS/VrCVBs4c2+9Wew==
X-Received: by 2002:a05:600c:8511:b0:3f6:eae:7417 with SMTP id
 gw17-20020a05600c851100b003f60eae7417mr4119747wmb.1.1686327336408; 
 Fri, 09 Jun 2023 09:15:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Mmbnzwr6yg1tfn4HXPZJs81Qp1FGmyI0tIQieiJmpyFiePNQ2N/7WykscFamqjV8439wbRA==
X-Received: by 2002:a05:600c:8511:b0:3f6:eae:7417 with SMTP id
 gw17-20020a05600c851100b003f60eae7417mr4119736wmb.1.1686327336129; 
 Fri, 09 Jun 2023 09:15:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5942000000b003063db8f45bsm4828875wri.23.2023.06.09.09.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 09:15:35 -0700 (PDT)
Date: Fri, 9 Jun 2023 12:15:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 0/3] vDPA/ifcvf: enable virtio-net on Intel F2000X-PL
Message-ID: <20230609121512-mutt-send-email-mst@kernel.org>
References: <20230609162200.875433-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230609162200.875433-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Sat, Jun 10, 2023 at 12:21:57AM +0800, Zhu Lingshan wrote:
> Hi
> 
> This series enables vDPA/ifcvf support for virtio-net devices
> on Intel F2000X-PL Infrastructure Processing Unit.
> 
> Please help review


Hard trouble applying - which tree is this against?

> Thanks!
> 
> Zhu Lingshan (3):
>   vDPA/ifcvf: dynamic allocate vq data stores
>   vDPA/ifcvf: detect and report max allowed vq size
>   vDPA/ifcvf: implement new accessors for vq_state
> 
>  drivers/vdpa/ifcvf/ifcvf_base.c | 55 +++++++++++++++++++++++----------
>  drivers/vdpa/ifcvf/ifcvf_base.h | 26 +++++++---------
>  drivers/vdpa/ifcvf/ifcvf_main.c | 10 ++++--
>  3 files changed, 58 insertions(+), 33 deletions(-)
> 
> -- 
> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
