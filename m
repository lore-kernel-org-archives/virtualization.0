Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F379CF
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755475261; cv=none; b=Fhzj9OXMoCdoSnjclVmhJAJm2MNs5oBNOko0JD8IUz3ae1Zfr8UkA02MpqPudVRNAbnU7qz8v6t/5xRVOadE7hi1PASD5A6DXlVT10LbOoFxTsUg/B9C4z1omC27be/rkmswW4raqYCCpclDfFNZz+boWlBNleB7N+mdX+uTI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755475261; c=relaxed/simple;
	bh=m1/hI4zAQpa/yacZ07Q91nQ7zDbp9gtYAaNYK2UtTyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFd2qSYoYRq4gnttxt3hey15j9VQ0Qeltx8kXFRyL4CaDFb9L1ewT5tW/hi6kEAmYP9ocZ8EpIMez8wD6jBfkOsgG8qiiRnhbpuDzXhDnHTByp6NFmSr82OWlVVUZyRZvKKGIIPAb4aqZXRVovMdo1kmy2Wq4pEYtbLk60lFjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOxBsg37; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOxBsg37"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9edf36838so2322972f8f.3
        for <virtualization@lists.linux.dev>; Sun, 17 Aug 2025 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755475258; x=1756080058; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1/hI4zAQpa/yacZ07Q91nQ7zDbp9gtYAaNYK2UtTyI=;
        b=hOxBsg377Smds7BuVx8WJEIyMRjpu3Ea199tBOOC/d0ninv2+PgEDBEZS8sngRHiRn
         3UWNMF3Xukfrg2dg44w0KZeNwhZJvGM+izBhR6hpXGFN3F5oHRS38Qhd+FeB38X7EKZC
         vF3U07TL3oBLV9duOI1ocYvivfkQFRt1WgD/HVpVJveEpsRwaGige1VGVTmmHgj1lsfP
         mz5fhFcELJ6LaTDYYl6rN0I0090cD4kjCTFwi8jtpx+Y3bpAMBFnwID+f20xZJUjSCtZ
         rfTsXpneNbZwWSNxPFII0lUPhU9RKD0ZqnZp5I7iaeUvavPjckRSAwfVJnz5lYBuFGVs
         BhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755475258; x=1756080058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1/hI4zAQpa/yacZ07Q91nQ7zDbp9gtYAaNYK2UtTyI=;
        b=BUtg10s6n8qBZnmbM0B06oxXLRyRjrWPRgpksQ7mMWR9OHd6n8UDicMEQwlMHQhlwW
         FK5VVhEbld5gLKStAPwY9aSyky12BptkfHBSvFSq6GxcoB+BRNo8h4VClswzpYurnoOf
         vCIccpngnP9xY8tP6w7lDT18VHrD8cWoTgELFxvlLRN88zzy95P4mboE9qcLiMJfJDEP
         pP0kqrVoh24FHkkOGL8kBR49jgn/B/pKbBYhshaMv001kIVwv65n5o+I9FFVjbuB6uV3
         JTZkI9gyeCzPQ649ApHLehpybOoci2Tph0QqXE/cXpoumAm83XNdI/Ah/KaRjQoUtzr3
         xYXA==
X-Forwarded-Encrypted: i=1; AJvYcCXGt49i9aeKEObv0k94okKMdDRhS7d5dPfnsSbvggpgQ3ytNrtbwuliSbzDkZA0kVdRed6FGA3Ro4j4yETpow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI6oLYenJ1oa9P6CoaIxfzIlJrBi3RZZqz+bUSN0k5mdMrOv/i
	8lzqf1l5XpuuLj67OX1iyNaCMaprsdDGgDyHMhRMiIIvEFBpPaiPXpgH
X-Gm-Gg: ASbGncu/5Ry58GycPBfmT8GwRxo9uJYL265S0LWLDJQX+IiKV2R6Gybodd0hqXCEqa2
	k1JzJA0VQ7Y/in+CeW5qUZYLMgd1eHsazqiKltembLv8TLLWdRmb5yRrk6y0OZDE42lMGJdcsI2
	0nkZkFxX4yG/g5kDxNyMQe1M6gfIvCysOtzYcm7m9oSNE9AQeysQyN3dgPKN0ZhX+CZdmaopEAS
	2hAxoiB3SXoh3uzy1QpelUsFdK99hyMpO13qulPkckhqxdX7eC+JXZzRGto1dyXbAPp1X4RKFMT
	WQ3m/+0XVNSx3o3SfWePurUJew3D1wXWqaQvAxUj04APLaEvZw5akWNp31yHyMkC+KK9RwkgtUM
	K1SPbuLncgNCf7dTOcQSezbAvbme1Bfgq/1qSNjeij/ceNtb3oH8d9g==
X-Google-Smtp-Source: AGHT+IEAB+WLlffq7V8E4TMyf2eXBnLp5sNhzDD2NavmOoKq7fhLVZX5GaQCOGPobQS9T6QuJHPudA==
X-Received: by 2002:a05:6000:18a5:b0:3b9:10ee:6e9a with SMTP id ffacd0b85a97d-3bb6864061dmr5979713f8f.33.1755475257446;
        Sun, 17 Aug 2025 17:00:57 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676caf79sm10734359f8f.42.2025.08.17.17.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 17:00:56 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: "[Leander Kieweg]" <kieweg.leander@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Sean Paul <seanpaul@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC] Plan to convert drm/tiny/bochs to drm_* logging
Date: Mon, 18 Aug 2025 01:57:48 +0200
Message-ID: <20250817235836.134286-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: [Leander Kieweg] <kieweg.leander@gmail.com>

Hello,

I am a new contributor looking to get started with kernel development. I found the "Convert logging to drm_* functions" task on the gpu/todo.html list.
The task description advises contacting the relevant maintainers before starting the work to ensure a patch would be welcome.
After setting up a build and test environment, I've identified the drm/tiny/bochs driver as a good, self-contained candidate for this conversion.
Would a patch to convert the remaining legacy logging calls in this driver to their modern drm_* equivalents be welcome?
Thank you for your time,

Leander Kieweg
