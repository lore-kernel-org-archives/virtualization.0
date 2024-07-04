Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4320846F
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096788; cv=none; b=u9JrAj2FIpXSGcRzm/1d1GMfW6sgc23+AFk/xz8sWwvcmpPUksshlmqTl5xfUk934PBNMf3yrnOvBSrJjQeikkmUo3LGF3YRT7ykDsb3sT3Erx8bzc1iRfhsgWPKVoAs0TOKOP2mwGZEaZsH91bd7CJd/B3sdK0utfo3nG9dUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096788; c=relaxed/simple;
	bh=NyzhNaCD6TlbH3eplfpU12b8aIOnZIV3hb57vBkYwUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f1cmr86hJxFLSP+fG5gmFIafS6DNuLpWj+zeCxMfquzVeXmUgdmnLoUcN7ACLWZugaS6i2ydUEEpGozpVljpV2KUnaxEQz84e5PnBS1SRQm6q4jsxU7K/mGPPO8zVX6RUdO+UjJczHxBsxbeQ6K1HNafuAznJhzbsSY01PGUUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5BQNkCS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5BQNkCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720096785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbCSLoklM3MzRq4o8/18W6TFG/1GqzX79QciXUnAMlc=;
	b=K5BQNkCS7rbg2AqvMUmvGnA2B9eSrrmmikCcbzZ9o3VzgCu4sPBWLf4F2lyTQI0KbK1rmI
	8cbZKomohTPSxSYj2i95WYo8Hb1bqxr28rrARboMWR0peR8AO7D6g9acF3f1dGZ3liB/z8
	362QJ2s2TW3jRuPBeH2HZXUAUGqsNvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-cWLURNmsNA2DPVro3RufFw-1; Thu, 04 Jul 2024 08:39:43 -0400
X-MC-Unique: cWLURNmsNA2DPVro3RufFw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4257dd7d40dso3742275e9.0
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 05:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720096781; x=1720701581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbCSLoklM3MzRq4o8/18W6TFG/1GqzX79QciXUnAMlc=;
        b=O0lbLgaaLmM/RQXWo2vW5KM0HqWJJGEPVSMP3T63SYBVPq+kBTqgShR5x+Xxwqo9fM
         JnBduubPcwTvWSagegCtifwKCQxUzokiJQ0ngf9rqvIdUncieHPksGkl3EnAvITxSkBa
         im8NJwWBMyVVt3RYA8Y5zGG8nF8gaJSAga/u+pmjbHvdcR5fhv44XLVHRgxjQAFVbe+L
         Ew0D5uKyyvAR0btyhx2NSHbibGZ175WCZFUhh4zqB9LC/+xWhjm35K3vRqh/BRGx9hco
         P1Psw2K0IKYurmJ2gjQaIpcvI1jfApyk1hn5k6kMovzyl9Dt68VTmkdSAFb8CyOG9YLf
         FNSQ==
X-Gm-Message-State: AOJu0YyVPUK49SOhb99v/w0N8aKhJjnMg/RWoF11BrPW4lqLIlXqNGZF
	UVjH4E98ZaUwj+5pAppekVmHBcmjCnPVimVQEDIy42+bkC3VGKf60HaSiMBIlpS8gemIFncZ2Me
	Ov6jaR4jMXW6WgaP3YgOEcXfKaN9EUf79nzTkErXwVdyRg4lZewWfTnQz+ccqzPZaj3nbn1ob
X-Received: by 2002:a05:600c:54e6:b0:424:ac5a:fc38 with SMTP id 5b1f17b1804b1-4264b161646mr15014205e9.13.1720096781552;
        Thu, 04 Jul 2024 05:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs/WBEBWKjr4Lx03mHOdCvB2r/isu8JdNOTZHz0urAoON5MI34HLy/oYhJe9FRI+JRyEc5Zw==
X-Received: by 2002:a05:600c:54e6:b0:424:ac5a:fc38 with SMTP id 5b1f17b1804b1-4264b161646mr15013795e9.13.1720096780890;
        Thu, 04 Jul 2024 05:39:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:a185:2de6:83fc:7632:9788])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f22acsm23271015e9.24.2024.07.04.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:39:40 -0700 (PDT)
Date: Thu, 4 Jul 2024 08:39:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	eperezma@redhat.com, parav@nvidia.com, feliu@nvidia.com,
	hengqi@linux.alibaba.com, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH virtio 00/19] virtio: consolidate vq info args of
 find_vqs()
Message-ID: <20240704083515-mutt-send-email-mst@kernel.org>
References: <20240703123913.969202-1-jiri@resnulli.us>
 <20240703084954-mutt-send-email-mst@kernel.org>
 <ZoVRIwZGbQNKwfqA@nanopsycho.orion>
 <20240703093649-mutt-send-email-mst@kernel.org>
 <1720093115.9907808-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1720093115.9907808-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2024 at 07:38:35PM +0800, Xuan Zhuo wrote:
> On Wed, 3 Jul 2024 09:37:10 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Jul 03, 2024 at 03:24:51PM +0200, Jiri Pirko wrote:
> > > Wed, Jul 03, 2024 at 02:50:36PM CEST, mst@redhat.com wrote:
> > > >On Wed, Jul 03, 2024 at 02:38:54PM +0200, Jiri Pirko wrote:
> > > >> From: Jiri Pirko <jiri@nvidia.com>
> > > >>
> > > >> Currently, virtio_find_vqs() and virtio_find_vqs_ctx() accept array of
> > > >> names, callbacks and ctx (in case of the second one) as separate args.
> > > >> That became inconvenient as the ctx addition showed.
> > > >>
> > > >> For virtio_net control queue, an indication of queue flavour (slow path)
> > > >> is going to be needed to be passed to PCI transport in order to
> > > >> assign vectors properly, another array added to virtio_find_vqs_ctx()
> > > >> arg list would not be nice and convenient.
> > > >>
> > > >> Instead, introduce a structure to carry vq callback, name and ctx. Pass
> > > >> array of these structures to virtio_find_vqs() and all the way down to
> > > >> transport find_vqs() op implementation.
> > > >>
> > > >> That allows to easily extend what needs to be passed down. Also, it
> > > >> makes the code a bit more cleaner. We get rid of separate
> > > >> virtio_find_vqs_ctx() helper.
> > > >>
> > > >> This patchset does the conversion in steps, using temporary _info() op
> > > >> and helper. Note they are renamed back.
> > > >
> > > >Thanks a lot Jiri, looks very good.
> > > >Some minor comments.
> > >
> > > Will fix and send v2 tomorrow. I have my admin queue patchset rebased on
> > > top of this and code will be ready for control queue to benefit from
> > > vector allocation.
> >
> >
> > Excellent, I hope it makes it in next in time for the next merge window.
> 
> Hi, Michael, you know I was working on this.
> 
> Is the virtio community already in such a mess?

Sorry you feel that way.  Jiri, I think it's fair to add

Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

to patches 4 and 10-17.



> >
> > >
> > > >
> > > >
> > > >> Patch #1 does one forgotten conversion to virtio_find_single_vq().
> > > >> Patches #2 and #3 do preparations for find_vqs_info() op introduction.
> > > >> Patch #4 introduces new op find_vqs_info() to replace find_vqs() it also
> > > >>   introduces struct virtio_queue_info and virtio_find_vqs_info() helper.
> > > >> Patches #5 and #6 convert transports to implement find_vqs_info() op
> > > >>   that accepts array of virtio_queue_info structs.
> > > >> Patch #7 converts virtio_find_single_vq() to use the new way as well.
> > > >> Patch #8 removes original find_vqs() op.
> > > >> Patch #9 renames find_vqs_info() to find_vqs() and completes first part
> > > >>   of conversion this patches does.
> > > >> Patches #10-#17 convert virtio_find_vqs() and virtio_find_vqs_ctx()
> > > >>   users to use new virtio_find_vqs_info() helper.
> > > >> Patch #18 removes no longer used virtio_find_vqs() and
> > > >>   virtio_find_vqs_ctx() helpers.
> > > >> Patch #19 finalizes the conversion by renaming virtio_find_vqs_info()
> > > >>   to virtio_find_vqs().
> > > >>
> > > >> Jiri Pirko (19):
> > > >>   caif_virtio: use virtio_find_single_vq() for single virtqueue finding
> > > >>   virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
> > > >>   virtio: make virtio_find_single_vq() call virtio_find_vqs()
> > > >>   virtio: introduce virtio_queue_info struct and find_vqs_info() config
> > > >>     op
> > > >>   virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
> > > >>   virtio: convert find_vqs() op implementations to find_vqs_info()
> > > >>   virtio: call virtio_find_vqs_info() from virtio_find_single_vq()
> > > >>     directly
> > > >>   virtio: remove the original find_vqs() op
> > > >>   virtio: rename find_vqs_info() op to find_vqs()
> > > >>   virtio_blk: convert to use virtio_find_vqs_info()
> > > >>   virtio_console: convert to use virtio_find_vqs_info()
> > > >>   virtio_crypto: convert to use virtio_find_vqs_info()
> > > >>   virtio_net: convert to use virtio_find_vqs_info()
> > > >>   scsi: virtio_scsi: convert to use virtio_find_vqs_info()
> > > >>   virtiofs: convert to use virtio_find_vqs_info()
> > > >>   virtio_balloon: convert to use virtio_find_vqs_info()
> > > >>   virtio: convert the rest virtio_find_vqs() users to
> > > >>     virtio_find_vqs_info()
> > > >>   virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx()
> > > >>     helpers
> > > >>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
> > > >>
> > > >>  arch/um/drivers/virt-pci.c                    |  8 ++-
> > > >>  arch/um/drivers/virtio_uml.c                  | 12 ++--
> > > >>  drivers/block/virtio_blk.c                    | 20 +++----
> > > >>  drivers/bluetooth/virtio_bt.c                 | 13 ++--
> > > >>  drivers/char/virtio_console.c                 | 43 ++++++-------
> > > >>  drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++------
> > > >>  drivers/firmware/arm_scmi/virtio.c            | 11 ++--
> > > >>  drivers/gpio/gpio-virtio.c                    | 10 ++--
> > > >>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
> > > >>  drivers/iommu/virtio-iommu.c                  | 11 ++--
> > > >>  drivers/net/caif/caif_virtio.c                |  8 +--
> > > >>  drivers/net/virtio_net.c                      | 34 ++++-------
> > > >>  drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
> > > >>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 ++--
> > > >>  drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
> > > >>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
> > > >>  drivers/s390/virtio/virtio_ccw.c              | 13 ++--
> > > >>  drivers/scsi/virtio_scsi.c                    | 32 ++++------
> > > >>  drivers/virtio/virtio_balloon.c               | 32 ++++------
> > > >>  drivers/virtio/virtio_input.c                 |  9 +--
> > > >>  drivers/virtio/virtio_mmio.c                  | 12 ++--
> > > >>  drivers/virtio/virtio_pci_common.c            | 49 ++++++++-------
> > > >>  drivers/virtio/virtio_pci_common.h            |  4 +-
> > > >>  drivers/virtio/virtio_pci_modern.c            |  5 +-
> > > >>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
> > > >>  fs/fuse/virtio_fs.c                           | 22 +++----
> > > >>  include/linux/virtio_config.h                 | 60 +++++++++----------
> > > >>  net/vmw_vsock/virtio_transport.c              | 16 ++---
> > > >>  sound/virtio/virtio_card.c                    | 23 ++++---
> > > >>  29 files changed, 240 insertions(+), 302 deletions(-)
> > > >>
> > > >> --
> > > >> 2.45.2
> > > >
> >

