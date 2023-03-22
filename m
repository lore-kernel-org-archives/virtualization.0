Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69393C6FD1C
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 03:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D648361392;
	Wed, 22 Mar 2023 03:36:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D648361392
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OdJRSSoV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWcOzRxNgmlE; Wed, 22 Mar 2023 03:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D5D8610AA;
	Wed, 22 Mar 2023 03:36:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D5D8610AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 416A9C0071;
	Wed, 22 Mar 2023 03:36:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE3ACC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C4F0812F5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:36:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C4F0812F5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OdJRSSoV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RrGnCYyAfg8C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:36:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9522A812BE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9522A812BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679456160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYwWxJKGyGkcEbk27LJ2df/aZ/eiXJ5egJTJFgeX6tY=;
 b=OdJRSSoVHhhUaTMqNhUfuboDhBXuYcFdimhROmlwB+54sQnvcXrEGQPMQpFDMSTC3JphIA
 Bmhe6KwNakxU4OoD8I5rqQzrrX3Mjjyqt3iZgvpFYHJFXpPQonFZqQo3OM1x4wrnvJECDR
 Asvdh4dGn2M95XDQbnCMCBJPpCUwqiw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-RHjkDCr7NQGjdW93tpNEuw-1; Tue, 21 Mar 2023 23:35:58 -0400
X-MC-Unique: RHjkDCr7NQGjdW93tpNEuw-1
Received: by mail-wm1-f72.google.com with SMTP id
 p10-20020a05600c358a00b003edf7d484d4so3276459wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 20:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679456157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYwWxJKGyGkcEbk27LJ2df/aZ/eiXJ5egJTJFgeX6tY=;
 b=0+N6DNxSlV3h2gJ04R+G8hC2rwjUim+bDBOHd4CrKbJHaej5zmkWM2pyoIBnasZZJC
 jXE3RS0Jf4/EEEliRI6vUzUrRedFaN5hlT5TvCiyCCj+EyJJY2bQeMeKEOkETzuqm6io
 8DzwJqXKk59P7pOnDBR/6bAuS6DmEj+goP9Tveqaxe1G2HWXmzeM9GeyUs40FB1rwRnn
 YOGIRX+RyaZ13QdhgJUarHQuwpzz9WjF9n5ofCEgpw2v5GW35T+A9KT5yh6r8DdKZrKv
 rchAPSVkoJ6aA14LPwrFINYNFQuMTxrduE2U5qfGeM2VIuqUHXclgIjM0qUQ06U5ixrf
 lkWw==
X-Gm-Message-State: AO0yUKUq2xzy8A7+01RhyWcyBrO30rWvhTT6HLHMyvKdbstOsEpnm3d5
 XUiqPFpzqoomxVnHhLQW/9Fj6vXipYXljpAQk6nEeevW0lnzxTSj9LGFgBl0TTaM1ATUmCxRygR
 ykPLXbxRBJBpuq2v0AIiaqKMpBmev5O/tqTorGu+d2A==
X-Received: by 2002:a7b:cbc2:0:b0:3ea:e7e7:95d9 with SMTP id
 n2-20020a7bcbc2000000b003eae7e795d9mr4004960wmi.32.1679456157655; 
 Tue, 21 Mar 2023 20:35:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set/A7QlePthVCjUnC3CQ17zYQz0P3R6xekAMm7ZYYjqWbovL/ej8A9wmET4LYM+H+oSMJEvS9A==
X-Received: by 2002:a7b:cbc2:0:b0:3ea:e7e7:95d9 with SMTP id
 n2-20020a7bcbc2000000b003eae7e795d9mr4004954wmi.32.1679456157324; 
 Tue, 21 Mar 2023 20:35:57 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c470a00b003ee11ac2288sm6290235wmo.21.2023.03.21.20.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 20:35:56 -0700 (PDT)
Date: Tue, 21 Mar 2023 23:35:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v4 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by
 default
Message-ID: <20230321233515-mutt-send-email-mst@kernel.org>
References: <20230321112809.221432-1-elic@nvidia.com>
 <20230321112809.221432-2-elic@nvidia.com>
 <20230321232937-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230321232937-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, parav@mellanox.com,
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

On Tue, Mar 21, 2023 at 11:32:36PM -0400, Michael S. Tsirkin wrote:
> On Tue, Mar 21, 2023 at 01:28:08PM +0200, Eli Cohen wrote:
> > Following patch adds driver support for VIRTIO_NET_F_MRG_RXBUF.
> > 
> > Current firmware versions show degradation in packet rate when using
> > MRG_RXBUF. Users who favor memory saving over packet rate could enable
> > this feature but we want to keep it off by default.
> > 
> > One can still enable it when creating the vdpa device using vdpa tool by
> > providing features that include it.
> > 
> > For example:
> > $ vdpa dev add name vdpa0 mgmtdev pci/0000:86:00.2 device_features 0x300cb982b
> > 
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> 
> 
> I have a question. Could you guys try with the recent XDP mergeable
> buffer rework? Does this address the performance issue you are
> observing?
> 
> Specifically:
> 
> Message-Id: <20230322025701.2955-1-xuanzhuo@linux.alibaba.com>
> Message-Id: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
> 
> I would very much appreciate if you posted perf numbers
> in response to that thread - both to help evaluate that
> patchset and this one.
> Thanks!

Oh sorry, I got confused. That is still preparatory work not real
zero copy.  The patchset to try is this:

Message-Id: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>




> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 520646ae7fa0..502c482a93ce 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3122,6 +3122,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >  			return -EINVAL;
> >  		}
> >  		device_features &= add_config->device_features;
> > +	} else {
> > +		device_features &= ~BIT_ULL(VIRTIO_NET_F_MRG_RXBUF);
> >  	}
> >  	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> >  	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
> > -- 
> > 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
