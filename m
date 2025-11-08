Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302502472B6
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617722; cv=none; b=h0kP4KgogoJ+fyUSIdmKcFLn1GkKVJTiXmTJOVWf+il2gFXttorMtqR/DwF//BosepFZhQ7QXKGoZ/X3pjOPAm62nSQlac5kAvSXItCBMX8euGxQHGTUhDxL5fAtCubOVz+ZVQve/ewLBNMZrgtweDFB+onL0G7rsZT9pfXMCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617722; c=relaxed/simple;
	bh=rsJoOi2cJHjVoFfWem70mON63FeGD3+bDKAfH1rnKVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUwjoA0K/BPxv20OafEYSK4nY6kigKSKDihw7jtNwKC9jAH00+tcGrYQ1hakL03Jq0lU3PtlbSA5rOPrMzIrm1KdoY5j8e3esJ1qTViwJZae98H/TUsDfmV0sppzlZhwrw6fxDpELUX5FELCLu0dqLnZSO2oFcltpNqJDj+fiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU+c39nz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU+c39nz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-794e300e20dso1136542b3a.1
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617719; x=1763222519; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCZpbzlgXNaHUfpJgg5bp7RfyHhboSaGeDqGPcpEBV4=;
        b=RU+c39nzkHpeJucRAVg37f7iYO5pNaYTXvBJVTwBwWOBi6HVvy+lENTk+kmOExeGaq
         JhhJXVXKkfjt0dZ3bK2boBJKMzZ9NlVY/qYtiO3o5SHa85JP2R0/0cXRy7DiU2zAMqVB
         Df2LPwK/uGn08jxTAK8yTNRbivH6LcRUYdOTaIM/mQphls45UPo6klUC/s3HUej/bbLs
         jgd9YP5JrXONC0sw6VDGbtAhI302Xw955s53bmlsr3lpg9bLO54MNpyTFs1VE3AIxheJ
         JgjOfCp+JK+UTZB7V9gy4G7tYVNqhakI8i7eHB1BPCajsILD0LTfC4fs7dGWgQiwI1J4
         21gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617719; x=1763222519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCZpbzlgXNaHUfpJgg5bp7RfyHhboSaGeDqGPcpEBV4=;
        b=iuLLAdEQETBj0GaPx/bk824XmetuJstokCVuTVIhIxqnKHQoOqwRjCO2jWu87Vxxfg
         5iioh5pdDWc983zfmusIqb6HM4/dXzZnQkJsWXnxQbMfy+fLq4wpRiXaXFagkmvCLnmV
         4q2yCkWYxFWQXxidT6L6RIJO1gfiUeqCK2c3+GdRysUL9Tv9kK8zfmpmaTBVZ1ZSO1u2
         WjTSbFK0lSUYRgdID8H+cFO68oNmnXGI3p2D1s82pnjdRxVEivTtp8WJy1Xt9ujebCYP
         ZiZZ8RSQQBPsiV2l0XegbRSvYX/9bxKD8+gvM78goiMZ1V0Pv6yN4kN1h16GIJ3erPGR
         zQog==
X-Gm-Message-State: AOJu0YwADu++js8lfZ66KGloMb0VCRSKUj+9kBxJTzXzCRidoFaosC7I
	x29zV+6QWBC49pOyEF1/46VDSez0FQX4Ncow5+XA/0kqzEO72ShUXBWW
X-Gm-Gg: ASbGncurrOSOpT21RDqOTB5bFEw3q9b6/YKh2E8HJ2sUGmM5yfWk0gfV2uCLnhpXHpA
	86XBoOz1szJ3xfV9KaFpNl9J+gMX2Wua69aw6tmlxFq0+bv/cftNNcwu+fqH3mPRY9AU4gRdAc1
	AAy4caSSa/rqDyjOHt+lWODzqWOwhuT9AU+dQ/I6B7t4t/5cLvLcA6qDya70D8eE1/OGXjD5XHL
	tGN4l8zFkJRaOHWsxKA93rGbDAKygUBnJzKKjAK7Cxrq0YzinfAW5uepg9df/DArTfXIQJgqIOM
	HSPiKMiSDrpRQFhRKbosLUaUI6TxbasNIjzUap+JQLadwpe+IVOtdqXinZP3EGjMzUgwV39nma5
	yrwAJhSz7tH4JrMGbuDrHgaIDCVKZmjL9sSQ25x2LY4gfM2c4jRjbNfjGDeyUx6JhnuLhQM/7
X-Google-Smtp-Source: AGHT+IE4yGWFg0aIBwiA4LPoKZBjaoo7gZDrHFJPuzyKYWyf6FZGig58eJBXmK4vcD8oY5wVdHAoBA==
X-Received: by 2002:a17:902:f707:b0:295:6850:a38d with SMTP id d9443c01a7336-297c95b383emr64698465ad.19.1762617719452;
        Sat, 08 Nov 2025 08:01:59 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba90138f614sm8137032a12.27.2025.11.08.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:00 -0800
Subject: [PATCH net-next v4 09/12] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-9-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- remove fixes tag because it doesn't fix breakage of kselftest, and
  just supports otherwise invoking with bash -u
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a1c2969c44b6..e961b65b4c6e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -548,6 +548,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3

