Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFFE757EA
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598226; cv=none; b=smttZ6Nz+XKW0a/RCeF9dJuCw6eY0C1eagh62LcuOzkxXW18W8rgdMyJ4jKYuZGPE1CbwTizwVNoeznm9CsOloKFriST1PZWHQxnFWkQwnRBlh0z3Tr4KDdYWHXeFOVky4U8AeGPxAzuyiQ2+D9ranwgohWv21pPIpkhIcIrZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598226; c=relaxed/simple;
	bh=szKhuhQmiVIM02ZbdgLbY1lco3UqzkBAMcoq3GvKKrk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tRwtt7WreQy+WRmM8NzYKiXua7nLIgjH3Pryxwq6ZvgQp1wUM+J6B8TbNqRFgZqRL0pv45TTQWhZKUrOYbAAZ2BcApW1RyJQtMShgq7cCvFRHWr+Gnl1yJLyE4IPodLvSuEdLNoGwgozn+nM7cZoM7sJBdgX95qHSm5BXSngD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSklrUXI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSklrUXI"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso1281701a12.2
        for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 07:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731598223; x=1732203023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=szKhuhQmiVIM02ZbdgLbY1lco3UqzkBAMcoq3GvKKrk=;
        b=HSklrUXIfqHsEEybYJVCbw1HyhjtP0buAudKxDYYugO6bK0BElPN2XX/gBCaZsAcuo
         V4PGx3RyJRRnf9TjX1xZ7eI7RyaNjfTfaeByUqlH7Zvb4sEQ461thlR6BqOvRNuKQvnh
         n6XhH+Zkf0qXLpO1QA5DniNbU0tvABxFQ4w2oRrj3T+nSQS3YUHnGxARMOtkdnbYW5pW
         lEYoykPCeuWPGUvUfCKYXcxpzSjGUdziU1LLCOHNhCWX9vf1buGPX5Sw2h1gSLuNBXpm
         ksDmkn++spetBkxZ4EETSCI+tCXWsZRG1e4PGkqHkVCxgzAkaZyLFB6w+DPDwp87wnXd
         pGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598223; x=1732203023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szKhuhQmiVIM02ZbdgLbY1lco3UqzkBAMcoq3GvKKrk=;
        b=PGCf9JSHJ4PHWb+5N1GFnqHQrP16yFWFSc964x5vObAypEulEl5mD8mbzCzM6o0Uuz
         pLWKD2cdFbt8SiZofaOyy8GeCkWjEsGqAV9GlMomvSnfTW4iPjoUEd4FImi/vwnID+21
         eZ7yBhRu/WpDQr1Fz0Off6ACMFg44Rob6A4rQgsk1SP71E7VzOOi0k3lSeHm/AIU0JJW
         TdK/l0Vtpler8uriWV+uky75Ufxbf/iRRd5vB0MpYN2fuAi7MhbL4p6IUDGgJP73wJ0E
         bVM5kteBK6OFR8JYcJBnogRPuCrmYretgF9OjO2UwuMQgTJJ5ARs/3nnyo7AjUWcqJQH
         CXOA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pGVjpv1L0KJCAsddK8bWlaQYilG4Q461BMwkOexcob1fraogTXSxS3RgcYR1AlJBGHe4ZlxV79uUH22Jsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzipwa8xTR6UqdXyFR5AL0T4lh+Ug++xMYf7xFrCTiO9sZY+bS3
	wUaoDU58O8Mun9shp9HmZrarHSfwEg5zW4kBmrLi5qsiK7Cb7/q5
X-Google-Smtp-Source: AGHT+IFn0AJrpN7erqmeNM/7HGlotZXPzE8O1SvFHPedjgfZG+/b95RXkljUudU1q+VN+H1HIMSRZw==
X-Received: by 2002:a17:907:31c2:b0:a99:fb56:39cc with SMTP id a640c23a62f3a-aa1f810644amr669660066b.38.1731598223137;
        Thu, 14 Nov 2024 07:30:23 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c9:2500:bb23:40f5:fe29:201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046919sm74063266b.156.2024.11.14.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:30:22 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: kraxel@redhat.com,
	airlied@redhat.com,
	alexander.deucher@amd.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: Switch remaining drivers over to drm_exec
Date: Thu, 14 Nov 2024 16:30:13 +0100
Message-Id: <20241114153020.6209-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi guys,

switching the remaining driver over to drm_exec, cleaning up XE and the
finally remove ttm_execbug_util since it isn't used any more.

When I originally posted the patch set for drm_exec vmwgfx was to
complicated to trivially switch over. This is now done with this patch
set.

Additional to that radeon and QXL were never pushed because I couldn't
get an rb for them.

Please review and/or comment,
Christian.


