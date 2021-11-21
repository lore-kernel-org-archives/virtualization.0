Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3DBC4332F
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFAAD80F48;
	Sun, 21 Nov 2021 17:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZpnJAYXoTw4y; Sun, 21 Nov 2021 17:50:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2C6580FF8;
	Sun, 21 Nov 2021 17:50:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB8CFC0033;
	Sun, 21 Nov 2021 17:50:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68F2BC0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38E3E401DB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Y+U3VZ4n";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="T/lou3sG"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hFko16LRRhoQ
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B7C840225
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALFtrOI000555; 
 Sun, 21 Nov 2021 17:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=Y+U3VZ4ndrPrNwYl77giU7NNDQqSa8rm0IzqzpACd0Ru36HtcabcfIkEtLAvXKe347h9
 wygWnBONJ9L1Qx0u5GRRaZXdRdHngbJi898Y84+nMIbbEvzUq9VlcEtZy0RW8hWr2kMB
 BG504qZG9dUF1Cuv0PeFEY9nUgsYEzjbjUOn61eQgyoADktd4muYXgrgBzG7wtdvi3wx
 BK8gEEdVr4K8lCEpeycKbRslzQ8S7QU68lYbfNEhWaWlcYsPHWUhHIzgJyen4WH0rqFQ
 np8daucPYz2xgZY50nd4cymv9Ol2C1u4kPsW/q35D8jmhyeRtspZB620BNTpb7GfElj+ NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cermsmgg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkuUG173690;
 Sun, 21 Nov 2021 17:49:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
 by aserp3020.oracle.com with ESMTP id 3ceru2jhv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAx6uwdumkNhN/LPzkfNiSgURv5FmHvVrGjD+7xeE14YjGHqYwTgqL3KFeUVBvhHnQo1kAC175VeMr2Uck6VVaBay8w5fHwXFM0sb2OM64401UmupSPT4vQfdelcRj3j2ecvunY2JKGSn3Fwc39IePOUehcQKakeu4nqTHV3D8SB1eTmkhvxsY+gA4jKM+3Xl8oF7eKZ8fqVQXRXMsv2x0ZKdrOR7ziSr6MjYIpfQQYK+JDkkC69WfI/vjclU1HzK0lUWyHVUzFCkT7PUd6Beg2aMmB9cJD+S5h4YyCv/Aye/YjiGvLM8gwuUGOSW2WWH1Sdon8uFXCXEgHIkCHfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=gQEwKG9O2UfDVwsjdSRjJFDnXtn8o9g31AJ6lq4uAfP7ZIKPfN8ErgNEfmg8NxIGELXIBEFMu6wllR8uDwiJmKMgAp930K91SKzVnbZZ8OVegwPnDBtYTL2JYGMfQoVnlG/LsBdJlqBl+0wSevbF+JVXZD3aEixiICQxTbur0G+JSQWYS5K+yzSazS5i7MyookBf8kQL7hJKjaQjZsU8pGX8G+Dt5TqB30AHCuEC9LE0bPJQaFAzJqMfC4cb9ohWa5VibEQ08BYK4xbCZijCMGDL8+nV6TMQBKu4msjAqIJ2QSwn2i2dUjQM1sLkAj6TZIteEXbLLqmbP4+uL2q1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=T/lou3sG+W+c3Oztt+Lqc61C2l2KX2rgruDOJt7fUXyya9m+SqlfwpfCktcQAbJ354uLqWQDywl/xIFGeIXw5cSZtdVjlp9VWQfM8CC8zCiVbFmKXJZr6X21OjqX8Uc6k7YxWYk088XrosGENT/DM5bJ8NqBdM9oYKSl0D39/Jw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:51 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:51 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 09/10] vhost: move worker thread fields to new struct
Date: Sun, 21 Nov 2021 11:49:29 -0600
Message-Id: <20211121174930.6690-10-michael.christie@oracle.com>
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
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dce21d8-7912-41aa-a523-08d9ad17513f
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5055904C88A101BBCD8DB19EF19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCkqWiywO7cT5sot0frglrsU+Eg6kQr+RtW9AcHVnfcTQWrYVNrm7FWJHrtZnMEgYzEjXiY22lCJLqr9nVJGD+x88+jrH+nQy57NDOfYVTMiMN0vnEVPc7Z3JZ1tE9QyVe7b4WOeWN6+A3AQ3zmD2GwYYX7cbvHTJfZ4TEnAGN1rtKz4PbU7jLt6iWp0E8R9fIAayjBY9RmIRVjE1oXsv7NvkmbENIIiRbqPQHluM4uJQhzWr/f/bvN1j3axz6c9hkWqzZYuvpF71ESd04xbh6JWIW5c2V2ZZwAmGSEwam9tCDVt6L5NuKgBnTx0M5an13jO/6bq3d7CAvf2YAsTbNWexscrifbRlpBQFFmP3jA7b7g27Y4r/ChN54LPp9GB1NT6rm0DMM1b86x6p5PJ8OV9sl2g3oMlVZqYDUUwd9HSHBZ2ExtqoPsNMY8ePNURqTQRPGFqYg7JXEBV+mWrVx6ypaEbHCMn2S3mDRM+zPggCQEM/3rasC1vSdVMrgVKwoQ+9YoW9yof8mKrK78X9ryuYyaaedZgseqRYOT4UvD3h5veWHN6jACjoywkwVSfnhSNOSOLiemzeBX0zInUJZ94ZO1vUZNgITd7dM18pUsBK+M3pK7MHbGUjjwh1ttI7Dxo371OjC/svq0fbKlQW4vOgsa3cQ5WOEf5Kz7S4CaSQaUKD23wWPiWOUUiisu6g8WuETpK2IqBPpfc294dsZQMZkkcW8ivPvkOJKqi9ts=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(921005)(54906003)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8rpQZKURbuoOUhTPoj1GvR9tzbA6OV1ZJx+OlJ1wjeVssqmvHJfrWSBrDvAb?=
 =?us-ascii?Q?rTHED0KCJ8SHe2JQdw6yy8ZDoAbGM7oo5sdhEa63OIMeihn2wdhy4FgdSiXz?=
 =?us-ascii?Q?hiJ6J6R8dEfGJ+Pid2X5/icnWG/EsalTcMJqQh4+8lVDl/Rhv3TjoVO7TO4F?=
 =?us-ascii?Q?IM/anmYSrEB7lG5N7tvdKIY/k1THvlC3TvTt4fGOc1LL4FbrVdoAwQ5Sdyu4?=
 =?us-ascii?Q?2VgB09BkkQkRMBHHHmVK5v42Mkfb6sgWiajwen/eRgU00P+h+zDRg0uDCxRV?=
 =?us-ascii?Q?iu3SoMV3SiNQASWTsQz9/H4DoJb/QYyh6fSTPfgDUb0Wd213KsdUyjBKWioI?=
 =?us-ascii?Q?EA0jabhqXOmGfOBCR3A+Mj4pxBg50PaPmosqxwLumVzJNHcFt2YLUiJMz79e?=
 =?us-ascii?Q?5kRwBJeR0nzFK6aOlwWPIx1VZ114Ux1uZOUDBIQH6YJIGGrcT2umlObdauMO?=
 =?us-ascii?Q?P2YX6Gj5VGDS6WPDPacDWaa6/5OnduorLpGKUFOCULelmZwi96NQ7aEZYh3s?=
 =?us-ascii?Q?2zuFcVRzeJUySco5zR/oAv6X6u07W2YL6HGNsXwyUKJTIOVK42LoVrNKr1WV?=
 =?us-ascii?Q?U35EY+vQcOcURNLUDIyURMqhC29FYHoz2udyw+hfYmHMrkpCIAwJ34kTCCEU?=
 =?us-ascii?Q?bdgKaEtV2Fx/uBGTLH14hAnjIaZIvGnBHMawi+HW2WSttgdjDvZ41LFzCwvz?=
 =?us-ascii?Q?U2L98H5PiyuP9cVoR0bpdT2n7/sCb2PTbXQDY4ITkEnwgrtxIqoyyl7MxB6v?=
 =?us-ascii?Q?faHCy3eAk7dNrcm/HjF+UdQu7+pCyUHbnMbS88UhPT8U4C4SZutJtFPGDNa2?=
 =?us-ascii?Q?SKMEG+vLTBQiXCpYjTvtaGGg4eyF3UKdliDz8SBpafORSAuPHZZCqIDi9ciG?=
 =?us-ascii?Q?vVU4NdozzocNS81Q6Spy3G5WEOGqtuaVYpOrmYwLzE/wgOKp4IssoFTwy7n/?=
 =?us-ascii?Q?OwX65/vwZqpogo0SgxtbOQIKbRXW5kC3GPj8DewMTjZJMYSQvzIL92e1/3zD?=
 =?us-ascii?Q?AFmXt0C7Opec8oRRZIZeCK16rjZD/uE8H1YrFt/djDf5WeGqcPPhS1NHrQ2p?=
 =?us-ascii?Q?MER0BJ5RL0RivGbbI5Xi3jY6qxk4YCE0LF2q1qMtBJrjdADL2/7AOYj/Svgh?=
 =?us-ascii?Q?uELeVQR9I6xYYgzWF71uGv1aZbDS3y9l5DIX1wtwkOoNgPHmWC9ovIwjaVvK?=
 =?us-ascii?Q?bRIUm1yW5lCo6PcMicrwVK9QfjM07eBDzxaXeusMj0mXMR2TP1hs1PJYbbrP?=
 =?us-ascii?Q?a+pUkY1QWIYRTgPWRRgMPnQWJmsFN05UqMz2ZGdI1zTncIFABtC9ig1Mzrh6?=
 =?us-ascii?Q?4bk/BkU0NF8UiNPE4eR+4vWLIYUFEmZu4as5M41cqL7EMNOdCo6/AYKOVuD8?=
 =?us-ascii?Q?ibbEDiDQDLu40unMT6c4Gu2/IxfsmzjbocmM2uoh2jdY/LKPUP4Y7XNdNsH1?=
 =?us-ascii?Q?uOgWGpHS5WWpJR3YCPCpDdkiKnvBVJ2tyoTgaWv6nCWW/pHig7Kmgt9S+KsF?=
 =?us-ascii?Q?9piuzXi8UhoJYjakce3H+n5Ss7mFgEnrN4oWhKEtx+NSPnd23b3jTsqhxOkg?=
 =?us-ascii?Q?DwCVSCh5LzDwe2SGpO1qdfeg6I8XI7OSPTq1yGskTFCFSLbu2JuuCT9evRka?=
 =?us-ascii?Q?FFXgalMKoYYHVX4nkHQKWbVoLQ+OwmhUJb6QxChD6LckS+Kf4HMYSnRCCKL0?=
 =?us-ascii?Q?pc7lNg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dce21d8-7912-41aa-a523-08d9ad17513f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:50.9953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BL2GvSJmm3NI8VDW/NYbj4FMO36G4WnhnHvMmKuTm9yUimqCo0ZOZldWyTrQhamb2zRC9e5an5Lywcwzq8k759nxATfxHZK3MoG4Zggq10c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-GUID: lrBnqrT98DvN2Ob9Oe_P2qg-l6jurr-Y
X-Proofpoint-ORIG-GUID: lrBnqrT98DvN2Ob9Oe_P2qg-l6jurr-Y
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

This is just a prep patch. It moves the worker related fields to a new
vhost_worker struct and moves the code around to create some helpers that
will be used in the next patch.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h | 11 +++--
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..c9a1f706989c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -263,8 +263,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->work_list);
-		wake_up_process(dev->worker);
+		llist_add(&work->node, &dev->worker->work_list);
+		wake_up_process(dev->worker->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -343,7 +343,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -358,7 +359,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -368,7 +369,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -487,7 +488,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -579,10 +579,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker = dev->worker;
+
+	if (!worker)
+		return;
+
+	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static int vhost_worker_create(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return 0;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	dev->worker = NULL;
+	return ret;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	struct task_struct *worker;
 	int err;
 
 	/* Is there an owner already? */
@@ -593,36 +643,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
-	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
-		if (IS_ERR(worker)) {
-			err = PTR_ERR(worker);
-			goto err_worker;
-		}
-
-		dev->worker = worker;
-		wake_up_process(worker); /* avoid contributing to loadavg */
-
-		err = vhost_attach_cgroups(dev);
+		err = vhost_worker_create(dev);
 		if (err)
-			goto err_cgroup;
+			goto err_worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
-		goto err_cgroup;
+		goto err_iovecs;
 
 	return 0;
-err_cgroup:
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-	}
+err_iovecs:
+	vhost_worker_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
-	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -712,12 +747,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	WARN_ON(!llist_empty(&dev->work_list));
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-		dev->kcov_handle = 0;
-	}
+	vhost_worker_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 638bb640d6b4..102ce25e4e13 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,13 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+	u64			kcov_handle;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -148,8 +155,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -159,7 +165,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
