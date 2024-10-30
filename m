Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29001D27A5
	for <virtualization@lists.linux.dev>; Wed, 30 Oct 2024 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270999; cv=none; b=CdmTBVfYLtxPk6wOFizcPjH1e0SWfdeccZ/fhpkNjHaFyMWwbmPl27yYUYT/EaDlo8stDcWzJZzlpQDUvWn0hqermcH9/O0tJzS3oiqWxLP+3KbEixoHnpmb53sLTrt/HYETFNzqf6lrZgb5cYlB5VNgTVj1G0UHoORQPx3z0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270999; c=relaxed/simple;
	bh=zJw3UJbl3CQMX8ZV+7LJ0VvBC/OyJZT7GPijwALV71Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpYfbn2ItKYPgrgQuVpAMlW14NKUaVjNriaNyrCz0BQnfebK+PK9yo2bQvYlvvxHRKxU2b5NNgKbkKYXGpvXO9IBnr58K5pwoQYd9utD2XYfVnQ633Voo0E/nzgOAxhAyRapSrXMHY/BHB4S25g2ZtOYeo9v1vSHaQagZXLWWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hui6aJfi; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hui6aJfi"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so4804332a91.0
        for <virtualization@lists.linux.dev>; Tue, 29 Oct 2024 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270996; x=1730875796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9htrK+K47j7plwDzFY6/YbL058OrTTXAWjNvqdUBAiM=;
        b=hui6aJfiyhHsvfRcTRW+vKY6SN0eyJoeI2OUr+3HfuGAgJH1IoqPPhvfA9/ZVkWXVB
         f1ItEn67nEXYCHYHda2k6t8agdyX8nJBofP0cNUkz6owaHA1Lfb02ERDoynOS3W78A+w
         SDCikLYnKIh2GdtmIOdW63WJIFhqRh8quZhzncyP5gRx+y+Gcx0cIEqYqmMhTC+WgEvJ
         XSgyBCN5MfhA7k++UxO0/Zv+sL2fOmSBV1H/6+4uwRX25COZvf432dxyC3aQV7MPd6rw
         KOgjVg/Q3GWXSd44hwSA0J5a0mAfpQa4f074WAqBaf6jL8FxQAm23jvYAtrzkNpHG6a5
         YbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270996; x=1730875796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9htrK+K47j7plwDzFY6/YbL058OrTTXAWjNvqdUBAiM=;
        b=KOEaMMgfe/TOSgdGf3jBfEjkvvG0+RO4DnL0bViuaPiebt/R+tnLinKDk9m4JTkZ87
         uIlnIVbqv1MkVWDRJ25G8ZMu208b9wHpzGlmOFCLzpkb9Hlp1L6eZfZ/VcVPd7FjjvHu
         /QBeYvMiDMNECiuMGC5o5kPjuteE0zDGiaY+rnqeDvEHm8+ZG9k1TwzELfnm6lCzQUpb
         VZtUlGqodC838DdN+xXtP28HTcJhUplwDC3VsmhwXO7CyaL4FXCW9IA+HQ6Luh+H9Hl/
         39wO8QxU9ewNXZ44+2Cvh4UU7Ygpji5is5RLki9yBkoOPjm/9oEFbtKwbzFpDlDt5Yit
         20/g==
X-Gm-Message-State: AOJu0YzXKKwnoOVzp4pDYC/iseEAqiFghLGuJQy0yFzuMsBUgUjJIaYL
	E3LpUOI8dXCGL03X//4hsG8Mrh3w6RdzKfkqp863gxHebo+M+oHn
X-Google-Smtp-Source: AGHT+IG1g9EtCsXxXn/Kg/bVUnlmd7QEjXsIawXwB5EKSR6LpuCF6dIPqV971MOh+qh6EqqNoSYruw==
X-Received: by 2002:a17:90b:300c:b0:2e2:bd32:f60 with SMTP id 98e67ed59e1d1-2e8f11ac92fmr15554606a91.32.1730270996173;
        Tue, 29 Oct 2024 23:49:56 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92f90c6ddsm885993a91.0.2024.10.29.23.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:49:55 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] virtio: console: Fix atomicity violation in fill_readbuf()
Date: Wed, 30 Oct 2024 14:49:49 +0800
Message-Id: <20241030064949.6255-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atomicity violation issue is due to the invalidation of the function 
port_has_data()'s check caused by concurrency. Imagine a scenario where a 
port that contains data passes the validity check but is simultaneously 
assigned a value with no data. This could result in an empty port passing 
the validity check, potentially leading to a null pointer dereference 
error later in the program, which is inconsistent.

To address this issue, we added a separate validity check for the variable 
buf after its assignment. This ensures that an invalid buf does not proceed
further into the program, thereby preventing a null pointer dereference 
error.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 203baab8ba31 ("virtio: console: Introduce function to hand off data from host to readers")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
V2: 
The logic of the fix has been modified.
---
 drivers/char/virtio_console.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c62b208b42f1..54fee192d93c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -660,6 +660,10 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 		return 0;
 
 	buf = port->inbuf;
+
+	if (!buf)
+		return 0;
+
 	out_count = min(out_count, buf->len - buf->offset);
 
 	if (to_user) {
-- 
2.34.1

