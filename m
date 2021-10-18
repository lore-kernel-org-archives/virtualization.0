Return-Path: <SRS0=YY9U=PG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D1C433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 09:15:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BE9610C7
	for <virtualization@archiver.kernel.org>; Mon, 18 Oct 2021 09:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26BE9610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DCFA0401E5;
	Mon, 18 Oct 2021 09:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bj0ncDAiAeqJ; Mon, 18 Oct 2021 09:15:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F3F3400FF;
	Mon, 18 Oct 2021 09:15:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01B26C000F;
	Mon, 18 Oct 2021 09:15:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8627EC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71C5181D5F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:15:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XAp1-P_DoJKe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:15:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 344E181C58
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634548532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xcdENWysQqYYvUn/ltLBtYWjzhYGiS7h1lmtIvy4W3o=;
 b=Z5ven1SD2Nrh7usKB/50HmVHpqPH6VBciMaLA8zj+CPbsCFhzV1jkx7CExj5u6X84wV0cE
 3TmDB2GoqTxgRVTXvP3LYa4gcGHETBbTzuQM+/uw++UqO8Gr0KydLFI8iXkMMKxukaHZkr
 Tx/Mk2XnbQILpgfR8QkmVvO8OjbpMIE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-NLCAtULENcmP-jSKPvMSpQ-1; Mon, 18 Oct 2021 05:15:31 -0400
X-MC-Unique: NLCAtULENcmP-jSKPvMSpQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 i7-20020a50d747000000b003db0225d219so9143152edj.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 02:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xcdENWysQqYYvUn/ltLBtYWjzhYGiS7h1lmtIvy4W3o=;
 b=aMO9qHiehcHakxrZL3EUb3C/ODHjMnlKtK3QBGEcDrx9+JWyIEZDAm3u4gso/8UyDH
 LR4YrKTquPsc/8E57V1NEkQb5Qw8r8rEdKTrKUYnkz6zjlnuVjID9E5wu/qQyT7a+71U
 VeJISmSBXzLEihUWsVNPr5nD97NDg60t7VblLT4sq5Mpx3hI2/bNwXpFTHm5q6rNWm63
 hnIJBGfXrBNrAhI8BEoRgGjTGvYCeoNu5Go/s0DZgpo9pkeriiTtjT1zDWE1EKfs4nVe
 VY3pfXM3V8kA101ut8Piz1sSSzaXYDE2n3let/YJUv9dlZ6ZoRsYjJeUizxpuD26LQKu
 IuhQ==
X-Gm-Message-State: AOAM530fjY9U8eOtWJGLZo1qODU9OsRB06UZKY9mlCBUGQGoDSGe7tyz
 p5nX7sCcB6JpV9ONHkNGI4WECFCabQ9ZMqei1WKDGaNjLXN8VTxzH6+93+I2gmvWUKsPmX8FIme
 jtCyxGgis4oQftlg6OiNZ77GQmWJ04I78REJ/u4PJgA==
X-Received: by 2002:a17:906:4ed9:: with SMTP id
 i25mr28743866ejv.228.1634548530491; 
 Mon, 18 Oct 2021 02:15:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPmR1oxG9vkjlbau/0XVz9OzNNHaFQkgFz5KaQWDoYJwt6PRiKPg0FuUx5TmYbApQq9XISug==
X-Received: by 2002:a17:906:4ed9:: with SMTP id
 i25mr28743847ejv.228.1634548530303; 
 Mon, 18 Oct 2021 02:15:30 -0700 (PDT)
Received: from steredhat (host-79-34-250-211.business.telecomitalia.it.
 [79.34.250.211])
 by smtp.gmail.com with ESMTPSA id dt4sm8496581ejb.27.2021.10.18.02.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 02:15:29 -0700 (PDT)
Date: Mon, 18 Oct 2021 11:15:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v4 1/3] vdpa: Skip protected ram IOMMU mappings
Message-ID: <20211018091527.ppfrp5c7jl3kfur6@steredhat>
References: <20211014141236.923287-1-eperezma@redhat.com>
 <20211014141236.923287-2-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211014141236.923287-2-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 14, 2021 at 04:12:34PM +0200, Eugenio P=E9rez wrote:
>Following the logic of commit 56918a126ae ("memory: Add RAM_PROTECTED
>flag to skip IOMMU mappings") with VFIO, skip memory sections
>inaccessible via normal mechanisms, including DMA.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
> hw/virtio/vhost-vdpa.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
