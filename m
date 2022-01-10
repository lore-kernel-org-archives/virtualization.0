Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C3C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 07:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A47F8270B;
	Mon, 10 Jan 2022 07:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EpfS9--q6Yyl; Mon, 10 Jan 2022 07:09:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC4688142C;
	Mon, 10 Jan 2022 07:09:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0FDBC0030;
	Mon, 10 Jan 2022 07:09:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B5D6C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3FEB54031D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vmrfojQrj7n4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:09:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2213440122
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641798582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=khXMCb/zP3DiYZRD+QYDFLLcwfNZJzMICOVfIgRXvCE=;
 b=Lxcyjin8R4uSAUS2MGvHjdYGMFa8qwRt9CxVKjOzn610pqjFyHH2UxmbcDXhCJlioZRIA3
 KkZLJSkqd6FdIJ3PUi81vzfGRBGrkMvhg2BVkKpNoG8UIPNYiSnFJYDxIc0xiyC4KHbh8i
 L/JquE0uR/AxAfP6ch3BXFv9A7i30uM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-j4OE8ZKCPUe6CnEP-4N8hw-1; Mon, 10 Jan 2022 02:09:41 -0500
X-MC-Unique: j4OE8ZKCPUe6CnEP-4N8hw-1
Received: by mail-lf1-f71.google.com with SMTP id
 d8-20020ac241c8000000b0042aa94a6454so5950981lfi.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 23:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=khXMCb/zP3DiYZRD+QYDFLLcwfNZJzMICOVfIgRXvCE=;
 b=WV5rbt0scD5fHwKK4AaFCclC62sZQvCIRZBOTW0ID4rhG7s63qLsJO+D3B7/YCHXGk
 yzXJD//ql7stQat5gW5dfaDUWioSibWQdcqwHDhzcfVWZAEeSIF7QrpCWqLKYJXSyj3i
 hii0p/EBa56EJw3yBuAtUPZqHhX9lYWuVPI7E4lJ1fochtI+zfTTanW1Wb78XnWc/Ta/
 btm8W9q9hJLq2n2djJm6vPKXELED/RN004ETDmkxK9yxX6xLEF3PcDOyddeLHS7sweNu
 +7dQUdo5SckpYkxGALIgNfOZGPynEi7DKtz/TvM6w7Ybjf5iUKNqNRE3BMdkGAAoCR1v
 gDBA==
X-Gm-Message-State: AOAM533XgLzgwAE6tIT7nUEGFh3LVI52O0GwX0MzjnGTsaruQxYAj7l5
 BZs1JNhKF9YP/W2Q02PiezMc/hT2Eb7N8m9gzYWg1drmnp5WI+uSCtoZmXLU6VBAaRDEenVY4lC
 U9Fq5BdTmQz7PFrggD4Fw0btNq/hzmwRUghTem2n6gjcrbpnHUf2SI9cspg==
X-Received: by 2002:a05:6512:68a:: with SMTP id
 t10mr66605307lfe.84.1641798579510; 
 Sun, 09 Jan 2022 23:09:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyK5zE3siWJObTixHuz5qhmoUe/RAT5nvZPxMuf36KANXyLIZ1c6QWbf9gsHL4YietOGlzrEJTxUghvpZgNym0=
X-Received: by 2002:a05:6512:68a:: with SMTP id
 t10mr66605287lfe.84.1641798579235; 
 Sun, 09 Jan 2022 23:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220110020122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220110020122-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jan 2022 15:09:28 +0800
Message-ID: <CACGkMEtQdGHf8D1S8PBZ6b32q-gchfhSH-1SuXyvHfRg+CpnLw@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] Allow for configuring max number of virtqueue
 pairs
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Eli Cohen <elic@nvidia.com>
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

On Mon, Jan 10, 2022 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jan 05, 2022 at 01:46:32PM +0200, Eli Cohen wrote:
> > Allow the user to configure the max number of virtqueue pairs for a vdpa
> > instance. The user can then control the actual number of virtqueue pairs
> > using ethtool.
>
> So I put a version of this in linux-next, but I had to squash in
> some bugfixes, and resolve some conflicts. Eli, please take a look
> and let me know whether it looks sane. If not pls post a new
> version.
> Jason, what is your take on merging this now? Si-wei here seems to want
> to defer, but OTOH it's up to v7 already, most patches are acked and
> most comments look like minor improvement suggestions to me.

I think we can merge them and send patches on top to fix issues if needed.

Thanks

>
> > Example, set number of VQPs to 2:
> > $ ethtool -L ens1 combined 2
> >
> > A user can check the max supported virtqueues for a management device by
> > running:
> >
> > $ $ vdpa mgmtdev show
> >     auxiliary/mlx5_core.sf.1:
> >       supported_classes net
> >       max_supported_vqs 257
> >       dev_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ MQ \
> >                    CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
> >
> > and refer to this value when adding a device.
> >
> > To create a device with a max of 5 VQPs:
> > vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5
> >
> > Please note that for patches that were changed I removed "Reviewed-by"
> > and "Acked-by".
> >
> > v6 -> v7:
> > 1. Make use of cf_mutex for serializing netlink set/get with other
> > calls.
> > 2. Some fixes (See in each patch)
> > 3. Add patch for vdpa_sim to report supported features
> > 4. "Reviewed-by" and "Acked-by" removed from patch 0007 since it had
> > slightly changed.
> >
> > Eli Cohen (14):
> >   vdpa: Provide interface to read driver features
> >   vdpa/mlx5: Distribute RX virtqueues in RQT object
> >   vdpa: Sync calls set/get config/status with cf_mutex
> >   vdpa: Read device configuration only if FEATURES_OK
> >   vdpa: Allow to configure max data virtqueues
> >   vdpa/mlx5: Fix config_attr_mask assignment
> >   vdpa/mlx5: Support configuring max data virtqueue
> >   vdpa: Add support for returning device configuration information
> >   vdpa/mlx5: Restore cur_num_vqs in case of failure in change_num_qps()
> >   vdpa: Support reporting max device capabilities
> >   vdpa/mlx5: Report max device capabilities
> >   vdpa/vdpa_sim: Configure max supported virtqueues
> >   vdpa: Use BIT_ULL for bit operations
> >   vdpa/vdpa_sim_net: Report max device capabilities
> >
> >  drivers/vdpa/alibaba/eni_vdpa.c      |  16 +++-
> >  drivers/vdpa/ifcvf/ifcvf_main.c      |  16 +++-
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c    | 134 ++++++++++++++++-----------
> >  drivers/vdpa/vdpa.c                  | 100 ++++++++++++++++----
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c     |  21 +++--
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   2 +
> >  drivers/vdpa/vdpa_user/vduse_dev.c   |  16 +++-
> >  drivers/vdpa/virtio_pci/vp_vdpa.c    |  16 +++-
> >  drivers/vhost/vdpa.c                 |  11 +--
> >  drivers/virtio/virtio_vdpa.c         |   7 +-
> >  include/linux/vdpa.h                 |  36 +++++--
> >  include/uapi/linux/vdpa.h            |   6 ++
> >  12 files changed, 271 insertions(+), 110 deletions(-)
> >
> > --
> > 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
