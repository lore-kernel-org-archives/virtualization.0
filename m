Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286B6A33A
	for <virtualization@lists.linux.dev>; Fri, 17 May 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957184; cv=none; b=YtUq405anPypoW+ksQ4NdDI/3HC8WUGP32BJTd1w1zBgp/HIToOunlyQ5Z2QX6cwlSMDloYwuw4LC4GVpV0+momPTS06edEehPz+3v1xIXPLyfM9K/lziE6jJsxfvIXPKU533rGIz/QMmri4sD07UqUvDDw4G49taY1Lt4oAUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957184; c=relaxed/simple;
	bh=j2/GYQH+YPgVz6Sz+FMKMs1AQ1hkT2Fqf7GxI/sZoUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfdN9GVuU4pzQHtveK9uUHxXVyhtWjrZ6NRmx9WpgmmvkrylsW9ekKkRLhcGdM4vbn7qwnZ/td5S3cT+CCZqCwNadZQcJKPsa4nIkBTKyzpGpGZ6wgEjmuh85+xxuh8XpGZlkZghO+goiMubtqSegTcEl7GMPoz4nSWNgmip0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNrLyFyc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNrLyFyc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so4554315ad.0
        for <virtualization@lists.linux.dev>; Fri, 17 May 2024 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715957182; x=1716561982; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0yGtcKEuophyxuK9PPE+gmzXonmfacqDZH3bhCr3sI=;
        b=QNrLyFycV08UFzpAv8IrPYmU39iWrT28McCebjNN420tqhzYktC25v4ZhVwKGzuPBk
         GeWGJfup6PwqmPWAWa4RvbcfiNPf2KuQTBSjk+45/MeyLWyEwhMJPckCpvdWkV0QFzkV
         QTSnMwxNc8cQ6OzI8C7AK4H73Ra0Osm5m/ZMtKRcIEwqYzk/4QqaHXq2IatFdcG7MnR5
         8m6IxHxt5mXmQv2BSoI07cMWRty2zWZge5pp83rS4u7Ke+NhaYbKttB/q+2Ij9kK/MYB
         WL847TkHu8886i18prhbW9pv9i0woS6OW1mcWyD2bpHQK4FunLKYRt64kdXCs88SiXcX
         Hrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957182; x=1716561982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0yGtcKEuophyxuK9PPE+gmzXonmfacqDZH3bhCr3sI=;
        b=iY5xTjo04FOO+ZzMl/d0V+83P1M3ooI6vZaxDnRMVBp1fEzS0f03IvyYa15a8IBOL6
         DjOnSO2Wx8rLMHTf5P1tVLhHb+k5Ct9BvCkO+yQbAQEaAoJbv7HU7k4Aj78tf6H3n1q3
         pqjCdt1+CzCxaR70Poxiff+CDsZp0fEGrFgzXhGbScLbxvrEAQBFPosxjryw7DfF8bSC
         o6cr2qpMX0TIT0CvBJup0O2q3q3fZB4gxeljqB6kccwC09ylbPpzi0Uq92RAHtpWo37O
         wlb+SThCsxgDP0kALyF2G01XsgLsMS1PuVA0KfzNY2r5KW9D5ScxhdRKYhOSTwn91xnv
         nYGg==
X-Forwarded-Encrypted: i=1; AJvYcCWGXoRCVhT7o5UmjLOs19Nk6uboJY9yLZocy8ElVEZAWXKUkB+CQfdlkd7+n8Ci83xIcyf0QM1mrsGmWMsw2lnK5sk3lgJsVTZuXmU+9ow=
X-Gm-Message-State: AOJu0YzjslYTwuhAqpNJAXgoMVjXQPpbufIkZtc2hxW63r5tGmBOn75/
	7/BLy8sKL5mEs9Sh8D5iM37Y7XngqpH4SsNtIDT8H2c1VXrLJeU9LR5j8IbJ/PMb51Vf
X-Google-Smtp-Source: AGHT+IExbl8LrLvJPyU9pKwjp5uruGM2OzUlT/MtzqGW1/+10hqCuUEFamttCWLYKNGTxD89KXVlNA==
X-Received: by 2002:a17:902:ea03:b0:1f0:af34:6fa7 with SMTP id d9443c01a7336-1f0af3472d8mr66089495ad.10.1715957182587;
        Fri, 17 May 2024 07:46:22 -0700 (PDT)
Received: from devant.hz.ali.com ([47.89.83.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c160a1esm158504985ad.279.2024.05.17.07.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:46:22 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	davem@davemloft.net,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [RFC PATCH 1/5] vsock/virtio: Extend virtio-vsock spec with an "order" field
Date: Fri, 17 May 2024 22:46:03 +0800
Message-Id: <20240517144607.2595798-2-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "order" field determines the location of the device in the linked list,
the device with CID 4, having a smallest order, is in the first place, and
so forth.

Rules:

* It doesn’t have to be continuous;
* It cannot exist conflicts;
* It is optional for the mode of a single device, but is required for the
  mode of multiple devices.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 64738838bee5..b62ec7d2ab1e 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -43,6 +43,7 @@
 
 struct virtio_vsock_config {
 	__le64 guest_cid;
+	__le64 order;
 } __attribute__((packed));
 
 enum virtio_vsock_event_id {
-- 
2.34.1

