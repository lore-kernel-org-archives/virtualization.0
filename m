Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5645C3AB28E
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442303; cv=none; b=keSl2Byj1vnwMMdJdmie+mvRx32S+A7H3+cyedsh25B3zksZl13mfZ2Vz2LErLISMwOq2Ol0rvzWnvdYyvC/8bON8pVfoq0M/lmYUlBBJ8ZhZHByOoJALCtnw07wzXc4J5ATZsW1uDoGQldlVJea1fXPXj5gtuk/49l4V0ySPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442303; c=relaxed/simple;
	bh=kG0V+A0XD3vYLFfqsb3MVX9KgiOaGk9ZgE+CUb0lYYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A36PtWED24NWilf/oXrRF2KZ0NOK6z7l+rrnUpRJ+s5fKksbKu8L00CR3CVF3yYO4y9G53kJEte3AnQzasEBOocd/6cRtox7dYWoZ0rLZVKGwi2t0c786zCL9uScG/VRnQcuItG3ttnHaIWTl95szzoRYh0iTjYNbaVKtUEppUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM9HG2qE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM9HG2qE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e04df8c46so330722b3a.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442293; x=1786047093; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHhFvDLdT6/nmSmrERMl9Q942exbwnTVnKlPTxRQFfM=;
        b=SM9HG2qE4vRjfzu1na7wFcmAyt99bHkCpWRRBOAQToOQFGpSx+q3/CZKgjOL0lSD6t
         JuaC3fZ6AsbHcxbPmJwG4JDcoDNwSW+rYmHKOGM/7EIqLm7a3EC3ngdWVmP+tp1u4TEO
         jTiSm2bBPzs32SRYsX5cAlRVZ5+aLUU4OjxOhaAaDgQ8jOUFDrmAZJIu7sFhak4l0LhT
         /VanrWPgx0ypB0O4P737q8uW+xa+OqNJeD5BU3hnvBEmEqrtdoYmZpsw4GEs5HGHQVa3
         N9jFdT/dCPxnDuDs1NQNF3goiZbOABnJ/mMeRZPwYR5kNdv/TU5XKo3UL2bQyhUieI+0
         elmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442293; x=1786047093;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHhFvDLdT6/nmSmrERMl9Q942exbwnTVnKlPTxRQFfM=;
        b=LGO04kMpyxXxDfZrFr538GWRcslmRlQkKhw8k1IbAZGz8o7mYXOQVNC9o7qFFpMs9B
         +izszXDe/RSUz+W5tHfjKCitC+9lXShZr5i8FkmgLepNmF7g0RAoZdvGIC+wynZ/+O9x
         q+fOTdu2bLDFCoVXDd4VHa9J8hF+IEut8JOk6Asijv6RdIOB3AJwvcz80d1p2R/D7XDT
         dKqH5EoYmsdTtaPTlA5ZyEsBBLX0W9EVwrBdUX983eTsfz5rgg0ufFQLhoW9oDrPcBo8
         jWNCmLGhC5TkPg3D8BwPN7W/683Ro164HJ5dCX+FSd322zkrsvd+K1z8+HWv2zsPNnVO
         PAfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTzV2gQg8K1SrGNXUV+L8HjR4XzGcKrR9AvYgrXd8njJSLScWjh9w2z0HlJQ0trTIfGOJ6wK3wrYJmG2GR6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCf5a1S6bL3Ac+GkZ9nFUWOVDKWXym5BvntV9fVO7dItsJqKlO
	nqsHSV0yBXX978Rwx9VzzaVEgl1SZHQOFrkv6Do0EF/uilgC5t3hsVKV
X-Gm-Gg: AR+sD13nm2TKpwmBjn4YIZwKDVZV7Bb7rT0e0f5ggyUbmM50/bpJbk689AEspg1G+Di
	RgqjwHxWGZPXyi0sLIUB83zLIeQXF7OGSC5kX2q3Npkn7tNnA8j0iA+Dpxq+iU5xp9JpV21qpOU
	I7TfkcMy2HMyiBbtYNYjhUJyK0xPpY3WRN0iEjYMLVxie2aAU1CwqixLdNCviYhAWRZH9G+E5cn
	qYO56q1rHCnHtSAiaDSFOm0UI10EdaYczIgivhDEMtRsHewJ9O//1g1f1k/E6TG5mkNOjQuJ+r+
	hBocy2d9pfRumuxsSeIZKccGl3WPavaibOlrfLm4/KrEoeNC/Ccw/zvidCJ72v1oRzkzhJaOB/a
	4t48Vi9VyUF+yA9eEVTKndEJH1BItq650YQRr3J1tsxX+j5vPPzMGCfSl4mPRpYErybqzBjEA/V
	Q0tbomqWhWLD/1Le+ajaOAt8NYrZTXmCpvX0EKMhhxqM0dmW+B/OPSQ58OcrLQd77BQF3wZqlGt
	k/uXLaaWvr5aiYl7FSicPk9Yn+vuc0vPLxmg08Nqyk=
X-Received: by 2002:a05:6a00:1150:b0:845:d284:9e0a with SMTP id d2e1a72fcca58-84ebc425164mr3944086b3a.49.1785442293425;
        Thu, 30 Jul 2026 13:11:33 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:32 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH 0/6] Remove support for Windows Server 2012/2012R2 & Win8/Win8.1 versions of Hyper-V
Date: Thu, 30 Jul 2026 13:11:17 -0700
Message-Id: <20260730201123.1767-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux code for running as a Hyper-V guest includes special cases for
running on Hyper-V in WS2012/2012R2 and Windows 8/8.1. These versions
were initially released 14 years ago, and official support ended in 2023
(unless a customer has contracted for extended security updates). Given
the release of subsequent versions with improved functionality, there's
no need to continue to support the latest Linux kernels on these versions
of Hyper-V. If someone is running Linux on one of these older Hyper-V
versions and doesn't want to upgrade, they can continue to do so as
presumably they don't want upgrade the Linux version either.

Simplify Linux code by removing special cases for running on these
old versions of Hyper-V. This includes removing the negotiation of the
VMBus protocol versions for WS2012/Win8, and the special case code based
on those VMBus protocol versions. Changes are in the core VMBus code and
several drivers for synthetic VMBus devices.

Some VMBus drivers have device-specific protocols with the Hyper-V host.
Further simplify the code by removing the use of protocol versions that
are specific to WS2012/Win8 and earlier.

Finally, the WS2012/Win8 versions of Hyper-V were the last to use
messages to deliver synthetic timer interrupts. Starting in WS2016/Win10,
stimer interrupts are delivered to their own assigned interrupt vector
(called "Direct Mode"). So remove the code for handling timer interrupts
delivered as messages. This removal has a broader benefit in removing
a key blocker to disentangling VMBus code (which handles the messages)
and stimer code, as they should be independent of each other. The
final disentangling will come as a follow-on patch set.

Testing:
* VM on local Hyper-V on up-to-date Windows 11
* Added temp debug code to suppress Direct Mode enumeration. Fallback
  to LAPIC timer worked as expected (x86/x64 only)
* Azure VM DC16eds v6: TDX CoCo VM with HvLite paravisor
* Azure VM DC16ads v6: SEV-SNP VM with an older paravisor
* Azure VM D16alds_v7: normal AMD x86 VM with HvLite paravisor
* Azure VM D16plds v6: normal ARM64 VM with MSFT Cobalt processor
* Not tested running in VTL2

There's no specific urgency to removing the special case code for
WS2012/Win8, so if the broader Linux kernel community surfaces
a reason why this clean-up should not be done now, we can wait.
But I think we want to eventually stop carrying around this extra
baggage, and based on discussions with the Hyper-V team within
Microsoft, we're past the point that it has any value.

Michael Kelley (6):
  Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version of
    Hyper-V
  hv_sock: Remove check for old Hyper-V hosts
  hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
  drm_hyperv: Remove support for synth video protocol of old Hyper-V
    hosts
  scsi: storvsc: Remove support for storvsc protocol of old Hyper-V
    hosts
  clocksource: hyper-v: Remove support for stimer interrupts in message
    mode

 arch/x86/hyperv/hv_init.c                 |  17 +--
 arch/x86/kernel/cpu/mshyperv.c            |   4 +-
 drivers/clocksource/hyperv_timer.c        | 150 +++-------------------
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c |  33 ++---
 drivers/hv/channel_mgmt.c                 |   4 -
 drivers/hv/connection.c                   |   8 +-
 drivers/hv/hv.c                           |   4 -
 drivers/hv/hv_balloon.c                   |  36 +++---
 drivers/hv/hv_snapshot.c                  |   5 -
 drivers/hv/vmbus_drv.c                    |  10 +-
 drivers/net/hyperv/netvsc.c               |  20 +--
 drivers/scsi/storvsc_drv.c                |  53 ++------
 include/clocksource/hyperv_timer.h        |   6 -
 include/linux/hyperv.h                    |   5 +-
 net/vmw_vsock/hyperv_transport.c          |   3 -
 15 files changed, 76 insertions(+), 282 deletions(-)

-- 
2.25.1

