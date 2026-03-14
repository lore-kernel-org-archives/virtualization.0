Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B43BB5A
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446452; cv=none; b=kR57Wq49K3FRXi8CaJGCeSw2qExqLelHp641bkJw66RrZLmxYj7eM9E4v7l/ZbGYkRa+vZ1Eii3JmG4+9JRcYtTS25XAd6rYuoXXRDy4pTKN56PlTVXeegjJ0PJGi4yn7ZuZafOe6ljiMQtDiEFnDfewR4acnOwHDHZfXLy+edo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446452; c=relaxed/simple;
	bh=SzNVxez9V7PcAZk5QZpuj9c+Tw1VVy/fO1zY3LpJVPE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VvI5NdeYHUwOYBtRCO2EoZ5DkN6ag2G3wdxmhvEWnkJCoyYdpm7o04vG4P1PXkTrrztj81/iJKEYZedHRTgxdd1C9OHJ1U29IF/FyfEDvSvoHjR6qJDsTqQ0WdBGxnUWlgTGP1hscnCUiH4uUa1AmZJyAhQh6WGSsYkTz7mEMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OekOZfmi; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OekOZfmi"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7991db3dc98so27225697b3.0
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773446449; x=1774051249; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNbQtouWXaM1HjP+6LQU3raUMR1ZrEf/jm2QyUp1DKQ=;
        b=OekOZfmib2l+pzGbuozpl1BddDxwpgzQM/c+UnK/jQqvIHx0VtLSsYtbdUvdCclX6U
         Ce3rJ4FfqXkYd7QXxYkcUYFjDeL581Lvhu6TBC+8n6bHpHUISA1Z3TKJ4DyL7Euh4vpL
         Aj2FZ5yN+oqcQRj7N8Zyqqf/xw+YPLnZr0SEcIJSI6hvs8ixaVkzmili6ALKtz7oztMf
         pPZA4+4/CHW6M6x6hxcjg8Nud8VTlrWa/69SdrdJHM03y9jVLVhdcuQd69Uz+Evs4e2Y
         QiqFcoQfmSjO6xE5cmGGWCPDptp2OsnRcGDyzv72z7B5pVpjiqUMwOTbUgH83zKRaiZi
         9CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446449; x=1774051249;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNbQtouWXaM1HjP+6LQU3raUMR1ZrEf/jm2QyUp1DKQ=;
        b=ncKSz6AtWoUX37rfpR/WO7U5LHmzrL3k9E1bo90w0h/evlcMXdB9eGseMm3xGHxLLj
         2rEuZPdfs/ZEnltkOJpMtRhwDi4/06veDvA6YWDWDMmsXLv35bVcHIQCtIZcGt69g5AS
         Jep8PDsturQ/V+l+L5NQbL+kl9KUPocw/HTM/1IP2ed8vnFr25leyuU6/hB6creG5n0g
         Oxes4TIFe8M1UNO86mQFzwareotmNOM7wyXAopQiv4qrisi90YnAEgHaNT+maYvmX1oz
         6Pn/hThrWiBMpi/jF1yw5BjxiVY7SxpxUtDthvUrEG/x42xWHdJjSjig/gbLHPotc3wY
         SCnw==
X-Gm-Message-State: AOJu0YyBHm9bzKn/HM8tUEeHEwThFYtmwbzrhITxh9BJovSlvn4syt8z
	EVkLg6RYMplCtk4T+5SOEMA6yhTOit8NRmferY25jm/VaEInK5/5Wzxb
X-Gm-Gg: ATEYQzwEvvg2lYAS21roMoGSAA3KiUJKOMyBesdc4RPOVz86FP3o03xBMJFAayhuQOf
	TgKzHmXTSG35a6hloGGpji9VYfQXpEmOdb/Nyxnp8Zx4WixA+JF/pJpWMYVkrQYUocNb5092+zz
	UScvLNZOUyTDFKEHP4ELjr3Pj/linOoHKLUFTC4MKzE1q12j3lFkH1zECqRjKPXY4qwtgFBH+fY
	rvR3LM2s0cqK+JIPe7xUqL8hDSe3SoqhoQqpAzRpnVVZOC/4TxCFZHadpBN4uo5txxHwOlA2sLj
	pDUQq8de8sjXJWF2Eia107nDPRkUmDMAHFDumS2NuO0B2hmOi9Pk865nQXOxaenY9A+bErFg+os
	aESg6ybO5o8nawo+M4+QLOCiBcnrKAOP1al/TMuJaiC14uloaIAAqUjqSykAs0hjRSLJs3e1Tcv
	TBWwx+EMBnqO1EsXKMrf7pYRUV6UQrXMU=
X-Received: by 2002:a05:690c:ec8:b0:796:5a14:87c6 with SMTP id 00721157ae682-79a1c0892b5mr54774307b3.4.1773446449477;
        Fri, 13 Mar 2026 17:00:49 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7991923673asm55811097b3.21.2026.03.13.17.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:00:49 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/2] selftests/vsock: support nested VM runner for
 vmtest.sh
Date: Fri, 13 Mar 2026 17:00:13 -0700
Message-Id: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6ltGkC/x3KQQqDMBAF0KsMf+2AMUVqrlK6EPNtQ2ksmRAE8
 e6lXb93wFgSDUEOFLZkacsI4jrB8pzzg5oigmDoh7H3zmuzbXlpe1da1UyrjLqmnaaTu67xEv0
 8jQ6d4FP4BwS5IfO394r7eX4B8SxAJXUAAAA=
X-Change-ID: 20260313-vsock-vmtest-nested-fixes-918fd4d3a961
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series fixes a few issues trying to launch vmtest.sh in a nested VM
environment and were discovered when trying to prepare the tests for
netdev CI/CD.

When taken together these patches make vmtest.sh work both on bare metal
and in nested VMs, regardless of the outer VM's user, coincidental path
overlaps, or filesystem settings.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (2):
      selftests/vsock: fix vmtest.sh for read-only nested VM runners
      selftests/vsock: fix vsock_test path shadowing in nested VMs

 tools/testing/selftests/vsock/vmtest.sh | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)
---
base-commit: 8f921f61005450589c0bc1a941a5ddde21d9aed9
change-id: 20260313-vsock-vmtest-nested-fixes-918fd4d3a961

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

