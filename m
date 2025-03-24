Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697F6125
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827391; cv=none; b=QmRaZ/MeEBBkIZSw2mFqOeaCkD0HoAZJ7a46oPZJRqlToamNJohYhEG1qwc23LWEDtkeU3/Zfv0KrUwjF0qQ17rt4YZ/o2Q6jjV16gB8YDsVrAkK1MkNiS5hYYNrAeLsYDMNyz6C6EAOz5qzXpoX6NgCA4S53bCcbAZSLr1FjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827391; c=relaxed/simple;
	bh=PYEbY72dpy4AhFJgdkxTlgNmyXa6hqElQV4pCL3kHKM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hwbef4JL1aQJVW0dHbpk4wijIcJpbHieemjHPXutmNgvZYoIUHSZhiJ31sZ4kKEWEzCQT0IHJWCsnu/Ep6TYnVttCM4rUYe/mSbkP8g1adc3Z1lNcjYpUyjkSuWya5zx1+Ye6Qmm9dQx6HKYbH9iR7hvVfU0mefJjcBm5LqQqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X/7wDzge; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X/7wDzge"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O95uTL015822;
	Mon, 24 Mar 2025 14:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=T7LEL+GWUh8MURVuH+jQFBh6NvGbG9blBlZjqcl9A
	Pk=; b=X/7wDzge9tGTN/HUChj4ZYQxuQFNYXdrjs+KLSZsldyJYn0EeXaS95rzs
	Kdtvn5xqGzwMy7yT90GpN5c9ad2WzxnM27G/6SWEV8Ds3arRarp5Hx2fT5hh0t4C
	y1HbZRRsKblCDEbbJO3HHJj8nCXrFX9WBKUJa6kkeRdUUWNH34PMcEHhex0ozGOI
	R7lL6sjTGy3H/sQOVxmGMSoUIahlUKIehYERPa6q/NZ3VTt4qVXS/MmcNJW7wNzi
	KB2FBMJHUHo0PBSbZXkwJwIG0QUvjR9U7AeqDrjUhLH6sSZ6pccgNFsGW174+j0B
	t7ta/y3sEOc+p5YmSN+iIeytrg7Hg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh04444-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:43:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52OBWMGZ025443;
	Mon, 24 Mar 2025 14:43:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7wyxsv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:43:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52OEh27N17039636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 14:43:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A401220040;
	Mon, 24 Mar 2025 14:43:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76E522005A;
	Mon, 24 Mar 2025 14:43:02 +0000 (GMT)
Received: from li-9b52914c-2c8b-11b2-a85c-a36f6d484b4a.boeblingen.de.ibm.com (unknown [9.155.199.15])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 14:43:02 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        mst@redhat.com, pasic@linux.ibm.com, amit@kernel.org,
        schnelle@linux.ibm.com
Subject: [PATCH] virtio_console: fix order of fields cols and rows
Date: Mon, 24 Mar 2025 15:42:46 +0100
Message-ID: <20250324144300.905535-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vE93AZ2pvJg3DIzgj0W27JR_y5BfzyHy
X-Proofpoint-GUID: vE93AZ2pvJg3DIzgj0W27JR_y5BfzyHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240105

According to section 5.3.6.2 (Multiport Device Operation) of the virtio
spec(version 1.2) a control buffer with the event VIRTIO_CONSOLE_RESIZE
is followed by a virtio_console_resize struct containing cols then rows.
The kernel implements this the wrong way around (rows then cols) resulting
in the two values being swapped.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 21de774996ad..38af3029da39 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1579,8 +1579,8 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__virtio16 rows;
 			__virtio16 cols;
+			__virtio16 rows;
 		} size;
 
 		if (!is_console_port(port))
-- 
2.48.1

