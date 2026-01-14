Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555293803C9
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380760; cv=none; b=FE73FFrCeoCPSFM+x86lkRljNx3hk7FH3/MSFaDS9ZjxvqXFe6PTswFfPvwtNWHfRZCf0aJTg2nSP7SQ4EX7iJlJriJ6iXNurlsqqNmAEFmtpcmM5fUxNTHXSirQdnU53J4j1TkOO3IIR+Qn9MrvGfeBo8XZOkeeq943zvn5Jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380760; c=relaxed/simple;
	bh=6Gf3O1Z46A6A3V618QjzgUC3TwEE6jvcWp4vN0GZKB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jb7LjLtHpuQnW1DUqMxJiledo4c7ypsBn4/itlxWacI839B7T4M4BkP81qu0VpqmeHxVS2XCGujnyU20A+T/06Hzm0E4sAmwQnoxdLr/PJfKYSkyTwhJ7c2HSEIud8IBldHTuwiJRP6SzIqO4Q1j9FlOdqDeuyP0FrUsFJu5vHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nvsYvXkT; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nvsYvXkT"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed7024c8c5so72310271cf.3
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 00:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380754; x=1768985554; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uI7G8mzCwfWt6hpevWSKMuVc2LUYnlWS3FX4pvAwGI=;
        b=nvsYvXkT8STPzuEmOh1XF3MGHxbEVqvnc1/z3bpGiQsg7wtrlQ9XW20KvJZih3dBKH
         AD38nXmc2bve0Xtk0HB0tRonIQdr3J9dRQp0ht/Wq2a3euuxbwGQZCKChzzbYcH6b9Pi
         ahWc7vl6emWc/V/no1I1OumQJl9vpI+u+N/vMUfLi66kAX5bUc2nfIctlIzw4s5Nr7LE
         c2/aRMoCoo5YXDv94pKvc4jU0hlR+v5J7L2kbyNBcM6GC+d6kus3JAMdEYe+dFGhqEtz
         YauO0FEs0atBwTEW0MpfpaVce07n7+FwNSn1Wxs+M5gvaYyavQRyZ6RzNGiJb1qyVjw8
         U3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380754; x=1768985554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uI7G8mzCwfWt6hpevWSKMuVc2LUYnlWS3FX4pvAwGI=;
        b=NevJysVEtUJcA++qCXuhd9ZR05qrDuNpX8FUbmSZReYYMBimN9BIlwLtDQ/CKk3j7k
         iyHGUX1BjjD4GvbM4zU3HXv3cf3b8ICjKfqivkHr6Kj1xTGAU++gr6LBMtahBc7aT0BS
         KHplaa+XWHl2bMP55h3NgHUJHNXv9/0S2iRHukwi/tI7eGimc5UK6g/G53MemSWIS6+n
         dBl2GiW98wneyVSd9+JezjTiKj8Ll+n0dCBEFrGDLu6C/rPLwGsvBQX9fhFrAP2hEzoA
         sKsQhN/nAz9Bkahc4jNer+AZzVC7+HbfD0WRlJLIvul/jQpGbDEryn0F9BxwEPuZtm+5
         HHSg==
X-Forwarded-Encrypted: i=1; AJvYcCUrTv9ZbAaNaBTlTcE8wrmi6Dq1jwTpq2ghYAnLIabXBPFhiN0UsgHywMQ30vbLtd8g4WwzCn6/2PHOhSKd9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlBjPQ5cd2cQeMa2Q4In+q8GrCxqM2pW9yTEQax2BeeKz1o5nn
	Nr4QBG3jkVpAMqn17X2IRHRCBrnCqGBezAIn84nz4sCSjjqHkob13DitM5lvtRQIFN0=
X-Gm-Gg: AY/fxX6PVNYUrmcdM71FYcoWb3Qdb0T2VtBEA8CACHrdvcYD2P+sx1ZB9Z16Tp5RgRg
	liFAVnczI6jWqdxvscXGu8VPs8oZO7C4OpnPwQSKcm5vBClI4vXw5M8zPqdhskPb59FDxuwzxej
	RFdq3Tk8ZVLvq3dTO1Niioua6hbL9ZKqm1jLojjs1rrsw8kgyKEhPK0IZ5+rY7rNxuDbENTxy6K
	LAvHunyc1ywY7d2D5hCEFi96WSmGajq1/T/YMAXUeEbsjiq6Yow+pqR4fwKNhQOdM0F3BREdoAk
	DMl0OueF6MJSzS5i8AkwI0jHvNuas18jBnMLAIRW4aUNerirrvzSQS2vW1WCgofj0FGWFGjhgtX
	UDPmvbMq/RYfdLM6/pnuGc83cK1RaxS2EdFw3Gz8wuovG5zk+6D1isVLaKs3vBBSfXqkcrriIww
	FXa8l5IFFldNfgzudULkcU39Mueukh8ReepDA8wiZQirKrn1jdG+FpuEogjoD5zZSeYGfv0v5h+
	uM=
X-Received: by 2002:a05:622a:58c5:b0:4f1:ab46:8e36 with SMTP id d75a77b69052e-5014a905f74mr11547531cf.9.1768380754428;
        Wed, 14 Jan 2026 00:52:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:33 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: Subject: [PATCH 0/8] dax/kmem: add runtime hotplug state control    
Date: Wed, 14 Jan 2026 03:51:52 -0500
Message-ID: <20260114085201.3222597-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the ability for the dax_kmem driver to control the
online/offline state of its entire memory region at runtime through a
single sysfs interface. This eliminates the need to manually iterate
over individual memory blocks when changing memory state.             
                                                                                                                                                  
Problem                                                                  
=======                                                                  
                                                                         
The dax_kmem driver currently provides no runtime control over memory
state after probe. Memory is automatically onlined using the system
default policy, and any subsequent state changes require userspace to:

  1. Enumerate all memory blocks backing the dax region                                                                                           
  2. Individually offline/online each block via
     /sys/devices/system/memory/memoryXXX/state
  3. Handle races with auto-online policies that may re-online blocks
  4. Coordinate offline+remove operations across multiple blocks

This is error-prone and creates race conditions between userspace
operations and kernel memory policies. There is no atomic way to                                                                                  
offline and remove an entire dax region, and no mechanism to prevent
external interference with driver-managed memory.

Solution
========

This series introduces a 'hotplug' sysfs attribute for dax devices that
provides atomic control over the entire memory region:

  /sys/bus/dax/devices/<device>/hotplug

The interface accepts the following states:
  - "offline": memory is added but not online
  - "online": memory is online as normal system RAM
  - "online_movable": memory is online in ZONE_MOVABLE
  - "unplug": memory is offlined and removed

The driver handles all memory blocks atomically and prevents external
state changes through a memory notifier that blocks operations not
initiated by the driver itself.

Series Organization
===================

Patches 1-4 refactor the mm/memory_hotplug infrastructure:

  - Patch 1: Pass online_type to online_memory_block() via arg
  - Patch 2: Extract __add_memory_resource() and __offline_memory()
  - Patch 3: Add APIs for explicit online type control
  - Patch 4: Return online type from add_memory_driver_managed()

Patches 5-8 implement the dax_kmem functionality:

  - Patch 5: Extract hotplug/hotremove helper functions
  - Patch 6: Add online/offline helper functions
  - Patch 7: Add sysfs interface for runtime hotplug state control
  - Patch 8: Add memory notifier to block external state changes

Backwards Compatibility
=======================
The driver uses MMOP_SYSTEM_DEFAULT at probe time to preserve existing
behavior. Systems with auto-online policies will continue to work as
before. The new sysfs interface is additive and does not change the
default probe behavior.


Gregory Price (8):
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: extract __add_memory_resource() and
    __offline_memory()
  mm/memory_hotplug: add APIs for explicit online type control
  mm/memory_hotplug: return online type from add_memory_driver_managed()
  dax/kmem: extract hotplug/hotremove helper functions
  dax/kmem: add online/offline helper functions
  dax/kmem: add sysfs interface for runtime hotplug state control
  dax/kmem: add memory notifier to block external state changes

 drivers/dax/kmem.c             | 645 ++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_mem.c    |   8 +-
 include/linux/memory_hotplug.h |   6 +-
 mm/memory_hotplug.c            | 139 +++++--
 4 files changed, 678 insertions(+), 120 deletions(-)

-- 
2.52.0

