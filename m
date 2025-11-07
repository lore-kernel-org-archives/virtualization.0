Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A932863E
	for <virtualization@lists.linux.dev>; Fri,  7 Nov 2025 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530569; cv=none; b=cZulvXymViAhzjh0GGrhVp0pqCq5tMmDXEwZ8hEQdBJbC6scCuNFSt+x1UfAhSKjuU7CDZgNkVhY3nn+hToaX4yKOdtJ+5CG9nG4F6M5G45By/SvfKFX+Yn+9cXBWoDTv/7w0Cm1ZeAmdhSXalBDkOzsyQv825rfEpPId6xLTUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530569; c=relaxed/simple;
	bh=27VE+i4w0x2v9vXfjkwHZYZx7SWxOyXyFMIchgV6VXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cuc+Qbk30yfIR7hJrNQVV+S5cxkwtUsiFC53qwWxaLUBSgsLk8EQMNxGdsHaCEhJMKRDs368/CrbJwFRG/+BXLHq0ctId4UhJaYz8dcs12AwxTrh0vH1BOr0mgQpamjKo1kmIKCPhmv+PUXDyyn/cbL85UMJ7AKazBSWfGoK4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XqjnbDs5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XqjnbDs5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775638d819so5262425e9.1
        for <virtualization@lists.linux.dev>; Fri, 07 Nov 2025 07:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762530565; x=1763135365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CieNdBP+iDUkzWsYIh1zY2fr6PrC6rMrfQxyOHiJYwM=;
        b=XqjnbDs58nSDIecAns3dhLJ6MRmbP5N3kiXEdSnnCwKgJI19xOwRGb2y2nBz3RKMud
         frzqF0kNDEPmJ/EVK+FWKP4rsUFcg56cUVgQVWFP684dGPrhghfnRAaALDwEMK+e9keh
         ScILRiAhMS3Y23mOk7xTw0JdrUfkoCPxHTS/FkhIlN18MEqK7PBk+9TkEXs61miH8zVq
         5Gfl0kCH4ICzfNJPnas60y97cF1OXFEjnunebTG0OKAZBSPZDGdAUBS78ronNdCCwn1v
         AfTgkV1RfAqAgz+SOyUfz6vss3RoUr6/oooId4WMTooN+wl7JjH7HG8ESgH5RtX13XKz
         VGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530565; x=1763135365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CieNdBP+iDUkzWsYIh1zY2fr6PrC6rMrfQxyOHiJYwM=;
        b=iIAeC0qXGl+SpHeULyeDg9PmJt9miD9vSf5ZKkA+99ADvfXZGwxX2/HdWvEPvjDzuE
         Q9Q8yLsh1d1UaunShM9gXqeqrG6pWEmVt+jpBHRgm7uy1jJgi2fws4gevPcJDlokEEYM
         IeXaX7H8zKymJ4udDnTZ7HbXtpRhnBh4gTJLQAAOYofpIkNzzt2UZDGqpCeHkEqhzTDa
         ZB2AyBBRJEwaI7tChpCeHm27aBsYRCjkWcCej9BYwyGrx1g+a/IGDkssxgyEVDd6S+cp
         SkpWd/2Jzw9rxvD4JliRBHE1ViTOMTCs6QONoGvuIxtFlGJLewhHtJ0I9lZ5gniyh2NU
         +zxA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Lq0iNycZYr3RCjfSRNSekB20kCzvLIA/cNUpCF6EdJOv8UUuO5nvThrP36I0pkwXDxKQ6UG+ylfNTTXCcA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz5z0gOodVFhhSlzyG1o0iVHawJhbVSL6mWlpzkuMkntgRJj/W
	W6AQMmBGnHzUD4WmYJetapmjSXmZnkv8mMvmilHB+y762bNh2i2nF/dvAMLukmSOQEg=
X-Gm-Gg: ASbGnct7DRNgEnWjjyOhpM/SZNjuaXwvH6y6WrbDv/WMI+WPtHqnUBxQK8Ps9UzzMG5
	UnzqCr6aurVledXIWU6BEYsZpdtkHUQzbiFfvYKaoYKFGCevNodDAnQxe6UXypeAP5ySaHm4daH
	lWeWGedG4JrIeUQFrn2MAZxBgRyq93NzLyVQB4JT/yXOqq4e53pAg15KCX4WQIEY5uX3OPdt4JD
	ELF9pWWwWPP6OXQeXBCHi1NypcJaJHTbe7R8RF1D9v9xhkMdulSxFCAqs9Flgh0meH7Hxa2p0NK
	6YyvZRlnio7GUXL/ji8cFkH+/gtSKjHpllZPAJtkIHsBn/rOxGii+N0HoNa/K+2nxzbQ7DPPrAk
	dfveXPV50AXduLEKAlVRhu4CgX48NKTWf3xKJflLfjaAB+VRDI6IN1E8lSnKnPPKtBlpkI5UzNo
	6HLo8/T9q300tJE9SAt1AB6gNKqPZwFYat41E=
X-Google-Smtp-Source: AGHT+IHCPrN7eR+D+kU2SwBA7nmLBnku+5xo6MtDpIgXiSpETxbxNcs9TulWIMc7l8A5LJZmRcmwdA==
X-Received: by 2002:a05:600c:1c9a:b0:45f:2922:2aef with SMTP id 5b1f17b1804b1-4776bcbf80emr41226985e9.28.1762530565117;
        Fri, 07 Nov 2025 07:49:25 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5875338f8f.9.2025.11.07.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:49:24 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH 0/2] add WQ_PERCPU to alloc_workqueue() in virtio_balloon and vduse
Date: Fri,  7 Nov 2025 16:49:15 +0100
Message-ID: <20251107154917.313090-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2] WQ_PERCPU added to alloc_workqueue()

    This adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
    to be per-cpu when WQ_UNBOUND has not been specified.

Thanks!

Marco Crivellari (2):
  virtio_balloon: add WQ_PERCPU to alloc_workqueue users
  vduse: add WQ_PERCPU to alloc_workqueue users

 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 drivers/virtio/virtio_balloon.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.51.1

