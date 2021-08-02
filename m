Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C229C4338F
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 20:12:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CEB60EFF
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 20:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8CEB60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FA5A404E4;
	Mon,  2 Aug 2021 20:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 41J7gn1y5CuH; Mon,  2 Aug 2021 20:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEF9A404E6;
	Mon,  2 Aug 2021 20:12:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABE9BC001A;
	Mon,  2 Aug 2021 20:12:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C92EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 045F5608CF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4EPVkLvWxlOM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:12:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DF0660A91
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627935127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q52w6Q4YtuhtQOV0oJmgEUraWN88/oaIpPIXQ4cq1HY=;
 b=X1zsVtMxyPq8ML0IVRj6u/GI2c9C27R3iLpBFZ4gbiHTLnDjatq6XyIM2gWG9Ct6irR1C0
 PbcusGMvPCv3gmANmV+mXbn2ThZG3rh5bug027M8PrXKrXCCLuy0kfl50OA2kUMtK2BZDt
 RRcEwb+wF8IsPGiAWWJ0ZfvjT00VCRo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-K8_3LZ6gPcmJ5hZy67cv6A-1; Mon, 02 Aug 2021 16:12:04 -0400
X-MC-Unique: K8_3LZ6gPcmJ5hZy67cv6A-1
Received: by mail-ed1-f70.google.com with SMTP id
 dn10-20020a05640222eab02903bd023ea9f6so4526003edb.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 13:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q52w6Q4YtuhtQOV0oJmgEUraWN88/oaIpPIXQ4cq1HY=;
 b=SIZ88AZkaUIA+oKLF84bhqeO6GJjFOiRGc2bQEXPmh4pNJyiJj30LJ6JnMDIKPhqRd
 P3I4Pfp00uqsJg/BZ1yyt25HDmwIyIdFYesdidIhLjfSOjPTtkZLVMOBCYLCDsa8Kx88
 Ufr/1HWmr01//svSWmLY+ObKOaBQwv1zlqU0ezJWYwrEkiflNpIScKG5LVwIts3/9dPL
 ULYg6nppVHdxwhFGRM6TcSNMRwr88OUivAG/48aiZD36PiQH0WjRB4lGdS1awbS2cWle
 pG9bik0I+dVqATiTth5bFxFAapnwF2rzLwumcwe71b91R8NA3RNvtBcATz0vD5RL27D4
 qs5A==
X-Gm-Message-State: AOAM533RkkcrtGZ2vd52RdUqX14L5cd2727x6BXdAzzHmnetUmgaLOSp
 b78zdPb+p6smwgOXAjJSMhGCycSo4q3xsm7u2n67qNDVBQ0gxspHDZiUAnI2wzMAnF7do9ebSyP
 AYU1Tmlp9bkYPaEDQABDHIYDLHKFQED7PrjTwM25bJg==
X-Received: by 2002:aa7:c0d1:: with SMTP id j17mr21235861edp.217.1627935122740; 
 Mon, 02 Aug 2021 13:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfr39sns4u7IHD+697IXe7EyNtPI7YycI0ox/3uN10j7vd/YANYQrljcKZhj+LRbcxif46Ug==
X-Received: by 2002:aa7:c0d1:: with SMTP id j17mr21235843edp.217.1627935122638; 
 Mon, 02 Aug 2021 13:12:02 -0700 (PDT)
Received: from redhat.com ([2.55.140.205])
 by smtp.gmail.com with ESMTPSA id o7sm4957679ejy.48.2021.08.02.13.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 13:12:02 -0700 (PDT)
Date: Mon, 2 Aug 2021 16:11:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: fuguancheng <fuguancheng@bytedance.com>
Subject: Re: [PATCH 1/4] VSOCK DRIVER: Add multi-cid support for guest
Message-ID: <20210802161055-mutt-send-email-mst@kernel.org>
References: <20210802120720.547894-1-fuguancheng@bytedance.com>
 <20210802120720.547894-2-fuguancheng@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210802120720.547894-2-fuguancheng@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andraprs@amazon.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, colin.king@canonical.com, kuba@kernel.org,
 arseny.krasnov@kaspersky.com, davem@davemloft.net
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

On Mon, Aug 02, 2021 at 08:07:17PM +0800, fuguancheng wrote:
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 3dd3555b2740..0afc14446b01 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -42,7 +42,8 @@
>  #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>  
>  struct virtio_vsock_config {
> -	__le64 guest_cid;
> +	__le32 number_cid;
> +	__le64 cids[];
>  } __attribute__((packed));

any host/guest interface change needs to copy the virtio TC.
packing here is a bad idea imho, just add explicit padding.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
