Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91980C00144
	for <virtualization@archiver.kernel.org>; Fri, 29 Jul 2022 09:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1018A60E8A;
	Fri, 29 Jul 2022 09:17:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1018A60E8A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MdiwpRv/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KA2eODejKjcb; Fri, 29 Jul 2022 09:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F9A760B32;
	Fri, 29 Jul 2022 09:17:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F9A760B32
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DF61C0035;
	Fri, 29 Jul 2022 09:17:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98F08C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FB2341876
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FB2341876
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MdiwpRv/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lik6IoYRGGCd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:17:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CC2041814
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CC2041814
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659086239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Xz418y7DeHdQl2NjMO3kFzuatxvu8DMltqTqlpmM7w=;
 b=MdiwpRv/DV0zM8TiNHzkIh5tPaahLmrLLtCMsrd9tp0YYD0VQdK7v8e+CW05COCfyDSP0M
 fdCtGW44wPU0OWAPT36HQtgY+pzkJwTh0I/B+kQbF8qGpXJsHsedN9i9ZDbuskWdHva/y8
 v1q9RTYYHMBIrPRx4vTN2RyOf5HD+bw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-QXZjwdcAPy6HaqUkVQUiqA-1; Fri, 29 Jul 2022 05:17:17 -0400
X-MC-Unique: QXZjwdcAPy6HaqUkVQUiqA-1
Received: by mail-ej1-f69.google.com with SMTP id
 gt38-20020a1709072da600b0072f21d7d12dso1564418ejc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 02:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=1Xz418y7DeHdQl2NjMO3kFzuatxvu8DMltqTqlpmM7w=;
 b=5fJ4CTKlZFBwBXom+MxMp8pXQ/SF1ixsJ5l0MBX7yuVdKpptWDJn8y7tmV/vpkKESH
 N42vHIgV9vdNL9LPvCuP9WLa9yUeXQ8FYtykn3Bn1G3XZgYKpVRIfZEy3sYQELl80ncq
 i3TcR2Z4d7zOnP2UZ5yPqYp+d+MmG2Kwjn+cPdSEzuP/prxphdzEECQl/VSvf+G5aE5Z
 ZJ4fqS1eE4pPVsULprGmZTUX1Ir4Tk0hXWPvxP+SjBtu9RhT5PMrWzlMDyi+Vxmkq5Xi
 ibwOYoTjVwbu7G5h9HtNJdEFmbIkmqdHW9IcOLysJ3p1aEjTQRBjAxN4fbiZBnqjoaw2
 K6vA==
X-Gm-Message-State: AJIora90K9Nf3BoC8LlGZ6nfyzMITcLw95ZTL8tChX6nkECiO1ktLxdx
 MVepBhZ4RlmDJz6K61CDeBPPxYl4OrDrKTkaLlEB/IugPOOiVl/Ll6JYCFPKH682El0V/Qwfsuy
 PQLayOpGqiEsedWIjbgszodJrLeeL2QFLwedeIG1OZg==
X-Received: by 2002:a17:907:75e7:b0:72b:51c6:47a2 with SMTP id
 jz7-20020a17090775e700b0072b51c647a2mr2169197ejc.147.1659086236594; 
 Fri, 29 Jul 2022 02:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uN/gs1nJPkDVqaw/s3+VrdvCIZO2VcGD8T7a3ikP7krGYBxWdgjFeV/oKw8/plr0FhJgUrgw==
X-Received: by 2002:a17:907:75e7:b0:72b:51c6:47a2 with SMTP id
 jz7-20020a17090775e700b0072b51c647a2mr2169166ejc.147.1659086236072; 
 Fri, 29 Jul 2022 02:17:16 -0700 (PDT)
Received: from redhat.com ([2.54.183.236]) by smtp.gmail.com with ESMTPSA id
 s11-20020a1709064d8b00b006fee526ed72sm1431449eju.217.2022.07.29.02.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 02:17:15 -0700 (PDT)
Date: Fri, 29 Jul 2022 05:17:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa.c
Message-ID: <20220729051119-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-7-lingshan.zhu@intel.com>
 <20220729045039-mutt-send-email-mst@kernel.org>
 <7ce4da7f-80aa-14d6-8200-c7f928f32b48@intel.com>
MIME-Version: 1.0
In-Reply-To: <7ce4da7f-80aa-14d6-8200-c7f928f32b48@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, gautam.dawar@amd.com
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

On Fri, Jul 29, 2022 at 05:07:11PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 7/29/2022 4:53 PM, Michael S. Tsirkin wrote:
> > On Fri, Jul 01, 2022 at 09:28:26PM +0800, Zhu Lingshan wrote:
> > > This commit fixes spars warnings: cast to restricted __le16
> > > in function vdpa_dev_net_config_fill() and
> > > vdpa_fill_stats_rec()
> > > 
> > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > ---
> > >   drivers/vdpa/vdpa.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 846dd37f3549..ed49fe46a79e 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -825,11 +825,11 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > >   		    config.mac))
> > >   		return -EMSGSIZE;
> > > -	val_u16 = le16_to_cpu(config.status);
> > > +	val_u16 = __virtio16_to_cpu(true, config.status);
> > >   	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> > >   		return -EMSGSIZE;
> > > -	val_u16 = le16_to_cpu(config.mtu);
> > > +	val_u16 = __virtio16_to_cpu(true, config.mtu);
> > >   	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> > >   		return -EMSGSIZE;
> > Wrong on BE platforms with legacy interface, isn't it?
> > We generally don't handle legacy properly in VDPA so it's
> > not a huge deal, but maybe add a comment at least?
> Sure, I can add a comment here: this is for modern devices only.
> 
> Thanks,
> Zhu Lingshan

Hmm. what "this" is for modern devices only here?

> > 
> > 
> > > @@ -911,7 +911,7 @@ static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> > >   	}
> > >   	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> > > -	max_vqp = le16_to_cpu(config.max_virtqueue_pairs);
> > > +	max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > >   	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
> > >   		return -EMSGSIZE;
> > > -- 
> > > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
