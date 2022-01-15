Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0002C433EF
	for <virtualization@archiver.kernel.org>; Sat, 15 Jan 2022 01:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4973140883;
	Sat, 15 Jan 2022 01:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZK0Yr9iR1XP8; Sat, 15 Jan 2022 01:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D82BE403EC;
	Sat, 15 Jan 2022 01:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC51BC002F;
	Sat, 15 Jan 2022 01:22:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20699C001E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98A3360B74
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Y888DrOu";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Y54bw/Je"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z16p8yF30m-y
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF18360F16
 for <virtualization@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 01:22:04 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20F0wkCN010215; 
 Sat, 15 Jan 2022 01:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=rjdCCqD0yT8Cslm7eYOYwQLbn4lxD8tj8I5vSfAEobI=;
 b=Y888DrOuA7BpMly+mRF5wPCaQGNtlXaoOL0ZovyYYMhXNBkILHjz3b5JYGYuEQTugp3W
 16CJabFeaaHainkSQz/kRhv3Ts8q7yuSJn3kdrvICViw78qkNqykvUNU1/e3p78i/jcL
 es68kVOiMB3rdyFGlGvZVw7QUMF+EK5wsd3I8NQhDBwjGTDhOE3NuMi9D9LpWAuioDGm
 nrjyjCQ2S/4KjVz4/1YaIdS+FKZ3nJ7SY9TgTW15WKKiZzobyWQMfMgFPkBvwVYLioi6
 h5EIXejq5HjzkLySDxa4EEddnIVXxfv7o7n5QnlXuAa7umMot49S/xlW3BhTjpY4CGi2 2A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3djkdnw1fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jan 2022 01:22:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20F16KUp073296;
 Sat, 15 Jan 2022 01:22:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by userp3030.oracle.com with ESMTP id 3dkkcsjsrx-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Jan 2022 01:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXATgAl2hAkGnd79i9AiQItE7gjHFgsAVMGxxY+MmKtEf5f0HcxCgp13qHxvC8DRkJmqIv+MwQh+/zrx6COdrBSEyjrzKX1aYtlAfZlvpW5hoRc135igWp8vQuEkdbmb6LIpySrYSHGOPiXzRTtq4IcptSxvZ1YN4a6I82bp6bv327VmR6HeEthB7p4ewFrxRm0YFK4RqNQeoCFPnkHBzpyPrwCcuJM+McjBYd6wESyfEizvDthFIIx9Ng0j8aoIm7oCV8sU92Ya5LJvrvUBAFCVIF1dKjOFJZzLdXIqQiA5gnaJLnBsS9y9rX9D0nikWMCFprLtc9COxpwnvVbpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjdCCqD0yT8Cslm7eYOYwQLbn4lxD8tj8I5vSfAEobI=;
 b=XqkWDzMhG4cxSUevsYyJcP79lLjkiRF8rlCW4lsWur5qg5ziujySj9SoLQ01UJpSB7u/s5LRTTJpwVlz/5s4WAiZ2Qht+ST6/JYJ1oFxJ+pbK7bxpx2QxlBm+Dr2YroKF2WIR172SVI5DB3/xtKYNIsupqlBK8e6zC/S+yCl6GpvmfW1ewaomYh231tyo7KzNt1zweF/foh69bYS6F+l2Gdxi8qfYTDUEfxfzhQNmmdP+/wUdfda0f9/A/9Xg3htchU0RgyfksTHmPBp3TBRjydgq+91ks7sInGBNKZD5ET4dwil/UU5Ueqsr/KL4MKeoZ+eatTT5fNcumSn2TNneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjdCCqD0yT8Cslm7eYOYwQLbn4lxD8tj8I5vSfAEobI=;
 b=Y54bw/Je1tLfMA/WPapHzCqbKL0K8EDgNm9s70WCXu3E6/tiOzOEJ7A6zQaQC7aMp/3ZnzZRpvI78slvnz1SF1JPpEGufL3Oy8JTu+82Gucd+H8rCKXHvMvRRjoJjObFQ6s9by36b6gjnD1ef94961yG0TM+JWAKlmywOzmRpHA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB5182.namprd10.prod.outlook.com (2603:10b6:5:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sat, 15 Jan
 2022 01:22:00 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%6]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 01:22:00 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: elic@nvidia.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v2 3/3] vdpa/mlx5: add validation for
 VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command
Date: Fri, 14 Jan 2022 19:28:01 -0500
Message-Id: <1642206481-30721-4-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
References: <1642206481-30721-1-git-send-email-si-wei.liu@oracle.com>
X-ClientProxiedBy: BY5PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:a03:167::48) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93cfd509-9f8c-4ccc-2803-08d9d7c56e11
X-MS-TrafficTypeDiagnostic: DS7PR10MB5182:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB51825A0DF31263E61BA2F9F6B1559@DS7PR10MB5182.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: buKr+c/wbv3PkwM8IjGjFOwtamVa38XgIugB6kELQVcTifGewobZzalgMHT0JIOuvkYy95fn+m4YbNFAdVp+vr8OaPsePd4TaoCsIMic1XZ207pbfC4QhEODJ8bTsw3y1nHj50EPNwl5sShm4EwqWJv54BK1lwiXac2CJTG95ZvaY50KU/xWQ4RJQLsayeGhUxxQAeDUTHP39icRvIKbHROOKwmtb4Mg0/Dz8v5W1VJLGLQP6rgia8BgAbZK4IwVYrOX8he12dBdQJo9vZlNkmehODplovE9D2mL8jqjPSIKMtzXXlpckqYvCTfZ5aoa7mgMAuJEZc+TvvinUv2QveFvds0jC+Po/b3feZvL0vTJ6sYpIHjdAX9sJsxLtj2A7kCagn9RIKJbooOvEj1Ad4N7eWc2O6cEPljD9TqeGnIi0yDb1rk3w8bsa8qw7HEUieOsr+h1SM8ZjIuQ3LnSoLfy7HUaGtZ9BzzpaKw8+WCbOMotQvUal8r8KOaq3aOENSxCDcKJMHl0M4YdHRH7My+6irFsJ9VV18hAGTcMaaX5RviDt89w2qxQByTXGIcqBDdljBW+7xk0+kliIltlPyDz2IYxze8j/IQEXKoEmrClFWpxEXerBxs0tkSYdUmcjCG0L1kJxsl2TjFAuAd03SUk6cs3Pe270fs854zUlmTSffhBcG/GHrRK+VBdlxvJZkQ/eddBDL35JW9uE9a5eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(6512007)(4326008)(6486002)(66946007)(38350700002)(83380400001)(66556008)(5660300002)(107886003)(8676002)(66476007)(186003)(6506007)(36756003)(86362001)(508600001)(2906002)(26005)(8936002)(38100700002)(52116002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDN48F2pX2oEtx/R7q6tPJMCfxNVUWPSh+KHu68pzvtOEhpAWqqrlI5mH6MX?=
 =?us-ascii?Q?5zc1hNj0sOzeD4OKn+BC59Cr4Ydry88MkHlujIk6tqAKsdIovPWZoosPLDh5?=
 =?us-ascii?Q?c18sFRrGCsD+N06gc7S1+q+uzZysNuwMVN4dJ6koTaVlTdExuHooVDLhBmnZ?=
 =?us-ascii?Q?riGBWdFg6s0LlEDJ+eFniTlcTVwYjGzR0uN8dqJTiICHiuDnBK2+w6b6b5kb?=
 =?us-ascii?Q?ANsnCGVI8XfwZCYWCXcjTHyP/gIRDG4stgXvgB7qU5fEvnFBGUaGBh9Xc5TO?=
 =?us-ascii?Q?GcD/yHRZPuIZdTUvOiZzKz2DLPU4jzB6mblhNVciGe6E3DyPIZtkPiJa/5bV?=
 =?us-ascii?Q?EGHiDYr7tsLy5jVc9ZPtSGWmvCHndI8lY9Ghx7o/eIEmbY9qxIcIgbZa6pBE?=
 =?us-ascii?Q?mfcR02q/C4VDpbNemn7jok1ETmVdjJmuORzQpsWTOskRq5ZwaRFKiigzs2MZ?=
 =?us-ascii?Q?apJvrADsYPDQK34SAE1sy3e7DE+CVV9acH+ixUu1Eg2K9pOkgMGRv4TFefBU?=
 =?us-ascii?Q?JPQ/UP9A4CnKBqt5jg1e1Afk3MQqmxl+P7lO/f99OC/H/zZ7uOmwnXO6JrA1?=
 =?us-ascii?Q?r/eUja3jl24E3RL83svCrFZ/egruUAgSbGDTqeK7Vx/o4vihmpIwAo0JnFMQ?=
 =?us-ascii?Q?cgtil6uSWbGlrL5nlPxrdsjExpiUvQxq2sgy+dzt5EEDQrMoSqc5nB3E4Mk2?=
 =?us-ascii?Q?DTiLTRwoJZo/d0Ynhkn3ROJCe0U/Wl0I62YDM7P7I/ZjUdAeBxwic18lD61X?=
 =?us-ascii?Q?S+n+x3cbBXTnIz0GEDe35cMSga6J4FEzM6FFyAaGA25tC0NajNoimBZ/D7tE?=
 =?us-ascii?Q?JFOFklmrwWl99ljm4rkyY+h/+yc8ks7fExPJbY17yBGMci12VdQWwEY3pSPx?=
 =?us-ascii?Q?OyKQncfdCpu92KG2CUsLC0ljkNGGa8eGlh1XgaDug6ZKLtd9P2ZJkDFYa5Jg?=
 =?us-ascii?Q?WqSnV744d0Oq5vqUIdVzZ5aQG5ZcnGbzLqH5CGysGtPcfXvkYZsR0G/HTSHt?=
 =?us-ascii?Q?PiCOIef3f6P+Ht8FaVFi9ZB3Z27KtCOcIIPvD3ScFsnsZKv0p8a8HS9Fy9j8?=
 =?us-ascii?Q?+usTM/F7MFHgCUiS2yfFXxhhy4lvptPrwJSH71cvqSNHgNUIqGvibS+Ggd6B?=
 =?us-ascii?Q?nF2/riQHhOf6+IwrpjsVTkHsPu/N2rycTB6T/ctjHNpHhYYviKnKbnS9jkmC?=
 =?us-ascii?Q?zRL9iKKpNpLvoDHXX3thLZjFXXfgagp7tPW9kSDy5zeRHQC93jf7Jdd5dqZ6?=
 =?us-ascii?Q?QbmSlr92xiBn/gKxJ7WNFNAfyrz4srnUkxzXI7j8ewSUfkD3pwy0KqIEVkoj?=
 =?us-ascii?Q?iK2BcVAej8R9sbDeRoAk2qIhob3gBga6He5zfnhmdjzcu9qcyWc5km6GlQ6j?=
 =?us-ascii?Q?JMVVbsrXZVBjk3Zzb1++Kx20oeLgk+YczqTYQ64IEi5y1wZ3ZtRJ3Kz7Dehr?=
 =?us-ascii?Q?XyPtBonTLw9xieT+GdTcoXQguZTMOHwckKbbOL4ukZgN+Mf7Yct5VsGjlxaV?=
 =?us-ascii?Q?s69OzHModq082nW3arBa/dHwLlphHTJrlG3UZWOqGPEobOY0Yf0s/Z0tkk5y?=
 =?us-ascii?Q?V7/I1E0feiB52u+cQaJSFxOxMqMZG0GiPDmDgWjreHxwBx90GivSGRv9KQd0?=
 =?us-ascii?Q?1GEtw48urXS1MSx5xppvW6Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cfd509-9f8c-4ccc-2803-08d9d7c56e11
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 01:22:00.8064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GzKNzM8dhPMg/gs3BFygHgA43je+cA/58TdBRmKzPPTGYQjUxfepsQNxjxx1Af/vkCE5UEJbR0gnZ+s0bdfYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5182
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10227
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201150003
X-Proofpoint-GUID: _R8fvd5j12g-780fn63GLbQqaRl0OuMN
X-Proofpoint-ORIG-GUID: _R8fvd5j12g-780fn63GLbQqaRl0OuMN
Cc: lvivier@redhat.com, eperezma@redhat.com, si-wei.liu@oracle.com
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

When control vq receives a VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command
request from the driver, presently there is no validation against the
number of queue pairs to configure, or even if multiqueue had been
negotiated or not is unverified. This may lead to kernel panic due to
uninitialized resource for the queues were there any bogus request
sent down by untrusted driver. Tie up the loose ends there.

Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6fa968f..86f84dc 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1563,11 +1563,27 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
 
 	switch (cmd) {
 	case VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET:
+		/* This mq feature check aligns with pre-existing userspace
+		 * implementation.
+		 *
+		 * Without it, an untrusted driver could fake a multiqueue config
+		 * request down to a non-mq device that may cause kernel to
+		 * panic due to uninitialized resources for extra vqs. Even with
+		 * a well behaving guest driver, it is not expected to allow
+		 * changing the number of vqs on a non-mq device.
+		 */
+		if (!MLX5_FEATURE(mvdev, VIRTIO_NET_F_MQ))
+			break;
+
 		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&mq, sizeof(mq));
 		if (read != sizeof(mq))
 			break;
 
 		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
+		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
+		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
+			break;
+
 		if (ndev->cur_num_vqs == 2 * newqps) {
 			status = VIRTIO_NET_OK;
 			break;
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
