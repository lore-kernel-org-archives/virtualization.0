Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36CF233943
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111733; cv=none; b=beiuYZ/S6kIprep/IFihHw925vReW8a2IIDYC1IDqafk3ONgvQMWvZYvj7gr4RIatmJE6A8K68iCpS1WM6SR7Pu/vAZXUxD41DxxzkFI3iidhjP7v1U4hNqKswqHF1DHvYZg7ehztrF1K536QR4ZEqpgLziI2dzwpKPoa6TOJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111733; c=relaxed/simple;
	bh=rQRBKGu90D3VIwT4rT9786sh1F6Ksp7n11KQLMHbI4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wky8HyPAFLdZBg1M2znHqO6c+YJdSyi7BdRCaq40n/dGBR1SNvAkAp3zDvFuJshrfpDhEGRdS6MsNyft2f/mEP6Ci8Mn/itR1Q75D076UXWTNtZJ3JMO6UJO8n0RbkcjEukXfLOlvgvqRRv7+b6KGWBl/9kl8ikODbmgZPabaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bVS0Fl3C; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bVS0Fl3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782111695;
	bh=319lTz1ceVETzXAILs5qMwI+USflR+yC6tjY8W9zrag=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bVS0Fl3CDjNCWKg7FejUshAPG1e/WQs58Fmvhe8PqRb6oW9XxZ0brMTevqBsvmzSy
	 1KtJaNXnE9jPczFcZBWKRWdxhj2NrGTSjhUsgR6qd3raevDRUEixhMY41tuiviE3VX
	 dPflzQqHOhNJ+hECZ0SxsL7c8FjaSI4B9D1vCY4U=
X-QQ-mid: esmtpgz16t1782111675t4f628c1d
X-QQ-Originating-IP: 8ryUe9248cB4IVt2wAtoTj7oaEBo6j8hELL3z+Krex4=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 15:01:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11017192551711522594
EX-QQ-RecipientCnt: 10
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com
Cc: akpm@linux-foundation.org,
	chenyichong@uniontech.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
	rppt@kernel.org,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 0/2] tools: Fix tools/virtio test build
Date: Mon, 22 Jun 2026 15:01:13 +0800
Message-ID: <A1DCE9FEF645A3F9+20260622070113.1207518-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260618080405-mutt-send-email-mst@kernel.org>
References: <20260618080405-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N921dkIbyDN3ucAvHNcG1xzTQaqUQW6N/VmX9sPSIz+SFjYLrQu5JeZD
	Y9r60Wscy/5/kv8I4bDxtAP5kCN1abIm1Yu87WnZNjCQckNmjgea722e7kynoupExkKM5aC
	YWypr3iwEuoQ7zz1l+QOGQ9t9YjdNMuKJoprT8KEShuZf66DRztfQvPnxVFEx/XuUGkt7y1
	VuRGSk/FkiqVVCB5XB59+cq53eF5zlxocRXQgRGUuTIjGo2DDxvbudpdRdxh8ujKBvEZ2da
	dDE5ct10SJO1V8KN5Aht8WfcZG3kyzyP5AoSoBQt47caceFo1tcsz7NJ/cy0sHCEJ2uAB7u
	yUSNKyqrkeGwAB9aaT5wec0P4kdD/GmYWP88KopjRRf96BSLfxxMXjvVnZsbxV2rtfc/Fn1
	uiJNYgaVYsio830MwxDEpDjjMP0+bcLHLF0uyJdjSnVQIJq16bPR9WAztS2RRgSLEnV+B/V
	t+Ik/SjdGjJ9b7Bzsn0Je4Aw10C25mAQiVRAn1VCSO+VGNFOrghdzOyDn+iA7qpKPIEIHGk
	wmUDIgZmHy0Y+6Jo7+lch8FbcY/QNBUCTdZ9yQPH4GAFUfErhGjMpgIYa8ViqJQC/mApiPw
	ZVssRQNfhpVICZ9F3SuyNQrEXxqfILFFFN6ep7xhdrijvC3f8BRu+6xH4vMAdHdYE3oqjxz
	kKuJr92UZ83gdpS9OGv/cHORwPcw5AS8qFayk4SMc41Z9+t7esOA/NVcbWjENZNY4fqC5IC
	4yczJ7CnO2ZI5KUNGOapgFvLx38hsJTzz5/xGS4wjUbP3F6mGflaEa5ENzH+hTXUAwR+FU/
	OeXcIN8cWHnRILFH6KGnjYCIAygZAmAb//7mHxGyY1v0x6zOvL5qlZvZJvCkQTzBiAJW58Y
	sTyIe0TYEdCUE9ER/lIkl+aOxn9IiaPkGNv789nIW8MyQ2JodTWkPRQ1+KxJs6fJxbqDltP
	UrhR4mZL9ALNSzKgWpdXuuhYuazU0loxNZMJpuqbaKeTbyd9DFPBeXnuv32PEdlxZhbkP8i
	D5jRgvEkm1zjkjsELa8ST4H4559MBk/5BDPOKoGpx2o0nqrqfEUBDDbSAJ1V8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Hi Michael,

I checked the history again. The tree was based on v7.1, but I had
unrelated local commits on top when I generated the series.

I rechecked this on a clean v7.1 tree:

  8cd9520d35a6 ("Linux 7.1")

The build failure is still reproducible with:

  make -C tools/virtio test

The first failure is:

  include/linux/virtio.h:10:10: fatal error:
  linux/mod_devicetable.h: No such file or directory

The two patches also apply cleanly on top of v7.1 and make
the tools/virtio test target build virtio_test, vringh_test and
vhost_net_test.

I can resend a v2 based on v7.1 with a base-commit if you prefer.

Thanks,
Yichong
