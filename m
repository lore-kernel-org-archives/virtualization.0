Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442222441A0
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Sep 2025 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520980; cv=none; b=ilSPP7ywpbnSdYyPPjEo6W+KmwfF/FvTBgsyjtZe9JzlhzSoQfMxBZzHBx9XNDY0Fumz3E0uEMryVhgeIfoyI8tzGie3wQP+FwH0tiQmb/JXQDVUUE2nPWhRUlqTiUrBy9ZRUTMaJAQoLo3+8siU72hrEk2OJjR8ZJ/at4sNmBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520980; c=relaxed/simple;
	bh=Sg2ZhJJNOixI58F9DAvglK5f8T6LuEby3v5Alaffuzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNNd2Fx3Z7kSVhniliN+hw6YaSvrk+hsE30fUkKK5GFbumgVtG2q8Ud42NeXM/45bM4bXdhS0ynlrusf4FOsUOuyQzF0DbW+PfVwYhG7tgdb2bRckJm3iiAg42sUc6n0MfxeqGlnUJPvf1yGWiY4tCdxfkqLjkrhGtEY21jRsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhRnF6ng; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhRnF6ng"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B04174137B
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Sep 2025 06:02:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKZbSiWedERJ for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Sep 2025 06:02:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5B65B4028D
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B65B4028D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BhRnF6ng
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B65B4028D
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Sep 2025 06:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758520974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXtgiVIDZQsTyx5yaIcOjWi6WHQD/mD1mUw/FWs9+uA=;
	b=BhRnF6ngQo83d+KJ6TkL3Okph81Q0RCVZ+uOm15wiHcBI2r/nxo7IiJLoxj5m1aKoR/ijd
	mdxPI3RxT2XeKgLKVy4gB9RA/PwuJIZK0pjNh7ehxQymP42GfEQtXZYObWZ0sLJFlz9CNI
	9PyBBpLUKxdtaPJFQeqNgz/G8coteyA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-50o7zuFsMuyf_qT00VfVYQ-1; Mon, 22 Sep 2025 02:02:52 -0400
X-MC-Unique: 50o7zuFsMuyf_qT00VfVYQ-1
X-Mimecast-MFC-AGG-ID: 50o7zuFsMuyf_qT00VfVYQ_1758520971
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-748d8d78d98so22272757b3.2
        for <virtualization@lists.linux-foundation.org>; Sun, 21 Sep 2025 23:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758520971; x=1759125771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXtgiVIDZQsTyx5yaIcOjWi6WHQD/mD1mUw/FWs9+uA=;
        b=miaGb0scBtz9vgvr6uGcB1pSOlD+a8zZiuUMj4SrUtrMKNLQUBhJxcFm8Omy1EJlBp
         BXVf+55RLjzsY7QjuQc1aIFIeM4zcbpyk24s0520K0dnjG58l5swvvu5ecWQkWu/NPJK
         wrRkNTa8jGCEoFUBGozBjeRVV1srcOwLkzUzvgEISSDLmRW0l8CnNV3gqSE2kmgCojwE
         nHB4cWPeHC6EzpEkaUaa8FrWvHMkP3efCs2FoO6b4re4KiLSZYSJv3TcFq6U7jjMTdEW
         OvsvAQH8oOwKskQTDPP08xLYD+hXlxpwX3WbTUoQgvBIKdDK2HMK/pQjVADyk65rQmWT
         cT4A==
X-Forwarded-Encrypted: i=1; AJvYcCXgjO+6u1fEJ8ZLV1F4xKHQf0IZtfQUD6+ES0EA7OoCnwJW+GtcrnEkq3EKKLXCbTYb3u0y4E9iQowsGuAMoQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxLkXcHaeZtgBIsEzGXuO+4ut4naUfTGzeT6Skm2hwTXEE9COxS
	8qQKYWPXw6OamsV9YY+p2dEI8sDYOmhWIFZ4HlAyRNkqJ0v4fs0QOUC+XdBPshfgD4F2tacZLTH
	Gqbld+cPo3c3W1d2MZhpIoevl0z9P44QH1ABxABQV1zFpYv+rrMYzEaqyZswaG1NIKCznhWLq84
	Br3Y4lCc7mDtpoHavMP2bgDZuDM3AhKFnW4N41ZVYCazJeSc40PQY4WDu3gA==
X-Gm-Gg: ASbGncsOFbHgUT9avPBUoTlGQ2nXKRhzYXf8htrsuZvCEJMpOJSZDNdJf2+u90j+Ozt
	4GLkHxNo07u3BvRA7wdGlrfly8EtN2CjhruZlHFwln3XXKfa1f39T2jy/8EJdV8uDmzo3ryqm5S
	oK1wD27mAPPUfV2c4FMjqhefixO6CvQKqYe/FfU3R7SneuuSBWiihJ5JjAeEN/x0AjcCajgQoua
	g50GKo5
X-Received: by 2002:a05:690e:1542:20b0:633:b9eb:85e9 with SMTP id 956f58d0204a3-6347f6ba46cmr8112823d50.32.1758520971450;
        Sun, 21 Sep 2025 23:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0kBUfTEwsGXZ2XE31k1sbK8b37mZcOhbe2/vAmhg4wuOIDphXzxvRzQgRorZGwG9/RWuF10EUngTVdtkcfO0=
X-Received: by 2002:a05:690e:1542:20b0:633:b9eb:85e9 with SMTP id
 956f58d0204a3-6347f6ba46cmr8112812d50.32.1758520971019; Sun, 21 Sep 2025
 23:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <202509202256.zVt4MifB-lkp@intel.com> <20250921173047-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921173047-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 22 Sep 2025 08:02:13 +0200
X-Gm-Features: AS18NWCc_27M-TzG_mmHLopTufIzWqfZX3OigDEEb-tvxhI6YUlzAbD54FDcadY
Message-ID: <CAJaqyWcGLKoa0mWivac5BfBTJbyAnW14FvAmA0EteunidMc6NQ@mail.gmail.com>
Subject: Re: [mst-vhost:vhost 41/44] drivers/vdpa/pds/vdpa_dev.c:590:19:
 error: incompatible function pointer types initializing 's64 (*)(struct
 vdpa_device *, u16)' (aka 'long long (*)(struct vdpa_device *, unsigned
 short)') with an expression of type 'u32 (struct vdpa_device *, u16)' (aka ...
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ljQHTgAyYQaFJzws0ZYnW9rWwrQvXzIppHh39-9nuBo_1758520971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 11:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Sat, Sep 20, 2025 at 10:41:40PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git v=
host
> > head:   877102ca14b3ee9b5343d71f6420f036baf8a9fc
> > commit: 2951c77700c3944ecd991ede7ee77e31f47f24ab [41/44] vduse: add vq =
group support
> > config: loongarch-randconfig-001-20250920 (https://download.01.org/0day=
-ci/archive/20250920/202509202256.zVt4MifB-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project=
 7c861bcedf61607b6c087380ac711eb7ff918ca6)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250920/202509202256.zVt4MifB-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202509202256.zVt4MifB-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/vdpa/pds/vdpa_dev.c:590:19: error: incompatible function poi=
nter types initializing 's64 (*)(struct vdpa_device *, u16)' (aka 'long lon=
g (*)(struct vdpa_device *, unsigned short)') with an expression of type 'u=
32 (struct vdpa_device *, u16)' (aka 'unsigned int (struct vdpa_device *, u=
nsigned short)') [-Wincompatible-function-pointer-types]
> >      590 |         .get_vq_group           =3D pds_vdpa_get_vq_group,
> >          |                                   ^~~~~~~~~~~~~~~~~~~~~
> >    1 error generated.
> >
>
> Eugenio, just making sure you see this. I can not merge patches that
> break build.
>

Absolutely, I forgot to enable all the vdpa drivers in my test. Silly
mistake, fixing it right now. Thanks!

> > vim +590 drivers/vdpa/pds/vdpa_dev.c
> >
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  577
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  578  static const struct vdp=
a_config_ops pds_vdpa_ops =3D {
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  579        .set_vq_address  =
       =3D pds_vdpa_set_vq_address,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  580        .set_vq_num      =
       =3D pds_vdpa_set_vq_num,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  581        .kick_vq         =
       =3D pds_vdpa_kick_vq,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  582        .set_vq_cb       =
       =3D pds_vdpa_set_vq_cb,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  583        .set_vq_ready    =
       =3D pds_vdpa_set_vq_ready,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  584        .get_vq_ready    =
       =3D pds_vdpa_get_vq_ready,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  585        .set_vq_state    =
       =3D pds_vdpa_set_vq_state,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  586        .get_vq_state    =
       =3D pds_vdpa_get_vq_state,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  587        .get_vq_notificat=
ion    =3D pds_vdpa_get_vq_notification,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  588        .get_vq_irq      =
       =3D pds_vdpa_get_vq_irq,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  589        .get_vq_align    =
       =3D pds_vdpa_get_vq_align,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19 @590        .get_vq_group    =
       =3D pds_vdpa_get_vq_group,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  591
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  592        .get_device_featu=
res    =3D pds_vdpa_get_device_features,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  593        .set_driver_featu=
res    =3D pds_vdpa_set_driver_features,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  594        .get_driver_featu=
res    =3D pds_vdpa_get_driver_features,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  595        .set_config_cb   =
       =3D pds_vdpa_set_config_cb,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  596        .get_vq_num_max  =
       =3D pds_vdpa_get_vq_num_max,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  597        .get_device_id   =
       =3D pds_vdpa_get_device_id,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  598        .get_vendor_id   =
       =3D pds_vdpa_get_vendor_id,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  599        .get_status      =
       =3D pds_vdpa_get_status,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  600        .set_status      =
       =3D pds_vdpa_set_status,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  601        .reset           =
       =3D pds_vdpa_reset,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  602        .get_config_size =
       =3D pds_vdpa_get_config_size,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  603        .get_config      =
       =3D pds_vdpa_get_config,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  604        .set_config      =
       =3D pds_vdpa_set_config,
> > 151cc834f3ddafe Shannon Nelson 2023-05-19  605  };
> > 25d1270b6e9ea89 Shannon Nelson 2023-05-19  606  static struct virtio_de=
vice_id pds_vdpa_id_table[] =3D {
> > 25d1270b6e9ea89 Shannon Nelson 2023-05-19  607        {VIRTIO_ID_NET, V=
IRTIO_DEV_ANY_ID},
> > 25d1270b6e9ea89 Shannon Nelson 2023-05-19  608        {0},
> > 25d1270b6e9ea89 Shannon Nelson 2023-05-19  609  };
> > 25d1270b6e9ea89 Shannon Nelson 2023-05-19  610
> >
> > :::::: The code at line 590 was first introduced by commit
> > :::::: 151cc834f3ddafec869269fe48036460d920d08a pds_vdpa: add support f=
or vdpa and vdpamgmt interfaces
> >
> > :::::: TO: Shannon Nelson <shannon.nelson@amd.com>
> > :::::: CC: Michael S. Tsirkin <mst@redhat.com>
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
>

