Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C365D2D2394
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936664; cv=none; b=khcckmacNngTzharzitATHPusGwDsBFwqF+DvhcS+4/T50ymTjL79xpS5UaKPdZDVbpuEU8dW99oxz+lNUqb551+Y6HMW8N1MWmHDNpmhicLD8YHBc3ChDanQCKaAZvwA24WWb0qaJkxQXQbpPrtUsBL0OqBjjU61t55JT5d6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936664; c=relaxed/simple;
	bh=oDkqqmtTJtGBZvqIfArxzM2jLkVcQGCEqnkrKRG+9hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NX8+lPjmjCEm/FKOaHQzbiYk0r8Gz5LJlf679//yov4EyGUAvdYwiMjZRn5Wd5Mr18dk2g8hLut8N6ZqSAabUKC+JTt5R4bsgGFLZ2751PV9THNDsiGTa9KfW2s35dzGLfO0WkgDzB9jgyTQLY2IMyUg1Bp/4LqecFgTfnSKVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOYaws5l; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOYaws5l"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso44726725e9.0
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788936658; x=1789541458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vBhD6t+tB+9jZHU6fZGAeov1ImNZWGevF727s90AjNc=;
        b=SOYaws5lG+jzwFbA6hFffnq0H/0HFypXXabsQySw0AfxZ8/w+QZZzyh7B3AXVoW1p7
         zdI0rLX8gFYBHz1KH/kjYKIr1saRa7I62JQ7eUJQctevpejJPgdHFDEV+lR8OKFNmF25
         9eyfeFipXKZDVPz/d3lBJLhWpQc3zmVD1x4BM4ZrtOSyAQga9hHy672ruPWGE3cY8rbS
         msj/rkFzf4/Hdh+cX3IrzjR/EjiAVkTnqN2RH64k3Di8tzD1xPURLaYF00vXug8GNjQg
         3/dAOLmZqaAcMylsKwVxIaF3W7x4SsYA2+JSY6Hnp38xS4xObvXXruvQVxsq/4KHQjQx
         Tn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788936658; x=1789541458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vBhD6t+tB+9jZHU6fZGAeov1ImNZWGevF727s90AjNc=;
        b=d3Ci1qk/z9BKYb5AmU/k5dkYTJVzMVW8vPizEpoTuwJIiqOiqlRzpXJmlVlL0v5D0I
         DbByZyPae2uXMhZ/rpoHsCBnoeY9jMpLcxxIfXF0f/vITDi/Ne+2VZ6cezHraYHOfnUl
         xuE3NIqATz05uT7taqVQlER9l4QAmgZk/plf2CWvQfjG/dHvOujFZuef6yc82Qg1jSrV
         rxqcADimulY2UrhWU+rbInUvgf9xrVobOsW+6ewqdvU3fPeLRpqg9yAmvHLvmXhVP6Vn
         egy0Hf2FBVw9fWP6hgd1uBXT82YnGvqeGpn9y0+ZG/zyxnGnZuTQ/UhqvJoHct+ZkkQf
         CMvQ==
X-Forwarded-Encrypted: i=1; AKwUvBylutVVFDIcXdhp1abNyl80JMDLYUaeslNdzYfyVYZRXvLqGNg3o/zTQ8amnr1lJxwmPxMm/7kcgq31H9EyVg==@lists.linux.dev
X-Gm-Message-State: AFuF++l5vQFftk897FQ5cyux95iO+pnruEuVny6WVQR1QIjhU6xkyplP
	ejKTWLtdrF0DyDX7oBWOe7JbBTG6PmGLLxQeySa4iCmO0hxzU5mERG8j
X-Gm-Gg: AYBFou0LZtSZakFCGOMIEI+X8MiiV0xCyC+lT7aCOCKJRuBMQBMePw+Ad/OLQKHI9hq
	FIQvy8RyZu4NhbxXJx7lgRl5hz6vVI2sbvGEEzdvxXb97Pg0F3kOJeAUH6+jNIA6p6scnzK38Gr
	wM/4lD5IeZzDv7/29Yd+AVpYlbSxYs0AzN2s+C8fctQSM4Xn/fZwsjK+3HnJ19EKlrm0yxNTPiu
	SqlMAi1u6ZcAt+WezJbc2zIa8MNkf7F1I8rU60GZrezP29oQ+Cw7sLNmf0pOmjd3eFHdgLSFcIV
	ijfVGGo+kNC/ezZWH9oKB2eDTd6HgGFF48sBj+AsPAFu10i/ie3y0DJj87fDajslVBCiCjh57nW
	f0dgq01DER5VcFkyH0LLiw8azXUgkqHWP6I9jA1S+iYrwJ6C0ik+ie/PpcYHXHansO+C30VfiVY
	nxdOTo9TTGKu6yPyHAfWTKToI7ZDu9YuJ4j2TJkALhjiZO2qqIz31/Oy9BPnFuT7DVKtwlFtmAI
	nDNQHXESP6zveL7SNwuwKCeQ+uN/eIp0wNgc376OHbCwXrNZ9dHTPYVbEixw19F0+3/jgdxSET6
	zdH4NEuDQUhKBYmUFRzqnTcDcunaxVAXtgEqG0cksQeRUwVn34mx
X-Received: by 2002:a05:600c:46d1:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-49cf820c992mr346389645e9.6.1788936658088;
        Tue, 08 Sep 2026 23:50:58 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-114-212-219.95.114.pool.telefonica.de. [95.114.212.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm443222705e9.12.2026.09.08.23.50.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 23:50:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Haixu Cui <quic_haixcui@quicinc.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-spi: Fix virtio_spi_config kernel-doc
Date: Wed,  9 Sep 2026 08:49:38 +0200
Message-Id: <20260909064938.90995-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct virtio_spi_config contains max_cs_inactive_ns, but its
kernel-doc describes max_cs_incative_ns. This leaves the real member
undescribed and adds a nonexistent member to the generated
documentation.

Correct the spelling.

Fixes: 6a1f3390fafe ("virtio-spi: Add virtio-spi.h")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/uapi/linux/virtio_spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
index 8ab3c970cdd3..459c2276c938 100644
--- a/include/uapi/linux/virtio_spi.h
+++ b/include/uapi/linux/virtio_spi.h
@@ -73,7 +73,7 @@
  * @max_cs_hold_ns: the maximum delay supported before chipselect is deasserted,
  *   in ns unit, 0 means delay is not supported to introduce before chipselect
  *   is deasserted.
- * @max_cs_incative_ns: maximum delay supported after chipselect is deasserted,
+ * @max_cs_inactive_ns: maximum delay supported after chipselect is deasserted,
  *   in ns unit, 0 means delay is not supported to introduce after chipselect is
  *   deasserted.
  */

base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
-- 
2.53.0
