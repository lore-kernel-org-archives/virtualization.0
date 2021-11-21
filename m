Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C64C433F5
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC46D607B9;
	Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e09ZRXaisjVt; Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 348C46062E;
	Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB8DC0033;
	Sun, 21 Nov 2021 17:49:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81A21C002E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61B7A40390
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="PIz8LGNh";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="BvQ/WVjp"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8mMmLlVn59nA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 939944036E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:54 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALF15n4016520; 
 Sun, 21 Nov 2021 17:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=HPXe72TRWC3n7L/ivyti9l3tXm+gKtIWIzSV+Y8Z6k8=;
 b=PIz8LGNhjEFntHPlW8+h6+pRykRiZ4aGYptzrkSO9pDe1wRXA20tk81a8zruYqOjmAle
 SQi17oKW31j9oKPJQnpsIpCB9YT+eZ91GrcekyihNqsL81ztFaUWuWQJ/0BwdFzYIhkq
 JphUOAbWEmOn9rvlPF3mXhx2/f/fQeN87+wuihswLwrMxN2N0r8WHaBy8dqojOuPQtKi
 kmgK5ciw+JMCU5HRe+qTf0lqnWfuvaIJaX8pXZ/Xy30O4D39XdCkAXGKsaMmWuDtuks9
 Qns5Vu3VKhIIzajbVQtQssRmqTV/J+jW6VNuI0HIToyA44kavDIIWs1aqgULkYZNFAqS rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ceqeccjnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkUXx015043;
 Sun, 21 Nov 2021 17:49:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3030.oracle.com with ESMTP id 3cep4vp60k-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAnYPFG853rFwDcPGsB6cykeD2HdBrZbifRufO20W975+AXPq+gfyeuzsxnSHW9rtr3bZcjO61an3pFwIXVfIwWRrNx3HCwrMVsP0X9ACLUWXQ/vYVGkDYiTL/Xy+ysh7EJrdk2K9FkDScCR/CzM+xM69XGy5AnRr54LM/sewlJXKDYLfV3v3xuJFbPRokAuWaYJHV6jFa07ccDslNqnrYWjQXqMMid6AIUDouhE7QPH34U5n4TAD7KkB/ot+VyABMdQndZ8ZOYnaQz5nqUqc4GEXqpJHSzIzAVSfNSv1aNOWGGFWbHEeVknfUFpb9zchW/QXvr+MaxnLGKlK0Y3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPXe72TRWC3n7L/ivyti9l3tXm+gKtIWIzSV+Y8Z6k8=;
 b=Z4H8JSm04Uv5aak0HGjlySlX/c7Kq+B3UDfASddsZSoc9xaZYyVCEW1F8ctO92JVVmqpbkSB2ncF9l3Aumo8BZ5L/D/m6VZ6e/T44NhbHhTUkIRiSSnBfvC/fm+5CIjLy8Fhsn2SAkqZUAEoxaBsGyD4x8jg62EgUWwmdkJr1zErfBG0Zr6XpYs01tJEDIsfy/NTpiXZ5mzrcEYjXsunVERKCe11LXCnCohWR+2O1p7OTTxX5bXgV1rPRHaXKELIh5I3rYBcTcRhM7purt+J+KXPQiNnjUPfIUp6vOArN9ioRA5cah8d6zdOq1f6xm7lx9Z4K/WIrybpaGYBSW8BkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPXe72TRWC3n7L/ivyti9l3tXm+gKtIWIzSV+Y8Z6k8=;
 b=BvQ/WVjp4R8RB774bVEX3B2eQOisgeF4Ys2dG1Lr6yFwWCRzku+3c/YcIL7NU2wFDJIlwB5qdfykAwlPJhFBon0jbn/AXM+4CIZ6RZmI2qjiHc4LT3xmJpYceehtYacHdHvqJ9kFftDRGzQvROXIAVxGnTN2IS9rQ+gNU9yEvc8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:46 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:46 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 03/10] fork: add KERNEL_WORKER flag to not dup/clone files
Date: Sun, 21 Nov 2021 11:49:23 -0600
Message-Id: <20211121174930.6690-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121174930.6690-1-michael.christie@oracle.com>
References: <20211121174930.6690-1-michael.christie@oracle.com>
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65d9ee8c-9477-4a23-d93a-08d9ad174e38
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB505582E0F41AD51F6A165F69F19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKRJeW2PYDO0NZrP4BTBkQwsoOC4rtaSK/XtxN/13s2uCM7hwGN525Ql+6MCxC0MCIL1K93XSDnY+DMj3ffJWfsOZSC2H8ipG1u1MT2uhuTrBrnzaSdy1K/GTDwElAaHeBVY4QM8k414ABzmCDpqe9ja9PEyfm6uaMz0ndQWFNul8IAZXqeE4kpSuEBie4vB/t9x548YvXAcZamW4rpMDdNZNeBNq7ouOYOwKoulDbzNwcgh6TV4RQEiTlkWr2OQ4Agk+ox0Knm6tvCZkQS6TGb8tX5MTpsq8TYv8hHC62D7AJeAtcZi9iE4tvn7dpER3FrW6Wzhkkl8jhlohTtXK8VGp0XDETRD1ij1Ub87SF+xvKBqy9L4R6Wd08j7YjD95dfFrLnJX4SLuKjLYGlyofwYBCfz7ZfwKvHWBnl13stdXle4W6am2TcMV2v2pqBhGiit7HRL/xgF/XJTMtZb+9SFAgJoqk1PihkWg3jYtOYp4hZ2rRdoQV0Ug418j5JODKKYgWawv1lqT0UA42fwCXyqd8EyYH2KMvJGjVb452gPbSh6xm2oLAtiMWQzruJ35xA0hrPNS/PPwmdTML5OJkLjuKgUTqF7c/5eqp5Kk5Ye9ppVDJkxHx+IjUulMI9hF2W/V2zpL0NlrnJS+oDVr2n74SS2MHvgHiG7mEqalAskNgynUEniwHfg/SlBJrFd40V82L+Sm9jcNm9mB3Za8iMjVObil9jB4AGZblHkX5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(921005)(54906003)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cPRREoqbJvA1ZIF2up92VfH2VUBlbrGod7DaOmrH+94VjWwJkZ2pInbnwYY1?=
 =?us-ascii?Q?45DeyoXEXjvU1oCgDvBG7dXJrh2v0wdugXX6D+7GfS/0/wtLJMYAVeSoFE7e?=
 =?us-ascii?Q?HR7mBad8dkW5muBIdIlRP8PngYBSehQ/738ONkd+sWNOyWJI8S5T9k2aOTBr?=
 =?us-ascii?Q?F+ljSI0SsxykrL9AFS+EyINq+A7i7VMK9NXZkH3AdEfbiCl0PmY1yqXUcstu?=
 =?us-ascii?Q?phGPFmALQOieEs+FB2eZt8NxYI0tU8wY5/i4ZYYHIF90k13p12ijL7cXFmR3?=
 =?us-ascii?Q?uEtTWJ49l/mRpypd7q2pOVKrpQYNK6DiMrxMvErGmCm/mfsO82KgRXxOczCw?=
 =?us-ascii?Q?cmyU5rLcixr/D42P+/aRWE5AoL5WfCTF2XG/V+C0AQ2/P+bUl6gREZgkmCIz?=
 =?us-ascii?Q?qBdsUI/PAbC3WFCeJLozi7nsekGP1joEiO5ebHABF4hLfThKW+1PSS0GYdvQ?=
 =?us-ascii?Q?WLv11R5vAThj7782+nlZeMvH90Dkrcu5kM+O9XikDuCGICtNTU5HwxuHaCxR?=
 =?us-ascii?Q?HjhMCpCzB6ZbGIBorcIIsfRZW6hn/QW233arWkpT+mGghgGVBT4di17zdspA?=
 =?us-ascii?Q?J845S1lqhw6LPtsk0CmnidVWwDQkYSpcVo2iGvvyhzLGbngn/iyXb/Pvq/L1?=
 =?us-ascii?Q?Ju4zdAcqYkMrfkynT8GuuW6ysb7eYIF1wL1BFqwZSAEkokanQqg15jJYVZw9?=
 =?us-ascii?Q?LIlYqe82aXL40G2iutdiXFgN7TKYLNdwUPhr0qsvUPb8OGUMv7ZOqhG3bSER?=
 =?us-ascii?Q?sMT2BuiXXKSbyjf5Qz8x7iA7RA8zI2FuCDBLegEoYtu3/ud/yZdWdaPFgAos?=
 =?us-ascii?Q?h0g62XyzSKCImifmGcaqMtoz3a4ZwPJSei5GgRltT0iOZ4u3fIXHA0DPaIRO?=
 =?us-ascii?Q?2H3MgdmvFYRNFXH0PH6ffLmRjzIMLvZNrzWM5t0HUl1RKFIgz2Y+y9TMlMb8?=
 =?us-ascii?Q?7MDcHT8tBph/n+FJNjvxRiOLJhWk0DyCrLhMFTfyXgnOednV8QWO1y0g+mIn?=
 =?us-ascii?Q?YYrpa60ElWq9A6+M4k7zYeXXM0JJfbtHnhpGaf+O34Ud+tJ+NzqAKrb8g0ID?=
 =?us-ascii?Q?Mi0iTL3227XzA9D/u39M48k0nqSwwigtQNb6nzogWzJA6rsf9C64B8dls+6G?=
 =?us-ascii?Q?1s8L1ZMX9SFlc6gzByNYGofvXgOGiVRaQy1Cfnf1t60Ht0Ui3LbZEyCaip93?=
 =?us-ascii?Q?y1tqw1XdPygXpVgBQIhn+TqWHXgbtTPOP1lbNZmQ/LfBVqjtEwcgA7LKLPBp?=
 =?us-ascii?Q?xcWGjpObph0Q1Y7IzByApMRgWyQ1xOnAq8QRHpg/N+yn7u4nvoD7T5CeGF0J?=
 =?us-ascii?Q?zkhhteodZYj+2jb2LRR0OtU2YZ5kKQ9y9/+cHtJgrsEfw6ci1HKZ3AfKqRiO?=
 =?us-ascii?Q?USlKj+Vyn7PpAYYluIOJG+oqo8dtCpg+Ki1Txv4jBlHXK/mIlJqPqQIXNVpa?=
 =?us-ascii?Q?DTcorWfa3x1E2E+5q8UuM6fegsaxj3PgWzpYaCyJs8SpXS2RcZOWiIEiGfuz?=
 =?us-ascii?Q?d3/FHt/f3IWDhVFFHDgjfQ7bmdncNdsD1EOrNYGlC70SA7PDPcZChGlYRvD7?=
 =?us-ascii?Q?geuozbJdebB5VfwIXIMLpghlfmJX1uA5CfaxH66C0H40uf6aDfm1+uSUMhqQ?=
 =?us-ascii?Q?i+Mxj9VZ5N48kWT1R4ia+jANrhPoGURuOCLtYOHzgk12Hr6vLo0qcYVTF/VM?=
 =?us-ascii?Q?uMCEFQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d9ee8c-9477-4a23-d93a-08d9ad174e38
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:45.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANGdRQUeZV9G0bE4C7h+wAKzAVD1+poQUaIGPiLKE3fY8bUckSOG7Zo4FSaiIqIfYb3i6GeLAdNQN6SdMMtXadyRfcv2LYEMMeLKukC2p0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-ORIG-GUID: 0O2ERDwcWRKnkiTUsMiPbHcQzQ6t95ln
X-Proofpoint-GUID: 0O2ERDwcWRKnkiTUsMiPbHcQzQ6t95ln
Cc: Christoph Hellwig <hch@lst.de>
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

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it calls the kernel_worker() function added in
the next patch we can't dup or clone the parent's files/FDS because it
would do an extra increment on ourself.

Later, when we do:

Qemu process exits:
        do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 1ad98e31d5bc..47ede41b19c5 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 #define KERN_WORKER_IO		BIT(0)
 #define KERN_WORKER_USER	BIT(1)
+#define KERN_WORKER_NO_FILES	BIT(2)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 8f6cd9581e2e..a1ba423eec4d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1529,7 +1529,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1541,6 +1542,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2179,7 +2185,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p,
+			    args->worker_flags & KERN_WORKER_NO_FILES);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
