Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87A3B9D95
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999146; cv=none; b=fjxi9A4R90Y5TMkqqbYCaTwjkWtgjGo7jles51pY64uV+sitN38/mpbiTG8E/BCaWxxK8+ChdrCLxpXK1oPPaWnESZxLToZQZihpmU5vBgLB5hqxmxJv/E5h6MPahKK2YgimQgO8nEhXvh3qD16wQYd2k3JQT5JjPxBCh/l+uhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999146; c=relaxed/simple;
	bh=07xBgVVP2JBjaNjTf6tOGuw5SBbrqT7XyGX1346mHb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UvZt/ONrerI57S6AxWlc85zJedBVhRU84ZY6U2ytTgcIyAm5rVqw5lSb/NZCDY8fzkpJ37wO6iW+9fkXMsc4REmupuCRkJTVk4WlPSgO7WWydd3yJ6MH0RH084MG+4uIWQoCnHu+Ag4QAVVc+5BnbPOpTJi8hRvIPicARvMrjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tE9IOgZP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tE9IOgZP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dcbade417so1492618a91.1
        for <virtualization@lists.linux.dev>; Wed, 05 Aug 2026 23:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785999145; x=1786603945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ci77Hl+QZM3Fah7Pj+TstLuIwRPYYUyZFUXDgpE0Gk=;
        b=tE9IOgZPSbd8iKLOMX8d0QMT8vuZyhM0neHy5EMqmTrzxis3sADNGPEGA5UAx5ZcqE
         eX1/Z2SBgebe28QD3n2kGTJQfKe9x9ynLkZ2AfL8fnlnOzI8SEubGO25rPW2uz4ojBWX
         TTZuc78xb1F+bAa6CfZF4+3d+QgqARfs0q0uahH8SvqnpoclEfJG2LF2upY6mhuJCkKl
         70VjbQSLo3oFElpIOe2I0Kh9a9kMEkyqx+NHh8Zrndg1AHNyCd8zl+dqRfeO+7pDY1Vn
         UtiaEPRw0QuoUZzn+pAoewoBwsWAL9BhpzvGIsytYU0NXNIjil/t/33QKqLID8IxG0c5
         ZggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999145; x=1786603945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ci77Hl+QZM3Fah7Pj+TstLuIwRPYYUyZFUXDgpE0Gk=;
        b=o3Cdm2w3xh4P4OJYY1ZcJQajVC6InaKTBjXYkVj/j4aE78NOMTcz0zj/D/ao7QQC2Y
         G8v43xbsmbqwfLlrsakJPe7d/LATSv6REutQrD+w0PqeVJ9y2Ku7SVcRtHz6UrU0BOk9
         QG7zg8sh3bw0wIuDv5peruFO5Uxy7X6CmC2EXWgZmJF7qZ9BAQkH4CMt9JqxRx/yuqoB
         jubzy3+R9UkbdokXBfaPW/37sMbcmRznM6cgNLG2fbbf41vGYR9/F8BysTd0HH7NGbwH
         iLwHyeq5L+4LlmIVjFNKur1i0xlwLJZ7aALiLcaTDxtIfcS4VKcWJiHnDsrmBp/fBb2I
         Oq5w==
X-Forwarded-Encrypted: i=1; AHgh+RpTEcqiVoIm8AD88TQ+iQGIhnXruv+Mz/G8GLgFVuptxjdquC6I+Or951shVFkLCZiQVvUfZPGGg/K4i79IuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvmIDo4lN3PY9tTBhhyraid5luHlTUejopsnJUjRDMgKy80RAk
	d4cDrbUG4Wo7xHJ1pCH7F1L/5TniTwfPEzHIz/6/6i/Vcjp8s7O6568uIYlZT2V+/NVBYg==
X-Gm-Gg: AR+sD11wjaIP0+0aGZMB+lEZI5u3d+qUVBIZgopemunZe/IXsYkbfotPmuYGhscL5Fr
	L39DIyXjeTg2ZAyjNxBvNUoXBOmQce7A0ZJZDTmKBA7W+r/jCLit2NSVWgN2PucE2MzzFh5juQa
	lycFp05VDKFlHs93HmkaOXYV86XI7BYHsrSoidxjaIr6lBP7HiT0ckkL7yh0ZSm2y3+TPsTd8TX
	BDptZxvY+Wca9xig1SX5QX6HjtKh6O0sAQtUR8arrKCBpKgmtz+yakDxrk2tKzUhsEGdzP2Of9u
	MJ4RAPN7dRjTdv2ZtToT7yMrp6wOhv5sYAOsZqkZ9J8vQjT/bNJLPEaHJFhcAcRDJjv3JAj3z3u
	z9txqd5uBpA0uZjmRDUMmewoyDxkEQEin0gie6FQ9SyUMNGVOeqgPJyTsyQJJmqQfKxtktihJqG
	lj1wx14CIQ0A6B+TNg39WA9ON/BEUfHJzeunc+Kh+8sB5p5+Yp9IP3MVk5UuEwQ3U=
X-Received: by 2002:a17:90a:da83:b0:38e:500:3975 with SMTP id 98e67ed59e1d1-3903c5d82a3mr11893037a91.18.1785999144464;
        Wed, 05 Aug 2026 23:52:24 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca508a48sm19408839c88.1.2026.08.05.23.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:52:24 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	michael.christie@oracle.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v2] vhost-scsi: serialize completion notification with callfd updates
Date: Thu,  6 Aug 2026 14:51:43 +0800
Message-Id: <20260806065143.55584-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_scsi_complete_cmd_work() drops the virtqueue mutex before calling
vhost_signal(). VHOST_SET_VRING_CALL replaces call_ctx.ctx and releases the
old eventfd_ctx while holding the same mutex. vhost_signal() reads the call
context before and after vhost_notify(), so a concurrent callfd update can
make it signal a freed context or NULL.

KASAN reported the use through:

	eventfd_signal_mask
	vhost_signal
	vhost_scsi_complete_cmd_work

The context was released through:

	eventfd_ctx_put
	vhost_vring_ioctl
	vhost_scsi_ioctl

Keep the mutex held through vhost_signal() so completion notification and
callfd updates are serialized.

Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Link: https://lore.kernel.org/r/20260720085306.1519294-1-physicalmtea@gmail.com
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes since RFC:
- Send as a non-RFC v2.
- Add Fixes and Link tags.

 drivers/vhost/scsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..7f46bc0de3c2 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -735,10 +735,9 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
-	mutex_unlock(&svq->vq.mutex);
-
 	if (signal)
 		vhost_signal(&svq->vs->dev, &svq->vq);
+	mutex_unlock(&svq->vq.mutex);
 }
 
 static struct vhost_scsi_cmd *
-- 
2.34.1
