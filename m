Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020086.outbound.protection.outlook.com [52.101.128.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47F199EAD
	for <virtualization@lists.linux.dev>; Mon, 18 Nov 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933677; cv=fail; b=QVIHnTxlPj7wCvZ4HOeoOY/H8YiVhegTcAx1AkSTBSSpXJr5JL60ExUgP2McFpLw8bUSfqr94UZHYDAUi/jzoWxneQrqXW2I2Q05CVmyrYe5ed+q3O1zMn21qCUkiHajQOrvuXTW7V/nTkXbjkhlFmYervcF3u6HYZadAdIlysE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933677; c=relaxed/simple;
	bh=I1NKEzrh6tmvdd58m6h1Uti0ggnIYBYod1NKHn6Lzls=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sifOqEFrJt6DeEps7KgXFUY/k7S92riIEp18JM5hw+CwhMimFuV5uKe7dEMo1W2TlxioJ/I0orNcThXnaLkLUSdyIqIBK3XEYfNOrTa8ag29oz4LfqI/VjACl6PsydrtyOc3zxp+pTn2gzU+eUhQatTZBjc65br4DMq/VMoc6XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=g1iAkkNT; arc=fail smtp.client-ip=52.101.128.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="g1iAkkNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhJBMramj1aog5sd1KR6TGm9TYEnm3koIgKBVtHQFn0medWbsFE9i/Ddk1Aw8w56n2hGL+wPExqilVOGRAFyhhqATHw3RVLq16DHNExm/e3WN5gup/oAonkzqBPMUIFy37iGvVaGWRJJS39QNVomdsBWj5xqWQgkBfyqOgLOilutQVeQ+8b+T0hZ6yuDDWZOhWjz9eq8+ilAf1xcmbBcZdLOSCk3F4+DZ9FtJSxVuZdIR0tJ0Ho3Y44/ll4iq0SRFEmOHtEuRbXVLnP0RIT4lYYjvSD3joOEZ/Xj10Cu/3EsAn8kReKgcsBhhwLE8Y0a1sPSBEC/KLRGK5m+rw4AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYYbED5raF2ITXAQ/FGisO9jOkPzZbraZjF5Tvi5alg=;
 b=a11wXEAByou9Z8ba1c6NRjzABOUBHyCzeQ/x7KZFhC/jyxDZnosasX3tsDjB4qkBLEuax5PS+vuGMczqmnZ+LDIhTtdltEu8Fl1wJl2Gd1iyfAlVN2xwLEwiBdbrY/1IyEidITdpVDNnBGtUVfFmqgemwCt5+prEDY3T4EnfxDGYQDxPCua8HoGrCWyQRze4ISFncxpDx0mCkSXqSeewbRVQOkD9rp0VFkE8scPXk4khCCIcs+qvguLoSvcPCgundtFNuWjdZmYC2ltTH4aoKnJ2A2l6InJBjs0Sw0NQBryNwKASW4YlgRB2yvj6Vs72K+htXpXixF+ioky7rySxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYYbED5raF2ITXAQ/FGisO9jOkPzZbraZjF5Tvi5alg=;
 b=g1iAkkNTohP/0+jGJP3hrcbCTXrDuU756paPZnYwuSVY4SHH0kAYo+SZBP83WVZhhstGPv9fVduWEzPqltdF/wBHB1O9ectqbO0QjmcPURSo6CI4HkWLx6D9JnncaDz04WOxVL7hNReTNvThediZ5aLkA7wyFrfao7/erbIhv0ZL33dxNHaO1wibMy0cFJDfTwhmW3TJm9x1UXexjbADrtz0UkoymyVSEmlsxGnx5ukRw5K1jlCd6UFD8slhEZhyE4dlKuGvs0CTIoLVre8/zXxMs1kAfn2IfFS0XqcQWI3bNEcdaDY4ZwINBaxvBDQFWfTRfII0qZD+dWUlyh5awg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from JH0PR06MB6800.apcprd06.prod.outlook.com (2603:1096:990:39::13)
 by SG2PR06MB5408.apcprd06.prod.outlook.com (2603:1096:4:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.10; Mon, 18 Nov
 2024 12:41:09 +0000
Received: from JH0PR06MB6800.apcprd06.prod.outlook.com
 ([fe80::816c:b02a:441e:950]) by JH0PR06MB6800.apcprd06.prod.outlook.com
 ([fe80::816c:b02a:441e:950%4]) with mapi id 15.20.8182.004; Mon, 18 Nov 2024
 12:41:09 +0000
From: xiaowuding_jaguarmicro <xiaowu.ding@jaguarmicro.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	angus.chen@jaguarmicro.com,
	Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
Subject: [PATCH] virtio: remove the duplicate might_sleep()
Date: Mon, 18 Nov 2024 20:40:56 +0800
Message-Id: <20241118124056.1038-1-xiaowu.ding@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To JH0PR06MB6800.apcprd06.prod.outlook.com
 (2603:1096:990:39::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6800:EE_|SG2PR06MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: 11008fae-23a4-47da-e947-08dd07ce46ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lje/lU5Ozy05TmN2sl0EB7QLubzG70H7M+e/sMVsowwXSTCz0MYZ1Q0BMU5l?=
 =?us-ascii?Q?aVsp2vLgYWZ3EuM13R08A7n/8efNjypfS428QHt4Xz9cqpBbi2eD+QkOQ1iN?=
 =?us-ascii?Q?kQY76T997n7DO15WqZ7m1WwVjMWUmZMof5nAY18VRhKQu8pgn8A9Jb41xerK?=
 =?us-ascii?Q?rzJ2Jskf1k4/gIGXcQp3U7fcjcMWncX5tpk0cN7iy/+FjioyeVZ7dVlGE3s9?=
 =?us-ascii?Q?DqhoLC3UHbBmse7BkRD3qEsnHS98NKY1UrEsnh6pU7PNCxAWnRl9qEEfVhii?=
 =?us-ascii?Q?fCHt4Yn6oCM0YE1/mT4ea7JC01g3v2SbVCXpmD3tVJx+DjZBwoENC3/x/VMU?=
 =?us-ascii?Q?nRsz8AuO7fpuuo83Laeh8JojOrV+uxRO8jTIssdzVVcqWx+dmEiIGiGmXHtV?=
 =?us-ascii?Q?l28cllxHqaLFBRwtfTMTgY1VV3RfxFdrLhkDeVFuBdSKQcOnTVoRw1AtX2lR?=
 =?us-ascii?Q?igCo8jseGdrQUf0F/G30DSu3g23z7bK0BEehg/Qrhba+2H9do9bWnzwS8fdq?=
 =?us-ascii?Q?q9P2j1JqStLDwrfvYG/zichwaHdbW0MlTu5CCBFd7v613GE82E4xuU7+tqoQ?=
 =?us-ascii?Q?GdlGgj5lLM3/jziBB10LqpFXYTkLUQxDUqSIWs9j8n3l+Wc43XUhtMsVhXa7?=
 =?us-ascii?Q?GPXB1cK57dmMEg2Dx0JAT0tjvpBbp2zT+OQo4AUEiiAB+NJTr2csmbFrP2x5?=
 =?us-ascii?Q?brfljUK0MNw6D3KIrGYrSQnvFk28nnzXJDCYm4Er5n5YOZ1ta4WSaVW6jwIi?=
 =?us-ascii?Q?Tz32ARA+pnWDlEY7XiRxEHWA4V7jtqDMgQEDKcQEH41pWEr5lgUrw0U3kxC/?=
 =?us-ascii?Q?OEAhBLj4EEXXjjOmTiskAzVE+XPqOnM9s33qopYd7GTFyPW0f2NacOCyOBHQ?=
 =?us-ascii?Q?CiwgHcq2vYq5M35B79Whajs6WtS7DWj1nV4yIA8vhbKMKJ1lzTL1xglMYeio?=
 =?us-ascii?Q?92YBkUHBuGoipWNCgJzXBUpJavmXxBvtESeRGW6GOq7plvJScEiA597e0DtJ?=
 =?us-ascii?Q?L9qoIfnK62gV1bzsSpANqH84odoYQ67BjrcoyxS6XecPHchUuRBlii1fDG99?=
 =?us-ascii?Q?H29yqLNyXL8CZ84KRthVrdhB2nwHHQhe0Rq9dzsxbZww2CvtG6pu2h++DvSF?=
 =?us-ascii?Q?MLfDs3xY4ZykVPcG98qfRfBdsgXvZxsEMDRhOYTPmJX9f3vbdk5mvT5V071Z?=
 =?us-ascii?Q?6Yu8wHvzPwXi4RqqhmwPnUrJoYE8ThpeH5lsI4yWBxxBZ4FnJI6eYD0NoOBJ?=
 =?us-ascii?Q?E7TZ+4oh9O/aTZnLvBrDTPYvEv/GmpRXeSvEq5C/DmXZQ5i0FS3kRHKj5DAu?=
 =?us-ascii?Q?vtvdwjCptPP0sYNjwDdlfiwi4KSGRiBDa/bCN09A/DqqdNep9r+SiV0XGVxF?=
 =?us-ascii?Q?qVa24rE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6800.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J4iNhCy26arTmIvDjey2UmylB7JGcMDmjKgDxabxhLbzC76M0v3V32ixzaOu?=
 =?us-ascii?Q?aSzgLpWt0+nDxUI3hxibMEdBZn74HWhyPZwPaEhY3yBpf4iz6Mpy+cQO24wV?=
 =?us-ascii?Q?5BltEZqMfKJ23TmCTEpW04ayJWoc6zzVTgcjZBFv4zoYn+mwn9x46HWsonP2?=
 =?us-ascii?Q?qVbDaQbhjjyRGcs9x6bLPSBgsyS4KY5BHM783DwYG12J+qOLUw5S8wE8eqCE?=
 =?us-ascii?Q?jq7DBrQsFaShxCJFFObYViGQUlIWvK7AeV4vQiwdwXi3gtTjQ3PRhqFuiE1X?=
 =?us-ascii?Q?wGbOBlCCBfsXIQI0hCfZK4cr+X2la472ohMxilyMc2/tILsPoPU/x2Zowqvu?=
 =?us-ascii?Q?EnxNAyBCjwxj8AZ+sFjLdKh1iP2k2+8ecM5LpIA1b06FhH+Wd9uzIEq5CYbD?=
 =?us-ascii?Q?fy/txqS/d38i0CAi43y2nibbcLPf0evjZyz91oP9qW//ez0OWjCD9Utx0hhv?=
 =?us-ascii?Q?kaotqURRWNmEW3Bly1FjQszFULHTsLnzdvkzcxtnK91PlRKjSCqy3o/af7Md?=
 =?us-ascii?Q?RphoSGp+0GS4ql8I4sRgw1ut2PYI+OZ+ySnykroDff90nFD0rz6/yIByJSXr?=
 =?us-ascii?Q?XjXZz4YvCv97Efdsz3XzZ6t6KOnUZRbmBXy5FlUp3dICjS3FQXV9fwddMSad?=
 =?us-ascii?Q?Zrg1eoY74nlY/jLLLa4Zx5c7S9W3PgKoMzDa5ki6YEK2tuWNHlhhzKgnR/p2?=
 =?us-ascii?Q?sRnoWV6PV3z8UFHHIFDJZqEPIFTnQ7c4Mo7Pg8wCb502SLbJpSm1Bk8W0TgX?=
 =?us-ascii?Q?GuCwseT5hkH0nbRpguLs8WLC5ElbFCZ96RYxP+jy/xxdDlklDxH9kCbI19y3?=
 =?us-ascii?Q?TbOAtqcq7QKR4729ofkhaYWq7gLN8/GFQ4yuo0ypuUPSS83aOhUm8EHg3WuI?=
 =?us-ascii?Q?EQP420opeQtEDkNLjYZRP/bi4cETxnS+Z0mwsya/fHYx7IESdTOe4uz285i+?=
 =?us-ascii?Q?EUSvfjso+oKHrObnemxTw+aHqxQQwBZAa9SPG/9y8UqyHFaudOR5rXbN2eD/?=
 =?us-ascii?Q?Oc66eOrE2Xc1GCyNutdTKXX463ckzFB2DYBf+g0nWSx+jGDjL/RAGIzMgIp3?=
 =?us-ascii?Q?6bLX3utDE27yjWfFpe6a2f9IFZyXlF1iA+zC4T+aEaIeESf6P97m448UUBqU?=
 =?us-ascii?Q?b2T+P2t9iK0ljbJ47mgF4IF94zWyjeKKSs5qaQx8z/ZdU9jVnXI3H/mQu3Vs?=
 =?us-ascii?Q?+PNSdxUgCj60XsqAZeKZcQ19MFRyuBusbsCcCV/VJmJzkOFSvZWKU+DduD8C?=
 =?us-ascii?Q?td0q7thQGxWIvvjkXOEYdji2Hhs/jfRf5BrG/hWF3OqS2GJtwV+liVxmWYd1?=
 =?us-ascii?Q?QG9TfEcDR4m7SMYXhi6qF86kGyL9eqBG10Z7wHfFeF76sFT4g0CAYrGJg9vU?=
 =?us-ascii?Q?XHEi2YcsndpeK4KS+rEVLSVfEHUJTCir1/AFRUVzJ6tN3S47d4Q4a8Drrd3X?=
 =?us-ascii?Q?icGZ5tB0nKuxUjaznx5qN8IQQNqZzVV5rZyxnHQkKaBhdShuaDfzm8Ks4Mx1?=
 =?us-ascii?Q?N5On4snRXkfcNCpTqo/a5zUEy8Zm7VojWJ3RtNiNjXcQ5aGe0B0vky3d0Tv5?=
 =?us-ascii?Q?EL99WuPod6/6HBZEuguZubUUF4IRPyBP0i+F5RofHH8wwPQ54YUliHMxc4yI?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11008fae-23a4-47da-e947-08dd07ce46ef
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6800.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 12:41:09.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kzc2gC++nszLbfwP2NxS84jSrpxwvzRnRVBZ5gTmLYi6SVkLIJVQrWzCHDVhmLvPlarx/MKDM1HGvTeiYAWzrJf5EqnSNsU9ggKFcXjLQZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5408

From: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>

The virtio_add_status function have done might_sleep(),so we can remove
the duplicate calls.

Signed-off-by: Xiaowu Ding <xiaowu.ding@jaguarmicro.com>
---
 drivers/virtio/virtio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e..8352dfc1a 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -205,8 +205,6 @@ static int virtio_features_ok(struct virtio_device *dev)
 {
 	unsigned int status;
 
-	might_sleep();
-
 	if (virtio_check_mem_acc_cb(dev)) {
 		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
 			dev_warn(&dev->dev,
-- 
2.27.0

