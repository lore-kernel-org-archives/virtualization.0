Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D53AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 18 Oct 2022 08:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D162883046;
	Tue, 18 Oct 2022 08:02:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D162883046
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GJYKh2WU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DCMaLvGRrZ5q; Tue, 18 Oct 2022 08:02:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6743A8294A;
	Tue, 18 Oct 2022 08:02:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6743A8294A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3419AC0033;
	Tue, 18 Oct 2022 08:02:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70110C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31EC340A5F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:02:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31EC340A5F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GJYKh2WU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QQIfzcE1F-g4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:02:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35A1540A49
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35A1540A49
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 08:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666080161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkqFd2cqN+AXoSfyMk1Ng3aRTcV6SBGhPSlpDU2xWJ8=;
 b=GJYKh2WUJlFJ3QPKiyDB2MWPOW6ntNwuYBeMVhqDFZzvrwC92cxtFtEYm5rpjnNOzomxE6
 USs+IafdczqquVKjha2k5vLoZcolHbV+xmxiV6KKjmZ7P2sKDsUeRYXP4y3duSzW77zGtl
 ostCePK/UoBEfBXa04L5tqXIVmFkjv8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-iu8Go6QDOyOCmorlV8_Q_Q-1; Tue, 18 Oct 2022 04:02:39 -0400
X-MC-Unique: iu8Go6QDOyOCmorlV8_Q_Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 x5-20020a544005000000b003545901f0deso5168887oie.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Oct 2022 01:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YkqFd2cqN+AXoSfyMk1Ng3aRTcV6SBGhPSlpDU2xWJ8=;
 b=UI68zKWpqo4w6V2XcrQVmhCAL5NyAlZmIvxYgkNoV6rvMjZ+g7aX8Zp4RsHt9AZ7eN
 YZlLW1eWCIKvwfopIVliLnau6JGYZ422vOXSElc6TNefzFzyXqB+CQmpG3wZ1WiMuB1V
 HanyJICQlr6TlYI1yH5c5kKhNZohJB24VcNV9gr/eekLDtPffCL6Abg9oRbLf/71BqR9
 BQe0OhzqOh1w0Qows8IRstFfq3CFN1RwcmTzV2MGhW/1xpsDEdq4mqmjc+tkYejQqobA
 Gne3CrX63nE041jN4RK++IA4ifMrHdhIMuxG86Vl40tjTY0/UEKElqQK0KOZqQME+cRt
 SL8Q==
X-Gm-Message-State: ACrzQf1plg7sADBc1HchMGuaEWyGuZTTiPO/2wuE+PyDLWSjZCZ8miKE
 iB1/aJsC0z0tgpe3fGPVoE9xW8MNcl8vyK1piyEoPFR3jEyYXcBvf+29eOjv+UO9lqmrfOYNHiH
 K9CsTbxnzoHiM+scRwEH/qdfBmL3U/deP2I7I2Ok93Sp3EEdpK/c7Uvljag==
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr752115otn.201.1666080159039; 
 Tue, 18 Oct 2022 01:02:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5aq2EiRfLQxL3Fzm4X6MDOYdo60o/DxbF2iB1TwdWDvdBYDYMYr7j1WIz+aMEtPnt+oKHOMZeInRsZa2QvT08=
X-Received: by 2002:a9d:7dcf:0:b0:661:dc25:ba0 with SMTP id
 k15-20020a9d7dcf000000b00661dc250ba0mr752106otn.201.1666080158805; Tue, 18
 Oct 2022 01:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1666008238.git.sebastien.boeuf@intel.com>
 <20221018021506-mutt-send-email-mst@kernel.org>
 <137616129e0bfaba371b50786f3fd7d1fe0c95c9.camel@intel.com>
In-Reply-To: <137616129e0bfaba371b50786f3fd7d1fe0c95c9.camel@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Oct 2022 16:02:27 +0800
Message-ID: <CACGkMEtSoxO1xTZLLGxEz3Hq=LC_jiBZhFR=dacrag48pOsNow@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] vdpa: Add resume operation
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "mst@redhat.com" <mst@redhat.com>
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

On Tue, Oct 18, 2022 at 3:58 PM Boeuf, Sebastien
<sebastien.boeuf@intel.com> wrote:
>
> On Tue, 2022-10-18 at 02:15 -0400, Michael S. Tsirkin wrote:
> > On Mon, Oct 17, 2022 at 02:06:19PM +0200,
> > sebastien.boeuf@intel.com wrote:
> > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > >
> > > This series introduces a new operation for vdpa devices. It allows
> > > them
> > > to be resumed after they have been suspended. A new feature bit is
> > > introduced for devices to advertise their ability to be resumed
> > > after
> > > they have been suspended. This feature bit is different from the
> > > one
> > > advertising the ability to be suspended, meaning a device that can
> > > be
> > > suspended might not have the ability to be resumed.
> > >
> > > Even if it is already possible to restore a device that has been
> > > suspended, which is very convenient for live migrating virtual
> > > machines,
> > > there is a major drawback as the device must be fully reset. There
> > > is no
> > > way to resume a device that has been suspended without having to
> > > configure the device again and without having to recreate the IOMMU
> > > mappings. This new operation aims at filling this gap by allowing
> > > the
> > > device to resume processing the virtqueue descriptors without
> > > having to
> > > reset it. This is particularly useful for performing virtual
> > > machine
> > > offline migration, also called snapshot/restore, as it allows a
> > > virtual
> > > machine to resume to a running state after it was paused and a
> > > snapshot
> > > of the entire system was taken.
> > >
> > > Sebastien Boeuf (4):
> > >   vdpa: Add resume operation
> > >   vhost-vdpa: Introduce RESUME backend feature bit
> > >   vhost-vdpa: uAPI to resume the device
> > >   vdpa_sim: Implement resume vdpa op
> > >
> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 19 ++++++++++++++++++
> > >  drivers/vhost/vdpa.c             | 34
> > > +++++++++++++++++++++++++++++++-
> > >  include/linux/vdpa.h             |  6 +++++-
> > >  include/uapi/linux/vhost.h       |  8 ++++++++
> > >  include/uapi/linux/vhost_types.h |  2 ++
> > >  5 files changed, 67 insertions(+), 2 deletions(-)
> >
> >
> > Not on list:
> >
> > $ b4 mbox cover.1666008238.git.sebastien.boeuf@intel.com
> > Looking up
> > https://lore.kernel.org/r/cover.1666008238.git.sebastien.boeuf%40intel.com
> > That message-id is not known.
> > $
> >
> >
> > dropped for now.
>
> Oh I didn't realize the list wasn't receiving my patch series. What is
> the correct list? I was using virtualization@lists.linux-foundation.org
> which I found from the MAINTAINERS file.

Have you tried to use scripts/get_maintainer.pl? I guess all patches
should be copied to linux-kernel@vger.kernel.org at least.

Thanks

>
> >
> > > --
> > > 2.34.1
> > >
> > > -------------------------------------------------------------------
> > > --
> > > Intel Corporation SAS (French simplified joint stock company)
> > > Registered headquarters: "Les Montalets"- 2, rue de Paris,
> > > 92196 Meudon Cedex, France
> > > Registration Number:  302 456 199 R.C.S. NANTERRE
> > > Capital: 5 208 026.16 Euros
> > >
> > > This e-mail and any attachments may contain confidential material
> > > for
> > > the sole use of the intended recipient(s). Any review or
> > > distribution
> > > by others is strictly prohibited. If you are not the intended
> > > recipient, please contact the sender and delete all copies.
> >
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
