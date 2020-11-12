Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BF8C2D0A3
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 06:40:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2FF2100A
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 06:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BBAJXmNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2FF2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D3F186D65;
	Thu, 12 Nov 2020 06:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WZjnJGe4f+HW; Thu, 12 Nov 2020 06:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A978286D5F;
	Thu, 12 Nov 2020 06:40:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95F2BC0889;
	Thu, 12 Nov 2020 06:40:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17551C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 06:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 066402E14C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 06:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qpUn7CJE0Nxb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 06:40:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by silver.osuosl.org (Postfix) with ESMTPS id B83182E13B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 06:40:34 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5facd8e60000>; Wed, 11 Nov 2020 22:40:38 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 06:40:33 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH 6/7] vdpa: Enable user to query vdpa device info
Date: Thu, 12 Nov 2020 08:40:04 +0200
Message-ID: <20201112064005.349268-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112064005.349268-1-parav@nvidia.com>
References: <20201112064005.349268-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605163238; bh=Hdk1FRDwYZoc183SbD09+7k3Ug3LOo5biJ6yLjJm35g=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=BBAJXmNzzEC7kMxEt5J7+04SX4s5FmQY7Nad/02N/4Ab4ZYJZdragKz8SOETz8cAV
 +B/ISU+OkJvwlY4vDmjaCxcY/B7TI6DzyO2h2oppkuroaPMvgaP75nkmP9M43XxiOJ
 5x1cogISbU/VnpKvJfcgKWuJprL/4DN2rO6aeC1j1VwLnDBnvNDXHomJiQbkot8ART
 fVMecefdVRNiZ/USy7UNlprtXi8AP7RfV3iLZY8iegt4ACy+tFu7fr9rqlLwBRm9Gg
 5z0LMWErGkezwLMlUXRtTNItt7CD/vzYQiu57KNOxvAIKKvQTrwlK/kGbzha2b4bJu
 g/ByMsXQXMX4g==
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com
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

Enable user to query vdpa device information.

$ vdpa dev add parentdev vdpasim type net name foo2

Show the newly created vdpa device by its name:
$ vdpa dev show foo2
foo2: type network parentdev vdpasim vendor_id 0 max_vqs 2 max_vq_size 256

$ vdpa dev show foo2 -jp
{
    "dev": {
        "foo2": {
            "type": "network",
            "parentdev": "vdpasim",
            "vendor_id": 0,
            "max_vqs": 2,
            "max_vq_size": 256
        }
    }
}

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c       | 131 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vdpa.h |   4 ++
 2 files changed, 135 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index fcbdc8f10206..32bd48baffab 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -483,6 +483,131 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 	return err;
 }
 
+static int
+vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
+	      int flags, struct netlink_ext_ack *extack)
+{
+	u16 max_vq_size;
+	u32 device_id;
+	u32 vendor_id;
+	void *hdr;
+	int err;
+
+	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_DEV_NEW);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	err = vdpa_nl_parentdev_handle_fill(msg, vdev->pdev);
+	if (err)
+		goto msg_err;
+
+	device_id = vdev->config->get_device_id(vdev);
+	vendor_id = vdev->config->get_vendor_id(vdev);
+	max_vq_size = vdev->config->get_vq_num_max(vdev);
+
+	err = -EMSGSIZE;
+	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
+		goto msg_err;
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id))
+		goto msg_err;
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_VENDOR_ID, vendor_id))
+		goto msg_err;
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_MAX_VQS, vdev->nvqs))
+		goto msg_err;
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
+		goto msg_err;
+
+	genlmsg_end(msg, hdr);
+	return 0;
+
+msg_err:
+	genlmsg_cancel(msg, hdr);
+	return err;
+}
+
+static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct vdpa_device *vdev;
+	struct sk_buff *msg;
+	const char *devname;
+	struct device *dev;
+	int err;
+
+	if (!info->attrs[VDPA_ATTR_DEV_NAME])
+		return -EINVAL;
+	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	mutex_lock(&vdpa_dev_mutex);
+	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
+	if (!dev) {
+		mutex_unlock(&vdpa_dev_mutex);
+		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
+		return -ENODEV;
+	}
+	vdev = container_of(dev, struct vdpa_device, dev);
+	if (!vdev->pdev) {
+		mutex_unlock(&vdpa_dev_mutex);
+		put_device(dev);
+		return -EINVAL;
+	}
+	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
+	if (!err)
+		err = genlmsg_reply(msg, info);
+	put_device(dev);
+	mutex_unlock(&vdpa_dev_mutex);
+
+	if (err)
+		nlmsg_free(msg);
+	return err;
+}
+
+struct vdpa_dev_dump_info {
+	struct sk_buff *msg;
+	struct netlink_callback *cb;
+	int start_idx;
+	int idx;
+};
+
+static int vdpa_dev_dump(struct device *dev, void *data)
+{
+	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
+	struct vdpa_dev_dump_info *info = data;
+	int err;
+
+	if (!vdev->pdev)
+		return 0;
+	if (info->idx < info->start_idx) {
+		info->idx++;
+		return 0;
+	}
+	err = vdpa_dev_fill(vdev, info->msg, NETLINK_CB(info->cb->skb).portid,
+			    info->cb->nlh->nlmsg_seq, NLM_F_MULTI, info->cb->extack);
+	if (err)
+		return err;
+
+	info->idx++;
+	return 0;
+}
+
+static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	struct vdpa_dev_dump_info info;
+
+	info.msg = msg;
+	info.cb = cb;
+	info.start_idx = cb->args[0];
+	info.idx = 0;
+
+	mutex_lock(&vdpa_dev_mutex);
+	bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_dump);
+	mutex_unlock(&vdpa_dev_mutex);
+	cb->args[0] = info.idx;
+	return msg->len;
+}
+
 static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX] = {
 	[VDPA_ATTR_PARENTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_PARENTDEV_DEV_NAME] = { .type = NLA_STRING },
@@ -509,6 +634,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_del_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = vdpa_nl_cmd_dev_get_doit,
+		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index c528a9cfd6c9..bba8b83a94b5 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -17,6 +17,7 @@ enum vdpa_command {
 	VDPA_CMD_PARENTDEV_GET,		/* can dump */
 	VDPA_CMD_DEV_NEW,
 	VDPA_CMD_DEV_DEL,
+	VDPA_CMD_DEV_GET,		/* can dump */
 };
 
 enum vdpa_attr {
@@ -29,6 +30,9 @@ enum vdpa_attr {
 
 	VDPA_ATTR_DEV_NAME,			/* string */
 	VDPA_ATTR_DEV_ID,			/* u32 */
+	VDPA_ATTR_DEV_VENDOR_ID,		/* u32 */
+	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
+	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
