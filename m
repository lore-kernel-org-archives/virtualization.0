Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA21E5731
	for <virtualization@lists.linux.dev>; Wed, 23 Oct 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717266; cv=none; b=tSm0kDoVJDRlDLtYxoW4DXOXWdFkh9JVvLCg9JcImFh4LqwYa7y1CNpEP9HA4yMVVpxpBY4KfBu52OxJ7APxoRC27SEHUh98ZV0nnBeUBLFqREre+u15jY84pLRofmM7yR1CNeYTPeMAtQZMd5ps0OzWBf1R/Azo/0t5ZX+VSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717266; c=relaxed/simple;
	bh=EQSt6977Vxtwd5RLu3DQSUzvHiDtQP1bTYd4yi99WFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qaCVsyNKfF8CDelDfyxBEL8HjqezzR2+UfwbJdLqrHddotKSZyAxYGNzGN9Fd0/M0/gclgp2c+PVHbllK44kwsS9PFsMgsonnhH/4FJHA4+7T1zFLiLMgxE73x5AAGJGzNvwsxkouOa52m3Dw3/SpGQVFoyTLmigF1dewmru88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HrMOyam4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HrMOyam4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDprQp014740;
	Wed, 23 Oct 2024 21:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wa0fgwkLYV31ELzbTX3BJAd0TjNsbG2SuK9Xo+Gio
	tU=; b=HrMOyam4EkqpwOMPAyTJWBbE4OLpN6Z5jsstdqfQB+x4FWNSUBweyP7km
	PxuJEFUAlX/BXRTjbZrzM8uNCnT5+25hz/pjuwmpzWMhUcalyo3rnziqzf+gQ1Hi
	zDXsYnI6EtqhIPFhkSDwH2WO5qoltAVhrPyoYa8zvrLsLCT2HOU35cBPPJAfv1O6
	rVd24WIhlZ6VpOtzDYF9SJXnia+T0fZ0WoX1iA0JT7/CIRAtprHJd7yPCfltt8xA
	BpAHT5Ry3SD2FsENXxhZqmJVmrF4g8ZV9reHS8c+QxoTvlIDKhAqqyQFHDRrgSuY
	32HuasiGI10HYkk4MViVihXjAyLPg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadw669-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 21:01:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NIo3eQ008791;
	Wed, 23 Oct 2024 21:01:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkamxnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 21:01:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NL11L744630276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 21:01:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C3CC58055;
	Wed, 23 Oct 2024 21:01:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3886058043;
	Wed, 23 Oct 2024 21:01:01 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.214])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 21:01:01 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH] vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
Date: Wed, 23 Oct 2024 16:00:31 -0500
Message-Id: <20241023210031.274017-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1HAwbZ2oyvtICjB4a0P2mSq9JMRcyTjI
X-Proofpoint-GUID: 1HAwbZ2oyvtICjB4a0P2mSq9JMRcyTjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230134

This happens on 64-bit big-endian machines.
SO_RCVLOWAT requires an int parameter. However, instead of int, the test
uses unsigned long in one place and size_t in another. Both are 8 bytes
long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
test for the exact size of the parameter, it only cares that it's >=
sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
returns with success and the socket stays with the default SO_RCVLOWAT = 1,
which results in test failures.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---

Notes:
    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.

 tools/testing/vsock/vsock_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 8d38dbf8f41f..7fd25b814b4b 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -835,7 +835,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
 
 static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 {
-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
+	int lowat_val = RCVLOWAT_BUF_SIZE;
 	char buf[RCVLOWAT_BUF_SIZE];
 	struct pollfd fds;
 	short poll_flags;
@@ -1357,7 +1357,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
 static void test_stream_credit_update_test(const struct test_opts *opts,
 					   bool low_rx_bytes_test)
 {
-	size_t recv_buf_size;
+	int recv_buf_size;
 	struct pollfd fds;
 	size_t buf_size;
 	void *buf;
-- 
2.34.1

