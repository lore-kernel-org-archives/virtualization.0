Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E77C38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 10:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9623F41C22;
	Fri, 27 Jan 2023 10:53:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9623F41C22
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bFJtEerF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zaxuLdYlANa5; Fri, 27 Jan 2023 10:53:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D221841BEE;
	Fri, 27 Jan 2023 10:53:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D221841BEE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94500C0032;
	Fri, 27 Jan 2023 10:53:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0621C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78D5241B48
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:53:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78D5241B48
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eTve0TvKJrEC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:53:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A26E41570
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A26E41570
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674816825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJ1GI3G85fJFqYm06GI8lKzcGyIkLgYi7jejhumzexw=;
 b=bFJtEerFWWD0P5z0Erqra4y6q2+IC3ECA+Y2Xcrf09cLMKWGjcyjBFYfYuMgwK+jNPLdQn
 8NMV3XNIwo8cABoi4ZoQOqoWeJ5W6cQEkW3iNHoQMq2YPZGU58vf0fRDHS6T7pu/Y+O4vM
 S5WuNXQ2eMK89Mwq5DAANANXtRyxpTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-S5SfFe6bOYewqS3tun0xpQ-1; Fri, 27 Jan 2023 05:53:42 -0500
X-MC-Unique: S5SfFe6bOYewqS3tun0xpQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 o22-20020a05600c511600b003db02b921f1so4436559wms.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 02:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wJ1GI3G85fJFqYm06GI8lKzcGyIkLgYi7jejhumzexw=;
 b=OYsjkLP8AGdtkqHKawvTHJveXg3rL+EoX146+Jhy9wGqg01u+m8EAL+JGrH8JnXq8h
 I96ijV0l5X3OYzsh7DZ0jy1I8II61lp54CYa3Hf5PHt0zaKwqfStJ/SgPnJpPRwBlXKZ
 iYAPUiWHkzBNCZFIaLpxVF26jAKPYdJImciOzKXVwstdxDyYhGak4TzETTNa4FgkwKuh
 /On5JhNuJSgiCY7ORxs6EVkxNtS/9ZLTG9wJeMzk2ZJySmAw8hbU7VFdQukeLoHUwdOV
 rtzj7xc/rKFocXGxycYQC0AEfZeqn4H1gXCH70VlOfAewMnKLikBg4ksmM85EaGGFGZA
 VxXw==
X-Gm-Message-State: AFqh2koxZc8Nr+wGJz47Goz2Bo39O970VrRKIVQiIDOPV4tfy7ewYcyo
 zbItXRIQeL7yVetCzMpRp5w+AhoQP2QOKjnkBzJRoybnBvNI7akN7R2D09E61ExNIjVaGP+56aO
 oOblYWihJe4aVl3vy+NcDaOv4XBzxE821gF/wvIC+1w==
X-Received: by 2002:a05:600c:4a27:b0:3db:3ef:2369 with SMTP id
 c39-20020a05600c4a2700b003db03ef2369mr38655065wmp.40.1674816821129; 
 Fri, 27 Jan 2023 02:53:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtRdTDcoX64da1qVXSSsJF8re3QcHQbT7S3uNuQv82lkftjUWFmD9UXAuPYItMnIUX9MLx2Sg==
X-Received: by 2002:a05:600c:4a27:b0:3db:3ef:2369 with SMTP id
 c39-20020a05600c4a2700b003db03ef2369mr38655044wmp.40.1674816820937; 
 Fri, 27 Jan 2023 02:53:40 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 l4-20020a05600c1d0400b003db2dede1a2sm8068848wms.26.2023.01.27.02.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 02:53:40 -0800 (PST)
Date: Fri, 27 Jan 2023 05:53:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 0/2] Fix expected set_vq_state behavior on vdpa_sim
Message-ID: <20230127055303-mutt-send-email-mst@kernel.org>
References: <20230118164359.1523760-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230118164359.1523760-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jan 18, 2023 at 05:43:57PM +0100, Eugenio P=E9rez wrote:
> The use of set_vq_state is to indicate vdpa device the state of a virtque=
ue.
> In the case of split, it means the avail_idx.  This is mandatory for use
> cases like live migration.
> =

> However, vdpa_sim reset the vq state at vdpasim_queue_ready since it calls
> vringh_init_iotlb.
> =

> Also, to starting from an used_idx different than 0 is needed in use case=
s like
> virtual machine migration.  Not doing so and letting the caller set an av=
ail
> idx different than 0 causes destination device to try to use old buffers =
that
> source driver already recover and are not available anymore.
> =

> This series fixes both problems allowing to migrate to a vdpa_sim_net dev=
ice.

Jason problems you pointed out are all consmetic do you ack
the patchset? Or expect another revision?

> Eugenio P=E9rez (2):
>   vdpa_sim: not reset state in vdpasim_queue_ready
>   vringh: fetch used_idx from vring at vringh_init_iotlb
> =

>  drivers/vdpa/vdpa_sim/vdpa_sim.c |  2 ++
>  drivers/vhost/vringh.c           | 25 +++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
> =

> -- =

> 2.31.1
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
