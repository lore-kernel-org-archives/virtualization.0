Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD983AD512
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323936; cv=none; b=bplZrzJDpGsIQiV4/Lnyr6EDT+riJeoTzNRQmTAidf7FGj6nLBqqW/amORuMVq885bd0RKTkbEWg33gEnvD1LtC6KzhOanlsLFsj8XqFBmwy8vf3K/VS+ckMe7gGvSqBF7hciRloKyEMAUhqgwW7HnjeQ+vKbSnnTjmxv5qVbAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323936; c=relaxed/simple;
	bh=Ugm8WCGysL1TqNZ9kVuOjPA7o8an4dn2pNoHsUMf2pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgDj7ev+bzde2eVTqL0RJZsWRnJYeUAczbvpp17e2yGaEaySHA8gQmQRN87T66lrA7wn6Q8jM/A8erj/jlW/la593ba/BjqP5kS5WxIDnMnrGCW+p/FIeWVjYK64JAAODv1YzMWkQRXQt0X43N88hpp/iLA8BwjMOewuQwAH+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNJohiYW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNJohiYW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso13246035e9.3
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 07:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323933; x=1780928733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MM4H2QoEUgarLx+0eAaW26X/5qxtOWLy6/mU6YWXbr0=;
        b=oNJohiYWln2F/1s4wRMFnkfJlx8xfFtArTdA9N7srcvEvSyrsjZ49ek4TyckGjFy7x
         cL5XdN0zcP85+T2HWdexHaZDC8GXIYZopCJ85KDyE4UaLcBIarBItU+7Pgj04FzsOJ6e
         NqorCf2WXhDdau05PKTBA4kn1cyx+Vk/LdNomqSXHSd3s2x3zAQnFSue3WKMKJfMGHjs
         LTZOIFtJwYbrBPKzu9QYLTWXaQ5BNGeAHzsgdoMg66UCdJBu7OD7wQgqrt95489jqoHH
         B3dgP5CrUU4s14sH+jVye4ZTru6Ykr/k6C/XCVCNHCoJ5XRoWp4hFrNY1AH+X7mLl/8a
         ej2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323933; x=1780928733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM4H2QoEUgarLx+0eAaW26X/5qxtOWLy6/mU6YWXbr0=;
        b=BEHaDqPnGegQAuLCy5sagtHgB98ekPK9dygzHKJmaKsmRnkMsDaE0qlsTElc/eIIjw
         Sa7AvzGy9fghtYw1JMzkaSV2pgX8MDST3jSTpzr/UE8X7VynbpP7Ul7H2DbFajRH/Rwa
         1E6n+GYdJ8fCoTj0fcAO+4MKQdcOwcKrklj7GapCmvPhH0izsvsFcVlKAQdDYxk+ghUY
         I7+/OCFJFZIb6OGWXPBFAKW1rSW975fxXi20NSIH/iv2I/NV+oDgv7Gmyelpnm18zDuF
         iwEfO+tXhSzf+I7S6oFSh9/8hh39K5jXJc2fBV8HuhH6E3sfe8JWSmbKhdYkvJpcH8Kq
         5FRg==
X-Forwarded-Encrypted: i=1; AFNElJ95pnjwrHBZKvKYMNv4ZGNfckgZWbjok6cg+qCm4vq3PD519I2BdRgOojKe1malT9XoHaya82j+OKt6V/am4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp7R/Hyqz3oVWmhOasH2E2NSwuH/1Nug7xwHOEF1wBUduxw6ZE
	RbApvQQa99YtjT1eeTPove9IE+V8WZKXG0ghzfWGiqKmpunoFuZWFus6
X-Gm-Gg: Acq92OGR/y5ZLoC79XnfkS2vQgCFuSj+vdr8kR/d4yOfhnL2SNvz4mmY+j6Qalbq/z0
	oLnlVHFBE42eRMu4hAYKeBU47ExfZvWBhHX9EnMSiCiuU/f7vOTD1J5giFtqFz61S9j/sRCCHpD
	sjOUloIi/W1sOwruDdhFahrC0FqcbWxwbSn9qeUFv+qAlTeND2HUt91jqiA2Q9WoaTe3G+kCLIm
	peYETchqox57W5sZos/8beonldQSc7yf2bR2njVjKkGWCYrGh/LwtpKJKj1jpb4mM3aP+byzUoU
	G/MoqrUEjTV0ZyisrFACI/WmeePelNEwUwsGMDPTi6J9iL6u56dbs0dUnLRR8+bwox4CpK9GywC
	JtyDu3krgZsGEMC2k6CDAoWUFGr/ybR7LAMh/98pTozL/ekn4NViBqp9VdV//jQScIgFReLwOKP
	lU5VlGygI5aGBZde8RZbhNPHotYzjcYngkr7Pl4e0F8kyc
X-Received: by 2002:a05:600d:640f:10b0:489:2005:b36e with SMTP id 5b1f17b1804b1-490a2941d4emr154124805e9.19.1780323932800;
        Mon, 01 Jun 2026 07:25:32 -0700 (PDT)
Received: from minipc ([185.128.9.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b47eesm27898283f8f.9.2026.06.01.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:25:32 -0700 (PDT)
From: Goncalo Gomes <gomesgoncalo@gmail.com>
X-Google-Original-From: Goncalo Gomes <gomesgoncalo+linuxkernel@gmail.com>
To: amit@kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Goncalo Gomes <gomesgoncalo+linuxkernel@gmail.com>
Subject: [PATCH] virtio_console: clean up port name sysfs attribute
Date: Mon,  1 Jun 2026 15:25:08 +0100
Message-ID: <20260601142508.3740862-1-gomesgoncalo+linuxkernel@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues flagged by checkpatch.pl:

Replace `sprintf` with `sysfs_emit` in the `name_show` callback.
sysfs.rst states that `show` methods should only use `sysfs_emit`
when formatting output for user space.

Rename `show_port_name` to `name_show` to follow the naming convention
for sysfs attribute callbacks, and replace the open-coded DEVICE_ATTR()
with DEVICE_ATTR_RO(name) which encodes both the mode and the expected
function name.

Also fix a missing blank line after a declaration in free_buf().

Signed-off-by: Goncalo Gomes <gomesgoncalo+linuxkernel@gmail.com>
---
 drivers/char/virtio_console.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..56bf0f1b8a00 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -352,6 +352,7 @@ static void free_buf(struct port_buffer *buf, bool can_sleep)
 
 	for (i = 0; i < buf->sgpages; i++) {
 		struct page *page = sg_page(&buf->sg[i]);
+
 		if (!page)
 			break;
 		put_page(page);
@@ -1237,17 +1238,17 @@ static int init_port_console(struct port *port)
 	return 0;
 }
 
-static ssize_t show_port_name(struct device *dev,
-			      struct device_attribute *attr, char *buffer)
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buffer)
 {
 	struct port *port;
 
 	port = dev_get_drvdata(dev);
 
-	return sprintf(buffer, "%s\n", port->name);
+	return sysfs_emit(buffer, "%s\n", port->name);
 }
 
-static DEVICE_ATTR(name, S_IRUGO, show_port_name, NULL);
+static DEVICE_ATTR_RO(name);
 
 static struct attribute *port_sysfs_entries[] = {
 	&dev_attr_name.attr,
-- 
2.54.0

