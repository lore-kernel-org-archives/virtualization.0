Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B5368287
	for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777004; cv=none; b=pTTD/+vGgibcsA7V4JEaG4b4dlYiPUUoQ1qoLVxg1/UPr56/wdlq+Yi8dWNbgoguI0ZezhikmIf4d4Tr9VcMGYIrw1FNOfyp8WinQa78EJZpingfkqKp1UGLLAOMyzXwBQ+ELDlRnGzwuLcsutuO6Yciy087atekXJAqR4TetwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777004; c=relaxed/simple;
	bh=UkptgKoZfZhe060t58H6/G+keg5rJ1MCWopaac/NyLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0xnjaCPcVWenyEBUIkitUCjMqeNt8pOcAHGMdrA22e4AGUUrOA2UBZdni4eR3KHAYGYVV/9p+O5R4VP2xYZGAAJG4wszbOiH0RQEKurhhmppjU7PO78tkImd2/xxSm+2FEp81Ki0x09Pb1JBP9J5jkEjfmcpcqpt+6c+0CiAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iVMbuC5k; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iVMbuC5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781776988;
	bh=DOps3CBIOHkR5KfN6p/UEwR2gyTD3H7CZcczicfEPj0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iVMbuC5kbYJDI8I12c6Pzh2dpeYGY47PS22ZTuLe5CVz935bDefx9Ux1f427EPKcW
	 SX2u4tFO/TMkyI9CZuiDeWfe70iPlh2iriVsdc97zhX7kdVelFKPJjRc7M5a7qPGnW
	 mIS4uwnZ7l5R0YHFOt/7S3ANdPHuGPYmiI2CpCe8=
X-QQ-mid: esmtpsz16t1781776983t48bdbb7a
X-QQ-Originating-IP: B9ZyRkMibcH5r3OaJ6XGsQIY5m6swmYH0qlgGp6nXEE=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 18:02:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10844846694893973104
EX-QQ-RecipientCnt: 7
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH] tools/virtio: Remove unsupported --batch option from vhost_net_test
Date: Thu, 18 Jun 2026 18:02:54 +0800
Message-ID: <E091F15D8FBE8F16+20260618100254.513806-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MhvVYtZeQ7htovJKFccWvrGEMDP19SGh5511j8+UuJjIXW3PrL3gKJco
	KUfE0QpVX0nhWq0AV5noumtB5NdYSTj2DefgIi+t621jOidZngXTOAx6UuUEnpAajZorp/B
	JYrXRlMpH6SuyjXshNXT2D582o81NVBHEhVBh20nylMKLRcA3RQiA69klyd+fr7pb3xTbES
	5EStFn1OO5n+HtcQc9WW4Wi1s44RTKKi/kN0ax420UJ8Ia1DV54ftRADa4UwdtSeEFgCg2E
	8v5N3iLeUqxrIInCd5B6TcvrZ75gFdT1DHKdCKO/Ic7/ARaDwOpJfqHe9Nqxkz3NfOHCzaL
	u5oUIPakRD0E8Y1/LqaDTBfkFHSRtpMV8PCPiQsqj3jZ+jT8Ukv5APH1h5gmhomAK1znlmI
	ODruHdCILYPxFk81r3slJDdAAy2ePgJ4lsrpbU9/OAafPTrCtTuuNID+SnJ0jcffM26flNs
	osbOvMwx9K1umhF4dwqV+zBFJg2DPDJ17MW4SssoE4Ilw8TNAUVUffoSSzD/mpArGDt7/2X
	sucZ2xv3pp4up2HiWgN/GMYXUrLo1vI64to4PvAMbjtPtiw94NmcXSM0aPSdsXMQkf5HDw0
	Kc2B5DBihcU7HHARh+tiwXM6CBR7dQczqVt7gmMki4wBEnn1k4Ak64OFOYQjRZpBnfSESWs
	ovltve4EJ9o8ur9AU1NtcYoXVuUYfSW4D6TR0DGh8JKs/EeHEf3ykf9ZZl3SAgYtQjBaCYO
	w94gEe1xzQlZ/kvRGW5hrb7sJcn90z3eURePxVtabmS5J5fhU8DnA/jHtFFn1X7eeqoEcy9
	MganzqqRCJYRUYE/AkOdOtVdUyed801e7aTTFEnyAwm0IfpEfDvtOVR+9yZgqR5dyTtgQWj
	pmmZCMa/aKYSb/UoRtENssBelwPRfNrkABIuS5OCboBBBH4eRkMXos3s/i2j0nGSRd38AJG
	bX/eQI4gyUBwo0suHKv1HlGjdUk5Tl0FSqMjVeHDUOx5R8DLDkKy5pbiQxKeLQfKSMjqK7b
	JhalzYexr5iUkGoJQyXxj5mrofJg1mfT8diS7TRA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

vhost_net_test has --batch in longopts, but not in help.

The parser never handles 'b', so --batch hits assert(0).

Remove the unsupported option.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/virtio/vhost_net_test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.c
index 389d99a6d7c7..566e15420bb6 100644
--- a/tools/virtio/vhost_net_test.c
+++ b/tools/virtio/vhost_net_test.c
@@ -450,11 +450,6 @@ static const struct option longopts[] = {
 		.val = 'n',
 		.has_arg = required_argument,
 	},
-	{
-		.name = "batch",
-		.val = 'b',
-		.has_arg = required_argument,
-	},
 	{
 	}
 };
-- 
2.51.0

