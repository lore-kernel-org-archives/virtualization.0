Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB47E792
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644662; cv=none; b=JlwvVplrygdrQErnqiPP3S5vJQwbB+BCX5T6CDT+fCq4yD64kw16EXwczme4aJo4YxzA/uTyo/lSMhqHoeUjqa2Hvn8cbI+ij5Ug0cvUhV64Jk2ZBUDEZKOjX06UF6LddiasSEf7j5VBR8yh0fUdptWT8iz7v5okBRUMrZAjgxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644662; c=relaxed/simple;
	bh=PqwoKExF7hzuaQAhCxVdphwaIay6TpBVh1ij/ZVF6Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJ75FMiZi1yN4JYQfk9UU/WbtMjbBGsy3mhY+wvQlmbjd/DxvRZz6VjrCd7mYyrbBdBx/LO0Mf3gb9DYeZE1xBh5yzPVj8qT7hu2R7FFNHmdCRBKHCpuPUT+q2JHuXR1vbXT84jn3AZtOBKyXpPy1bMBeC4phuMWxRDcLuqml6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krBwvTWq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krBwvTWq"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-890d52c7c7bso467906b3a.2
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791644660; x=1792249460; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PqwoKExF7hzuaQAhCxVdphwaIay6TpBVh1ij/ZVF6Y8=;
        b=krBwvTWqL6vZDtIbcrkbZN4do0oAT2jw8+JTf4useO9pAgw7pvSloSHg3XU5QrP76r
         lS1vW1hIJ7WjT6is6Z42gajCl2hb8vOVtKwBheMGDwe0fmGyrhIrgWwHSqGPhoU1HKwX
         oWiSrK5xYNeRzDH0T7JY0R2LRQl6vP5UEG1rDu4h9OwmXYWygIfHIKlm23iV1iGsPg7C
         po9beHZGolYHEIvtscAjlF0tudt/Xjje+5UT6pLgEh5cMNURy8ESazOowE6+rOQQzZUL
         uPan147yXM99sJg2lVZ0r3mPYWzduPTisJN/7wBBZ/5wVnxze7W9+HBb9I2cStG4dlmr
         CFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791644660; x=1792249460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PqwoKExF7hzuaQAhCxVdphwaIay6TpBVh1ij/ZVF6Y8=;
        b=2e/wF7TOWJ3STIN4GwmS40VU7FJtLKCBbveZ9pXxqzM9oX9gmHMKnUV/7jTBZXmqym
         oIDhF8QmKuxBSu241c/EyhbtOh99jF3aYHCp5Adqpxn2yxZcUyZYFpSvoUp9gdjHuYYr
         GAtnk445VItX9RhTKMkJBKbYGjmleiWAS3e6v2jI8S6/8cQb+cJlgzcXl/dMDLfCXPFT
         FRVQSjAoqVn0LUxO9TKAqzAQpIcco4Nndxubk78leGnV5Z8m9wZnzmv4Iro4i+RGfebw
         Duq/+x3z9XT7ZY/McovKFMHnd1ZXFKt9LUTsXsdJmSC45piW3w7j0++FeneT+bMQsT5/
         HirQ==
X-Forwarded-Encrypted: i=1; AKwUvByKLezsqwj42mo2fcQV9IPkcRjU1iwBURWFSPZjkYSHvAuZU5ATZVw4fxspVaYY5D6KVlNRHC+P4+oDQJKd0A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJuFtyQSW/1KeMAnBkaHfCmXI59sn8QiJQBCxTsi4k5rVSy2TBj
	VUDMMjGFUWDwa1xGY48sH9yu/HPt8Q3U75cEMycDVXZ1LpfwjMBpole4
X-Gm-Gg: AYBFou27MGHOu9Cpf3VBJdLVAEJHHCkyE5wp740KhkcMrRmEOpybIMcut022WGhWmHx
	J76aGlkbSAoEZTXOcIh64yu2bti84+MiIyHem11JpQZ4rCmFDJPQ8DkzIE8HULvzVO9VYIzqoJ0
	kfNczhsAesCL8SP1W1OKGSvicJqHsGYBmVpi3fWV0glaYWgYcrh5/W/7Tq4jFoRN/IJXWkoat4N
	CEv7+0xJj5oj/F7PRcO6x3uh2i3ntvgfhW5No1K6Oi5Pb+dyheNUg53eEYqqhBRUfFf52s5hvWq
	9kAZIhI4You68KfEtaVKNKmGGQjRKkRpVRzKBEnlOearJtKXM1LsISkYHtx05+2lVIFzYsLGms5
	H/C0gPnYEOuHHQVyFWkXQXc5SIhct8lIZzKcKksZc3ITdzy46Ml6Fuppb28M1WcFOcs0HVVwNh6
	fCzOZ1Vjty6hsMu/p82jcUcch6piWgjSgrEU4JimmwuUprff86rpB5FcIpxS3MLS5uv+F+Rg==
X-Received: by 2002:a05:6a20:bea6:b0:3e1:5481:5457 with SMTP id adf61e73a8af0-3e16bde44c7mr4299571637.31.1791644660094;
        Sat, 10 Oct 2026 08:04:20 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:2d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c42b06e9sm2252836b3a.42.2026.10.10.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 08:04:19 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Hillf Danton <hdanton@sina.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Sat, 10 Oct 2026 22:04:13 +0700
Message-ID: <20261010150414.16953-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 27.09.2026, Dmitry Osipenko wrote:
> kmem_cache is used by GPU drivers to avoid kmalloc stalls in a
> latency-sensitive job-submission code path.

Fair, I'll drop the kzalloc()/kfree() v2 and go back to v1's approach
(one cache, created once).

> The /dev/fb reference doesn't sound right as normally removal of
> framebuffers is required before GPU driver can be unbound. Such bug
> reports should be treated as invalid, BTW [1].

I went and checked, and the /dev/fb angle isn't actually load-bearing
here: two virtio-gpu devices at once hit the same WARN at plain boot,
no remove/rescan or held-open fd involved ("-device virtio-gpu-pci"
twice on the QEMU command line). syzbot's repro happened to go through
the hot-unplug path, but the bug is just "a second virtio-gpu device
probes while the first one's cache is still around."

I also owe a correction: my commit message said
kmem_cache_create() fails and the device doesn't probe. That's wrong.
It WARNs and still returns a cache (merged with the existing one), so
the second device probes fine either way -- I'd just never checked
that claim against the actual behavior of kmem_cache_sanity_check().
The real problem is the duplicate name itself (confuses slabtop, per
the comment next to the check), which is what syzbot and any
panic_on_warn setup flag as a crash.

> Assume the similar "duplicated" kmemcache problem should exists if
> there is more than one virtio-gpu device in a system. I suggest you
> to validate this case and if it has the problem, might be better to
> make kmemcache's static instead of creating dynamically.

Confirmed, and agreed -- I'll send a v3 that's v1's static
module-scope cache again, with the commit message fixed and the
two-device case as the primary trigger.

Thanks,
Nguyen Ngoc Thang
