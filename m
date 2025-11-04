Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187502D594B
	for <virtualization@lists.linux.dev>; Tue,  4 Nov 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295951; cv=none; b=PYYWD2MJcpzkP9iCEMtCvcrRfW7aSpuSy5Mw74GIMIDy6A/JBaAt8mQvfCStzAWbIwYvjkIIxO/7+cbRrkd4MEuwfteJmKWkmohYxEjgw489btz7MxwgPHQsynbyQ5sA4SlAST9+IDvZgWKYshTDeu3Zn7wLjbHQltjYoaqSeG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295951; c=relaxed/simple;
	bh=ZR9/j052YDNAkFJ3hHReoZQ9gREe6fypHqzQIW+W8y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fVhoLe8IG6fMa42H3QlIHH4n4lLw0YjdDiRAiZd8GRcMHXLpgVqX+lhvQEFcCkjhily3bWKgAUgicv0qq44XcqrPHpNS2kwsj6Wb9EAoQ/zHQT/XxSmQN6+9G+936GA/ZgIznNXVbJN/Z3OEKkHubIv1sJa/O+3WyH58SABUyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACkRw4Zt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACkRw4Zt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295247a814bso66330975ad.0
        for <virtualization@lists.linux.dev>; Tue, 04 Nov 2025 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295949; x=1762900749; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7OH/VaXbxgdDQ3VEdnOK5yc54+Zfxu1IfTiRbOYzNo=;
        b=ACkRw4Zt8SlZdCSeI8bKRtrvIc9bfqHlENME2qFs0ZYCpX0xyMtd1B0cj7KRVqWSOS
         8o0TAkoXJl7eqQ3M45wyiKKaCQKEJek00ufTDky2s6BvSeACVEsx7oiHzBz9Twkkt98s
         WW+VkuPnB1WdE2wt31KcohDygP0nouRZAgovRf83CSz9k+Dewy35mgY9YcqQHgtgeYRA
         T1dyHa71dqTsojR/g2cDYiSrOFVuZ9zxbLo6vT34+aquLC4neG6GWTFWkj+7/YD2DuNd
         GokIwDkobXDi7vNGjrJaPFYfqgHJRPHfttbZe+nP3dxYUFdCJzYYRxLQRag/6qGoxLOP
         lonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295949; x=1762900749;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7OH/VaXbxgdDQ3VEdnOK5yc54+Zfxu1IfTiRbOYzNo=;
        b=I2l3xsW8FHxAvOysqHnEuKv8cKvlSD6rQmxZguFRaKobfB7qEYEzLw2CV15mGCw92/
         T9K4FaYi/2e53fHSoaxtUitlShdp5+Wywk70AcS11o+NKRT96J01FSxXGuBcRYT+lEjH
         HoOg2F9bFiMDawxyuTGCrhXGZzXs3migIIiR4X2S6FG4CPKJQvNlnNDY1moKGGxfyC27
         9DMCPev+c8WdybISqyESGIedHWoEDI9J++uK1356k7lD1jLL2bGQwKGwhSACRPM/xLId
         vIfMh0yamEVk7JkGDuGckJdLn2I5q95Sf7tPRqCUWfSWfeGcqPcMoxULJUmscEIRKs11
         iJIA==
X-Gm-Message-State: AOJu0YxTGT8XjDfJETwCEjcdso4+p0sNNmHgrBuXIFB2itg2Tqexzc+x
	4GeNoWlmstn+XhVNAyXhv9mVWj/txInKgo7PJkdF73XZf85g/UINq893
X-Gm-Gg: ASbGncs4l2cgMOuWxEYEup+kfESC2lo/Sbnf1tbduTRrTdgPuEg20clIkJTeXeufBQI
	fLR21sRb8fEII/NLDKV4NP/9F9X0XwTp77EPGmrtE3lBSXSNK9HaXpBJyU+5XiOe2q1f4EQZwmM
	TezquWcbBqIDCji6LZ/ycttetfKrSgd138IEiYID3XsBe3+HIW1aC1jWtkYk/0GdsV5KxKLKhCD
	p40IjWh3ww8HqUr+WwFiP0b8Xh8YwTp+dPbQfF8gcnql+CpJJNSC/FIkMDMfXMgyQA6//GrGDNj
	ol1Ydw53U2hq4paMX8chvLqABRk5mpd/5iFkjcavrLcGCK22Kk2ldoBmoBkLFduVrW7oVCMhjJi
	ZkgIBCRtPJkEVvj1y+DLIfDhoZZv2XHybnc+BU23xPfDXcG/v1a+MLtxd63nnkPrQpI+B4DjdjA
	==
X-Google-Smtp-Source: AGHT+IEf8Nrub88wm5PzVqxHEp7+fQp/JKH+iJ9scU23Jg6FQodVkNNRoH/TfsmpGm25Zf50pWGuAA==
X-Received: by 2002:a17:902:dac2:b0:272:dee1:c133 with SMTP id d9443c01a7336-2962adb20f8mr14797755ad.22.1762295949382;
        Tue, 04 Nov 2025 14:39:09 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d174sm39069295ad.77.2025.11.04.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Tue, 04 Nov 2025 14:38:50 -0800
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHqACmkC/52OywrCMBBFf6Vk7UiSvtCV/yFdpM3EBm1SMiFUS
 v/dWAS34vLOvZwzKyMMFomdi5UFTJasdznIQ8GGUbkbgtU5M8llLbgUkMgPdyB8mIgUCYxdkEA
 5DXaag084octnXrdVxY3ppVEsw+aA+zKzrsxhBIdLZF1uRkvRh+f+QRJ7/5HJX2VJAIcKT21pt
 BywF5cJozoOfnqr/6Khzpj2pJuqKb+0btu2F09HTHczAQAA
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

---
Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

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
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 332 +++++++++++++++++++++-----------
 1 file changed, 216 insertions(+), 116 deletions(-)
---
base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

