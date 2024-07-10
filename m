Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E315ECE9
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646767; cv=none; b=sfBgdMD1iy5CpRYO4K54GxjzhCpnrpOOTJ1ImrE0BhTIP9nDp0666dCe87TCFuiBW877sjVyPqZMhU9ccIRlhYwNBYJ22Ubpckpw0bQh3D7QB+QE6AvHcw7VJhMYg52jl4zm0MvxFw4LgGzRJk74xpJQJxxzeXKDVR/c4IhuGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646767; c=relaxed/simple;
	bh=gwtanEC2pGzN60xOeGZgf6/7sgGtmktz1APYPkOQvwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1T5G+ryxD4ZPflLsTyHZY19hF1eB3smWXa1WE82BXjp4HXF8IVfEy5nOXAzVpo+eMF6JkwUtAs6rSBQ5LoGhjjNhBSehjfZQEidUjeiunHV8nQlmC2ox9J9KgvdTBOnARj4U7gCvmaKo2ySDHExi1eM3t2JMCyhNYH8jzIr8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmgm+jxC; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmgm+jxC"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 255F940249
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HN-mXhEZfIc1 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:26:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3930D40126
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3930D40126
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bmgm+jxC
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3930D40126
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:26:05 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-79efbc9328bso16545485a.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646764; x=1721251564; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmWB6RITNr1rCqVWevMLNgD0qATYDnpZgKWdiv490xA=;
        b=bmgm+jxC4iYMQ1otzywauxdKg4A7yAZMAnvrZ4T0YtC+Sc7oFFN/IvSl7oLt8z6Jna
         QyYDInsAWL00xhSkbwFFIwvuFW4gI1liPepPtTf3qB1A2U3j8cq3mTHgzxd8uM1OmwbC
         G1cnmUDYi731L8oSCGb6qmnRNUUeUABAj0G60p8R1PiVknouUcdSYYjh+oQrl0EfVuqf
         44BVHHE8j0jxLF6uTQ7+E3TEiQ7IwDq6ZmQ6KwocUtN9Ov5meNBUyvNX1tEJWe6eY7Tb
         /s7OEZti0/9Dyux2Aj2FEyJ7FQQD1v2z7r8QL6hhDiZMAIa0dKl3ztW7jKPURJOSAyc4
         qA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646764; x=1721251564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmWB6RITNr1rCqVWevMLNgD0qATYDnpZgKWdiv490xA=;
        b=i1F3B2oaKRPe36FIEP9tuI9EZ95nU+0pf8IFmn+k8Fcty6MjjeendoQS3RNYxDZ89e
         eQX2CVvQCpVjCVlXXWBYthzPsQPIToqWeBB+WvSWeDgnZa2zlSnQegCE/uNifKVsxDTd
         l7Iiaa+Qmkj8lMlrXNSU6lwFrdCG5Bo2sqKtgkidDAl26Ptle4xVykBPZJcfFdlzD9ES
         fmX1BsyL/26gFaFR9JIHAJEGLqH3BdROOThbI9Le51AK+jeTnwRaDPpuWW8DV/Bk36Xk
         hXsJ8WkVevu41Y8JlLgoAtYmJAXBx0ETWTBoYhKHFw4TlYHQG7rx3p2qOvLVeCwnmVtU
         C/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2VbRxdvjOIK1uXeN4WplYezusILBhkGVL8Wv7XiYsfIqGej79oNmcy8GnuFnal6YiDKLdfIvWElIVB5ZkL2UUsgbmbx+6lBHO9MXZ+PSeoV7uBvA6A/0XWA==
X-Gm-Message-State: AOJu0YwTQsOzId6KNw9VDrJaYTonxythWU2gf27pTMVI3M7XfwAIHtzf
	9VjLPAgcWCneJs55dXWykudjLSmRjQdQWCL6F7Dzc7Be8wbRIrg8
X-Google-Smtp-Source: AGHT+IG777NGw+WgU0m269DXuwpGYmePB845UKK+Uaz17xBp/iDpuOJlJWqnyMj0N84ol+h/zJHD9g==
X-Received: by 2002:a05:620a:51d4:b0:79e:ffce:47df with SMTP id af79cd13be357-79f19c023e0mr644384385a.78.1720646763945;
        Wed, 10 Jul 2024 14:26:03 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:26:03 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com
Cc: dan.carpenter@linaro.org,
	simon.horman@corigine.com,
	oxffffaa@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org,
	bobby.eshleman@bytedance.com,
	jiang.wang@bytedance.com,
	amery.hung@bytedance.com,
	ameryhung@gmail.com,
	xiyou.wangcong@gmail.com
Subject: [RFC PATCH net-next v6 10/14] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Date: Wed, 10 Jul 2024 21:25:51 +0000
Message-Id: <20240710212555.1617795-11-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240710212555.1617795-1-amery.hung@bytedance.com>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bobby Eshleman <bobby.eshleman@bytedance.com>

This commit adds a feature bit for virtio vsock to support datagrams.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 331be28b1d30..27b4b2b8bf13 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -40,6 +40,7 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
 
 struct virtio_vsock_config {
 	__le64 guest_cid;
-- 
2.20.1

