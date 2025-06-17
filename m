Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52ED23B63C
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750136047; cv=none; b=Vml8n5YWtV82cEPsqrRgtCZ69ouFX5A7viSYhmJfg8DwjaQzGq5dTQizBqZtgmf6LMbBdhIduCXMZubWjHwnj5SN2t9RtR7/+K6SD6HbM2Oc58EO67Xvyah8dgQhJ6HzxfKH71Vmoe2rP2kBlxgxuN7emlNGqi3VwslH1zp2Ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750136047; c=relaxed/simple;
	bh=yYhC1SvTr4r/q4aKyafrkgVQ1b+GHoCyO4kJ6c3v10c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixSTZgr6TV/rID65h1fsGnioTurwcQqbj5zvvtvNlL8O/VzEIfp3kTyVrL/UBj9Y8r9Tdv1R3+sjN+5IKI74FdslWtmwJHsz83RZUEfIp6SG0EYkQRhBP3Vp/G4vE9FBd38Ep0bsnH8u+wjVZAX4pzBKtv6fpUiEFbGwDgAu6E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOIZkc+p; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOIZkc+p"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742caef5896so4373183b3a.3
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750136045; x=1750740845; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te1ubGn4t4pkro6tbCWw9qlZ7DcNvsq3ids6nDR7Ezw=;
        b=SOIZkc+p4iM+JaO9u+bi09BqcLCf/V2fAJQaluSvnuyumEIQJ8ET/Z1kI7rmb3lutS
         PTgxZVJc5c6ND9QLJEcB0kK23Unxh057KMd6Gdlwah3GAoCgFc0ajwYzORAdX9kbAQXy
         9SXZmM9oc0vBFPVTKRnJG+184NLZQjPcPigiyHtOW160cmzFUWalZMN3JbDLp+t0cPxh
         K28DHa9nOw/B5b40E6Ez8iKAs9LuKWkpR7qolqT/TfmzcEwb8qukJFzR9txyRlGmytgA
         e5lk1lma9zImZX+XFXodCQ79wCZOOS/oVtH+RyARSGN4wvHoyHYuh7wHJmYWJnSXkkNx
         LidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750136045; x=1750740845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te1ubGn4t4pkro6tbCWw9qlZ7DcNvsq3ids6nDR7Ezw=;
        b=VoEnj4WNQjMjTVc/7jfGRcuqLLYw+JveHrU77AsEBQBNlkHhJ3BsjMZWy79dZW08T7
         Wi2tsXxVWdG1PMGOkOvKQ2l6PNAZk/D0UR2UTUIzU6sYcJkt0rzbeh6wB84qqp9x18WE
         oXFbO6qjQsazyUIl7q0XJOpMx08w7f13bcB8CpTY99KGghvPvvGFsfJihWB0wRGPy8zU
         Wxihk8Ka+qSmJXkJC38Zo0WJIQkhdi6xZIgGhZWZF09vv6KJFq6tFmoMS7HkSk1hORVW
         NVXwMhpSHcVPhps1To605D4AdvfXvMnR5rgkuBtxjHSTFCqqwWaa6lASKdQriGcDdWrL
         kQnA==
X-Gm-Message-State: AOJu0YyEr7uWafietayQIuJ6fxvHPwT81tI6q3jKCrRyErROS3LOoKGo
	C2FNBJvRc76SHUeyTSMkezBhtJDFX0N0o4an2Go1FezeaV2ObdVCzAHIV38S9tUU1tDJfN7I
X-Gm-Gg: ASbGnctAzYFi0DBXWlW9xbF0yZtS21lmY912ABcRe5MSJj8pa0iWdvQd9WtoB6gzzhk
	Rfj5rn76gEHAfYpG+AiMdmJyRG6GpvU87bpJRJhmA/HW7KHtAEV6AdZoy6TXdCGvVWQUaDOi0Ka
	xBj/7yEyQNXizZ1tYH8/YUnw9bZOJ5tCIv01A392EovOiku7stFJYYu0lztuNK1gMWupU8fzjnQ
	8P7HxVKU9AbCZp35wywIHmPiyNIlOL42FbpaUS8cjIYq8RhUXJOuoSRW4IHCczILSBrQHURTdyY
	qGeRmyuo+tNNoSw3GT/uUtb4nlbdprCqbqhraiTEDnzv1VXy7hVDxN1zwrKxGBHtqsWHNEY77M9
	6KC3zT11Om2n3ynLd23c=
X-Google-Smtp-Source: AGHT+IFWLomMyMMiootDI6sNH+M2APnpL0s4349WJSyZsCDj3PUu6b9MZuRQQzq74o3s8FUXyYRzBA==
X-Received: by 2002:a05:6a00:1787:b0:748:1bac:aff9 with SMTP id d2e1a72fcca58-7489cfc7ed0mr16816419b3a.18.1750136044879;
        Mon, 16 Jun 2025 21:54:04 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890005f47sm8132852b3a.51.2025.06.16.21.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:54:04 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com,
	leonardi@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v3 1/3] vsock: Add support for SIOCINQ ioctl
Date: Tue, 17 Jun 2025 12:53:44 +0800
Message-Id: <20250617045347.1233128-2-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for SIOCINQ ioctl, indicating the length of bytes unread in the
socket. The value is obtained from `vsock_stream_has_data()`.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
---
 net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2e7a3034e965..bae6b89bb5fb 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1389,6 +1389,28 @@ static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
 	vsk = vsock_sk(sk);
 
 	switch (cmd) {
+	case SIOCINQ: {
+		ssize_t n_bytes;
+
+		if (!vsk->transport) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
+		if (sock_type_connectible(sk->sk_type) &&
+		    sk->sk_state == TCP_LISTEN) {
+			ret = -EINVAL;
+			break;
+		}
+
+		n_bytes = vsock_stream_has_data(vsk);
+		if (n_bytes < 0) {
+			ret = n_bytes;
+			break;
+		}
+		ret = put_user(n_bytes, arg);
+		break;
+	}
 	case SIOCOUTQ: {
 		ssize_t n_bytes;
 
-- 
2.34.1

