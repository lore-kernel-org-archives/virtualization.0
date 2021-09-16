Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ED1C433F5
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C6F60FC0
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69C6F60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18FD6406FE;
	Thu, 16 Sep 2021 21:21:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2LIBbESjF6Oo; Thu, 16 Sep 2021 21:21:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4FC9A40635;
	Thu, 16 Sep 2021 21:21:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 148AEC0011;
	Thu, 16 Sep 2021 21:21:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 911A5C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8102E80D7E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="zBJqtzGn";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="rqsTe+6z";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="rWdKwq4F"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PaOasHyBY1Z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7113C80AFD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 21:21:07 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GJu7YR019729; 
 Thu, 16 Sep 2021 21:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=G4osKdktX/ZEqtQ4EpH1N9vM9fppqprnCvtuI1aUGoU=;
 b=zBJqtzGnSWZs/QgbZn69ldsQu0X7Nk/xoxJwtVRjy6pPJkmHhohG15opt3hPoWoedyPp
 ErupFlp4TZCZoswILGc5vxqGxMJaZc5V+I4x9PveR+o0b7WkFNCAmXiLDA4XckBWX/DJ
 w4vQcZNfFR7G8h8hqN3TDoyabBeqPjB8iB6oHWuZcRYYE+j943JedwyY60lAa+Y6vug3
 0roskznRQU2r4+NVQ9iueyNDTY1RoWPAtKnp0PSnXusvc4NO+QTA8GpllLdJnSD3I2TY
 CssAH2Iit9+gVEu5tUWLEQzF8xYq5lBdxbakXThnBDjqj8iC9NYp91t8qEqS9rJv8fGL Dw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=G4osKdktX/ZEqtQ4EpH1N9vM9fppqprnCvtuI1aUGoU=;
 b=rqsTe+6zYp3q2Bj964XFlouVz0xfKbLeedoBatPwRVNFzWjwUbwpshVtZ52z+fAEws3C
 R2VQIzdW1+72zWbniA1eAwf8w49vQb7MytYYZvADqme9GeldQa2vK0mHkYEWbX0rMUIR
 kdWIZIhm17OEQO+Lg0jMHVil9KeCHvy9onFN9Ot4TLMvmayUHgSJBsOQuKufxgeFZYeP
 99QGN50vICRTwGkcLcJ+7vJKxYlpzkfaRHhEAd5RmYnO/J0JV9KmpjdIjkXuO4KzV7FM
 zbarnXhhVhR8vM8MruAjKCs3hWxSqtV2EGM0WLpF1ccc9r8m5RzS3yj61yfkafGaZmKz 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b3t92m6q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5XNn011268;
 Thu, 16 Sep 2021 21:21:04 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by userp3030.oracle.com with ESMTP id 3b0hjyuvpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Sep 2021 21:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX7EFMKlm8EeSAZLILEPuUuCgonFDpLxYMIS8D05O61uUk2VHym3Mzm112ZVBFoTBlCGppsAqQTseX/pYU6TPSE3l9BYB2GTn5LBKtLjIs8b9Rr70Ul6PvY2PlRG1qWrS5RCiV2FjWtyQn3KQ/4EArbcNvTEfmDBnxIoX/1Un6zO83e3wZbuQ8NS3IBhF/dYMQK5jiyCTb6WdyUkskDFx4pTQiJ7+0SqoNXjeyWATXEAMIzfQV277mg131pAZEbJcV0gD5fQC4vSc1+MPIwcgL3+qopYdwFN7fQOPSD2coU9QtU/pGg8c0IoZgDIkVYA+xzMSWFj9d5GT1RIK6Ov1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=G4osKdktX/ZEqtQ4EpH1N9vM9fppqprnCvtuI1aUGoU=;
 b=O75lcEdUKFSv6AM4O+eHRADdawTqVQiJ2DrB/kxS67KyfzIm3LF848nUYbbrMNpgKLzzHSHLr5rqZ82J5Wz0aJrpOpCYtiwAnac5ZM6+zk9f4ewJX8DLkZRDZHesdyQGe3K22YSGWN1VudXGEQkxTOmKVMD9QD9xVN554SQAQR8YS8/3QD7W5uy8RGBKGjhtq/0cgssJ/Q+EU2xNwBdhGexKcAOnDEljLN4kszRb/ma5hY0ZZYZYP7d+m5BNiEP992kFK9f78XezgBTV2f+l1qHDVQrEHj8vuibY8AuJKjgvtrnzpMNMvemRc7nfhFJwPGuTcc9GYoexpuUCZv0SYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4osKdktX/ZEqtQ4EpH1N9vM9fppqprnCvtuI1aUGoU=;
 b=rWdKwq4Ft9vilTRYKGiuLeHQN5gQd9HnyI7J4EKETCoDKFMo+fYMSBT4T7Wjz7ItY9VnoMh4OlWAi6Ges1PrWl4z9XdFNXyn5vAjK85i7riViq0YVdJ16s6Up07Obi6/2SYvWjXO6kFCnNd3t0uFxtAZMQtBxmhJP4LA5Z1ExCk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:01 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:01 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Use copy_process/create_io_thread in vhost layer
Date: Thu, 16 Sep 2021 16:20:43 -0500
Message-Id: <20210916212051.6918-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:3:12b::13) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0f7061b-fc5e-4c1b-e0d3-08d97957e1e5
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-Microsoft-Antispam-PRVS: <BYAPR10MB293544560A6E3D694F72052DF1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Szz0ScDlZ4mrxKgZpi07Dk/6kMmWbieKZ1sDmo0Fnp6D/s6Wz5kClkmqnvOAtvt53qerae7KRM8Li5i0jjFSDGZMwBl4jTjMJXJnyRndF5uKJYp8tXRWD+D6jw07cl6UMsP/AEFBhbki8U/BTbYqSop9bFu+sE5zh4rY3Z4EdBImvWAMsoLTgidvzzepYgn6Qde5uFO03mLOE2HBwrzl1gcOnrvD4IhWyejJVDKnTP8gwvFdI7yVdXMHTMev2NK4JHkLBVu913VEI4Tu9SnKDObenorBKWthVGv7/MEAh2AcQg6nH9qdCDVbkoQr/46ATn6Zhz1p953JnzMqwhxjuDAabDFHynDN/7brcuaciaAEObPg4oW9yoRS4817ehfS/x7A29FUHme/itwL3R1zN1pgHmh4gROThxgoQKHOGd57TM6/Gl1sPq1bQHsGZ8dVCpIYirX/UVz5u/vucskEvcyz+czgplsswMP5cH9fQsfE9/kKjGVNh5WZICieWpVaAePVsXusJv891tRsqUT0QFdMhap5cIukWaApeKY/fm43t9fKBuTMWMDFZ5Je7LnVYQ5KL4BL++iU5sbOMfPRcDLfaN8yOZqe/41N0xtDntA5ni49RIiRxhP1gnCvJuoWpBzmD9jW7Ryubt2t/JZkDFCdv8k2JFYStF4C2tOVxuobUhSzduodEUs0LDBrtLPH/BqIbDRsTOG/Vr7bIKqtfUSDe6CUdXwW6INRW3HeLlOFuE1nDlDUhFhoBU9wNwJDFRY8AKH9MRKqaVmJNEr7Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(966005)(316002)(86362001)(36756003)(26005)(508600001)(8676002)(8936002)(66556008)(83380400001)(66946007)(5660300002)(6506007)(66476007)(6486002)(2906002)(38100700002)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzOTk/8/A+ZRPIKu/9aYfTrvoGLpVCl19XnZIHtGVfyDtto4AFcsTmwuHj7R?=
 =?us-ascii?Q?ejaz72cgoidpu5ptfToMXPTXpUaW7c6mTkjCp4aiTqVAxgDxVs3CQVETaead?=
 =?us-ascii?Q?o2eFaGJuvSTXhv5xj2d4QFk/MrAVuQtRQ4cpk/T06S1xt/l5EZ7vP+VOWWnp?=
 =?us-ascii?Q?JHlJNRCUcPGxPzzq6qij2iOjuhTbH2TaFFmSF/dHo+d02tED/DPFfAgQH9A1?=
 =?us-ascii?Q?FUwz6bXy5oUF6/D2Pz3rvk21pEzRdZ7jCdrI6MvxwsK/sz5xw2NpwNZoeskM?=
 =?us-ascii?Q?e2bl8O/58vR6FYsxJC+5JJ2GUdI8OgxNM2JggVq6w+5xkEazJJreBM526ody?=
 =?us-ascii?Q?qk2zlZ/d7JQEocrjeN2TcV2qkDTtywgCR92mZ7KeDLJg8zMZanlu5u6zBpy9?=
 =?us-ascii?Q?P3PlioKDpVcgZKEWxQtnWLF8b7KvKiEhWgHIatx+dkQsFUxA4JHKx/czT7TC?=
 =?us-ascii?Q?CIJBoU6envUuJ29t/LpIVM00sAMz3PjYVA2JhqRHDt7RV9QKH/XKDYvhLyiv?=
 =?us-ascii?Q?nHtQMM2Y+KKlAZvO+qLyIW51zJgowYWBHzZ29aRxYfvrV+KI4BLZj8deUm0F?=
 =?us-ascii?Q?Ep572vbipXu3uyvxVFZTEfL5IOB7rduGDpPAEGtV5vMqUmPb4stxFjXwPWqa?=
 =?us-ascii?Q?1SIrtkmb9S+UE9FrWkhbVvpp5qbfIhfU4O1J58hzkoCQzIVQYbMTOsertTmP?=
 =?us-ascii?Q?qB5eVj/umq2mQkQ7m5rnM/qmxEZJU8n6BtPcQKgyPubICT7M/bnIjC/cSRYF?=
 =?us-ascii?Q?owegTi7v3A6aiX2D7vfz90UGFU43k9dK2E6aQop8xEDu2nKluG4X6/WAgsIz?=
 =?us-ascii?Q?Kz271+Nx+BwtqdaFJjO7fcb4cAKV2WaQVZjQu0kngfRRUKHRzfYOt4HkDHvj?=
 =?us-ascii?Q?DGTPkScIx45SA0TDyLyq+9repLFI/WWyHciE6e+xlrcSprvGoR/hL85pMiCN?=
 =?us-ascii?Q?9DsU166WvtOhncuZPFeh5rbjOQ6S406XxXns7BX47jx7kQSBN+CCq+KUxri1?=
 =?us-ascii?Q?iTDG+UFByYsB9msoofDMqRAcdmVsD1eCq9J7xKeL1RLMyKJhyWs2XtpHiRH3?=
 =?us-ascii?Q?nOwCSxEpV4iU+qingzPumbZ3+siPyPm/hhqLHQtT/xyUJ7/dCq2CE7f3eE9b?=
 =?us-ascii?Q?t5v+82Xa0l2Qq8UG7BYwvewEehxhHVwX56DjpWrUXM6aEztW930RNZvkWCfH?=
 =?us-ascii?Q?OX5JZ1IREQEEpkqGxxT9fcVTpNlPSdIM9wI1BnfAAhTh4K2SudcGp2xAOPd0?=
 =?us-ascii?Q?fbwYyULttUiyilAWHQ/uIboV1/jRAKNodzyWXO9SOTpbTSJzx6LcwDdOD3Kt?=
 =?us-ascii?Q?6KNdiopJCkPF6QwTC1zsJCsL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f7061b-fc5e-4c1b-e0d3-08d97957e1e5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:01.1119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIbnsfIC2+xJppu44z8x28LgZdtp7PRDNfH6/crjAwPIEJEEO/Xqfh3BirhnvYUe5ZEE896BKCM4A8YRjD1qZedly7vseY0sBpxgMemFET8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 mlxlogscore=621 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-ORIG-GUID: W97TARUWu4r82xKml8FbYpYlmkvDzqKU
X-Proofpoint-GUID: W97TARUWu4r82xKml8FbYpYlmkvDzqKU
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

The following patches were made over linus's tree and also apply over
Jens's 5.15 io_ring branch and Michael's vhost branch.

The patchset allows the vhost layer to do a copy_process on the thread
that does the VHOST_SET_OWNER ioctl like how io_uring does a copy_process
against its userspace app (Jens, the patches make create_io_thread more
generic so that's why you are cc'd). This allows the vhost layer's worker
threads to inherit cgroups, namespaces, address space, etc and this worker
thread will also be accounted for against that owner/parent process's
RLIMIT_NPROC limit.

Here is a more detailed problem description:

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



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
