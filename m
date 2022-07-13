Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DBEC433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 05:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D167D4231D;
	Wed, 13 Jul 2022 05:27:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D167D4231D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aANZnG2g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vsIR2AnN3dtQ; Wed, 13 Jul 2022 05:27:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 29D1441A58;
	Wed, 13 Jul 2022 05:27:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29D1441A58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 057F0C0033;
	Wed, 13 Jul 2022 05:27:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AA15C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 532C76132D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:27:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 532C76132D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aANZnG2g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8gDBypbZXwlK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:27:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8378461353
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8378461353
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657690025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z/8AW1mLy0vS7+l6IodLYuxxHB7nmU0fVG4Vd5xB/EI=;
 b=aANZnG2gf9JFioKX5iKz4T/fHD9pmfl4K0smz5DzLxnDY5Ta2MZYl9Nux4P1hyaA7ianjN
 mOEUbkpNHJue5JhPkskNWutMb7PhDbbNliAlZz94wOesTGKf10R8pxZuTb4E5oXwrOe7kT
 lGuiBkAXppeqk+ivoN5j9zknXkyoOis=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-lJaObr1VNTSBpCmC3EeA6g-1; Wed, 13 Jul 2022 01:27:03 -0400
X-MC-Unique: lJaObr1VNTSBpCmC3EeA6g-1
Received: by mail-wm1-f71.google.com with SMTP id
 v67-20020a1cac46000000b003a2be9fa09cso5055967wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 22:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z/8AW1mLy0vS7+l6IodLYuxxHB7nmU0fVG4Vd5xB/EI=;
 b=B1KA5AdDahnzGcF19hMcsAzEf44huVTqZI2nQFoU+/rGSN2nlMnYW1KUStvBsRjzIP
 8pIKPiwet1bEk7KiClidTwtHSjpkMQoH1ITPwbQpwSnWZorFHhc5XGgd8nElozPgkpIa
 bnyzvDFq3MpLl1BbvkncYpE9q86CIffgxHs5Y1qKY4oYsD+OQ+59rOEeMlj8zAELVjef
 D+/4Ok7Mxd2WD0wlLTKs4e6TPU8B5c7nfh2dSFF5slt190+9IUc7Qes9/Tsvl9kU/FX2
 uBERzM2EzD9YkRC50WjY9ok6c0F8QZ6ZFlIrJWdZInt/rvyt6zUfUOiFYP2fsY91/Y4T
 wKSA==
X-Gm-Message-State: AJIora8XrqLy4527ZjIvDI8GOcPooBJjA1bp4nM2lQYccMNXl94pq8nG
 H4x5DA4K3eDYQfRvQb6qYpgy3C26avOAqDlhnX+UEzRG7drfwkBEV/Bl+4wcJfyxgtYAxWPkUZp
 +G/VchI1clCsVc5tzZVk+7VakAf0WqRUbO+ODNEHiEQ==
X-Received: by 2002:adf:ce81:0:b0:21d:6d21:9752 with SMTP id
 r1-20020adfce81000000b0021d6d219752mr1362247wrn.26.1657690022478; 
 Tue, 12 Jul 2022 22:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uowWaNmX8XxlwA6SGk6pOQWK89++LFMozOdfKgz9YOkSHJGoX27WaK+yiZFiAfckDuwrGSMw==
X-Received: by 2002:adf:ce81:0:b0:21d:6d21:9752 with SMTP id
 r1-20020adfce81000000b0021d6d219752mr1362232wrn.26.1657690022234; 
 Tue, 12 Jul 2022 22:27:02 -0700 (PDT)
Received: from redhat.com ([2.52.24.42]) by smtp.gmail.com with ESMTPSA id
 m2-20020a05600c3b0200b0039ee391a024sm975273wms.14.2022.07.12.22.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jul 2022 22:27:01 -0700 (PDT)
Date: Wed, 13 Jul 2022 01:26:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220713011631-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-6-lingshan.zhu@intel.com>
 <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548173B9511FD3941E2D5F64DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Fri, Jul 01, 2022 at 10:07:59PM +0000, Parav Pandit wrote:
> 
> 
> > From: Zhu Lingshan <lingshan.zhu@intel.com>
> > Sent: Friday, July 1, 2022 9:28 AM
> > If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue pair, so
> > when userspace querying queue pair numbers, it should return mq=1 than
> > zero.
> > 
> > Function vdpa_dev_net_config_fill() fills the attributions of the vDPA
> > devices, so that it should call vdpa_dev_net_mq_config_fill() so the
> > parameter in vdpa_dev_net_mq_config_fill() should be feature_device than
> > feature_driver for the vDPA devices themselves
> > 
> > Before this change, when MQ = 0, iproute2 output:
> > $vdpa dev config show vdpa0
> > vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 0
> > mtu 1500
> >
> The fix belongs to user space.
> When a feature bit _MQ is not negotiated, vdpa kernel space will not add attribute VDPA_ATTR_DEV_NET_CFG_MAX_VQP.
> When such attribute is not returned by kernel, max_vq_pairs should not be shown by the iproute2.
> 
> We have many config space fields that depend on the feature bits and some of them do not have any defaults.
> To keep consistency of existence of config space fields among all, we don't want to show default like below.
> 
> Please fix the iproute2 to not print max_vq_pairs when it is not returned by the kernel.

Parav I read the discussion and don't get your argument. From driver's POV
_MQ with 1 VQ pair and !_MQ are exactly functionally equivalent.

It's true that iproute probably needs to be fixed too, to handle old
kernels. But iproute is not the only userspace, why not make it's life
easier by fixing the kernel?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
