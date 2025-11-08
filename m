Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE101E3DE5
	for <virtualization@lists.linux.dev>; Sat,  8 Nov 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617714; cv=none; b=SGhiSH24g+YZHaGmJoFJz7XC8EA7G01rO+46mAv9uSfYaHprBT/boptFeNmIgehFZKMn0ar0k24tVq63r1qXBUoi7hQD2VlqsGeOIQtuwMVcXzcMaE3ZeyIbBjq1BMmlCG4m6EU6sxqklqHvci8bGdcajoNG2+iBBZupXsWC3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617714; c=relaxed/simple;
	bh=GL2KSL5/GCvtcabkEDmH0mQRKHpNR6LFtcdCsXg/aoY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t31xquVbRCAquqxYYcofTfLR9PtjzG5ih0nBFQeFNEdG1thSMuug1z+j549TyxXTDcP7QcM8l4HIEj5pp2PMAWC03w+miZSAA/NuP9YwwCa2wkUKm0jQeSAhAKIxWF5cW9ebD8XbNn/qg6WFlRo6ElI7ekIfKQ6Uzyg45q6ZsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSAIZ5N/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSAIZ5N/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aad4823079so1523660b3a.0
        for <virtualization@lists.linux.dev>; Sat, 08 Nov 2025 08:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617711; x=1763222511; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pk+ftSCmg1CG/nltRR0t8BMNABaT0VYcCFBYbPRrPVI=;
        b=kSAIZ5N/mnFdoTRiaPUZC1AXC1vvJbyfAhS5+Dk3fOO85hPh24tIr1hq6Qv2xVU4D2
         +zQl+5QRzLUkkyNMtY9MvUZUZPgMv56/rSCXb/3PBDgesj7Xe00tw+Gl1oteqttc5xmW
         Lc/kPxrivBW6qoMDpywq76GwjbHvhEfpRARl2r5D9qNbVD8qUtyyMz6d36IuGZspBy/R
         8rUcW/7/xAU6TK8WgU+xpI6vsv85fl9P2w4alHsYzT9U+TYsSracqOSJ58oRyD8UtwGh
         fitXRcmRHOROfsSbqrTtNw0dJR7t4dghYOh0JDET1kPZpmeZzTqYd9BD65+YlrNSyE//
         hkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617711; x=1763222511;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk+ftSCmg1CG/nltRR0t8BMNABaT0VYcCFBYbPRrPVI=;
        b=IVJ3W4jMmDViEqtNpRbo9YiE+FaCAbcFn5UNBH+TKeDloAVxx8vpuu6Cek3Vv+MrtB
         Co7OheqAknjEwvVgyhbMPPOBYrnCVQV+oOc434eg4NhTV+mXIoXq27ZbTxfPro1bUc/k
         WHkZmUwHkS4E/V6/a8eQXlhMGi7VSFRFdqecCT3ZvnjfrYCLGLvuHRY55xDyFhpDBQcG
         YKvKoitD3z9fsMoNvi7Gd8xolSZATS7rzz2PNs1fX7ZOmoDXRJZi2uEP4dtg8mDJA7iv
         AE1M8HNoRDrU/u9xHRnugTgfl0NiKfdxiopgAM3VL8zThkrWGU+c+mXrlekPXPBDbBKM
         pKOQ==
X-Gm-Message-State: AOJu0YzY//KBZSxwI6BhsXalskeuQcXHCt+4neJZlSw2v5h0nTBcF+Dz
	Rt/8dzm3OOqFPtkqd5tGvhzxR6X2maGcrZN00+xv32I/9uqsh1gxj6Ez
X-Gm-Gg: ASbGncvsGCqbYd1XTcFrHnNFvqACr+1cBcIXQuYEj2NsAvRwfo+ni0oO7Cf+J01umMz
	im0MykuqlLiXGDXyX0oN54CSPCkErG4DcSRGlEbSd0/fBeY0cDqiv59uXQ98QpugICgIelt7ydR
	Z+R1K8doidXGOykC/lrugQEBdAJdK/ghdBrX3YOZR/zfpIRizDwoxS4R6VdMzzGJ5HrGfYikPDX
	p/tKpuvL0NUzBHppoMyYyIR/N9A/hVak9D699cDD9mN14Ryu+v0cswecTqYxn0zf5tYtKsFyqyj
	zCSw6aNKWLVxv1x/QtVy4gZjUEntajoxizZ9XNKif232X/G61u45qYIFwMyTGS1A5tnapXUvgwn
	yeOZwzbxpMyUGEmk9hsPW9WOxRHEavmLaGqiCOrI0lGmi3NKG7K5hPz7m/FfdkELX6JXOUd8I
X-Google-Smtp-Source: AGHT+IEHIM0+igw1l8cTysPn1b2itALVEX3/urDFw2r0A+vpNa/C7teOEzoE2qf9or+CsSDT9YZpYQ==
X-Received: by 2002:a05:6a00:4f8c:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-7b226f8d5e4mr3563547b3a.16.1762617710732;
        Sat, 08 Nov 2025 08:01:50 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c0763csm6374312b3a.19.2025.11.08.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v4 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Sat, 08 Nov 2025 08:00:51 -0800
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADRpD2kC/52Oy2rDMBBFf0XM2lP0slV7lf8oXdjWqBGtpaARI
 iX430tMIV2Gru/lnHMDphKJYRI3KNQix5xgErYTsJ7n9EEYPUwCtNS9klph47x+ItNXqMSVMcQ
 rMc7JY9wuJTfaKFVG2TtrZQiLDjN0Ai6FjidM4g0SVUx0rfDeCThHrrl8HwVNHfuvTD8rawolW
 hqdCV6vtKjTRnV+WfN2V/+LRp4W5UY/2ME8aPfeZh6NSg5PUw1K7NVonKbXWbrlD3Xf9x+YcLC
 MiQEAAA==
X-Change-ID: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>

Changes in v4:
- fix messed up rebase (wrt check_result() and shared_vm_test() patches)
- more consistent variable quotes style
- use associative array for pidfiles, remove after terminate
- Link to v3: https://lore.kernel.org/r/20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com

Changes in v3:
- see per-patch changes
- Link to v2: https://lore.kernel.org/all/20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com

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

 tools/testing/selftests/vsock/vmtest.sh | 346 +++++++++++++++++++++-----------
 1 file changed, 233 insertions(+), 113 deletions(-)
---
base-commit: a0c3aefb08cd81864b17c23c25b388dba90b9dad
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

