Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A63C00144
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 19:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C17FA400E4;
	Tue, 26 Jul 2022 19:49:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C17FA400E4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DPQBR0Jp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sWXgmD3jHDtw; Tue, 26 Jul 2022 19:49:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3EB9740012;
	Tue, 26 Jul 2022 19:49:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EB9740012
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C770C0033;
	Tue, 26 Jul 2022 19:49:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87F6AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 19:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54714400D8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 19:49:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54714400D8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lTPmQrd4rJnz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 19:48:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70CE240012
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70CE240012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658864938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4W4k8N5drQJsdvsOqmfMYTc9AkddbThD/GEQ+8d7Sc=;
 b=DPQBR0JplCG+PbXl6HHN+LYbWfy3IrCR8yrnGSwyjNvH9VQjjYr3hP8lWyXyjS8KA95xXt
 HHPXeZaq+BDgXATlBI+9YA3ZWIASt0bazwm7UwR3ccc8Kt9ksUL3A0lxT3gqwGaaOWvzeN
 fATlobaAzEtLRamYBCufr0G4nZuVcao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-wm89caXWNnWIgSJA2k5yNw-1; Tue, 26 Jul 2022 15:48:57 -0400
X-MC-Unique: wm89caXWNnWIgSJA2k5yNw-1
Received: by mail-wm1-f70.google.com with SMTP id
 t25-20020a1c7719000000b003a3564fa721so3790635wmi.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 12:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=h4W4k8N5drQJsdvsOqmfMYTc9AkddbThD/GEQ+8d7Sc=;
 b=wX7sii0hzG84qpQ3OPNHnDNwXIRDlVc1bUaJWmYG5ndOA4eWOwQylb6JJk8oAIQYSl
 Qf1TLm283G7TK0jmTRZybNrJCbtQRIVDsXMmvRFGz8DyPtzkKay4wvS8c6ir3+EjwXbL
 boNA17VHTLaUcg0YE+meSWdfBNntNxnf3v9mOIOp7L3I5kWSHQNTSl3bvg1uJHstKtYd
 0VSK035vjfOn/krU49AGnaq+FoEqI57Pj2qViHlw5wpgVND4AppjQdNC+JCZsQ3EUIoH
 9OyQA7Y1UVAN04cGHAXhVvRp4uFOnzzqsDFCMVUyIX05fqWClH4SQyyVhaL4NV+/Yv2W
 Ebpw==
X-Gm-Message-State: AJIora+11r9qeOWA1EnSGyeZpOi5XqnZJMZ6xXYwhileWcyDv+vm3vhG
 XYgDQy+/t5/VvMVFZ6Q8tItjaVAsG850M60fY3BXi1tQvW8Rj808KJXLP51XBIy0Mv9qzD7n6V7
 ln6K3rfDDHFrDYtYoGKR/E5kTDSZRhJ8AoAI/G7MhUA==
X-Received: by 2002:a7b:c7d8:0:b0:3a3:1b8a:97a4 with SMTP id
 z24-20020a7bc7d8000000b003a31b8a97a4mr542843wmk.160.1658864934578; 
 Tue, 26 Jul 2022 12:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tlej1ETE/gaBJNxgTakMhYrg+HP9txSBXb8RhBbcX1b6PoXkUF9gyXs90SnjmmLAVx8vQqNQ==
X-Received: by 2002:a7b:c7d8:0:b0:3a3:1b8a:97a4 with SMTP id
 z24-20020a7bc7d8000000b003a31b8a97a4mr542818wmk.160.1658864934023; 
 Tue, 26 Jul 2022 12:48:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7424:0:3d16:86dc:de54:5671])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c35cd00b003a046549a85sm24811524wmq.37.2022.07.26.12.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 12:48:53 -0700 (PDT)
Date: Tue, 26 Jul 2022 15:48:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220726154704-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-6-lingshan.zhu@intel.com>
 <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220713011631-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BE59EDF381F5C0849C08DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481BE59EDF381F5C0849C08DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Tue, Jul 26, 2022 at 03:54:06PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, July 13, 2022 1:27 AM
> > 
> > On Fri, Jul 01, 2022 at 10:07:59PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > Sent: Friday, July 1, 2022 9:28 AM
> > > > If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue
> > > > pair, so when userspace querying queue pair numbers, it should
> > > > return mq=1 than zero.
> > > >
> > > > Function vdpa_dev_net_config_fill() fills the attributions of the
> > > > vDPA devices, so that it should call vdpa_dev_net_mq_config_fill()
> > > > so the parameter in vdpa_dev_net_mq_config_fill() should be
> > > > feature_device than feature_driver for the vDPA devices themselves
> > > >
> > > > Before this change, when MQ = 0, iproute2 output:
> > > > $vdpa dev config show vdpa0
> > > > vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false
> > > > max_vq_pairs 0 mtu 1500
> > > >
> > > The fix belongs to user space.
> > > When a feature bit _MQ is not negotiated, vdpa kernel space will not add
> > attribute VDPA_ATTR_DEV_NET_CFG_MAX_VQP.
> > > When such attribute is not returned by kernel, max_vq_pairs should not be
> > shown by the iproute2.
> > >
> > > We have many config space fields that depend on the feature bits and
> > some of them do not have any defaults.
> > > To keep consistency of existence of config space fields among all, we don't
> > want to show default like below.
> > >
> > > Please fix the iproute2 to not print max_vq_pairs when it is not returned by
> > the kernel.
> > 
> > Parav I read the discussion and don't get your argument. From driver's POV
> > _MQ with 1 VQ pair and !_MQ are exactly functionally equivalent.
> But we are talking from user POV here.

From spec POV there's just driver and device, user would be part of
driver here.

> > 
> > It's true that iproute probably needs to be fixed too, to handle old kernels.
> > But iproute is not the only userspace, why not make it's life easier by fixing
> > the kernel?
> Because it cannot be fixed for other config space fields which are control by feature bits those do not have any defaults.
> So better to treat all in same way from user POV.

Consistency is good for sure. What are these other fields though?
Can you give examples so I understand please?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
