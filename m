Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B037B3F3
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722208812; cv=none; b=II9jgHd3+fWTr27psn7ZDWJIS70CHvJr2kxBd2j6SvI0N4xCIvnkDieSLWyIvB1lv+0uA5RGPtwRDZqKSt1k9t2JaKU/pHN9B+D586+waLaSTk53oBmrMT/g/EprsXvuCH3bklr+EnjX5j9dE3DO7Qtiz7g8945TAv56nqTRMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722208812; c=relaxed/simple;
	bh=+dP40l89F19I3cNbdMF63OXjKsihv2/8PwPxnwj6LNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JGBrwrPQOIGDg2msp+H+B4PxfTn7bzv054+XnlsT4h8AacbS8h5lF4romEN6qnMQIUy2SmtOMDx6m2vBVwysSMx/KsDndT6p5ZLhzDW/ix/goqx7WammO3eIyAsk1s9iJnyjtOpEJsQBQ6o5lcscP+y7lZluObvt4lgXIGmux1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqygtvB3; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqygtvB3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6362C60717
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 23:20:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1dc3yNeHrSW for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Jul 2024 23:20:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2ABCB605B1
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2ABCB605B1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cqygtvB3
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2ABCB605B1
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722208806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+eRbOioU+yVUzmrkos9cLIO1XQ0vF0g/0lgz70sgOCo=;
	b=cqygtvB3T5WwlWeiQKBqnu5uIVWep6apQRd60pb/Z3v6848NogHzWYpDaqV0RAtYAh3BqI
	6TbA8B160LB9JPfoRCjASVqLqFQJ7h7b9h0SYuRtkeKk1UA+84cwavhKr6oJWorF8cP0iD
	ZzSv4ZJc/WIQ2+24yYYXKXyju9Iy3WI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-couHXwnNPnq7gZVt3GGBJA-1; Sun, 28 Jul 2024 19:20:04 -0400
X-MC-Unique: couHXwnNPnq7gZVt3GGBJA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42816096cb8so15066175e9.0
        for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 16:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722208803; x=1722813603;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+eRbOioU+yVUzmrkos9cLIO1XQ0vF0g/0lgz70sgOCo=;
        b=hVQ2Hr0SvoUUegmRBUo403APNw37wTcaiyXkrsjnfazI8kxHCYlFBn+iDBx2SAuZsT
         BAuv52Zx8VIYOOxb8SWkFEbUX44nw5bJdNQjxy/nS79RMIybfN+jciaxHbgQr16e+lSE
         dAHcwKqDlK3VP9keMtgnOl40zHilxStSWY/gUsu65T0GBkRzP/48iudyiymdStS59dXP
         eORWl/ff40agKiU6eEkXVEpD6Kyyz4CogKtYXleylgU4/zkp5XdnhSCV3OaAZeCdJWac
         Y12HL7Yn1FqLbDKZf44PZRbUJ7DxBWpGs11kGx2WfoM8HeZibIAnk+ARh+/Ebf+QGvLe
         ifNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX17Z5ochboGZeoKbS4W3NekneZ6DEbmOIftLtwDiaa5EZq+4R9E9+UnRVRbMlShwjhEZfb96ZVZlSr4fy7gfEYFoA3IIUuG9rzFKg3NLywBB19IpCz6nH2KA==
X-Gm-Message-State: AOJu0YzcuftY0lTlpNUyzre11APRvgG/OCONnymWdfkqMMBl43VIfwMG
	rBX1A003iH7D/1qW1O4h741qZT/l71SsjSIpuhOYyf21FT1Y94xvL2Q0SxCCa5QasmZ6NtQmfIN
	FYv9oope1JqsP+oeIbGC/MMPGS6KrpcHbQyJY4+UcVTPb6zg52XmYB/KJO/EAWTigRiwsXoZlWu
	/owIY=
X-Received: by 2002:a05:600c:19c8:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-42811d8c0d7mr48465255e9.11.1722208803525;
        Sun, 28 Jul 2024 16:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJQeBFE1Ei3wW/3T05Gw1tpFuinUnNFeeMy1TSpz7EYl+J4w9ikvZ++fHV9MkZAfomQa2gNg==
X-Received: by 2002:a05:600c:19c8:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-42811d8c0d7mr48464915e9.11.1722208802271;
        Sun, 28 Jul 2024 16:20:02 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:98c4:742e:26be:b52d:dd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281a26e1bcsm33145835e9.34.2024.07.28.16.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 16:20:01 -0700 (PDT)
Date: Sun, 28 Jul 2024 19:19:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, jiri@nvidia.com, jiri@resnulli.us,
	mst@redhat.com, quic_jjohnson@quicinc.com
Subject: [GIT PULL] virtio: fixes for rc1
Message-ID: <20240728191956-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The biggest thing here is the adminq change - but it looks like
the only way to avoid headq blocking causing indefinite stalls.


The following changes since commit 6c85d6b653caeba2ef982925703cbb4f2b3b3163:

  virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07-17 05:20:58 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 6d834691da474ed1c648753d3d3a3ef8379fa1c1:

  virtio_pci_modern: remove admin queue serialization lock (2024-07-17 05:43:21 -0400)

----------------------------------------------------------------
virtio: fixes

This fixes 3 issues:
- prevent admin commands on one VF blocking another:
  fixes a huge scalability issue with large # of VFs
- correctly return error on command failure on octeon
  fixes a corruption if any commands fail
- fix modpost warning when building virtio_dma_buf
  harmless, but the fix is trivial

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (1):
      vdpa/octeon_ep: Fix error code in octep_process_mbox()

Jeff Johnson (1):
      virtio: add missing MODULE_DESCRIPTION() macro

Jiri Pirko (13):
      virtio_pci: push out single vq find code to vp_find_one_vq_msix()
      virtio_pci: simplify vp_request_msix_vectors() call a bit
      virtio_pci: pass vector policy enum to vp_find_vqs_msix()
      virtio_pci: pass vector policy enum to vp_find_one_vq_msix()
      virtio_pci: introduce vector allocation fallback for slow path virtqueues
      virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
      virtio: push out code to vp_avq_index()
      virtio_pci: pass vq info as an argument to vp_setup_vq()
      virtio: create admin queues alongside other virtqueues
      virtio_pci_modern: create admin queue of queried size
      virtio_pci_modern: pass cmd as an identification token
      virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result
      virtio_pci_modern: remove admin queue serialization lock

 drivers/vdpa/octeon_ep/octep_vdpa_hw.c |   2 +-
 drivers/virtio/virtio.c                |  28 +----
 drivers/virtio/virtio_dma_buf.c        |   1 +
 drivers/virtio/virtio_pci_common.c     | 192 ++++++++++++++++++++++++++-------
 drivers/virtio/virtio_pci_common.h     |  16 +--
 drivers/virtio/virtio_pci_modern.c     | 161 +++++++++++++--------------
 include/linux/virtio.h                 |   3 +
 include/linux/virtio_config.h          |   4 -
 8 files changed, 243 insertions(+), 164 deletions(-)

