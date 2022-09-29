Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC6C6FA86
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CCAB80060;
	Thu, 29 Sep 2022 07:38:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CCAB80060
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HH8sLW+K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YsZzKa07Mn2y; Thu, 29 Sep 2022 07:38:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E22C83ED3;
	Thu, 29 Sep 2022 07:38:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E22C83ED3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 553ECC0033;
	Thu, 29 Sep 2022 07:38:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C5B9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43DC760687
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:38:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43DC760687
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HH8sLW+K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ItWzW-YK3VgE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:38:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 752A86059D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 752A86059D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664437102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtU8HP1rRMHMXLmU+RcQMq0RJUO/qXYiXZjHcG/czQU=;
 b=HH8sLW+Kz593XUMgW1MQpn4WrCXXiCgNkJTYYdaLuYRF2oUYqaHQlcc7AlbeP1DN+mFLgA
 sB3bGelNrPfbZmgtUNxGJOeqca2p1Enan4iRN45GWTY5gBJMDFCT3s1aladWIlEKkJfacX
 TAbY6YzhYS0si3mqu+0SA+QAkO5LHps=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-223-Q1TR_8mIPKKYxQ6LO3M3Sw-1; Thu, 29 Sep 2022 03:38:21 -0400
X-MC-Unique: Q1TR_8mIPKKYxQ6LO3M3Sw-1
Received: by mail-wm1-f71.google.com with SMTP id
 r128-20020a1c4486000000b003b3309435a9so1846507wma.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=EtU8HP1rRMHMXLmU+RcQMq0RJUO/qXYiXZjHcG/czQU=;
 b=fnNjNurSSOpZ/l9/OMUoH6Gsax/2cWkra7FGZamrYxC9AjpBO8wOlXT0/lERJGibGx
 4G1huPr6wfNXzoTIovLMH6CaUaenggtyfD+xzXywJ1QzEV6/RlLWQSukM67cSqMqLh0G
 zCl3wmebhvcjZFRfPxhnUbtEb1xraFlNVjnE+uo/R+GdBWUkCrc3rf1r2s6LEHVPBkGX
 Ftt14Ne/fCiHC6IYPToKcnbfP7Hms2IogLTxcLyb3k5LJ1dyxC2FQ8u24kCISUZikFxo
 LIMH+ntbeLi3sxH2MwSBrN/VKgxmjiqBIcswq8/Q8ultUrTb7pHXO0xDZgBj8KhVX8LE
 AbbA==
X-Gm-Message-State: ACrzQf0LSILLg4v1GyM7iGBd3bcdJ0J24rPQKtMhpVAjmrKmhfWS0MFc
 QgrJlspcTc+uTvF/oCcjmQeT5ecDFrVLQtVsy72YFX4noZ4WC3rjNh3e/mh0FfPkogJWZvxtcPh
 U+i3P9cXkQIl/pZfR2V9QN6oEoRtlCoXs82rfPBnTxg==
X-Received: by 2002:a05:600c:b47:b0:3b4:8604:410c with SMTP id
 k7-20020a05600c0b4700b003b48604410cmr1224704wmr.51.1664437099831; 
 Thu, 29 Sep 2022 00:38:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5g6rBu5QPYx9aQ8mXAgqZl+RIeinGA8XoV5PQpBXrrGB5+Tr4uCc8Xa8taFU+6U5nEO1ZyHg==
X-Received: by 2002:a05:600c:b47:b0:3b4:8604:410c with SMTP id
 k7-20020a05600c0b4700b003b48604410cmr1224688wmr.51.1664437099556; 
 Thu, 29 Sep 2022 00:38:19 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 z2-20020a05600c0a0200b003b48dac344esm3808228wmp.43.2022.09.29.00.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:38:19 -0700 (PDT)
Date: Thu, 29 Sep 2022 03:38:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 0/6] Conditionally read fields in dev cfg space
Message-ID: <20220929033805-mutt-send-email-mst@kernel.org>
References: <20220929014555.112323-1-lingshan.zhu@intel.com>
 <896fe0b9-5da2-2bc6-0e46-219aa4b9f44f@intel.com>
MIME-Version: 1.0
In-Reply-To: <896fe0b9-5da2-2bc6-0e46-219aa4b9f44f@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Thu, Sep 29, 2022 at 03:23:46PM +0800, Zhu, Lingshan wrote:
> Hi Michael,
> 
> Jason starts his vacation this afternoon, and next week is our national
> holiday.
> He has acked 3 ~ 6 of this series before, and I have made improvements based
> on his comments.
> Do you have any comments on patches 1 and 2?


No, I'll merge for next.

> Thanks,
> Zhu Lingshan
> On 9/29/2022 9:45 AM, Zhu Lingshan wrote:
> > This series intends to read the fields in virtio-net device
> > configuration space conditionally on the feature bits,
> > this means:
> > 
> > MTU exists if VIRTIO_NET_F_MTU is set
> > MAC exists if VIRTIO_NET_F_NET is set
> > MQ exists if VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is set.
> > 
> > This series report device features to userspace and invokes
> > vdpa_config_ops.get_config() rather than
> > vdpa_get_config_unlocked() to read the device config spcae,
> > so no races in vdpa_set_features_unlocked()
> > 
> > Thanks!
> > 
> > Changes form V2:
> > remove unnacessary checking for vdev->config->get_status (Jason)
> > 
> > Changes from V1:
> > 1)Better comments for VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,
> > only in the header file(Jason)
> > 2)Split original 3/4 into separate patches(Jason)
> > 3)Check FEATURES_OK for reporting driver features
> > in vdpa_dev_config_fill (Jason)
> > 4) Add iproute2 example for reporting device features
> > 
> > Zhu Lingshan (6):
> >    vDPA: allow userspace to query features of a vDPA device
> >    vDPA: only report driver features if FEATURES_OK is set
> >    vDPA: check VIRTIO_NET_F_RSS for max_virtqueue_paris's presence
> >    vDPA: check virtio device features to detect MQ
> >    vDPA: fix spars cast warning in vdpa_dev_net_mq_config_fill
> >    vDPA: conditionally read MTU and MAC in dev cfg space
> > 
> >   drivers/vdpa/vdpa.c       | 68 ++++++++++++++++++++++++++++++---------
> >   include/uapi/linux/vdpa.h |  4 +++
> >   2 files changed, 56 insertions(+), 16 deletions(-)
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
