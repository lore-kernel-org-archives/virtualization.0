Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1106C433FE
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCB861166
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BCB861166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58A5483C23;
	Mon,  4 Oct 2021 19:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tRx_oYXPyJMg; Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5252B83942;
	Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BAD7C0011;
	Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF8DC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C094405AE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="VYM0zmA8";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Sc85AAkr"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mn4k6m-rGFhI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F5CD405AC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:12 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194IHEfa019244; 
 Mon, 4 Oct 2021 19:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=KO6CaUzPzB31L0dz2wNJJOoekdRdKyntNge3pR0sQW0=;
 b=VYM0zmA8xs0gjCcYCYgl42xv4NqsNKav9zEdTUoVpXl7QxAlBAjNnF1F5uFNdHRmcg0i
 kokRuofuzONt6t7QXPBWH60MkpbDWgmBQcn9XYxxCxaztzUl9HIyd32F7m9p705k4bFY
 V1CStuT+fizzi+0bjugVFgjtPLWFyAmZTVZq5NVQEBtCET248UMg+TkxCuUSb9T7hR6J
 HOI8oaJqSgD33b/B1dsmN+qeYUETfAgZyupjg9o+ZP6iT5UteHReqfDMvh8unnE/zdeu
 7JPO5wiQj00YK+XBzI4aQmhQqd90Gy3IcaU7TpoVctRoxMVbozsUvYFGOmuqbnuT1TUC Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5aatd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAcLx132330;
 Mon, 4 Oct 2021 19:21:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by userp3020.oracle.com with ESMTP id 3bf16rwfhc-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNM69O/jOBhhOnq6Jd/ArtCWaAYkn8R+CbWWg9g7x+t3iTTDX/1MOBQd5ywSOVmo8/JKVYATvoXi7jWqv7I6HuEHTggATXtQospQ/7J0i3Shknjcd8pz5yyulJ+wedL2Hx6qfyxN2vfu1C3PxA5mmXCRp0jpyg5FWnGEqow05iTwUjG0WPOb3iSXdAA0kai/BDGyWIG5s7/2dY3fr+kRwoqJQ3BoTB9joqCBkQEmVJrrPjY1KgHtV8kHqqwfBrGtyZkM//nnrYQsJw+JMcmhVcfGCCNZ/ubYASprefz+jANR9FdUUvA0KU2b2qmAVgB0aAl6DrpP4SQPeXJpKWO4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO6CaUzPzB31L0dz2wNJJOoekdRdKyntNge3pR0sQW0=;
 b=XfQxoqHda2BrJLW6vh3dMtSY1FQqnt7AmD22B+mWA2MEMqa6cxihoXZXz2mfckzecUEOiZ+k3FA80m7FIx+3C2mnV0zfB5W0BLESa85ibzuO9xTQNBWoPSx21efOmhAGuuOeuchK7FX/+t1JPYAPaz+XCx80TdJyssEHThWPkPvpZ+YsF38H5M/6TpVrS99LstkA7oNU/cHyDtvJy90CTFm4ibc2cPULnzT6fIhvqpm1nWKznjYV/BvJnt++iBDdZJ+a/cle6v36gAT3kO7eZQ1wtBFlpRLMy+cwG1THxt8hYFQl+cBBLfBNPnKLUaSGZCSocEZk+q+vfUlSCM+mkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO6CaUzPzB31L0dz2wNJJOoekdRdKyntNge3pR0sQW0=;
 b=Sc85AAkrrWrUtZBR/b604jKVQ1tODFeMnl4b02spapRs6VcijJz2i+RXpnggUm+oognGr6y6gk6pHMwDflSvve0XzdkMDR3Sewujoh2L2i1eNVFynsTJsG5vpWrYGkTD4vsWa2tuxbN1NnDWCZgFjyAOIPiKIAo1UsZhzxh2ja0=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB3307.namprd10.prod.outlook.com (2603:10b6:5:1a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Mon, 4 Oct 2021 19:21:39 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:39 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/9] fork: move PF_IO_WORKER's kernel frame setup to new
 flag
Date: Mon,  4 Oct 2021 14:21:22 -0500
Message-Id: <20211004192128.381453-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004192128.381453-1-michael.christie@oracle.com>
References: <20211004192128.381453-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:4:4b::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 514b7695-b05a-428e-75aa-08d9876c3087
X-MS-TrafficTypeDiagnostic: DM6PR10MB3307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3307CC58A41833222934C4A5F1AE9@DM6PR10MB3307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9Gu9jBXJv7kAIAY8aOcHUehvHVOP+uJJrVm/pGTKItws6j3x1BQdOxH3Tb7R+rT7rRPh65R+fEppYmU0pnFADPtbzYEV15+CbGgWpoT1XC5e5JMtdoL7lf1GyLF+omzH14zqKKmYT7jC9B2O5pam9Xd5jci+YQih/cxwT4a5Ctdbo/cSOeP+0XJJVM5sQ91BeALL2X0n0RdPopKJaIHuXd5FVKzsIfryu51+kqqub1/rCfu9vZ+rX+hFkDLj0dlj8pmTevAzr6vNZfqg1Ru0U/zl4gZ9/aT2sgsq73lXb3WFMgjDTR64qvCB9q3yvIvbepto1q2IoDo62FAtvdvH679460r+MiMyYoG3xyl00Xmm96B4Q68mGvETeuuFPksr0kAoEfhGwQGdSrapatlNeqokGLkxGSIlsXPDfEIMWyTd5tO7JPezmzA6QMH/DAf6awIt5vIRkQMaH+fV6mf3ZrM/bivxRVviYHH7oBe9sHLDuAkp4fI+qkd4rYWeXxSFZ4kqdPQNxWOQbYqRckqyA3zguINsUD/zUxGjBiASpTQf9NEp6dDOUncbh46T1RwXzC6BEYMdUL+Ld4lNcp4zGTPbo+DHdTCCt+GgfLL9oo4PCK+j9bir4lYidmUylbhXot/PSuGIsbkrdVfqa+q2wqJ+9NZmiUHeD1BNBivOOpYOfZRu0gTGJFzDYVMPj44RI4BK6b2HKNlU+EoGeCyJLEr5IQZq29KW3+FtTRdHLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(66476007)(66556008)(36756003)(1076003)(107886003)(6512007)(52116002)(6506007)(83380400001)(2906002)(8676002)(8936002)(6486002)(26005)(6666004)(186003)(5660300002)(4326008)(2616005)(7416002)(921005)(508600001)(316002)(30864003)(956004)(86362001)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E4Kh+fhWO3pjwezc10dy8k3ylplQ+hTCzA2zAp9/KQBuN8mTDlZ+vj5wt2qP?=
 =?us-ascii?Q?jcUXdVY0yjhbTr/CJOZhr9+J7q8uUIKLHL/8IZs52Dmgv4l4LE8ZUkek78kA?=
 =?us-ascii?Q?5+ZKg1hFBrTwNrPOgjIAAq3da29jHFOIDWobuIl/dDgnmxcsMM5bjIN7hKLo?=
 =?us-ascii?Q?7NkXIWHnatxlAyTqaZfbsAG6V667ey4UkU6uVVfr0LIzuifXl/HoeFpaFZ91?=
 =?us-ascii?Q?5b1NOI428l8Jj0Wc2XAXXk5BxhjS2vcRnxhIQHMcT5LJVNshf21taI7hWTuy?=
 =?us-ascii?Q?+3Xf4D2+bC1NZW2EORbeTnmcMrVA25k/QO3hCvFSheIdnem+vwS4IMNYc8uG?=
 =?us-ascii?Q?IcvNe1bv8nomU98AVfkjS68QZvOcyNhLEDohPrJcIgZVftsAzoDmAp4bNruv?=
 =?us-ascii?Q?JavhbrqajULqykUbswp2ZxSKoBtTVveSMCHRQfwyQeamP+Cplrz9i86CNPEM?=
 =?us-ascii?Q?KVZonAa9bip5Vh3WHbzSBnGhE+NiJNq/EJk8lTUZ4HL5nEckC0q/l4LLuEsB?=
 =?us-ascii?Q?VrGn+9+/596whBChuy1nywU6GuUbk/xhoM1nWuUYLS8rHgXfJc6qWibS0yau?=
 =?us-ascii?Q?/T42Xuh0pklc8iOkhjDYGWYHwyo0QOyR2LzqyfQ/SAhenUVQC4vA0bNn4Dir?=
 =?us-ascii?Q?LZQEa9JkejZS0zVciOVIe9Brcd29KCuAF99J5Ot5nZdLuj8qPQI8bCdu2KXL?=
 =?us-ascii?Q?06HPtY+8ObALWKtR3hd7bG0i4o9GuQQBduat+jkwcBJYB4bWPFT4SyaRpb86?=
 =?us-ascii?Q?y9MWht+sbhGIjgW3qeszOm/0Mn1LDrpQXOFcte5ZMemBnb+vOKz+OL4aesAB?=
 =?us-ascii?Q?/E4PkposRhZ12Iiynrkp74eYvo85y0PxydQVxYq8xXw5KUEqdDv1YsoVLUuC?=
 =?us-ascii?Q?zkNTuHertBpcYGZT20/8xRkVaovUNMMRx1bCORbkl/RSR06tJ6hvbWjBc2Dc?=
 =?us-ascii?Q?Nl0JrDmLRQav/0Rdfj/noxnt7PA7IAV1iZc5UXrCJ6KTLKgqt7p47FE95nUI?=
 =?us-ascii?Q?AdNQnsmT9phd0b1H/TNKofaHTJc6VgC5E+Hep5jDx7e9j1ePHfH3HMg+444O?=
 =?us-ascii?Q?dJXQHOSxKazYeGdQ8dA2+IIOYXZVqrWY5ZcF0oRv9fx+xJ2Vbifafr+9vnjH?=
 =?us-ascii?Q?bpNi/fcUL+dRQyCPN2wMGktUJQAOvOqZIJtXiqVyOifW9sQ1MLLVuVIV3FLJ?=
 =?us-ascii?Q?wYQ5TB/U5PNWt4/KrVEfdM83izO27ExLXkb1db21O/g3r8DJoT3iQ519aWOc?=
 =?us-ascii?Q?xmiwN2M4I1aMeVAtcc3mxgeBLHPoHr6ExJ0LhG7ePnVuU3DpK4NRNFSOhB6t?=
 =?us-ascii?Q?0eAssYXWrj91gU77LnL7Qsbl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514b7695-b05a-428e-75aa-08d9876c3087
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:39.1366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMADzyVTR+WzFjT8hHzfIAGU0Eat08bDueWdedjgb8DicnDkD+0K3rxL7qIU+wK1bR8JNQo2KVZFPIXJtWT9z097R9L67PH8fnOR3kFaDz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040131
X-Proofpoint-ORIG-GUID: 06W46Hc9Mh5kjzZT_gg8Spc1prIPwI4q
X-Proofpoint-GUID: 06W46Hc9Mh5kjzZT_gg8Spc1prIPwI4q
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

The vhost worker threads need the same frame setup as io_uring's worker
threads, but handle signals differently and do not need the same
scheduling behavior. This patch separate's the frame setup parts of
PF_IO_WORKER into a kernel_clone_args flag, KERN_WORKER_USER.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/alpha/kernel/process.c      | 3 ++-
 arch/arc/kernel/process.c        | 3 ++-
 arch/arm/kernel/process.c        | 3 ++-
 arch/arm64/kernel/process.c      | 3 ++-
 arch/csky/kernel/process.c       | 3 ++-
 arch/h8300/kernel/process.c      | 3 ++-
 arch/hexagon/kernel/process.c    | 3 ++-
 arch/ia64/kernel/process.c       | 3 ++-
 arch/m68k/kernel/process.c       | 3 ++-
 arch/microblaze/kernel/process.c | 3 ++-
 arch/mips/kernel/process.c       | 3 ++-
 arch/nds32/kernel/process.c      | 3 ++-
 arch/nios2/kernel/process.c      | 3 ++-
 arch/openrisc/kernel/process.c   | 3 ++-
 arch/parisc/kernel/process.c     | 3 ++-
 arch/powerpc/kernel/process.c    | 3 ++-
 arch/riscv/kernel/process.c      | 3 ++-
 arch/s390/kernel/process.c       | 3 ++-
 arch/sh/kernel/process_32.c      | 3 ++-
 arch/sparc/kernel/process_32.c   | 3 ++-
 arch/sparc/kernel/process_64.c   | 3 ++-
 arch/um/kernel/process.c         | 3 ++-
 arch/x86/kernel/process.c        | 4 ++--
 arch/xtensa/kernel/process.c     | 3 ++-
 include/linux/sched/task.h       | 1 +
 kernel/fork.c                    | 2 +-
 26 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 6005b0dfe7e2..e9b2dde444f4 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -249,7 +249,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childti->pcb.ksp = (unsigned long) childstack;
 	childti->pcb.flags = 1;	/* set FEN, clear everything else */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		/* kernel thread */
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index 4e307e5b5205..2caa80fb9e9c 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -191,7 +191,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	childksp[0] = 0;			/* fp */
 	childksp[1] = (unsigned long)ret_from_fork; /* blink */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(c_regs, 0, sizeof(struct pt_regs));
 
 		c_callee->r13 = kthread_arg;
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 07ae4444b6ab..9f41435d78d9 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -248,7 +248,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	thread->cpu_domain = get_domain();
 #endif
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER)))) {
 		*childregs = *current_pt_regs();
 		childregs->ARM_r0 = 0;
 		if (stack_start)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7979ec253c29..d149de03bd50 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -334,7 +334,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	ptrauth_thread_init_kernel(p);
 
-	if (likely(!(p->flags & (PF_KTHREAD | PF_IO_WORKER)))) {
+	if (likely(!((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER)))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
 
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f38b668515ae..10debf43375e 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -50,7 +50,8 @@ int copy_thread(unsigned long clone_flags,
 	/* setup thread.sp for switch_to !!! */
 	p->thread.sp = (unsigned long)childstack;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childstack->r15 = (unsigned long) ret_from_kernel_thread;
 		childstack->r10 = kthread_arg;
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 9a8f6c033ad1..e0d69c3afa2a 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -113,7 +113,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	childregs = (struct pt_regs *) (THREAD_SIZE + task_stack_page(p)) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->retpc = (unsigned long) ret_from_kernel_thread;
 		childregs->er4 = topstk; /* arg */
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 664367be55e5..9ea473567a5c 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -73,7 +73,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 						    sizeof(*ss));
 	ss->lr = (unsigned long)ret_from_fork;
 	p->thread.switch_sp = ss;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
 		ss->r24 = usp;
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index a69cc33b5e32..d7c47ea12703 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -339,7 +339,8 @@ copy_thread(unsigned long clone_flags, unsigned long user_stack_base,
 
 	ia64_drop_fpu(p);	/* don't pick up stale state from a CPU's fph */
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		if (unlikely(!user_stack_base)) {
 			/* fork_idle() called us */
 			return 0;
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 7587291793fb..a842e6c7bef2 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -157,7 +157,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	 */
 	p->thread.fc = USER_DATA;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		/* kernel thread */
 		memset(frame, 0, sizeof(struct fork_frame));
 		frame->regs.sr = PS_S;
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index b8eb544e1fd6..ba1a45842a70 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -59,7 +59,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 	struct thread_info *ti = task_thread_info(p);
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		/* if we're creating a new kernel thread then just zeroing all
 		 * the registers. That's OK for a brand new thread.*/
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index d494e1d76e71..b592d1bfab09 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -120,7 +120,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/*  Put the stack after the struct pt_regs.  */
 	childksp = (unsigned long) childregs;
 	p->thread.cp0_status = (read_c0_status() & ~(ST0_CU2|ST0_CU1)) | ST0_KERNEL_CUMASK;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		/* kernel thread */
 		unsigned long status = p->thread.cp0_status;
 		memset(childregs, 0, sizeof(struct pt_regs));
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 1ca8900f9d07..8ec5b725842b 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -157,7 +157,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* kernel thread fn */
 		p->thread.cpu_context.r6 = stack_start;
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index b49dc6500118..e22b83b64769 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -109,7 +109,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct switch_stack *childstack =
 		((struct switch_stack *)childregs) - 1;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(childstack, 0,
 			sizeof(struct switch_stack) + sizeof(struct pt_regs));
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 7b356a9a8dc7..684ef1f0999c 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -173,7 +173,8 @@ copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *)sp;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(kregs, 0, sizeof(struct pt_regs));
 		kregs->gpr[20] = usp; /* fn, kernel thread */
 		kregs->gpr[22] = arg;
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index d9555ccf1e9c..1c955e6bad83 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -198,7 +198,8 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	extern void * const ret_from_kernel_thread;
 	extern void * const child_return;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		/* kernel thread */
 		memset(cregs, 0, sizeof(struct pt_regs));
 		if (!usp) /* idle thread */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d2f2301b0ad1..097f13b43a8f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1700,7 +1700,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	/* Copy registers */
 	sp -= sizeof(struct pt_regs);
 	childregs = (struct pt_regs *) sp;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		/* kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gpr[1] = sp + sizeof(struct pt_regs);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 3d0e6390f34c..39bb4a79be15 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -125,7 +125,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 	struct pt_regs *childregs = task_pt_regs(p);
 
 	/* p->thread holds context to be restored by __switch_to() */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->gp = gp_in_global;
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 01b969bb868e..29ba92911340 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -131,7 +131,8 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	frame->sf.gprs[9] = (unsigned long)frame;
 
 	/* Store access registers to kernel stack of new process. */
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		/* kernel thread */
 		memset(&frame->childregs, 0, sizeof(struct pt_regs));
 		frame->childregs.psw.mask = PSW_KERNEL_BITS | PSW_MASK_DAT |
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index d199805552c0..8cbd7404df40 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -114,7 +114,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp, unsigned long arg,
 
 	childregs = task_pt_regs(p);
 	p->thread.sp = (unsigned long) childregs;
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
 		childregs->regs[4] = arg;
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 6e04cfc64b99..2522283a63ac 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -296,7 +296,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	ti->ksp = (unsigned long) new_stack;
 	p->thread.kregs = childregs;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		extern int nwindows;
 		unsigned long psr;
 		memset(new_stack, 0, STACKFRAME_SZ + TRACEREG_SZ);
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index b339eaa1f890..a157474c970f 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -594,7 +594,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 				       sizeof(struct sparc_stackf));
 	t->fpsaved[0] = 0;
 
-	if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (unlikely((p->flags & PF_KTHREAD) ||
+		     (worker_flags & KERN_WORKER_USER))) {
 		memset(child_trap_frame, 0, child_stack_sz);
 		__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
 			(current_pt_regs()->tstate + 1) & TSTATE_CWP;
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 0815a43b9f4a..28e5c9f67436 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -158,7 +158,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		u32 worker_flags)
 {
 	void (*handler)(void);
-	int kthread = current->flags & (PF_KTHREAD | PF_IO_WORKER);
+	int kthread = (current->flags & PF_KTHREAD) ||
+		      (worker_flags & KERN_WORKER_USER);
 	int ret = 0;
 
 	p->thread = (struct thread_struct) INIT_THREAD;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 20d9bab61b14..a904f5524d73 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -178,9 +178,9 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	task_user_gs(p) = get_user_gs(current_pt_regs());
 #endif
 
-	if (unlikely(p->flags & PF_IO_WORKER)) {
+	if (unlikely(worker_flags & KERN_WORKER_USER)) {
 		/*
-		 * An IO thread is a user space thread, but it doesn't
+		 * A user worker thread is a user space thread, but it doesn't
 		 * return to ret_after_fork().
 		 *
 		 * In order to indicate that to tools like gdb,
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index a0ad9f0cc0cf..0af51e94c8dc 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -217,7 +217,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp_thread_fn,
 
 	p->thread.sp = (unsigned long)childregs;
 
-	if (!(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	if (!((p->flags & PF_KTHREAD) ||
+	      (worker_flags & KERN_WORKER_USER))) {
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long usp = usp_thread_fn ?
 			usp_thread_fn : regs->areg[1];
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ffc7c6a384ad..cf7c9fffc839 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -19,6 +19,7 @@ struct css_set;
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
 #define KERN_WORKER_IO		BIT(0)
+#define KERN_WORKER_USER	BIT(1)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 3c3624786e4d..4b0e8257993b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2527,7 +2527,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.worker_flags	= KERN_WORKER_IO,
+		.worker_flags	= KERN_WORKER_IO | KERN_WORKER_USER,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
