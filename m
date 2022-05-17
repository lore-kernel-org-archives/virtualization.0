Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485C7C4167B
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6534B84054;
	Tue, 17 May 2022 18:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9E158GaO-gkD; Tue, 17 May 2022 18:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5AB284057;
	Tue, 17 May 2022 18:09:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFB5BC008C;
	Tue, 17 May 2022 18:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9B38C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6235610EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="X1fJSyOU";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="IUnPCDO9"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m8FJdMUNmRQw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3332660B1B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:08 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSfoU023077;
 Tue, 17 May 2022 18:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=3gCd/Lr/LrHKOFgYi4DfzpWpTieCG8yFJy7lAhr1gNw=;
 b=X1fJSyOU2qAKx0vWX8L6jpFnGZelCWVa66ptSo4WQEFiQCFSGCuiGXzOMtWPK42rnd4k
 cCEwIT3tCJjhkmwNVGvl8TAFoPtrnZ5tAqdLubQIac6uCTNhjAoKn+3otKrIc4jY8kk0
 qpxBvxY7LO5O4DSsZNBIj0XRV1yJHiAfCWCZSsR90g09GU6v3XSFRe9uOk70dZnCX5Db
 ncbfdhPi+jScBOBJqj5IiZc3FWBFPQhXsm3uctU3owN2N7jkeV6wKsZ/FVh6ELVBKa/e
 /+tLnqOV5WzzPxoOhN9JOL7a/4rzaw9xst5U9OMUs3qkb1eAkK6txF2fLafKPKFu2/hb bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241s73t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:06 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI5VfV017126; Tue, 17 May 2022 18:09:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v359nm-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEgJHWDDDlNX3Cb8JC30s2AsZrYkt+wS1yIBajxurttCIpFFqERnQ+EIvkfIEJn8jR8kgI+wwX4t0QzdAsO03Tpqtl/jDNSCSsEks8unD1peSNhiUptJGgCuWXy2bmdxn6a4xQTXViNhkOO23BV5YGNneUv4kQKb77c12nNrd0sbRmNkN7pOz+sbbli99Dd0I+tcm3C/ZrLvX4KWXnZNVlILhBJ9nmg6EMRmbpkS4b1y/6+/+g1yKxNHcSjBDSYf+vSps0apwXLH43CVp3tV2viDATHqkA9AWw52YdhWgJ4nGeuhPFkt4aYDGoplzzac9bo1yAbSZ6a0xvV4pk5arg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gCd/Lr/LrHKOFgYi4DfzpWpTieCG8yFJy7lAhr1gNw=;
 b=KH4JzdBApySTDunVVwvFtM1VUyxnikIMcOcVGWgcP8s3bKRDO5LkbgYAsuHHPFk/4Y9pywd8dvY8ki+v+UmK2ha5Bsb6CavAqmzn7Y3gIDMsojiVkjxTxNIb74/W9ChsZcevHYFLnAMj/oqU4SMxuZd9/oYyBvgXVuEDLvvMPe7wDwvKYMmEQIsvWHTqxJfnRPxoi302MQlkA3KDOsZX0HFjP3XF74F43T8uwVHO4dTSJqnlo+UHpqS5Yc4JzrBcb+Ov2hT+sAvh2obU1iy6d3XlyRyKri1CycXMLK+HRemcZg9z1pYAsPnD9Q4L8HgVV3RuNUooaZ11IJp+QNlu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gCd/Lr/LrHKOFgYi4DfzpWpTieCG8yFJy7lAhr1gNw=;
 b=IUnPCDO9/UtMH/xIs5+mDURelHdAEa7Fs366W7qlsb+vNlWhBHW8ejEl/zMHybLRaT8VyhYLDSb9YnqSGf2n25K9asPtx+ZIaebnTkD6EZCJdmambrdqesYSaI3s5/69ndmDpyQ2X904Zo3vdnPWPjs64tT88cZoKEmLPo5oZa0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB2873.namprd10.prod.outlook.com (2603:10b6:5:63::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 18:09:01 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:09:00 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 5/8] vhost_vsock: simplify vhost_vsock_flush()
Date: Tue, 17 May 2022 13:08:47 -0500
Message-Id: <20220517180850.198915-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517180850.198915-1-michael.christie@oracle.com>
References: <20220517180850.198915-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 797fc37e-752f-423b-71ca-08da383051bb
X-MS-TrafficTypeDiagnostic: DM6PR10MB2873:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2873CDAE5906696B6028A611F1CE9@DM6PR10MB2873.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9vcy2b+IpgjevdfgEW+UTkf1WV1n3m0Vw2wzd/cHCwc/qgdngXYhM+ce4ND5DhvDWfxxbyb2vAKCblIWDf1qHp+VGfHn1rCs4/BW3HrTKAhQOz+R3ITf/MOCngMl6r56+oLVTnoYXX0GmvVa1VudLLUeWMOmL/aYyZOqKclaWlKoP3/txH3FQTMVXwbHpmUE8DOROeRaKB6ZL7EzBA+xHGKEnc9wGdhT/WyodgVF4OGBKmF2kG1W9Qzejw2Zpp0AxpLk8iSjXEtFE/G+Ni8OonBspUJRnzlVQDIkk5r8DLRZaGbF386zlfXcCR/wvW6r32U0bbSUAa5ZgSvQPbxvlO2CULhJgYkcx7mRuTVWtnCEq3NmzteF85M9Mwr7iJuL5CCLskUc7FK2KSXtEFzJVL85gRo3jhIy8cZbQ6yIBhyQ9bMc5ik2Hl1a3f7gJnyD4V2lweUbLcXAcHRNvBfdBwZ6h8Ibe+kM1dCOnnyF5ymf8D2hQN4IojyGkKqKatQGjvL2aXwUByBIRMoFhJ+xQ8XEgojPYF/9WvjbHzTOBe0eXWsG4EcA5yRF/VutKD/GX+D2GxYbvzuuI2aezryGk9dmkhuqP0mh9tp09oi8ajJd56kksigyaAtv4+VBC25DCxVOTgVIejeeI37W3rYFxZl0I2BHDmkdyNp22aqXyOWdHc2lwHIeua6Mc5FqefO3YRIRdO9MVFybH1pjexzhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(36756003)(5660300002)(83380400001)(6486002)(316002)(1076003)(107886003)(38100700002)(6512007)(6666004)(2906002)(6506007)(26005)(86362001)(2616005)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(508600001)(38350700002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r/9zgv/EY3v7DOcN2juFAOGtDoX8DcEXDhVcbAjzyylJQOqjf663yb3R82Aj?=
 =?us-ascii?Q?Y80YxvXgE/+5OEeTFL87pyzwisuJ+pzdws+ViR7/ULPfAByeEMUJ9/7P6Dhx?=
 =?us-ascii?Q?r0caPQPwf+2T/SVopYy1H5AIqQYP9Q7LEuUvlgwWO9tN5ds9HFfkAxFfkwOp?=
 =?us-ascii?Q?/N57oecqayQ6Vmv0Ic+006ODv8kNMprHg8FnlJnVhJGuOH04aMZ6peF00BDM?=
 =?us-ascii?Q?XfZnzTmN9lpDRd+9EOT1V8S753JD4WgGqegKkj5Ax1aFAcKhGAKkPdURkYKi?=
 =?us-ascii?Q?0lq770BUa9MejTZQF8TPcOsJO+rfGwHHGuymTvys3O9naqsgNRV4dNrA7ZDy?=
 =?us-ascii?Q?lW4XWyMCAia5Fl201QJnFC1YfdBx4xA+oSdtGWSqAoCNExBu72iJw1M09lHC?=
 =?us-ascii?Q?r+P0ZRkSqxau5e3hMOhRjB9IB2AsiZ2oiHumIB0wqNKBGJgcJoraoa9nKHTK?=
 =?us-ascii?Q?S17/xOPwRMTVzZQ6UbJi9SHqQS8lYqwmRSfACRxTz0iXI/2iN13aERZ5+1MI?=
 =?us-ascii?Q?92ojIFWyoiXfuNCIEM2iDpD6m2VFDLpELYgtqqJR4xLvZN87t8JI732q5Li9?=
 =?us-ascii?Q?srCuXLA/2E3XnQegJC0OMWbv5svt4a2L1ImLc/nxd530RCHOIoY2RCvD+1lJ?=
 =?us-ascii?Q?mDjCnD1M7eUwsbNuI5Pcb3+K9y54kO1wHYZK6i9oj4IpFX+8gkbyWuf6fkGN?=
 =?us-ascii?Q?efDSbpqFY426ZGL7TBUHVeXwIVlVf8Cm1UovP9M9pKzERZ5No55ntRXRvaL4?=
 =?us-ascii?Q?hqo0rqS2L+W9wJ5e6+Qf3l2i3ehp4stdPeW1ic4fNW0oA94ol6zOb5EBvINW?=
 =?us-ascii?Q?HR2TTT3CR3XGS2NjLc4viu6ReKRPXJygOj1wnTAnOdtIxV/+7Z4cXAxUxtcv?=
 =?us-ascii?Q?r8m7gikuzmFwLwt6Y8WZnl8/9qtgDnzJe75X8HE0Ni8pLJq9IMe77HFMahDq?=
 =?us-ascii?Q?tLIMZtixPLtjLnm6iaVzXh0tbc7IDcpPp/0x/23oc6j0dPzCzc8qZe1YI1Jv?=
 =?us-ascii?Q?kP1F4Qr7c5FNErZtxdclWTnfJXoTxJBT7n5IJ37+9QjhGMCJCR6zaWjfzYgR?=
 =?us-ascii?Q?fwpqogK3XCQvydy4Z5LwjnA1sqPG4Z2DWPz8eMSyjMHf9aBIf0O0HgjXTHxu?=
 =?us-ascii?Q?JAcZYTntE2V9RCk7BKiIRZGFsvbymmAnV69dCcV4VRs1oSGXh1DVSab5UhQ5?=
 =?us-ascii?Q?1wr+FUHyB3n2ohgj1ORm0LJCHRNX/eO2IOg4G0aZcqvy8TwbDB6v2sjcn1/b?=
 =?us-ascii?Q?OcF9h6qgr1KJMJLpQOuuGIT/r6nLXm/qSHKFg4EKw1Ylqq9mMd4FBcoMex2B?=
 =?us-ascii?Q?azGjwQEQhh7WeWgV5ZLdVylP5zIOhJh3btZs6BOP7evyz98/TJPfnWl6oUZD?=
 =?us-ascii?Q?XIzkndAjsR62twDNnS9Xz5rV1abfbrVHr6rdPt/esgSf0zO67RaGsd5IDjkf?=
 =?us-ascii?Q?qRPzB3xKDMFSUKDs8bTl1/auXaRxP828/BJXxJGb7a4N+Kl8Fvn9SMcYev5v?=
 =?us-ascii?Q?oQqhuQI76U/r7eEO8a9xqHFqjXd355q/RK9N5r1iMIjNYNZQRh9xJYB+HFVb?=
 =?us-ascii?Q?APxE3QUleXdjuYf7ga+zV85ovuYzrDcisP8nh5xo7pNyyR6KCtv7AIPOluGG?=
 =?us-ascii?Q?LnfVPGl/KMnaghOimast/sSiVaFEMXwwGv3Gd9mskvrlt2RnGpnDuY0ElPbP?=
 =?us-ascii?Q?X3XqJgHkEpEsApU9RpiB3Cjg4iQFlmHqA4WsBQ80jv4Ju9N4FBGbwyAGVICO?=
 =?us-ascii?Q?XonUCq4UHmD4TOh8aiZ+iF1fYoB2g3U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797fc37e-752f-423b-71ca-08da383051bb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:09:00.8420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SMY/iVjpcGNpcFCqknEwTzeadGoZsrQT3rmKJs3enZb77ru316w0yLZmmQrXQnUGkQcYLQMfcRINQ8zGLV3MXG5J6owtSruxR291Qg9lgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: tVgl_YXOKa-6AMowADOAxaMFJCn9xgif
X-Proofpoint-ORIG-GUID: tVgl_YXOKa-6AMowADOAxaMFJCn9xgif
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

From: Andrey Ryabinin <arbn@yandex-team.com>

vhost_vsock_flush() calls vhost_work_dev_flush(vsock->vqs[i].poll.dev)
before vhost_work_dev_flush(&vsock->dev). This seems pointless
as vsock->vqs[i].poll.dev is the same as &vsock->dev and several flushes
in a row doesn't do anything useful, one is just enough.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vsock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index a4c8ae92a0fb..96be63697117 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -705,11 +705,6 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 
 static void vhost_vsock_flush(struct vhost_vsock *vsock)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
-		if (vsock->vqs[i].handle_kick)
-			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
 	vhost_work_dev_flush(&vsock->dev);
 }
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
