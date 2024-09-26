Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9170F34CC4
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367493; cv=none; b=jXHC3JNbnQE6Sx0gWVJkhz1KtOAdgcqzEglJyMPryul/D7vdS6K49LV8As84WMUEZqxOdvi6K4K+I9mHqDmAqYXzRPWYLIYSVeHl+Ri9H8WRANpWok7k+22laSNNmSaq1Hqj+L85c6WXAARx9IYgMdfWeZLy+/w1sbxeuMqeHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367493; c=relaxed/simple;
	bh=7gDjgu4wElEbQxuDgDh35dLOIRlB1xp7/51JxMwantQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IoTVEzppymJI/BkksVs1kFVsTV2wMI7WCt03fexmVlXIdj+WgiW0YlLwMyay2OqWgrnZPox5d7MB9998k+SJU5+DWP6Vp7+5aZq/BQUCrFMMGsIOwbpRHcyfXc3+fcyWbWHYwqCFOiPpQj3bISPJ1f+hsO+nMm+sHdbqZfbmE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=d5oMn7Zk; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="d5oMn7Zk"
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6056B3FB61
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727367447;
	bh=b1Yy5Y+O/8SNdOfIY1NdJ3kg1DxrF1aZEa29oc+RxsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=d5oMn7ZkGmQOYoEG7Rw9NeOcHvif0Cxx50gJ5SB9zT1RDW+XIRgNVZCoVNVR8kNMX
	 W261SAomYKfrStCo7QwKUsNWwFVAvK9yFYmg1/d/A1Zgg6yYJv0nmdpN8jZ5GM5MKW
	 ASB4ivIH73Ni/DsIUAHHOTm+ncuy0sTGHsUvgXQYyayHXjzdlhd02xAdD+saTnldcu
	 bex5Bli3q4NcfyvI7OhRk7Rxr24XImTI2ZHRlmFug3+9ere9mDVFhKT5ZQDpfuS+M2
	 rq9/X6D8Te52o9YJT5xAYzI9Q5snMcqOxLdgBis4VhLIOhAn225MVif2JAvG1IU0Kn
	 iJUjHWY9Wu3Sg==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso10988895e9.3
        for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 09:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367438; x=1727972238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1Yy5Y+O/8SNdOfIY1NdJ3kg1DxrF1aZEa29oc+RxsM=;
        b=ntxKhYt0ds7UsVyc138JcJeDlzEUdpvd7yR4nluvP7G++cteNl/a370Rg/gdgd/IfE
         DQsiwauo/1KdHgvSuefnk5i3ddYNy51e0qYiTOrPQSktd6VG58+kqGr0CwfQKxOrfmIM
         zEgUqfJjv1p7Yx+A7rGUEaj7n6Urp1lRQzoXTMh0ObzE9X04+FgAL0LgOgraphB6GbOG
         H8jevVSRHxyDfsumcHUWSRu5QJPpIj6ijo2H5HmNskYtTAKYNQp7wPhk+JALqNZTjmP9
         YaVqIKEpso/DmVaucfZsaSk+r42jFysRGEJaambN35Zo8gjXyMFK4zBvLQPkNWOcn0VV
         inDg==
X-Forwarded-Encrypted: i=1; AJvYcCWjTr5GIFvhp/QCDX+sNI9dyIkDhvbsLBQgVKKYl8L7arxiubHlv33fXFMHRITSr+B8QFF9IbEAddcSCUVrow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4IBX+SCIVDRwAFfDWtRONCMNV5twc60Yd2ZK+04ZcpMsMUo4K
	LOaKZuWRUrYsll+5tywngBiZCuyB5/ULFy9ieTh8zFCAkSJ2QWnYr3bRuSMwVylh09QRciOrN0D
	YkASFrUOuz9LtYEM68XZOROiToq+CvlhrUcf5ELfLIbmfn+QlBCns+NEpgUCPhz3OMD70Kv2nbM
	G+WDWw
X-Received: by 2002:a05:600c:1d88:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-42f58433478mr169555e9.8.1727367437785;
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzaX27OdIk12RXul9FuGgRDD+iCxKpGs0uDOQekLQVHE70zEjsFFHKV6Qz72FM1jylL5Re6g==
X-Received: by 2002:a05:600c:1d88:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-42f58433478mr169345e9.8.1727367437454;
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2948231sm14104266b.99.2024.09.26.09.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:17:17 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: stefanha@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vsock: specify module version
Date: Thu, 26 Sep 2024 18:16:40 +0200
Message-Id: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explicit MODULE_VERSION("0.0.1") specification
for a vhost_vsock module. It is useful because it allows
userspace to check if vhost_vsock is there when it is
configured as a built-in.

Without this change, there is no /sys/module/vhost_vsock directory.

With this change:
$ ls -la /sys/module/vhost_vsock/
total 0
drwxr-xr-x   2 root root    0 Sep 26 15:59 .
drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
--w-------   1 root root 4096 Sep 26 15:59 uevent
-r--r--r--   1 root root 4096 Sep 26 15:59 version

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 drivers/vhost/vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..287ea8e480b5 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
 
 module_init(vhost_vsock_init);
 module_exit(vhost_vsock_exit);
+MODULE_VERSION("0.0.1");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Asias He");
 MODULE_DESCRIPTION("vhost transport for vsock ");
-- 
2.34.1

