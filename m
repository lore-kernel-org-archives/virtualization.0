Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFD0C433EF
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 03:05:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36A1F84653;
	Fri,  8 Jul 2022 03:05:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36A1F84653
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2021-07-09 header.b=vcDwBvP3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yQpaLRPa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N2hZBVyMpr3m; Fri,  8 Jul 2022 03:05:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BEA828464B;
	Fri,  8 Jul 2022 03:05:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEA828464B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B5DBC0033;
	Fri,  8 Jul 2022 03:05:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2B8AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A786A8464C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A786A8464C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60dtX5cP1lrc
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1968D8464B
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1968D8464B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:05:36 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2681QoWu013683;
 Fri, 8 Jul 2022 03:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=z/twu8U1qQoME+La4nO7q8Dq2XS+jcgcDYcOn1V/dbg=;
 b=vcDwBvP37QbaMaqouOeM5P0Fl23m7BmnYN0iIny1vT5QUl7mDNFCm3eFKzal+G98cbIT
 jbCGZVbw4z6tcWzdMUX8r27M99LwHW+0GC/57M47NE3y160sklveTnhRFH5g9PLcz23g
 /A8po6z7Rf4ExbETiz0ltrlSo4ob6u4++NNnDb3EedCBlPzz9ukCAVVM1Ti6YAzfZJ0W
 6v7YDmwL6HdiQje6v1tjSGvrGPD4YaEjh9txwvGOlglfIwbI8L+aVq7MQI74IaFdj7v9
 YiTsKDhrTDgZxol1hh3PvY96fZSFn7uNEF4YDlHxrmO5siHX2N0ie9h5wwV5jR9yONAE 1g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyex6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Jul 2022 03:05:35 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 26831Kko032205; Fri, 8 Jul 2022 03:05:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3h4ud6cc45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Jul 2022 03:05:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APi4YN1ynJacXFgcR9zSPiFYbICp2PcN4munUgRcbGdFOkpuL0SP77MouaEv5qB+8/JweMNhYz2IHkUblMb4ibXR00uIq3y5ViVzsejrMjohkC2bwkcg+FOYS5F4Pu+Az8VjazYdulIo1gVjTT+GPvsm11eEsBSC4+h5vGKXugiiKMQ/E/7Yad/s0YAq2bOxdWZJmnWKOsW0RHdFlfjRIZLMjeQSPaKKOe/kRnTYCsFTlZI0K/JxXU0chcPjEVlz08aUkyqNBvCxL1rNCI23gBqbCkEcoQxs9SS5scA/9veyWMxVXB7G4Xb8r6//brYcNUW6PQ2eRSUEwuzy5C2UKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/twu8U1qQoME+La4nO7q8Dq2XS+jcgcDYcOn1V/dbg=;
 b=Ak4zL9Mwx2BBDGjN4J6CQaTXvIOG6hhqUnUG38sEDYIIrjdBl5QWavNvmqX2FOm3UhHxOdeNvnfGI6BdSFZ2bQEvhfK+xP/mj1TGyBXSGy6ZYAdfT7YC0ktuHScWDgSAL3/k+uSIE4kt2WuJm38TlkGL7uWm6YNb0hHrIRQpttQLMAeSJD0lfsevJE4qGBOtVjeSLANOuphcfUMHALT+6VQNjLVH4xIOVKKZdSE4MY8DbmAYt1e4jU5BxREaglDDiISxg0kLdeN6kerEuoBQLZRKFW5Ubmxh771XuwOvbVNE/cTHd6nTNXrW0p1sj4mkalLO51T3FoWPxvapoqtCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/twu8U1qQoME+La4nO7q8Dq2XS+jcgcDYcOn1V/dbg=;
 b=yQpaLRPaKRW2F5KF8QlfXsRuM+mVVWebR0qRc/gqL9cXTHTq2uTZMQ8iJKV6ZnSDecaxvEBMNcCfq2KJV53PMHY3c3KTO47ewn+oqugHts4zgbHh87ZEbnC+yhFSu1Iem43VeW3xwWhTnX/DOTUmEf9IGbVKrlCzunBB7GfU4kc=
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
Subject: [PATCH 0/2] vhost-scsi: IO virtqueue creation fixes/features
Date: Thu,  7 Jul 2022 22:05:23 -0500
Message-Id: <20220708030525.5065-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM6PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:5:134::33) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aebc2c4-6e8b-40e0-8fef-08da608eb8bb
X-MS-TrafficTypeDiagnostic: SA2PR10MB4731:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ribauPDYviOYI589w0IK5iBfkrMicJjQBwWWvrqIXCnlwcGwoNRcLi4gmdYjSu7UOYtLuZLSpXhOkwPbr9wJCyEpNHRLlHHYpWfqgtKBK6ugiDjkvfxf0Ke5NcVUKPYJGKfuCeWvWA9deYttgAXhqWDFbNakQ5rvtXV1oPWq1X6IYDCEK+fTrcQIVp6LgQmTljHGRQFe9T2IBZM816GVhQ0w79vzIkWe7NT310Kw10aC5AN4yw23LsBU3g6oYya++ANjS8IB/OChTPv81cQM9Dj4ZI3NWWH8KCJy8Ia1/JQGxn0aFQrsJ3U1Tk2Q/wGkcAty1rwEs8CAgIERbhiCDz3e/AfjzSpjbT17OCYABBZfHchId1biHqAcYybWt3eK1OLUQeQCNfyewolAARlvQ5N7jgMJPm+TPTWxnrAvuqzAiuOBeBZnC8JmIhBXfenC7Zc/8iOhyuzbOjXLuLM9R+L02FP8L0u/XYTWwDeNtRIfPxa1pq/h8Bb5FGzIhmmF+5OSiBo70S2wVLWoB9A98H4IxcdTxydZaSCZTSMnXFIdU1CIjLBP03NdBZRSfWUTMxdEXWZwP2oWZLeYMs0FYdh456FRZPmrHDO0RwHXlIwOYIMrbGPz5MxZcOfh3WUPG/xfE7m8zagsSiasEnQbyDlzbUBavIpSf3jgMl+asn7ehFxKz+YZoAMoBsFTtEo+uoP55ff6SHyY6VdFqOLH7YKCp6Bn/U6dTpFMFbfmpOOVRSnQpSTlX455FOZpOeBzRmuncKS43A6CG6zH/QSmKmTne13n8WNC+G1aj1i52vZtycPzgBAaocQ0kAdh3FA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(346002)(136003)(396003)(366004)(376002)(38350700002)(2616005)(38100700002)(186003)(1076003)(8936002)(5660300002)(66476007)(8676002)(66556008)(41300700001)(478600001)(6666004)(2906002)(26005)(6512007)(6506007)(52116002)(558084003)(6486002)(36756003)(316002)(86362001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5h4wjFKjgALzGcTctchu4SEVl8XlXiZo82Gzalc/AQiMthAR+Zuc623dyyaf?=
 =?us-ascii?Q?p+qgn61t00Zo0mGn9Ltu2G8Rc26njhb91JwTdyREzAZUhjFWFHfA5l9XUbAr?=
 =?us-ascii?Q?2lqI8boSmEMVXn9sMTXjpm7a7GstKoFGsTkcfR6UUZFjPUkt+Jp+EqBHP2AA?=
 =?us-ascii?Q?YCd+b/qhYX2mJPXWI/0S5lh8Ltl1e0gFw6kDQX5vTOnAP/BeWlOZ6rLl6AOn?=
 =?us-ascii?Q?/sy/Y8apcWgC9bEeQ+9o2h8dYFJQV6F9T0Vep4H0leQWRdbhWMn6MKSZQFwm?=
 =?us-ascii?Q?vcTGsUnz7lQf5dFAHODzL7sV1yIOZuJHjFPD2JogvOzZfFcyGHR5hlR3Bbo4?=
 =?us-ascii?Q?8E+DuuzVEuu0SFyxAXNJtFyxumbBfeHLWatQKcrZ5wVruFO2CV7NKBuLNHpq?=
 =?us-ascii?Q?Pm+vc0wW9UBS43nK5vDwzQ1WlcSiPixHKKD+MpWfxWZD2fPm6pL0+sPJra46?=
 =?us-ascii?Q?pKZG5qf8d3nLqg60sRIifUWc5+7OibuZEgOJFNwjzrNWdzkA7bt4IL2kT+XK?=
 =?us-ascii?Q?8ryqXVAC1/vdA12WbYa6/Ya2pjnOMjJbV3IBvSfqi3Etp1mgX8FC8PG/Ptn0?=
 =?us-ascii?Q?Ck67a3c7WOZJ9MYFORt4JUAtA2x0NAbRMX7o8yJuRbORVYxjMQVJ485eSAFU?=
 =?us-ascii?Q?gbLYh9+7VhAyRpTrommS6Gda09DqEhzmTlNFgsfGCp0tHUul8WffA2l4SP1F?=
 =?us-ascii?Q?nox5dn1JfoSiQWwmt4+3RHvDLglIhWULRM56Kfy/b+C8pkTJ66FTukRx1D9P?=
 =?us-ascii?Q?fj5FOCrWK5/U3YrSnIoG/yeuogNYixduJWl+/POKpHinaLtmgObFYBz1puTB?=
 =?us-ascii?Q?hjRJ15Sn1WeOjAGWz2A8igtD+lXag791JxHdjYPvt1jkZafJMngjXg8fB0ZU?=
 =?us-ascii?Q?P0QcBcD2LKnoYPXMskAu7uWp00UFWgZXAxsM7w8zeyGRPGf1O9vVcqoYEE4n?=
 =?us-ascii?Q?12DzYpgl6KwJgfHGhGTzEtvTAlMkElEfTfm8R2s9mYvhgh8DDVHa035y4FWB?=
 =?us-ascii?Q?Xt3t/3ronBbBfgDuiYT3rEmYfwFmwzHKTZHdkSajtgdE7gJWQbcU1eQp8N09?=
 =?us-ascii?Q?HtmuPGBkppPmJVo0e3NYOrqvRfoMrlkezEOXZk5OADCMaHJ2zymWDuutITpf?=
 =?us-ascii?Q?BcYZMl0AtdJpa0/zpDkiOUmKg9lcTnCEBxoZYMkuoOsvdLw+9nX11GRcO7mi?=
 =?us-ascii?Q?aM40FXbi9Nqb/8o0+l8a5kXrQUcDRZy0qNQmeyijRb5btQJPjfT3Vb+JEWaH?=
 =?us-ascii?Q?XbbxqW1AkMqoFtqp89KPDEwbE716+qLWOjlVoJcRdeSS4rO2Uy1AC+UHHPXE?=
 =?us-ascii?Q?YVnKug64h+gxF4sEPE62aPjkd+sHxjgrAFpdkv4w3uMcnGaqh9jU94TnYerM?=
 =?us-ascii?Q?Rp8nqgc/vH/H1mMmIuD7D+BKSBnKdjElQ+vN/KPP2I0Dwm/9KFEiwIKSpYIg?=
 =?us-ascii?Q?5dYboiMuaKwrdKlTWWFOEiJbbIJugWSEZoIct4JHrgjoGxFL6GOtDTWZP7hO?=
 =?us-ascii?Q?H7TjoAmGvQ8TozS+RrNFwArDWMVC7mT4P+zShxhy3LamTmTHTyWEO0rxHxV4?=
 =?us-ascii?Q?frwHuVcctpw0Ib41+q6PF2PVISaFikx8VSJzzCeK0yP7yrc0sqEFqvXRvsLt?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aebc2c4-6e8b-40e0-8fef-08da608eb8bb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 03:05:32.9456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmcaSHocjnh1MfnoTz98rEORzh+7Nsnnu9jxIyKcR15ald5zBBIcHkRmGGzXDFbU6HKLue7mC2FF2KypJZY3d9EqIR6Wq7k30w5BO4MFP/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4731
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-07-08_02:2022-06-28,
 2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=814 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080010
X-Proofpoint-ORIG-GUID: 3CVlgj4BVwzJmweFQaMNIhV1IQGXDKHZ
X-Proofpoint-GUID: 3CVlgj4BVwzJmweFQaMNIhV1IQGXDKHZ
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

The following patches were made over Linus's tree but apply over mst's
next/vhost branches. They fix an issue where userspace calculates the
number of virtqueues differently than the kernel and allows userspace
to control the max number of queues.
 


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
