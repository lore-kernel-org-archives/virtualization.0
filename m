Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25724C77B60
	for <virtualization@archiver.kernel.org>; Sun, 30 Apr 2023 13:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21FA741753;
	Sun, 30 Apr 2023 13:15:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21FA741753
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=dhX1SOch
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6-5021n4-5D; Sun, 30 Apr 2023 13:15:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2094A41857;
	Sun, 30 Apr 2023 13:15:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2094A41857
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7CCFC0037;
	Sun, 30 Apr 2023 13:15:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42951C007A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D77C440332
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D77C440332
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=dhX1SOch
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k7idaZPami3U
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:15:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17B5040017
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::626])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 17B5040017
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 13:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YglorN+m/uNV2tCqpeqx9vD+nAgucbhf6rYQaNjMM/ArjiprJ7Uurdy6VQhGstbN+bBR9g3R/dPSz5RBpSY23kI7VKEe6kRxT+PJldhLZEE3u1sjjL+rS5TC4a4dRIjF6theBaYtcBw8CkblMvKTd2t2amDBIuqJhn6B7E3zKE7BRbezMubzizaENYh1QJpNaqtHtoJp7t2py6wfzxcUOZJTbsWGxQycPwsFq/LOJieHSgUMQg5yBOcIJhOpT9ZzOszznN3VqV9ROAy51asYmViErlcJbSrW0vsBfNrqDjs9u/de2D5093WDGTWNsxbuckvQqK8VuZuxjrmDbZX4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CkMn617NGcOIW82fXp6biqVBtJmQyqTZuuxdSUg1fE=;
 b=dZeOXkwnXsXtJ1/AZJVgtVg8rI0jfbSXN89NkSQ4MDoG7D7l+Pj1/Fs0GfCjK8KCB6t7E4WiXxTDjmzVEA5pgILXlVhYMvZp/XaERTYgaQLu17ChMKP8hEqzAtDHHd/VIx0KNzyhsN5ymtGvGqPasQXY16OjVqaeRyHsCegEAVXSjwuQoYGYHv525GeiGtRUE1+FI610Zipfdhcu2Ra5kBEnuB7yl/hYU9gaT6YnVVmRJ3ZYHPVbSe3rAFg4O7gKrIKaVpb/9LjaFxezRxDSRF4LkC5d524aE/yksfax8kzQDlKG1BbX0y+h9t1dMXJubZyruoSEnBdbChxWk6aoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CkMn617NGcOIW82fXp6biqVBtJmQyqTZuuxdSUg1fE=;
 b=dhX1SOchEQFpionO8As6uBA+yUxPwyY33dmENTGXwKtulv/3iSCPD3Xt6VDJPQylcX71Np1enPN8Q+lqtGsFD6U+6DC/a44B+7EztU5t2IkmQEqY7/GI9ro92qQ6tEeTuv4SBi1CM7rbd2kGxLoSb89bgmes5pAPY3aIVfH6A2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Sun, 30 Apr
 2023 13:15:33 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106%5]) with mapi id 15.20.6340.026; Sun, 30 Apr 2023
 13:15:33 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH net 3/3] virtio-net: block ethtool from converting a ring
 to a small ring
Date: Sun, 30 Apr 2023 16:15:18 +0300
Message-Id: <20230430131518.2708471-4-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
X-ClientProxiedBy: ZR0P278CA0191.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::10) To AM0PR04MB4723.eurprd04.prod.outlook.com
 (2603:10a6:208:c0::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4723:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: f007aea1-0fad-4575-1c5f-08db497cfa7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwIAWr7AprY5tyGqBsbUgR7d/QK7xAhnHHZnBY5xS795DxfPSodyYEev9CEC25zFU/WjuRhY6Jq/9vlqxS5HuNfb1GLm9e7TO14zwi3e9N8eoH0gc6JP5HIfKlxm5rfw/IVTBAKyiyXQctmrSyorJp42Oq+fbZw0pazluQ71j3wo2nuw88AVpEe/WYQdrF4CzKJIrGtsMuCE0bJXyUOOPIVre85mmNkaWDIGVOcnnu7Rl3g9djW18bvpvtsKe+Rz+I3ysg3tc/M0Qri9yF5tswrxfuhEx/lZfahJH6r0LOz2a1hmPOvFfoIGsDmGehJrhfK1TdJlI2NxCXbOXwOrcIeiAlpx8lYiOzUbyIM+QLSDbIPgYrxFJVRbT5i2IcxyJgeW+jbu16s2UiQJ9MtVWlxF7CuTUJM6QldWdYBQzEIzGWTKvrpUZQdDe5M00f1I3eyZ1Xv18CrVSdMhwYXG6+5meWp9iWOMd3rEmnf8CwP2gP0/PqEBnKQ/4+ZKUgA5XvXrryQtBKrqV+9lMNacCM44xS+RkhfhdKZBgO4yCzUlQ1fD2QXtNbzYkaKRVfKviPuEEkNH12FZY2+qUUfL5lNZ4iDs55pZpAWdUiz/yHWB6BiZgSfkv+jeDv4IatdS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39830400003)(451199021)(86362001)(36756003)(38100700002)(38350700002)(7416002)(5660300002)(4326008)(66946007)(316002)(66476007)(44832011)(8936002)(41300700001)(66556008)(8676002)(2906002)(2616005)(6666004)(52116002)(478600001)(6486002)(6506007)(1076003)(26005)(107886003)(6512007)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijhI6mvsm7jz8ftjOh6UmrsHXhA9cNSBAw2tykjpxwCAUvORiv9kMFjbIN81?=
 =?us-ascii?Q?P1X6ql03Ca7k2KIBbrWgLbzyf5vzwStx78teNw705K74kGDFW+wbfS/OZXLw?=
 =?us-ascii?Q?6zNYL5jkTDL34v+js/7be0+nTYT74ZxFsrn95WbWOP8S+0+3EiDWMIMIJg0k?=
 =?us-ascii?Q?MINtLVxD6PJR5iA11Rxaef2Iylfa/pWIK/+vguKhf/XOH+MsgqlOgMlpJVe4?=
 =?us-ascii?Q?Jx3AU3EAwvy/vNXTcvz6IGFs6Ay1Gi9OCMsHfJFec5MGP4619XBVJX7O+DSz?=
 =?us-ascii?Q?ZsA9NSN0uv3sxTShxZKXmcysFehNBZLkPpd8cQelEFbyuh3nQlIZpJYsyt2n?=
 =?us-ascii?Q?iagNPBiWj0Mjl/072zflcyhgqcxbYHRrVZvLc5PvcESks+X3eN9k6cRbJ/PU?=
 =?us-ascii?Q?rvC+7Tb4VUtDKa0SFrKUPdgC+SVUnRynzkZWQ592k/r38q8HcNFw3qAIvRvt?=
 =?us-ascii?Q?R7neoFmWfg7wWvwD0NcGnY8t7tNe2GeTevmEM64RZgWeH6a9k4esQ4/x79IE?=
 =?us-ascii?Q?lHE+KpJHQZIvL3LAGOgpngUqFnWKqW3Yu2kXI4+CWYw2eHm0EcvQQIj3Qygf?=
 =?us-ascii?Q?c+R1WX49+p6dGNSyldmi2UY2/FDVr1aRViAaMov0NH+vUlI77wXAUKncmAwP?=
 =?us-ascii?Q?TOpKGSCjmnFDHXayxZALQpmKgG66AyDQF44bDQN1xglT1sNCHeqdZleyfk7f?=
 =?us-ascii?Q?eCh5cmqg9wrwerbfL2SnFVAyZeNv0yTMCEDQPCPEHDL3xzaqxlNwaKE+ZIFZ?=
 =?us-ascii?Q?tzxWsaalrkpeOh8yO9lcwFaxSz0R6p77UQ2xh5ytEnRQ7RSrXTfQE+TdMcNw?=
 =?us-ascii?Q?t94CaPI/oMLdsPZxVgy2UZKBFHWGx4Sus7ULKfaDgvwWA91a7JefEejl7KN1?=
 =?us-ascii?Q?eiICRAgNz+eNnQsfTfe2GXvVb4vcVqCKdMoRxO8nG2lfXImDxBVBHqEphsma?=
 =?us-ascii?Q?O6z4QZPl+IQ/e1+KP4fyTQ0R6WZQkfpga+r2XacPDpXlklEC00AyM0AOLifO?=
 =?us-ascii?Q?zhPvShQZAlKkOmHuOHBvsc6aQ2LERa+2HWHqZT/HTbJ5Xb3QiKD366SWD5tb?=
 =?us-ascii?Q?yJjodQxd5gef+NxtcG6mNM4wVGDsezGYc3FkOUDkoHIlDCTBkaw0lSv2WhKv?=
 =?us-ascii?Q?l673sY8pgx/xii2k6y8qwRGar+pZ10SqDGqo9GDWAaRADLv/AE9RHqvjRk7W?=
 =?us-ascii?Q?AIyMBAeqKQY9OfMGwvjW50fTOuZstvNEKbWm+2xJd1lZIJCejD5W6I0Tzvfq?=
 =?us-ascii?Q?qi7OSU4hPY5UYgw69WbVMP+iu8ZfyE9/1ipP3lLEiwsvM21YDS/PGcJf/HkN?=
 =?us-ascii?Q?q9gFV1OWtPJ/VJFUbKbZAjUm5wn3z96qZB9SIPV9CIqQvPb1Ch1e8C2FdWWu?=
 =?us-ascii?Q?j+kiJH6Bl0jE5UAUhZwsFgJ9BKLIqvnfO4TAV7HG8cIxDlbcNWufZVn1Mg2s?=
 =?us-ascii?Q?IGJJONFTkvGS1a27MCUGLW+qvlGgAVmbUQicq9gbIlDkIGaER0r3K8g2VDrY?=
 =?us-ascii?Q?nLnCuC2dAtnSi7zw1sDt+g1Z/T5M338DcNfYOTlS7NqCOUbhNHhwIFMe3ipT?=
 =?us-ascii?Q?0Fv+4ZjmyzfE2MNaWGqO2LT9rQ0DrDj27Ni2wqjVL6M6+mCgiwP5NC5IOdtC?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f007aea1-0fad-4575-1c5f-08db497cfa7b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2023 13:15:33.1993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +C1LX+kRjfaIiRFASgP9tiBeyF3EPG9bIx6W3Uppy/6IP2+IEE8lgDmU4P3FNvj3AuPRYpRRsVxB5Z/h38v6NPZ4FmIinr7oH2pX24cpeAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Stop ethtool from resizing a TX/RX ring to size less than
MAX_SKB_FRAGS + 2, if the ring was initialized with a bigger size.

We cannot convert a "normal" ring to a "small" ring in runtime.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/net/virtio_net.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b4441d63890..b8238eaa1e4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2071,6 +2071,12 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	bool running = netif_running(vi->dev);
 	int err, qindex;
 
+	/* We cannot convert a ring to a small vring */
+	if (!vi->svring && IS_SMALL_VRING(ring_num)) {
+		netdev_err(vi->dev, "resize rx fail: size is too small..\n");
+		return -EINVAL;
+	}
+
 	qindex = rq - vi->rq;
 
 	if (running)
@@ -2097,6 +2103,12 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 
 	qindex = sq - vi->sq;
 
+	/* We cannot convert a ring to a small vring */
+	if (!vi->svring && IS_SMALL_VRING(ring_num)) {
+		netdev_err(vi->dev, "resize tx fail: size is too small..\n");
+		return -EINVAL;
+	}
+
 	if (running)
 		virtnet_napi_tx_disable(&sq->napi);
 
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
