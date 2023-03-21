Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA91C761A6
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 02:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FF80417EF;
	Tue, 21 Mar 2023 02:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FF80417EF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=vAet4Owe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJs4VoOy3fEA; Tue, 21 Mar 2023 02:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 65CD941816;
	Tue, 21 Mar 2023 02:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65CD941816
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C6FEC008B;
	Tue, 21 Mar 2023 02:06:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE923C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B75E44015F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B75E44015F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=vAet4Owe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DPGGdp4mIctF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A634B400F3
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A634B400F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 02:06:29 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32KM4f6v019786; Tue, 21 Mar 2023 02:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=uDozhA7V1smowI3g1F3OEZAT8u+ulxze/ZDZDIWVI7Y=;
 b=vAet4OwebMkJ2Z+dTZNSbdcdjDVRcP6pPKyd5lF5nC35XXw3hdYm2lZrPvWfNd6OESWP
 l0JN/JJuNRt1qV56q8TdR44IUhO7wA4WCdZ0iF3tGHZ4qZPoZThvbcyPp+ddN07CaZAa
 mbwTNN/bWgWZsovqMpRlO5ZwFHHjS03wPLwRI+73NBG8eSOKgkc5rB/DgLzOD/orn3px
 G3uPoJHVpASarDbsUcaYf7QI5DAhKfOYNcBN6XamijHUM3QmGY8L/jq/Xn56VdIDIQd8
 HIHd1nXleKac6g8dIibnzhsTQ4YjndArWAvmHS1RMxbeV/zBQGRIHfn3lc7STadvq0E3 MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdmxc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Mar 2023 02:06:28 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32KNKX3m010787; Tue, 21 Mar 2023 02:06:27 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-165-250.vpn.oracle.com
 [10.154.165.250])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3peqjn4c0v-1; Tue, 21 Mar 2023 02:06:27 +0000
From: Mike Christie <michael.christie@oracle.com>
To: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/7] vhost-scsi: Fix crashes and management op hangs
Date: Mon, 20 Mar 2023 21:06:17 -0500
Message-Id: <20230321020624.13323-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_18,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=783
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210017
X-Proofpoint-GUID: zUr1oyX4b65z71HoPqIzudJD7zoLqRa1
X-Proofpoint-ORIG-GUID: zUr1oyX4b65z71HoPqIzudJD7zoLqRa1
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The following patches were made over Linus tree. The patches fix 3
issues:

1. If a user performs LIO LUN unmapping before the endpoint has been
cleared then we can end up trying to free a bogus tmf struct if the
TMF is still exucuting when we do the unmap.
2. If vhost_scsi_setup_vq_cmds fails we can leave the tpg->vhost_scsi
pointer set and we can end up trying to access a freed struct.
3. Management operations like LUN mapping/unmapping and device addition
hang for 30 seconds or up to N minutes depending on the device.

The problem is that we use a global mutex to protect the list of tpgs
and for accessing the tpg, and to make sure they are flushed. We then
hold that mutex during a lot of management operations. So if you
are just trying to add another device, it will have to wait on another
device if we are in the middle of clearing it's endpoint and it's
waiting on hung IO.

This patchset fixes up the ordering of how we flush IO and release
refcounts and how often the global mutex is used so we don't need to
always hold it

v2:
1. Added fix for possible use after free and merge with a locking
cleanup patch.
2. Added fix for LIO LUN unmap during TMF execution bug.
3. Fixed bug where we needed to hold the tpg mutex instead of the
vhost_scsi_mutex when calling vhost_scsi_do_plug.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
