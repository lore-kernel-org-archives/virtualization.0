Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DBEC433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 08:15:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C67C6115B
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 08:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C67C6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 132F6608C7;
	Tue,  5 Oct 2021 08:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BkesZQbWfU1Q; Tue,  5 Oct 2021 08:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82F056075E;
	Tue,  5 Oct 2021 08:15:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5618AC0011;
	Tue,  5 Oct 2021 08:15:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE89BC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 08:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86984405F9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 08:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZM3O-jY3PU5V
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 08:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC1E0405E6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633421749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWK9jhYHAz16BVu0V3LktixTLTLqMth4byPzqPPXRzM=;
 b=TmM6T0Rr/qc3S4Vohteqi2boBQEWcfHdmrQWLIiWgCZiiQzGEdMSiQe7mUnKXQdLgYMlSG
 aAUy9S0u0bDKfts2vgRdOfToAT984ngSApKdyieCiNVREbiYl1+YeEpN5ZMRzYvTSk9MCO
 JhiHvMAxSs+SxAt28DZwFF5R0TcNVRs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-eRrD9hA2M_mwGmSG701gKw-1; Tue, 05 Oct 2021 04:15:48 -0400
X-MC-Unique: eRrD9hA2M_mwGmSG701gKw-1
Received: by mail-ed1-f70.google.com with SMTP id
 c7-20020a05640227c700b003d27f41f1d4so19831064ede.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 01:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GWK9jhYHAz16BVu0V3LktixTLTLqMth4byPzqPPXRzM=;
 b=IvTiP/vNKDy6aK7i12ZEZ1SC2u7pGOzFgDEu3+ulZ8894nFeCe97DS95KXV6PhylSe
 JQlqscTUiI+bxuUa0Hq74vzogdLGn4W5dBeKSTolMhCJIdKyRChAVLWJgIfhd/qB4NfV
 fPjrZeVOzTtCX0dSXxOCHFr1QZUGJoaPlKeKYQjWR7qGeHAKO70/YhV+SSCJN4OOltd8
 oNNAZ0vAovZIQTf73X7Ai5Yjlj6Ys6xynFwrXSOV7xnGanpjgHfLHpx96Nk2Ys4aJDiS
 7/jJ4r8aB79XkZRaEPF9c3qmqomZzN+FOHTXE36sXRdKbv+E0pV/x3ji6P8EXGTy0nfW
 0Cvg==
X-Gm-Message-State: AOAM533p48fQrpTuC0qTlVEFwEVhNPxRN9IJFZPY/cowNS/b/DDXDj5Y
 z7ljIWt4vP/OWDM0DSs5IEGb2IPywgSCmCN0wOhxROi+6QxgjuyxJh6oE8nkrAoYPWLXJo8oyQb
 kafT27KC/yHu/9p9/7qYBLRN3p29csC8EUAKAGYuRtw==
X-Received: by 2002:a17:906:2506:: with SMTP id
 i6mr22661458ejb.186.1633421747514; 
 Tue, 05 Oct 2021 01:15:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyp4YSodXDYgZa9apzHQbUL+ooKe4LzYLJ9sj3uKlP/MO0rUF0FZcxHp7ME/b9/xv4DfDqaA==
X-Received: by 2002:a17:906:2506:: with SMTP id
 i6mr22661442ejb.186.1633421747353; 
 Tue, 05 Oct 2021 01:15:47 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id i10sm8525891edl.15.2021.10.05.01.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 01:15:46 -0700 (PDT)
Date: Tue, 5 Oct 2021 04:15:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 2/3] vdpa: Add vhost_vdpa_section_end
Message-ID: <20211005041429-mutt-send-email-mst@kernel.org>
References: <20211005080131.408506-1-eperezma@redhat.com>
 <20211005080131.408506-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211005080131.408506-3-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>
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

On Tue, Oct 05, 2021 at 10:01:30AM +0200, Eugenio P=E9rez wrote:
> Abstract this operation, that will be reused when validating the region
> against the iova range that the device supports.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>

Note that as defined end is actually 1 byte beyond end of section.
As such it can e.g. overflow if cast to u64.
So be careful to use int128 ops with it.
Also - document?

> ---
>  hw/virtio/vhost-vdpa.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> =

> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index ea1aa71ad8..a1de6c7c9c 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -24,6 +24,15 @@
>  #include "trace.h"
>  #include "qemu-common.h"
>  =

> +static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section)
> +{
> +    Int128 llend =3D int128_make64(section->offset_within_address_space);
> +    llend =3D int128_add(llend, section->size);
> +    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> +
> +    return llend;
> +}
> +
>  static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *sec=
tion)
>  {
>      return (!memory_region_is_ram(section->mr) &&
> @@ -160,10 +169,7 @@ static void vhost_vdpa_listener_region_add(MemoryLis=
tener *listener,
>      }
>  =

>      iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> -    llend =3D int128_make64(section->offset_within_address_space);
> -    llend =3D int128_add(llend, section->size);
> -    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> -
> +    llend =3D vhost_vdpa_section_end(section);
>      if (int128_ge(int128_make64(iova), llend)) {
>          return;
>      }
> @@ -221,9 +227,7 @@ static void vhost_vdpa_listener_region_del(MemoryList=
ener *listener,
>      }
>  =

>      iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> -    llend =3D int128_make64(section->offset_within_address_space);
> -    llend =3D int128_add(llend, section->size);
> -    llend =3D int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
> +    llend =3D vhost_vdpa_section_end(section);
>  =

>      trace_vhost_vdpa_listener_region_del(v, iova, int128_get64(llend));
>  =

> -- =

> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
