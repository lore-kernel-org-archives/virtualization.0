Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826F71B27
	for <virtualization@lists.linux.dev>; Fri, 17 May 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957196; cv=none; b=prddjMgl+uVB7vpaUE3TQxlLH89LCIm3tWOFuyfr4sOysEYNZMiM6nfTRKJp7HLKR7OnTESH4aLeGqzaSigX4z6CrtVOel9A3g7ZmKATnVp0+PJd9xm2vMuVCFC6wT3VypKzWreZIgT1jrN7buhHDLq7k0pAuPjo3EEFIQ20tUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957196; c=relaxed/simple;
	bh=WnxVwjgYGJtcoPZ87tCxtUxpJqNACgXajD6ezrDCG4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eh3ia+mZJJTMNG3+hHLTKvpUQbdfPyuufT5X0vyZSrdtkQjEuGa01fAG55onTh7SmBzRk+1zoWzrt6Za8+HO+w/uoUXGSpx8Yg59A9EQWSkUgBJQNpmvj/XQHgtvcKIklmda87vKGsI3dFPV10eRUrvyqtap3ZMx2YIw4dcEjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHSBM3HE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHSBM3HE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee0132a6f3so11457035ad.0
        for <virtualization@lists.linux.dev>; Fri, 17 May 2024 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715957194; x=1716561994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1E5gdZlICe3lq/gDwWvHR3o2K94KvkxWORr8jEuKK78=;
        b=OHSBM3HEzH++zHzKqRfJ7s4SRktvVwc8FEJ2hZ7IIvRhmExIZSJ0cUrfw+2Ow8jsz5
         tuZwZIXuiHYSSt5FbfAas2ZY+ILz9McAgwMkcPbaXip2F7ljNpZghQI4lM3fMHaVRO5g
         TQyUaMrOs9sYEwc/TyP7J0y0elrEo/xDH9NnnFTzBLVREvQyrYRkCrXPw5bDL2av9lve
         tdXAgNFYVaQyoRtymAuOmsUG6O+YbjvV64Of1FoFThMVhRxkf/A6O2hlytx7b9k5dsBX
         Z0vzlnOTVyWPVafkI0VLtGlv1CtFZVH3ToqmkPC+V0rDoqos7ftxjMpqU8ItgUy61EKl
         v81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957194; x=1716561994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1E5gdZlICe3lq/gDwWvHR3o2K94KvkxWORr8jEuKK78=;
        b=YUNzOULdeOHyLKn2I9cx/L9j8RqqxN3RUehdJpUrvVWvMdp1dgVuyeM5Ih9CobpIAn
         bOn0AcaI7ZxCibUY2eBV4CFGlKmQskhY9DJ5ZMoxrB/g+PRBVIPG0eNFQTrmmY/JL9bT
         rudZ/vLz6AmmE993CXdV24N69+TykAN5rJRnPLRqXZnnyLct3TUzeuth2NQHECbOIr/8
         UGegUIDqTtFQBMDDdhOw8McP395kCEw+NUOHJeAQMFhJK1KCoRBhSi1FZdZuQkjK8+C9
         dXluUIOCjqDZFo9BcbTgpJQrFEdwzyD0BxL9O1uu1PxriZ54lqs9PrLT+IvcXRFAsvJL
         JBzg==
X-Forwarded-Encrypted: i=1; AJvYcCV3iWai0WTGiUs70JlELB6KhBHuFLjo6NnV5CmvQKb4PPlhlif4sSJJLIZW785Nsa0Lgo73KDNSyro5UmHL1mMUSYs78lmCq4yXJMZ86hE=
X-Gm-Message-State: AOJu0YwBNA+S9PcExs1uwFxzspSDF0PLKhp1yoGv2gDSCDvlLzLjUFfg
	+STa+UmZBjxDFTytyVl4qKnneWv0t0ZLc1KsAPZhdf2HXPTQsbHA
X-Google-Smtp-Source: AGHT+IGlrB2ABZOfxviKuEq2qAGBP9HT0HFRenQskQ3kOdrAUJQmjATvt0uOz+tRWRqVGbrjhLcsCA==
X-Received: by 2002:a17:902:e889:b0:1f0:9938:d260 with SMTP id d9443c01a7336-1f09938d438mr74524725ad.50.1715957194441;
        Fri, 17 May 2024 07:46:34 -0700 (PDT)
Received: from devant.hz.ali.com ([47.89.83.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c160a1esm158504985ad.279.2024.05.17.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:46:34 -0700 (PDT)
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
Subject: [RFC PATCH 5/5] vsock: Add an ioctl request to get all CIDs
Date: Fri, 17 May 2024 22:46:07 +0800
Message-Id: <20240517144607.2595798-6-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new request is called `IOCTL_VM_SOCKETS_GET_LOCAL_CIDS`. And the old
one, `IOCTL_VM_SOCKETS_GET_LOCAL_CID` is retained.

For the transport that supports multi-devices:

* `IOCTL_VM_SOCKETS_GET_LOCAL_CID` returns "-1";
* `IOCTL_VM_SOCKETS_GET_LOCAL_CIDS` returns a vector of CIDS. The usage is
shown as following.

```
struct vsock_local_cids local_cids;
if ((ret = ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CIDS, &local_cids))) {
    perror("failed to get cids");
    exit(1);
}
for (i = 0; i<local_cids.nr; i++) {
    if (i == (local_cids.nr - 1))
        printf("%u", local_cids.data[i]);
    else
        printf("%u,", local_cids.data[i]);
}
```

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 include/net/af_vsock.h          |  7 +++++++
 include/uapi/linux/vm_sockets.h |  8 ++++++++
 net/vmw_vsock/af_vsock.c        | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 25f7dc3d602d..2febc816e388 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -264,4 +264,11 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+/**** IOCTL ****/
+/* Type of return value of IOCTL_VM_SOCKETS_GET_LOCAL_CIDS. */
+struct vsock_local_cids {
+	int nr;
+	unsigned int data[MAX_VSOCK_NUM];
+};
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index 36ca5023293a..01f73fb7af5a 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -195,8 +195,16 @@ struct sockaddr_vm {
 
 #define MAX_VSOCK_NUM 16
 
+/* Return actual context id if the transport not support vsock
+ * multi-devices. Otherwise, return `-1U`.
+ */
+
 #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
 
+/* Only available in transports that support multiple devices. */
+
+#define IOCTL_VM_SOCKETS_GET_LOCAL_CIDS     _IOR(7, 0xba, struct vsock_local_cids)
+
 /* MSG_ZEROCOPY notifications are encoded in the standard error format,
  * sock_extended_err. See Documentation/networking/msg_zerocopy.rst in
  * kernel source tree for more details.
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 3b34be802bf2..2ea2ff52f15b 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2454,6 +2454,7 @@ static long vsock_dev_do_ioctl(struct file *filp,
 	u32 __user *p = ptr;
 	u32 cid = VMADDR_CID_ANY;
 	int retval = 0;
+	struct vsock_local_cids local_cids;
 
 	switch (cmd) {
 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
@@ -2469,6 +2470,24 @@ static long vsock_dev_do_ioctl(struct file *filp,
 			retval = -EFAULT;
 		break;
 
+	case IOCTL_VM_SOCKETS_GET_LOCAL_CIDS:
+		if (!transport_g2h || !transport_g2h->get_local_cids)
+			goto fault;
+
+		rcu_read_lock();
+		local_cids.nr = transport_g2h->get_local_cids(local_cids.data);
+		rcu_read_unlock();
+
+		if (local_cids.nr < 0 ||
+		    copy_to_user(p, &local_cids, sizeof(local_cids)))
+			goto fault;
+
+		break;
+
+fault:
+		retval = -EFAULT;
+		break;
+
 	default:
 		retval = -ENOIOCTLCMD;
 	}
-- 
2.34.1

