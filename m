Return-Path: <SRS0=1ME9=CT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5EC433E2
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 08:54:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A03C2078B
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 08:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wx17EmnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A03C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BDEBA84798;
	Thu, 10 Sep 2020 08:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KfpU5G+3acIu; Thu, 10 Sep 2020 08:54:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1A99D871BD;
	Thu, 10 Sep 2020 08:54:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF9D5C0859;
	Thu, 10 Sep 2020 08:54:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CD0CC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ED509872EE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5hy565KLZCAt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3F3CC872D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:54:06 +0000 (UTC)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08A8XGmj164198; Thu, 10 Sep 2020 04:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=sRPpqbahpQqemdeTO4/3zXQoLZgn4dX9e/cX2KkjQXU=;
 b=Wx17EmnASg7HC4jesWmzTo7M5hyKs/1rQu5XD9A1z6i5e/iIZkF+L7THzSnvYtyUjY7x
 iaOgtCqNpCcl6ZaKfAvuaJyiXwJ2JdecgBxjjgQdpL4LCJB75RK+n/7a+aXCJ5C6I8Ls
 WQIC2pL0qqylSUVZdljh2A2qG5IsqUIK41g2iePUCwvzcu6OXATlhamu6CTUZcP92gMa
 RibKqFvq0frW+tu9rNStrWI5Xbm9dApe7bexgGF+BdPXgrxkMVFW3YXla4TaDtdHhrL/
 ixEdAP1eLlDSLmSQ5NgMZLEtM7yryBdvlqCvRB+T3Ol/3GzXaqMdsf5e/OmG+ZtrhUvz 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fg431x25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 04:53:59 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A8XMQL164833;
 Thu, 10 Sep 2020 04:53:58 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33fg431x19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 04:53:58 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A8q1mR006833;
 Thu, 10 Sep 2020 08:53:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma01fra.de.ibm.com with ESMTP id 33c2a81ab2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2020 08:53:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08A8rrXG64946530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2020 08:53:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CD8711C054;
 Thu, 10 Sep 2020 08:53:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8A0B11C058;
 Thu, 10 Sep 2020 08:53:52 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.28.144])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 10 Sep 2020 08:53:52 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/2] virtio: let arch advertise guest's memory access
 restrictions
Date: Thu, 10 Sep 2020 10:53:49 +0200
Message-Id: <1599728030-17085-2-git-send-email-pmorel@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
References: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-10_01:2020-09-10,
 2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100079
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

An architecture may restrict host access to guest memory,
e.g. IBM s390 Secure Execution or AMD SEV.

Provide a new Kconfig entry the architecture can select,
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, when it provides
the arch_has_restricted_virtio_memory_access callback to advertise
to VIRTIO common code when the architecture restricts memory access
from the host.

The common code can then fail the probe for any device where
VIRTIO_F_ACCESS_PLATFORM is required, but not set.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/virtio/Kconfig        |  6 ++++++
 drivers/virtio/virtio.c       | 15 +++++++++++++++
 include/linux/virtio_config.h | 10 ++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 5c92e4a50882..ef2d49430800 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -6,6 +6,12 @@ config VIRTIO
 	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
 	  or CONFIG_S390_GUEST.
 
+config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	bool
+	help
+	  This option is selected if the architecture may need to enforce
+	  VIRTIO_F_ACCESS_PLATFORM
+
 menuconfig VIRTIO_MENU
 	bool "Virtio drivers"
 	default y
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a977e32a88f2..a2b3f12e10a2 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -176,6 +176,21 @@ int virtio_finalize_features(struct virtio_device *dev)
 	if (ret)
 		return ret;
 
+	ret = arch_has_restricted_virtio_memory_access();
+	if (ret) {
+		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
+			dev_warn(&dev->dev,
+				 "device must provide VIRTIO_F_VERSION_1\n");
+			return -ENODEV;
+		}
+
+		if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
+			dev_warn(&dev->dev,
+				 "device must provide VIRTIO_F_ACCESS_PLATFORM\n");
+			return -ENODEV;
+		}
+	}
+
 	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
 		return 0;
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8fe857e27ef3..3f697c8c8205 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -540,4 +540,14 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 			virtio_cread_le((vdev), structname, member, ptr); \
 		_r;							\
 	})
+
+#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+int arch_has_restricted_virtio_memory_access(void);
+#else
+static inline int arch_has_restricted_virtio_memory_access(void)
+{
+	return 0;
+}
+#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
+
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
