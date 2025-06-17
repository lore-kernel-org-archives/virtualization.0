Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876272EB5A7
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173860; cv=none; b=MxP863v/C705B1X4s/e4ZUpwRmjOZFyLfCRxUvnXagArUC6ZEzl88hedFDiIiyMAv3sRwU/d6xMJoWyI3ddK3FZLomWJqZaR+1YfG3Bmj6uBBzqpGWxqvAcL5LEUI3DxAQSem/Rm/su8/sWMyuD3seO2/4MxwOA1xo1dvlKl/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173860; c=relaxed/simple;
	bh=Ff9lS1Yd/+nqGtnrmnMrj8V8fDZxSoDHmktWe2ibSwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9nxSLeDP0hV0xVAoUNdB1JMz4Cty7ONmGEn4n9+W9Ip7KENfnZtW68z/ibTXzogmP4UhpXJowjaeHvAkUSXjIpe18pZJCiDgrJD79bQTfe5YBF2CvfiZkg/NTHvEV25zh4E3TDbxI7j2Oiz/Vn6TDMZUDTu67OuZofm6mCvxEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+vf/OsC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+vf/OsC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso3366783a91.1
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750173858; x=1750778658; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jbR+py3WXxAosAVt09Fd+QIJmRYUlK/h5DTO/DPsSM=;
        b=Z+vf/OsCEAFAFHkYpeMO+oHNvN01l9pTUcp8XxiDd/HH2prfng0xDey+j3yKdxZm9r
         g659dVX4R5aHzHnMRMg5Ng8KKwG36MQ69d2AGJE3eporECx7qfT4pYCCxTe32V0KbJhG
         GhLckGSnbAi8zZmDUWdX8JVUEkScu67M4Y+KmcAL0NI0CdnKrthFOJyDGjLJgfNMV86I
         JifqPizEZrMmAh3UiQsaMUW6cBGDv4xyZXfjsF9JCTn4cB1QDB8PcWOBmstShb0abHCl
         f64XeHjw383f2HnOmRUtXiQjnwi3i90jEQgk5sWePslZfKLJx5QxdsYPea2rO/99xClH
         RBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750173858; x=1750778658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jbR+py3WXxAosAVt09Fd+QIJmRYUlK/h5DTO/DPsSM=;
        b=pNudIqnQ9kGWS8RLPevWaBpR+SNrkWiPnSmD0lkbZJWSQU9r7GDMzxqWnynzqzYRef
         ZABigFGNvmZa5LBcICbOVDlTpIiuOXlu9tz52+0QeUC9VEzL1iZWbKXvU7qp5UR/xsV2
         pSa+qWmdV+1HzV0QSpjtI574qiJ7bXENlO+DMlO5JNHLQ3KYF2UoQRQyOpBbW23tU4QK
         dhIrp/6N6tRYQ/EquCFWrCbBmEk+kEWYeQa89vyoWagS1bAhN2Vz/VVO0a23Ew2tvOIr
         MFqW559l3eXYjH36qbd7khddkrHtxvEpHRjk3mb3koFou0ntnzuro/mzalsm8N1rJPXS
         IYTg==
X-Forwarded-Encrypted: i=1; AJvYcCXzYtG9Fo1o3Svrgphh5+/Uc74Qfp2RfD60lvo+jAInwKtiUmaAF9rnxKHvyONtnRt2jNpKivCAXdBlZm4dPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YziqImzUXMSSXiBnfnXVkFE7eWcgdvDUASWKHZ7gz9CNCWRrKj/
	Xv1XBU20CvzPxsEfke55GKsAskeitOkZPk9U0Lp78o3q7Z1bXRzgrAOd
X-Gm-Gg: ASbGnct6F++g5cH2yRzS0pLozgeJCQYBHPPDXtcNvXR/2quuIRhie+FXkGbDLP+Jr9L
	NkNpbEfpECk2XvmLd4kAxwrUqQ834ZDkvuAEjmPe9oh2FM5SfXyQLJDyR3HsmFNMG+E5Tgt7bdh
	a6mCuiA5hz2ooDONamO9BRFGh+Ktv/kd7QxfOoR2kT0H8WGEADrhcSdzLwP6vJgEtajQxFcGAjv
	lBhJdD+ySs+mkzginSSsQ/biIly77assyd/EcBhmse8bUbbfQLrQRAL1PqpibOZWg/xnBFp7+2o
	iyv197CvNqu9R/Yu71nQIKZs/GA81ApYG0d1UFqS6v+o9tAaYQ3l5zGkBWOSqGhZVRPjruCKYQM
	U9IahGbYJ
X-Google-Smtp-Source: AGHT+IH5MD2+jZvIUtC67uk+pIfR42yS9eI+xyYHXF0u5t7e1n8p6rWyAE/h3yACBAbGGBO+BxREIQ==
X-Received: by 2002:a17:90b:1807:b0:312:e9d:4002 with SMTP id 98e67ed59e1d1-313f1d9bd7cmr21120975a91.28.1750173857515;
        Tue, 17 Jun 2025 08:24:17 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19d0e36sm10806236a91.15.2025.06.17.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:24:17 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	leonardi@redhat.com,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 2/3] test/vsock: Add retry mechanism to ioctl wrapper
Date: Tue, 17 Jun 2025 23:23:48 +0800
Message-Id: <20250617152348.1346298-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <uqpldq5hhpmmgayozfh62wiloggk7rsih6n5lzby75cgxvhbiq@fspi6ik7lbp6>
References: <uqpldq5hhpmmgayozfh62wiloggk7rsih6n5lzby75cgxvhbiq@fspi6ik7lbp6>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Tue, Jun 17, 2025 at 12:53:45PM +0800, Xuewei Niu wrote:
> >Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
> >int value and an expected int value. The function will not return until
> >either the ioctl returns the expected value or a timeout occurs, thus
> >avoiding immediate failure.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >---
> > tools/testing/vsock/util.c | 37 ++++++++++++++++++++++++++++---------
> > tools/testing/vsock/util.h |  1 +
> > 2 files changed, 29 insertions(+), 9 deletions(-)
> >
> >diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> >index 0c7e9cbcbc85..ecfbe52efca2 100644
> >--- a/tools/testing/vsock/util.c
> >+++ b/tools/testing/vsock/util.c
> >@@ -16,6 +16,7 @@
> > #include <unistd.h>
> > #include <assert.h>
> > #include <sys/epoll.h>
> >+#include <sys/ioctl.h>
> > #include <sys/mman.h>
> > #include <linux/sockios.h>
> >
> >@@ -97,28 +98,46 @@ void vsock_wait_remote_close(int fd)
> > 	close(epollfd);
> > }
> >
> >-/* Wait until transport reports no data left to be sent.
> >- * Return false if transport does not implement the unsent_bytes() callback.
> >+/* Wait until ioctl gives an expected int value.
> >+ * Return a negative value if the op is not supported.
> >  */
> >-bool vsock_wait_sent(int fd)
> >+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
> > {
> >-	int ret, sock_bytes_unsent;
> >+	int ret;
> >+	char name[32];
> >+
> >+	if (!actual) {
> >+		fprintf(stderr, "%s requires a non-null pointer\n", __func__);
> >+		exit(EXIT_FAILURE);
> >+	}
> 
> I think we can skip this kind of validation in a test, it will crash 
> anyway and we don't have in other places.

Will do.

> >+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
> >
> > 	timeout_begin(TIMEOUT);
> > 	do {
> >-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> >+		ret = ioctl(fd, op, actual);
> > 		if (ret < 0) {
> > 			if (errno == EOPNOTSUPP)
> > 				break;
> >
> >-			perror("ioctl(SIOCOUTQ)");
> >+			perror(name);
> > 			exit(EXIT_FAILURE);
> > 		}
> >-		timeout_check("SIOCOUTQ");
> >-	} while (sock_bytes_unsent != 0);
> >+		timeout_check(name);
> >+	} while (*actual != expected);
> > 	timeout_end();
> >
> >-	return !ret;
> >+	return ret;
> >+}
> >+
> >+/* Wait until transport reports no data left to be sent.
> >+ * Return false if transport does not implement the unsent_bytes() callback.
> >+ */
> >+bool vsock_wait_sent(int fd)
> >+{
> >+	int sock_bytes_unsent;
> >+
> >+	return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
> > }
> >
> > /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
> >diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> >index 5e2db67072d5..f3fe725cdeab 100644
> >--- a/tools/testing/vsock/util.h
> >+++ b/tools/testing/vsock/util.h
> >@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> > int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> > 			   struct sockaddr_vm *clientaddrp);
> > void vsock_wait_remote_close(int fd);
> >+int ioctl_int(int fd, unsigned long op, int *actual, int expected);
> 
> what about using vsock_* prefix?
> nit: if not, please move after the vsock_* functions.

My first thought was that `ioctl_int()` doesn't take any arguments related
to vsock (e.g. cid).

I am fine with the prefix, and will add it back.

Thanks,
Xuewei

> The rest LGTM!
> 
> Thanks,
> Stefano
> 
> > bool vsock_wait_sent(int fd);
> > void send_buf(int fd, const void *buf, size_t len, int flags,
> > 	      ssize_t expected_ret);
> >-- 
> >2.34.1
> >
