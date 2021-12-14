Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FA6C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 03:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CF3B405D0;
	Tue, 14 Dec 2021 03:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MGDQiTMuvD4C; Tue, 14 Dec 2021 03:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD2F3402EE;
	Tue, 14 Dec 2021 03:17:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 792E7C001E;
	Tue, 14 Dec 2021 03:17:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4E62C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9388D81365
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7qJVStefigp4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:17:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2E2681361
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639451834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XT1Tf/9PR5ThS+7UUdxaM8tfSLDW1ssN+Qwkx7eCnlQ=;
 b=dvxz5eT7ge6w0GwyO3F8w5g8P5MUzczWzaCSFob1rEgI8nyHJJst6zLGXO1ER1zHVmXAuN
 ObgVzUbUbMZJ9dq4wofCeuiObc7JD6wfOKA85MhxH+ezhvPiin91qNrd/fsAmfVtKzq2EM
 vCMqZJSS1hi3lqlY2bfZCQVXEwEZ0Ck=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-meg7N-D9MnS7hlox1GP7xw-1; Mon, 13 Dec 2021 22:17:13 -0500
X-MC-Unique: meg7N-D9MnS7hlox1GP7xw-1
Received: by mail-lf1-f69.google.com with SMTP id
 q13-20020a19f20d000000b0041fcb65b6c7so6153710lfh.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 19:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XT1Tf/9PR5ThS+7UUdxaM8tfSLDW1ssN+Qwkx7eCnlQ=;
 b=7M3DHu0vwr2YkbthBPBXeYtawZIIYZBegyinqTmiN8liaaMweG8uzod5BLWfRo6pcV
 eiT3gKyAuu/eJLZkDHBhHAE49XmUeGtQ0ZmZdtpWvBhxPWTcNnhuWNhaEcJqlsLghaVt
 Vyn+dPljwLWo/BMuY46MuwOtD/RhSbCfcJhWCn/Amj0MtHq8zCafJPTvg6/G7d8bcSKY
 uqIZO2JmuG6j5HsuK0pJ1DQ0J5Nbk6a06xY+wii18iXBJbf4ZM0gXWBJC5eoWhRv3m3I
 89a7xeb8EczxkzTPhcowtjq8dm80Pii7DaPZthVfW5r65Y+4fS+HJktDBawn1znQvKF5
 gsDA==
X-Gm-Message-State: AOAM530z21o9RqJC9TWvB94AQBOvBKhZU1SWIFNPDmZH3mz1vGbUJAPZ
 pFVCtfy6lPfaVsO+Bo7YqJocK1pBqTzfCMHGsXBFzXZwvA0XFPuw5yeka5ygWoCKrdKIzKpEnL0
 rOZnZT3R5pV14E4/RZ9iN7qSuUiacDlHoucx5dKIANRTGoYe82ybbQY5iIA==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr2325951ljw.217.1639451831815; 
 Mon, 13 Dec 2021 19:17:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZFDNMjzA3H/OZ4ge4fv0pM5iWP90AFMeR7gF887BnZpR/hS3I9UV4vs9aJXxUwjfoe9e8hgo15N4hrEiRYRY=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr2325930ljw.217.1639451831550; 
 Mon, 13 Dec 2021 19:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20211213144258.179984-1-elic@nvidia.com>
In-Reply-To: <20211213144258.179984-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 11:17:00 +0800
Message-ID: <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Allow for configuring max number of virtqueue
 pairs
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Mon, Dec 13, 2021 at 10:43 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Allow the user to configure the max number of virtqueue pairs for a vdpa
> instance. The user can then control the actual number of virtqueue pairs
> using ethtool.
>
> Example, set number of VQPs to 2:
> $ ethtool -L ens1 combined 2
>
> A user can check the max supported virtqueues for a management device by
> runnig:
>
> vdpa dev show
>     vdpa-a: type network mgmtdev auxiliary/mlx5_core.sf.1 vendor_id 5555 \
>             max_vqp 3 max_vq_size 256 max_supported_vqs 256

I think the maxsupported_vqs should be an odd number since it should
contain control vq.

>
> and refer to this value when adding a device.
>
> To create a device with a max of 5 VQPs:
> vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5

A question, consider the parent support both net and block, if user use

vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1

How do we know it's a net or block device? Or do you expect some block
specific attributes to be added?

Thanks

>
> V1 -> V2:
> 1. Do not return the index of the control VQ. Instead return an
>    indication if Ctrl VQ was negotiated.
> 2. Do not returen conig information if FEATURES_OK is not set to avoid
>    reporting out of sync information.
> 3. Minor fixes as described by the individual patches
> 4. Add patches to return the max virtqueues a device is capable of
>    supporting.
>
> Eli Cohen (10):
>   vdpa: Provide interface to read driver features
>   vdpa/mlx5: Distribute RX virtqueues in RQT object
>   vdpa: Read device configuration only if FEATURES_OK
>   vdpa: Allow to configure max data virtqueues
>   vdpa/mlx5: Fix config_attr_mask assignment
>   vdpa/mlx5: Support configuring max data virtqueue pairs
>   vdpa: Add support for returning device configuration information
>   vdpa/mlx5: Restore cur_num_vqs in case of failure in change_num_qps()
>   vdpa: Support reporting max device virtqueues
>   vdpa/mlx5: Configure max supported virtqueues
>
>  drivers/vdpa/alibaba/eni_vdpa.c    | 16 +++--
>  drivers/vdpa/ifcvf/ifcvf_main.c    | 16 +++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 94 +++++++++++++++++-------------
>  drivers/vdpa/vdpa.c                | 42 ++++++++++++-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 21 +++++--
>  drivers/vdpa/vdpa_user/vduse_dev.c | 16 +++--
>  drivers/vdpa/virtio_pci/vp_vdpa.c  | 16 +++--
>  drivers/vhost/vdpa.c               |  2 +-
>  drivers/virtio/virtio_vdpa.c       |  2 +-
>  include/linux/vdpa.h               | 16 +++--
>  include/uapi/linux/vdpa.h          |  9 +++
>  11 files changed, 178 insertions(+), 72 deletions(-)
>
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
