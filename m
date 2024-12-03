Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8121F706B
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238440; cv=none; b=DvO0DKyZsz5wjzI5xV+85+HYZDf89VCcvVqClTyoIgjbK0cOlnzRbKQUufkCtl0ne4PDar5hoZgysMBxupYVtzNJY0Zx7kSl5U9C/O8zzsJWbFf1hicvEYFj+6r7PkfOrPkW8p/fWLmcCLyndevH/+JLN+dRzs5aKjud35ObUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238440; c=relaxed/simple;
	bh=oHTER3kECGc7CIOHuxx4SO6NtWbnmsPpqQg9GmUoODY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrJEOT4XaiQXSrOI7tvXjixka4xtDvIp28XYg4NSwU2eMw0y1WMb9e+LplkAwi8LFkkszBwHuYmV8Nbl3bhIhure9t7Cuu5BSyfpnhtrvHpoC19OtFCtC+AFhRW3mpqMUQcD2v6OnGRCM9PldzjoL7qKHq7C1vqqXVZ5kaX37ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hRYoc9qB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hRYoc9qB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3CisFT008837;
	Tue, 3 Dec 2024 15:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h/hQDsUZ0WqQMvbrf
	aNILMaNiX0RhWMSf3/Z0BtexhE=; b=hRYoc9qBWhmW6x1KM3JxM9XcajurirLwV
	zn5t2WG0IG2+x6G1qTNM4csgI1YZUFGII3AB/VEsAe7eJ5uzY72yddv32USdGkQX
	yYVSQKf9vNNPeTI4JzdnxveWAD7joGPCnFRah6wK6eSjAJojsgrrhzTtoUlhbjp2
	QumahEJBIPGS+lApCvhY2Dkp8pLFJ2NGiisD8bPydXpR4zOAYA6fD6/2WVpVxIIz
	1SopVHH+CKeIgVaWf7uLSnyItLWwRSCFbWH6D6mG96SjGtaWNhlpQtte1eBs7hQc
	PjzMUNoKefH6/d+Lb6BHtDwojfg5Jy3cW9CpjwspazJm9HxSCrPow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgq7x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 15:07:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3DfHKv008622;
	Tue, 3 Dec 2024 15:07:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jh90n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 15:07:16 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B3F7Ets9634546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 15:07:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EEF05805D;
	Tue,  3 Dec 2024 15:07:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E161858043;
	Tue,  3 Dec 2024 15:07:13 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 15:07:13 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        pabeni@redhat.com, AVKrasnov@sberdevices.ru, mst@redhat.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net v8 2/3] vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
Date: Tue,  3 Dec 2024 09:06:55 -0600
Message-Id: <20241203150656.287028-3-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203150656.287028-1-kshk@linux.ibm.com>
References: <20241203150656.287028-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wI8VYMRXivoYEt4FnH8sh9VLWKMSfo-Z
X-Proofpoint-GUID: wI8VYMRXivoYEt4FnH8sh9VLWKMSfo-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030127

Change parameters of SO_VM_SOCKETS_* to unsigned long long as documented
in the vm_sockets.h, because the corresponding kernel code requires them
to be at least 64-bit, no matter what architecture. Otherwise they are
too small on 32-bit machines.

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Fixes: 685a21c314a8 ("test/vsock: add big message test")
Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")
Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_perf.c |  4 ++--
 tools/testing/vsock/vsock_test.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
index 22633c2848cc..8e0a6c0770d3 100644
--- a/tools/testing/vsock/vsock_perf.c
+++ b/tools/testing/vsock/vsock_perf.c
@@ -33,7 +33,7 @@
 
 static unsigned int port = DEFAULT_PORT;
 static unsigned long buf_size_bytes = DEFAULT_BUF_SIZE_BYTES;
-static unsigned long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
+static unsigned long long vsock_buf_bytes = DEFAULT_VSOCK_BUF_BYTES;
 static bool zerocopy;
 
 static void error(const char *s)
@@ -162,7 +162,7 @@ static void run_receiver(int rcvlowat_bytes)
 	printf("Run as receiver\n");
 	printf("Listen port %u\n", port);
 	printf("RX buffer %lu bytes\n", buf_size_bytes);
-	printf("vsock buffer %lu bytes\n", vsock_buf_bytes);
+	printf("vsock buffer %llu bytes\n", vsock_buf_bytes);
 	printf("SO_RCVLOWAT %d bytes\n", rcvlowat_bytes);
 
 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 7fd25b814b4b..0b7f5bf546da 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -429,7 +429,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 
 static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 {
-	unsigned long sock_buf_size;
+	unsigned long long sock_buf_size;
 	unsigned long remote_hash;
 	unsigned long curr_hash;
 	int fd;
@@ -634,7 +634,8 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
 
 static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 {
-	unsigned long sock_buf_size;
+	unsigned long long sock_buf_size;
+	size_t buf_size;
 	socklen_t len;
 	void *data;
 	int fd;
@@ -655,13 +656,20 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 
 	sock_buf_size++;
 
-	data = malloc(sock_buf_size);
+	/* size_t can be < unsigned long long */
+	buf_size = (size_t)sock_buf_size;
+	if (buf_size != sock_buf_size) {
+		fprintf(stderr, "Returned BUFFER_SIZE too large\n");
+		exit(EXIT_FAILURE);
+	}
+
+	data = malloc(buf_size);
 	if (!data) {
 		perror("malloc");
 		exit(EXIT_FAILURE);
 	}
 
-	send_buf(fd, data, sock_buf_size, 0, -EMSGSIZE);
+	send_buf(fd, data, buf_size, 0, -EMSGSIZE);
 
 	control_writeln("CLISENT");
 
@@ -1360,6 +1368,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 	int recv_buf_size;
 	struct pollfd fds;
 	size_t buf_size;
+	unsigned long long sock_buf_size;
 	void *buf;
 	int fd;
 
@@ -1371,8 +1380,11 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
 
 	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
 
+	/* size_t can be < unsigned long long */
+	sock_buf_size = buf_size;
+
 	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
-		       &buf_size, sizeof(buf_size))) {
+		       &sock_buf_size, sizeof(sock_buf_size))) {
 		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
 		exit(EXIT_FAILURE);
 	}
-- 
2.34.1

