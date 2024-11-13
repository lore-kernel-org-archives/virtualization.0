Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA84C6C
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508570; cv=none; b=eWy7dkwGjJY7hgCzMSV7PqMjlfsZuAnavycJtFmhmUJNtdfqdORmcwhgV16zh9j1VkfZ3Bl7P10HT5tm2AR3WxxMg3zFCPJOHmW1Asp9f+xzQgYSJL04YP2J8neNOW+3pAyGA+dZLfiB3HJKa64NiqEH+K662+dlIRvSOEJ6eA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508570; c=relaxed/simple;
	bh=vWvyO67zuD8NBnU9gxfvVn3EExRr8p8tay4D/9Payrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IaZPPRAOzFYdA5Uwwy7nuKstxPCTzY2KkbpdjbL6kPxciDlfYu4Dr94H6CH02SmH4TX2J2MbKvt6UlLhzlLXbmbxX0lWG7EKMpYwyjMkfjCErTvHRmlAjqey5QF+OYqYG9xeq33Kd4dFO4zU22iF8BXrpWY0zKA/31HMqwRpq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TfYRTuFr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TfYRTuFr"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDADUI006642;
	Wed, 13 Nov 2024 14:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VBhYf8x22aJ2KcZ26duuP4JHVVn3RZuFlMuWVL0zI
	54=; b=TfYRTuFrWCtGYANoK7AjQTWTFYm/DCtIq3C8t0fSZhga01P8I64I4rxn7
	lj44CDdL9iNrv2TLUWMVmvG5s+1rxqGvV5R8BuweWkCVHpKAF4m+WF1nVM6L/4LI
	1Z2Cp3xm4dB9rcsUtWoOHu0GxMUdah7rN26BrUBwJO8lbkN/V+Id3pxwVb81PntR
	5rqD5qq4EVAWadpz8qkt3gCUFIbFr8VrW3qUBL/9c7j0CGidTkroz+TMrHr18MtY
	jnC75YllNgvZI3wlRIOGGDPnSOXd1xXX8xtlqAPfUnTS+EZlOjsRlXYsXMBbEqYV
	m659ZUDUvwUhp0QcOHWVx9/HC7QCQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vvrm8ct3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:36:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDc2MK008392;
	Wed, 13 Nov 2024 14:36:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjeywgnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:36:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ADEa5m935324436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:36:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D5C758056;
	Wed, 13 Nov 2024 14:36:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72E9258052;
	Wed, 13 Nov 2024 14:36:05 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.austin.ibm.com (unknown [9.41.105.143])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 14:36:05 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com,
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v6 0/3] vsock/test: fix wrong setsockopt() parameters
Date: Wed, 13 Nov 2024 08:35:54 -0600
Message-Id: <20241113143557.1000843-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hTBPcgjkzKEbMhOX23qr7-7n4_vBci6i
X-Proofpoint-ORIG-GUID: hTBPcgjkzKEbMhOX23qr7-7n4_vBci6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130124

Parameters were created using wrong C types, which caused them to be of
wrong size on some architectures, causing problems.

The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
didn't show it. After the fix, all tests pass on s390.
Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
a similar problem, which turned out to be true, hence, the second patch.

Changes for v6:
- rework the patch #3 to avoid creating a new file for new functions,
and exclude vsock_perf from calling the new functions.
- add "Reviewed-by:" to the patch #2.
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

 tools/testing/vsock/control.c             |   9 +-
 tools/testing/vsock/msg_zerocopy_common.c |  10 --
 tools/testing/vsock/msg_zerocopy_common.h |   1 -
 tools/testing/vsock/util.c                | 144 ++++++++++++++++++++++
 tools/testing/vsock/util.h                |   7 ++
 tools/testing/vsock/vsock_perf.c          |  20 ++-
 tools/testing/vsock/vsock_test.c          |  73 +++++------
 tools/testing/vsock/vsock_test_zerocopy.c |   2 +-
 tools/testing/vsock/vsock_uring_test.c    |   2 +-
 9 files changed, 204 insertions(+), 64 deletions(-)

-- 
2.34.1

