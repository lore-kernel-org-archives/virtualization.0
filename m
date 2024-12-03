Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAD13B2B8
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Dec 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253432; cv=none; b=GA8BPfQhmH325bgz9bs/JbJVu1i4TORSm46KJtJQ0Z4lhWPJsSXEHOqumaO1JkB14knLhOl1R1OYx4XaHypbDu7QUQdF7V4hW2mC06/lm1VkwgXeaUTmVpxCknJlCt6JnLgN2dYXH56Wg2gBwdau6x9WUkNnWZWzBIMHnHZTttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253432; c=relaxed/simple;
	bh=k5O7DAp6vfkbonZQML+9XMYQ0zCC34xZlufUGtqimW0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DXDuyMZd38t9d/kpqwCCV4Nv0SVTLslxsds1tTTKaEgLxDdCRflKLdt2mFXe5wNkBEdN5MO5Vw0XvIInmR5ffNGrfEh2qxAGpWTH1joaDG1oUaSKlSltWAbFU5OGvOBo+fF7g1N6MbY9xe2xOTh/eT1Am6B1bGUnQsA0YPhQws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UGQNHDkV; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UGQNHDkV"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1886A6159A
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Dec 2024 19:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.49
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IvgKmWi-WF61 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Dec 2024 19:17:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 44DD06158B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44DD06158B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=UGQNHDkV
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44DD06158B
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Dec 2024 19:17:09 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3HtZfR030203;
	Tue, 3 Dec 2024 19:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=k5O7DAp6vfkbonZQML+9XMYQ0zCC3
	4xZlufUGtqimW0=; b=UGQNHDkVVABqcZKGtwWDc2d0IkgXvZXt+hit+iyFip6hi
	QvleE/3OV6EwkEAs6SV9AZRo0wTWFfY/C1rVqJ+pEJ+UDlRDaXUI1r9ksbBetdpP
	WyOfyJQoZ/l+j7bBEtL0rc/dRe5BkesOY7t9uYfx55Ng3HqCAnd3DOcvPtVD/5my
	+WCA382Bn6AF7MQ4aiKSiLJ9sWH3smD+tAqtMbpZRVeWHO8JB6knGgVRya9u6obT
	VMjIK0av8ZfKoW2dkwP2zmNNA7SWOjUb1KUgQho3Bdt8DvlL6/N7FUXrGyVyvlv9
	tVNaRdjkdKbOtqNSVU2fbHMpLzectOAejrnKZRXwA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas6sar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 19:17:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3I0jN5000822;
	Tue, 3 Dec 2024 19:17:08 GMT
Received: from mnc-mac.us.oracle.com (dhcp-10-65-163-31.vpn.oracle.com [10.65.163.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 437s58ak94-1;
	Tue, 03 Dec 2024 19:17:08 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, pbonzini@redhat.com, target-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/8] vhost-scsi: Memory reduction patches
Date: Tue,  3 Dec 2024 13:15:07 -0600
Message-ID: <20241203191705.19431-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_08,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=770
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412030159
X-Proofpoint-GUID: wS9Lbh5xAnCYp_cQcufmP-WT-iWpUr0q
X-Proofpoint-ORIG-GUID: wS9Lbh5xAnCYp_cQcufmP-WT-iWpUr0q

The following patches were made over Linus's tree and also apply over
the mst vhost branch. They reduce the memory use for vhost-scsi.

For a simple device with 1 queue and 128 cmds we use around 25 MB. These
patches allow us to reduce that to 8.2 MB when supporting up to 128 8 MB
IOs (the current passthrough max size).

For a more complex device with 16 queues we use around 2.5 GB. These
patches allow us to reduce that to 77.1 MB when supporting 1024 8 MB IOs.

v2
- Rebase against current trees/branches.
- Fix email threading.

