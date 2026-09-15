Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAEC4AF17B
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487302; cv=pass; b=qDarR4uKWY10S7W9ndrEwtNGDAcqDwR/7Xf/3xRTCrMX/PleH2koB6/PVozhhaGQFbkUtqIbs+uGcG/I4+N1Py5EMiTWGu0l8Rq8NuzFG3HGkjJw9Vj+vHy8bNMj00VnUvMshIlXAO9oQY3DR3Xh9nh2bXQUoLkuOjpkILEKQ+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487302; c=relaxed/simple;
	bh=IIae2hOq/rSdDn4rRHwnG8IHTBsRfnz+1SfXNqeYduA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWhz5VSLCyyXa30gr+mwvcEHOK8fPca1O2byOcMmPW9vcE92peuSf3x3/lYZpFHvboDxKBSXgByyDnBCNmpSC67vWmZaoPprSge09NFTSRz5zBPW8ystoBXefCjq7s3Qv4do7bTKHuk0rth0mCAPobrJdKYwdxlX77pb1ca0ucg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbuJjaUF; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbuJjaUF"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86868f7707dso1395425b3a.2
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 08:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789487300; cv=none;
        d=google.com; s=arc-20260327;
        b=dM98RFzWiKcvkfr8LT0S/nsoUlBzyLbFAwMyFVevS0gqzW4of4iO+Q1vBFkCE0j3Cw
         G8htmKL+WMXygwSqixV0kchuhNz8JNhNFJVbmpS/s/bKEyTsthk0kg3XR8ov8ouSfr5u
         0VdQTMDrTjJuFmWK/wfiXsFvIYGia9Djk5y8d6n1a78Nejn4YEV1a3LUvJt+JoOGo+ve
         fjglSsThR3rCR1x8kTDrBr0d7/WvCNIWck1ScJdDe7T5h0GpIC19vrZo3ly+r2kWwRnL
         byC9e9fyvFfPYoZ0l3KE+cXdVK/Zn2iXi3U0trgjHNwTEDjjf9qthTKOBOJu7oFXx/Cg
         goOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IIae2hOq/rSdDn4rRHwnG8IHTBsRfnz+1SfXNqeYduA=;
        fh=wHtg5Y5aLl63vHAsjLtch+qYebOfAoSq0GcXHMV6LXA=;
        b=MDONM4lilK9i+krQYT2ed5QsgmXZNoah9u3sTac9LNirkaOGxIysYMOi4KdR//i/Lx
         LwWK/MXd87yR/RNMRMJs+9lHRaUv9+Nq0dPd8gozsy2k7wDPS28Z1wbJk5baGWiUUuDH
         uZ6ubOMIL74wuO8eiSD8Sbj8k7uqmCebH8ukFbIDL1VLXAsJzKXrcN2FZL5Erj2oHaiT
         8t0u+ksmtJ3xHzlFCKPQglyWOP8rj7icWTCAAzkoF1NSbvhNhniQFYsIpzz99q2QOgSO
         YiRsxPQIBLCC7BoIWeEiVu4BQlhAyylcsHVYJRNgMEC+YRBZz82PKK8uaUHp4+H2ZSOk
         5vIA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789487300; x=1790092100; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIae2hOq/rSdDn4rRHwnG8IHTBsRfnz+1SfXNqeYduA=;
        b=NbuJjaUFsW4vmpU1HpoH94nkaRDqgiY5hjNv8J1eXOihDW6Xx3QHs/fQBf1B+Wekv4
         JXHSUpDXuU7v4bIvWjVpG2Spf87CFzYPKC00dcvnjwJkkpdE66/BKDgbC6zczBZXNgDq
         r85TBWapu+hxSi/DUDqB0vBgWTCQ9N26VssEYVh8hD8DJr8n3VsOVTzv/3kJhtKYoCOc
         Se/jUVn9NmWxZ5+Gs+ucE+I2lFcKECf2fLj78M/2qrv30ljS9JoPWpaqAbZvK2RiFtH2
         2NmSvhY1eiuuNlnb0100Ikjb0Vd3vHm9MyL1kDdgl3UWeEvkS46Z8iyPDXYTCfK4/YGS
         4whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487300; x=1790092100;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IIae2hOq/rSdDn4rRHwnG8IHTBsRfnz+1SfXNqeYduA=;
        b=GUiz4lqG55Mq1MH60xUS08S9YjYbDudI+d9h0jnCRSOUP6+pDR7daFGO02xUEMz0QI
         Ba2fiWKhCVUEanqqq3l77cOJ6iRq2kXJqGz0NFQXVvTgnodpWibJWdfD6r43dEHLvKPf
         h0k02UBhrAXtckE6V7N878m2hdWMAyWr5bhuD0VnLgqAPwGjWERfhJXsFuonoXaO6d3A
         1d4zLzcWzxFZ4Ey/wA9ykMcrHPQAOF9n737hneRD1VVtJH7gI0kf5iQlComsZhlgOrQn
         e7LLNJN8VqBTq7xtxp6sGV4baHmgJnYZJoSScfCDyFW13frMDULuoguj7aeZLfdxuxyf
         NWKQ==
X-Forwarded-Encrypted: i=1; AKwUvBze++3YNsB8A3hp9PEPY/WWNbeTQuoxpsJHHCzi4/LL6got3dgdovwVv4reGNfmlXkPcHqzpRn+zB6IibY2iA==@lists.linux.dev
X-Gm-Message-State: AFuF++mxr5q5RM4Qkg7umWRJpQJxUtKK31zbMYj0ruKzmV4RJF5EumzD
	eY2cMnB/m92f9bGrb2SjDTWU5Z0Dru5vsH9ubVMf7SKrBjF24d742qhBSulXCZo5iSjtq0K+h4N
	qHgHCQ2YsObiSKyChMWO1KKDRkzUI6Ng=
X-Gm-Gg: AYBFou05BsDd6C/i5SO4KT4LpzRUu89J4ASV1A+SedCMI3z98ZBYbZANb80RYY2gWt3
	szVPWKtKkhdPPypGEm6dqnxyCR8AC7hajZz9D7VAMMShpC5Icy+IadTHC1FOjSvW3hNhGBvtAX9
	Oseghx6rOxRfx8FIKwNWOBMAl3WadxzkUJvv9AjUQD1Rhd7tDYlBuQsjSd37fBM6DfIYDhfb2jy
	TKqExhUVt6FXU9pvgoUyWzDTUda+d4u7cDBXv/aj/Ir6vqojOTBF8rhOhY39LMwDpHmPLWLUAAC
	1OJ6zYyCq83xxgi+Zuj+uoO40mMGsJIfhbleekbkmpI+RACh19olyQ==
X-Received: by 2002:a05:6a20:ce4a:b0:3cc:f008:8125 with SMTP id
 adf61e73a8af0-3db4047dfd2mr18121150637.1.1789487299805; Tue, 15 Sep 2026
 08:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260914040332.1892175-1-oss.patchbox@gmail.com> <20260914041702.258821F000FF@smtp.kernel.org>
In-Reply-To: <20260914041702.258821F000FF@smtp.kernel.org>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 15 Sep 2026 11:48:07 -0400
X-Gm-Features: AcwNN1WjwF8pq8QGvnAAIZj-8VV9zkdWmSbWOv3iTyv7SJN2U0DA4DXnP8qJG64
Message-ID: <CAGG=RgBhjFbfvbmMtT4q=_1Q1k=Focg1HaLSzcRJ8YGg1XAS+A@mail.gmail.com>
Subject: Re: [PATCH v1] vdpa/octeon_ep: Fix race condition in device deletion
To: sashiko-reviews@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Sept 2026 at 00:17, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>
> New issues:
> - [High] Incorrect teardown ordering in `octep_vdpa_remove_vf` allows hardware interrupts to re-queue the event worker after it has been cancelled, leading to a Use-After-Free of `mgmt_dev`.
> - [High] The lockless `atomic_cmpxchg` synchronization introduced in `octep_vdpa_dev_del` is vulnerable to an ABA problem, allowing a Use-After-Free of a stale `vdpa_device` pointer.
> - [High] Early return in `octep_vdpa_dev_del` silently skips unregistering devices if multiple vDPA devices are mistakenly attached, leading to a permanent device leak.
> - [Medium] Calling `cancel_work_sync()` on a potentially uninitialized work struct triggers a kernel warning (`WARN_ON(!work->func)`).

Thanks for the review.
Please drop this version.
I will rework it and send v2 based on the review.

Please also drop the Cc: stable -- it was premature on v1.

Thanks,
Yuho
