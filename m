Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62B1547CA
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116110; cv=none; b=ugqRbF5XDo9g2GQ0t8t3W/JlQpmmG+hMQlZxylbx2e/o2XQE4U0FUUYgUbOV+1IOp+QvrnwCM+dqOMmTqeVmOrp6d5aCjO0nbeJt+WXNr1snVCZO3BGrDqudZEdBJxVxiTN9n49L1g07SI0qJit+Rh+8vJDjHaDzu5uY35W42hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116110; c=relaxed/simple;
	bh=RcJODScoXNF3HP4hDUffKS9Z470PUHCkZnTLG0obbnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Z3hYVlvxQdk+wugU1tfcdfhbxSXy2B0mePW2Qm7/hhoEf0P2jyMv2L2xOh17PgcxRy4BVEvAqPCtSkc29744lx/1AonAg7vKCDs9BLwMopeaUKmeoEc7xe8i/0PA9d/M8RYFPiqfhQwFOOaKUfKjHrkYcXno0QkjL+iBTuAXet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bejfOB69; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bejfOB69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734116107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Oi5mdK80AGx2gnUMpCyjJOjx4fPGiU1BQmQpKsVJLQ=;
	b=bejfOB69gHeHUW8r8aZ4YC6lR4v4mjDZLuiJx92DY1mGbFCNy+eoc2BMgJJib61R9sVgFM
	bLKUIt9v1Tup6I9hhQHNFwF/Ps0TRrvkmk1QwQ3V/WvvvM1vzYm9XZNtJNMNoODe0YCJgB
	xwJd4W/UP+d90PM55awZPaNoJ/v0vp4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-uQDXOmgvNd2nAxa06CF2ng-1; Fri, 13 Dec 2024 13:55:06 -0500
X-MC-Unique: uQDXOmgvNd2nAxa06CF2ng-1
X-Mimecast-MFC-AGG-ID: uQDXOmgvNd2nAxa06CF2ng
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e3cbf308so868181f8f.2
        for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 10:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734116105; x=1734720905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Oi5mdK80AGx2gnUMpCyjJOjx4fPGiU1BQmQpKsVJLQ=;
        b=fdiFndO8mSSsOYQX7i1+i2fA21QBD4jwwC2YRnqbLNQ4+Fg3OCCvZHE53RxbtAb5Pf
         gIwA1ZK4zoH9f2HfkixbtRPnYena3/8WsQmfXy3rUpsABr43i9Jx2VWaNqogsEDuO/GJ
         vsFCLSOTh8hoXuD1RhaP12o0FpSorr6WWzgfc96DLkC+evtXppnHn/rB0tFJ5USNpo2y
         VQePoCT3aMzKWQ3pqZmk1M2FYm7lRtIl7qdFLXbuS2eoUG9T7dlujEoikVrMtXIfyyDw
         nypifVa/bVCXa0c7qaq5ZxepaRmVH5ttWJUXX0gGg2du9GmfFmx1piSEmK9PDyUYLiV9
         bo/w==
X-Forwarded-Encrypted: i=1; AJvYcCWMJSuaQ/2aLT+DYA/lh7R7dRFFqK3+wor7so9qvxHevOQdsEwzi7+LJ5jfpcPIzpX4jEvPmvxP0yU6RXbwAg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywhfbv67nm9qG6C9roT5Pcdd0I0uFp2qvHqlsMCzbmrQa6LJla4
	lRzzchkZdsX8LakOcMfs3nGFyV9Ml00cwaJ74XaGPcrAqt2PUuFrbRavZl+ZB2ZAe+6sOYPeHR6
	j2bN+QjfCA3R3TZdIx1TVwU/ttjyLjk2yZ62P9Ffs1Sq4LtcnRKblbJJhYl7vg85f
X-Gm-Gg: ASbGncsL2Cg3gWho9q67zb0JRB9CmjyYa3pUJU811zrs0p7MTDTqVJUC/Ax6BV4rD/6
	NgM69yCvV9l0aVvcHTtKfgOpwS42fRpBH08agvZD2KnRhyT4jXula1RexTLskY3UHrX99TtPp8P
	lpvYltt/AhzWkB8k/aG0oujcHHxzlzMSG5ojt9dZiWF4hGWtjtk9UdOYW1X/5m2TS2y1VKSNhxx
	C7eYjUJZbIKvsqauGHVRdGr/kqFQ+PM38anxq3qlA+9hQfNLg==
X-Received: by 2002:a05:6000:4024:b0:386:3f3e:ab11 with SMTP id ffacd0b85a97d-3888e0bd231mr3018506f8f.34.1734116105452;
        Fri, 13 Dec 2024 10:55:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqDsqjIlsKqyhHXSOnxjVEITmP6zRNZkmfcHEacMFRdJtvP0V9402C97CiW3ObpgUPBopi4w==
X-Received: by 2002:a05:6000:4024:b0:386:3f3e:ab11 with SMTP id ffacd0b85a97d-3888e0bd231mr3018485f8f.34.1734116105103;
        Fri, 13 Dec 2024 10:55:05 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:66af:6381:7d28:90f3:9fad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80163b8sm265821f8f.35.2024.12.13.10.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:55:03 -0800 (PST)
Date: Fri, 13 Dec 2024 13:55:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shijith Thotton <sthotton@marvell.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	Srujana Challa <schalla@marvell.com>,
	Vamsi Krishna Attunuru <vattunuru@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI
 capability
Message-ID: <20241213135321-mutt-send-email-mst@kernel.org>
References: <20241209151427.3720026-1-sthotton@marvell.com>
 <20241209151427.3720026-4-sthotton@marvell.com>
 <CACGkMEvuObS4RCk2BjQ4sm6r4jaC3fN4ui5EXd6SVzYxYZV7iA@mail.gmail.com>
 <PH0PR18MB442538D91F856F27F3C37A9AD9382@PH0PR18MB4425.namprd18.prod.outlook.com>
 <PH0PR18MB4425BB6DE30C3805F31D75CED9382@PH0PR18MB4425.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <PH0PR18MB4425BB6DE30C3805F31D75CED9382@PH0PR18MB4425.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zDk6JiiTW_109DOwkGubSWQbXNFMhdMmzzmfxTruX4k_1734116105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2024 at 02:20:24PM +0000, Shijith Thotton wrote:
> >>>
> >>> Added support to read the vendor-specific PCI capability to identify the
> >>> type of device being emulated.
> >>>
> >>> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> >>> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> >>> ---
> >>>  drivers/vdpa/octeon_ep/octep_vdpa.h      | 20 ++++++++++++++
> >>>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 33
> >>+++++++++++++++++++++++-
> >>>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
> >>>  3 files changed, 55 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h
> >>b/drivers/vdpa/octeon_ep/octep_vdpa.h
> >>> index 2cadb878e679..53b020b019f7 100644
> >>> --- a/drivers/vdpa/octeon_ep/octep_vdpa.h
> >>> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> >>> @@ -8,6 +8,7 @@
> >>>  #include <linux/pci_regs.h>
> >>>  #include <linux/vdpa.h>
> >>>  #include <linux/virtio_pci_modern.h>
> >>> +#include <uapi/linux/virtio_crypto.h>
> >>>  #include <uapi/linux/virtio_net.h>
> >>>  #include <uapi/linux/virtio_blk.h>
> >>>  #include <uapi/linux/virtio_config.h>
> >>> @@ -52,6 +53,24 @@ struct octep_vring_info {
> >>>         phys_addr_t notify_pa;
> >>>  };
> >>>
> >>> +enum octep_pci_vndr_cfg_type {
> >>> +       OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
> >>> +       OCTEP_PCI_VNDR_CFG_TYPE_MAX,
> >>> +};
> >>> +
> >>> +struct octep_pci_vndr_data {
> >>> +       struct virtio_pci_vndr_data hdr;
> >>> +       u8 id;
> >>> +       u8 bar;
> >>> +       union {
> >>> +               u64 data;
> >>> +               struct {
> >>> +                       u32 offset;
> >>> +                       u32 length;
> >>> +               };
> >>> +       };
> >>> +};
> >>
> >>This seems not to be padded to a multiple of 4 bytes?
> >>
> >
> >Looks like, the structure is naturally aligned.
> >
> >struct virtio_pci_vndr_data {
> >        uint8_t                    cap_vndr;             /*     0     1 */
> >        uint8_t                    cap_next;             /*     1     1 */
> >        uint8_t                    cap_len;              /*     2     1 */
> >        uint8_t                    cfg_type;             /*     3     1 */
> >        uint16_t                   vendor_id;            /*     4     2 */
> >        /* size: 6, cachelines: 1, members: 5 */
> >        /* last cacheline: 6 bytes */
> >};
> >struct octep_pci_vndr_data {
> >        struct virtio_pci_vndr_data hdr;                 /*     0     6 */
> >        uint8_t                    id;                   /*     6     1 */
> >        uint8_t                    bar;                  /*     7     1 */
> >        union {
> >                uint64_t           data;                 /*     8     8 */
> >                struct {
> >                        uint32_t   offset;               /*     8     4 */
> >                        uint32_t   length;               /*    12     4 */
> >                };                                       /*     8     8 */
> >        };                                               /*     8     8 */
> >
> >        /* size: 16, cachelines: 1, members: 4 */
> >        /* last cacheline: 16 bytes */
> >};
> >
> >I will add __attribute__((aligned(4))) to be safe.
> >
> 
> Small correction, I meant   __attribute__((packed, aligned(4))).
> 
> Thanks,
> Shijith

Don't add packed pls, for me it means "something is not packed naturally
here". when in fact it is.

aligned is also bad, since it can add padding which creates all
kind of security issues.

If you want to be sure, add BUILD_BUG_ON and check that it is aligned
as expected.

