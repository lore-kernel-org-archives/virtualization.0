Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B391C77B7A
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 19:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0230E40886;
	Wed,  7 Jun 2023 19:23:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0230E40886
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=igx2OfvU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=OuFmmrYk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L1D_hE5l_xkS; Wed,  7 Jun 2023 19:23:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08A58408C9;
	Wed,  7 Jun 2023 19:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08A58408C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0DB9C0037;
	Wed,  7 Jun 2023 19:23:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5791C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7260D60BCE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7260D60BCE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=igx2OfvU; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=OuFmmrYk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mLCiJPdrh5aA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:23:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 920A160BD0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 920A160BD0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 19:23:54 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 357EeiRX017995; Wed, 7 Jun 2023 19:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=MPyLif/fhP02qpS8XmDkoZIPePvR2EQL+l3vu2pbXCI=;
 b=igx2OfvUHS5mJM8JCWqJqvLWVfZKV2c7PKkCz3i4qcn24t0NOFC3fJXUMkHyZg70jX/F
 B1QcDajWkCpgiyG8lyg7CcL/nvASYyVSQ1E+zWg64AWvu6tXMypz1Dq+gqd8OI2LjOx3
 0uSLj7jWnyBLSKsDNzNYQxr5xsytqHk/EwLPFknaDctB2xm4weJHmm9EPVDzwgaMJId9
 9J4DZ8ZQMsHIR2amAkWWcnMYv/z59EdGlVavJ9R0794eVvBPkdR6M+J50NvjQJwmxN7O
 uthpdudyt/bk09AbYZAvM1w5utUQyB6zUg/Vk8udJndQUvTBSX1CFE2FA9KHWGbEvcrf 2g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6uahar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 19:23:53 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357IsUY6037092; Wed, 7 Jun 2023 19:23:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6rxq0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 19:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaFUvLDZRQkmBTB6iRQArfAcYHXL1ZYvm3RV0Bg+rZRDVFG5C4ECFnCr9WsbDZSbQviyBlzOkjOTUEPtc659sdAKc9xQ5hDWnnrAucaT6m0icgGJIq8Dn5eDHxh9PT/YFxJmpLI5fdakn2ud8rc+e6OtcKKQmom4FbH6AewySJ/fBDIoyWWIbrNqVQPqqZKV91B0sKTP27GdEVU0Cor5pYjHHFFdyTgucn0pZCBKWj+QSk/Q2DiT28x1+wXQHGtlDKc8mVf4CC4n632azNFYZRuLLF32eD/ORmrNmaYAESgmS1RgAxB/S8RKKyHVhXsn0C6slw3PCvUtfglQzBH2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPyLif/fhP02qpS8XmDkoZIPePvR2EQL+l3vu2pbXCI=;
 b=lOCeQLgzd7kuNsCi0KRk/fsuwukkF9yHK3BGY0gfEptpfO1lrhHeTZIUl5rXgwZkocERdr9KKIbmLPikq04I6bXlp54PHatOMC7fJPfKEoDK49xeM/4jgdQ3lAkKwPTDS3jOYIbNTr6SrfE/fPYIgTYetEyHnSP/cD3QCPDVHlL5HcnS1/o9Ybfe0KW82ZaG8xronBdcOmTOuSEfAvHszE53hEBG6W/jmf2DIw/aTVDxhWRpg2e0UY/AJ1cyH3zEIlL0KZ7Prm9K+YT78qikJ6oZmol78j/FFdhE915ELWfAL5eod/YqhWe9lrqIpoDe5Eo5WjjQGLl26B7pk+55dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPyLif/fhP02qpS8XmDkoZIPePvR2EQL+l3vu2pbXCI=;
 b=OuFmmrYk5vmw3TWZSedWCmfmWa6WZ9Z1BfXFMaf7v3xfBdsUISyZ9zNeOTmFjDwSFr8zgpGVUJlgvek4UT/VkWl+4vPsmCBU0D1TUsfGHj+Xlz/O7qWPbVZ3PmKaFL/MuB+sMiWF+8juy5NqfLqujSC6RdpjFhsnD5OphmsiEPM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB4808.namprd10.prod.outlook.com (2603:10b6:510:35::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Wed, 7 Jun
 2023 19:23:42 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 19:23:42 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] vhost: Fix crash during early vhost_transport_send_pkt
 calls
Date: Wed,  7 Jun 2023 14:23:37 -0500
Message-Id: <20230607192338.6041-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230607192338.6041-1-michael.christie@oracle.com>
References: <20230607192338.6041-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:5:333::14) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB4808:EE_
X-MS-Office365-Filtering-Correlation-Id: d2117f15-92e7-4d62-6309-08db678cb49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTjY+vOsbMqaL0T5pTvs+1squu5WBBDqZYSfqjAZqavsaCWGYxBRNJa0AuDrtafjrJMqpSdY8AfSSUm9bDK1jmgU7pgsDyHLcvH1hicNRGyw9j+QzI4q/hzqVl7b9keU1bsTrBFw7wkIDl4Bt85zPS7XgU7lhXQu8NOLBqq3QKzx0qThaYjs1jUus4Ecc5MnOF5GB9wgcq2k8HyCH5cQiIjna4WCw1/1S77gy49DtyAxt3FvfCcEiCjVGeNtwznC8NSdWCGjKx2P19biUF/2Ca6At+ZUvdwmA8vxIifZysiEhpnWalEYFXNTP+ZmhSkhRiXHN3/uT4VKNQRq/aEIsTrtdPfW6gjAfwVN4GsEQQ2im1hSAokBKISlTLyYJ9wcgq2Iqua9X+4xrZjovsXUs1Tou3zFaI3aq4TEdlf9f+Pw6dBPnEmY1Dc167jf+GsHEcj7s61eTtl4j6PlTJT20HvKES+aItvz8yfLXzAweeVGH3jgxuB01j2snGHsHHDsZSMZ4x01InbHgGL6XchBzksA4EDqDGshhNQ3AoIpOgb/J+1Fn0Gus37lSw6WUKAT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(83380400001)(41300700001)(66556008)(66946007)(66476007)(38100700002)(2906002)(8676002)(8936002)(4326008)(316002)(5660300002)(2616005)(478600001)(6506007)(6666004)(6486002)(26005)(86362001)(186003)(1076003)(36756003)(6512007)(107886003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFMhNpVYITE/gAp3uU7Tu53fHPjG61Z0ZJaQQSXLQc+ono/SjEKf4jiaUVbq?=
 =?us-ascii?Q?282adHokF5mywg2wJ/QsY88gXFwLhbBUkDJ8T0MUVOpxq45KhBLph1op68T8?=
 =?us-ascii?Q?LNxHaYyyKhnQtj+3RYaPjtJUcsgwganF0jx1ZN42at5+zn6yC90qEBnIGt5x?=
 =?us-ascii?Q?Te7DrgyHRIgZNnC/UdqZhRgO5HI2moI7rl7YORcDBPM9f/ym3SIdcjTUl76a?=
 =?us-ascii?Q?x9L0Uri940qzOm3TvVpfu/Gh9xtmPyuHY1harpnJJRqYGcGigHh2qeH8G0yO?=
 =?us-ascii?Q?bnCFbtlkPdiPcPTabAdoNPt1zxPsXY4fTAb/Aod7BzDMcDgsU3XKxB7J+HGj?=
 =?us-ascii?Q?ol3JS2puvGREljiU6oCw3rW0wPddviUo8Z9BjEu/3AI+bKj6KGiyjbml0XXh?=
 =?us-ascii?Q?ulFBpHaI3L1kEmoBGIT+iWR1EA9Dqa1sDhNc0Yt6xwBR/2f7VfOSltIZEp/j?=
 =?us-ascii?Q?G4V4L9jqbkv32Tj3ecsmXbEl5sKmh/vWo8E2QaCz9nK21+9zdO4NxRuwXRZv?=
 =?us-ascii?Q?ktyr9ZNTRR0LSaJm/LXPRudYMqjUYEwUQgrTVxXGGm32gpsCoozZid4UYqq7?=
 =?us-ascii?Q?2XD3lfqEvmTN9JEB2WPO/wjsoFt6OmCc2pcgz/9atm+iGX7Qq+5I8ty3l3hE?=
 =?us-ascii?Q?7BEH+4gbVFs6pDyYcWG/wJv/dy3VCHQuhj3ECCj9xSM3cFZYHWpel7NYOGLE?=
 =?us-ascii?Q?oqTUWjpkxGetINgsMKptEGyaGMVUwXJ/btS2xvk3nMLuUlDCA0QAW57IGIks?=
 =?us-ascii?Q?i9r4A2+UhHFIUH7CWecO1Sbmoc1vBY16KJ01NYfT8oUw7GVfJTSbvL1NbiVb?=
 =?us-ascii?Q?RGBK3bPGKyOOow4UWhkvtPecCiaofAddEz5MdwqrrrRTwNpA2s+d53oSs62u?=
 =?us-ascii?Q?7E1VTEuEurp4APBHf/yntBmUozUZlX6qgZyQkPdfc6cTg1YO+Wl0XjOWRxs4?=
 =?us-ascii?Q?1oLdG0VDXiv9xIgZmsPZVA/08Ey+Nal2icR6kQh6THraMfewPuRC7dfo+vEy?=
 =?us-ascii?Q?DqHPRxtON9xjxRgrBmbzA64+d/c8JAWg9wA+pLaCYv+Vbuuh7ZO69+tAImqm?=
 =?us-ascii?Q?l4id7qwtfGe+5gngX59j+Pm82mV2ogrm9JdqzL00evqcXZqoqoNEs1kNBNGO?=
 =?us-ascii?Q?aZ6oX34jtHZOjZz5GyvQgQDDs+EJ7iJm8CQfecs4vKiJjrlH7VR2zRErQYlu?=
 =?us-ascii?Q?ULtIy8FoEFxbw4TK/ZxvkdvQv7RnaPua5P4S4V7W7qIkXWrlpf1PNbkoK2tM?=
 =?us-ascii?Q?EsQrH3TRc5ZqZW1bsjC66IIO+Y1+pPNp6xzTgERZ97n6ukjryEEjNkIFi0gM?=
 =?us-ascii?Q?sahBodORItiZ+gQXER1yC0HnARngADwBbf9RGtcPfArQ3t2amLiEgAbjQyaI?=
 =?us-ascii?Q?2AYioCDF6mKz3+eBo/Tz4mg2G8KaMEqdmSszqQlfPJM6okTmlNwMKf61NEnC?=
 =?us-ascii?Q?iVNMrS7TFNSldDFY4Rs9tcDWrYtCdHZOEgjgsdR10vZo1gRr/fG3X3TPld2l?=
 =?us-ascii?Q?fyjPkrqvmG76GOTqm67x/ycFQY0TDNZWrXmRZTRylQqFI/Scin8bODULaz0g?=
 =?us-ascii?Q?f9DbpqVnOd6p4bLwk9RjoHQHs3KNd0WxDGBGmrWtmXMP7sP7fORqnnPr5o5E?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VOFTOHWmxx26xvhpgkfin6WJBc6C7LEytjgTnALu6LrDNY8P7y9A0c5A6YojS5zoA0hYvNtJX9/1EKB9ef5zZK0VJfenhTKpvl5SSIXwuWs5Z+L5ejmdtYyYI2aESdAyTSHtmJ9rDAZkh5ZL2DPoBrrADxhFNsDyaRFiwVSz+1pRHreBdPHhcQiT8PxEcBzkPjg+FnaYMo93sS2vBig8n9c1bN/GpTg9eRIEvb2x3k6fE0f2w+sZcwiy0CjnLd8IcKzDtUz2QitOQHm0+CTpD9eYu9g00ABXBpgkIuqSmza3ilnwhKqIh9da219OnKro7oAX9RmsOkdj1FXKAj5B5jexYmjkxekKO5gT1LIfkMzmtEMwzvD8ipTM/ZlXQosMkekDYX0YEwV61cmYWW/kgd+Xo7+U5KNgRGPCcoPSSzAeMAGyowBNmaIl24VBuzl1YihnW2G0GrK9qh8nl3UUJsxoeDELfy/05pgSAFi6ufeEojFOlRTwpK6vXK7udWHBwwg++FCkegCQlFwLGGwsFhDh3gIsNBVE5xcsfEkGRCtxXuj8H/zT49TZxfKPXEW258ZyNFnj1h3csz4VUlEfpUXk5HZs5SlzI2gZO/bEkNCfVy5k24cPMW8+CNYHYHhCL7eDwitGQvVAD2f3hmSuwSe0XHvcSsSgV9/oPfpcyQDQMmnF+NxsyXbUzwZzmqRm9Xnq+xV5hQj4r6GCJROOolbwKX/qJ1fI1Ft0qDvojf4Lh6doALtr0y3UT3iNSymIGoT+fZjrTnGje1/mjjKfGwQRlk1ULAS8mNlSZ+vT/e3vOFaID2wmTQkZy7eXM7Tg
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2117f15-92e7-4d62-6309-08db678cb49e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 19:23:42.8230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgMsZp8yCeswxkIMATr25eclJ3uhZmxLNjuf1fRY2s4PNg/yMte6RXgPp6++zDeQphpQT6hcXB8SviwyNigeuPLRyuH3Kkx5AYuW9AJ6ULU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_10,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070167
X-Proofpoint-GUID: j-mD6PPdMHOavqMN44_j5gc6kuZrxs-Z
X-Proofpoint-ORIG-GUID: j-mD6PPdMHOavqMN44_j5gc6kuZrxs-Z
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

If userspace does VHOST_VSOCK_SET_GUEST_CID before VHOST_SET_OWNER we
can race where:
1. thread0 calls vhost_transport_send_pkt -> vhost_work_queue
2. thread1 does VHOST_SET_OWNER which calls vhost_worker_create.
3. vhost_worker_create will set the dev->worker pointer before setting
the worker->vtsk pointer.
4. thread0's vhost_work_queue will see the dev->worker pointer is
set and try to call vhost_task_wake using not yet set worker->vtsk
pointer.
5. We then crash since vtsk is NULL.

Before commit 6e890c5d5021 ("vhost: use vhost_tasks for worker
threads"), we only had the worker pointer so we could just check it to
see if VHOST_SET_OWNER has been done. After that commit we have the
vhost_worker and vhost_task pointer, so we can now hit the bug above.

This patch embeds the vhost_worker in the vhost_dev and moves the work
list initialization back to vhost_dev_init, so we can just check the
worker.vtsk pointer to check if VHOST_SET_OWNER has been done like
before.

Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 50 +++++++++++++++----------------------------
 drivers/vhost/vhost.h |  2 +-
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 074273020849..7a9f93eae225 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -235,7 +235,7 @@ void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_flush_struct flush;
 
-	if (dev->worker) {
+	if (dev->worker.vtsk) {
 		init_completion(&flush.wait_event);
 		vhost_work_init(&flush.work, vhost_flush_work);
 
@@ -247,7 +247,7 @@ EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
-	if (!dev->worker)
+	if (!dev->worker.vtsk)
 		return;
 
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
@@ -255,8 +255,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->worker->work_list);
-		vhost_task_wake(dev->worker->vtsk);
+		llist_add(&work->node, &dev->worker.work_list);
+		vhost_task_wake(dev->worker.vtsk);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -264,7 +264,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return dev->worker && !llist_empty(&dev->worker->work_list);
+	return !llist_empty(&dev->worker.work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -456,7 +456,8 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->umem = NULL;
 	dev->iotlb = NULL;
 	dev->mm = NULL;
-	dev->worker = NULL;
+	memset(&dev->worker, 0, sizeof(dev->worker));
+	init_llist_head(&dev->worker.work_list);
 	dev->iov_limit = iov_limit;
 	dev->weight = weight;
 	dev->byte_weight = byte_weight;
@@ -530,47 +531,30 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 
 static void vhost_worker_free(struct vhost_dev *dev)
 {
-	struct vhost_worker *worker = dev->worker;
-
-	if (!worker)
+	if (!dev->worker.vtsk)
 		return;
 
-	dev->worker = NULL;
-	WARN_ON(!llist_empty(&worker->work_list));
-	vhost_task_stop(worker->vtsk);
-	kfree(worker);
+	WARN_ON(!llist_empty(&dev->worker.work_list));
+	vhost_task_stop(dev->worker.vtsk);
+	dev->worker.kcov_handle = 0;
+	dev->worker.vtsk = NULL;
 }
 
 static int vhost_worker_create(struct vhost_dev *dev)
 {
-	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
-	int ret;
-
-	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
-	if (!worker)
-		return -ENOMEM;
 
-	dev->worker = worker;
-	worker->kcov_handle = kcov_common_handle();
-	init_llist_head(&worker->work_list);
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_worker, worker, name);
-	if (!vtsk) {
-		ret = -ENOMEM;
-		goto free_worker;
-	}
+	vtsk = vhost_task_create(vhost_worker, &dev->worker, name);
+	if (!vtsk)
+		return -ENOMEM;
 
-	worker->vtsk = vtsk;
+	dev->worker.kcov_handle = kcov_common_handle();
+	dev->worker.vtsk = vtsk;
 	vhost_task_start(vtsk);
 	return 0;
-
-free_worker:
-	kfree(worker);
-	dev->worker = NULL;
-	return ret;
 }
 
 /* Caller should have device mutex */
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0308638cdeee..305ec8593d46 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -154,7 +154,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker *worker;
+	struct vhost_worker worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
