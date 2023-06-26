Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5044EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CC9780C2D;
	Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CC9780C2D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=vr0+8Euh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=PagU6Hai
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4yAzTX4MeB7; Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4BF8581E5B;
	Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BF8581E5B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83047C008F;
	Mon, 26 Jun 2023 23:23:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97223C0037
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B0EF81773
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B0EF81773
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivtq3B2xugLW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7239381DF7
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7239381DF7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QMiS45001871; Mon, 26 Jun 2023 23:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ovFIYMT2WJIGwhEkCd9VDPaYfKcglUnMeGqjERUwTWw=;
 b=vr0+8Euh9QVWB7B4YWGj6ZB3yUf2ZGKyA/FPJDuzL3+q0rZObsDZifgW27pIsqlehDAG
 mmaSCDzkCqNPgV3B6wsuAPjbdWLVvSz+3QaqkwmtVzx034+p2xmRDdkE7miaPHBtbADJ
 yJDV65I5a1hYgovJHHeyOVo/1FPyNajiMt7vK83xLvQMzyfN7BpeJlB1Q4A/Fg0+p74F
 m/+TcHuO2ZnS0a8YG8x/fSzAjqEbkr9JbPReqaf/2oKJ4BnPJRK5G7+WW59IEhu4gj+d
 1gqQkFbgW/Z5nRZpztHxJDNL19shvCQUmi0j9KPqj8ZHdvVf5NBBMl2Z2+Aggp5pPV+k Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca3p1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:23 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QLDFD0018832; Mon, 26 Jun 2023 23:23:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3ywgs-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDeLH0lMDF/jNBI/7oppNl/g3Em9NBt/b0f5ANcpPEP2bM0QTU9eW5sln9ytPQj+ebIRA0ggsXcECV9YEStiocmX+XGEMG01cguWKYXgWdNCt/owVOYYjAzvVlfA7RW3s1U+oPmucYxjF6aRowKCeoTukU+5KnZUSdH1Apx71jKkAbmh+lfup8+KCU/1LO1B0Ha7xuWOb6D0ASL9UOG4bVDNuT/V9euOlcdq3QMsaDWyDt5NsaGbn1cMLFklZWQWm2PxXn/Dyri78y1V+JdFbDDewCh1CH0Y3kbzJehqD0ui7okmjwEp607pUvL+NPpxX9s9jiFxITU40JrEq8CXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovFIYMT2WJIGwhEkCd9VDPaYfKcglUnMeGqjERUwTWw=;
 b=VyQ8GPWWrJb5RL/qVpq5x2lphGYeudLc0wxkvqzcsdcKGEb0clT07WxkTygyw/MYnrZt6vxrVugHdDbEhiU0ArT63deDh6Lek6khVHnEyndIS3RacaIg2cWTVPCazRIMgkib6QUdVTROyd3BoxiZh89R10cvU+9VQsRIFoGUJ7Xv1tZzcia5PORmwXhZaPbLHeV1dCTQ4X3vBNQ0LaVeTsEddVS/NEaYIiJcNsACqtbESpXfBSeEK1Sejqi8814xLywUp6t3u75Wa/vK3sgqorTHlIflD+AQrkBMw34DcS8C3158Xa12ZeZA6NXspGP+F0UgIul0Nv+3jgB/k9Imvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovFIYMT2WJIGwhEkCd9VDPaYfKcglUnMeGqjERUwTWw=;
 b=PagU6HaiYocgQ8YTMDOpMQ+i9NDkEaqbiEcnZDquCsqf9Up60/X3FWBNza+1kTbrcQLMIVS0KqivsvP/CR3CvITU4lysBlrp5Kib6ha7adX4DJIo7Wkdo82kLa/4JsbX4PI7qhFY0+6nvzXHfCk6OkBFVwG5wByvz6TffGp3lgw=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:20 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:19 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 06/17] vhost: take worker or vq for flushing
Date: Mon, 26 Jun 2023 18:22:56 -0500
Message-Id: <20230626232307.97930-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::13) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f5c52a-0dbc-41a8-308e-08db769c53ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQfLXrKTqF9Sx4VOsfQCYY9Kt9cIjxGIVN0JhohpzYk/ItHrMMbJjKHsXzrRR3ERoYqj8fWLNAn6cVEqtfTFKfZydnWFwrdZ8u/K6OEhMhS/VNkS79rUJvsGvXPox0Dj8sfa8C2AgJNZ8gBNEVXZAUD/l87u0BbGmVpxQlSirC1aoKzD41Afl6QSUtrdPQSipHWR9DebfrgdiqvKH3QkBSZwgKzi6Lmb4y07tcWWYppDUcd0zc4kwTdAwA/imowi+OgLrQyrMIdzgGXVd4HGsWIYcas/LxSN4aDxubK9lpX4euNoTcwq5PJuKucisPFKderCUWcRrcHpOyqzL+80h4NGffdzgsb6O8Hp6wlMoukbzz1h/eeohhV7aDgURckcy8oS7GuHz9WH69+HZkPDn5nN1OEQRb9rhSK9V9FOEIFs5rIgI64xBnu6cM5JGvla6oYfBwOEzbMoTcyOtAM2zKjKN2ZIG6LxYfhjeb1Ys0vmqiGBai3iRwIjhlYwbJpCARHJxb1++7GFcuYtP59w1SnBH+ZOin0n9A5fuOEAj332YSUyUk+rqb6II59KzsMXX8OGowKa6BFc9hUqQhqwUgSI0VjWlaStpZQtiot89EQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KwJSXyyk/lobRYJeBV+SJaBbgUhq8V3dUW8MjVmQUX+3WbJoqsOUBpUHwhck?=
 =?us-ascii?Q?fXdQPKy0bodl5Oh8guotuVGnmwYZ/Vgh7d9pMqUyIjuC7s1XtWd40c/gYgW3?=
 =?us-ascii?Q?H177Fubt5LUFdhPKUCxd23C7PH1cJWjGX+VqWCJnWXE/v/BNReJOFP9SZCAb?=
 =?us-ascii?Q?fHlem970jnowRu/q/Ti9KeTbtcwCSKgEddepK4VrAKUCoFk3BpK9mBeldTks?=
 =?us-ascii?Q?uXHLkuSXoV+esahq5Ad6mHYX2gAGep61V1L+I4FaLuxu8PyK2it+7nBGu2fV?=
 =?us-ascii?Q?XjZG5r0Jdhrn0eYsSIuVmu++8XOZXNg5gXanQu2jory0mZ2rHYD0+CI11zr+?=
 =?us-ascii?Q?yFcmgpWKB0sImOlJqZmQaQV5XeinK6Igp70EHDGgIKahssVSia7LfP5AvSEm?=
 =?us-ascii?Q?v5oUo0xVeE8xlIzZnS1YFcAy2y4RTyeOZioPCwVH/DHSy470sg3Bk0lIeANV?=
 =?us-ascii?Q?Y2pTfmhy46eCepVvZLTuFI8pC2Y0zYkc5NgksoxcOgTcAYFi18DqPx9I+8kT?=
 =?us-ascii?Q?zrSuIfAQVUHaNP5DNJxBvNzE1jQGnauyODU7v1kWyLlPKIJ+X8UixBJv51UP?=
 =?us-ascii?Q?4hUFjPgQioEtbf7yg4lAK+fVx/FBdSTqhlRSeiIfTFpAJ8zoOt36+89zigAi?=
 =?us-ascii?Q?lk7ScGZS0Od5tlNKa/9wyUMd+FJG6zu6KHSVuiVS68Of/HvHhOH4ZBqVsinf?=
 =?us-ascii?Q?p4uX8P4rXC+rILDCAlyEGTcTiFWqmfRUH7o1+z/tJmSmJ16FazqiO04QEKfv?=
 =?us-ascii?Q?gBrM5Go4B2BrSP0XJY8pWh77vPIhNHLS3xmQJld3+H7xNRwQ0tL1NG9KwBkc?=
 =?us-ascii?Q?Wumoj606ZRVadoJiV7ztzodmdBWNienq4r5zM3CXUIqI2lqNGs55ZoWpgtqd?=
 =?us-ascii?Q?FOzLDrx89hVJ9HLmMKb7SFNBpF+NhedslW2lqh0K5MQ1hMwNG6cOYSFOWFn9?=
 =?us-ascii?Q?K1et4VMfdUjDdYpFj+3JS5NCwYs7QFRbb74vMFiXI7SQ3+fs9fDTmMAXiHGK?=
 =?us-ascii?Q?V0uwVIv6suvaqX43lgXxKTCtBTiHA3FMmxgiMNKbuj6/XOKRKagVlIkzDOLX?=
 =?us-ascii?Q?wwKXuR9r+NZ9GpuXFujODeCBip9qsqDxdTUrQGFscZUaVMAA11mIJMsOeyWV?=
 =?us-ascii?Q?bXp50ad45JY44NnfBEd7TnXerXA3eCA4iwiGJoJSVJ6afzjxnLUkWSLgZITo?=
 =?us-ascii?Q?EODsTkyYW5/75OJr4x/KTOCK/VoTi5EPb6NzxnGNwC9rc659KyxGdVPvXSNz?=
 =?us-ascii?Q?/EKimnJXAlgZ+txWwZAIa7cGnll/mO5awG61Nx5hKUb19Az3hHDQs+cKb3Aq?=
 =?us-ascii?Q?9gzfxj13t5AYXv5gp0GSokr3qBMIY4uQ7eS23QVMIIQls/Q4HbSi/dwneU8s?=
 =?us-ascii?Q?TxHtHOdsySXwZ3d7+qn2aH9LmncegSNLem27cv/sqBOROrvwFanCHc0Bbtne?=
 =?us-ascii?Q?xBE9OZtz9L754LXHTdEqLKsjj6fPQ98HBIesMdyjaV6mxjPB/v8zkMJ+RF1p?=
 =?us-ascii?Q?NUmBDnfrdUc3FgEZ27yefOGfk0twvTImrv0EBcHn+KNBohIllCAPyOjJuHKU?=
 =?us-ascii?Q?lfUS33AkkkuGHwFfiAxjDMBvEe+riUYkiIxD2S6Xp8GF1XkiOAVmx8CUd4jN?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ww5oGWDxoMI7NYsx36Keerqc5OGrstzAiFuXFqv3BinoqUO0YQJWUvnrctSD3T/9X3P6CZsCw332XI/zlkkyKjnxAxvOQYZYJSwXoFe1bVd1CVJpu53CC1itS1tOM+9+mQF+2Vu1muMJ57IWBWI95jZc6xxwY6MoSCuL0Azbic6/WwTc5vjRkf9qXKWxmqcZlYRKM8PZbFag3/L4yy6Rjo3lYztcFrzAEk7cE+TGariGe0Rd3vI9niT+WvhRi8paSXkIKfTTdgdaCsVlqh+SWwzu3JwYX7uFxN6FIw/pG/rAD+10jjurNX8mL+ZMWM3FZpGJ/aagffIq/WLjVeOn7KegkWwDp5Mv2I3axP1mEMQpKl4Hfrc43U1SbSwP1EiyjWHWCz34ZBmVY476zy3bR77P6u9C0bwqBOvqb02COIWKpTs6C0Vcb6zB0xGK5mOObuvr86yLchPx3iXPzRf02DWcf6H8Yx7F7qit2xODb8ASmvML4Sg54CbOJevRAwintrbKHZuuCBnYtoErhtYwSXB2puc7QNeJXOOLJ7guvaI3erAO9HcZKkuGa3ZZkgEDhNkTbrnlNxpdr14luqezkCqAAV3SGjMl5KNr8oJhEWpgVtI2Q7zl/656n0pAyimpH9NFyrxpeUVGUVRCuoP8GD+7m2B4yUABCFPmNYOLlR5t7qG+Q5DZGYMQ54WoDJOMwBuC5rvXADo7l9yookuJagRCVUL3wiHkU8YqMuieGKruH6uClhoS3dpGqeiX2CBNbViRPa8qFY1psWyChj9uCmXnZwNwtQqS9ssI1d3dGjBCOksPfp4cfi/nQoPALcni
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f5c52a-0dbc-41a8-308e-08db769c53ee
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:19.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGEuKdna6nRIo0a2jI7B4IklMcOS+7wk5FaKhnLbUQnzse9nbaAEfj7X+ADTkNi7YNHyexO6GrGYqPcwxUO7bRT02kHxh9nJ9nGyxL6saBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260218
X-Proofpoint-ORIG-GUID: e8kNFGUL5Ptj7SyS-nlpvEI7Bc8rkC0c
X-Proofpoint-GUID: e8kNFGUL5Ptj7SyS-nlpvEI7Bc8rkC0c
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

This patch has the core work flush function take a worker. When we
support multiple workers we can then flush each worker during device
removal, stoppage, etc. It also adds a helper to flush specific
virtqueues, so vhost-scsi can flush IO vqs from it's ctl vq.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 15 +++++++++++++--
 drivers/vhost/vhost.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 611e495eeb3c..2ea107e867a1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -265,16 +265,27 @@ bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
 }
 EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
 
-void vhost_dev_flush(struct vhost_dev *dev)
+static void vhost_worker_flush(struct vhost_worker *worker)
 {
 	struct vhost_flush_struct flush;
 
 	init_completion(&flush.wait_event);
 	vhost_work_init(&flush.work, vhost_flush_work);
 
-	if (vhost_work_queue(dev, &flush.work))
+	if (vhost_worker_queue(worker, &flush.work))
 		wait_for_completion(&flush.wait_event);
 }
+
+void vhost_vq_flush(struct vhost_virtqueue *vq)
+{
+	vhost_worker_flush(vq->worker);
+}
+EXPORT_SYMBOL_GPL(vhost_vq_flush);
+
+void vhost_dev_flush(struct vhost_dev *dev)
+{
+	vhost_worker_flush(dev->worker);
+}
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
 /* A lockless hint for busy polling code to exit the loop */
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index e2dd4558a1f9..f208f9923c88 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -198,6 +198,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
+void vhost_vq_flush(struct vhost_virtqueue *vq);
 bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 bool vhost_vq_has_work(struct vhost_virtqueue *vq);
 bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
