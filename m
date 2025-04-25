Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBF233D9C
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565126; cv=none; b=KjLkQHmi1wouZxjlo9c9elXBCgD5JE9mwxZi3NX3HLCOaEOMK0cN62Sn3w57PeEcDzO00QtEHvTm4YEPWwCfpFA+BV4whIvdgwlc9Ry73GKHfecYi0V+xkAEDfDVUO7Champ8iLWLcdHFgO7ZKkdmAYmxxQl+RVtHYLjuasrOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565126; c=relaxed/simple;
	bh=fbFQYkrN1XH+y7ZVmfRanb5zZ2ao2S6rtD9w9lEiSmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIrgrMRIjTtSV9PxGwTZ7zvBGQWtlJKmUj6hUMVCm4AVgcK516sDMdc9LpsiA19YAsRIa8zNxz/Fnb/4DxwM0fvRUDEHBVSr5KatEUss7G9YQWmCvp4gLJh5ftr/WQmJ//A9odfv5XeaU7mXpCjNAi+XcfhbvOJNEZPUfwYK3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsHXk+iy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsHXk+iy"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3054ef26da3so1611409a91.3
        for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565123; x=1746169923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lldMq3GuKsNS7Tmp5QkmsxzmnppZ1kmVjOK5AIUcWk=;
        b=WsHXk+iyl1F8RVYurYk358o7kTGvQUgL0UEQqvc3pP2HZagslNrnmhZaRsq4S2APrn
         q0Tyx5aYMmhBHJGYRj8ZGg5H0sqPEhtyIrmG4hiQr2x9muDtz+++/nyg+izM6eF6jx84
         CgLnurk+PTIHXZX/9jNwqB0RBiTVBu5BvQFQcdpesUA5BWXpsu52ZQidFyXmnRW8bZ2w
         UcCBtD5AYB1Psyum8h71d9FEBf8S+p+oz2TjZJs5I08BRTTFtg8A+wkD6fQaqJ458w61
         sVk2Ai/OaFQO7uL5SOgFwSdhfg14P7m/mnI+EULRamN1QkO/F3Ct5OKdQCLdOOROI8Rl
         Vx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565123; x=1746169923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lldMq3GuKsNS7Tmp5QkmsxzmnppZ1kmVjOK5AIUcWk=;
        b=ORQs3o/vfJEI/tMucbHddPR91OkZai9Bt9i8iYjvfjne1hpVYsxS64XRbyIbQT4dZh
         paHEhW2LKm1DqWoqfznWBmXsaQE2L0yF/C5cKYUBSOR5wzYTgrjSGg3nzfk8JvNVMP4C
         3N5UD4EnDhStIscgQmhOXgaOiTp6nVXh4bgqlyxsOQ53lyC+X2Dyc4iyFkBjqlE2eb6f
         duWSvKdEe9ZL3RdCL1Eb5UeYQoLrrpnxUl2RJsJUcaxkpclDhumLwJm/Tfw2KypKZCYU
         RSiKpuLQhR3c87jEPS8qmc0TJA6kZ71rzjTqNalOv0CoxLEcEnsdT1IQIwO7WU/tQZRl
         848A==
X-Gm-Message-State: AOJu0Yyl4YwDBBYCL0wh70dEsptDWCzaqf9pw2N4h+kbiARkAbWKiUgn
	4sO3fEyuJfH1JL/E3KQ+YBAUiKBV85DNxCTiDZ7Aqy2o2tVuF+4JydjP7jEdenQ=
X-Gm-Gg: ASbGncuwBlmzpP4vlzp50lUP/y79T9FHwlSdpWFU5bWq3glVBnxR9yud7t4+1nGRFzZ
	7BTFrTLGz3dyswKrxKylSee5QrihALPxmZTyCR3RfhPpj0HDVgKmRcfVfEx4yiXNlSyiIu4v3bX
	8aCRjowQ2ndsGrx2mhRWPuHDV0UHhQYI/eEzq3Q1B+ed2B7tbfRJydOSiaBUKw8Ss13aWeH6ysl
	YXW/FI1XYSNdsGB+jveb4HzpyDx5N1NwEAgSoLEM9vWwYJGjCAuInLMuQZlYIgNuQhgqyk5nxuc
	hlHOyb+X4PHTvva/3XN0L4H8WtHsWA41dXfJlK3iTKdo4kUDn/BwgOVc
X-Google-Smtp-Source: AGHT+IGOLflJPiM1kAIV4XAg02lYJ1F9ADWNr/7fQCvJe3nlEDTR3ljD5CXGvcCmPzqN9F2GvEwZqw==
X-Received: by 2002:a17:90a:bb8f:b0:305:5f32:d9f0 with SMTP id 98e67ed59e1d1-309f8db391amr1240737a91.19.1745565122928;
        Fri, 25 Apr 2025 00:12:02 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:12:02 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v6 3/4] selftests: net: retry when bind returns EBUSY in xdp_helper
Date: Fri, 25 Apr 2025 14:10:17 +0700
Message-ID: <20250425071018.36078-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When binding the XDP socket, we may get EBUSY because the deferred
destructor of XDP socket in previous test has not been executed yet. If
that is the case, just sleep and retry some times.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index 6327863cafa6..eb025a9f35b1 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -38,6 +38,7 @@ int main(int argc, char **argv)
 	struct sockaddr_xdp sxdp = { 0 };
 	int num_desc = NUM_DESC;
 	void *umem_area;
+	int retry = 0;
 	int ifindex;
 	int sock_fd;
 	int queue;
@@ -102,11 +103,20 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
-		munmap(umem_area, UMEM_SZ);
-		perror("bind failed");
-		close(sock_fd);
-		return 1;
+	while (1) {
+		if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) == 0)
+			break;
+
+		if (errno == EBUSY && retry < 3) {
+			retry++;
+			sleep(1);
+			continue;
+		} else {
+			perror("bind failed");
+			munmap(umem_area, UMEM_SZ);
+			close(sock_fd);
+			return 1;
+		}
 	}
 
 	ksft_ready();
-- 
2.43.0

