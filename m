Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208C7C433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 15:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9AE74184D;
	Thu, 10 Mar 2022 15:12:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4iPo_amKgqsl; Thu, 10 Mar 2022 15:12:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5836041758;
	Thu, 10 Mar 2022 15:12:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AF14C001D;
	Thu, 10 Mar 2022 15:12:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45B5EC001D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 311EA607F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:12:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="YmQRO4hJ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="B1WOwofD"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pj-rp1jM99Vw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:12:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D7A260A79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:12:38 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ADdb4o028201; 
 Thu, 10 Mar 2022 15:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=VSf18qjDUdxfJhWWE26Bo56jmUSUPIW4S+pgdltCUc4=;
 b=YmQRO4hJ1zd1nY1IaMbxfPesujN/jTVx5zXE12xiGP0hnjT9fZo+XeDr9uxrUfpk+6KA
 TS9iN64JQzsT+jQQxkO1gtiLFwKwwjBsET37HWFc4U7bdAfRoc7SlA3ebZIDlxlL4lKn
 q6tPJwVBWNhwLkWlRtUiD8JG1dU3v0JNzDHRYnFKcQU4Ae2muGvCF6YtKaiLn5hoVcw1
 EfrTMoXsMaQf9pHIilswb3FRa5Y3AKVQKRBvP0j3cLTK08AgMahp+h4rCPpge0Vi7zkh
 LzdPt3MdYt37r45LVaCKFVvWAbIaH/B0mlf+UoFzDk2JUZfMOuSwWCacKiYpf7+fZD/v jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0wh4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Mar 2022 15:12:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22AFBNKi156260;
 Thu, 10 Mar 2022 15:12:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by aserp3020.oracle.com with ESMTP id 3ekyp3mq9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Mar 2022 15:12:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHuXD4sjgbWKz8IpqEeZG7BFb6pmFgWewewZkHMTpeQ8KhOvEdwc617RBFXKV7zqKbw99MivRrTZxlpyWEuQEszXFHY71MFcoMd3BtS/0odpYU3b8lKw+BZiPAfYCmutvRcBWaxP52ReLFGL6tKJINgzkTAZ5LGWEeqVz/nP/mJAuzSI19oUtZKp8/pQGGG4nRYzO1fcfwhjOMvaPXYqEv2E2rSkaLFMKELTJHa7txoq80pFU3MDux8cK76V2uN/UQ8j5sxYAfiuFDRGbj53aSvcYvOqa7xBXtldDWnT8FPgpKtf5wg5KfKEileLLeWeABEkyqMzUO1UuY7oYJOo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSf18qjDUdxfJhWWE26Bo56jmUSUPIW4S+pgdltCUc4=;
 b=lUbwUhNHvtLrS2Ed5gaWhwdvGnM1wbNW4GSpid4enK6/z0Uud8AykuGG0UH5e1+CEyJQu/EDsfpO2varzYujIvl8k2sQF8Iwhpr7Yh/rpuo7Vc/hY3Qnf0LTQ7//8mq72QRiBhpTSlY11xYLDhEovT6skXKKIOhX6ueWa0phfziU5GyYtyHMWOz1uppLOn/GeN6QXFPuVipZGBFYwBHXvuCR5oHgncLDj/oqO3aFK3fkGzh+GdO3jAymByhiErN8lRA/NaFTQs6m344z5aB9HOwUVaWi7IiBCBNyVTOHfc6pBuuYqUshPT26qUPxWSm6VbvM/0a5rWuzkQ+rfBGa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSf18qjDUdxfJhWWE26Bo56jmUSUPIW4S+pgdltCUc4=;
 b=B1WOwofDojUmDfecrtfQmfeDueGsDiR133Xn01ywBhzpjEQLHHhx3Qsea+x2EomnKB1E6dyZZzWuM/g4/qgofT7VKFBZur+YirtPZyfklb8ckME0iFG8lOTlsKt6tdxRpOWAi6GZGpILy3vrT0ezByYyuqmfgGym6On0vu+mY74=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3273.namprd10.prod.outlook.com
 (2603:10b6:5:1a9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 15:12:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 15:12:32 +0000
Date: Thu, 10 Mar 2022 18:12:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: xuanzhuo@linux.alibaba.com
Subject: [bug report] virtio_net: support rx/tx queue reset
Message-ID: <20220310151221.GA2212@kili>
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0175.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32931e58-2b06-474e-724c-08da02a86698
X-MS-TrafficTypeDiagnostic: DM6PR10MB3273:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3273E3FB08D7219498B452148E0B9@DM6PR10MB3273.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3yDwmY+zO8mV4522KUbu6PWS3qshPHKgUit3jFsqP80JlRLtA3jS3Ancs6hGeQR3OSc7nI1+ywjfLDFKM9hu+9SJjfPFtkcvUsRTD76Z94/W1mYjgQ0wXzrGWNqiP0u4fdqOp+Ul6RLfj8wDwFzwn7INV/FbikZuuqhPYg4XG8Y/nYF5uRZNK57sJbcCu3TbR6loAc1oCwDRWsQF3f4Hk/Eo8PO1Dfu6fXNb6kpBrq1Sxp7ymjcQdhGSgYC/hYtIgwMt9XPtVnjrcZ2G6horINArT69Xs+3Guuk2g0+eDpxzQyr5ekcOBt3h5hcl5jfd4saB4Iutd02AFm6RswerkPIIcVZQCUzFJQpqUms0jvZ5mzBtAGz5RYX9cN96eZRt35mc1qsplUUFDErlQUXmD9xKp9Zx7fwX23xsV9IPKqn38+h+soEzYFC4BMz6iRX4y/l1SBsSNWeCdggJ/qvf3V76cm9BqEdG8bCl/ZLe8idULfb83b0v88FpqwJmjK+OKnRsMnwesdC3+YCUD12p4HV0YHeF5qMNJMXUkFUjQboKA2Dg9Lbfq72pdvjF+9POtHmDkHHQF9P/8ZSP9vNnKMUZw73oDsYMu+AHiJjMmTaxvrZ+u/669iJODS0saucFN7Z9AitQkLuu7aSD0to76mkxDnJzN0JAZLRnrfFkme8/O3d5cRtJMGpb/MufvlyMxJ0r+VuR/EXwH8jtdKplA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(2906002)(66476007)(4326008)(66946007)(66556008)(38100700002)(8676002)(38350700002)(508600001)(5660300002)(6486002)(33656002)(4744005)(8936002)(44832011)(33716001)(9686003)(6666004)(52116002)(6506007)(86362001)(26005)(1076003)(186003)(83380400001)(6916009)(316002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d9K7bUanEqX9xujhxdqFE+uQB08ZOsmthH+egJa34X8N6UPZn0hlIEpDCb1e?=
 =?us-ascii?Q?ma4IjK1y1UB3LeQfdT03EiVuO0dYiU62qZ0q22sSEbpI3C9f+s0Ug6SECArt?=
 =?us-ascii?Q?+1J6fx1Q1tGZhLsss7SCF1hmFy1QEdXYu3INgjEkKSoQA55jPCx6zzzVSd6c?=
 =?us-ascii?Q?PQPTXMuwDXNf+yOsaiLTPm1ZFu7jHcQwGWtkr8BoqEOZiKKHV9iH4SBMgZq8?=
 =?us-ascii?Q?tSUiQIOHHjXm52HUrJnGicZZehv49lYVfrbEDmZmEnM8VSxaPxMto1IRrh0N?=
 =?us-ascii?Q?79HrfF0oyQXtJvZr6QUn+5E4kvOqJOb62orZlmta8VXNsXEvaorJUDZCQFcB?=
 =?us-ascii?Q?FWe3g54dMTtLbQqGDVLxflkTVZxLGEmX995leA5YmSAdhQyQcm0ewh6XxpFu?=
 =?us-ascii?Q?9ss4/xvQl1ADGdMs7sP0zDx9FNGtrb5mtqKdQlXc06YM7S0ffKnEC48/s7If?=
 =?us-ascii?Q?OnMBOjl81zvQlssGrfXeUuqfVcouBWGrfxVVF03+UgQFgzRoTgTcKJZzx+6f?=
 =?us-ascii?Q?tEPNWem8OLoBMUbLmsotYFXq/N0zD1bzFUnj7wSncGYzkkFE1emfvBTmFMH+?=
 =?us-ascii?Q?DiGqtQ3tHjkLFDj+9CPuST/fFiawDWpIRdhX6LN2/F1Nnf9WMlOsyP+DCCvp?=
 =?us-ascii?Q?WBK2vcOQqg8AkJNPTGm6C+PqnrWM4Wma0bbqFZnFfevlfAGIvfCc+U8cAw1y?=
 =?us-ascii?Q?vDQpfUNZDJd4Z58f8XA40UUhMiNZciVL0fiWsfah0eCpA+tj7PA1lZDLV7Ua?=
 =?us-ascii?Q?0IGQU6gR4TVVoHm99o+ijO+dndrXc30rdaKCxSVRAii0cfdAEVC1Htn7QebZ?=
 =?us-ascii?Q?1pDGJJ2zWvd1UHxLAat57K+Gi2VM5xUL7uVBRN+Ew3wbKrYnFcoUIKEHUud+?=
 =?us-ascii?Q?XFTpgWeXwkR/Nl545Sbf6xkuIqdmOI81WTt8TUZENGLIaJg61mBzVc7EszYm?=
 =?us-ascii?Q?HUccXnwA1UUnQUheG8zyW7KhzEWnTKyxDl3N21ggCQR8b4dovxNLc+llpeGN?=
 =?us-ascii?Q?3+eU1qwTnohw+4M4+wW6PPKPFr38KSsxoPqzVVXz83UeU88DKgwiN7S8XB7x?=
 =?us-ascii?Q?OlAjWWTtAp9d040bOqNilRh7V985VRtzU/AsSdvCvFJWVbFJdCqhykYdNmxN?=
 =?us-ascii?Q?p6ZU5FQStUhV2rPLvYq1x9Dz4LmKEVvEP3PC8uf5ExxCQ8bjWIvZn1IghihG?=
 =?us-ascii?Q?pXl+q1JOpWGZV6UIU6sSAlFEaP97FJMGPzhQp1omkB7p/l4mtH50nLwC+3Tv?=
 =?us-ascii?Q?qOiVk2X/8hO4UrIEJ7gOE2Lo3zX1tv+bPi7pwB0rfFWZIv8hk2l67lKTzUNG?=
 =?us-ascii?Q?OaPlvv3J5tNrIJqtcNjgK4wotzZnKcR/Tu/J65y+IHA4ayJEwd7SMjvlwfsF?=
 =?us-ascii?Q?riVh+CZ4f0eFVigWP/7THLVqDN9WZjIq8A+20VoM9yd7333Nl/Ma7KQoghIG?=
 =?us-ascii?Q?xElyX9aqBlv65hoG0vNie5nBrGp26Sq/CW4pceNX6o/R9Gb+rQDwHw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32931e58-2b06-474e-724c-08da02a86698
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:12:32.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2g7EhNpLOE5rIs+gApSSPvuraWRPMms9UKZe4uYhWxe3xFvzATe12ptlog2zBAmMi3rMMs9lQD1mJ9D9SM8pP9OzL5i/5pMlzyxraRM8Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3273
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281
 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=863 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203100083
X-Proofpoint-ORIG-GUID: x-VmWE5KIDdnsCUNo72P6blQoHYWh5dU
X-Proofpoint-GUID: x-VmWE5KIDdnsCUNo72P6blQoHYWh5dU
Cc: virtualization@lists.linux-foundation.org
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

Hello Xuan Zhuo,

The patch 26ae35c46f93: "virtio_net: support rx/tx queue reset" from
Mar 8, 2022, leads to the following Smatch static checker warning:

	drivers/net/virtio_net.c:1410 virtnet_napi_tx_disable()
	warn: sleeping in atomic context

drivers/net/virtio_net.c
  1829        static int virtnet_tx_vq_reset(struct virtnet_info *vi,
  1830                                       struct send_queue *sq, u32 ring_num)
  1831        {
  1832                struct netdev_queue *txq;
  1833                int err, qindex;
  1834
  1835                qindex = sq - vi->sq;
  1836
  1837                txq = netdev_get_tx_queue(vi->dev, qindex);
  1838                __netif_tx_lock_bh(txq);
                      ^^^^^^^^^^^^^^^^^^^^^^^
Disables preempt

  1839
  1840                /* stop tx queue and napi */
  1841                netif_stop_subqueue(vi->dev, qindex);
  1842                virtnet_napi_tx_disable(&sq->napi);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
napi_disable() is a might_sleep() function.

  1843
  1844                __netif_tx_unlock_bh(txq);
  1845
  1846                /* reset the queue */
  1847                err = virtio_reset_vq(sq->vq);
  1848                if (err) {
  1849                        netif_start_subqueue(vi->dev, qindex);
  1850                        goto err;
  1851                }

regards,
dan carpenter
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
