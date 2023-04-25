Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE300C77B61
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 06:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7524A60ADD;
	Tue, 25 Apr 2023 06:09:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7524A60ADD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aFj076Vw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PPPVlX1PYl21; Tue, 25 Apr 2023 06:09:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF414607A3;
	Tue, 25 Apr 2023 06:09:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF414607A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF114C0037;
	Tue, 25 Apr 2023 06:09:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6182EC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26B3B408B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:08:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26B3B408B1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aFj076Vw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LEAe9qCvbpA9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:08:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1173C408B0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1173C408B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 06:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682402936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZlsSuAo9jEF2ded6btyLYNb+j2rnAPzZnmrQ1QOfh0=;
 b=aFj076VwO/igkZ1AmgZaZytKtSi+QMacIJi4U3yaWOgtujzlHsljCmXk6c2z1KE72QqmSJ
 RxPAfbzocknXbiXxwvgOcgiRjA8VCBt08v/Vyl799H2yOiLA7ZQCIuhe4lKw2g7CIgBcCf
 lvcz57doyaffAdGodqbXKqluTYK6rAA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-LB1-caT8O9WTR6nLaA3TBw-1; Tue, 25 Apr 2023 02:08:55 -0400
X-MC-Unique: LB1-caT8O9WTR6nLaA3TBw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f080f9ea3eso19855645e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 23:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682402934; x=1684994934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZlsSuAo9jEF2ded6btyLYNb+j2rnAPzZnmrQ1QOfh0=;
 b=aibkErhuclrYVkmfoosEkDzSxY8JVUa4BH9J1A7QYYAJh6lWBcrLHGqiYgZQYFRkAf
 8AwgldHmfdINu4xqlZMw5VSoET35VIyUX6hpQPRHTqRMTWzLgVPbJ2VXS+O/IPrZGhTF
 oOp28LLbIcQ9WD+gLgElLX7T+DGqTidFCgu+yXZYldKAYZQw2oljiIFOzg9pvNne0a9e
 NsA8Q7ib6mRxFxemT3CFxKlblS6WjFJRbKSyb+ssYQSucYmEVzJVeMlAZkYDXVldnCh1
 N066jXKNESpv/EIzPDnACqpbnsiUw6Ur/Jt1rLATIhXm1GdqJCL26UsyQtUCNY9lPsgw
 yjVQ==
X-Gm-Message-State: AAQBX9eZY06NWvC8sMQpLhLaTYMZH072yYVJ0zlfRXc9xKZWiqf6vdtB
 A/t9VwyqOA3EYscY8puXbu63B1iXaIzQrBsr8Q4Vn7D98uIg53IXrnDOmq/u1dRO5FgXIjg8BgR
 bD93ZeAjtu4SvxxfT7qlzWd3FEVLs8cp/8YIWrnCh3A==
X-Received: by 2002:a5d:4d06:0:b0:2e5:d4f4:c43b with SMTP id
 z6-20020a5d4d06000000b002e5d4f4c43bmr12448159wrt.55.1682402934087; 
 Mon, 24 Apr 2023 23:08:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350bqvTlTRUue79/Y/sok1CXVeWwZMNTh7JrSnMb7qA31YTWKmmruNb+Lt/4r1++Z9XvhddGSEA==
X-Received: by 2002:a5d:4d06:0:b0:2e5:d4f4:c43b with SMTP id
 z6-20020a5d4d06000000b002e5d4f4c43bmr12448148wrt.55.1682402933728; 
 Mon, 24 Apr 2023 23:08:53 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 p17-20020a056000019100b002fda1b12a0bsm12361174wrx.2.2023.04.24.23.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Apr 2023 23:08:53 -0700 (PDT)
Date: Tue, 25 Apr 2023 02:08:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 0/3] vhost_vdpa: better PACKED support
Message-ID: <20230425020807-mutt-send-email-mst@kernel.org>
References: <20230424225031.18947-1-shannon.nelson@amd.com>
MIME-Version: 1.0
In-Reply-To: <20230424225031.18947-1-shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: drivers@pensando.io, virtualization@lists.linux-foundation.org
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

On Mon, Apr 24, 2023 at 03:50:28PM -0700, Shannon Nelson wrote:
> While testing our vDPA driver with QEMU we found that vhost_vdpa was
> missing some support for PACKED VQs.  Adding these helped us get further
> in our testing.  The first patch makes sure that the vhost_vdpa vqs are
> given the feature flags, as done in other vhost variants.  The second
> and third patches use the feature flags to properly format and pass
> set/get_vq requests.

This missed the merge window most likely, unless there's
a reason to send a second pull towards the end of it. We'll see.

> v1:
>  - included wrap counter in packing answers for VHOST_GET_VRING_BASE
>  - added comments to vhost_virtqueue fields last_avail_idx and last_used_idx
> 
> v0:
>    https://lists.linuxfoundation.org/pipermail/virtualization/2023-April/066253.html
>  - initial version
> 
> Shannon Nelson (3):
>   vhost_vdpa: tell vqs about the negotiated
>   vhost: support PACKED when setting-getting vring_base
>   vhost_vdpa: support PACKED when setting-getting vring_base
> 
>  drivers/vhost/vdpa.c  | 34 ++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.c | 18 +++++++++++++-----
>  drivers/vhost/vhost.h |  8 ++++++--
>  3 files changed, 49 insertions(+), 11 deletions(-)
> 
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
