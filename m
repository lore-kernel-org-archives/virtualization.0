Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB63EE1F2
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812844; cv=pass; b=SZfQLWzR7DDqbxEXYu8K0ijqCs3Q1x8P8j1hdckbSuUGZGGIE1E3h9wkyDpg+YOc1kLeSTfI5L91Vmq209GJo9d7FjebC0aNyUpTIkN07j5NiCowfiv2If7uGGpBxSssX7YTfVZF1WlXIdodbyXJrDdFUhs/ZxJUElJ/8ySGh60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812844; c=relaxed/simple;
	bh=mbKVpQPDeDDFht6FcdGf+b590T3tEEZuvC93vpYd4Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4HmqVXxo99tXGcRL2iX+RENtDK1hIEhrl+D/CkUYksr/DZKcpumfo5OfkwzfH8NoaSl1mI2/oJ5IxklJftlUMdUmJywpLFvusNQ7vxMN15BN1T/J+vGRVHIXI8Sc/X3z2MJvByMl97Fr9ZWNjbXvY1N6y8EZDXpf2VGpoZD8vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQb6c7eV; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQb6c7eV"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4877a7b451dso2799083b6e.0
        for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 02:47:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782812842; cv=none;
        d=google.com; s=arc-20260327;
        b=rJUFTZd2DZE9rAYGOq+tfi4/x8zPmV9W9hpW6NlEn4XMTPvI4SYx9k9hGfjP4PgBbH
         SK/6dPDBSfDC7FMf63Mbfa6elhhiTut7Xj6Kdt4XIbGmF2SSFzYNKJZMPg7TByGk3CXR
         TH7IsMfu8biYkzqInxcrF/9TR8iNwkuPu7hE811ZSid9dbsfqkR261XWdPDA6VssDFFR
         Q31L4AcxNz5wpUTmUPKURqOu4gyrrbssKRHMsf9Bf7mL786bjnhZ+ZzJa2PRgwVGyYMw
         y9DhCzj9Oc0dYOMJnhP1sBJl08wOZkbciFBRbr+P+Prj/+rwzfmiCf41mN25q9JRO/RZ
         EMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KBIcT5HxVe2+MOLGkActp5e844bC5vrv0teTaWEFK6Y=;
        fh=8lKpY3QUb0SK+8CIs3STibeM41nmNCrhHCZmvnG9Pwc=;
        b=n9Ub7wc+O9F45VLDuRfbMzwTG9ElpusxUFbtbkvKSHU+ymnp+OOw55khtt5970jIms
         irlvc4HNuXDcJViYAQwu5Aj3O+iI11U54wDT3IAZrxoswqlP9rGlV0BURyOr8wCoLLMu
         0eTe31A08H48rGWQbY0GYk9oHepIciqHf4g44r55vjYWxg2GxCzQx240VrwbjWDtnIjI
         ZgUB4HRUShxZ6ZjVeqOU/secYEiJfyTTrRvBhX9SeNQ987Hw7avISp9gtgwElehaZdni
         /VhMIQwVOrGLw3XDBTaQtwBJCK5qEbB44Mlm8vINF/Jn2LyvPSwYNfEKXkUJgFkjYSk4
         udgA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782812842; x=1783417642; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KBIcT5HxVe2+MOLGkActp5e844bC5vrv0teTaWEFK6Y=;
        b=WQb6c7eVveYFiksY/oLSjxVE7rjXHRO2L65gZzalczXNT/7YSHB2+kbu1E2hnorBTk
         ZV1SXM0Gl2PMu1jtZQJqhTNkmbSD+A1QVlLCGg30ITVNZWlbU+So9RIXiVVMbWjIyrI8
         jYq10KJLXTM8jYcS/B8i0U7Bsjgmp4f2Jc36+lQATDlQ8RVRzmYLPhocva+KFmdEVi+G
         XuseRD4CDcCglhW2Im3rVNKHXPFxad+rXMhSQSV3ntIOPoK+zmukudyG/6kkrs7DZ2vw
         7xqnJ7e9618staRZp3hTWadvWvJfkI1IiwRueN4bRXnoYsW4e84AAkpg2MUo7MKL0iqQ
         Mleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782812842; x=1783417642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBIcT5HxVe2+MOLGkActp5e844bC5vrv0teTaWEFK6Y=;
        b=LTjiEibunPRUUYGKyNZDvTroPoILC7TP2CXexO4rIuZP5lyCzEU45lGRvO7m8Ll33/
         2Y7EFUxifESWhs5hj55prbs53vybYCbl9GuLBO3j8tVJKqN1VW+h38Pw9bCi40QoQWNx
         ghK39q5S6/YkJe1qw8XlfdoxOV5rehXGCbYIkE0UUzTfSSaMjMDXu6Vfdt+7BPKNyWNA
         bTzosy2dp6LoDciYAdmn0Ku/f36IC/QiGIFKjFJVHFvCCp+PlW8Y3yvuCk3Pl+mpZr9H
         fz3J2GTn27UA0FOpEWPBCZ5MBRw0EsUlEaxzVc3AQ8Dl50ESzOIyCnEQCeQ+x25xqZML
         h+bQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3QXRu3CQIV1tCxp3yX1muJlKUA++olTRR8YG4dMWRIO+1idwxQgwmAW3R0WiSKc7JUc++kOCzwpVfv4bllg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNHJ2WyL2ApuknjaPoW3AcPjkNOpa56XyazKdTfXghJ+CNud+g
	uFSj9bc0MadScMPPO3VUSkKeXZkq8CnLNt8f5K6/W/Wh0NKaQbTBExAtwKsKcZ8FWK7bHPdy+kG
	QFEgDKiBXFQZEBIlHUca7C3QLeiuWneM=
X-Gm-Gg: AfdE7ckZRnsfeEBBJTfWDuTuQu9nYqF+UlTtbuSJ9zX5jPgoCa3a0xSLef7Ik6CoGXU
	M4f6k3qxOXvbWwwkepF53kJzK7gkrhy7oYIacXuIGo9uJA5/7Z1t3UJwhZ7scRM/mpYkZqz+iYJ
	MxpR2bVFVA5lbG3naP6hTS4JtWhN1O3mpsr37ibJsx6ms89CnqXJRVP5kMves7GrWuI9FjvS793
	e9bAxn6bge5ob8HI8w/wjsdCkkHyzFCpP14BS8bLPSqVzsCuzdiBpDRnxSlMOll61f43x/Olzs=
X-Received: by 2002:a05:6808:e86:b0:491:177:c22d with SMTP id
 5614622812f47-495eb113c92mr2503729b6e.36.1782812841661; Tue, 30 Jun 2026
 02:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630092338.2094628-1-me@linux.beauty>
In-Reply-To: <20260630092338.2094628-1-me@linux.beauty>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 30 Jun 2026 11:47:09 +0200
X-Gm-Features: AVVi8CcDtRS43Sq7ele27Lz7sTO6pgEllQzoWJX7MfY6faDfvLddPHeZ0ZfhVIY
Message-ID: <CAM9Jb+gvNYvnqE65WWpXig-VE53KnMZpLf1CF6vxk51cBySKgA@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] nvdimm: virtio_pmem: fix flush/request failure paths
To: Li Chen <me@linux.beauty>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, virtualization@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Dan Williams <djbw@kernel.org>
Content-Type: text/plain; charset="UTF-8"

+CC Dan's correct email address and MST's email.

> Hi,
>
> This series started as a virtio-pmem request lifetime and broken virtqueue
> fix, but the rerolls have picked up several related flush-path fixes found
> during local testing and review. Since the series is now broader than the
> original lifetime bug, this cover letter calls out where the patches came
> from.
>
> The nvdimm flush helper maps provider flush failures to -EIO. That should
> remain the default for provider/backend failures because host-side errors are
> still best reported as generic I/O errors to the guest. However, virtio-pmem
> may also fail a guest-local flush request allocation with -ENOMEM before any
> request is submitted to the host. Reporting that resource failure as -EIO
> makes memory pressure look like media failure.
>
> The raw failure seen in the local mkfs sanity test was:
>
>   wipefs: /dev/pmem0: cannot flush modified buffers: Input/output error
>   mkfs.ext4: Input/output error while writing out and closing file system
>   nd_region region0: dbg: nvdimm_flush rc=-5
>
> Patch 1 comes from that local failure, with the error policy narrowed after
> Pankaj pointed out that host/backend provider errors should not all be exposed
> directly to the guest. It now preserves only -ENOMEM and keeps other provider
> flush failures mapped to -EIO.
>
> Patches 2 and 3 come from review of the pmem flush path. Patch 2 keeps a
> failed REQ_PREFLUSH from being overwritten after data copy, and patch 3 is the
> dataless-bio guard added after the Sashiko review. Patch 4 comes from the
> local child flush bio allocation failure, but v7 reworks the v6 synchronous
> FUA approach after Pankaj noted that the old child flush bio path completed
> asynchronously. This version removes the child bio while keeping parent bio
> completion asynchronous: the provider returns NVDIMM_FLUSH_ASYNC, queues
> ordered WQ_MEM_RECLAIM work, and completes the parent bio after
> virtio_pmem_flush() finishes. Patch 5 is the remaining allocation-policy
> follow-up for the actual virtio-pmem flush request object, not for a child
> bio.
>
> Patches 6 and 7 are the older waiter fixes. Patch 6 wakes one -ENOSPC waiter
> for each reclaimed used buffer, and patch 7 makes the wait flags explicit
> READ_ONCE()/WRITE_ONCE() accesses. Pankaj asked for those changes to be split
> across patches, and patch 7 carries his Acked-by.
>
> Patch 8 is the original KASAN use-after-free fix for the request token
> lifetime. Patches 9 and 10 are follow-up hardening in the same completion
> path: order response publication before the submitter reads resp.ret, and keep
> the DMA_FROM_DEVICE response buffer away from CPU-owned request fields. Patch
> 11 addresses the broken virtqueue / notify failure path reported by LKP and
> reproduced locally with fault injection. It also serializes async parent-bio
> flush work against broken-state publication, so remove/freeze cannot drain the
> workqueue before a racing FUA bio queues new completion work. Patch 12 handles
> teardown: it drains requests across freeze/remove and also addresses the
> Sashiko-reported req_vq-after-free/NULL-deref class by clearing req_vq after
> del_vqs() and making the drain helper tolerate a NULL queue. It also stops the
> submit path from checking req_vq after the broken state is visible.
>
> The original repros were on QEMU x86_64 with a virtio-pmem device exported
> as /dev/pmem0. For this v7 reroll, the series applies to v7.1-rc7.
>
> Thanks,
> Li Chen
>
> Changelog:
> v6->v7:
> - Address Pankaj's feedback on nvdimm_flush() error policy.
> - Preserve only -ENOMEM from provider flush callbacks and continue to map
>   other provider/backend failures to -EIO.
> - Address Pankaj's feedback on the FUA flush behavior: replace the v6
>   synchronous FUA path with provider-owned asynchronous parent bio completion.
> - Add NVDIMM_FLUSH_ASYNC and use ordered WQ_MEM_RECLAIM work to run
>   virtio_pmem_flush() and complete the parent bio after the host flush.
> - Keep GFP_NOIO for the virtio-pmem request allocation, but no longer describe
>   it as a child bio allocation fix.
> - Add Pankaj's Acked-by on the READ_ONCE()/WRITE_ONCE() patch.
> - Serialize async parent-bio flush work against broken-state publication in
>   the broken-virtqueue patch, so remove/freeze cannot drain the workqueue
>   before a racing FUA bio queues new completion work.
> - Fold the Sashiko-reported req_vq NULL-deref fix into the freeze/remove
>   drain patch.
> - Update commit messages and this cover letter to describe patch origins.
> v5->v6:
> - Address Sashiko review feedback:
>   - Add a data-loop guard for dataless bios in pmem_submit_bio().
>   - Replace the child flush bio allocation with synchronous FUA flushing.
>   - Keep GFP_NOIO only for the virtio-pmem request allocation.
>   - Publish request completion with release/acquire ordering.
>   - Isolate the DMA_FROM_DEVICE response buffer from CPU-owned fields.
>   - Wake the in-flight host-completion waiter when marking the queue broken.
> - Clear req_vq after del_vqs() and make drain tolerate a NULL queue.
> v4->v5:
> - Address review feedback about REQ_PREFLUSH ordering and active virtqueue
>   detach.
> - Add 2/8 so a failed REQ_PREFLUSH fails the bio before any data copy, and
>   make REQ_PREFLUSH use a synchronous provider flush instead of a deferred
>   child bio.
> - Rework broken-queue handling so runtime failure marking only stops new
>   submissions and wakes local -ENOSPC waiters; used/unused token draining is
>   done after device reset in remove() and freeze().
> - Remove the broken-state shortcut from the host-completion wait so the
>   submitter never reads an uninitialized response field.
> - Keep the raw broken-virtqueue dmesg in 7/8 while updating the teardown
>   rationale.
> - Renumber the old virtio-pmem fixes after the new pmem PREFLUSH patch.
> v3->v4:
> - Rebased the series onto v7.1-rc7 so it applies cleanly to Linux 7.1-rc7.
> - Update the allocation site in 6/7 from kmalloc(sizeof(*req_data),
>   GFP_KERNEL) to kmalloc_obj(*req_data) to match current nvdimm code.
> - Add 1/7 to preserve provider flush callback errors in nvdimm_flush().
> - Include the GFP_NOIO child flush bio allocation fix as 2/7.
> - Renumber the old request lifetime and broken virtqueue fixes after the two
>   new flush error patches.
> v2->v3:
> - Split patch 1 as suggested by Pankaj Gupta: keep the waiter wakeup
>   ordering change in 1/5 and move READ_ONCE()/WRITE_ONCE() updates to
>   2/5 (no functional change intended).
> - Add log report to commit msg.
> - Fold the export fix into 4/5 to keep the series bisectable when
>   CONFIG_VIRTIO_PMEM=m.
> v1->v2:
> - Add the export patch to fix compile issue.
>
> Links:
> v6: https://lore.kernel.org/all/20260621130246.2973254-1-me@linux.beauty/
> v5: https://lore.kernel.org/all/20260617122442.2118957-1-me@linux.beauty/
> v4: https://lore.kernel.org/all/20260609120726.1714780-1-me@linux.beauty/
> v3: https://lore.kernel.org/all/20260226025712.2236279-1-me@linux.beauty/#t
> v2: https://lore.kernel.org/all/20251225042915.334117-1-me@linux.beauty/
> v1: https://www.spinics.net/lists/kernel/msg5974818.html
>
> Li Chen (12):
>   nvdimm: preserve flush callback -ENOMEM
>   nvdimm: pmem: keep PREFLUSH before data writes
>   nvdimm: pmem: guard data loop for dataless bios
>   nvdimm: virtio_pmem: stop allocating child flush bio
>   nvdimm: virtio_pmem: use GFP_NOIO for flush requests
>   nvdimm: virtio_pmem: always wake -ENOSPC waiters
>   nvdimm: virtio_pmem: use READ_ONCE()/WRITE_ONCE() for wait flags
>   nvdimm: virtio_pmem: refcount requests for token lifetime
>   nvdimm: virtio_pmem: publish done with release/acquire
>   nvdimm: virtio_pmem: isolate DMA request buffers
>   nvdimm: virtio_pmem: converge broken virtqueue to -EIO
>   nvdimm: virtio_pmem: drain requests in freeze
>
>  drivers/nvdimm/nd_virtio.c   | 265 +++++++++++++++++++++++++++++------
>  drivers/nvdimm/pmem.c        |  51 ++++---
>  drivers/nvdimm/region_devs.c |   5 +-
>  drivers/nvdimm/virtio_pmem.c |  65 ++++++++-
>  drivers/nvdimm/virtio_pmem.h |  22 ++-
>  include/linux/libnvdimm.h    |   9 ++
>  6 files changed, 343 insertions(+), 74 deletions(-)
>
> --
> 2.52.0
