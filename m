Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A07C433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 01:21:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E97615E5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 01:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4E97615E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1C3F42530;
	Thu, 30 Sep 2021 01:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xR99lRGUHoYC; Thu, 30 Sep 2021 01:21:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A99E4252B;
	Thu, 30 Sep 2021 01:21:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D8E0C0011;
	Thu, 30 Sep 2021 01:21:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 596C4C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FD9084075
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o9AAOuXcwpxF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:21:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93BF484047
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:21:27 +0000 (UTC)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TNxZE5014056; 
 Wed, 29 Sep 2021 21:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3BT6KhLK4QOsmsWLo+Xr8Z4GZJebqe0S/Ad5lfsLrFA=;
 b=U+Cpuw/R1gcJ0k/DbVNnC9Bj02rhq6FBupmELLI7/8EriJUk+6wbiQcmHFo7tKt21F++
 Do8z0aXumznZf3H+uYlZmI1HtBc4e5iOZKVQwwtbNHGAw+I5gZqyXSUepJ/pUGmNwZQa
 +nwsR2PJ6oCDdLyKaTOS5QpFESUFLBqe7cTb45V1ZS3KdJnRVXXMaBiORktL2GZhoHsM
 Fxt10rmWt5Yi0YP2Q8h1oqO570eYHiSUtC9ufG5ZDnVN39+avwX0IaXhaSqgxFVG6LEG
 VV+GabUYx0vvv5J4Cxb+xbrrxnPAZatuhmjkeW94+WaU7v7PImpFWen31XqBGyz19BwS 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bd2a91c66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Sep 2021 21:21:15 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18U1LEDt001310;
 Wed, 29 Sep 2021 21:21:14 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3bd2a91c5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Sep 2021 21:21:14 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18U1I8ak016636;
 Thu, 30 Sep 2021 01:21:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04fra.de.ibm.com with ESMTP id 3b9udabapc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Sep 2021 01:21:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 18U1L85j44564842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Sep 2021 01:21:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5ED442057;
 Thu, 30 Sep 2021 01:21:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ED2242056;
 Thu, 30 Sep 2021 01:21:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 Sep 2021 01:21:07 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] virtio: write back features before verify
Date: Thu, 30 Sep 2021 03:20:49 +0200
Message-Id: <20210930012049.3780865-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oaYM4f0KOIm1z1XhXdiaVl1kNzwSe1xk
X-Proofpoint-ORIG-GUID: m72TjF8NMIgmhtB-HNOgS_bjBHOPZZBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_09,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 malwarescore=0 impostorscore=0 clxscore=1011 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300003
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, markver@us.ibm.com,
 linux-s390@vger.kernel.org
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

This patch fixes a regression introduced by commit 82e89ea077b9
("virtio-blk: Add validation for block size in config space") and
enables similar checks in verify() on big endian platforms.

The problem with checking multi-byte config fields in the verify
callback, on big endian platforms, and with a possibly transitional
device is the following. The verify() callback is called between
config->get_features() and virtio_finalize_features(). That we have a
device that offered F_VERSION_1 then we have the following options
either the device is transitional, and then it has to present the legacy
interface, i.e. a big endian config space until F_VERSION_1 is
negotiated, or we have a non-transitional device, which makes
F_VERSION_1 mandatory, and only implements the non-legacy interface and
thus presents a little endian config space. Because at this point we
can't know if the device is transitional or non-transitional, we can't
know do we need to byte swap or not.

The virtio spec explicitly states that the driver MAY read config
between reading and writing the features so saying that first accessing
the config before feature negotiation is done is not an option. The
specification ain't clear about setting the features multiple times
before FEATURES_OK, so I guess that should be fine.

I don't consider this patch super clean, but frankly I don't think we
have a ton of options. Another option that may or man not be cleaner,
but is also IMHO much uglier is to figure out whether the device is
transitional by rejecting _F_VERSION_1, then resetting it and proceeding
according tho what we have figured out, hoping that the characteristics
of the device didn't change.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
Reported-by: markver@us.ibm.com
---
 drivers/virtio/virtio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 0a5b54034d4b..9dc3cfa17b1c 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
 		if (device_features & (1ULL << i))
 			__virtio_set_bit(dev, i);
 
+	/* Write back features before validate to know endianness */
+	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
+		dev->config->finalize_features(dev);
+
 	if (drv->validate) {
 		err = drv->validate(dev);
 		if (err)

base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
