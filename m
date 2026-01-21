Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBFD43C05E
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033526; cv=none; b=h8yNKsGAMaTyfDNKnfH/N+UYXGhBasRk4ELP2GM7Sv8tnkSW0WWAIPZDzYVU8uNNf8a3RPAlJyl5l/pnKAzoluBcRe0TyepMTAC5KlL3fw4UJoHmgW1MDfbfVCyRYPT372iqVE90hJtZq1YukjI/jgrIo7ih3uc8rQIofUmJCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033526; c=relaxed/simple;
	bh=QFGTndIZnCvd5tocHyARHg0OdzlZifxdeujSy28wwJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szkqLRcDzEtGrbuMxqiA0WlwmHIKO5azUbBDvCykyvJm3+n6glZTO6IuyVhZKxn2edicQ7k5aGhsJwEa0+/DrJ2h4QOViv0QI0a+swZH1ikVCFNs9b0AMn5qMIUrLWo5T4a5NiAE4vhx1+IDZKyVv2V4O//iuyg+8vcKRIP/Crs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpPGloQD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpPGloQD"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79273a294edso3143097b3.3
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033522; x=1769638322; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=EpPGloQDgk06WbrKhu8OoQ1eMh/M2d0Wa1lsfEW7+m77DaGFGl59sQHWaCHOEI4mU7
         FJE9kw29bfYeC1q5L9MOVDAiX/4i+WSAJTczDyzOyPSmWQqUe8q/xK4o8Dqzv5mMFVzi
         pWOMpyQaaAPIrUHNL953nQ4ZBx4tGr3LsodJZgiSUACRrwsZtnj5nF/33YChtmulTa9Z
         7wUZ2OjusqFe0v1RIGm03SqKkWFskfYRDbDtmF1tQAuWo4xnUdvFuMEztZyX2Va2Bc4O
         lemPgO5mGJ5JRX/xet1b1Vk+2eaTuW/VuRo/eCHw93ab1SB9lplj4NaqA6b+ICkC/sCg
         q67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033522; x=1769638322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=uFzelnR740UopRxfW4fg8LlolNz4xXPynJsv7YgFsSTl/m97vElzaa6qU9qrqo7sli
         jQHySYvfPDE4xF4yhikG4AJbNfNl119ntBETBKwa27g9b6glyIAZXQgo5HAHdF67zZv1
         Gq2djpTivrVO5FM6wcV/gaw1puPUyudTiDrJvIwzl+cJdtWF8DPYU/m01fqvQjnR2hi5
         zsYhJFB19P+Vxx0oSfPYafL3VbOaYXTWmKw9xK7kG2BbpaLbjFV7Vs9yPxS4/rTMlxur
         abWvIv1l4e7d/UpzZMylP/LvFo5t0hkbpv8zXkCEne9igpCUKytK+kdpTgkAkchCfe6Q
         AJxA==
X-Forwarded-Encrypted: i=1; AJvYcCW8tj/QYwZJ1ux9IinzTiw4Aza607QW71PweBSkI4+cLesCDPjaoinhbUXptZrPVV3W0/hbQV4B/rAQE2FOtw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnFTCLWEDgUJ+OW/RtvZ90s1pIdYsJBsNLXlnBP+M9drXZyW6Y
	E8jZJol6r+/yPw5VrDV3zABbmcz/2mPc9JwDNx444u4UH1vHGohHbasI
X-Gm-Gg: AZuq6aJUYFRJ9KIN/THH1I7BwOwXRbK4BDlX62bqkrme5QUh9uQie+pHgzT5fG6Ikn/
	6/5Hm9mSzTCc/KdNcHo1w1i738JMBm6fMWDrJ63DjfngRbpq8Ds/ll4HsTODY+Nkg8NciKYKR7H
	TGWJleEVM8BIU/i2bxdf3wHKQR02oQH1ZxhCeBXX24xTfaez4usj6ETT5lsZaXIidUHb9zwUl/l
	NOQU4OsrWeJSidK1xVx7Wy5qg8W4xlPvR0+cVytxeQ8XN8UjlhBUCc6454RtzLPiyUm1xc4wcPb
	kGbs4RmGJMK/xj7G4X0fDz9ve9xeOhCMQqifnXMPS5eV09HRA7hQa64LNCRGeASPzBOclOxJWr/
	ysh4zXh7gmqrJr54HLAJGjUm1+3KWcHTlw3ckQvkNGzzdqqGtlwIY4lgPOQFKbVc+ntMzvvDzw6
	CehV2o53TS
X-Received: by 2002:a05:690c:7204:b0:786:a0fb:fa8e with SMTP id 00721157ae682-7940a11e123mr58055607b3.15.1769033522528;
        Wed, 21 Jan 2026 14:12:02 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79415015f4esm20243667b3.22.2026.01.21.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:44 -0800
Subject: [PATCH net-next v16 04/12] selftests/vsock: increase timeout to
 1200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-4-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase the timeout from 300s to 1200s. On a modern bare metal server
my last run showed the new set of tests taking ~400s. Multiply by an
(arbitrary) factor of three to account for slower/nested runners.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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

