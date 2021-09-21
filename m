Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE67BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:52:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D8360FDA
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 84D8360FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BB9340665;
	Tue, 21 Sep 2021 21:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4UzSxgpkuIh; Tue, 21 Sep 2021 21:52:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE3794068C;
	Tue, 21 Sep 2021 21:52:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6097C0011;
	Tue, 21 Sep 2021 21:52:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A232C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 360A060839
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="A9TxBozR";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="F7gC70wl"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oh4m5OdCAFOU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:52:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1700160832
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:52:50 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLECTu027984; 
 Tue, 21 Sep 2021 21:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=k3UEBvbi827abY9LJ25RF832sOl4/avHWbZgU4S4sQI=;
 b=A9TxBozRkVyQtgSDq7G7XnGe33ivSnUGTLr5LPCOxSbLaD9mquXckPWM7jIpWZWw3JmS
 6ybVduVk658iEU+Ps405fAFeeewEKQRW8DF4TUY1aEkWEckDa1jFRMhZS/1rzeF6AHoc
 Xn5mjl7qz6yVbANuNwFOYJU51R9xoGoV7SYxNgTyRT2IuuMUCTwlfiTWAd0445foCTwk
 QBiR20ltfqnsuC3zOw22RC1xv+r7ogEqAPVYTuEE/F/dg2GrYSnp/LrEnXS3JUGjOW3U
 LnpSpMutuR0KKtD1imlhaTx/bf+1X0tVKpVaDeBeV6XICSgZdopQWM09l3rs7gScBrWM CA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4r8554-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLnv9f106589;
 Tue, 21 Sep 2021 21:52:31 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
 by userp3020.oracle.com with ESMTP id 3b7q5v97j1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlQAOdE3RQnNDQQtCqsi5oW8dYoKOakwFoBi87FzviwPRyC77l6+6pCmCNl3+vGUtdZ8eX8R7saK9X70hoWDigOHBhCleVqh521rSGeYsuYg13jf0eykU1owbJL++LeNpakcuXHJZ7xEVmnNOM6J4m50wRZ9E/fh6dUPDgmkM6bgxVWiSy/E+lBNDtWw6FQqlp8yyhbT7XOdwug/cOns/zrZYSSzgM0VwenNQvJL9LS9DdYJpPFtx75W/PWPGkzZUPJoEnmyArM8qA/VfTf++4ywpzONU3diSIoIndhYIXx/N/F4+inUmnnykGpYVcg+YgTzEyBBBsJCTiXKdbIvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=k3UEBvbi827abY9LJ25RF832sOl4/avHWbZgU4S4sQI=;
 b=mBMc9PC6FUFslPRkQrFXvjyZ4ZZa9lmHP+7EQkJO8QIrNujI+4PHLIkCpX00aysceXmHoQlQl2nn7k6AvgZ8Hy4lU6oYTk1M7JxHRCQJRG9nQHUhrD43Bfdp/C8c/jiqoeeA2xgkNtYEJmi48AvQo8Q3ofvlPusgh7b6bcr934Fp6uoTGI/rmhRfls2wbzuvUcpYqUiYwH0EzEZH4Dgw6w0yyVrF7ZWfKM2UajXWHDxxGWLQwosDypI57pB2YEmlGuVyKvTVEAgcqASb6UO0g/A0dq0Lr0SozS55kDDpCu3PmWm6xD42Ry6TnUDar1mbS8FrWw6RiO1mry7o36RaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3UEBvbi827abY9LJ25RF832sOl4/avHWbZgU4S4sQI=;
 b=F7gC70wlbciDnnypdudd+rvX/AZf0NCJ3/f/Q4hSaFs7IBoBh+C3ae6VIESVaGEbOQOflzW4XLLYV33sLv2lfSKWukhyZHjmITInbCrnPlJ1Ol7zHYV2SfzXiyEtzJzFozATqoamyLU0g5M36NzuhVKaKqTpJjGqvyjhDokX2jI=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 21:52:27 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:27 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/9] Use copy_process/create_io_thread in vhost layer
Date: Tue, 21 Sep 2021 16:52:09 -0500
Message-Id: <20210921215218.89844-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM5PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:4:4c::31) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d397040-bd26-4ce1-36ab-08d97d4a1a7e
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3892FDFD3226409D18723D9DF1A19@BY5PR10MB3892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwwcIWHS/8bpXSKLqbiO7EFRibJP4dMyymW415jw4RXK02d+9subrtCKQ8Ptvk5xEBZKvOqG2pSOZpK3VplFyzuOMRbwTvEe9gGxoWqHIvSNfzyHsQFyhWsDTnwD6+HL2y1CC8BdhePJATAWPskTblhaN4rG0hv+40dvQ/lsM8805fgz7OkMO7cMZM8cqbAM1JcnqN0wxGxUSfQI9u8H32Q3f4p///oN8iOZFUWLinwkjSrLYrboI9g5keWLv90E9AeEBpvZ6aGBoilMXwB3b/DM1jNUTozKkr74pEyKBlUdK7Gcq2a7KwP6LZGSS6wmgEJCnDiq1aP8HE9Eyq37HI4ynXVKDCW0soeBmT40WKetxW5Lc1fFraGNk8ektPpVUSDGRhOQqIzr09tfUpjLf2Ir7vOWojFV6JsREwGWK3FvIWyfj4/0d6mcQWxUA1R+oXWh3MmsYcM36AH5AQIaY2jyAcZYFEkPLxWZ6c91BoKrGPUsUvc+bXjLBN2fWSXj78GM0Z9ZOSoqU3g8g3A3hBdYaJHNZBcOoeHQGDzCLnS3WRCsuC0MkcJq4/VhUHWQngxC7+aT/FcUwBD6SA9lVROajzuGLTMXM1bN/fMCLFANmpFTTZRVqBpXtWN43aNPHQibz4xv4MhweQdqwRVLbh2BVf434NC3eC2W0pHZOYJkdgVLKkNWCQHg3/kBx8t4kIbQeBCbHlP+H3v84AbjYMfd09kX9i/ArY1aSVnBsdlrFu7PyQqyN7kmPhYslQD1b6pNg9FaSs6KfT56oiRtSbgqPWKCLb/BRXikfJwOLB8UXiThr9X5S32HuZ4qihO6wiAvr/l4zk3yzx8kbW1vXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(52116002)(956004)(66946007)(26005)(7416002)(66556008)(2616005)(66476007)(86362001)(6486002)(8676002)(6666004)(508600001)(316002)(2906002)(966005)(6512007)(8936002)(38100700002)(1076003)(5660300002)(83380400001)(186003)(38350700002)(921005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfiAiR8f/vCw+RUcM0KuY4LfiwAnsoSQv6wMRqR02zVMgkUF6JlOmANRt7Pi?=
 =?us-ascii?Q?8pJEgTnCWYEPodQpBAe1HJX0pQTdptkmjVXfo1h12lXoMZZLeg2lENg+cy9a?=
 =?us-ascii?Q?5QiL7iNuya7AFNKy++n2PQhmSjWFKlsRIyygkZg199wy1LgvCPcIrntA4J5p?=
 =?us-ascii?Q?l/f0k0wKK+DpnkWw2xKTtv9w858cM+XYnfh+vXREZh0Nza4WQ4Ozt481drX2?=
 =?us-ascii?Q?aRo9svO37bz25YIr5d1w275D/WGVVHP+KcryiXfh+q/caCfQr1wPgn4eSfRo?=
 =?us-ascii?Q?GCZjMlV0iU+qQ/y3A274eJ8a5nC5Oo5fUQJk56/QPbf5AEQzyZ0omiFRCV3f?=
 =?us-ascii?Q?/hDDIrYPYEae0tIxQ5VozUTYPQmM6BC/QEQwijvJYCexkj4dnxcpI2fq0GhQ?=
 =?us-ascii?Q?SfcCjqJUFG2/OJBlZgtXANMk5m4zYfU60h8KI0ANnL/fbVhwbUXD/nV3n4mc?=
 =?us-ascii?Q?yQd85DXJSNXGY8LTGgeiR0KoYY2xooc9Q1ASRWNE4hWy5Ra6iSfBBx3boysK?=
 =?us-ascii?Q?UmeNI0zTiM7jLvrj7vVNEz+2ok2WqAg3oOXEgMr+t9bkhPBsROdjAyk+HA5c?=
 =?us-ascii?Q?GFQ61YYLxGBsom7xjmggz9gZqK7rwq4qYDGmYol1Ccr2pdC96br78nfkeXRh?=
 =?us-ascii?Q?+YmooP2UM/9RLyuOS67Bmkxp0oR+DHMz93th8St0prpc/w31PluxgNO4GACs?=
 =?us-ascii?Q?ZiZThOPzoux7FSENUTewD+JCSZhRi6C8pYKL5w9G99zNQnY8oPGiRr9RUWju?=
 =?us-ascii?Q?OOGS3kae+yrcgtQlbZZ0Or0WEflOt2gZmhtdsUvUzTjzYvVGeriF41gBPinV?=
 =?us-ascii?Q?gfpfT5gmlQw2e+hoV59ynPEHlJSfG5v9cjlkMiJkIIRmKBwzaXnYVNaRJKAR?=
 =?us-ascii?Q?EJQxulQm2xMKuweaZTfNcPqNHt0Xs2VwpvVDTsF94mK6GJ/b3HaFtKbElp2+?=
 =?us-ascii?Q?gtTY+Ok5ivXCa7ydryG71Xpg5deo0q1CZ+DiwDgmFRsX7qJiuGFf2o4VsKwS?=
 =?us-ascii?Q?9+rpviuAR4iiY8Vyq06djhN+nMpEqu08A2iUN1HRObtKnKi5w5Is4JLXGY6l?=
 =?us-ascii?Q?FHTuNlukHobKo6G6wAUztlQwj0cjTHBgABCXmZBHae8hIiBwz7zkWZPJemBJ?=
 =?us-ascii?Q?qb+1VLtriaG2QIo+ZG00HwVYr4zFP/AbVSt7iyhdibRAjHW2fa/kmUCm66fk?=
 =?us-ascii?Q?5E727VYfheL3Qx6cAmVOTFL0jkubG2x1xSxMz+OnRlJ6xLneckfgFE9BoEgO?=
 =?us-ascii?Q?tRtoVF+JhqB3LZbIxDsNBuBVss/+MqwCVgCRzXo7c+hsdI9t16H4xmbF90iz?=
 =?us-ascii?Q?DaICEQD5li7HNLdqtxhPVTD5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d397040-bd26-4ce1-36ab-08d97d4a1a7e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:27.8844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk5gcy0fmwDxL/wk42KaXPhbY3Zrfvg7fyZB7TzmOFLMd0g+N4Chgd9z6QQ+9gAJRsEZHDVEayTRsOCjkHuPMBeJ9mYQNGx73bxveelnjxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109210130
X-Proofpoint-GUID: pjOVjY-SmmBfgjk2gvmMmPVWclCC3rC4
X-Proofpoint-ORIG-GUID: pjOVjY-SmmBfgjk2gvmMmPVWclCC3rC4
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

The following patches were made over Linus's tree but also apply over
Jens's 5.16 io_uring branch and Michaels' vhost/next branch.

This is version 2 of the patchset and should handle all the review
comments posted in V1 here:

https://lore.kernel.org/all/20210916212051.6918-1-michael.christie@oracle.com/

If I missed a comment, please let me know.

This patchset allows the vhost layer to do a copy_process on the thread
that does the VHOST_SET_OWNER ioctl like how io_uring does a copy_process
against its userspace app (Jens, the patches make create_io_thread more
generic so that's why you are cc'd). This allows the vhost layer's worker
threads to inherit cgroups, namespaces, address space, etc and this worker
thread will also be accounted for against that owner/parent process's
RLIMIT_NPROC limit.

If you are not familiar with qemu and vhost here is more detailed
problem description:

Qemu will create vhost devices in the kernel which perform network, SCSI,
etc IO and management operations from worker threads created by the
kthread API. Because the kthread API does a copy_process on the kthreadd
thread, the vhost layer has to use kthread_use_mm to access the Qemu
thread's memory and cgroup_attach_task_all to add itself to the Qemu
thread's cgroups.

The problem with this approach is that we then have to add new functions/
args/functionality for every thing we want to inherit. I started doing
that here:

https://lkml.org/lkml/2021/6/23/1233

for the RLIMIT_NPROC check, but it seems it might be easier to just
inherit everything from the beginning, becuase I'd need to do something
like that patch several times. For example, the current approach does not
support cgroups v2 so commands like virsh emulatorpin do not work. The
qemu process can go over its RLIMIT_NPROC. And for future vhost interfaces
where we export the vhost thread pid we will want the namespace info.

V2:
- Rename kernel_copy_process to kernel_worker.
- Instead of exporting functions, make kernel_worker() a proper
  function/API that does common work for the caller.
- Instead of adding new fields to kernel_clone_args for each option
  make it flag based similar to CLONE_*.
- Drop unused completion struct in vhost.
- Fix compile warnings by merging vhost cgroup cleanup patch and
  vhost conversion patch.
 


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
