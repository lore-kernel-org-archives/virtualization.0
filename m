Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FC4C433FE
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 14:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E25CA84348;
	Thu, 19 May 2022 14:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cAMYfwbBwdLz; Thu, 19 May 2022 14:48:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8111184329;
	Thu, 19 May 2022 14:48:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA40C0039;
	Thu, 19 May 2022 14:48:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11779C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 14:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EBA3760B5C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 14:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPNYEIpUIoqQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 14:48:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97D6260B0E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652971689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OAuMmOz0HL+Uy2U9iB8Am39R1ctikhJNEflzxuIzxs=;
 b=THEFu1p75ij2yqnzvzlvt9WzA+J3HLgsHf8t3oOpxLa+DijOWp/Kwr2bgC0lGx9Nku7XjA
 Y/53xSdLNeBtiE2q2xCtUuhB9J3Py+udceoBq2WYQEEKi0Qptt1HGbNi1DbvKUpFsaWoxm
 Ghw08vYwTGjApTRkDO9q8MnzjVI4EaU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-2n3J1tfqNc-sKO0MzTAn-A-1; Thu, 19 May 2022 10:48:08 -0400
X-MC-Unique: 2n3J1tfqNc-sKO0MzTAn-A-1
Received: by mail-wm1-f70.google.com with SMTP id
 k5-20020a05600c0b4500b003941ca130f9so2150526wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1OAuMmOz0HL+Uy2U9iB8Am39R1ctikhJNEflzxuIzxs=;
 b=2ReB24WuFZbro2y985yDSq8ut314oH8zlQXMjR94w4gCgt5buaVFgjcBU0cwIrYu1T
 td/KZGAOXAVuhJjZnhvuEKUmYWipJdViK+OVXGIOH9Q+vVaVd89DrTXeX8NwBkP48jG2
 Zhi4aQdaPbXwHFDMTzq+XSSiiEEhr1fDUaRbDI3GQJoAh4jc8PerqC3/SkSprJOOgn0S
 Ph8xqUYfsP7MP0rJ4Oaf/Ep7lntcr7GuGzRg0JJZwXaeRqpe2UVaNgXnj2Qa4s+7DAy9
 zKDq32TWRV7vU/mfuySfnPgfwU9Vtky1oCTyyoBSbrDzQJbVhTLJaApVzoYypawLWKQL
 T0rw==
X-Gm-Message-State: AOAM532Jf2mZ1riYPE4f5esSyhwgfHHdDAN2b/PHYeA3wnbVsSG2NMHe
 Zly3hslat5Z1uZsOW+QiuIFnKFN5lmYxjhetCtJOOO8QLv9R8gLNJWSnIfGUv2Ef+fMcsC9Bzlv
 jdTaRV4jAWmIpUGRsdYagba4MzM3CCN15m2Nqs1Aung==
X-Received: by 2002:a05:600c:198f:b0:394:952d:9a72 with SMTP id
 t15-20020a05600c198f00b00394952d9a72mr4627442wmq.72.1652971687153; 
 Thu, 19 May 2022 07:48:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrkzJZYLrUDEogMR26ucPZYo2pitwKWmbuBkCcZMZ+f7N5rGYODtRfu066599B6CWYFRn8fg==
X-Received: by 2002:a05:600c:198f:b0:394:952d:9a72 with SMTP id
 t15-20020a05600c198f00b00394952d9a72mr4627423wmq.72.1652971686920; 
 Thu, 19 May 2022 07:48:06 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 189-20020a1c02c6000000b00397342bcfb7sm787758wmc.46.2022.05.19.07.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 07:48:06 -0700 (PDT)
Date: Thu, 19 May 2022 16:48:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpasim: allow to enable a vq repeatedly
Message-ID: <20220519144801.m7ioxoa5beo5jzv7@sgarzare-redhat>
References: <20220519143145.767845-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220519143145.767845-1-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, eli@mellanox.com,
 lingshan.zhu@intel.com
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

On Thu, May 19, 2022 at 04:31:45PM +0200, Eugenio P=E9rez wrote:
>Code must be resilient to enable a queue many times.
>
>At the moment the queue is resetting so it's definitely not the expected
>behavior.
>
>Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>Cc: stable@vger.kernel.org
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa=
_sim.c
>index ddbe142af09a..b53cd00ad161 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -355,9 +355,10 @@ static void vdpasim_set_vq_ready(struct vdpa_device *=
vdpa, u16 idx, bool ready)
> 	struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
>
> 	spin_lock(&vdpasim->lock);
>-	vq->ready =3D ready;
>-	if (vq->ready)
>+	if (!vq->ready) {
>+		vq->ready =3D ready;
> 		vdpasim_queue_ready(vdpasim, idx);
>+	}

But this way the first time vq->ready is set to true, then it will never =

be set back to false.

Should we leave the assignment out of the block?
Maybe after the if block to avoid the problem we are fixing.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
