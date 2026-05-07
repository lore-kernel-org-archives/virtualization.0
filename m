Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD83932C0
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 08:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143473; cv=none; b=ZNL5ghrGqgSrRJN2KFTzGSSspH4mgJrK7f2lFLiP+rSOLjXwuuiB4NOWzOMgO73jCh7QC3PTIbOb9IMbpwYQZ94y5C5dMuZyi0NUVqdnBMHx/W+CJ4pUAsr9LMjEtkwyOZL0wsrlfUQw3CBlrM0vJRVeKlcs/pppUJZmFW/IiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143473; c=relaxed/simple;
	bh=iuH3ng2SMU5XMCkaEwUa4i40zg8spim+qeEvG0iKFgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REN7gYL5bOHUJ4YVkMcPAXwyxkBH6143muUqxS/tCfrvkn5TEFDxsn4yBXVXVTEc5c5sHbiW1bmzy0cim4VJxG00MslqVBpV7TO2bo8isHvuL+CnHaHHNExT9PplkPIdWPEsg8PoMwlu9bNwkvIxpxkex0x0AuiB/zG+EZhEx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjlazj/d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjlazj/d"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296d553142so327523b3a.3
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778143459; x=1778748259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzgFngjfsKygSLsXg6rWfkZ9Vqa6LDc2D4netmtnYM8=;
        b=Sjlazj/d3ZrLORpe8oOtDQ1n9hR6QG8YlfaMvObzUMOieHwr4oVFWL1K7pVOXEf8CG
         rORPqcntbPPdiEfu0OudnnFVH6KLSRYgPQVdaDMcoh0asBIwZ8TAHR45puVt75HKnklK
         pgUqn7yFPI5IMJnb7aaiD0Bvbk4z7a5Ah7QCwyIE3fyYk1fhE3MuKW6C5nvV9AJEJL0n
         RSPCX0ID+UM4fTaITHtUmXI+oYufBUsCZmMwubkTYxPl+946jDAP8NgnddS/7tI/uvMf
         eYow1QFVRk4qsSHu9HHRc8pX0nsy5wwOokcT7C/2/j3GYtAb9whvuneIe5TZ/VYUfk/u
         9Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778143459; x=1778748259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzgFngjfsKygSLsXg6rWfkZ9Vqa6LDc2D4netmtnYM8=;
        b=MT7vESTEau2/Su6vg6DS1uFsK9D8KJcD/2mHC04WbPV+k715a8JItWIlUYLjuYgQ8O
         ax6nPG8qMldeE8N7UAD8csLaFeObaobfalv4R+jeqFibUd5uHHrQrUc9xi969p9ulnti
         onWV2FvbCBWGqrGkgi1e+JG+luCrt8omCXRQG6e0eikTkJng0WMmG8VdFQvf4XjJpaIT
         30qKq6QENWWLCf9xlKLEmJ/p1J+caexg0Ep1RN4O8Wyg1mkycd7kGywUik674k2AtbBH
         EKjBjCp6kOv0s6ZXJdRUl9XfTuv8DMmzBbbebJgrk5YPupvvQazF+qByY9YAFn9foA32
         BnaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iKGPD/xI0xFoN7nLKjqifQF7FM0vhRXtQakWXLxv5ds6Gf3Ycm39KAYuYyIANEVjWULkk9HGoYGWHFXFdGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7XnbMp7/i8ARZ3JriydeGTXfIDAJBfvZoVCpxLRuUkETNk6Wy
	q8WW5jM1Twd9akq2v7enzLeGW7ARK1pEwAafcYkog5y0zdH30Yg6Sj0=
X-Gm-Gg: AeBDiesgWZ6ldNhm5RGKoS2uWdv2UZ4jlZRp9IsxDQzdp7+rZwzRxJrxBWn6cz+y3qg
	BJH+IOKwNn8I+DxTWE7XWo8Q7qn+rN0nEnpjhJFeEadZLdIq3MJB3lARnvSNXEqVf6F30qP5HXw
	upvF6VAh497hw8T9oKptZ0ciYuLlmI3q9Ugxt+VgAgy0r/he+9ep0A7E/pV6Pwrv0xsXR9Qo/U2
	Km0AREY1Qq0vXc9QVxnvXmyPVk8S6gCteHZHnwYGvMGTcSDS+Nu9gE/tT89ZDWoEMokbSPsLEYp
	2bGAzzO0voBnqnEetPuBP2XB2LShQe6fGHSewPJ1PdCuQUSmtQoojvpOGOAHrNyzMucP/UNkxVF
	amX+RM+i6S9zvDu9lJbddBz40Ja+v43RgHYepylWoHL35BniGtvmgcdNdhUKLnz+Wql6WOxoCkH
	HqsJ8K/i3eyL181dcsa6ggEJZ9XdwKlEVydVzp1JZTAdSZyI5ianBNeWKydtnhG5icyJwqrySkR
	60/7XeCa+7UCw==
X-Received: by 2002:a05:6a00:4193:b0:781:2291:1045 with SMTP id d2e1a72fcca58-83a5b2d34damr7200606b3a.8.1778143459390;
        Thu, 07 May 2026 01:44:19 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf36sm9989625b3a.41.2026.05.07.01.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 01:44:19 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com,
	kraxel@redhat.com,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH] drm/qxl: Add bounds check for relocs_num to prevent memory exhaustion
Date: Thu,  7 May 2026 14:13:53 +0530
Message-ID: <20260507084353.78071-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The relocs_num field from user-controlled struct drm_qxl_command is used
directly in kmalloc_objs() without validation against the driver-defined
limit QXL_MAX_RES (96). This allows userspace to trigger large kernel
allocations (up to ~8MB) and prolonged kernel loops (up to 200k iterations),
leading to memory exhaustion and CPU starvation.

While kmalloc_objs() prevents integer overflow via size_mul(), it does not
prevent unreasonably large allocation requests. The QXL hardware and driver
enforce a maximum of 96 relocations via QXL_MAX_RES, which is exposed to
userspace through the QXL_PARAM_MAX_RELOCS parameter, but this limit is not
enforced when processing execbuffer commands.

Add validation to reject relocs_num values exceeding QXL_MAX_RES before
allocation.

This is similar to the recent fix in the Xe driver (commit 6e61a2df9ad
"drm/xe: Add bounds check for num_binds to prevent memory exhaustion").

Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 591b026ceff..aae9ca636ae 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -164,6 +164,9 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	if (cmd->command_size > PAGE_SIZE - sizeof(union qxl_release_info))
 		return -EINVAL;
 
+	if (cmd->relocs_num > QXL_MAX_RES)
+		return -EINVAL;
+
 	if (!access_ok(u64_to_user_ptr(cmd->command),
 		       cmd->command_size))
 		return -EFAULT;
-- 
2.43.0

