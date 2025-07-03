Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA2B676
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541821; cv=none; b=i4pf602SLoWLoqiz601S/5kf7d9vTZC3JPHlgcoMM7H5J4EmXi6Xi1mv2O9VhPFlhChPeWIQLjAZCqng1DRD0k+Ex61UBkJP5qpO61I6cgsZCdwafmTLDB3XU7LkBBUZGrWOHCdMVI0vjg/CnuimgEj2wMVI8kt2aZsVI0ziojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541821; c=relaxed/simple;
	bh=qCJ/Od0uSXuN2KvuQPi0q2CGVCbCbEn3umxbnY7hirA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=XMu8K47QCsI1GLMQCzN2jWGxxA4lK4aT0w+MWEQTCJ+RM8V7uKsaaNfUoJTvim/JQwWFbJAyIjV3lvLZPmRzhKgicPyKV4W287ZjLlrMd05kL7l82XCtvr22u0BZVkJySC1Jz2rUvrMfvN4CjSakdpKcV7o0a39ERyxi4z/GQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWGaTUUv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWGaTUUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751541819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PIJzNJK0FfXDsC5luatCe5NaXC4y6NbBybHk8bPHUtM=;
	b=UWGaTUUvoqWbNLvBbShYMJDDEXhO+xe1yzCl+A1sxeRISqMc+K8HWDZWa+7hCpy96ylNX0
	ox1reqZplej10hXAONgy9V2TwTpXF3wl0043tsxWK+fgHXYPEgu6xOZWXrQN324fjpuXj7
	HSIOtb0aiVi5GvGQFvq83A6kRlDkBXM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-aSDRbFjnPR28SJc-D_PiQg-1; Thu, 03 Jul 2025 07:23:38 -0400
X-MC-Unique: aSDRbFjnPR28SJc-D_PiQg-1
X-Mimecast-MFC-AGG-ID: aSDRbFjnPR28SJc-D_PiQg_1751541818
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5bb68b386so2168788385a.3
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 04:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751541817; x=1752146617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIJzNJK0FfXDsC5luatCe5NaXC4y6NbBybHk8bPHUtM=;
        b=CYCHcjAWuaXN2QyDJL+AESgS+aEjlJmng8sMyo5+97yRNVG3KIhmol3Qots0gwamBi
         JbGX5dRtOonvusw/BuD92ptUz6d98nEfORSW1fnTOImqeMjkF90NWQeZywI0FYGxWV14
         Z2tIb9yNUB1yHcZ7JGAaDmzLsHLZe9A2/jBwM8PJXeXmOMBjrMwdlRvUsnlSd7SxMJSB
         N479pEwJ+QEZY3ModMP3j1WZjwgPMz3Rx4gQ/QiLEBzk5AtPSt8hd+GByiWy/HqncZRr
         UJwuq3rd5WzY8GyIurDAK3uAbKxILERhMlObMiStcTe9ADiTdn0Amxu4hGbqOmBYPErQ
         3xjw==
X-Forwarded-Encrypted: i=1; AJvYcCUGoIUHxgYG8wLa0V//llpwsrQw7lvkZn/D+SyMxRBhw8MZI0dWttgpgZ2rQsLfDSB4TblRFWH3BlwsOuGcJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPaReyIn3z5gwC+DOPCd29N38ZCKR6MnqmIub6H8HhjPrIegcE
	wKDRrCFWOh3eYIQFG+FYBN7v8nnBD1nVNnSa9uujsXW0rxtsiQzo/7DofOeHWG74Sy6X3ofhTJB
	ZkiJxgLMrD5jCfM0Gvajuex1wR9uMM5Vm2uOOoa8is5MLFI0Lyd7LAqJVUrf2hwTFe4D1
X-Gm-Gg: ASbGnctkqjvYKFti6RN/Zdqxtbyt884Xe5BBw97QCcR7Nc/mXMUBkdm9rFm/C1OQzJK
	1DKBD+4P/NijPklySwX+327guGv9W9BbPj8sNp/JCGzKfFLq5c7SQuyOOlzyUZO5AUIzmaN7qgC
	3Th11wsD3NHJrZ9keoUTiZqInMkvFN9XCQpIxVU2+6MWFit9XQvXGIKOICmrbzqz4Uz/+bSTaUm
	CCt8opSfQPEVyR8+JXzyKrnaog/3Ec5MIHFFaYWPh6XFH8+6KtU/lkSQU/IU7BqY7x+XyzaFVie
	+F5Hd6QD3AG6dL8oK5ygmA90fBNt9A==
X-Received: by 2002:a05:620a:8389:b0:7d4:3ac2:4c4 with SMTP id af79cd13be357-7d5d14909e9mr501463985a.50.1751541817644;
        Thu, 03 Jul 2025 04:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIhjpqSJkjkr7yySi+zSYYPuX82fx+PYQJJ7PyIEcTrA1s0zbfEWG0IS+SDm5LkMQyKv6eIg==
X-Received: by 2002:a05:620a:8389:b0:7d4:3ac2:4c4 with SMTP id af79cd13be357-7d5d14909e9mr501460785a.50.1751541817217;
        Thu, 03 Jul 2025 04:23:37 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.161.238])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44313925dsm1088725885a.24.2025.07.03.04.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:23:36 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] vsock: fix `vsock_proto` declaration
Date: Thu,  3 Jul 2025 13:23:29 +0200
Message-ID: <20250703112329.28365-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hk9LpTponuEg8INwCXw2qa--fspqqaSe96hhEjitZ-I_1751541818
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

From commit 634f1a7110b4 ("vsock: support sockmap"), `struct proto
vsock_proto`, defined in af_vsock.c, is not static anymore, since it's
used by vsock_bpf.c.

If CONFIG_BPF_SYSCALL is not defined, `make C=2` will print a warning:
    $ make O=build C=2 W=1 net/vmw_vsock/
      ...
      CC [M]  net/vmw_vsock/af_vsock.o
      CHECK   ../net/vmw_vsock/af_vsock.c
    ../net/vmw_vsock/af_vsock.c:123:14: warning: symbol 'vsock_proto' was not declared. Should it be static?

Declare `vsock_proto` regardless of CONFIG_BPF_SYSCALL, since it's defined
in af_vsock.c, which is built regardless of CONFIG_BPF_SYSCALL.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/net/af_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d56e6e135158..d40e978126e3 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -243,8 +243,8 @@ int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t len, int flags);
 
-#ifdef CONFIG_BPF_SYSCALL
 extern struct proto vsock_proto;
+#ifdef CONFIG_BPF_SYSCALL
 int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void __init vsock_bpf_build_proto(void);
 #else
-- 
2.50.0

