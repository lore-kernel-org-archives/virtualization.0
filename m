Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B42C07E9C
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 08:06:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B418961360
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 08:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B418961360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79B2940295;
	Wed, 14 Jul 2021 08:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2C48D9A_AC9; Wed, 14 Jul 2021 08:06:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 03CFC4021A;
	Wed, 14 Jul 2021 08:06:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C52AC0020;
	Wed, 14 Jul 2021 08:06:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2FD4C000E;
 Wed, 14 Jul 2021 08:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCED1405D1;
 Wed, 14 Jul 2021 08:06:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ljXnHRU5";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="JtVcghPl"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RxwQL1P99pmD; Wed, 14 Jul 2021 08:06:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 236AD40580;
 Wed, 14 Jul 2021 08:06:07 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16E82viB002641; Wed, 14 Jul 2021 08:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=2aMRnxf4q0qGjXWqt9IqyAouyCjXtcLlRPi/lTe6FWc=;
 b=ljXnHRU52sls3Lxw0akVaXTOPNR3XOqMh2oBM0A5DeB4ZG37zmVjW4mq69Tst2R9XS3X
 oUSOKSVDdMWnaTMJJBJtNgrWL5QPRJQS4ciqNlQuOo0+pEhsANDufyz8LU/bSUkCEiw2
 v88Zn5QxXR1MJ4yPc3d7bkm4RdtNQ47mEzx5IpwEMIw+LTZ3TvPiif11BFeLMuCCEUc6
 CJxTB/AA46+CKYAvzJ4nvQcFUhzzs0zmK5pTuO/9abO8pXKRc9PRDGezSKHf2N/jjC+w
 TXgbj7ilYW4EUPgXOkDzCIAYpu0OtLHX1ljG5o/38Gqsun40f37cWN/59KuOIvfgp77v jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 39rpd8vbtv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jul 2021 08:05:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16E80mpI146936;
 Wed, 14 Jul 2021 08:05:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
 by aserp3020.oracle.com with ESMTP id 39q3cekgef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jul 2021 08:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftkGNcPwybH7eN3kw8gkIagWC9onMEQd0EUFZoCqAbFr/6Ge2EKZLkMxV/bTvrAZ0WZWkR3pdzfYoSpVCwOqYq5VNYbjtqF2Odt5CxboCLgp6haJ8IywE3pgJF6bYwVEX54Q2kNZC1Cttz+XVDG04qmLC28FT4MJkJVqMy+N/USuJABkHZxuKamOddachC3dVDfevX/+X7ikk9eCINosaQZfcakqCBQCRfH0OkEM+ZnTrWQQTnLbzK6RqD7mXRMu6BlMFbzUZft44xE/QMbDtmcJMVD37d63CGL2aDBF49Omu8cPdAcvH2Og2LIPyPI7A9ZSyaN7sTxeXD7b7ULj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aMRnxf4q0qGjXWqt9IqyAouyCjXtcLlRPi/lTe6FWc=;
 b=b9y5A+gmqgvVivjZuPnl/c74WJveCF6cVq1R2bjfBCnrylan/a62PZzyeIiQUZvbHHFCwyITk8ToNHKMCXtFY+kTA7O6p3OsN3WGBFbR+tXyYLoMzckDftnOCrcoqRCY2NtdNqHxQkAH6iA1v6mc1yqzkuaTKooK+axv1TrJOQJ4Z7cWDgK0NZR76BV0eddAdiamKirfI8nQfgevnWbyw9SWMLNjpoW/C/odWiDrOqQh8MpsTurpneEoCoIJpSHGOMnpnr5B9zWqiPOLAp6aSNR1F+FSK+/O6/t7ENcAqoR66Ngiq9EU9C090vBhECm8XYgrcO00QhYy8RaYCBumWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aMRnxf4q0qGjXWqt9IqyAouyCjXtcLlRPi/lTe6FWc=;
 b=JtVcghPlZTFacNHYoxIfYz6Quvf29l77Z/dIqKFngkXiasaRw/MrQ2AQVcG7Tgsn2A+upEjck+idqI7yAsSf7kb56vC0EFjekI5RAu8jNyTOQ8mO8Bllp+/tgVe27MTJS32tBQ0bZzEJKeZtN5JpKdOITv0g2FbzS75CU6LnF3w=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4483.namprd10.prod.outlook.com
 (2603:10b6:303:98::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 08:05:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 08:05:53 +0000
Date: Wed, 14 Jul 2021 11:05:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v9 13/17] vdpa: factor out vhost_vdpa_pa_map() and
 vhost_vdpa_pa_unmap()
Message-ID: <20210714080512.GW1954@kadam>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-14-xieyongji@bytedance.com>
 <20210713113114.GL1954@kadam>
 <20e75b53-0dce-2f2d-b717-f78553bddcd8@redhat.com>
Content-Disposition: inline
In-Reply-To: <20e75b53-0dce-2f2d-b717-f78553bddcd8@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by
 JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 08:05:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd917d8d-68ca-4805-5f80-08d9469e3338
X-MS-TrafficTypeDiagnostic: CO1PR10MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44834A42145BD63D9730C1ED8E139@CO1PR10MB4483.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0OaoS6zF+rsSwlJZaOGZm7h2cBuTijTMvEcizkW0BXuwNO96fV1UqLA5GJSWngw4RtBP8BQpujnjGTjCPacw+W3dQ1epkjHqmXJap5cuzv/ec0mzb8ZBMIsSuyikyTG7ezUM0R3jgmnaGG5ZdNczqcKhi0NP60X3m0dIGZ5i5Wnk+r3wvHY5vKsGwY4C9w4w8mDN5jIjSXI6o3rG6XYM+wPoeA6mJX+fYCoytazd8pXeiroimKHQCypFYSnLnO8D+zl0HKbWvxpcRu0Dy4fFoJbxVlcqV457pDaSNwCDO4Guw6qVcAgKXIQfs+vWdAEhXI+Q2M3K9rta7tnisnRhEi4/TsbFMCWIKdM7FrZYbRztkJ39exmfOHe1KS8oRd1QN8TLVxz/W6/bhPWUMeYTL9XVFQk7b4i0/XKIRYkJRRWKimZjSGh8bFxxSn9il2+vLBlRZ5D/PmISdJN+WqOSuXbwJjZO1/rjA4fzznkOL3Lyqtz3owwUlRQoNRrTH5WcCZdkwNoqxPAyOAKKlhWub5RNw8Dzy4YtzmQkoASb3Xg6F60xAc/620SaRL9tp/ql+4gtoMihhZ8dAhTmYM5mkvayNehvWPsEvivkbL73M62xHjChixElTLMKg/rgt/txxIlMy/5OSz2ZPYhToABJ/fQfL5oDvckQiPbDmokAqV37pm6MG1wCAN2dfbxw1s8x4FKjSNZCGj8uHaAqxeleQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(396003)(136003)(366004)(39860400002)(478600001)(55016002)(9686003)(8936002)(8676002)(33656002)(83380400001)(4326008)(6666004)(6916009)(38100700002)(38350700002)(9576002)(316002)(956004)(2906002)(7416002)(1076003)(52116002)(6496006)(186003)(66476007)(5660300002)(66946007)(86362001)(66556008)(33716001)(26005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUp4cmJnY28vTW5QZ0JrTTFhb3RhQkhsWkMzQ0R4Y1V0Q1N6S3lIU0lza0RY?=
 =?utf-8?B?cDhUTytiVzhIQktyYzBLaWxpNXF0RmZ4LzJSeUZIQzNZallUbVdKVDRkcm9o?=
 =?utf-8?B?b3Z2NWJETWxxOEZpNlVtZVA1WXRaVG84azdXZ0NNRFhsRlJTVkh4emcwWFpm?=
 =?utf-8?B?cWwrdVR0T0pNcDFZZko4MkhKajZ3VWlLK1lsR2NmY3A2VDduTWRBY3o5bEYz?=
 =?utf-8?B?Y01ZaVlQOWtyRFowNEswSTM1QlU2WGRqQktHNzQvNTQxTHZCMTgxUitDVUUx?=
 =?utf-8?B?UEYzQWU5NEV3di92c0xZSG5PUWxFRDMxVjF1clF4eUNiOTFzWVYxSjMzM3lJ?=
 =?utf-8?B?cVJOUmorS3Rrcyt3UldNTVdrM0lqTDFnTkE4RjZ0QlVac2p1RHIydE05bVoy?=
 =?utf-8?B?aWgxamo0cEp1TlMrMmcwWjBrWlROK3Q3a2xnZHNSb29rWXJXNkQ0UHg5aUZS?=
 =?utf-8?B?a1pzcGRNaDNCUnhPbUJIZ3lFOXYwVGd1WG9aWVNGNkRMbkFieVExK2wxYU9Y?=
 =?utf-8?B?aXdVbU01VERieGFoOEdjUmFTK1Z4cmpOWndKbCszL2E3aGErU0hwY2tWQW5E?=
 =?utf-8?B?QXhnQkZLSXdhb0F1RHRFL3FoZU14Tm1ibDEybUkwaGF0VUJwWUJqUXZmWlB6?=
 =?utf-8?B?Zi8ydVpBbEdpN0o3YWw4Tk9FUzkyRWRodjF6eHF4SmJqb1hkREdHL2MrSGFG?=
 =?utf-8?B?VmdGczBIYXpqSDBZV1NFRVNNU2RUd3ZNd3dGdTFIZVlhT05NeDJ3VDl3VTdG?=
 =?utf-8?B?dVNOMUpmdjc3REF2d2RHQkoyUnB4aGc4SHVKVnQxUWdZMmZtUzNMQlNWQWE5?=
 =?utf-8?B?RTFjRUpMRzBhZWhCaEtTOEVjQng0NjNFWVJMRTkyOGR0d0o2Kyt6UkdUMmxz?=
 =?utf-8?B?bFVlRmEwRWVFdE5keFlNcXN6ZUpaek5qT2drL1lweER0R0ZDcXBlMWdnSUtz?=
 =?utf-8?B?UTZHZUZCUG9ENEJYWUtYTjd1REVLWENqYi9qMmphTVVlMFVLVmYrWTQwZnVH?=
 =?utf-8?B?cHZ5NkYwemRzM2pHY1NiWSt4TVQyUzZ5eWhOUW1PdDJydUtyZGd6STYvclBT?=
 =?utf-8?B?Vmx0TnQ0b3NNdnpEaDRYYnZFczdFZWtsMlA0NjdwOEg0MlVYRmxOV1RqMTZZ?=
 =?utf-8?B?Tzc1d0VOOUlNTjZHaW9pNUtQNTJSRE53T0ZJZFVYa1dOdm5BK3VVb29wWFB1?=
 =?utf-8?B?ZHU5UWNQaE5EcnJZaG1JZkVYemVmQTJLQWRsSC85MnJKeXRXZ2k4QW15djNv?=
 =?utf-8?B?T3I5VHJJYmhLTXhCZlFyK2UrSWsrM3hRS3VoU3NtYitxOW4zZnpVNjF0YXNs?=
 =?utf-8?B?TS9YK1QzV2ZoYlh4ZTNON05SWllFZUFPWDNqU3dPcm1uc2QyZXpwMlRCcGxG?=
 =?utf-8?B?RTFxejFQVGVyWWNCY29WRUx3RjRzcUV1T0FrQmNkdm9vMk41cDRMT3pwc29P?=
 =?utf-8?B?WDMrVGYxVlI5Q1kyeW41enBJZ2paNDRaeXM1ekJBdGpiOXhYWU1ncVg4cnhv?=
 =?utf-8?B?K3ErcWI3S2d6Uk9palV4QVZiS3hrOWFFYkQ3YjRkcUowYi9PQkY5ZjBGUE1l?=
 =?utf-8?B?aktCa2NlSURLK1FtYnJ3NlQzR1RkSzh2aE94ckZOczdXNHRqZDAyaDN2M2Rn?=
 =?utf-8?B?b3dISC9FSEhWTEFhQ3dBYXlVQ09zdWhUZ241ZXJmVzNzUjVkdTRYbDhmdVAy?=
 =?utf-8?B?Z1lncUdvZlpyNmFDWHA2MWVOWjhqWWdHeWZ6WExYUkUvbHNZeWV5ZmdNaW5x?=
 =?utf-8?Q?c+aNIVVq//2JME5PJyiK9l3Hg4tu/TfVvDm0oBX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd917d8d-68ca-4805-5f80-08d9469e3338
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:05:53.3112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUhx5rHBP/c9tDOnZRauYWqXXZ9aE4oEJND9iXUm8H9whENcj8JCyNVCMx+ryNMHAMwJo2C8upQnhFptEfl6FJ0ZKhIndBtm59+jrH7QiKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4483
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=870 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107140051
X-Proofpoint-GUID: Xy6BNIYKnJ9bTEb3yuv1KWtknz2jLlMB
X-Proofpoint-ORIG-GUID: Xy6BNIYKnJ9bTEb3yuv1KWtknz2jLlMB
Cc: kvm@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, xiaodong.liu@intel.com,
 viro@zeniv.linux.org.uk, stefanha@redhat.com, songmuchun@bytedance.com,
 axboe@kernel.dk, zhe.he@windriver.com, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBKdWwgMTQsIDIwMjEgYXQgMTA6MTQ6MzJBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS83LzEzIOS4i+WNiDc6MzEsIERhbiBDYXJwZW50ZXIg5YaZ6YGTOgo+
ID4gT24gVHVlLCBKdWwgMTMsIDIwMjEgYXQgMDQ6NDY6NTJQTSArMDgwMCwgWGllIFlvbmdqaSB3
cm90ZToKPiA+ID4gQEAgLTYxMywzNyArNjE4LDI4IEBAIHN0YXRpYyB2b2lkIHZob3N0X3ZkcGFf
dW5tYXAoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHU2NCBpb3ZhLCB1NjQgc2l6ZSkKPiA+ID4gICAJ
fQo+ID4gPiAgIH0KPiA+ID4gLXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3Vw
ZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiA+ID4gLQkJCQkJICAgc3RydWN0IHZob3N0X2lv
dGxiX21zZyAqbXNnKQo+ID4gPiArc3RhdGljIGludCB2aG9zdF92ZHBhX3BhX21hcChzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdiwKPiA+ID4gKwkJCSAgICAgdTY0IGlvdmEsIHU2NCBzaXplLCB1NjQgdWFk
ZHIsIHUzMiBwZXJtKQo+ID4gPiAgIHsKPiA+ID4gICAJc3RydWN0IHZob3N0X2RldiAqZGV2ID0g
JnYtPnZkZXY7Cj4gPiA+IC0Jc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiA9IGRldi0+aW90bGI7
Cj4gPiA+ICAgCXN0cnVjdCBwYWdlICoqcGFnZV9saXN0Owo+ID4gPiAgIAl1bnNpZ25lZCBsb25n
IGxpc3Rfc2l6ZSA9IFBBR0VfU0laRSAvIHNpemVvZihzdHJ1Y3QgcGFnZSAqKTsKPiA+ID4gICAJ
dW5zaWduZWQgaW50IGd1cF9mbGFncyA9IEZPTExfTE9OR1RFUk07Cj4gPiA+ICAgCXVuc2lnbmVk
IGxvbmcgbnBhZ2VzLCBjdXJfYmFzZSwgbWFwX3BmbiwgbGFzdF9wZm4gPSAwOwo+ID4gPiAgIAl1
bnNpZ25lZCBsb25nIGxvY2tfbGltaXQsIHN6MnBpbiwgbmNodW5rcywgaTsKPiA+ID4gLQl1NjQg
aW92YSA9IG1zZy0+aW92YTsKPiA+ID4gKwl1NjQgc3RhcnQgPSBpb3ZhOwo+ID4gPiAgIAlsb25n
IHBpbm5lZDsKPiA+ID4gICAJaW50IHJldCA9IDA7Cj4gPiA+IC0JaWYgKG1zZy0+aW92YSA8IHYt
PnJhbmdlLmZpcnN0IHx8Cj4gPiA+IC0JICAgIG1zZy0+aW92YSArIG1zZy0+c2l6ZSAtIDEgPiB2
LT5yYW5nZS5sYXN0KQo+ID4gPiAtCQlyZXR1cm4gLUVJTlZBTDsKPiA+IFRoaXMgaXMgbm90IHJl
bGF0ZWQgdG8geW91ciBwYXRjaCwgYnV0IGNhbiB0aGUgIm1zZy0+aW92YSArIG1zZy0+c2l6ZSIK
PiA+IGFkZGl0aW9uIGNhbiBoYXZlIGFuIGludGVnZXIgb3ZlcmZsb3cuICBGcm9tIGxvb2tpbmcg
YXQgdGhlIGNhbGxlcnMgaXQKPiA+IHNlZW1zIGxpa2UgaXQgY2FuLiAgbXNnIGNvbWVzIGZyb206
Cj4gPiAgICB2aG9zdF9jaHJfd3JpdGVfaXRlcigpCj4gPiAgICAtLT4gZGV2LT5tc2dfaGFuZGxl
cihkZXYsICZtc2cpOwo+ID4gICAgICAgIC0tPiB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfbXNn
KCkKPiA+ICAgICAgICAgICAtLT4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZSgpCj4g
Cj4gCj4gWWVzLgo+IAo+IAo+ID4gCj4gPiBJZiBJJ20gdGhpbmtpbmcgb2YgdGhlIHJpZ2h0IHRo
aW5nIHRoZW4gdGhlc2UgYXJlIGFsbG93ZWQgdG8gb3ZlcmZsb3cgdG8KPiA+IDAgYmVjYXVzZSBv
ZiB0aGUgIiAtIDEiIGJ1dCBub3QgZnVydGhlciB0aGFuIHRoYXQuICBJIGJlbGlldmUgdGhlIGNo
ZWNrCj4gPiBuZWVkcyB0byBiZSBzb21ldGhpbmcgbGlrZToKPiA+IAo+ID4gCWlmIChtc2ctPmlv
dmEgPCB2LT5yYW5nZS5maXJzdCB8fAo+ID4gCSAgICBtc2ctPmlvdmEgLSAxID4gVTY0X01BWCAt
IG1zZy0+c2l6ZSB8fAo+IAo+IAo+IEkgZ3Vlc3Mgd2UgZG9uJ3QgbmVlZCAtIDEgaGVyZT8KClRo
ZSAtIDEgaXMgaW1wb3J0YW50LiAgVGhlIGhpZ2hlc3QgYWRkcmVzcyBpcyAweGZmZmZmZmZmLiAg
U28gaXQgZ29lcwpzdGFydCArIHNpemUgPSAwIGFuZCB0aGVuIHN0YXJ0ICsgc2l6ZSAtIDEgPT0g
MHhmZmZmZmZmZi4KCkkgZ3Vlc3Mgd2UgY291bGQgbW92ZSB0aGUgLSAxIHRvIHRoZSBvdGhlciBz
aWRlPwoKCW1zZy0+aW92YSA+IFU2NF9NQVggLSBtc2ctPnNpemUgKyAxIHx8CgpyZWdhcmRzLApk
YW4gY2FycGVudGVyCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
