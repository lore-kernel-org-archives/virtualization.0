Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CC136E05
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218479; cv=none; b=JDH/vPbrwt5RctKt/+v+NFDQ78l69aD+4OJgX21jgnLPHcfi6lli6YzeVtfOP/eYtePDRUMO8T/4leWn9AbKE3FeN+x1z97gxTQOVYlq/jYQ6iMtw3/6dtMcpqmqa2auE+z1XOCmJm9J/Ya8i+4Yon0TD3wNEe7qNeWkEYYloic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218479; c=relaxed/simple;
	bh=V2eBgGmN6lPZIjeppPTRl+kJSvEQj2BfLxHuAEveWws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l7khf7a8x4qtVvVCtuuVjis3vF3EibxfIRi99BChvNWu5g9g3RNBjT3W6QCqrWjP0ZlBANzjxAfL5CU369vlpbfX2HDaYhDIZ7l9aY+KeSppN2xtGxYY54WJmHMpyJynWfwiRHmpEH0KCgfwHhjEkcGPLrAgqu9SpP0fBx5coM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kPWN9hRT; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kPWN9hRT"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA4804054D
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ouQvvRN2vC1R for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 15:21:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 37DA14052E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37DA14052E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=kPWN9hRT
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 37DA14052E
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 15:21:16 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KEPKuZ027893;
	Mon, 20 May 2024 15:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=fISmQfEMf2/rDg/w9UA/s9DtZTN/+2SzLGbgOVR/jS0=;
 b=kPWN9hRT/M6zjGCHbF/aCZ/tffzGA8F992WwG+46k1diZOhZwH8DlfrRMp3XldiUYgHX
 yrvUXtr3t1l62NK+DCAwJGmz4oZMDM7Rl6DqW9f5mF5UK1/LZ4rPNi8TuDYw1NkNKu6Y
 MilfRYgvblw1w+z0U+PFXYtHhS5ipej4q4qh7yoVFeVNlVd7qh08LLYeFYCmQQXvblqH
 qmLmjBCiOpkDySdhyfiawUhSy1Zcpe4yuyo8dOXfYVuWgDUNvsEY/c6phqTf7O2TIrTs
 3ak+eRayw4WWfFyKS9MtrRypSr/a36dpU+FdnaDTa+PozQLWGNidC7doAlUQj/8IAzRR Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b2smy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KE2nQU002749;
	Mon, 20 May 2024 15:21:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6cy7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KFK19X038962;
	Mon, 20 May 2024 15:21:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js6cy5w-1;
	Mon, 20 May 2024 15:21:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 0/3] flush workers on suspend
Date: Mon, 20 May 2024 08:20:59 -0700
Message-Id: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=571
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200122
X-Proofpoint-ORIG-GUID: gqnrVHdfhIowfQbYlsHHmaNKxkrIMo8s
X-Proofpoint-GUID: gqnrVHdfhIowfQbYlsHHmaNKxkrIMo8s

Flush to guarantee no workers are running when suspend returns,
for vdpa, vdpa_sim, and vduse.  (mlx5 already does so, via the path
mlx5_vdpa_suspend -> unregister_link_notifier -> flush_workqueue.)

Changes in V2:
  - renamed "vduse: suspend" (was vduse: flush workers on suspend)
  - call vhost_dev_flush unconditionally in "vhost-vdpa: flush workers on suspend"

Changes in v3:
  - rewrote vdpa_sim patch

Steve Sistare (3):
  vhost-vdpa: flush workers on suspend
  vduse: suspend
  vdpa_sim: flush workers on suspend

 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 16 ++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.h   |  1 +
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vdpa.c               |  3 +++
 4 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.39.3

