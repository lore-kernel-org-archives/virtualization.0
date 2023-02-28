Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893B0C64ED6
	for <virtualization@archiver.kernel.org>; Tue, 28 Feb 2023 10:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07E4740A68;
	Tue, 28 Feb 2023 10:56:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07E4740A68
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G3eyKOlF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBoWSh4K9dYs; Tue, 28 Feb 2023 10:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 66C90401F1;
	Tue, 28 Feb 2023 10:56:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66C90401F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42186C0032;
	Tue, 28 Feb 2023 10:56:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4ED8C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7017403CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7017403CA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G3eyKOlF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FvANJIhn-ff2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56DD140359
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56DD140359
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677581799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nB/5iQA/ERrIuMdNnPUytn6rExVcHdy0T6L0a8hSUc0=;
 b=G3eyKOlF+1+rl6i3QG0pfau5Vs7rIlc7b0W3BxO/BbnoDZDDOxG0VaaYGauxrSysR4Om/e
 qcR4xDknNgIqq0gcQWT6MMyA7RZHj4XhdKCJyisuR9I3jvnbFi3D+l2Lj62WSnpTZ7QSDZ
 gaWN1qBr1Yi/YirdiqrGbNJNtaSjGfY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-378-OLBOLb9FOzKd3UhY7BSJyw-1; Tue, 28 Feb 2023 05:56:37 -0500
X-MC-Unique: OLBOLb9FOzKd3UhY7BSJyw-1
Received: by mail-wr1-f71.google.com with SMTP id
 m7-20020a056000008700b002c7047ea429so1461425wrx.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Feb 2023 02:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nB/5iQA/ERrIuMdNnPUytn6rExVcHdy0T6L0a8hSUc0=;
 b=VeRfuk6/C6sJFOgsArFOAkyA6JrgRy3qjWslWKgbHMwK0vQQPsmwwxBeX7y2q99SqN
 oZQeXtCgv5HI8tNuPkMQRAjcpEQqgehy2e+Uyy2er3MzopB1eKM4d0czwakGn6BwF/uf
 WIQW7mzOVqW+hDk4wFpzDmw6DTrA1M6F/kGNP6/aJmqcJVwiHCmr/tJAqR9LKbQ6yuyn
 LGL+PR+doHAh/dXPv/gcOhs8iVYFs/vkYlJ2+IRKVKcan8g25GemsGQTHVZJVhbUNaqW
 Nm8CyK5MDeF4O8h2mRwhHkPANmJQtEJysCfKv7o5IyOZ0/2ZDTJ5fAvpr6Mmfl/MSQ/3
 YNkg==
X-Gm-Message-State: AO0yUKVE7Yt2e1xXPx4azJ/14pS04/VL9vG9H/CayRS+1p6DNQ6JuXSh
 RgA8FWM9eaUtjORwh4tX/bCMpvFVuL9fKfSq2QM8LBE8dyZdqHF4tNDJptgDn9I5DZ0/JtztT0b
 s/11ivDK5pCxG+a/LZL5M6XgTsLkoqGHLgQnKAjqhaQ==
X-Received: by 2002:a05:600c:4da4:b0:3ea:e554:7808 with SMTP id
 v36-20020a05600c4da400b003eae5547808mr1859451wmp.19.1677581794988; 
 Tue, 28 Feb 2023 02:56:34 -0800 (PST)
X-Google-Smtp-Source: AK7set8t5/GwTKlOQXUiSLsp1gpZsKknVKhWt62LvswyPXDef6Z7111tgcUhPxqtQuKzFkIe1Yy0Lg==
X-Received: by 2002:a05:600c:4da4:b0:3ea:e554:7808 with SMTP id
 v36-20020a05600c4da400b003eae5547808mr1859429wmp.19.1677581794668; 
 Tue, 28 Feb 2023 02:56:34 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c4f1400b003e20cf0408esm12986061wmq.40.2023.02.28.02.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Feb 2023 02:56:34 -0800 (PST)
Date: Tue, 28 Feb 2023 11:56:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v2] vdpa_sim: set last_used_idx as last_avail_idx in
 vdpasim_queue_ready
Message-ID: <20230228105628.lwd4l2nw6isfjc7c@sgarzare-redhat>
References: <20230203142501.300125-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230203142501.300125-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com,
 Eli Cohen <elic@nvidia.com>, longpeng2@huawei.com
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

On Fri, Feb 03, 2023 at 03:25:01PM +0100, Eugenio P=E9rez wrote:
>Starting from an used_idx different than 0 is needed in use cases like
>virtual machine migration.  Not doing so and letting the caller set an
>avail idx different than 0 causes destination device to try to use old
>buffers that source driver already recover and are not available
>anymore.
>
>Since vdpa_sim does not support receive inflight descriptors as a
>destination of a migration, let's set both avail_idx and used_idx the
>same at vq start.  This is how vhost-user works in a
>VHOST_SET_VRING_BASE call.
>
>Although the simple fix is to set last_used_idx at vdpasim_set_vq_state,
>it would be reset at vdpasim_queue_ready.  The last_avail_idx case is
>fixed with commit a09f493c ("vdpa_sim: not reset state in
>vdpasim_queue_ready").  Since the only option is to make it equal to
>last_avail_idx, adding the only change needed here.
>
>This was discovered and tested live migrating the vdpa_sim_net device.
>
>Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
>Cherry-picked from patch 2/2 of the series [1]. Differences are:
>* Set the value of used_idx at vdpasim_queue_ready instead of fetching
>  from the guest vring like vhost-kernel.
>
>v2: Actually update last_used_idx only at vdpasim_queue_ready.
>
>Note that commit id present in the patch text is not in master but in
>git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
>
>[1] https://lkml.org/lkml/2023/1/18/1041
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa=
_sim.c
>index 6a0a65814626..79ac585e40b9 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -68,6 +68,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim,=
 unsigned int idx)
> 			  (uintptr_t)vq->device_addr);
>
> 	vq->vring.last_avail_idx =3D last_avail_idx;
>+	vq->vring.last_used_idx =3D last_avail_idx;
> 	vq->vring.notify =3D vdpasim_vq_notify;
> }
>
>-- 2.31.1
>

If you need to resend, I'd add a comment in the code following the =

commit description.

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
