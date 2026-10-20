Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792492833;
	b=c51uDMnFq+hqssdPIShfRCm947KnUfp1LEW5PkCe8wK3dn1iPRPYMHvtSNgQQ241jtr6
	 vBybsU0cE5WU71Yq3Dn7oVNgmuaXWnm93bolMzsTaRpSIf0LbMucBAZt1Mz9/Lm2GU9Qh
	 PAlw0MjpIy99ryNE0yGHLxWPeaBCjneTZ4cd3AzDfqf0XoOxbeKA5UO6zKB2cLi3chgjX
	 eOL6904B459BC5dlu3Qs9nB0oo9WES3Ofrzf/AsYd5wxp4LqXsG/kSbFdwbEIdUnJIZj/
	 6+T1A4+yRwcpjz5wBu1fM3UFhRwCazk9546FyiEgCA6XWX8Uu8qQh0WktIdB6EpToeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492833;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:X-Mutt-Fcc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=VIDP3nx+FxbnMIBjBfYFZNsQEwlHUezNmijwKASBZA4=;
	b=0/xhkmtorXhYoM/k8+otXDc5JSD3KevYm2MfhRJ7moXK08jl3KO2AhpcJ3xu/9y6miHy
	 6cznIrK6btWCnQ/ISoBksNgbaCiv1NPiplO4hN4Rbo413nXUVSk46k3vCP1hBVGsqynZJ
	 sC3OE69H+ZjxoA6KTGAmT5DjaQ7E/XDNh4cz/G98u8BFjN3YCb4N6eNe2ugTwZRIl8CoC
	 xVM7dqlso0iK9WV6FM2TVY9UUHSDYwZYSr5XCUVbAsfxS0Qp2Pf+diYG+P9o39/aV5cAM
	 nmHouNaTVZ2CsNPN7L8IoPkETdvmaz7r60XteZrKHBSTKHtk9KGFeArrKO0LuxpVBKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RmdHq4N7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.138
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D8606A31F
	for <virtualization@lists.linux-foundation.org>; Tue, 20 Oct 2026 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RmdHq4N7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB20280DD2
	for <virtualization@lists.linux-foundation.org>; Tue, 20 Oct 2026 10:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.693
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jy9W1RUp9oGu for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2026 10:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F1E080C50
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792492831;
	b=hef5hwcnzHTLByKEQrcG7S8+eWhpIbEO+iW3wE0LOCRgPC60R5izA25028UY6oFWXbmu
	 claZNzwWeulHIldmueoI5OxJE1g1iOA0EUL7+MDHNXVdzYYcJUyCh/1nHJsu//kA41thF
	 rja1trXZliC8UmXR9x6KuX9KgHr8IyyVvoVC19neRFnTUUKCRbB1MNO6nE9HUuZCDnevz
	 u3Epcas9Co4LfGi21UXAsUiWKB0P8CtA1RVWpBMn7Db1yA39mT25YlKJQUT5izYWsG4SU
	 pfFr10ljlnxpZY6LiNtUh41NCJUMxBHxr6/gK96uyU0jcymHDfQloyHYcIK2nLnCx2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792492831;
	h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=VIDP3nx+FxbnMIBjBfYFZNsQEwlHUezNmijwKASBZA4=;
	b=DrTQZcJC5cnk2ZXMX03JjwiX5YZ+TFrO5r24kU5p4EGFjQbpYfuaSjvBO8NVBTP72EkZ
	 z3aquSH7PyB4Aaey4iKJIxctwbEXeAKTPKhn00+Mw6x0x6n9JLcDTPjm/mkUf5LrcQNCo
	 6oM1uABXUsalD3a9dLReQhMplGyUYDoonGUbgkkTa8uzdWQPdLuNNHpMEWlbOl4qj7VFa
	 oIOvM71O/A0PB4itmbiOd9hyAyTpe6g5eFXUzQ6Bcxnei+gDNqhJobnJda5KbSq7FFYom
	 ZpRrO2kLpebV5pHdhMFhxOqmJTg7m05wiFCj/xtsqX2uN/XNDJKOxQ+B17dfpfxCoOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RmdHq4N7;
	arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RmdHq4N7
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F1E080C50
	for <virtualization@lists.linux-foundation.org>; Tue, 20 Oct 2026 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792492828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VIDP3nx+FxbnMIBjBfYFZNsQEwlHUezNmijwKASBZA4=;
	b=RmdHq4N7uHME6HBybqJQuPI3oaUxpgLWAL0fiClnHcx6Fgu09FS8E1LXsuI76+3nWbcK++
	Hpf0l2raqDdKuTwZvOEKmcfhngdxVqwUWpzVkwOjb1cGTRKBAbGrKc8WIm/3yAQrZZFcsF
	Lbnp/7aEfhgIuF0E+gpPABJ5xlo84gc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-tEqowQEmN9OFZFBEEmrxWQ-1; Tue, 20 Oct 2026 06:40:27 -0400
X-MC-Unique: tEqowQEmN9OFZFBEEmrxWQ-1
X-Mimecast-MFC-AGG-ID: tEqowQEmN9OFZFBEEmrxWQ_1792492826
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a17741243eso18284295e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 20 Oct 2026 03:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492826; x=1793097626;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VIDP3nx+FxbnMIBjBfYFZNsQEwlHUezNmijwKASBZA4=;
        b=Wl/ofQ2JPe+igRDGNRdgLno0IXXC8Vbe5qJpTGOmaO9vH9HSiufz0wDkE8qJKZ6tPW
         8NcfnpRdZ96/DqkeamI43x/Fc2lQpfY09HjC8EsL5IApNdWpb1hO1O5EEhgcHoirX4Uo
         9ZSntqH01pgc7F3uEizjLIsdfRbOMHadK8zJH+m0iOTfD2uvcHad6KlBhsgZEQoMuWVM
         VN3zhdUUTkLT9OemAAfdcxx4FtWGi8k+uMBZJdUyNgGgMhVizkymAGOpeDmqHOTLog0E
         aqhSMIkV+WuxrraK1uCRgr8KAMGUdWDoAmtVROPXQkK0TiRykt7ZhAyesWZZjS8hfoBY
         pXvw==
X-Forwarded-Encrypted: i=1; AKwUvBw/jXrCm8nrblPjuC5bySkw2STKE+yntUNdx/h55dQVXtzNAo6Wy5zPMgtmKpjey5GmUiCPc+4k6huFmH554A==@lists.linux-foundation.org
X-Gm-Message-State: AFq9FYLGNdaBxWvfBq7lcfaSVXFAwnfbSFmyT8fA2whylfmX+7RKxpwZ
	YKN+OcWUBL0V/FUhinmglVWvc8oXVBsrAqA5OlQA/KR7a0QQcUTb/dVVra9lYRjFaNCo98IBD3m
	zT+p2P1/H4zssQirxh2GiDlruZkxqWUyb+qSu+vSFrM9Z4w2Amsl6cJP2UMhdzLFhV67zJ7Km6r
	VoOhRjS8c=
X-Gm-Gg: AYBFou1dyu4hGltNm7roBXmDsh9VRiAsPjGM8DTQ1PhnpAS+SFqtZi6kH05DiZx6oId
	EFg3vhUOcwzq4X4EIrBZ5PesD9eO9knlybYWLHAnQa3DFZy3ZxfEGq5upfNE6U8KwZFFO172iFP
	Qxcy9WOW0MYEbTOXqTFVpPr/epq/4ddN361skunkzc0MbaBwERaSTvp+EDGaWBHSovzb34fo++K
	QXQfhDjxZYz+JHMVJHZpPjhK3aLclQSopd90Titdq06OiGc0VPSLUt49w0Ua0ohQxYMB1WtyLzJ
	bMcQtuZK2O3faclKkLxPqP5J6i6y3sBOxH171rMleFaVePWb+AZkwd/K2+QiaZ7XxeKh1g==
X-Received: by 2002:a05:600c:1c19:b0:4a1:ec5b:dca with SMTP id 5b1f17b1804b1-4a1ec5b0fb6mr118201075e9.15.1792492825843;
        Tue, 20 Oct 2026 03:40:25 -0700 (PDT)
X-Received: by 2002:a05:600c:1c19:b0:4a1:ec5b:dca with SMTP id 5b1f17b1804b1-4a1ec5b0fb6mr118200305e9.15.1792492825235;
        Tue, 20 Oct 2026 03:40:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dbf12sm5345167f8f.1.2026.10.20.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:40:24 -0700 (PDT)
Date: Tue, 20 Oct 2026 06:40:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrey.drobyshev@virtuozzo.com, den@openvz.org, jiri@resnulli.us,
	kmehltretter@gmail.com, mst@redhat.com, ptikhomirov@virtuozzo.com,
	sashiko-bot@kernel.org, tanglongjun@kylinos.cn
Subject: [GIT PULL] vhost,virtio: fixes, features, cleanups
Message-ID: <20261020064022-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vZ8NMo0RoLToclPg9bvd6d2_yjaft7E8Xg-_onRHxk4_1792492826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,
I have a bunch more fixes under review, but let's get this off my plate
first. Thanks!

The following changes since commit 48a4ee65e677559776349128e6a81a6041986c99:

  vduse: return compat ioctl results directly (2026-09-08 03:58:27 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c69023b5e16e5ffe9368603dca76d85bd544ee57:

  tools/virtio: add missing device-id/virtio.h wrapper header (2026-10-08 18:30:04 -0400)

----------------------------------------------------------------
vhost,virtio: fixes, features, cleanups

This adds CPR support for vhost.

Plus some fixes, notably for a host of races we had when callback fire
around device reset.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Andrey Drobyshev (3):
      vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
      vhost/vsock: re-scan TX virtqueue on device start
      vhost: synchronize with RCU readers when freeing workers

Karl Mehltretter (6):
      virtio_ccw: fix synchronize_cbs() after interrupt fallback
      virtio_ccw: always take irq_lock in the classic interrupt handler
      remoteproc: implement synchronize_cbs() for virtio devices
      um: virtio_uml: implement synchronize_cbs()
      platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
      virtio_vdpa: implement synchronize_cbs()

Longjun Tang (1):
      tools/virtio: add missing device-id/virtio.h wrapper header

Michael S. Tsirkin (3):
      virtio: synchronize callbacks after device reset
      virtio_pci_modern: move avq cleanup from reset to del_vqs
      virtio_pci: drop callback sync on reset

Pavel Tikhomirov (2):
      vhost/vsock: split out vhost_vsock_drop_backends helper
      vhost/vsock: add VHOST_RESET_OWNER ioctl

 arch/um/drivers/virtio_uml.c             | 10 ++++
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++
 drivers/remoteproc/remoteproc_core.c     | 12 +++++
 drivers/remoteproc/remoteproc_virtio.c   | 39 +++++++++++---
 drivers/s390/virtio/virtio_ccw.c         |  6 +--
 drivers/vhost/net.c                      |  4 +-
 drivers/vhost/scsi.c                     |  2 +-
 drivers/vhost/test.c                     |  4 +-
 drivers/vhost/vdpa.c                     |  4 +-
 drivers/vhost/vhost.c                    | 26 ++++++++--
 drivers/vhost/vhost.h                    |  5 +-
 drivers/vhost/vsock.c                    | 89 +++++++++++++++++++++++++-------
 drivers/virtio/virtio.c                  |  2 +
 drivers/virtio/virtio_pci_legacy.c       |  2 -
 drivers/virtio/virtio_pci_modern.c       | 15 +++---
 drivers/virtio/virtio_vdpa.c             | 34 ++++++++++--
 include/linux/remoteproc.h               |  3 ++
 tools/virtio/linux/device-id/virtio.h    |  2 +
 18 files changed, 215 insertions(+), 59 deletions(-)
 create mode 100644 tools/virtio/linux/device-id/virtio.h

