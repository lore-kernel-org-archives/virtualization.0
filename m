Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AE1C433EF
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5455060F8F
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5455060F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19108608CB;
	Thu, 16 Sep 2021 21:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkxIM_t3w0-r; Thu, 16 Sep 2021 21:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 97860600B4;
	Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BDA5C0011;
	Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2D34C0021
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0B6F406FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="DRRgHV3U";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Z4sKIcZi";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="C8le5lrT"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x_oQuaC0XHaE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EC56400F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:09 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK5R5a010759; 
 Thu, 16 Sep 2021 21:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=/cvzxwZtxEgsiDzhYZDo+UjkF4zhNV8spCgc3PFY9sg=;
 b=DRRgHV3UlIL+rJXgzfCUii3wVbX4YaN543TMiWr6PFBb5TlOo7wYlIPn768fK2XoX5yY
 fwK7AH3erQmGnysnI0+AdPFHHC4TDmoLgLVvOpNsSWl3xiGpI6n0np5dO6i1RZlIusDh
 zGIDQNuKxmWk/ltQqNR0s+ZVKCGuj5SLjmUOFhYNN1NrIof+cQcn5ulkuBFu7A2xmXVM
 GFwOwBA4WqHkaclZhhEgAtc/nESpCePQ3cYFD1Qyj19JRDi2FvF+qgHyLJDq8ZiBDN9N
 SjQStPU/du5KG9U25jo8ak5PC1QMfqRt/2zwjfg/LbF36fbgcWDSK97fcpHDonu8F8S+ 1g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=/cvzxwZtxEgsiDzhYZDo+UjkF4zhNV8spCgc3PFY9sg=;
 b=Z4sKIcZi9+ERVV0NTQctM18lSArr12k0JbAeyoAA1zwgl0QJp0s+j4gEGx8HgPT3wI3d
 u+/aGZuR08t4aYPz4MoDIV5MvqgmA/EnIYNVcVJcG4qQAp25U9kj6duxxJncPp6qJXkN
 eLCy76S+SQw6B0srY4C4dOXwyt+Uhfgb+Mku7jmB9pKNlZfGiHdDqkvOT53nrt+nKHhf
 dc1XP7LjFXMo7sHPOBGpCXhO9gpeMLYCbZ2Fzy8IN+FEeW65Wy3+HaHblPxWmhftWhuO
 eleqkK0Kz/Be4gaONEA4PcRIK1+Vq/DEA/QlFMaeZzRv2Gc5p3Yy85bhuO2+b42nnkGt 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3tnhv271-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5XNp011268;
 Thu, 16 Sep 2021 21:21:06 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvpe-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9B2HdFmmWcnaDrWS5fTh5bM/HgX5dzOMJM17n3vgWbttyH/RJmBcWy4DKX9yRhgv4L+jsrbo9ZPXbhkWPnJ7OWrLeRJK2/kXhiSHedUU9er71ZLFsCT8GsUZZAVyLjLuweEMjtki+ySGM+sqXKTkN2H+Ma72sUKk1atIsDwwFdZzQhO/ZCPWL84ETbRRJtAAFycdO+l7ul8bGF1BN3/Tz9NyrzhSUfDvp3ppI+UZGW3tVT4M1EvImxBkfiu/xKQWgr/EgIZfvB2RNMtEi9Zu6qybY0fWOaPU3SanbGq/oKHjQ7KLGRVQuygXRiBbfnOCepmFltKRGPcbQcFOEIDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/cvzxwZtxEgsiDzhYZDo+UjkF4zhNV8spCgc3PFY9sg=;
 b=oYmkvj/uVto4BiIJY2tBelbWrD/Xr2J3eP43fyly/uiNf+8RQ1wRDUinsGvSv6ZJ9yR0mDX1Av56TtZy9k1UBhXBaugZbI/pGGTvdpll+5eiYeUQVSgj0XCsPR6/czW8v9laKGGEl15IpreDBRqb3VTJO4ct52Yx3ZeIHUMK9LmcLfWiyUCiaeMc0stacEumGljsCJl7fFVNAuQBD1EhO8dfr1nC2MlYaR1X0OqM7zXuWSBCHOiSpCzm81uHgLWKSpuEgX84U+3ydhIAhkPYzpfcJD8VqSMnpZfv27ynpEsf8MeYHNmWNCaUYQLmOFtza5a3rk38b19aOYVqgcccGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cvzxwZtxEgsiDzhYZDo+UjkF4zhNV8spCgc3PFY9sg=;
 b=C8le5lrTaZmxPm3XfZzHt8UGql9jLPpelAFwMJjPuvEbNmz7vumYSo4lswCzi+lFoWWLPYx9Ct8xjbRU8S0SsHXgukwpTQqNK4f6B9+ovCOEvvfwmGExTVw2cbd2OdCByg56jLc/eu+uWfLhR3/vOiw6nLOVIeZ0Td5e/st1MrA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:02 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:02 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] fork: add helper to clone a process
Date: Thu, 16 Sep 2021 16:20:44 -0500
Message-Id: <20210916212051.6918-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916212051.6918-1-michael.christie@oracle.com>
References: <20210916212051.6918-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:3:12b::13) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c7f127d-244b-47dd-4167-08d97957e295
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2935BAD917665F71A98CB9F0F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBMSG2QHuiXzbaSCpG+rC6moFJ2oCx+VE7LVRxTWsAdbp1XcmVG2dSR2DOCNBRhNBFmIm17zGGpKKCKzAIe8/2hNLlpxyVyCb4oBpFU05MTODDEUQuNhhbLlQRvHYOLbU9avT2U41MmU0eMR8he4LcT3IxOWYY6wCTaTPRL6YkkemFvK03NTb6pN/JKesqsOGeqTnMnRsWLEdtqEdXgdGXan+rjUeRIGtCRvh2+KLz9c1C4agYtHvVpMZneJvELU+tMarYfubxBO7YhDTGiO4n+vztqQOEz8e5My/zkIiZACOUAisfr8GsF79G6Fi4J3AqEzEdFn/9UUVO5aGHgJXPYpDYhkroBt0c1haUcI4oTFFMZ71J10FDAWfQI5d/N2nja+Ofnv03qLDN+JNTbl5eoo7M5Ca8FgOvRgsF273jeLxmgM4Vg3Rar8SFQb5bH+XPBRqYziBd3/7rc6UnVCkqNdPIg5R8QTQdHSOzIfCTxEED1PszizYih6x6FSpYRe6cdglX2LluBT3Uftw8WdS8b/zCWcu3EszjDCRPUMGLJYuToxsxEknTWeJOm0/3iUPIB5xKEifV2NVcO49GBX9tFSYD01HOXptTZFQ2c3U++tVxgVPi0MWXTJ0Qb4U5OKpnejVeu+TwWqYseiRbzUY6MQtEYEtHxJWjZ1qLDTrJcHkLtH8MGYknjMMl72DxnyY3T8K1ErSegZyRQRsDKvOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(83380400001)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C7wG8HHrSjxYFW8lZw4W3q60l74vIl6xFXBaz8ITKop14V5XoHV80bKmsQ03?=
 =?us-ascii?Q?lAjDtt2PvlraY45c33k/32Bm11coZf33jMvs1p/sDLL18QM1RLL2oNljLQT2?=
 =?us-ascii?Q?cH8R9aboxLLkqoSxaefMU8Pzmi0A0S65VwYah97OMtsE+AOpJZeoO0Sw0uWh?=
 =?us-ascii?Q?WWXLwZxN+qUvJUaIkwj9O0KsPBnnVGTTgz3QatoaQetLe0rzHMLPgnoznxD8?=
 =?us-ascii?Q?PqNpAAvvIpxIvJmMPT+U+kJ4yNfl0RNuVGepI28x6leW/if2rHCBcfBOwE2q?=
 =?us-ascii?Q?LSUzhDf1882Kuq3R8x7hBNEHsY4ErWK8/Ld4puFCowqpbud9PyK58zsM5hYg?=
 =?us-ascii?Q?Eprh1TjPdZOyyFo5VTAkq18Y125sDUlO4jEnPeC4VUi6lY16fyNS6tzCoyBg?=
 =?us-ascii?Q?ze5PFHb/9U4r4/x4TGbqj3eNQC43nDcCsktndC1n0SfUV2pbcZVLzg6RSG3C?=
 =?us-ascii?Q?ubeETxbty/tJhZ+u1s2PIiEUhooqT35Xy4Fgsbdtapb1BlLez21TC3diNSXI?=
 =?us-ascii?Q?DGqCabO0HlM+jddzkcWsv5cnKoPX0rnTyVf8RrHO1lGYUj+hdYGkTfTV0Smn?=
 =?us-ascii?Q?AvG9Sb7f3yxPOcl0lc4vz6WjPkno3ordILXYad4IY2/no5SSA2+0nfzB9jVv?=
 =?us-ascii?Q?KX84nThBOnkuWW4a7HDkjabCNN5xJUg0mI01jfeHJ+05CNu4ws3Aw1vi0OMG?=
 =?us-ascii?Q?Aen5/jf/QXnu78WBiROU33HVrEuAGAjv+EJCyf0ySyMEPNHXiLfyS1Hw5EPT?=
 =?us-ascii?Q?jd0irFgsaT2iQv2OLxdqFwCscKRdu1sIDLVTpazq/0a6ZcLr8fNxoqPTABrk?=
 =?us-ascii?Q?oqr6RE6OPMZpgz4cHKDBNwv9KFwR8+G+h5hWN8eJAbb+tmVDV4IiIRztMO4Y?=
 =?us-ascii?Q?XWOZ/IgAWW/OwMFenfqlVUTpBd5G6jj/UjYuHkKlCFc7Q8dmq6jnDgnOs2l7?=
 =?us-ascii?Q?Lgnr5bKL6OA4Vi2A5oPMaPXCUikHqlgCnPoTVvT4zKP2P/d48DBxeV36EBgM?=
 =?us-ascii?Q?0DxFuOBlGSK+qbqHh7weWze7q2kEUaJsPgdG1Ej/JaODbdeEc9qJhxsfMLqH?=
 =?us-ascii?Q?AcJPAWNt4419vg5UuBP0kcJyx3SpDwgzGhVeJBONS3YbmP98/JGbxHrtmMvA?=
 =?us-ascii?Q?k5eKDv+oNd5VxZhtXGhQPyhjL3jQ/7Z/K/LUjbhm0dv06sSojWkOLbmuWjuv?=
 =?us-ascii?Q?tsYbnyBb20jCAN3t/STtM5xwDXo1d+OQxzWVbz1BqMSHQTw7/513fGTXr89G?=
 =?us-ascii?Q?hpfbYnT6gnL69w+nSwFyI0cnVBd/UIdx5lBHGJuQQuzyBuRcj2XJr3JrQ6eO?=
 =?us-ascii?Q?IRNT9AE0bm5qqe8+8XrPi2y0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7f127d-244b-47dd-4167-08d97957e295
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:02.3881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCJn4O3SgixoAlEUbpoW3s83qc+Gi3+0gBmSqM/9G+YUwBdeSsM1sffFjOGVjuu1dUwlglpoEDXzHYoj4aMKZyD0R/pZajO2CL3MXXoXjmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-GUID: JhTQ-nWIf3axvEFmnQSUw0YHSZy6LaU2
X-Proofpoint-ORIG-GUID: JhTQ-nWIf3axvEFmnQSUw0YHSZy6LaU2
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

The vhost layer has similar requirements as io_uring where its worker
threads need to access the userspace thread's memory, want to inherit the
parents's cgroups and namespaces, and be checked against the parent's
RLIMITs. Right now, the vhost layer uses the kthread API which has
kthread_use_mm for mem access, and those threads can use
cgroup_attach_task_all for v1 cgroups, but there are no helpers for the
other items.

This adds a helper to clone a process so we can inherit everything we
want in one call. It's a more generic version of create_io_thread which
will be used by the vhost layer and io_uring in later patches in this set.

This patch also exports __set_task_comm and wake_up_new_task which is
needed by modules to use the new helper. io_uring calls these functions
already but its always built into the kernel so was not needed before.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 fs/exec.c                  |  7 +++++++
 include/linux/sched/task.h |  3 +++
 kernel/fork.c              | 29 +++++++++++++++++++++++++++++
 kernel/sched/core.c        |  4 +++-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..9fc4bb0c5c7e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1220,6 +1220,12 @@ EXPORT_SYMBOL_GPL(__get_task_comm);
  * so that a new one can be started
  */
 
+/**
+ * __set_task_comm - set the task's executable name
+ * @tsk: task_struct to modify
+ * @buf: executable name
+ * @exec: true if called during a process exec. false for name changes.
+ */
 void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 {
 	task_lock(tsk);
@@ -1228,6 +1234,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 	task_unlock(tsk);
 	perf_event_comm(tsk, exec);
 }
+EXPORT_SYMBOL_GPL(__set_task_comm);
 
 /*
  * Calling this is the point of no return. None of the failures will be
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ef02be869cf2..c55f1eb69d41 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -84,6 +84,9 @@ extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
+struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
+					unsigned long clone_flags,
+					int io_thread);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..cec7b6011beb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2532,6 +2532,35 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 	return copy_process(NULL, 0, node, &args);
 }
 
+/**
+ * kernel_copy_process - create a copy of a process to be used by the kernel
+ * @fn: thread stack
+ * @arg: data to be passed to fn
+ * @node: numa node to allocate task from
+ * @clone_flags: CLONE flags
+ * @io_thread: 1 if this will be a PF_IO_WORKER else 0.
+ *
+ * This returns a created task, or an error pointer. The returned task is
+ * inactive, and the caller must fire it up through wake_up_new_task(p). If
+ * this is an PF_IO_WORKER all singals but KILL and STOP are blocked.
+ */
+struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
+					unsigned long clone_flags,
+					int io_thread)
+{
+	struct kernel_clone_args args = {
+		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
+				    CLONE_UNTRACED) & ~CSIGNAL),
+		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
+		.stack		= (unsigned long)fn,
+		.stack_size	= (unsigned long)arg,
+		.io_thread	= io_thread,
+	};
+
+	return copy_process(NULL, 0, node, &args);
+}
+EXPORT_SYMBOL_GPL(kernel_copy_process);
+
 /*
  *  Ok, this is the main fork-routine.
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba4128a3e6..a0b9508ea202 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4429,8 +4429,9 @@ unsigned long to_ratio(u64 period, u64 runtime)
 	return div64_u64(runtime << BW_SHIFT, period);
 }
 
-/*
+/**
  * wake_up_new_task - wake up a newly created task for the first time.
+ * @p: task to wake up
  *
  * This function will do some initial scheduler statistics housekeeping
  * that must be done for every newly created context, then puts the task
@@ -4476,6 +4477,7 @@ void wake_up_new_task(struct task_struct *p)
 #endif
 	task_rq_unlock(rq, p, &rf);
 }
+EXPORT_SYMBOL_GPL(wake_up_new_task);
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
