Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE8130F92D
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273982; cv=none; b=oNc+MMZfFis3t63ON10AtaMcKGIgwE0d/xYnQSVGqTA2zFdVyrbch1qfB8igexYrK+oNk/hQzyHdBbfZ+9qzTDUtIdP5aOPDrGB9NuhLomCofYoXwDaaE2novNkSDTrsazOwgvA5clqSXG96l6CyxJKQpjcy3xE069hTrX9px3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273982; c=relaxed/simple;
	bh=8kT9Sce1CZrAgVQ7vnNZA70o4fM254DKC0wfkmWzB90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSGJMGi5uC8hL7i2BecFP3m2h3/9ZUUIpZd3fzOrsJKTv4+um88cHnTwWwUF89IQs2YC4pJZWLa16X/6/+XHVD84s09nk6ye0JGOTCx1LVlZzlAOzXwnC1Jlcg0qDqwoNkCD1hUYMoIXVWfLTJeczUfwmRhnLECNoimklXUHrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqvFlgTz; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqvFlgTz"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64471fcdef0so6450107d50.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 19:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273980; x=1768878780; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uP5dCmGJx/cfUOeiPby/DoTXnEYYyl2lr0FiheN3O+M=;
        b=nqvFlgTzp791Qyh3exjXIrZWIg0VBy5+rP1aMsSb/QgQB3zbpvmNde/JJx+GBcwPcp
         KhvCWceK4bdGTPMaXc2ZOuGxpme4W6xn+SpUcCy2Hsw5q91LrCFyPoz3OEFrpFHITjvu
         irvlHc8F4v4/jjPwWti2PC9ByYNvyKoeAmUo9iekwb/TVmQ7dBwQjlUkChu3fFEJW/Or
         OakMA5KRXsXMJbWkEgtZ9gHAPtsNZ97sLz6weBUz8tb8mBYp1enFT0DM+vPWdDe6DBdW
         Zv1iYMCWAnA5XEHjTgTzMvUNRk9tw7gwtuyGW/caf+xAcKdIcJ3++nsEP57U8XGQ/gfP
         DWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273980; x=1768878780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uP5dCmGJx/cfUOeiPby/DoTXnEYYyl2lr0FiheN3O+M=;
        b=gB3x/QL5RinRtQlmqA4nnPh77t2GzfcuI0x9axE5xjiA58Aq5pTH6SsihBZfS6hf+j
         b5tNeSt8bnSb57eCd5MoL2DFI9B6mMqlrZESLAGDeTm/UYW5IlDHZ3CX8AiF0JuqEHvY
         NfADjyg7rNdtyw2/D3unxMfry7Id5AQdeiTWgD2LsOYolEWHfrSab2/PtHnrGE+fxEMP
         /1Iin+Q4SeAeNcT+znXXeffLHSJ4IK+FcZah8ns0AExqfCFoweJI0cb0Gxfxx+RLhVP+
         P7Y53h0gI2uUEhc+RGGk2YlJ9ADKJ+b97YFrqGwEvgJKYVt+fWv/rncuNLw2Rgb/qvQh
         oT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSKOY6SWo2byz0rwBcBivAEUizF9Hv10BCIrRtNGL96pzBwpFuUQGBiyj8pZSDwMlARM/uwRVcPOolxVR0+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAM0UTic1bYvkA6p9E+Nn2BhToqeji8Kx9Yl+pBtOwFgX1RNhm
	v+py3qVXNRp9/uU6IZjYO5fbiGGzTMu9yp9TuZ7dzYe+n1VcWIgYLWUX
X-Gm-Gg: AY/fxX5Gr4oZ+CCns5O1k9TdWUzS2PYSCSi/EyC1RpVoygaCpaD55za2gIim895nRfu
	NcycFZDakH4Gzd01KWromWU/mjTRLRQkXwcAgbmdirl1h2gzMfC5NDmh322RcNCzn8bqD1g54N8
	hYhQXZ9STFS+8wTyx0myZxAkSqIYaTyHYNkN7KJyIWrBRnylB83NBGlJAVMZeYa+BKCi0zTH4Yc
	z6NYMwmRddOmn9mOah/GKiqOkOwKerE6a6unU9wmvq9X+GE8cx8j/zMtv573rPRkjpHB4MUB7BJ
	aBqavrr1uB7BDFmPM608gAJUeJhwKCvGm8qP57PCBzG9K0Dw2rPiN312c5nng66gC3ynBe56uOE
	OiF8iuNpYEZQfTogoo8mrc9G5/0Is3QeRBnBBc9qV1GPf9Jjy6OYLBROQZT9GV0mQQM+QUBs0RG
	fuXKSosvS0yg==
X-Google-Smtp-Source: AGHT+IEb6SZC7b3qvFJYt3k7Bek7L59Xocc4oQtKoQnzhDn4qYGn5XzM6bedIh0Pal8eLsRvCLYfaw==
X-Received: by 2002:a05:690c:9c0c:b0:787:e3c0:f61f with SMTP id 00721157ae682-790b5834fe3mr369495447b3.57.1768273979828;
        Mon, 12 Jan 2026 19:12:59 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8c52b3sm8800897d50.25.2026.01.12.19.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:13 -0800
Subject: [PATCH net-next v14 04/12] selftests/vsock: increase timeout to
 1200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase the timeout from 300s to 1200s. On a modern bare metal server
my last run showed the new set of tests taking ~400s. Multiply by an
(arbitrary) factor of three to account for slower/nested runners.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
index 694d70710ff0..79b65bdf05db 100644
--- a/tools/testing/selftests/vsock/settings
+++ b/tools/testing/selftests/vsock/settings
@@ -1 +1 @@
-timeout=300
+timeout=1200

-- 
2.47.3

