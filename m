Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BC4F602
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593369; cv=none; b=lnp6j2lJ0cn1DuPa5oE6eeGB+5tt4cBwbpu1zX7pbZN3sI8mSBDL17A/OsudYet5YKHHNbfHnEenNMqKs33rJjogIwuxQMNJS2Jo5rNW0Te4OxnfjPxZngZ0sb8adhDnrQGzyLMQhoTH9oKCv49muekFY3xiYGUZnYyBBzd0o6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593369; c=relaxed/simple;
	bh=o/pSGdI0pOMi+pZ4lbyDrVS3GvZlbAA31qdQAp3h6ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rc9/k6tsp+A1RSv48uvl8XVlXIZCgLq6WjJrZn//UcFQoEPQd4pRYqBjZ+08agy0huc2TXr337wGe/JuccLXMaKx55e+/OxsD4/L3OTLEdTSF26iFyOIwkJ1fP/TkmzvbHjacxJODq1cCMufbcC1GafOlgkl3Q6qcp9f2XkTARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YohoTmY0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YohoTmY0"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea952ce70so4082055e87.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593363; x=1721198163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NkEPGOVrfdAoNS1g8HucglgLGiQVtl0GE9xmrY+mMY=;
        b=YohoTmY05bMDk8K3QCOA8L6OpVJLJEkHZ52Zd0tmq71iJpYecXwM4h4wxstmaAvLhP
         m6DCVKpRX9Od6mTKVJoxKhWzrCsoNmTZE8hIKchfn3otOr3lHzzCKtbmcR8jMz1J/RWf
         qGP4dCu1ZMAblnLfNvJa6G1SWOkC5YaLIrYjeXGikXRRwKdameB1ptpX5Eeu6d362Y6c
         Kfp12g93EJTM80Tjlb5C7h7ebGRwwIG7fLKsRsj4dhB3iaigxWQz73hFFP0EDlTf0QYt
         /B6UMlx1IYNuktX/4BQCNhmyDBDVdIedgxfpmq0TvyhvYbibrwUzLUdU/CnaiNoOjyD/
         Ie0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593363; x=1721198163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NkEPGOVrfdAoNS1g8HucglgLGiQVtl0GE9xmrY+mMY=;
        b=tqpGrD7SWk58qY5xbQAjSCXkeBvj+5GCGolqNI6qV/DEWEsG3HEVmul3fgiOXCWxUd
         eI2mTAOCY1FXkG/a0QskNqfFuwgzg2MxmV5x+j+ZBU1f23euyxL4BbMOF8UFthyDb6IA
         gk8aXzcAds2WEXclyx7QNftcBQUIUrNm+jbLlLAy9sEcIV7Pi/xOL/67RR0VmwJU8X4b
         bmsUS/3ILQWMh3ylJNOd2cErfdBn5jqUPR4Jc+VRtEpE9theQQNFjX/IoDVK1x18iSlg
         RLaDaa78w5BttpQHK+yq+onoiicgcV+IQCR30cU1La8gx1T8HMYfd1Y+xEJIx4uoYh3z
         0/eQ==
X-Gm-Message-State: AOJu0YzrrbGviin4wvaSzUk/6oHY3f21iV/2iPD3J494ZNiK4iRIUoLP
	KeogSCkeDJv5whLOcjxqpLHkSSVSULFftKgGOPLGhL11z6Xsmi3SrrJXLBGBlukaumviU9D6HyU
	3
X-Google-Smtp-Source: AGHT+IGWsDsv0uDnXkspg54mwUno9N/Z35bLTtuwComS2ynELhhTOhiWesAQqMtLEtJiYVwD2tZywg==
X-Received: by 2002:ac2:494a:0:b0:52c:e3ae:2737 with SMTP id 2adb3069b0e04-52eb99d4fa9mr2183399e87.68.1720593363100;
        Tue, 09 Jul 2024 23:36:03 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f74159csm66959985e9.42.2024.07.09.23.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:02 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 00/13] virtio_pci_modern: allow parallel admin queue commands execution
Date: Wed, 10 Jul 2024 08:35:48 +0200
Message-ID: <20240710063601.2000149-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently the admin queue command execution is serialized by a lock.
This patchsets lifts this limitation allowing to execute admin queue
commands in parallel. To do that, admin queue processing needs to be
converted from polling to interrupt based completion. Note that admin
queue is treated as a slow path virtqueue. That means that under
circumstance there are not enough vectors available, the admin queue
will share config vector.

Patches #1-#11 are preparations, making things a bit smoother as well.
  Worth mentioning is Patch #5, which introduces another vector
  allocation fallback for slow path virtqueues.
Patch #12 implements interrupt based completion for admin queue.
Patch #13 finally removes the admin queue serialization lock.

Please note that this patchset prepares ground for control queue vector
implementation as well, treating it as a slow path virtqueue as well.

---
v1->v2:
- rebased
- added slow path vector allocation fallback
- fixed couple of bugs and issues
- see individual patches for detailed changelog

Jiri Pirko (13):
  virtio_pci: push out single vq find code to vp_find_one_vq_msix()
  virtio_pci: simplify vp_request_msix_vectors() call a bit
  virtio_pci: pass vector policy enum to vp_find_vqs_msix()
  virtio_pci: pass vector policy enum to vp_find_one_vq_msix()
  virtio_pci: introduce vector allocation fallback for slow path
    virtqueues
  virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
  virtio: push out code to vp_avq_index()
  virtio_pci: pass vq info as an argument to vp_setup_vq()
  virtio: create admin queues alongside other virtqueues
  virtio_pci_modern: create admin queue of queried size
  virtio_pci_modern: pass cmd as an identification token
  virtio_pci_modern: use completion instead of busy loop to wait on
    admin cmd result
  virtio_pci_modern: remove admin queue serialization lock

 drivers/virtio/virtio.c            |  28 +----
 drivers/virtio/virtio_pci_common.c | 190 +++++++++++++++++++++++------
 drivers/virtio/virtio_pci_common.h |  16 ++-
 drivers/virtio/virtio_pci_modern.c | 159 +++++++++++-------------
 include/linux/virtio.h             |   3 +
 include/linux/virtio_config.h      |   2 -
 6 files changed, 239 insertions(+), 159 deletions(-)

-- 
2.45.2

