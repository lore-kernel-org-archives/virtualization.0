Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE5242913;
	Tue, 25 Feb 2025 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475311; cv=none; b=CQ7C9Gd2XUoDhpAVPcJJ03BCaboT1qy+k2PdM7DgzykguK9eZWb1dUNV5de9wk5vaoYRF1FxRPXpej8E8b6LqfXG1YtsiKCXlk2BXvWVXdEC7JUYROxbGgy4QUqtCq9H8U3aJQE9405wnX4zwS1rEwz7VhVZfWinro/jrWkNONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475311; c=relaxed/simple;
	bh=JyNOQvzqmUn51V0d92KRSJ6eRcVIn3Yww23zfrVDL54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IO3+pdX536S/ErD/VQ9Yx+4IynUMhw/WHiyUOJqEyj6Rw14duM2McYysV56fSh3kmlsszGZAFOpED7jhHxCRqQB29APFzYHoFy6vFFnoXwzWF4cIcBYxTwTCSycYMHHDwTT5Vj9peXsmLEs4TqCKGMlScYarXnfF5lekXmTZ52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjqIBeyD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjqIBeyD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P6PXq4019441;
	Tue, 25 Feb 2025 09:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5+drL0zdm39qhap2TEZNvewTHtRKjJk1QxMeZnwbS
	xM=; b=IjqIBeyDWH4QNZckBTC7gsbPwFPJ1OBMHcEWpYkpcfeNiis5rb91xFmpM
	JYOckG8r+4kJq2th2nmT/GGiVe3HI5QM+QA0AkWE06dDuzSGGGmxCTlwTXCoSkPc
	CaiCa06pcIlgqI9544GYVw67hLryrO5JixuCaouMeck9nslgmqyWYckldj7aENGa
	Jr0h2SBwf+HIgn4IERmaY1oMWeBm4xfGivJmo/IReObLX51kmFJtZsok2RRdGqhT
	QIJ6ewm3kQ+iG4pe5HbXLoNy2OEGN51Pcm4FFxMaV71fUx/rlq17tdtEoq7HrckL
	KfDoWsM7+Jl9JrbHXB0ljbVa2Wz/g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4518k68q8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:21:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P87kZY002578;
	Tue, 25 Feb 2025 09:21:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jkps7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:21:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51P9LcjZ42991970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 09:21:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38BE920364;
	Tue, 25 Feb 2025 09:21:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F99C20363;
	Tue, 25 Feb 2025 09:21:38 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.boeblingen.de.ibm.com (unknown [9.155.199.15])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 09:21:38 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Cc: amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        brueckner@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
        maxbr@linux.ibm.com
Subject: [PATCH] virtio: console: Make resizing compliant with virtio spec
Date: Tue, 25 Feb 2025 10:21:35 +0100
Message-ID: <20250225092135.1200551-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wvEaYDokX0k1_5WsJP9rVDo7PQRAgsm6
X-Proofpoint-GUID: wvEaYDokX0k1_5WsJP9rVDo7PQRAgsm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250061

According to the virtio spec[0] the virtio console resize struct defines
cols before rows. In the kernel implementation it is the other way around
resulting in the two properties being switched.
While QEMU doesn't currently support resizing consoles, TinyEMU
does[1](and they implement resizing according to the spec). CrosVM has
prototypes for virtio console resizing, but no user[2]. With the JSLinux
kernel[3] and alpine config[4] resizing the kernel works. It strongly
seems that they patch the issue downstream as patching their kernel to
use the upstream ordering breaks resizing.

[0] https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.pdf
[1] https://bellard.org/tinyemu/
[2] https://github.com/search?q=repo%3Agoogle/crosvm%20virtio_console_resize&type=code
[3] https://bellard.org/jslinux/kernel-x86.bin
[4] https://bellard.org/jslinux/alpine-x86.cfg

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

