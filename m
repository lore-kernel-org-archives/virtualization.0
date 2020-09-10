Return-Path: <SRS0=1ME9=CT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E396C433E2
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 08:54:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E9632078B
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 08:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KaavuZCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9632078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 61C81204D4;
	Thu, 10 Sep 2020 08:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1HLLtXnsZGwS; Thu, 10 Sep 2020 08:54:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7206E2011A;
	Thu, 10 Sep 2020 08:54:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67ED0C0859;
	Thu, 10 Sep 2020 08:54:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45F12C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3325D2011A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yg3lxPRB9Frq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by silver.osuosl.org (Postfix) with ESMTPS id ABC141FD43
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:06 +0000 (UTC)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A8VI6C181275; Thu, 10 Sep 2020 04:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject : date : message-id; s=pp1;
 bh=pU4urWtsbWSPa4r0ZU3rhdfIMKoqDCYrwScAUEWZXjs=;
 b=KaavuZCIjVlnsJN3Ls5rqbo1Hu+17oC1wBEveZCYRHbgadEvSh+Y+jE6TB010Cr/AeZU
 XPf47WFBjGFsvmIv1he2228+NY4NbU/ZOjq1WTlpYvIfsUAC4iVivUB5B3EdxRZLLZxR
 oFAT2JtTXhB57M1f7PWMiELV1jS92xLsdaTwZvtxzV3NHhbO+Jsz63ThLJWTq83nHBiE
 lbLtUioXmvKIiyErnTkWEkUevP/K2I0JZRHfGXxDZ7br2GJrJDYvqX1CyJllmpfh3L8V
 oXLqqy5wGeiAs6eSMmzwqtY8UFl/rQc9nkHGYeFzi0SyfHIJBUpAq/r1ikzg3oia+79H yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33fg6q1pt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 04:53:57 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A8WnpR186593;
 Thu, 10 Sep 2020 04:53:57 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33fg6q1psg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 04:53:57 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A8rci9005421;
 Thu, 10 Sep 2020 08:53:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 33dxdr319g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 08:53:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08A8rqgW39780724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 08:53:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9586711C052;
 Thu, 10 Sep 2020 08:53:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC94C11C054;
 Thu, 10 Sep 2020 08:53:51 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.28.144])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 08:53:51 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v12 0/2] s390: virtio: let arch validate VIRTIO features
Date: Thu, 10 Sep 2020 10:53:48 +0200
Message-Id: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_01:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=991
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100074
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

I changed VIRTIO_F_IOMMU_PLATFORM to VIRTIO_F_ACCESS_PLATFORM
I forgot in drivers/virtio/Kconfig, and put back the inclusion
of virtio_config.h for the definition of the callback in
arch/s390/mm/init.c I wrongly removed in the last series.

Regards,
Pierre


Pierre Morel (2):
  virtio: let arch advertise guest's memory access restrictions
  s390: virtio: PV needs VIRTIO I/O device protection

 arch/s390/Kconfig             |  1 +
 arch/s390/mm/init.c           | 11 +++++++++++
 drivers/virtio/Kconfig        |  6 ++++++
 drivers/virtio/virtio.c       | 15 +++++++++++++++
 include/linux/virtio_config.h | 10 ++++++++++
 5 files changed, 43 insertions(+)

-- 
2.25.1

to v12
- replaced VIRTIO_F_IOMMU_PLATFORM with VIRTIO_F_ACCESS_PLATFORM
  in drivers/virtio/Kconfig
  (Halil)

- suppress inaccurate part of the comment in patch 2
  (Halil)

- added back virtio_config.h to define
  arch_has_restricted_virtio_memory_access
  (kernel robot)

to v11:
- replaced VIRTIO_F_IOMMU_PLATFORM with VIRTIO_F_ACCESS_PLATFORM

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
