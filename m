Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFC37EFF1
	for <virtualization@lists.linux.dev>; Sun, 27 Sep 2026 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482159; cv=none; b=PK8Zz3Fvxx+9OnorpjY925sN3ftjhhMqHgnDi6BHxLGK/A8mVhd2GwytGZIKoGHQXgFbrts/5gwnvKZyxUFUZwrR0GEnDDIQsfPufatEo81jvYVL4B0tYwavUt3zrNOJsGrayuHGtxlMmYjFHH7f+wtLOCDlehH++1IAHoWMLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482159; c=relaxed/simple;
	bh=2LjSmy5wQ+RbKF7JAhK6ovvEPU2UEhSF5hUQSR7JJEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef6nimiocZnw0ngnOv7G1ya+Kb08G0HqeyurSpuieGLiotEkqIJJ72CDRpfudJ/bgG4e8e6o7n0Jytp2giu+pk9Htt4TB7/5BcB8hCiV8KaZlEnC8QXrrDdl5GEcYfK5TRJ491iYWhZrALN/KDGMU2XzwhUXpWW8mKLaaEWV1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOprq73l; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOprq73l"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so1084359a91.2
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790482158; x=1791086958; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2LjSmy5wQ+RbKF7JAhK6ovvEPU2UEhSF5hUQSR7JJEs=;
        b=IOprq73ljazuiiFNIT8rjTX4gTtDdSXs5H6eB+Do9X4DWz9/Cvx3ZtQ50Rq1iA/LEs
         sb2dU2PPx8DXIS9DDSsvh1R5f1l0/lXeAD7yfBCX1zeecFccNGCFjYIz/PN9N925lK5I
         7gIvX8nS6xLQA04rlOxvZi1zzsfLIvndgmbq3/jLoSvFu5bUlJTRGyPaZd1/jlZUBVup
         jZRC9OBxk2FZXbcJ8Ts+z+Owp7AStVJ7bfKf9BxT6VsBccfoZfkPWeuj+SHJpc9iE72Z
         UHchh6rLpRcOxb7D4sZKg4Q1aYIR05n0csNd8uG+R1bn1hkDlSovsiFJRrOTRD6VF04S
         Ls4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790482158; x=1791086958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2LjSmy5wQ+RbKF7JAhK6ovvEPU2UEhSF5hUQSR7JJEs=;
        b=DduSCS9P250kZEgbAjXdzhhASmhATp6vVUvsPXeegIls4M8ergIJJL11xY8ykze18h
         QJRPLy5COo7AqK8rnFJAYnAJH66dGO5+yFQCEBdp7lSMV4OQsc/iYYDYEciRTP41VwLY
         40mcwaJAyf0Ex5HZFn07pDKtCHmyeqtmD0lmlN0J1F4H7Bjf9RDglMdacSE1QxQOCriB
         TVbxG2wMQmBbGIv94+7tbi+uY0pWYTN8RyoJ+FtWQzeQ+KfT5SRuOYUK3IoPeajP5VYl
         4Oh+ntIrjPP2y4JhkMPYJ5nVNoEN6flzTd7Pqy8oyhMiFHxx36h8SghiDPx46oj1Vh36
         6VeA==
X-Forwarded-Encrypted: i=1; AKwUvBwjEIlfAsGg+YdvksEG9fS1YdPxWxMjH+MRlvdBXlIH+gGP7Ufbbf2J0VRQ4t9thHdhc+cC0vF/1knf0C0fbw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIRFFc+rQ/+3FbA0jL3Eyd9uk/g5ChqmSNGXKBga3WY8KLSRJoK
	VF6kHEyfEzNzsHO/HHpUclFKcx0nFIAMZULDe46THfN8o36a70r7dkze
X-Gm-Gg: AYBFou3UpQe6sdr03bSSkqG2bqTgY8jWzaV2YRsndBqsd4P0oD6cVcwPnkX2cprgJ4p
	jTuid4wrYoPrwugOKpZSlWCs5RJ1myZJeE7Nlv0eZKrIwomU4t+Ss3UQB6UHrYCYvW/fHVfB1xM
	ICGw19UTl/WDKekhD+G0DyB33htlgajkEbugALMy0I1qqA1wWjnxgel9PTIxaCWsvH0y07C9yb+
	ADOn6lq+37hLy+tp4kK1E6uwGgxSMiyUfq383vwy9vkJ0s038GjwzhQ5mqQDxVPQY7/JVseN/ol
	9VJtoeSnejt3RsLyY+M173a016WrlMGLTxxohlSvFbEORmy9Ys8PsI2kz+mwfOaLC3kwJeJt79C
	6IfW9SqvfAdNtkqxWQ+1P1Q5GJX20uifjuC7FwY1YxBGXEfic0m+4RwothFShsPTPxWLXvIIouv
	elx3HUFBKX2VVGv+Eb6HcXkE29yRbQoszuc6yguNG1lr6NfF0XlHMQVxolZvwfUIbMQBFM5iviz
	7mnnp253fsfXxRr
X-Received: by 2002:a17:90b:5107:b0:3a0:d823:c750 with SMTP id 98e67ed59e1d1-3a0d823cb37mr3049456a91.49.1790482157721;
        Sat, 26 Sep 2026 21:09:17 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09766210bsm18717708a91.8.2026.09.26.21.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:09:17 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Sun, 27 Sep 2026 11:09:11 +0700
Message-ID: <20260927040911.15181-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927000323.299-1-hdanton@sina.com>
References: <20260927000323.299-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026, Hillf Danton wrote:
> What is unclear -- why is kmalloc failing to work in 2026?

kmalloc isn't failing. The failure is in kmem_cache_create(): the driver
creates a dedicated cache with a fixed global name for each device, so a
second probe while the first drm_device is still alive (release is
deferred by an open /dev/fbN) trips the duplicate-name check.

Your question made me look at whether the dedicated cache is needed at all.
A vbuf is sizeof(struct virtio_gpu_vbuffer) + 96 + 24 = 216 bytes, which
lands in kmalloc-256 anyway, so the cache buys nothing over kzalloc()/kfree().
Dropping it also removes the lifetime problem entirely and needs no
module-level state.

I'll send a v2 that switches the kmem_cache_zalloc() calls and
kmem_cache_free() to kzalloc()/kfree() and deletes the cache setup and
teardown.

Thanks,
Nguyen Ngoc Thang
