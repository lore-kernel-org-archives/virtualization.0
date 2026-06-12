Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270373090C6
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291363; cv=none; b=WFvnYdQ4vv8CWa/4Fu/P+S2Cj4B6d1kraeBlCQbxf0RdlTB2fixUR39jKdqQqbFytoBWlIi0E9LzmT+5xDwCEQ41mFX2pzz+ohj0BymkmkFQoXNUwpudYkl7qUng1eBzS8KEAIYMRdvLyztJJYdkacihdiLxvYFZwI4JGqKuqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291363; c=relaxed/simple;
	bh=yKA+ZzX6XcYhDv+LWR2Mk2bht6hMBJSX9q+2jBi6BiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZC29K87xRw+QzPzjDyphUNRxp8ynEMocJvj68ixqGNsqrjGvZYDY4mckQnbHu6YSeExK2UOCOHMnQuUc/1dKxlLCfwQSlIgWTmSh8kqYsaxak9WZCzSuUq0I1J1/VnFoD4vTCpjjyi7Hi9PvaDnu0j9cp9xMNI81avWrii2O4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrWFLtcS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrWFLtcS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0b9328c4aso11192635ad.0
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291361; x=1781896161; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4L3vRJymTPS0qt6L5cUW7zrlkl0+scsI7rVDfbLQutE=;
        b=NrWFLtcSB8PmnbnMEk/dP501RqgiNaad8mt7w+hcVj4wyfmVGmxp+ChgLgcEDxcQoc
         I5RGDiJq2X+yZE4X+YKWdXO11UL0PtFSD5L0l/N4TUxe6M3gP/5jyz8wtGFOx66aTB9e
         x0BUKDLjXtJUtQ6xsVa8VbYumpPyijZxb+x4OSZ3ufbsL3xH6Y8m4dlH1WjESuC0pBjS
         OmIQKdWqH/5nNeu3bCwD8U72eBWRKdMPW+EAqw5+ZnCSSy2FABMeEcBdfABukEjIjNGN
         vMyBYuyhRsQ50iL7ihwDKNoy6veE7Hax3wXz1VZ/6D4JZf2sN9i9U05qhaHDzjydVqyU
         r8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291361; x=1781896161;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L3vRJymTPS0qt6L5cUW7zrlkl0+scsI7rVDfbLQutE=;
        b=qX8/c09toGEiOJd1qbgR6/QRk0nr9j6CGUnBCJmk/ucvqro86QBUbDMnNGiL6NJetX
         TWtRdS2ynbVw6eTRj8YOY7JaQnIBAc+j4dvzDmw5iLCKOyj0xfu6XslLgyMYWWnpMwTC
         4E8SovpyqdTpMRkrqNEysZpCCvP6DDx2gfUVDx7zDmf2f7cYiLtlFeKBXLFtNEh658fJ
         pPcxFtOW7MBTFlTfBAoE+GDobEdEoBlhYv5AI84oNYasA/IuhwvU2hYqQavdgtRR+bv5
         xkIxE0PtX9OwznYE6r8qoji+358x+aDFO8x8Z9WE2thoIxo9sBK+cJHUXjeYX/kst9i+
         +C6w==
X-Gm-Message-State: AOJu0YyHGki1t9SoUU9FH8jfyeUhzQ5x+B+qMMNlS7mGfIl0zbb4PaVq
	4aHAfoCNpYOuj9AUDASyF7aqgcX5ZsDhp5G/XtdtQRexsu1WyifzETHF4y6Zw1tR
X-Gm-Gg: Acq92OEFUoVI5PYH4oC9+74B+J6dN2YonkIJAYIxMrJ0+uSCY5zW+mKgLpjnau2HBxh
	/NB1bFuvXNgOolOxipoj3ueJNckFt9kg472AmjsHazpshBysAgD0C/Wmg4JpVM/ZFOBpMihwdsw
	quMjbbEeIRIG3D3IR4jv//14jD47uIQaWlAHzpptLJA2wS/8aYmNbyvNKy1JgVvguPhRVnc6Ilt
	0ni/Z0hN1j/P2PAruEN6f21uBZGoiOH0FTe/akCArtuFo0yIOvvWp1093RLmC/t16wXGk2bvmmx
	cx8WZAs+wDPIYrb/lkeMNGS1MSlV66MP+ZMN3GHgsyBXIzcQdU2eyAl0y8hldG/v6uZUavWwofE
	qwXmkW0xrFjIGxNfPbd4p+Ab0fgeYQCVHWpWTwjGiP73Xh/giHYFQKOxPQsVTjlILJhlgP2olJS
	sVc7u6Q6kFIHCOcAfORkQ=
X-Received: by 2002:a17:902:ce8f:b0:2bf:11ed:3d64 with SMTP id d9443c01a7336-2c411c7997amr52161945ad.18.1781291361424;
        Fri, 12 Jun 2026 12:09:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm27661395ad.41.2026.06.12.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:09:21 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/2] selftests/vsock: improve vng version and
 quirk handling
Date: Fri, 12 Jun 2026 12:08:40 -0700
Message-Id: <20260612-vsock-test-update-v1-0-7d7eeed3ac8f@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhZLGoC/x3MQQqDMBAF0KsMf+2ABiqYq5QuQvLTBiFKMhVBv
 Huh7wDvQmcr7PByofEovWwVXqZBED+hvqklwQvc6OZxnpwefYurGrvpd0/BqDkGLjlHpofDINg
 bczn/5xOVppWn4XXfP6AnZaFtAAAA
X-Change-ID: 20260612-vsock-test-update-fcae9ffced52
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

As vng has continued updating, there have been two things in our
selftests that have been affected. One is that newer versions always
emit the vng version warning, and two is that we have a workaround that
is not needed in newer versions.

This series just updates the version handling to allow all newer
versions without warning and version-gates the workaround to only those
versions that don't have the commit that fixed the root cause.

Additionally, we add function for comparing major.minor versions which
is used in both patches.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (2):
      selftests/vsock: accept vng 1.33 or >= 1.36
      selftests/vsock: skip vng setsid workaround on >= 1.41

 tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)
---
base-commit: dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6
change-id: 20260612-vsock-test-update-fcae9ffced52

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

