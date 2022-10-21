Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FE7FA3740
	for <virtualization@archiver.kernel.org>; Fri, 21 Oct 2022 23:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D5A841859;
	Fri, 21 Oct 2022 23:49:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D5A841859
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=MS8hwiEw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7GWYbTWEAYLC; Fri, 21 Oct 2022 23:49:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E2C1418F7;
	Fri, 21 Oct 2022 23:49:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E2C1418F7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88DA0C0085;
	Fri, 21 Oct 2022 23:49:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 161C4C0033
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 23:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEF5483F60
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 23:49:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEF5483F60
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=MS8hwiEw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H6LYbVs-Z9oj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 23:49:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3A7583E78
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3A7583E78
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 23:49:41 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDn3t005590;
 Fri, 21 Oct 2022 23:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=+ERFyiHXEdvrz8E3RvSkJniqhhPRKAx1foTvxjTTKEA=;
 b=MS8hwiEwSILu/wE4cyRrnc49kdnE+NWUoQEPiZtWVekdU5e+KsUJO/YJ3lWavVEM9DEq
 li9O/2C/GpwDfJ0sje0lTpIsSmtcXWcOPpPhSsBPXhbrnutl/m7chrmFbOLE+oc+aWf6
 Mmf81i7h9dw7WjxLyHzk5GhaCj/0hfE7fS/i4cBvD+/B4cgZ0/Ggw/tMrKwY6k2nxA8g
 6f6Vs89ZMwUTvWvPcSkLyuE7uB+DwNFFsq/YzQRbquHmqcc+G/KFG9b/vec8CWlBHOEA
 VhgQFwW/eKVjb+ZvM6vGOWK+pkp2nLxN4aTisSjtOAxVkZVJQE5qGvbOpibEc+jN/9FA xA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtucb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Oct 2022 23:49:41 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29LMgIQU007144; Fri, 21 Oct 2022 23:49:39 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3k8hre9a3b-4; Fri, 21 Oct 2022 23:49:39 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com
Subject: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show" output
Date: Fri, 21 Oct 2022 15:43:56 -0700
Message-Id: <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210139
X-Proofpoint-ORIG-GUID: qjwBfrKXvfL1eemarairM2QD3NRCWguZ
X-Proofpoint-GUID: qjwBfrKXvfL1eemarairM2QD3NRCWguZ
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

Live migration of vdpa would typically require re-instate vdpa
device with an idential set of configs on the destination node,
same way as how source node created the device in the first
place. In order to save orchestration software from memorizing
and keeping track of vdpa config, it will be helpful if the vdpa
tool provides the aids for exporting the initial configs as-is,
the way how vdpa device was created. The "vdpa dev show" command
seems to be the right vehicle for that. It is unlike the "vdpa dev
config show" command output which usually goes with the live value
in the device config space, and is not quite reliable subject to
the dynamics of feature negotiation or possible change by the
driver to the config space.

Examples:

1) Create vDPA by default without any config attribute

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
$ vdpa dev show vdpa0
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
$ vdpa dev -jp show vdpa0
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:41:04.2",
            "vendor_id": 5555,
            "max_vqs": 9,
            "max_vq_size": 256,
        }
    }
}

2) Create vDPA with config attribute(s) specified

$ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev show
vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
  initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
$ vdpa dev -jp show
{
    "dev": {
        "vdpa0": {
            "type": "network",
            "mgmtdev": "pci/0000:41:04.2",
            "vendor_id": 5555,
            "max_vqs": 9,
            "max_vq_size": 256,
            "initial_config": {
                "mac": "e4:11:c6:d3:45:f0",
                "max_vq_pairs": 4
            }
        }
    }
}

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index bebded6..bfb8f54 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 }
 
 static int
+vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
+{
+	struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
+	int err = -EMSGSIZE;
+
+	if (!cfg->mask)
+		return 0;
+
+	switch (device_id) {
+	case VIRTIO_ID_NET:
+		if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
+		    nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
+			    sizeof(cfg->net.mac), cfg->net.mac))
+			return err;
+		if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
+		    nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
+			return err;
+		if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
+		    nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
+				cfg->net.max_vq_pairs))
+			return err;
+		break;
+	default:
+		break;
+	}
+
+	if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
+	    nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
+			      cfg->device_features, VDPA_ATTR_PAD))
+		return err;
+
+	return 0;
+}
+
+static int
 vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
 	      int flags, struct netlink_ext_ack *extack)
 {
@@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 	if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
 		goto msg_err;
 
+	err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
+	if (err)
+		goto msg_err;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
