Return-Path: <SRS0=Psgj=CJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF4C433E6
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 09:10:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDB5208CA
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 09:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UZWmdfeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDB5208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A0F768637A;
	Mon, 31 Aug 2020 09:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFaQVpEajsBk; Mon, 31 Aug 2020 09:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4DB2084F4C;
	Mon, 31 Aug 2020 09:10:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DAF7C0052;
	Mon, 31 Aug 2020 09:10:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEEEC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 09:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 21F7085495
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 09:10:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k65ZzNUdwrDe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 09:10:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5B5D9852D5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 09:10:02 +0000 (UTC)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07V91wx3132558; Mon, 31 Aug 2020 05:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=LAaTEag7rfqT6w9lcK2QWR89UbUVGYDylsa7lF6cjIw=;
 b=UZWmdfeQoqE0x29aj2NVKcoTg1HZsmPFyABaLWS0BSdsXmf2DPiM92qUF/DVUDsFY1ht
 36BYzw2PGlwJ541c7GpHQKNy+uyfqCXOQ3t8VAjwGgPQUjc3mOnCbqBLaFtUR1ADgZEd
 RuF3pM2L2qUgIcCR3PktDwm3xuYFqF4bDZ119CBL42qaPTELKZK13T/Ri6bYx6Bpbrla
 feQ898e8ROMXbSNfMm1TiPZN5wH7HpLnZR2K1y1mgbZYcFii7NeyM9K+X0ayB6ixGu5u
 C42zUin0fpZb69J/nsdxmwuOAK8KHoFU7WpsRlLWZ10qK848+GXYhPAHL9wDoQzSkwOM sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 338x2dgcxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 05:09:56 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07V92Nv4133765;
 Mon, 31 Aug 2020 05:09:55 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 338x2dgcw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 05:09:55 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07V8TlVg007596;
 Mon, 31 Aug 2020 09:09:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma04ams.nl.ibm.com with ESMTP id 337en81yac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2020 09:09:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07V99mDt29032762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2020 09:09:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24C4EAE051;
 Mon, 31 Aug 2020 09:09:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D51DAE045;
 Mon, 31 Aug 2020 09:09:47 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.40.55])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2020 09:09:47 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/2] s390: virtio: let arch validate VIRTIO features
Date: Mon, 31 Aug 2020 11:09:44 +0200
Message-Id: <1598864986-13875-1-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-31_01:2020-08-28,
 2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 suspectscore=1 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310051
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, linuxram@us.ibm.com,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, thomas.lendacky@amd.com, hca@linux.ibm.com,
 david@gibson.dropbear.id.au
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi all,

The goal of the series is to give a chance to the architecture
to validate VIRTIO device features.

The tests are back to virtio_finalize_features.

No more argument for the architecture callback which only reports
if the architecture needs guest memory access restrictions for
VIRTIO.


I renamed the callback to arch_has_restricted_virtio_memory_access,
and the config option to ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS.

Regards,
Pierre

Pierre Morel (2):
  virtio: let arch advertise guest's memory access restrictions
  s390: virtio: PV needs VIRTIO I/O device protection

 arch/s390/Kconfig             |  1 +
 arch/s390/mm/init.c           | 10 ++++++++++
 drivers/virtio/Kconfig        |  6 ++++++
 drivers/virtio/virtio.c       | 15 +++++++++++++++
 include/linux/virtio_config.h |  9 +++++++++
 5 files changed, 41 insertions(+)

-- 
2.25.1

Changelog

to v10:
- removed virtio_config.h unnecessary include
- wording
  (Connie)

to v9:

- move virtio tests back to virtio_finalize_features
  (Connie)

- remove virtio device argument

to v8:

- refactoring by using an optional callback
  (Connie)

to v7:

- typo in warning message
  (Connie)
to v6:

- rewording warning messages
  (Connie, Halil)

to v5:

- return directly from S390 arch_validate_virtio_features()
  when the guest is not protected.
  (Connie)

- Somme rewording
  (Connie, Michael)

- moved back code from arch/s390/ ...kernel/uv.c to ...mm/init.c
  (Christian)

to v4:

- separate virtio and arch code
  (Pierre)

- moved code from arch/s390/mm/init.c to arch/s390/kernel/uv.c
  (as interpreted from Heiko's comment)

- moved validation inside the arch code
  (Connie)

- moved the call to arch validation before VIRTIO_F_1 test
  (Michael)

to v3:

- add warning
  (Connie, Christian)

- add comment
  (Connie)

- change hook name
  (Halil, Connie)

to v2:

- put the test in virtio_finalize_features()
  (Connie)

- put the test inside VIRTIO core
  (Jason)

- pass a virtio device as parameter
  (Halil)


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
