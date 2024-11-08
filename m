Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21391BD9EE
	for <virtualization@lists.linux.dev>; Fri,  8 Nov 2024 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028667; cv=none; b=anDGjSZWg6LjOrWlwNzyCX+91CS4HpjBSpU9/WREe1cUUHlqcQ1knsn2TAB7IWq4E+Ad/S/jw9ijK9IQlcGeN7CItG2DP4KXtCSOS7hyvfpzmUCBUb1avt2Lbw/kPZ0iJwzP91hwQwMNTMXhEozUVLTMBah4zKQPRFGHRwxGySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028667; c=relaxed/simple;
	bh=TwWOR+TWSUf+I8vkPN4Q/KWWabdz1kTUv4R9RmjRv5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFDF2167ay8cPnAsH6DxXpJwo6uhfzl3Kfo+kRFoKisFrJT3pGoJAyaQn5UBITwfAI6p5I6bj+jm0AkwkmskXvzqPyNtI4wBCq+eeO4GRv+zJbH+Yw+HtgjfE6NOEvwUEe7yolonREsgnBvhHZyj1scAk2egJ0hR0NAIjCFtphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZhgyhZSP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZhgyhZSP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A81A2Np003251;
	Fri, 8 Nov 2024 01:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=G5MoYnu7dexdAQGZXU8GUwap7fX+vgmlsnxIUgqgQ
	H8=; b=ZhgyhZSPLVQVLtDmjnfHFCLqJ4ShSihrElLzRivf9ukCuEpUTI029x7o0
	X03wpql7RJq+2skWVHv2eOomfsgMxNCHU+o5uSIl0F6HgBAagqbyu99NNuAbeygT
	6AdWy/u8ZaG85ybELS2b0xWsSyYHstJ+dir0M0TColoXVkVGBXz+7R/gC5ryLKW/
	cekKo3CK0P3eFW0YWXMAYZbzWMMIZXtP8zd8349Ns2ux3e67O0YbhDYOcyGcLaaL
	f95op4zag3R3UPUQiGjthnNwq0PpPU9kJftpQ3qpHAdKHb2ENZ5n6P9ZjF3w4fuC
	5EE3D5c8Ebuwi5saVs/mKKesgp/7g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42s8r380yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 01:17:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A80mOkF008423;
	Fri, 8 Nov 2024 01:17:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywmcaeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 01:17:41 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A81HeMq21168718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 01:17:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16D5658054;
	Fri,  8 Nov 2024 01:17:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 990A95803F;
	Fri,  8 Nov 2024 01:17:39 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.11])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2024 01:17:39 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v5 0/3] vsock/test: fix wrong setsockopt() parameters
Date: Thu,  7 Nov 2024 19:17:23 -0600
Message-Id: <20241108011726.213948-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rpcoGUd6LHhCoen8Hg8-eEavzuf1v4tq
X-Proofpoint-ORIG-GUID: rpcoGUd6LHhCoen8Hg8-eEavzuf1v4tq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080007

Parameters were created using wrong C types, which caused them to be of
wrong size on some architectures, causing problems.

The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
didn't show it. After the fix, all tests pass on s390.
Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
a similar problem, which turned out to be true, hence, the second patch.

Changes for v5:
- in the patch #2 replace the introduced uint64_t with unsigned long long
to match documentation
- add a patch #3 that verifies every setsockopt() call.
Changes for v4:
- add "Reviewed-by:" to the first patch, and add a second patch fixing
SO_VM_SOCKETS_* calls, which depends on the first one (hence, it's now
a patch series.)
Changes for v3:
- fix the same problem in vsock_perf and update commit message
Changes for v2:
- add "Fixes:" lines to the commit message

Konstantin Shkolnyy (3):
  vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
  vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
  vsock/test: verify socket options after setting them

 tools/testing/vsock/Makefile              |   8 +-
 tools/testing/vsock/control.c             |   8 +-
 tools/testing/vsock/msg_zerocopy_common.c |   8 +-
 tools/testing/vsock/util_socket.c         | 149 ++++++++++++++++++++++
 tools/testing/vsock/util_socket.h         |  19 +++
 tools/testing/vsock/vsock_perf.c          |  34 ++---
 tools/testing/vsock/vsock_test.c          |  64 +++++-----
 7 files changed, 231 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/vsock/util_socket.c
 create mode 100644 tools/testing/vsock/util_socket.h

-- 
2.34.1

