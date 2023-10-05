Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45B8E9272A
	for <virtualization@archiver.kernel.org>; Thu,  5 Oct 2023 19:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E79240A47;
	Thu,  5 Oct 2023 19:18:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E79240A47
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1DYS1c/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uFf-CRAja1Nn; Thu,  5 Oct 2023 19:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D0CF40280;
	Thu,  5 Oct 2023 19:18:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D0CF40280
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86654C0039;
	Thu,  5 Oct 2023 19:18:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D545C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 19:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46FD541FF1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 19:18:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46FD541FF1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1DYS1c/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41FdY3qSL6bQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 19:18:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C5A641E7A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 19:18:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C5A641E7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696533515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2R8nvS1fGysVMS5a70TnQ+euq+3ceDHbf0f2W4kS2b4=;
 b=E1DYS1c/Vb5lNUwW4K3kNTESufFV8GfqCa7asZgeG+C8zEe2n31TbUpIS0wd6IbAkBySWS
 /L+jIYf7XTOpvjXtjataBoLlc09qjmYS+Txj/o9vcOXkWcfa2g2g7eBFo71ZW4W8zArdD7
 Ao/cDj1FZFGLr7ua5+pTiZyJgudQbGQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-HCRIAI0IPKart0u0RaJerg-1; Thu, 05 Oct 2023 15:18:31 -0400
X-MC-Unique: HCRIAI0IPKart0u0RaJerg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso1051811f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Oct 2023 12:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696533510; x=1697138310;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2R8nvS1fGysVMS5a70TnQ+euq+3ceDHbf0f2W4kS2b4=;
 b=Cot912glapWl78NfvKq6aCRSDLqHWBTC47nppmwEEAc/tN0H4y/el5nQndSguqXsb6
 JCR9d5xi0JiHyt4vxO43g1tpCXA6kh1wCMJUnYS3D+hsMmB1Yoj8SM6bFp9U9eOhKkas
 NwJ1FlmZRrz1tyVGiyWhRDz3rVVnEs02zAaCTJ9pWq6eZ9dSCt/yxWE8gkUQQyDSV1yG
 zlVqL25CNa30I4r3850bxYcSbxQt70fuAChtGiR+u6Td2nc8qZ61AVEj/5OECcwKSbFw
 k/vc9MOKbxt4V020zF96P/1yxDxC/Qu8JR3PcbwaccOF22lMa+UKtUN4B4yIRy3jEkCd
 8O/Q==
X-Gm-Message-State: AOJu0YyNWeTq72HVpBE3EJBLvOeBAohsyx9mLVh4O/Q7wFsCuj2gcoPa
 N5wQacyU9TY63jePcB1LggnAZg/A8Sp42RkBpaAhGNoRwwa3AB9mBG0RNGxEexxiieKm3e8RCQQ
 DmJ/1iLvcXCw7r5I5jMRBySx/6N9BTzPxvhUoFvDIAA==
X-Received: by 2002:a5d:58c2:0:b0:319:7a9f:c63 with SMTP id
 o2-20020a5d58c2000000b003197a9f0c63mr5707829wrf.50.1696533510571; 
 Thu, 05 Oct 2023 12:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJSoSJCYUxP/9cvc2Te2pM2upBQSmDoYt/HKnGitt6LjIRBQVlh0qAuXtMDSL56hXqGRauRg==
X-Received: by 2002:a5d:58c2:0:b0:319:7a9f:c63 with SMTP id
 o2-20020a5d58c2000000b003197a9f0c63mr5707810wrf.50.1696533510205; 
 Thu, 05 Oct 2023 12:18:30 -0700 (PDT)
Received: from redhat.com ([2.52.3.174]) by smtp.gmail.com with ESMTPSA id
 e1-20020adffc41000000b003267b4692e5sm2421018wrs.19.2023.10.05.12.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 12:18:28 -0700 (PDT)
Date: Thu, 5 Oct 2023 15:18:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH vhost v2 00/16] vdpa: Add support for vq descriptor
 mappings
Message-ID: <20231005151812-mutt-send-email-mst@kernel.org>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
 <20231005133054-mutt-send-email-mst@kernel.org>
 <9dfa552011c20a58d8550bd794977de821212df4.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <9dfa552011c20a58d8550bd794977de821212df4.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "leon@kernel.org" <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Gal Pressman <gal@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

On Thu, Oct 05, 2023 at 05:44:01PM +0000, Dragos Tatulea wrote:
> On Thu, 2023-10-05 at 13:31 -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 28, 2023 at 07:45:11PM +0300, Dragos Tatulea wrote:
> > > This patch series adds support for vq descriptor table mappings which
> > > are used to improve vdpa live migration downtime. The improvement com=
es
> > > from using smaller mappings which take less time to create and destroy
> > > in hw.
> > > =

> > > The first part adds the vdpa core changes from Si-Wei [0].
> > > =

> > > The second part adds support in mlx5_vdpa:
> > > - Refactor the mr code to be able to cleanly add descriptor mappings.
> > > - Add hardware descriptor mr support.
> > > - Properly update iotlb for cvq during ASID switch.
> > > =

> > > Changes in v2:
> > > =

> > > - The "vdpa/mlx5: Enable hw support for vq descriptor mapping" change
> > > =A0 was split off into two patches to avoid merge conflicts into the =
tree
> > > =A0 of Linus.
> > > =

> > > =A0 The first patch contains only changes for mlx5_ifc.h. This must be
> > > =A0 applied into the mlx5-next tree [1] first. Once this patch is app=
lied
> > > =A0 on mlx5-next, the change has to be pulled fom mlx5-next into the =
vhost
> > > =A0 tree and only then the remaining patches can be applied.
> > =

> > =

> > I get it you plan v3?
> There are some very small improvements (commit message in 13/16 and fix in
> 16/16) that could make a v3. The latter can be addressed as a separate pa=
tch
> when moving dup_iotlb to vhost/iotlb. What do you think?


if there's a fix by all means post v3.

> > =

> > > [0]
> > > https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-em=
ail-si-wei.liu@oracle.com
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/lo=
g/?h=3Dmlx5-next
> > > =

> > > Dragos Tatulea (13):
> > > =A0 vdpa/mlx5: Expose descriptor group mkey hw capability
> > > =A0 vdpa/mlx5: Create helper function for dma mappings
> > > =A0 vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code
> > > =A0 vdpa/mlx5: Take cvq iotlb lock during refresh
> > > =A0 vdpa/mlx5: Collapse "dvq" mr add/delete functions
> > > =A0 vdpa/mlx5: Rename mr destroy functions
> > > =A0 vdpa/mlx5: Allow creation/deletion of any given mr struct
> > > =A0 vdpa/mlx5: Move mr mutex out of mr struct
> > > =A0 vdpa/mlx5: Improve mr update flow
> > > =A0 vdpa/mlx5: Introduce mr for vq descriptor
> > > =A0 vdpa/mlx5: Enable hw support for vq descriptor mapping
> > > =A0 vdpa/mlx5: Make iotlb helper functions more generic
> > > =A0 vdpa/mlx5: Update cvq iotlb mapping on ASID change
> > > =

> > > Si-Wei Liu (3):
> > > =A0 vdpa: introduce dedicated descriptor group for virtqueue
> > > =A0 vhost-vdpa: introduce descriptor group backend feature
> > > =A0 vhost-vdpa: uAPI to get dedicated descriptor group id
> > > =

> > > =A0drivers/vdpa/mlx5/core/mlx5_vdpa.h |=A0 31 +++--
> > > =A0drivers/vdpa/mlx5/core/mr.c=A0=A0=A0=A0=A0=A0=A0 | 191 +++++++++++=
+++++-------------
> > > =A0drivers/vdpa/mlx5/core/resources.c |=A0=A0 6 +-
> > > =A0drivers/vdpa/mlx5/net/mlx5_vnet.c=A0 | 100 ++++++++++-----
> > > =A0drivers/vhost/vdpa.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 27 ++++
> > > =A0include/linux/mlx5/mlx5_ifc.h=A0=A0=A0=A0=A0 |=A0=A0 8 +-
> > > =A0include/linux/mlx5/mlx5_ifc_vdpa.h |=A0=A0 7 +-
> > > =A0include/linux/vdpa.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0 11 ++
> > > =A0include/uapi/linux/vhost.h=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 ++
> > > =A0include/uapi/linux/vhost_types.h=A0=A0 |=A0=A0 5 +
> > > =A010 files changed, 264 insertions(+), 130 deletions(-)
> > > =

> > > -- =

> > > 2.41.0
> > =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
