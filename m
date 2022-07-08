Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CB8C43334
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 03:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FB64612EE;
	Fri,  8 Jul 2022 03:05:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FB64612EE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2021-07-09 header.b=XWxl2bY8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=THUrgMnu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vk4x9FKxUYOt; Fri,  8 Jul 2022 03:05:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A75A461303;
	Fri,  8 Jul 2022 03:05:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A75A461303
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5717C007F;
	Fri,  8 Jul 2022 03:05:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFBD2C0033
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA7C142463
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA7C142463
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2021-07-09 header.b=XWxl2bY8; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=THUrgMnu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q3rJqAaLOHex
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A658342456
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A658342456
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:36 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2681oxM3026377;
 Fri, 8 Jul 2022 03:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=p9QrmQLEytd2pVC5YkOE1q1rTMdwQhSdTSyTCetNu9U=;
 b=XWxl2bY8zfO6rGVJzLJu5C4pwPL+afdkVEj9WZHugdaIyiAE8CU7DS6m5gr0ddMStXFb
 1dOEQ0q4YgsZxvJDysISrGd5AXKWtsUR7CkWaUhOk5o1kyPI7q+OEBlgq16d80oa9so7
 fVt6Bq0T3G5BsEyycJ9gCajqfNonyjjPsEOOPeGqwSE3e+Nja6iRc2J7+35PPF9Px59T
 ilFFCNBXrsl/nWK0uB2op9la8FwM1RaKrO21EYF5yB0zs9qgEzEILdRuyQCtUgndlI2f
 +qQEd1458Gbfqdb0WoFAFPrzyMvpYnJzGTkJ2Hyfzhe32rHBV+e6lcs2KSIxIPpP7xN5 Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubypv9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Jul 2022 03:05:35 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 26831Kkp032205; Fri, 8 Jul 2022 03:05:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3h4ud6cc45-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Jul 2022 03:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLqpRjcuuQ8Ax2sAAxp4kbOrJznrzI+PPIJvqlKkjK26eVnL+ke4yYOa2XfVaDvPfmeOOgUf/0FkAQ2SD6D4ATIUdpjiUDmCDnGaIrkfgXEZmJcAo7kTGxfKeCslYLE9EqlZkVs1ZCyakPbbj+aPIulwuNAzMrXfzmYa5/Y6a35+ahoY5GSDuXqne2jAHClvqQdlizT6cZsc+dQJtosLqYJWoekd+crv9kiaNTW4XToqml7OB8awaRgW+1EJ6qbwJ+V68QbXzKns30iz/+L6AJULHMuhLNr3qaPdKL6P+ylfWajK0MkAn654GqmztqumQGTld9iFDLKsmpVYwZMSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9QrmQLEytd2pVC5YkOE1q1rTMdwQhSdTSyTCetNu9U=;
 b=BjowxXtPGxzl7bMQCnH0Zh5WvQCsnqsLg+2r77bj2Fqrf+BnxYYbtbXTCWPaUnebQqCkwz6gas6E802G60rpi9d2CnvkaHkHbeaeFeFNcouE6NIuebPVzupEQmN4sXNrb+IEE0EQc/R/ehK9sfaOMJe60HxqXd3xKj0iPJjR0u2TqCIlTUqeTMJlmoBe0VaM+BuOUl6GkkG0LN9duYxoJpUeAevRoXKAh2RNa2eeC77CavT+iyjMGWeLtCogAgrFGTJBYlD9y6nAEpSZ7T/8880vHfXXv+Iswq3UUI36NJ7C2OEKszw+YoRcPKqMjsvvFQI+30vTmTBdCw/ZLdMQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9QrmQLEytd2pVC5YkOE1q1rTMdwQhSdTSyTCetNu9U=;
 b=THUrgMnuYspXTdPoj9G24b7Z4B3Kl4k4bAOGyL2Vk6FjJoysARtI2qAOi4jNh4bKiv7GflWKA96ANZ+oWI6z3wwKTrlH8HwmON3eLHwNkoUsyj+3wyqY+r9bVM1Acp16N4sECWoHyFPoASkydp73gGe0Fu28qU20LQzLysK+mlM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SA2PR10MB4731.namprd10.prod.outlook.com (2603:10b6:806:11e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Fri, 8 Jul 2022 03:05:33 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 03:05:33 +0000
From: Mike Christie <michael.christie@oracle.com>
To: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com
Subject: [PATCH 1/2] vhost-scsi: Fix max number of virtqueues
Date: Thu,  7 Jul 2022 22:05:24 -0500
Message-Id: <20220708030525.5065-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708030525.5065-1-michael.christie@oracle.com>
References: <20220708030525.5065-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:5:134::33) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd7b6778-746c-4773-39d9-08da608eb929
X-MS-TrafficTypeDiagnostic: SA2PR10MB4731:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6NWM3p6G8VUHa8U6QGnOBUDv4w7nK5MlNF14lyeKUyXEGAbbvGCnSs0DN4cH6zvCI8JSc8+zp6WDAaLZy7jsdL03jvWLwxSFnoEjSKltFro2Uf08yYcmu5YL3vGbhYNGqxxj8VgCZWEstdAy1p0s0AhRHsjXqmxEFN4t9idsnVwdzoMFYFFQ7pfqCtS1x5l4Ov1zXZ1DSK0bhH2Lg7+Ap8HInEpwsumpWD72iw/yBL/njlm94wBuBGoEI37luwZ0G+FhiFXOHvch/GDD2jQi5RXSGmdC0NzS8MFdmz1L6NB4KCLWW/NbGWsNpWRvScWnmRa9LqKr5rnhvBSnvJIVLZ4fZFy5Q37QOFg5ozCMCVFjgjCJ+R/lppZjI/8kh0BWqfDokAAicFnbztQrWxi6DuOGekz8qKo9SOIArdUWuysrbG4Ui2qX8CrNqweimRYt52/5akKAkNzgcLS19xIBEJokunZ2uKgGhmh+fIcrTs+1UL8rr7BLyI2nMqWRODWN6XJi/ItTp0WVpUkhdpF/cFHY6LHC8HGfJI+rxzerDed/ekrWzHC8kv6o3a4qbn16r465S9Id60S0+bXE4yiaZ8lY2Gg5RnHAH3+Q5lkwZSrwTDniGVy63RKkY/vDeFWHPsY0Jq8oNAi1G73mvZLaMgtodT9pXD0PW/OqJ830ZhCkQurG7UZvBw6m9lRxz5//+nXzaLZihaVbObiOxpd9DVD1uKmpTcB6RFrm3ZM7Leb9ROEP8cmUTTPOvrubV4+wphCygjAkkiyb6K63FZzyKOx1q7rMNpf5+7BZwHAm3c3veOX61RMqZLRJpcG16Nq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(346002)(136003)(396003)(366004)(376002)(38350700002)(2616005)(38100700002)(83380400001)(186003)(107886003)(1076003)(8936002)(5660300002)(66476007)(4326008)(8676002)(66556008)(41300700001)(478600001)(6666004)(2906002)(26005)(6512007)(6506007)(52116002)(6486002)(36756003)(316002)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kkyRjppnZLXTPFNYqtCkZ9J0/rG0bCI77BhAt/0gaTXHWpbxTzrHDJBzT+Y1?=
 =?us-ascii?Q?psFFR2nh8et+X4BoWXJhSUcOYQofZu44X5/oJX/w+QyR6YYKKDMfklOEPID7?=
 =?us-ascii?Q?4LxdUKLRrgZlfacrSuC61lgGlvWnxzaY2TN+q6bFtoP0dmPFKMiRTBRfNsH0?=
 =?us-ascii?Q?Ohddwany3E9aabWG+/SmS6NK/vdaoMoTWUsgYinRyhG8nsthCt7t23pGG2jd?=
 =?us-ascii?Q?5ljutQWTPrS6rrcOwFBjPcX8XjFYbSQimrwftp3Oy7sVqxY4X9vcgFDenvWH?=
 =?us-ascii?Q?5pliemgBSO64ijozCuXtKz7mB7qriPVYYPz5FLcILujdK1HcS2oNdR9TvWQj?=
 =?us-ascii?Q?YfTjalva0u9zycTnMRCL9qS5CWiER3pMMdxIK2dEicyUShZTkHbxYeyaGAjq?=
 =?us-ascii?Q?3EBEW0YIqYcv9KI3pUh8lgaUHEoUejkjOw/5CIL26kMeF4WPmHtUau+CMRKN?=
 =?us-ascii?Q?zyYRUD4RRDIDfL3ZxyO3z8vFVA2YTg0zIzCKBOCqN5C/UIJ+K/rjBjFmXc2j?=
 =?us-ascii?Q?bybNdS4GRQSMuREAsgrmfoCEDPpl3fkVcWIcOaDH3nUozvC3NnR1Ae880nSZ?=
 =?us-ascii?Q?Dl7k12RLJVl2XtZcN/jeU2rFMsPHAYgptaOf6unNcVF4DOETS6XNtag3RX4w?=
 =?us-ascii?Q?wtvJlGmvrPHlpTgsfhXay+ih/5tY3GlJtXAlJsr30GwwcCXmdWKLp/HD7cFy?=
 =?us-ascii?Q?nq9j+ClEZPQJXIfOjfWi8G4Udu5qb3MHaXw8iM2q0R3+Y3f0Gh4G//BejyU7?=
 =?us-ascii?Q?yfve2Sv1/EKjOZtOiEcfIjwFp82xA1IUsCQFWsP0+9MiyqG/h1uaWpeiWTmw?=
 =?us-ascii?Q?/4QTdUXWixDrvICUE0oUcwk8kLfTWXpI5cvYaJL4ngw3bBPjetm5l/SUvPDJ?=
 =?us-ascii?Q?VjEc4e4lsH4deqi6HASC/62EKO1T58ztLJUWKPRMe9CD/T7WFEuSO8swckNU?=
 =?us-ascii?Q?51SUPQJD+sZeOlSjVnymXSqaMR6EgNgNXdkwQjwPF2UVufBep/EA6gm44288?=
 =?us-ascii?Q?okVxekjbwuop1yAaZMEaEc9NRJJ6V9F1uDK0tiwIhmmjLqynlZY26Qd7TXon?=
 =?us-ascii?Q?KcZSIpRflNVsDvQ75/mdfZWkM/CqawmA3kQ8zSFGLZ6I/tPUoety9iZF2It6?=
 =?us-ascii?Q?96dmB8PzVWcD9APwlf6/zpHA7HRwrly576vc2uqYKK2iMma4+miJ/ltUXzbG?=
 =?us-ascii?Q?lkrpdwcjkYN2ZFWFmHzcFSvjKyoGTUws2wHh7Z4KfpDXmwbFH9SFBTzMfVxt?=
 =?us-ascii?Q?k2L0BdiXfM8SKFxOP+YMd5IAaUUSOV3Zaogu4RoGULB8Q2dMYDUdjIpzE0OK?=
 =?us-ascii?Q?7nmKG19aULsRI88NTUvs79+u2u/NJbOIQc4GfQfiQq8g5+BXwUAX8FCGG0Iv?=
 =?us-ascii?Q?pN0hsMBxsVGQ4mXX02SI+ooASvJ8MELSMjr5EOD6BmzcjpjRwLAGs8cRvBzQ?=
 =?us-ascii?Q?chizFvl6oA+5rVR3fffXDJ8WamO40PQQk3aHLqgpfAhlH6gbnxvGQ0ZGlQTr?=
 =?us-ascii?Q?QSVshFut5fb4V6Hk0zVWWKUujb/H8PBX6m26sTOePn7Zjq9kKyxfB+2BUZ/6?=
 =?us-ascii?Q?rH5yPmIsOkPIMgCLViGV3iz8YYn4i2LC1iQoYBBeZyVZ7/djyF2Xlv3VTmSu?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7b6778-746c-4773-39d9-08da608eb929
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 03:05:33.6018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjIXpoaE9jG+XPReSRb9pd/+17iCFM6NhXLmHYwcvbmwp2nve2UCPS3KVyj2FI++fJCM/1uRJInIBmVmXVEs1Gm4aNOFc4pyYUAXCSdHFAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4731
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-07-08_02:2022-06-28,
 2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080010
X-Proofpoint-GUID: ofIv4MBOw8hurVxPJsbk3YkRtnY9ysk6
X-Proofpoint-ORIG-GUID: ofIv4MBOw8hurVxPJsbk3YkRtnY9ysk6
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

Qemu takes it's num_queues limit then adds the fixed queues (control and
event) to the total it will request from the kernel. So when a user
requests 128 (or qemu does it's num_queues calculation based on vCPUS
and other system limits), we hit errors due to userspace trying to setup
130 queues when vhost-scsi has a hard coded limit of 128.

This has vhost-scsi adjust it's max so we can do a total of 130 virtqueues
(128 IO and 2 fixed). For the case where the user has 128 vCPUs the guest
OS can then nicely map each IO virtqueue to a vCPU and not have the odd case
where 2 vCPUs share a virtqueue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index ffd9e6c2ffc1..8d6b4eef554d 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -159,7 +159,7 @@ enum {
 };
 
 #define VHOST_SCSI_MAX_TARGET	256
-#define VHOST_SCSI_MAX_VQ	128
+#define VHOST_SCSI_MAX_VQ	128 + VHOST_SCSI_VQ_IO
 #define VHOST_SCSI_MAX_EVENT	128
 
 struct vhost_scsi_virtqueue {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
