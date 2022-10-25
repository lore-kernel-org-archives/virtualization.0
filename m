Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A4BC38A2D
	for <virtualization@archiver.kernel.org>; Tue, 25 Oct 2022 04:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02CA040299;
	Tue, 25 Oct 2022 04:05:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02CA040299
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlpyA55O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id docric7KkIuM; Tue, 25 Oct 2022 04:05:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01A3A402D7;
	Tue, 25 Oct 2022 04:05:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01A3A402D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4144C0033;
	Tue, 25 Oct 2022 04:05:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95B2AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 04:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FC4C608B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 04:05:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FC4C608B7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlpyA55O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gecfXwu0vs6w
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 04:05:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1770560899
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1770560899
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 04:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666670705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGQAN5QfmAdIFxH4zxQ7DPOdP0CTozat81OxKPl1IMM=;
 b=MlpyA55OSbyZhZ8NeRXnJX5SrNIRtare+mbpe+UPJV1C50RTnbEXMMV2PVPOpZa2sGsu8m
 DymuLjU6I7zznQu/eWVHf/ieX4wQKCS6Q+rnJQ0JsdCWeOwyreF6qynN0bL2jKbIxjDsM6
 08/agQbUxU4soFTIR/PVz+aq7lWKnKc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-YjIhvQx5MUuxSOVZX0acsA-1; Tue, 25 Oct 2022 00:05:04 -0400
X-MC-Unique: YjIhvQx5MUuxSOVZX0acsA-1
Received: by mail-wr1-f71.google.com with SMTP id
 h18-20020adfa4d2000000b00236584fc8c7so3482159wrb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 21:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGQAN5QfmAdIFxH4zxQ7DPOdP0CTozat81OxKPl1IMM=;
 b=6EJ3BcW4aqysAMvWuGY8U9E1cAqoGs/5UW8mAuEYUi/AUo+0x/RjQFOHnT1HAHBXbc
 ScLUfkuvZ62BbixCpl0sXzCvEJeHTV4neOsrFQbo6DvxCTZklwahwbzA4Phsiu21bGbN
 PHx6tDuZUWveGW8Im/yf+Dcg3WA9uqN7f4TEIFQiO5RvuPWFANWLruKE7a6em52huZ1F
 uxUpkiaPgKKYu6ElxSi0t/4cyI5+2hHS5mltCrnIRDx1gFBIxmxfiisAx3S8Iq2ZGO7W
 G5TkqXyRJYluO1QH/89d3k965gp45iCdPlBaKQSwzjC40UlsH7+qEUpn46XoLBc8++av
 oLnQ==
X-Gm-Message-State: ACrzQf162nUhlypSvXcb4qoNZpf0hys/AV7k+ImO9tA3qhnEI8Aok7iP
 P5KV1tQIJYqqKP+Q/EB+EZ2TN1rsx43zEQjcSeeMGwT9SmShweX/kMtOZHZrQA2mqRmEcAha1aB
 EOUQHjln8Tt7IroUCuihM7DP/EludVwA4GmfowgnD7g==
X-Received: by 2002:a05:600c:1822:b0:3c7:103:f9be with SMTP id
 n34-20020a05600c182200b003c70103f9bemr22816972wmp.195.1666670702988; 
 Mon, 24 Oct 2022 21:05:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6GrspV0Rv4ooc27M/ZkGRCgHDhw7hvK7fug9mQV9MrYrQcfzp+yqeg/SM+IxYTvSy/l/z7tw==
X-Received: by 2002:a05:600c:1822:b0:3c7:103:f9be with SMTP id
 n34-20020a05600c182200b003c70103f9bemr22816959wmp.195.1666670702802; 
 Mon, 24 Oct 2022 21:05:02 -0700 (PDT)
Received: from redhat.com ([2.52.24.36]) by smtp.gmail.com with ESMTPSA id
 r7-20020a1c2b07000000b003c6f3e5ba42sm9660282wmr.46.2022.10.24.21.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Oct 2022 21:05:02 -0700 (PDT)
Date: Tue, 25 Oct 2022 00:04:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Subject: Re: [PATCH v3 0/1] virtio_bt: Fix alignment in configuration struct
Message-ID: <20221025000433-mutt-send-email-mst@kernel.org>
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org
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

On Mon, Oct 24, 2022 at 03:40:32PM +0200, Igor Skalkin wrote:
> According to specification [1], "For the device-specific configuration
> space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> and aligned accesses for 32 and 64 bit wide fields.".
> 
> Current version of the configuration structure has non-aligned 16bit
> fields.
> 
> This patch adds a second, aligned  version of the configuration structure
> and a new feature bit indicating that this version is being used.


subject should be v4 but besides that, ok.
Will a spec patch be forthcoming?

> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf
> 
> Changes in v4:
>   v3 was corrupted by our smtp server.
> Changes in v3:
>   v2 had been sent from the wrong address, fixed.
> Changes in v2:
>   The first version of this patch just changed the configuration
>   structure in uapi/linux/virtio_bt.h
>   This can not be done, because it will break the userspace, so the
>   second version offers a less radical approach - it introduces a new
>   feature bit and a new configuration structure that both the device
>   and the driver will use if this bit is negotiated.
> 
> Igor Skalkin (1):
>   virtio_bt: Fix alignment in configuration struct
> 
>  drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
>  include/uapi/linux/virtio_bt.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> -- 
> 2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
