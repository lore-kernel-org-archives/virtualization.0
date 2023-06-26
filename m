Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3683EB64D9
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35056408DA;
	Mon, 26 Jun 2023 23:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35056408DA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=p2d6Fy8B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=BBBOhehg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpeaWCdz1b7H; Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 632BD40143;
	Mon, 26 Jun 2023 23:23:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 632BD40143
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35B80C0037;
	Mon, 26 Jun 2023 23:23:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 937A5C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B5264056B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B5264056B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KQ-2i7gBWuCJ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 237D140143
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 237D140143
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:23 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QN4lRw018442; Mon, 26 Jun 2023 23:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=HiQNkfjDSVAtkdYuWWQJJgpO/PyBKa777Bxrn5zNmx0=;
 b=p2d6Fy8BaKq9qlHRhkJR8YuQumswLxdzoex9g0Qa9luwKF6ypj9sywJb3Ia2m6UEn43R
 Yez99QQFxMIMc5hw0OIBGhqM0WbyGqkpkdqH8fM/vBtZ3jkGkyvsAR+RS2LWwDGn2XnE
 /SMq0SFJIdNAYVWDPiK/MZC6AIvzf/h+FN5nDw6tSxVLkojkXAkHvJf1jcfzQK67dYqS
 1fb7EXpjYO00Mm4tmiycngVHRQzmOr8k+AkJYGbYvgyVnTijWCxc/Oiwx369M1tR8HJv
 6DmTah7DVD49SEKyh69zNxf0QUT9P34AoajUbSVJ7dr5NZ74gd/SOessnp2W4UF7qP2Y +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhckvte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:22 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMJNkX028275; Mon, 26 Jun 2023 23:23:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3rgcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k//PTxd2jCJXTValwKfYy2i5GgXOB42SanD18N4tPW6Bhmv8Nve+PWgSfwAtqsqXSLgjQMpPxAoWuwq2KX1WECJ2Alkt0IRxKkK0lbz6tCF37ivV8aG4v+JsUv9sohXo1a9J//0VRk0bW4pm+u2CHSl3Tcuakuusbk3cCCrVnilkQTZR8udizh5GheGxQ8n2SWCRTZIvJwYQiUHKIa/k4+XYFFkciSZYEivhIJBAB3muZ1r3tTnpSc7bp0U58sG4UmXYIROpLf6P+uyj9bgLyvVnX9MH9wYO3eodiQwXhxMq7n6i0xtd/wwHKS5sxeHD7/p9cFD2YypmU4n11yDBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiQNkfjDSVAtkdYuWWQJJgpO/PyBKa777Bxrn5zNmx0=;
 b=FRanN687pa7Tih5JSYfSSzgUV6TDq1iDTZ+nQSOeVni7MV+gAePHNIybJKd2ulAfUsuJzmDPBmkKku8FhTB63NF+ZDydTOsQx67PRd04gMl/O6HI+eYnVuQeh7CT29MykgdYI+7FSEGjUp/558iv6AUTAB3irOXdjqGUWlBGuj+nfgDe0RMKqabKQovpryENTutBqfwV+NR6XCCkeDS/meB3XY266Qq42rcrqPRpRV0lWo1OJoPeruW6Ez2nH58/2S9YFDzbCJ/LFZhDiJCgf/wPabsXDXOXaVW7CAGC/wed7eXoqoqd4hU6NoOVD4a/4Iz5KpDrqZzO5snWz+KbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiQNkfjDSVAtkdYuWWQJJgpO/PyBKa777Bxrn5zNmx0=;
 b=BBBOhehgPdV7BS1tdcZhIQuQ6r7pI2fYa3oIRnue1LGqRdXPA+n64uddFlJ6Sr7BM7ZBWIBi4LRRwq6B3jgR+B3O4H2jmad7xf4xoKqgjrTHW6AYtaaAhBKHrIcZD17LGJAuJR0S777utofbyXmK0Yd1wJvKSqy6G4/RdQlQgws=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:11 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:11 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 01/17] vhost: create worker at end of vhost_dev_set_owner
Date: Mon, 26 Jun 2023 18:22:51 -0500
Message-Id: <20230626232307.97930-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::23) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: b47474df-ed2a-4cac-8067-08db769c4f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/8KkZ0q4OFLKLdLVeE9eOuuUFzZC/Jj16DOPksOWzcLd1VIDqQDKoRYFFw1SDxAohHc5o7BxKXQSjzr/hX85InW6Fr02jFg8FU5OT8gCHPwOh9YPvG2MHIT16Cx8MnkmxhmVw5FOCmK7JOSR18/kcnXEfKz9zOTdh2I4zC3LY+AEX+W/0pScRF5Vc+zbqGpzqyooji5jATmMby86rt9+kerTuYhqi7CTZgYaiAiX2y+ov7Ev5i6F64+MDxXwSZufurZSvRloIK+5BahZ4ObAP876GRljLjrgQ2zM5eRkU5+hykhwy2mi0c2tMugvYAA2D0nWcnN+H3KPvZns1viq6rS71kmvmrx4fJgdplMzVSFHQbiFnoN5UI3D55c+1LIvW/n8w2g7C/JozvOmoSYamnPxbwvDaexwj8Ki7UN4rhDgYfDIqM6BzOu01YS6/DrZ9U4wO/ZxK6LjZuhVvFQDbVhm5ED41S08hMrUyUuXsfJSgQNMuo+tc0EIXrXbjWzFGo/eIjfsfgXaF+cjC/kmMUYFdHUbz4u2oEmdL2ZnhoxYNyqyOleSECAgdcVEmHDsxJCuFiuDh85ALv+uMJSd8MXEzbFTd83Jk8ollg6VKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVbG69d2nT3flVzsBvtPWkV9eW8ZJCqEvWKjQV85TIJQ6TnaGwHwpW+9YHXV?=
 =?us-ascii?Q?z8z6mbSU4d7N567XHSHOHEKZT7EIVDTVapsOTaOCmmnIDECafoXhYQH7X/FF?=
 =?us-ascii?Q?UrPFowu7h8P8nqtWvAb5qGvg9elYvqgL8Ztiuo5TlDYkTlaNrm5w5Plb2Yia?=
 =?us-ascii?Q?d7lH58ZD0HGwm+BtNZuxGoiYt7BdvJRE7b7yafHR6qqxtPJ5jV6PFt4V23SP?=
 =?us-ascii?Q?TsGcPc6VaPhxt19EKvkZvg5V9HFqVRNlw4NyRlfqboRMW3ERUI/p4zhJPigm?=
 =?us-ascii?Q?q7yYnsJmbdcStZNeuUdEsFpEYYLLlWS8R6WgzDsxtM+SF0b0BZ+M53mXkISP?=
 =?us-ascii?Q?UrP6TMOa6qlazvXeWgED7m2e85AyrrkTXoz0Xvv2A71yyO0Ohb2rJt14PoJs?=
 =?us-ascii?Q?NY6ir4kiE6vHNydBCSq3/Q7ZXY8dV8RLB/fc1/w8v7QwZ/SxCZ6AtE+egXie?=
 =?us-ascii?Q?jj+Awl/SfAMd76KfK47w8nPGcjlpTCw+laeQ0wEEQtYzPYw/fr0Nulmhc7m2?=
 =?us-ascii?Q?TCKy65O48a5o6weMNEe6STf3HQpRV5l5DURkp33p1ilY9aYUgvISol7MHgB0?=
 =?us-ascii?Q?yhSsFApwkrxht/PH5UQ4GSWW5LKTs+f8bTMokNWN1CggS5LBa0Z9bBjv+DJd?=
 =?us-ascii?Q?FRgb/dKLIpIiKm5ySh1P9HGOeRuY8mCxbIendakwAptNtYq0hUgANbx4MmsK?=
 =?us-ascii?Q?yOZpwQgrKPGr/AG6bGEdaxNafCS1MS5THqnA0C5yEQAstJvmJ7adbRbS7eru?=
 =?us-ascii?Q?BYAnVJ3l99xKSrAicF7/+t8TODrv1xtg/+6Bc/ZIAyygPHMa4petaJW8St3l?=
 =?us-ascii?Q?xfmOtB1NKAjFmfr/GnF4MQL+fNNpqTKUib4nby4DXDBcJLHRtreBu9l0P3k6?=
 =?us-ascii?Q?WQ+l98issMqH0ix5brCzi6sbXDjehLF9rSjbHhEPErRi4KxOR8EIUXvaAz/H?=
 =?us-ascii?Q?Z4n98/1pvLRn2yNkPxvmC77MI65BFPXh/Oh+DkujuLLSKZp1kEltPSEBbHaU?=
 =?us-ascii?Q?Yv0iSe3THj+pd1miweJOAA+b0XdSkyc0Y/DaBifYzWW52sks8pFsk9Z0zg9m?=
 =?us-ascii?Q?KTV+Zt2QxRgXJsbeh+a+TtbWCIyQHP49bDDI4HskmJ7D9KikW5GcfJ6k2TAr?=
 =?us-ascii?Q?CtW0eyT8aD9utpWGXGmrkKFo1kjZaTZZnmSDcTvJhLoUDfiPOCbU7xLOkYp8?=
 =?us-ascii?Q?YrZJDb5Nqx7GABRmZMwNZdjYlnG1R7dX7C5BfdwEVs+h5v/WTZFX7LGLBXr8?=
 =?us-ascii?Q?cdnw+qrWJy1QTGP4alT1HdX63Wgzj6dfd2CmnNv3+HU8TJ00G5WTxV+Z0Zy2?=
 =?us-ascii?Q?4j1H5eFhELRzN7Vi6GAaB2h+6DlXXTLGrVeYWZJXj7oleOzmtudd7fxI7W20?=
 =?us-ascii?Q?NDwyX40y0YfU6V1wWN3sVLILFGKc+HuCAgPhqyOAdu8KM4AxdpVhBpTzYxZd?=
 =?us-ascii?Q?5su5CCQcVH9M7pLaNwEEWhe7VxrqQkVy6XVGFt4HgFlMI0Cmbu5ALesU6Fi/?=
 =?us-ascii?Q?uAGGOoup9EgnSO8bNcManZFIfgIY5v+vyZ7PBRNuLHUtty4FmE0r3cTyCV9l?=
 =?us-ascii?Q?xoB6O3SwDNjR74FBjK3xHfWgtAHNV+qFBYbj7cVgpWIEbonWf0M68pA5sK+K?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9hlOaKcvJWMmSe+hHZHE+F1ZqtFOoTQ2eMhEm+hhBzyC0ESo7E+GjqaTSE3jdHMUb0CxK/dBroOSWdS5eRynX7p4oi91BelyyU/6I07W9iwFnLRwHrdBLZQd8csd2pnEpQ7Rrctw6tspbmtN3DBMgD1VIMEqDUjfwtOJmdeWvyJv5ZAgUU9iBOg6BsphiYCtnxBWfi++TpDR12nnjosc1JT+6EPCIY/NK9+05/nTspaI08HNdH8QDk/oInwlT1KHtojLwt0kIrmvfM0yc0uJ7RzKjIldQWeVTEzUi3cyA6hi3HU0eCF0whJBxCI0usia1r7/fFvg32OUWtaDEIoHOB/piGsNfLxYJw3k9NJ725M5v12CVKXD/R+dKZSouoYu+cRp9a1WbvUq+mG1WTeig/1mu6iclxMCBXYLNuLA6flASPRH+6bbMi+XklHn4vXdy7dl0zdmLnq4KsDBq/qJPAs3HTEMgkPYS0eItl+PhD8XpsnW+WjrAhLtzA6dnQpnd+XnEM1irQ898FvqPF5fXURffqXc7GVdP01XdLGluxYq7gGfWInvgvf1irXshMk1kg50b2+aW2Vv8Ufn64b6ogb2mrC5B5kDT5j7iTKf6cabNzOOsxqjkkZvdimIXhcO9p01MeGwQbWg4BBS0y/lyZvJVIIKgKebcN8TNfT1fwsgo8P+gsAyUj3Q82tkKs2gSNe/40V5IRxmDItyYkY3mo9wqRQ+OMm6KA5PWmlcVL+9dEh4qhYpBMEvCMH46d6JQ/bUzHuwj9CAnDnfntMeQzUH0eRPHNbaQ3WvUbloH0AEPxGqRmZPB6QViGx6DP+v
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47474df-ed2a-4cac-8067-08db769c4f11
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:11.7350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPKe4FhViHtolZ/QY5OLpKciuvVo4iRUaNRS5JPInNsmj5o4/omLSOZunHkFKnPdra13tXWsfGWVihoa0WPiFs8qh6X51FbFxyy2Hl1EMp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-GUID: 350QbI9HcOH8bKW_j1KeekQHSGZ0WkMS
X-Proofpoint-ORIG-GUID: 350QbI9HcOH8bKW_j1KeekQHSGZ0WkMS
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

vsock can start queueing work after VHOST_VSOCK_SET_GUEST_CID, so
after we have called vhost_worker_create it can be calling
vhost_work_queue and trying to access the vhost worker/task. If
vhost_dev_alloc_iovecs fails, then vhost_worker_free could free
the worker/task from under vsock.

This moves vhost_worker_create to the end of vhost_dev_set_owner
where we know we can no longer fail in that path. If it fails
after the VHOST_SET_OWNER and userspace closes the device, then
the normal vsock release handling will do the right thing.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 60c9ebd629dd..82966ffb4a5c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -572,20 +572,27 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
+	err = vhost_dev_alloc_iovecs(dev);
+	if (err)
+		goto err_iovecs;
+
 	if (dev->use_worker) {
+		/*
+		 * This should be done last, because vsock can queue work
+		 * before VHOST_SET_OWNER so it simplifies the failure path
+		 * below since we don't have to worry about vsock queueing
+		 * while we free the worker.
+		 */
 		err = vhost_worker_create(dev);
 		if (err)
 			goto err_worker;
 	}
 
-	err = vhost_dev_alloc_iovecs(dev);
-	if (err)
-		goto err_iovecs;
-
 	return 0;
-err_iovecs:
-	vhost_worker_free(dev);
+
 err_worker:
+	vhost_dev_free_iovecs(dev);
+err_iovecs:
 	vhost_detach_mm(dev);
 err_mm:
 	return err;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
