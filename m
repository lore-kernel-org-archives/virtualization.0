Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47819994F
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181227; cv=none; b=nqEmzzb1jAMVDG5ExoIW7yuxl4fuiBn1c3+7xmBNAk3tfq87gvFblYBw+zvjDNG14cQy439XGjhZlBSKWWPF5Vw7c1X4EcWs5pj4vLkxz1pcBLaepxmUAWsx06yCXbTDGRCuzRUf4Y23pu9GWXgGDEPuily2p5cJSdeEUFGnQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181227; c=relaxed/simple;
	bh=OrsxdswB6rrhAmFOBRD5OXXftqbef7SMzTrZcBtK8PE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HDCZ9kIQBu0HebaAMJwmsh/gaK8IP5cz4YcFF6UA1Ex+U8Lg1zG18BSHK4i2zV+7Dx/n+fvqlzxYd40vce3si3eGrkOEmEX2tpT71E+AEjGsIwwB30uZkwKrJBLV6YuWro0zW8eLj3o1peL17irFC63shR3BpWz5nKX27KaJoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc3ro7bp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc3ro7bp"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so245752a91.1
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 18:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181224; x=1761786024; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QcrG5SS8hn1JmYCm2wGF/gyiT6cJxpEJmuxnsfJHsCI=;
        b=Uc3ro7bpVrFHZrmHJvgPExYoRSC8yiEhHlfRv5YombZMExHYN/3Av1qdwbJ89WPbn7
         WENhj5MgKd6eHfP+pbrjRsaq3gTt4NiTG0f3xYfw2EGa3TJfAKslDdROzQ2FB2WAsDkA
         PILunWbWHjBWN0ivENCVJJHhPFxxFgspp2wPk8Y/sSzgs+P0qrikDsj+5zE4Wb1IQ1DR
         TFYZth7R+c3qOXUwbxiY8rKz3K2QC2TJjnKsJsDGTFRC5kAj5xrhqwTs519gnlaPEOZy
         S0yQTqwmD7A92Ipvl8ZQFE7oS51VW0hph7yeA3DR6l/GVVfybENWc/lr8LAy7vnftYF/
         kbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181224; x=1761786024;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcrG5SS8hn1JmYCm2wGF/gyiT6cJxpEJmuxnsfJHsCI=;
        b=OYtT4ZoRGysuBYT2+1sb8gMEss3ageOR0NnvQTPvd6NFHWcS1XzLYDTInN6GlCXRzo
         ZG8fTPgj5hiUnbsoopdNaTJuCj/xRmIuDwU5hHBoxRQMyMiX831RTXxpBB0ibynuffZF
         i7Qv1UCJB32TReVxRUnHllfHvApSjZmyvv9G8ZxC2aZKxmqee0GYaHCN8wSW21MS/uCM
         rsH+PCPTgZ06s6QezWr/tqXMPJCQdzrkaXSeJW/pywnX4sgGJse/BxBTlw4HPw8BZT9p
         +uAYyN8olz7xHB7NXJIMOYp3ryJUiea7yPvxi+XybpuOZqPNRGPv55lk8/F1NDrHjs9l
         Mfiw==
X-Gm-Message-State: AOJu0YwHdeRnAXB9iJoNNgaLyR5cQOeYCbj9IGaxN7mf7XDCTwuMea2B
	7xlMlAfcOekhFkDi5Gkzf5fExmqCqeVh/D5xLzQlMkrO5EMVEc6gff685iTaaShC
X-Gm-Gg: ASbGncv2FS4X5Bn0EU0KKIMYn3datbj+d/LPbPNKP21v4m4GUFIgvd+X/QmqGgpvmEA
	N2wEyZKXlSpW3iLGX90gzclBOdtECcEulEiI/w5jhdzHoJRd2IifZQjf1Gs3WVRHpI4ZDwncmOT
	bBgpuTvL8rSmpRh8ib1lX0hwpjPE6Bni9l4NHCR3ti5dlLTbyGpUmaibAiaZKN5SL34agmwXlvP
	0hIbE8H2l9Zy0z+s3nbBa+eO5qd3+rBnF4iQiCbcDPPJ5qY2It/j2OfRrwcOwD5PxtWpKH0DWsb
	mlVJngGFis3t5NJRai1SOydtEy2+wmISmlIg/uKr+LoBud+1BBsTt8S1hV/W+tHzT0nKGoaQ1Ky
	qhdeHxU2FUyxAnGPsPv8GXhy7U/apDvWwVnY+KjZNyt4nuYMV5uT+UkKVgtrhWXVLRJQAg72xrH
	FDo6YjZ3g=
X-Google-Smtp-Source: AGHT+IGnOv9l1GPF2QRjAQJj6nCOHdYFB+j/jBqimM5n8rIVXUeoQADXI3xEZDsAaop4mPz3EecSjg==
X-Received: by 2002:a17:90b:4c4c:b0:329:e4d1:c20f with SMTP id 98e67ed59e1d1-33bcf873e1bmr28314920a91.9.1761181224284;
        Wed, 22 Oct 2025 18:00:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e2a48sm3855388a91.6.2025.10.22.18.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Wed, 22 Oct 2025 18:00:04 -0700
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABR++WgC/42OQQrCMBREr1L+2i9JbCm68h7SRZr+2KBJSn4Il
 dK7G4oHcDnzhpnZgCk5Yrg1GyQqjl0MVchTA2bW4UnopqpBCdVJoSQWjuaFTG+biTOjdSsx6jC
 h80uKhTyFaouub1th7aishlq2JDqStesBgTIGWjMMlcyOc0yf40GRB/+NqX/HikSBLV37i52Uo
 VHePWV9NtHDsO/7F6ESUlXlAAAA
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, reduce false-positives, improve logging
generally, and fix several bugs.

It also prepares for future tests which make heavy usage of these
refactored functions and have new requirements such as simultaneous QEMU
processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Bobby Eshleman (12):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: identify and execute tests that can re-use VM
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: avoid false-positives when checking dmesg
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading

 tools/testing/selftests/vsock/vmtest.sh | 345 +++++++++++++++++++++-----------
 1 file changed, 227 insertions(+), 118 deletions(-)
---
base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

