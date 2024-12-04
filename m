Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5720ADD0
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326699; cv=none; b=b3iazym/lzEmq7DgwMcWGcjSuLzTVa+Gsdmv+T8fWSYyDAxNBrG/48vPQGrwg80Y2gdkegopxP8Zp/nH5D3g1IL9cOA448dkVoazDqUJ3peeQzBJg/hrd1HYYdNkhumVdDOuY6E+rO/dzoWyabmrOdOk+s1RPp8s1gFdWF6kN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326699; c=relaxed/simple;
	bh=4ZmqK1eTqsM8s4gS1iefw6hnA9prRMWERxTyaIBFNOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tZcdoaAAUkX+ihOZe9mISzL9V6XmmOXh9g6encgK23iLQ9o+cJqsCxYJUKrqQIhx/irD7EabUav5/vMVgMqMRCAt2UgOgZ5XHLJEmabISdnVzH4xrGOm/SilG3Bm14hxaMcGa0iIfxaMcK4utC0q9tlOKGsRo+XzzIBGT+am+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtualopensystems.com; spf=none smtp.mailfrom=virtualopensystems.com; dkim=pass (2048-bit key) header.d=virtualopensystems-com.20230601.gappssmtp.com header.i=@virtualopensystems-com.20230601.gappssmtp.com header.b=BZTt/+W1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virtualopensystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=virtualopensystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtualopensystems-com.20230601.gappssmtp.com header.i=@virtualopensystems-com.20230601.gappssmtp.com header.b="BZTt/+W1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e2880606so4817282f8f.3
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 07:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=virtualopensystems-com.20230601.gappssmtp.com; s=20230601; t=1733326694; x=1733931494; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXJVi3ZUFWXc/9qU0ThXbnY6f+RTukvr4DroDcrK/eM=;
        b=BZTt/+W1ytfnsX2cJhwgjWY3pQWry+pP9DPBJwM/bEQAmFNZKzHa65yMqon0Uko3e0
         DF7WTdKNYb0nwnbQBuuLDD4nmnt4Z8Mwa2y+glkAAY/ugVIl7nMYr4I9Pyg1wtyiRDHi
         gwHbPy4LBsuFzMk5rwurHIk7Y8lg465IeemaGopRyP/pj6WypepVuwe3RuwPyCX8aiHp
         lAk+dZmUX+FpVvifRn7X+V+y/ABrkQkf8fF4NekDlZRTauWUm6ePNuHMIwqvkrIaWWed
         FLQ7t/C85lW5iheoRvyCgaBVondmJ7HT8wAtU3ulSAxh82UEjhrBiay16LjreTEteck5
         WRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326694; x=1733931494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXJVi3ZUFWXc/9qU0ThXbnY6f+RTukvr4DroDcrK/eM=;
        b=h47qa+6FikW6PYNXgbBilMhBRGnyz8UkLQ6ysBNGWnj39WYPnMDU1xmBHNVa6vBEiG
         J3jUjzq716btfN5XT9TLWbnen8j4oXy2hj2PJhzpiR29OebO2PO/REvG2dTg/4txp6cP
         f9DH0UmzI7tnn9jo1G0PNnbBXict7sPvV/1/myFf/hvWuUoDE9UNcjUtkibIp/5tm2D3
         D2tW87iAUeQzh8VRqvECqX3L1vCCsf2wmrDReCf9avb4pVBJdfKMps7owqGcuWDjcKwM
         568Mw3NM9IrapG41WoJQ2SSpLFk83NMa3HDAWIS0pK1zm2XScIfOEEqFDql5MYBo0HzN
         pg+A==
X-Forwarded-Encrypted: i=1; AJvYcCWys2g6uUE1n/oVnvMjeulNjWaP5dQW7pfxFMaO+lN7brb4SxPD0efdoueaw32tm+OpvKFY7AGdnW2u1FyEMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqOeXIRaN9l9kZxL4xr+xH+aQaHD/gNZNNxiugwho6T/07tWvW
	8Rlah9dgiruQM5CN0WBxxlruIG+vG7pD+tOql0WOFm9svDfCKgVO7BlQDdIMF+c=
X-Gm-Gg: ASbGncsVs2vFhAjZQXov8mJKKWLCDSpgzNIaMawZ1V2ZWfrjYmVnClayKQA8YzrT6Le
	qUiWC+/W+CeZh6L1IqWwDhaBeJAeqvGk/I9KbWdRI4tTmyesH5JD0SfmPDimgV1ohPnwMRIjKqT
	YtVlm/0sOOloJ2U9VQFILJRA52yzJN6E0zNfWE/Vc9KOVYx/0VNRHUp9kRB1lBy90dWJ0qoq7wg
	vcV5tchho78Zi2fyhl2F8Yf9Rdw0ZqD4Fed4Un4ly/9DhuDcPB78xaZsg6tmS2RwvYQ0WKXbLvG
	PDf/AzBs15tWnjKco2NCnzLLUd2ylGldM3b3V5rF2VxQILsojok=
X-Google-Smtp-Source: AGHT+IFkCgIIIQ8WUK20PtBtOKF577l2Z27m2asCj6g+yRoI3w5iyIMLcHY//1+CLg+LsQ159dsL5A==
X-Received: by 2002:a05:6000:78d:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-385fd4350fdmr7905571f8f.36.1733326694421;
        Wed, 04 Dec 2024 07:38:14 -0800 (PST)
Received: from ritos-ThinkPad.router.wind (adsl-146.109.242.187.tellas.gr. [109.242.187.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e4a54b71sm13088839f8f.79.2024.12.04.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:38:13 -0800 (PST)
From: t.ampelikiotis@virtualopensystems.com
To: virtio-dev@lists.oasis-open.org
Cc: anna@virtualopensystems.com,
	a.rigo@virtualopensystems.com,
	m.paolino@virtualopensystems.com,
	s.raho@virtualopensystems.com,
	chou.kensou@jp.panasonic.com,
	wminer@linuxfoundation.org,
	jsmoeller@linuxfoundation.org,
	virtualization@lists.linux.dev,
	stefanha@redhat.com,
	xuanzhuo@linux.alibaba.com,
	sgarzare@redhat.com,
	jasowang@redhat.com
Subject: [virtio-dev] [RFC PATCH 0/1] Virtio-loopback: a virtio based HAL for non-virtualized environments
Date: Wed,  4 Dec 2024 17:38:10 +0200
Message-Id: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>

We would like to share with you an RFC for the Virtio-loopback
technology which we have been working on at Virtual Open Systems in
the context of the Automotive Grade Linux community (Software defined
Vehicles expert group)

We previously presented this activity (see [1]) and now we come back
to you with latest development and updates.

We believe that the technology is more mature today and we would like
to assess the community interest in the technology itself and in
merging the code.

Below we provide a brief description of the technology, recent
updates and a short comparison with vDUSE that might be seen as a
similar technology.

1. Overview:
-------

Virtio-loopback is a hardware abstraction layer (HAL) designed for
non-virtualized environments based on virtio. The main objective is
to enable applications communication with vhost-user devices in a
non-virtualized environment.

More in details, Virtio-loopback architecture consists of a new
transport (Virtio-loopback), a user-space application (Adapter) and
the vhost-user devices.

The data path has been implemented using the "zero-copy" principle,
where vhost-user devices access virtqueues directly in the kernel
space. The technology does not require any changes to virtio protocol
and vhost-user library.

The architecture supports vhost-user-rng, input, blk, gpio, can,
sound and console devices. Early support has been provided also for
vhost-user-vsock, i2c and scsi.

2. Updates:
-------

Since the last time virtio-loopback was introduced [1], we implemented
the following updates:
- Multi-device support:
  - The driver can handle multiple instances of virtio-devices and
    connects them with multiple different instances of the vhost-user
    devices though one or many instances of the adapter application.

- Update the memory mapping mechanism (zero copy mechanism between
  virtio and vhost-user devices):
  - The technology implements a page-fault mechanism which enables
    the vhost-user devices to access the vrings buffer located in the
    kernel.

- Update the notification mechanism:
  - Notification can be delivered from the virtio-driver directly to
    the vhost-user-device (by-passing the adapter application)

- Add support for more devices:
  - The technology added support for vhost-user GPIO, CAN and
    Sound device.
  - The architecture has become more device-agnostic and the process
    of supporting new devices has become a trivial task for most
    devices.

3. Virtio-loopback vs vDUSE (+ benchmarks):
-------

Virtio-loopback and vDUSE technologies serve the same purpose by
trying to define a virtio-based HAL between application and
user-spaces drivers.

The main differences between the two technologies are:
- Memory mapping mechanism:
  - Virtio-loopback implements a zero-copy data sharing mechanism
  - vDUSE implements a bouncing buffer mechanism for sharing the data
    with the user-space.
- Dependencies to other technologies:
  - Virtio-loopback is a simple virtio-transport driver while vDUSE
    is relying on vDPA as an upper layer
- Devices supported:
  - Virtio-loopback: virtio-blk, virtio-rng, virtio-input, virtio-can,
    virtio-gpio, virtio-sound
  - vDUSE: virtio-blk and virtio-net

Performance wise the two technologies seems to behave very similarly
when we measured the throughout for the virtio-block case using the
fio tool [4].

4. More information:
-------

More information and instruction about how to test the design can be
found in repo [5].

5. References:
------

[1] -> https://lore.kernel.org/virtio-dev/CANN35wLsm_RTTKmxFz5jcBujoxfjPwsu37FAw9+W58hjt_nVPQ@mail.gmail.com/
[2] -> https://gerrit.automotivelinux.org/gerrit/admin/repos/src/virtio/virtio-loopback-driver
[3] -> https://gerrit.automotivelinux.org/gerrit/admin/repos/src/virtio/virtio-loopback-adapter
[4] -> http://www.virtualopensystems.com/en/research/scientific-contributions/virtio-loopback-perf-eval-icai2024/
[5] -> https://gerrit.automotivelinux.org/gerrit/gitweb?p=src/virtio/virtio-loopback-adapter.git;a=blob;f=Documentation/testing_virtio_loopback_design.md

Thank you for taking the time to review this RFC,
I would appreciate your feedback and suggestions for improvements.

Timos Ampelikiotis (1):
  VirtIO: Add platform bus driver for loopback virtio device

 MAINTAINERS                                |  10 +
 drivers/virtio/Kconfig                     |  20 +
 drivers/virtio/Makefile                    |   2 +
 drivers/virtio/virtio_loopback.c           | 780 +++++++++++++++++
 drivers/virtio/virtio_loopback_transport.c | 924 +++++++++++++++++++++
 include/uapi/linux/virtio_loopback.h       | 259 ++++++
 6 files changed, 1995 insertions(+)
 create mode 100644 drivers/virtio/virtio_loopback.c
 create mode 100644 drivers/virtio/virtio_loopback_transport.c
 create mode 100644 include/uapi/linux/virtio_loopback.h

--
2.34.1

