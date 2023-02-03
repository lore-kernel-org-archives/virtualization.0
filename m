Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83FBC61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 05:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3694F41D3D;
	Fri,  3 Feb 2023 05:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3694F41D3D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=yicUr3AL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aEVb7TBhrMIa; Fri,  3 Feb 2023 05:02:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 342F441B87;
	Fri,  3 Feb 2023 05:02:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 342F441B87
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BFE9C0077;
	Fri,  3 Feb 2023 05:02:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 119EEC0084
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 05:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6D7941BC3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 05:02:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6D7941BC3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ip6CRDGqe9Pk
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 05:02:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF46041A3E
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF46041A3E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 05:02:27 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3130OA8A005801; Fri, 3 Feb 2023 05:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=90PclZH5smGZrRUKyhlf4EA2JpBj5eesUZ1CnMBH5tI=;
 b=yicUr3ALVdRQNK/1M8HYhVSra/F7w6MGWZCHgzRSiszChFeCBvbYExVek3rQHyHHQzff
 0kvsu/EvyuibJOY6kBPEWPq0RfyxXH1vSXegyteQsCsecDRKApyvHJdU7EwnPVp40/bu
 xt47dM3uMKDXpURNUzRl/MEo5POy7Lra3DF4x4dhAnf1FaMKlacVTGUXZoITDSQNcfUh
 XZX6GY212Eou9LX4wbRZDyRRuelw/ZXtBW127QxdmhmI/XRk43cGYzl8Rn3+iJX5oLNS
 EwgY7B9roGRpUVkmNXjtQBNaKDZu/Itx/IDEMgkJmroMb6qdVQ6ziLDWgQDb8645Dzda YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkfe4wxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Feb 2023 05:02:26 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 31340RuP006053; Fri, 3 Feb 2023 05:02:25 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3nct5a2tm8-5; Fri, 03 Feb 2023 05:02:25 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH v3 4/6] vdpa: validate device feature provisioning against
 supported class
Date: Thu,  2 Feb 2023 21:02:01 -0800
Message-Id: <1675400523-12519-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030044
X-Proofpoint-GUID: cINSHcYYRUl5v3yBw4llRx1HaIZyOQZN
X-Proofpoint-ORIG-GUID: cINSHcYYRUl5v3yBw4llRx1HaIZyOQZN
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Today when device features are explicitly provisioned, the features
user supplied may contain device class specific features that are
not supported by the parent managment device. On the other hand,
when parent managment device supports more than one class, the
device features to provision may be ambiguous if none of the class
specific attributes is provided at the same time. Validate these
cases and prompt appropriate user errors accordingly.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/vdpa.c | 61 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 1eba978..4aa2160 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -460,12 +460,30 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_buff *msg, const struct vdpa_mg
 	return 0;
 }
 
+static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
+				    unsigned int *nclasses)
+{
+	u64 supported_classes = 0;
+	unsigned int n = 0;
+	int i = 0;
+
+	while (mdev->id_table[i].device) {
+		if (mdev->id_table[i].device <= 63) {
+			supported_classes |= BIT_ULL(mdev->id_table[i].device);
+			n++;
+		}
+		i++;
+	}
+	if (nclasses)
+		*nclasses = n;
+
+	return supported_classes;
+}
+
 static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
 			     u32 portid, u32 seq, int flags)
 {
-	u64 supported_classes = 0;
 	void *hdr;
-	int i = 0;
 	int err;
 
 	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
@@ -475,14 +493,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
 	if (err)
 		goto msg_err;
 
-	while (mdev->id_table[i].device) {
-		if (mdev->id_table[i].device <= 63)
-			supported_classes |= BIT_ULL(mdev->id_table[i].device);
-		i++;
-	}
-
 	if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
-			      supported_classes, VDPA_ATTR_UNSPEC)) {
+			      vdpa_mgmtdev_get_classes(mdev, NULL),
+			      VDPA_ATTR_UNSPEC)) {
 		err = -EMSGSIZE;
 		goto msg_err;
 	}
@@ -566,13 +579,25 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_buff *skb, struct genl_info *i
 				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
 				 BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
 
+/*
+ * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
+ * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
+ * all 64bit features. If the features are extended beyond 64 bits, or new
+ * "holes" are reserved for other type of features than per-device, this
+ * macro would have to be updated.
+ */
+#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
+			      ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
+
 static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct vdpa_dev_set_config config = {};
 	struct nlattr **nl_attrs = info->attrs;
 	struct vdpa_mgmt_dev *mdev;
+	unsigned int ncls = 0;
 	const u8 *macaddr;
 	const char *name;
+	u64 classes;
 	int err = 0;
 
 	if (!info->attrs[VDPA_ATTR_DEV_NAME])
@@ -649,6 +674,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		goto err;
 	}
 
+	classes = vdpa_mgmtdev_get_classes(mdev, &ncls);
+	if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
+	    !(classes & BIT_ULL(VIRTIO_ID_NET))) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "Network class attributes provided on unsupported management device");
+		err = -EINVAL;
+		goto err;
+	}
+	if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
+	    config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
+	    classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
+	    config.device_features & VIRTIO_DEVICE_F_MASK) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "Management device supports multi-class while device features specified are ambiguous");
+		err = -EINVAL;
+		goto err;
+	}
+
 	err = mdev->ops->dev_add(mdev, name, &config);
 err:
 	up_write(&vdpa_dev_lock);
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
