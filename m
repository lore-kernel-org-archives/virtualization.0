Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023072.outbound.protection.outlook.com [52.101.127.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60532D7F0
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765968625; cv=fail; b=jEvgkCB0FjVN9FJXIUkBsXyGG12/pMRou5lNgS5qn2IkENctHU2sAnAwConzszPSUH9hb4u2IydPOM+79c/YLRsWFiXegWw7J7fRso5FuXsqGx2dgOfRp6RLVfozNNB08v+CDrHT2HQfLbL7N2y3bGAU7s3pAKrutY+Js46vFT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765968625; c=relaxed/simple;
	bh=t98e9AJdVdEtm8zQ5uO63LtSpcGGmgxTeNvIWJzOqQs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H5bACeOlLSPED5HjUde498NuUQ/2QllZcrxCIv3AF5vDfHrtiejlyMUqhmPuiM1+hOx616gxVXdf5lsncGHMQszKLSIQs0rX7hsJUaKyMp1tTUaZ+5bbW/Qlg94axzvmMRxJnpfKjVeqeVQafC5vFRWb9AAuHNvaVDSlMil9iRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=hI2r3tQx; arc=fail smtp.client-ip=52.101.127.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="hI2r3tQx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrMbS6YomoCrFtrtg+ly8W80yA4fMk2EioF0CEAOIZl2IS9keW8buR46G8lyIld4mAZkce2KfMHKpDKbmMlEKXJXrd065Lsu2GO6cwCtrR9XUatsKFsM3xzEwSlqEFNeWjVUQO4zlpoFZgAgU/9/JBWiRaRMu9zIHpG2ANX28FlF0iSR8rRAjnVj3lSsCzvIlY/o8Vbbk+7IKhDmyt8QXyc55ABNhK9qoAr37eq9rC7v5l+P4PupgINkmQvVzm/1iyoVcX5wmKKYbm8KfyNVLI+wxreUanNRFuQsGadx6y6p+HUDRjeq4TOYLvJyDPMdfOKMtq4AzShNQ2MhtcvHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koLWXWVOviiiMA7W1Gmja6T2X5nxoFRBjZEkSlPup4Y=;
 b=JvUo3no0wJFQ9q/6R+3N9ymJyvJbux2toQLwaTpz9dpA90NRycyyO1eTGdpP5+jmsnwImJ0XhgmpnFzrvadblJBIA7xj7CqU3200rYXKdAUzqZ/LdG2iwpblWrZcXfuziAf9N6APFdElWncqRfrAzDix06x4WDVDyjbMV0mGuZ4nFscq3lOpW9AvelrU+8r66Q7GbpgQaToBLk+BGjkoTJy2ZE0Xa/zCqu+UIENoM9vA/BWZu2WPPiDY5Rc3iK3xlkWBGTTa71ftIGm0Z11R8ogLxMNexcz61WKwx9vphPn3CW1au6uW29Sjl7GtQwkOVri4wIpmoxXP3z/4OzfzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koLWXWVOviiiMA7W1Gmja6T2X5nxoFRBjZEkSlPup4Y=;
 b=hI2r3tQxJc6tpnrauXBD6au1W8yQBgyJ6rODXa/PG/0vCixbPHVUFzXsztFSqvImMGIF5g20n+5iaxyAapqEN49Q9diejtaOMLcBEJmnoXFH25sQXefQmDVwYD1iI76Y/0PTwedR1z6iIrElJERVwaLbxzk3OMjebME0r0dO/7pI/iREvEKi6f89ODsl/DkqF2xz5w8lvdG5040ZEd1ptsS6bKsob6USjc+aI8pSvERV3epFN7FOVmS9+cQG5V13RpvPT5J3azp33zjxn4W7Z8Vu6CohU3yoio7HrAuaZAl1h2A0k2AlnRpg7LW+Tn9kPOWwZzo/8/wzxjByWPctQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEZPR06MB4998.apcprd06.prod.outlook.com (2603:1096:101:4b::13)
 by TY1PPF19F8E0514.apcprd06.prod.outlook.com (2603:1096:408::908) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Wed, 17 Dec
 2025 09:17:43 +0000
Received: from SEZPR06MB4998.apcprd06.prod.outlook.com
 ([fe80::43bd:6cbb:28ae:c259]) by SEZPR06MB4998.apcprd06.prod.outlook.com
 ([fe80::43bd:6cbb:28ae:c259%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:17:43 +0000
From: Angus Chen <angus.chen@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH v2] vdpa_sim_net: Fix the error handling logic
Date: Wed, 17 Dec 2025 17:16:43 +0800
Message-Id: <20251217091643.307-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::6) To SEZPR06MB4998.apcprd06.prod.outlook.com
 (2603:1096:101:4b::13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB4998:EE_|TY1PPF19F8E0514:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fd84fb-2755-42c4-11a4-08de3d4d2267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?RBraxRquiQrP14OUx6LVbm88G1fwqaS+vW9gduowlQZsgcBE3hlllFujRZbx?=
 =?us-ascii?Q?r1uKgSMp4/hrFmJxxMkSPNu34SdZHUCZpZ/qn10lWSrWx7kwQ/ajyb5TOi/L?=
 =?us-ascii?Q?6qZStWOg7EqR2+F/XiG/KNzeBqt8XE0M4KtulPoa7gDrKmU0jjrEIDPUgVKH?=
 =?us-ascii?Q?/TCg/d4GWRv8PgWlj+Fq0nPCGjTeheuPS8+6r04ZEP/78zJNBSJZZxnJ+suR?=
 =?us-ascii?Q?MlJ1ZJUHddY43JflnPLtX3o2fSEY/dlD8GRob9y8weGK5wHTSQ8/vot1+s8h?=
 =?us-ascii?Q?3Dn0IWn2aL0OkofDeWHrIi8Q0ezmrcNywHIKQE44d/R3Yaio5aYQD1BGsQu6?=
 =?us-ascii?Q?hn9AtMs4oqagtB2Ds3lSfwYShdr+MopvSQPC6+OKlNYgib3KHiF3aMKacanh?=
 =?us-ascii?Q?oUzgZigNk4bmCs27HmoIweoZ/9fe3Inu7cxFCTj5K5Zw9eu1EdWpzEsZjKIn?=
 =?us-ascii?Q?ntzzH1nh/CwERDsVTfyQAHRwHEkPd7Sqvvc9gn7Wg09KZWA4AyRKjN7zy3Wk?=
 =?us-ascii?Q?b/ASofwbdU0hW0htIN+Q3RaHzAsk0CC/ltJLCPfNPOASVPRz6zctHghr8HgH?=
 =?us-ascii?Q?6oE92cLHbr5KrVhMps0TfNfvQ+r1ZP4BB5i4FwYbrY0vzhUIrk5wTUd8F5WP?=
 =?us-ascii?Q?btw+QTbSbHKqHs3fPOJXbaimTEl3+AtTuwjfSvXWD71Bq8DyydzYFxlUgYfu?=
 =?us-ascii?Q?WyQwe0JcvXG/PZeZNTJzRNwWYvb8J/mzbUhmOFEyO5D5+s/7dJf18jNOLh1l?=
 =?us-ascii?Q?Y0Dt5XkBjVyyCExJoFHwrgmNXV3QZCkmLTd8cjoJ7u9E6w2qkwjfCMu3EoKS?=
 =?us-ascii?Q?egVNlzvSveDtSKWty8IqZY1H8jQYTiFcf3FQvwbzAxKjFH/rgKvlbo/bNXI0?=
 =?us-ascii?Q?oWpEqtO74EHIR/+ZzCxN6V2S9UhvnagftznBY+RfSlPUzQQPe5Ndlzia98wS?=
 =?us-ascii?Q?x37IqeU5EyOLYG+VOA8AClm5XT2uvHjzUq8dpW43FRCrG+XBq6muGrcFl1Aa?=
 =?us-ascii?Q?Pvw3ePMTPzQ1otITkTEf5c737xf9eUrK4VyAG7mkQUDNxwdL9FvS4/9eg6B0?=
 =?us-ascii?Q?zP2PwuJ9mMIfCNgue0IQGPea7wOTa4qo7afEi+c020H0WeGggSVZtfEMXtiN?=
 =?us-ascii?Q?lAnocfPDJ0bPDEpnOcDtWDL4O8dH5VkKYQ6+1xnzeaYh1w7mM1EEOtq3g8Iu?=
 =?us-ascii?Q?fQQhvggo/Lg1w5XxvLqRyovBMiEYW4lZxBlySq+u07CM7/AvlgI9x/BULboX?=
 =?us-ascii?Q?jGdnHzbW0fzfD/+xETPEImDjE2eaTFRKpR+LyXcZHGjC7fDYVuZa+XLFThiM?=
 =?us-ascii?Q?ns6dQM3+SAvJt2lqWHpfyUMwCejbxnp4oN+9eq5bYd8v2E8MTsFZcROLh+vh?=
 =?us-ascii?Q?ZA1QIY3E9WFeCFwmVUxXpwsANTtQ/EX8iTo/w5fYM7mS7tRvMMLjkr73hMcU?=
 =?us-ascii?Q?LgB44nYTSwPb8p9Kkfvf4anad7zAnch0F9ot546AZuMAMCCQqeR0bnDJKUIf?=
 =?us-ascii?Q?gyKMCIRVB2mCvgxdc3dZZqKbT5vYehPTV1tU?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB4998.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?0vruysWBw8hkcQ3kDBcxGwsujouFkvjmzxlvinF17rujjYx9y73ib3TikFBO?=
 =?us-ascii?Q?KkKL1GBUuomNYa31M+l0Ql/5COixj2kXcjBXOu+zaQhwoKmRxRRdGnOZZDha?=
 =?us-ascii?Q?57mSYrWRqVeLISXCkBmZRTdxJD4xajnZrw/1+z5eaI68zyCzIP4lPNn0xMbz?=
 =?us-ascii?Q?PnM919MUR7DPbxhSiGSycxNAw0nq+qC5kWZc/gXeVoyljEn6ScF1xGmrktRP?=
 =?us-ascii?Q?xgQJgTkec+1Y1OBdwrc/VmRIVKjGRHS0WoFH5NJmqgwLzNHZ1TejffQx0j4d?=
 =?us-ascii?Q?leYb8YY25kD0eHWDnk490PDlOJeJkg1RbiAor6JquVOtycRKViXO3sWBmxBP?=
 =?us-ascii?Q?it7PhVT7YUFSJzg8s7sVkBoxIAWlNAdCpdGZYzFSl7eeSeU5m62nMQKTB2DD?=
 =?us-ascii?Q?KXblDuqlUTW5lCP8+6qI5o0VCCs4hdDfDWZVk4eU2l5bFlRmFEZ4h1ozFyNA?=
 =?us-ascii?Q?wmsS+c2PE4Uce5WakUoJ06zMRzFtksRZimbjhF8M1sSzFAATxiD0Y8KF6IFF?=
 =?us-ascii?Q?Q3NKydrxvfz+8mGwa0CR6ZFkV3TioN3tZ0kKKA3QtDWdjedRRT6Ch1uk1rSK?=
 =?us-ascii?Q?2Sk4hGllYvYtLOfJZ5Eh97nnpAG0LgLVjwGOFInVOilRCE2+9EZqlqceJJTJ?=
 =?us-ascii?Q?AGkWI9oKdreR4iBShi9IoyrvBXvUnxno+vyQpZ1RwQdtOvCGJLMiZJYLN06B?=
 =?us-ascii?Q?I93nylBAW2XWM20v33lHUBUj7/9jAyTuqLef8apieeYv1ooG7lnfrMEq+A+M?=
 =?us-ascii?Q?QXkQO54LlxDKfJNAAz7FIwNjphQ5JxWTraoJuaQJW/tB1/fUE+R2BhRw6lUk?=
 =?us-ascii?Q?Ob6bqvh7RnLgCQAP27ccfHlxZDiIQvqx7HR41Sf3NVJ2e8MridFdWGxJnaXz?=
 =?us-ascii?Q?qzrsfxfGwwNFng6E5cDLPbddy2IBPQDwvAdI8vVKQtqtg+5puVPBvIMENtD7?=
 =?us-ascii?Q?8qn044jWpPefddOrjtfJjv8CiXNEl//mTD2+4j7ULecfTgXFWGnNDpCsWmH9?=
 =?us-ascii?Q?Oz42rESDFE2nNdepq8kj4sCcx2i3oaD5hWalxn1MXN0t/aIi5hcIsGMVLX20?=
 =?us-ascii?Q?97s2BfWoBiuIMAgKPHUPrPSYb/rXPvgLEuiM3lA4EkX3Klq6uUlZ/IARfpK+?=
 =?us-ascii?Q?w+sylAdb5cGT8/8eQmPC09OxYM5m3VqpQe/vUxgcdjj3jHb3rcwpxrfxd31m?=
 =?us-ascii?Q?U5H5vwDSX6It8L5tNdbcffKgMbjEIFRudq8aVTn3NTulGy37B8NIyBUFMBsA?=
 =?us-ascii?Q?iYQJY8JskHAAw87yl4YedLSqpW+nkBeJVR0uEDHYs5/eFkO7Ap33d/OLV6Sf?=
 =?us-ascii?Q?ls+9OplqQ3vJoZSHpKfWqM1H2Dn9x5bgD8V0VHV4D73ELjtKZ/cPZjDmXZBv?=
 =?us-ascii?Q?Llsl3KRRu1bOpF/lsjSEZ3BAZ1k9WTkezi9+q54ACXtz5WEjNAdJhSMTOOrH?=
 =?us-ascii?Q?SSRq14C8QiQNrTcxBBWWPylQruXPaaQxdH6Hl0nVSDO86ud+Xlm4oAHjv3Rn?=
 =?us-ascii?Q?MydVZwXbn5DAoun2VQzIxwXZgfZNyaAfBpfg954tDLCuYOHzQxpyW+cCG1FV?=
 =?us-ascii?Q?QQfsLMLJJ1zB5HnUtUFiHgkoMTUJ6CP+ub/wrdnp5UJrP9wDEWe2pSmorAnM?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fd84fb-2755-42c4-11a4-08de3d4d2267
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB4998.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:17:43.6223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMlY8sa+ahSbjg8EWWdHvWfW6JlhQBn4QybiyY9NyGsmXMHmTp8M73XlZxI9cT3rYNMxpOQR1dyDKymyfUTdPnBfQPpz9j+dIcVcHekjvxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF19F8E0514

The vdpasim_net_work function handles both transmit TX completion and
RX processing. A descriptor is taken from the TX VQ at the start
of the loop, representing a buffer previously used for the TX path's
initial read from the virtual network device. This TX descriptor should
be completed back to the Rx queue at the end of the work loop.

However, the error handling logic was flawed:

1. Read Failure (err <= 0): The TX VQ completion
   (vdpasim_net_complete(txq, 0)) was performed, but the unconditional
   break that followed prevented the processing of subsequent pending work
   items (other descriptors) in the queue in the same work function call.

2. Write Failure (write <= 0): If data could not be written to the RX VQ
   descriptor (e.g., vringh_iov_push_iotlb failed), the flow would 'break'
   before the TX VQ descriptor was completed. This led to a leak of TX VQ
   descriptors, as the work was never notified that the TX buffer was
   free to use again.

This commit refactors the control flow to ensure:
a) The TX VQ descriptor is completed back to the rx in all error and
   success paths related to the current descriptor processing.
b) The unconditional break on read failure is removed, allowing the
   function to continue processing remaining work items
   until the loop naturally exits.
c) It updated some statistic logic also.

Fixes: 0899774cb360 ("vdpa_sim_net: vendor satistics")
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
v2:
  - Add Suggested-by tag.
  - Shorten the subject line.
  - Consolidate vdpasim_net_complete calls.

---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 31 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 6caf09a1907b..8c7b943f148d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -231,33 +231,34 @@ static void vdpasim_net_work(struct vdpasim *vdpasim)
 
 		tx_bytes += read;
 
+		vdpasim_net_complete(txq, 0);
 		if (!receive_filter(vdpasim, read)) {
 			++rx_drops;
-			vdpasim_net_complete(txq, 0);
 			continue;
 		}
 
 		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
 					   &rxq->head, GFP_ATOMIC);
-		if (err <= 0) {
+		if (err == 0) {
+			/* rx has no available ring, no need to break */
 			++rx_overruns;
-			vdpasim_net_complete(txq, 0);
-			break;
-		}
-
-		write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
-					      net->buffer, read);
-		if (write <= 0) {
+		} else if (err < 0) {
 			++rx_errors;
 			break;
+		} else {
+
+			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
+						      net->buffer, read);
+			if (write <= 0) {
+				++rx_errors;
+				break;
+			}
+
+			++rx_pkts;
+			rx_bytes += write;
+			vdpasim_net_complete(rxq, write);
 		}
 
-		++rx_pkts;
-		rx_bytes += write;
-
-		vdpasim_net_complete(txq, 0);
-		vdpasim_net_complete(rxq, write);
-
 		if (tx_pkts > 4) {
 			vdpasim_schedule_work(vdpasim);
 			goto out;
-- 
2.34.1

