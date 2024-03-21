Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4617D2
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984631; cv=none; b=N+OM2FfqYpbVv3rP6Jv0rwTxpqznIokiX8gohJ8Vr5krtAaEJ++MSsP1neCemjdaF1vS2sKgpPv6LlBZ6LySb/1vQLslXuiBupStie0BK0fIfTyJTZog52DFQRyL9kDvXGR/sPIyTSHvpsJj/4YYJAvJsFEeC8nHSYkGVrYJqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984631; c=relaxed/simple;
	bh=kl/gBd+Lc3gNj5XO0OTXtqTZ86F3iToD6CkJPAtrC0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0/PsZ15hieYb4aqN7l0rzZK7O1YRClv6ygvBCdvGYt9EIKj7gIbj7cZ8ExIKdio0xNwiwKTzLyZ7hvleg0wwutKIe3on3xBtz1HRg7rR15cPvVFH5LEkY2GpAeePYzPOsq6fKRb8Ny6ijH7BGiLBcOYXLoWAjal8Dg052mkMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jQI5bApF; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jQI5bApF"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 218E281E92
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b3SBuOuHXmPt
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Mar 2024 01:30:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2397D81E50
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2397D81E50
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jQI5bApF
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2397D81E50
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Mar 2024 01:30:27 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-78a01a3012aso32825385a.2
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Mar 2024 18:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710984627; x=1711589427; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRSqzJosPoKI6/qjkm8bzkMOGa+EX2021eXQBZPsvWc=;
        b=jQI5bApFnZfVLkY2ancXst4a4cKp0X/GY4/y1w9PAlJXddekuNnwx7WCoRD1imQRpQ
         VGsz7qy1MYza6LNsHYrG3gQarnp12mkIysRzsI+clQ5HQgGaml/KfPTacl9EAZSmWbGm
         0BvugbnXcylGRl8/lNP6QnRCvWphnW5s8qXt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710984627; x=1711589427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRSqzJosPoKI6/qjkm8bzkMOGa+EX2021eXQBZPsvWc=;
        b=VimpOHDD5cv/KKXoX/SYQR5GGX0uxfrWizrzkcI8fGuWwArwH/nIJ/VpILxO1YZVq3
         46Q7PKTjfEULnYv3jWR0IvotMKH9nmkdlpU/BA6ST8OCgDmvMpWVQEJuf/6Araav6uqH
         6VjG4lGmZK5CVoCLCNJrmjr7ZROkwXX9SU1TN4tpWOY9XMpPn18lPtHrq9BMOmtlEH2G
         3v9gFuxcQKIsVw0kYfc5ZU0y+iRbNdfVxglT5xG2d7udLJo2sinDmB8oB5RQehKaoKIj
         y8bFe69N2pNc1ZQJ+jxqhfdsqr8YgHVdWJtiLsLJptnM1355mUsZOBt89FFO/nCtVdTD
         bXxA==
X-Gm-Message-State: AOJu0YykVfEOyc61igF0+UjChqHPP6hOvIAGV0gZ6Tg/gx515n4baTMs
	FadwXVJggzaHaM0qD0L6AV69214PKT6hQhPU2IS+/aKeojMZhIA6VBLVOxxnjLsKrSBch4FDTVw
	=
X-Google-Smtp-Source: AGHT+IELQCIYxX1ks+CpfT7OtuOzAf4Z+DIiVFEwIwS6fFzcle3k2lvos9qVE71qOSIUdmeUd1hghQ==
X-Received: by 2002:a05:6a20:6a08:b0:1a3:49a7:f56f with SMTP id p8-20020a056a206a0800b001a349a7f56fmr17972155pzk.2.1710984296424;
        Wed, 20 Mar 2024 18:24:56 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d837:1d3e:d3cd:7674])
        by smtp.gmail.com with UTF8SMTPSA id k10-20020a170902c40a00b001defa97c6basm11137159plk.235.2024.03.20.18.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 18:24:55 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 0/2] Improvements to virtio_balloon pm
Date: Thu, 21 Mar 2024 10:24:43 +0900
Message-ID: <20240321012445.1593685-1-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

The virtio_balloon driver uses wakeup sources to allow the guest to
enter system power management sleep states (e.g. s2idle) without running
the risk of becoming unresponsive to cooperative memory management
requests from the host. This series fixes an issue where wakeup sources
for inflate/deflate were improperly shared between drivers. It also
closes a race where stats requests that come in immediately before a
sleep state transition could fail to be handled in a timely manner.

v1: https://lore.kernel.org/lkml/20240318091034.535573-1-stevensd@google.com/

v1 -> v2:
 - Add comment about virtio-balloon's wakeup source
 - Rename virtio-balloon wakeup event macros

David Stevens (2):
  virtio_balloon: Give the balloon its own wakeup source
  virtio_balloon: Treat stats requests as wakeup events

 drivers/virtio/virtio_balloon.c | 84 +++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 29 deletions(-)


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.44.0.291.gc1ea87d7ee-goog

