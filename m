Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956ACB660
	for <virtualization@lists.linux-foundation.org>; Mon,  5 Feb 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110404; cv=none; b=am7XSW1qkuTu95NcEnrQT4ISgWPeq+8ehpDrKVJsxM5HzGRPOTPBYlVbpEFapcQcwP3Qf9ZibJaJH+S5hwGgWZdMYPZIT9gnhlJsVHniZQnzFeOF4Mk6BJd50Rqz7XIREyUASYjqM7z4ZW4WS7TlO7sGSbwiwWqytKHHDCNJYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110404; c=relaxed/simple;
	bh=b/F/IvZJvxSYV6yT8GonNahencq0VCJX3syNSsaFNgM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dk36QzpnBj74xHQYoQ/GI/oWyd77RDekrkV8OGBu3ZH+apEOlc9FSligmcJOiIEhir0Z3PJB49SvFvCr89/Ufs+NfIFy+n1BfnAtEn5GSxYgRxomaOde0LJH8m6dix8o6iURDl46Cf2qy6ATl+OR+pEjRkwCd2BzL0lnj+sryOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KtWF9kZG; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KtWF9kZG"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21B1340466
	for <virtualization@lists.linux-foundation.org>; Mon,  5 Feb 2024 05:20:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21B1340466
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KtWF9kZG
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k1zP8FWLURjy
	for <virtualization@lists.linux-foundation.org>;
	Mon,  5 Feb 2024 05:20:01 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6E5A240540
	for <virtualization@lists.linux-foundation.org>; Mon,  5 Feb 2024 05:20:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E5A240540
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5d8df34835aso1803083a12.0
        for <virtualization@lists.linux-foundation.org>; Sun, 04 Feb 2024 21:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707110400; x=1707715200; darn=lists.linux-foundation.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW5zoXaotbxS+SYq2Yu+7hcfyLit5t9UvVc+9SbtbuU=;
        b=KtWF9kZGAXd6v+PtXkn6445h2sRdI3x/tT+O2rI8HESLSxe0xnIaUbW/oKwn3K8L4S
         myiuLJk0z7y54fPhkCk1T5eKYjzGuwUVjn7SPsuTKz0/WE5uqjnce4/XWCaqf9SWfeqT
         RQiTLgG+ZfbGGHTkcxP+00uWN9rSMP1JGc7cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707110400; x=1707715200;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dW5zoXaotbxS+SYq2Yu+7hcfyLit5t9UvVc+9SbtbuU=;
        b=Aa7sdI1KSPkMhe+fXUSef40SshonrD3iu4LU01peBlCEAcIKpCVV09LLCSgRPjcoDX
         sVg93vwq/Ppsm2tLCnZZ4VO7510h7ZFVqsQBdtXbOnhooekarKi2/QFa6rhzPEdTMtvg
         D2PxwIyeWsrEx9CV62OSXEhhoEzz0waCSqDeHHnDzWjmF1k4af4J+IWsnuH2pcyId8T0
         LBaY9isCCMR9QDAnMto0RkaTYmncSdGPSq5MLd4o2ql49+mrkq2W8yZdFxBVlV6ReGSc
         pEtdN5ytyZPyoqqUIb+HaYBzGnFt0BpVrkdWS2/2oVwQ7Ob/wQ46d2koZ8cRtSJYi2hN
         Ys0A==
X-Gm-Message-State: AOJu0Yz2kRjBuxNFSXikOJEJ/2gyuU3nrKa+esTfXQ3KHAaY20RMwLU6
	kURfeTkDqgji7wOqEmA3l2K0+axzj0uzXxOiLorkOxGUXdR8ssZMdd98eJqvPg==
X-Google-Smtp-Source: AGHT+IF9ggkIkGzgeO3uo/eh4fyZDfJpqokYxDxSkwePH8H9UgegtHqrBxC2F2NZ8p3jAZTfYMVDNA==
X-Received: by 2002:a05:6a20:d909:b0:19e:5e0c:3bb8 with SMTP id jd9-20020a056a20d90900b0019e5e0c3bb8mr7970208pzb.7.1707110400605;
        Sun, 04 Feb 2024 21:20:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW49LbvIWU+foFA9+KIxmqctHvrKIaSi1hkNesPGFRM7R9cegKJcmHbSFXi3GzjE/YdnB5Fl/OpeO3vZzMH5DaqL6KSgHIyyvlhIQUpyRQReWw22hTiBxoqktD8Cs1h7bN/Cd/Brw9tVOsaoCiNwdisW/3kqqmoiX+5XZTjDIqgn/YKopHvMH6THCVhQxwRn9vXhafxdhJ7MbNsEh9Z/9YUHTbcQNqFSa+eN44LDAwcUHy+/tAEd4rqQbdLVf1pwFbD1iIlD/rVOCG5lAw/zFeMPiZY9dZ2IBAaMoBOvFsYb/QRCnW7ICYfQ42h28TqV1bbU+64mlT2XlHJn9yY0theGA3HEUVu3iIEwKYlsyLO/v8F+HDPf11iYfXrGwhw7dYZ7Am1PDIbpWcadF12ojDSrkZSe+UAP7aKohAyjC+TQld5Zn/uBnxO8g==
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78110000000b006dd84763ce3sm5612953pfi.169.2024.02.04.21.19.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Feb 2024 21:20:00 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Prathu Baronia <prathubaronia2011@gmail.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH v6.1.y-v4.19.y] vhost: use kzalloc() instead of kmalloc() followed by memset()
Date: Mon,  5 Feb 2024 10:49:37 +0530
Message-Id: <1707110377-1483-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

From: Prathu Baronia <prathubaronia2011@gmail.com>

From: Prathu Baronia <prathubaronia2011@gmail.com>

commit 4d8df0f5f79f747d75a7d356d9b9ea40a4e4c8a9 upstream

Use kzalloc() to allocate new zeroed out msg node instead of
memsetting a node allocated with kmalloc().

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
Message-Id: <20230522085019.42914-1-prathubaronia2011@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
[Ajay: This is a security fix as per CVE-2024-0340]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/vhost/vhost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 07427302084955..ecb3b397bb3888 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2563,12 +2563,11 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
 /* Create a new message. */
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 {
-	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
+	/* Make sure all padding within the structure is initialized. */
+	struct vhost_msg_node *node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
 
-	/* Make sure all padding within the structure is initialized. */
-	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;
