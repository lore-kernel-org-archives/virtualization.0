Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051522424F
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491647; cv=none; b=snaqrBg6kLkokkSAkDG/MmMxtNrBSSKytjHtNNGvcLAvnUDWDf2gfv8QEE9GUwCsM9Ap978hjeBbIAMpr8Qhy9MY7yklN0A40yeJdmrBdrzgzAHmshrCym0wTXagF/8MDdq4sP6B8JO7eKruB3PIBjDbRhJGIDOsPUoDyNktKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491647; c=relaxed/simple;
	bh=MqcLRUu96fTKIOWZKIriMSE7yNMM8EAW7vRREecywYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ldGiiD1pHu88bBtYFLLgxHhTX+KzlJZlP9KRBSh8c5gzKOuqT/tyU+gZqRONP7Xta1wTi/GoLfs/THoU3a+l7GvGwBpSgD5XfKNADL8amK2yJyCTW8QJ8BNG9w4Jn4AzD414gai8+PYu/Y7/+XPNO7XK8WD67dQ/+VqhwOOD4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YVui7oao; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YVui7oao"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCVxsi030670;
	Thu, 20 Mar 2025 17:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hcg9LHEojm99piejacT9SE10T3fhELJm2itDDNWmi
	HI=; b=YVui7oaoAaMbLPTyVD6JLCAHDlQst18UTRMZNYDqPkJDXttZtG30EPuRN
	zuL19Yaf1Hs0Ay+dGhjilIm1NH9I8szx33ff0gpuAFOjdNNReyaTiLKQ6uoyb1/5
	E2bhJemkByeOmSywoliaLCPdgcG89I5VpJ1iJ7OLgqgAI373V+7peTpThMLJz7Py
	9utZdk370qiJWEQEmBeyeLU0IEErqfkuIh153OPdCTat/9YOYFfKrWdWh7kuy40h
	1nJHH8DQ6CBqtklw5o+SvDB0jGqt0mzeCc8gy4vKjN7F8/Xf+Ke3rkzy+hPOwYOT
	Q6F+Xdk+rhWKS6p84VzW7ktyl8Iog==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gbd9m3hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 17:27:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEEprk005628;
	Thu, 20 Mar 2025 17:27:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm909a21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 17:27:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KHR5tV24773360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 17:27:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8851A20043;
	Thu, 20 Mar 2025 17:27:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB40920040;
	Thu, 20 Mar 2025 17:27:04 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.ibm.com.com (unknown [9.171.57.148])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 17:27:04 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        mst@redhat.com, pasic@linux.ibm.com, amit@kernel.org,
        schnelle@linux.ibm.com
Subject: [PATCH] virtio: console: Make resize control event handling compliant with spec
Date: Thu, 20 Mar 2025 18:26:54 +0100
Message-ID: <20250320172654.624657-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WaGrOWOrmvhaqAhKVTrEGjODcOodk1UU
X-Proofpoint-GUID: WaGrOWOrmvhaqAhKVTrEGjODcOodk1UU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503200111

According to section 5.3.6.2 of the virtio spec a control buffer with
the event VIRITO_CONSOLE_RESIZE is followed by a virtio_console_resize
struct containing 2 little endian 16bit integerts cols,rows. The kernel
implementation assums native endianness (which results in mangled values
on big endian architectures)(a seperate patch by Halil Pasic will deal with
that issue) and swaps the ordering of columns and rows.
This patch changes the ordering of rows and columns to columns then
rows.

Fixes: 8345adbf96fc1 ("virtio: console: Accept console size along with resize control message")
Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: stable@vger.kernel.org # v2.6.35+
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 24442485e73e..9668e89873cf 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1579,8 +1579,8 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__u16 rows;
 			__u16 cols;
+			__u16 rows;
 		} size;
 
 		if (!is_console_port(port))
-- 
2.48.1

