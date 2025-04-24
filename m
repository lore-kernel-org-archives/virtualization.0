Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1921FF33
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491803; cv=none; b=hcTHA0Fi8Ok3g1UCscO2tU7KFgJW73W38noNcDxZRAmDl5Xc/6Cav7c0zRnR4ymA3L+NwWYAY7r6K0uX0I3D55Bdx0AXZ0Y+5RobFyk1ApNigXO7Z0A+KNh6x4JzeX9d6XOVGCuUUU6+1RMDsne6VaDKhmmBoaj2qBM6chrd/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491803; c=relaxed/simple;
	bh=wA8lVB4aYxVAiaL/w8CUnf3RB0WE0OrhGgeiAdwLQDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1z8Ill/a7Lhn1PAPe8NkkhDfYYiDo+UoG0FK0IzUgMGcjymB6/9bS+Hkunq8WZ8eSHN24NZgwc0/rnumbD33D+giiOo+WoYgNtJhh3eZ2nbgFO9HbdwKodUCzSwlSyvPm7YABrh+DtodI9Uf2pLz2d7qwWiPbbWCpPGu9EU3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHEE+yEF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHEE+yEF"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b34a71a1so951598b3a.0
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491801; x=1746096601; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBx30bACzPdvynzARNCXR72Us1nQHSIhvQyy+Kz/fPk=;
        b=HHEE+yEFjYEOyWmKqNv6c05+RKzxXESacAk4/7gnihoTF9Wz5eplIbXU3QNC2sjehS
         s/Oe+sX+YbFojEnf4PkPgQvlZAsMghHQC0effTz+DtVa+teiQn7V5FSaBO2/5MdRMTkU
         PSgKshwXLG04mvlWqBlyBJadrgiL26fMm8pGdYWZZaMvgpxklnx7A0hkZPOpE80yjvjz
         o/UZw9BqsgZWO43yf+AnJNatB+5HZVodFn5GhC1s+WCEIeJpYcz47szWR2cT6XeVCjpM
         hxQAsQA4raz0sjVHfwFuURJYmI3SW5UOeX8VF0j6URmq8ljU8kwc+jsBgPKDTehsknq3
         x8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491801; x=1746096601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBx30bACzPdvynzARNCXR72Us1nQHSIhvQyy+Kz/fPk=;
        b=TJkM42RDYaLCZr7zivb+As+7wnZDr2rQoVU0KscdvkOITV9SoftSxNdPA5ublV5W+X
         N9Iwa9qBuSJnoCsmIc2PzsmlAf5dY/u5BqtTcDz1kBKm79dYp4srq2osmgbNWzh9ioB/
         xvnCndyRfPYBjVh55MRVRFYXPqVJ3lP0GLTpijKlViraz2ck6mP+v8QQq/GorSbNOLJt
         yP6CPHlYmUJbGLCkSZnHFyU7EZfarvYe/ZBI8/58eZau6XhJQVflkf0vPfm1s+SWmWRm
         FiM61L4jqbR4sZgtYleEEyIVe0OLNjKDz0+uHKqp95DufcTHSgCiePpdP42U2JdOKpf+
         VMCw==
X-Gm-Message-State: AOJu0YxorA1QadhwVtI28qf5UyJwnzgsDjYVc0kLGI5LRfzheJK9JT5G
	GVnXJerdPdZpcM5Up00dOH//kLWiFybM1BmmrvsYObxvRU1amvM5gJVb8m4BYpg=
X-Gm-Gg: ASbGncvmZQLTJFBiZ6bd/AseoToZkSTRHk1oPpcZ1UF0ttRl3ZnAlZX3uL76jsl0V8l
	eQdcwaTg67LM6siyv6IoMt4CdahI/ZsQ8z6zIhANPIbcUOaM5+zuOkuhnRnPkGSQ02Hog6sUxsy
	H1E7/kj/96/QXNvzTxG6MR21Oe2AdPVYVifJLaa2DeIgbSPhI1r36RVvKCMx1UfnXeeplLti8JK
	+Ib8XToy9Qg0oKLz605W0uqWuuX55baiWplJSVP9rzHUAeTDGM6w2YwIuTv9uu/+tJzjKGPEqsS
	ye0x0V3LUuTBP816oI+UaXmsOinLoumlSaQV5qpbDH2Se+YQ+xt0HBAs
X-Google-Smtp-Source: AGHT+IEKfU0nmB/5B++mOPco6o12mEI223xQ9pX0CSxCbN6AdMo/5JJmz5Z+hAnFqSKkbj1bMDNHrA==
X-Received: by 2002:a05:6a00:278f:b0:736:31cf:2590 with SMTP id d2e1a72fcca58-73e247d82e6mr3056625b3a.16.1745491800945;
        Thu, 24 Apr 2025 03:50:00 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm1120138b3a.65.2025.04.24.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:50:00 -0700 (PDT)
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
Subject: [PATCH v5 2/3] selftests: net: add flag to force zerocopy mode in xdp_helper
Date: Thu, 24 Apr 2025 17:47:15 +0700
Message-ID: <20250424104716.40453-3-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an optional -z flag to xdp_helper. When this flag is
provided, the XDP socket binding is forced to be in zerocopy mode.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index aeed25914104..f21536ab95ba 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -62,6 +62,12 @@ static void ksft_wait(void)
 		close(fd);
 }
 
+static void print_usage(const char *bin)
+{
+	fprintf(stderr, "Usage: %s ifindex queue_id [-z]\n\n"
+		"where:\n\t-z: force zerocopy mode", bin);
+}
+
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
  *
@@ -81,8 +87,8 @@ int main(int argc, char **argv)
 	int sock_fd;
 	int queue;
 
-	if (argc != 3) {
-		fprintf(stderr, "Usage: %s ifindex queue_id\n", argv[0]);
+	if (argc != 3 && argc != 4) {
+		print_usage(argv[0]);
 		return 1;
 	}
 
@@ -132,6 +138,15 @@ int main(int argc, char **argv)
 	sxdp.sxdp_queue_id = queue;
 	sxdp.sxdp_flags = 0;
 
+	if (argc > 3) {
+		if (!strcmp(argv[3], "-z")) {
+			sxdp.sxdp_flags = XDP_ZEROCOPY;
+		} else {
+			print_usage(argv[0]);
+			return 1;
+		}
+	}
+
 	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
 		munmap(umem_area, UMEM_SZ);
 		perror("bind failed");
-- 
2.43.0

