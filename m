Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E34EC433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05D6C41C76;
	Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sn2_dzN8rssD; Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 99F2941C6E;
	Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA05C001E;
	Tue,  7 Dec 2021 02:45:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEF16C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A68674011A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="P3qDy153";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="EpTxV173"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZrNEHyU3JCUU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78EBE400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:22 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M56uN019273; 
 Tue, 7 Dec 2021 02:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=GeTXbnKkZ9J0CfnxPwaFHs/4U2aJja8SQR+KA+xBFZg=;
 b=P3qDy153/Vmj7D1G7R95IisGdI4y6LYm1kds4oc7dmTR4lmHYnd3gZC+AlrjibttOV5V
 SdvhsvBscuM1K7vXoaHz4k7xuW7b46SENK92stvck/4vEcTn1x0al9Y90/NFM2e4g4Ql
 4g4Sqp4lU4c0RtRcZfgs/fMPsSpi12Du9qdCtZpZNZQhOlhJXIgs9b1gxIPErHrT8UP3
 MvkGLXJFXH9pyX2rMn5zvO2DI+8wK6ugIPFxpoPD0CZnFaMvdQR3Eqs8gtPWhumk5jdE
 Mlng5+kbwm/1gSvvLcJhWrPRIq3cE+0FISXaXYp2bnpXXeYyfx5McyrZeGDLcjDgy/JV dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqme7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72bJek124653;
 Tue, 7 Dec 2021 02:45:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3030.oracle.com with ESMTP id 3csc4snh1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icHvjTKOUIOOSa1+bvIb57TQ6NUBW2q/+/UGlMdrjr4WRAa6qZFaulmYVLqtm3jmZJmDpkQsYPSehvERM9uIBbmy5CY92SuBl1I6hfOL1SAzqcp7CYYHSgej9WXPJF1X+o2aIcBlEzga7YKhlVfvklNBzhCYgszn+8/Dz6piRCKljHpNJzGGgyvbdiQYXxtW/T2LKYiTrVNBjZFlDvvbSGWTpFUs9cVAuc7EmMSSIqfbswePtHGEZzAmtITAIz5xhGrO/5ZIKHLrQool/+gEPGEKd+2sq/bTgDc6SIIj9x0jIQ+nUJjyHHR7fRqke/91dNYl6Adz7z8VimncoQ/jGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeTXbnKkZ9J0CfnxPwaFHs/4U2aJja8SQR+KA+xBFZg=;
 b=FvvlYEgdBHgVf4HkHTGb0yA+LA2ACFeQ9uV/oVR/hS9KOmLmlwQQMiZNG5cUa8lEjz70Y1aRspw3dcbIXBgFbohG8z5gkGbhMUFgUr8W+4+D8tmxCCywZSFxbivCpYEPyrcRUrjZZ+1aeyW26iSDqjislGt/86N6RJwiiwhr9RA7A0ZqJ2HBThedeWnvpSlXUXhjXk6aw6uiVU4V57ZgoO8EvMDE6DSDgnALHz+cZxTpDhVMLgikIrwUztqxqbOB33uFAZ9Uja7noTsySFpTP7s75nYwWc+z5iTyWb7VCiJSq7PzHbZZd2CgqDboEW41EntLIeiwcsbMoVaCM7nf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeTXbnKkZ9J0CfnxPwaFHs/4U2aJja8SQR+KA+xBFZg=;
 b=EpTxV173CghLUoGHzoBibv6RNG5fUOZz+w3fZNc1q7OFbB+vFHSzLpUVz0BzR2OraVAWXK+PQV1hktGSq3a8kpnhEz2xO6VZZlZ91h9JMyaIjysf3xHTv2oSxL+POcJYQqT7najQ1DZB5Qoi8pXlb2E5rnnX4w4GFpSulX1yBDU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:45:18 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:45:18 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH 0/7] vhost flush cleanups
Date: Mon,  6 Dec 2021 20:45:03 -0600
Message-Id: <20211207024510.23292-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::39) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 02:45:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c41467e-7b2f-4aa5-367a-08d9b92b9af1
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB434740C76FEA2B6196F2DD62F16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXzrJ/sNVkAV3XaJzqVka7VfPkLwy/FNT541tfwh6XwWTbxHDMuwzf33ag43Y76PTN41ubUMN/qQflyuI2fTfeIfhBEGBPCZtzsq/wHwHj/f8CZ7e0EzX7yNFq1cU0qk2U6dIhbD5nnemxlOEUPhjFDwh+G9/459DQ43idAk/J0sNA+xia/4Hsj10x6p4M5XIEY0vaTZb9i7P5J8QWK9aAXv+hqcx9DGJRnaM6eKBZP5Y51g1Nr/igoF4bKnnclXgBZYO4NqiPm6Nxg+6c2jKxIfM5bNMBTmyZ8IlAJEhimgOklei+3i1Kx/KkQzUElks3lCvF7dFiHPRj5Jj1dPqY6wgN+dNyxkRO82amEHCaeHtJq1L/Cy3mx3LEKF88sRSbobGnaZ88Btjps0/EutuECqHGqcA548sxKFLW809rWeKg8HbF6WPWPfQApM2U8FxZsX9gQ74fmsu3qt/cpS3R5Sf2TCUlLa2oHhHPHej4yDqfPR0SqwCcIVPMfIj+3O+z5Tih6LVbKGF0DArSibs5DGm7xDIswLqYLmvs9KKnLQvHtGcGoDcx0N66bivaz3DB39F88g1txJ0CLI/niS9OnvqhjEPxbj92yqUE9Lfp0O/z+l8tITWFN08sdf9Wf6BN040C3UDfjxzjfr11IdlckloGjxV7VK6CSaUa0ZDMrNxT2ldOyUusuEN3oEBtTzyqJlBRWcZyRAT1ny+O/Owg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(316002)(36756003)(8936002)(38350700002)(38100700002)(26005)(8676002)(186003)(6666004)(66476007)(66556008)(66946007)(1076003)(2616005)(6486002)(956004)(4744005)(52116002)(5660300002)(6512007)(86362001)(508600001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvBOYDgIKZHTcwdy5NSZbdKGoA2NvPBa+wxH2is/TDGu3QCrXYM77ErKvp9N?=
 =?us-ascii?Q?uHe5LGwKeCRF/OKzo53ouJ74eteK2vwX/w60ME455Sh7xg6Q7XyhZAWGB0xk?=
 =?us-ascii?Q?IGwJiEuyNJxI40jRg+MWwfxdOyeMZBp9tFW3ToJ13SVaASqixi1L4QEc17RR?=
 =?us-ascii?Q?Ksco5lnOuZMy/Y+sAHRBXoJaRY3AQ2+qIw+YaaZy5iC408xX2Yz7ReG8C9xI?=
 =?us-ascii?Q?d2tvpwCTAEW/NUbhIQumASrPqvt3uq2JyrJSlTvsnqTjtTgVvUCRA4xWLujx?=
 =?us-ascii?Q?3Ien3UnC9gzfn/wabSyTQ6DlWW1nl6Rr5apnBP29rV53knt12OgyZuUPE0If?=
 =?us-ascii?Q?cNWA+Iid3RwRUrzdOgOIrXDOeiO1ZOR1H38TdzxebyLpwVsH9ukZBZZvjTD8?=
 =?us-ascii?Q?2yy2htlT2HympRY3zAXH3ynGRjVpNu4zFvq+keUIo1y7f4LjMMdFxa9aslrL?=
 =?us-ascii?Q?5HC3BLiMEpDrUqNz00ozosbJh13rwvlNAr5v0vlhVhfkLeB4UwVSiGZLmYBg?=
 =?us-ascii?Q?praeXEE7ezOhsYaxpZItPJ51B2Eyhmxm09Sn72F8uPhziASJ3yylcTl6F2rD?=
 =?us-ascii?Q?T0TCl7XhsrG5mrq568Bc/v1PrTE68KXgPQtm2oY6XbxMdW1Ev9MJ+FafsIM4?=
 =?us-ascii?Q?kiq40kw3RELU8pwhHBLEWrlSQSoRxGmRmrD6Sw/XU6nSzOKeG+B+8fjSq8rC?=
 =?us-ascii?Q?mmUClpfbIsBRR70TMcuJgIczl0CaSfw91xU8NgQ4QaecP367wN2KN2WkXhi+?=
 =?us-ascii?Q?1oNo6kL26qfEOKSnKfRm5DFM2kvmqdlcnQbTdsq9BLzpJGpBhQL5eB/T7OGG?=
 =?us-ascii?Q?kMvlnGldqKgUCGuMwFp86Nd4FC7pzPn4sfOGp5Lq0rGP38WdO74onbBk3BoT?=
 =?us-ascii?Q?ujzBzcHAa0Q+8F1z9tShGvlx5YVDT9qsNdMnbSCF5t0fSq1cn+0LXWGYk3xP?=
 =?us-ascii?Q?mzRAKQQdIdcP6/dg9/PA9dBt1hMZH6owaDh5rd0VCPMYasbnimQjIwRYRIL1?=
 =?us-ascii?Q?6OVFOiGjv4ADoq3l6Yz4u+yBdr9BqNSH/U7xM2IJoIL09g/QGXGCS+rCbvPJ?=
 =?us-ascii?Q?X/vTELuTjGyu209f7TpHt4UZoun58Ui5N11BDQ2D2SpsGNDpm0VmN+eFZgb1?=
 =?us-ascii?Q?SRHMt9uNUBA9gymaloRNlNZa7SmHNIAyHn8nMVgavrrHD56wF/TrydEeGFpw?=
 =?us-ascii?Q?qvnaeCILGWbI2MnJJfu0IgNfP+J0V/Jb+Hq33yNA8buhWIcv1jnahr/MzbEk?=
 =?us-ascii?Q?YNwWsn9IwAA2aSXfwelWbQtVUPV9vCnwc09HZwgr27wDGdCBXsu9aIzFetIB?=
 =?us-ascii?Q?3NlEceTQF7P+ibjd7N6xVoIMKQE1qMDQ3zrKWLKhae9HEjmkNNvMrwNsuK5r?=
 =?us-ascii?Q?V6B/KxjJ9Pn4vKV9L4mXiyu3EgoiVXg+7BzaBmZ0OkyiTmiUqzlZShHVcUIF?=
 =?us-ascii?Q?vBCcb/+CQA6xSbE6DTXvFHY2QGDVVTBnN/Z8opjslX/FZMRnNrbOvzu13jCj?=
 =?us-ascii?Q?74sL87Ixk9BsVDxZ34H579yDiFiXVCgt2YRFSkmJ7yJVfRJlBtihKuoWbDCw?=
 =?us-ascii?Q?3EKGdZAjzkRqTZuTTcrKiUhrAV/BXUIrNw03pL1cgZUggNwP1QeaA4NVu5wY?=
 =?us-ascii?Q?W6FHUc1NNqKQMWdJuMr6K3205LfwkOHTREtGEY4UViPZ+Kvx9OXVo6ddHXiS?=
 =?us-ascii?Q?/0w2vg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c41467e-7b2f-4aa5-367a-08d9b92b9af1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:45:18.5726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBUiKesAd5AtkeTHolVEajK2COTbgdccadU6KZ/TsEggk6YSfGxsTBtkVDHQPmE2vWjStMwgvx+IzwvaJ25d4l8RmlQjACFGFuApqNfkIlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=594
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070015
X-Proofpoint-GUID: Kfd_u6AOsDxaMHVSD9CJSSqIzPuiCVNx
X-Proofpoint-ORIG-GUID: Kfd_u6AOsDxaMHVSD9CJSSqIzPuiCVNx
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

The following patches are Andrey Ryabinin's flush cleanups and some
from me. They reduce the number of flush calls and remove some bogus
ones where we don't even have a worker running anymore.

I wanted to send these patches now, because my vhost threading patches
have conflicts and are now built over them, and they seem like nice
cleanups in general.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
