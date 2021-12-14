Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4D3C433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 08:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CBE5400C9;
	Tue, 14 Dec 2021 08:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amymTxmoTQkc; Tue, 14 Dec 2021 08:54:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DFFAF408AE;
	Tue, 14 Dec 2021 08:54:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C791EC001E;
	Tue, 14 Dec 2021 08:54:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9770C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96BF6408A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vfv-GE5Jj1wL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:54:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CF2F408A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 08:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639472045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rDCqkzm5FMCVzwWtkuVrcioU48JxJsL0fZLEwqlTu0=;
 b=Eo1Uud201eK2T2Tw5Nm1+LSrE5kwTzb4yockAwq8VvIZXdSvVdQOqp3T5l0ik/Xz0pyD+a
 LT7S8ezfLRsyQyJdeTs0CH6ZOKmKfXuevAT6YmA3WbO7eUth4ujFyltiIKGHzbzACksaJV
 l6mtzvXyV3dI+FipRdjFYtkVhVTbSPw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-bi-SmuunOqCD0amdhljNZw-1; Tue, 14 Dec 2021 03:54:02 -0500
X-MC-Unique: bi-SmuunOqCD0amdhljNZw-1
Received: by mail-lf1-f72.google.com with SMTP id
 d2-20020a0565123d0200b0040370d0d2fbso8684066lfv.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 00:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4rDCqkzm5FMCVzwWtkuVrcioU48JxJsL0fZLEwqlTu0=;
 b=a6xEhD6lG5fO/MJoja4LCZ9w4IcqmumesvPca541Cg6ZEVXGVLjut+YncPLTpTmkRS
 KwnAmNnKQ6FZRc33QDkS1IvofIO/X3Kp6r9p1qBHfCVfz1LG9dTr6r6sxyEFm3nb8VE8
 SaVCOpOhdDLmigbPGuMftKdvkIEYW4F3tLtZCh2V2zpHu+6Wc5BBKVK+hDYeEbXjSVdc
 Xe+0j9RpS6tRs4J9s+c36uNbL0iYtbeFE6ty9WCXoOcTGwLDfVcFsuFcN8F013w6EsRN
 TUyhCGJvhSmBWKcTGXg4yS8+lhv6CKd33yA3UiQ7uzsrhdat8B/07OjYXgp4BM2/HCKD
 Zygg==
X-Gm-Message-State: AOAM533RkTRRluyrBP0uyJKr2OIQzAboJZjbGASDCvPmtLwv9x/wGFCc
 cBM98XKogHCAV7S1Q/sA3+6YvufkyMhkK7HyP7upvULm5bVHPET266XQ4kBk4dGTrQTRo8ZJ5wk
 nQYJ8W+zf5DRe1G8flko/F2NQstP6gW5v0G6cE1lGq5OnXhkj1310lP2ygw==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr3738301lfm.580.1639472040734; 
 Tue, 14 Dec 2021 00:54:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYtZF4h4Ft6XY4UD3XOg+jnRnwqZFOjkVQlLjZhWbCaAEg2FrWuCngcAtItbeZmGPBmo2sxFw1TDlaD/YZo4U=
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr3738280lfm.580.1639472040529; 
 Tue, 14 Dec 2021 00:54:00 -0800 (PST)
MIME-Version: 1.0
References: <20211213144258.179984-1-elic@nvidia.com>
 <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
 <20211214073141.GC89087@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211214073141.GC89087@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 16:53:49 +0800
Message-ID: <CACGkMEtDUw+COR5UnVDeu4Nf+9b-Uf78zfZujXew16y2cV2uOA@mail.gmail.com>
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

On Tue, Dec 14, 2021 at 3:32 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Tue, Dec 14, 2021 at 11:17:00AM +0800, Jason Wang wrote:
> > On Mon, Dec 13, 2021 at 10:43 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Allow the user to configure the max number of virtqueue pairs for a vdpa
> > > instance. The user can then control the actual number of virtqueue pairs
> > > using ethtool.
> > >
> > > Example, set number of VQPs to 2:
> > > $ ethtool -L ens1 combined 2
> > >
> > > A user can check the max supported virtqueues for a management device by
> > > runnig:
> > >
> > > vdpa dev show
> > >     vdpa-a: type network mgmtdev auxiliary/mlx5_core.sf.1 vendor_id 5555 \
> > >             max_vqp 3 max_vq_size 256 max_supported_vqs 256
> >
> > I think the maxsupported_vqs should be an odd number since it should
> > contain control vq.
>
> I was thinking we should report data virtqueues. If some upstream driver
> or device does not support CVQ, this should still be an even number.
>
> Moreover, if we want to include the CVQ, we might want to indicate that
> explicitly.

Can we expose driver features in this case?

Thanks

>
> >
> > >
> > > and refer to this value when adding a device.
> > >
> > > To create a device with a max of 5 VQPs:
> > > vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5
> >
> > A question, consider the parent support both net and block, if user use
> >
> > vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1
> >
> > How do we know it's a net or block device? Or do you expect some block
> > specific attributes to be added?
> >
> > Thanks
> >
> > >
> > > V1 -> V2:
> > > 1. Do not return the index of the control VQ. Instead return an
> > >    indication if Ctrl VQ was negotiated.
> > > 2. Do not returen conig information if FEATURES_OK is not set to avoid
> > >    reporting out of sync information.
> > > 3. Minor fixes as described by the individual patches
> > > 4. Add patches to return the max virtqueues a device is capable of
> > >    supporting.
> > >
> > > Eli Cohen (10):
> > >   vdpa: Provide interface to read driver features
> > >   vdpa/mlx5: Distribute RX virtqueues in RQT object
> > >   vdpa: Read device configuration only if FEATURES_OK
> > >   vdpa: Allow to configure max data virtqueues
> > >   vdpa/mlx5: Fix config_attr_mask assignment
> > >   vdpa/mlx5: Support configuring max data virtqueue pairs
> > >   vdpa: Add support for returning device configuration information
> > >   vdpa/mlx5: Restore cur_num_vqs in case of failure in change_num_qps()
> > >   vdpa: Support reporting max device virtqueues
> > >   vdpa/mlx5: Configure max supported virtqueues
> > >
> > >  drivers/vdpa/alibaba/eni_vdpa.c    | 16 +++--
> > >  drivers/vdpa/ifcvf/ifcvf_main.c    | 16 +++--
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 94 +++++++++++++++++-------------
> > >  drivers/vdpa/vdpa.c                | 42 ++++++++++++-
> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 21 +++++--
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 16 +++--
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c  | 16 +++--
> > >  drivers/vhost/vdpa.c               |  2 +-
> > >  drivers/virtio/virtio_vdpa.c       |  2 +-
> > >  include/linux/vdpa.h               | 16 +++--
> > >  include/uapi/linux/vdpa.h          |  9 +++
> > >  11 files changed, 178 insertions(+), 72 deletions(-)
> > >
> > > --
> > > 2.33.1
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
