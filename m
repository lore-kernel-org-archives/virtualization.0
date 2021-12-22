Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D2BC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 23:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42ED340339;
	Wed, 22 Dec 2021 23:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id COZ0vTmGKqGR; Wed, 22 Dec 2021 23:04:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6E98F40265;
	Wed, 22 Dec 2021 23:04:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D7DEC002F;
	Wed, 22 Dec 2021 23:04:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF51FC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 23:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA3F060777
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 23:04:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="bJ65CxIh";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Y3mWmufn"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VJF-huMNv3m7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 23:04:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70961605E0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 23:04:41 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMJmrco016922; 
 Wed, 22 Dec 2021 23:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5+J9jXJokKBOTxodSxaskDqb6UMlbKwDAv6IUICcq7I=;
 b=bJ65CxIhaMF5f1Cz/WFjSxMCYz8e/GswjjlF5IFxaAsf2f34c3fV6ueflGJmOdT0BGBx
 KuBcMku2M80+vtzec5Xk9xj3bt1D6F8KkvvKhfAFRBp5gDtEqCmXlKmRyst7v8F7XEHS
 29vkRYnWmdp4ro/bAZ7oIm2rlOJUfdtvLrga+9NYP+DtSePxCdZS0OEEdBaUUdQm18q+
 nHK0QtTMKqgKZYOBUr6AktpGta694MmUJJhXXjpHGL4qdSQRIEvhPce1e56/2WcJqfG8
 qhRcDjCCWjdaofS2MaB/8F66E+tYs4N1zeefk071cABriF+hwH8NWRKhloXq1PgMcIuw Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d46qn16tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 23:04:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BMMuY0T100599;
 Wed, 22 Dec 2021 23:04:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
 by userp3020.oracle.com with ESMTP id 3d193qjrrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 23:04:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsRw8ehx0/iBrdRsJGG8b1sqJbYQGkmzgnYaf5lreZA+iLYJTUWV0bMutDN2LamI9PyHUer/5FKJvnsKdxenJ2VJHgqsBdRpdLGfEDZVrOtyW0FkyKYtN+JM6JY7ngR5CPnP+ZbG2nvMo8hjPPKV2hkyKkQO1L1C2v9He6qSpVX0xqgd61ZBBzeN5q2p/7pC1NFSb/Xa4MLEmvm+cvbe1+Qv8nr8DLxRM97wQ9AXtTesIJfI2tUS+8NQ0sgsRL6uPeKPvj834AmTV1sniUFRJzZsuqBVk6GLbaO9DzudJDHKnPCe73BW/4whpRSZnYpqmXuFADjSi2sZPkTeEDsEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+J9jXJokKBOTxodSxaskDqb6UMlbKwDAv6IUICcq7I=;
 b=auYrhZBFmwwP6kQwBJfuy4wG00r6aBQHFrkXTZmzZRVyHIUfpakFuF0jNK+h54oDIhz69dmLHBpy4NJ0eu8DVGywwDLSJP5eh0iq7FrwGn0dCBXTC+BJ9O2QWBjiKWLWozT8AkIN7P1N7uvkO2h9i+hQ0uvi+6JlOCfb/ysDiq9Tyin5sEn5Z1S6ndWDbyeRKfRm1lATFgMVZ+2XO2iEKxaWq8BA0cIUZ+L/xp8tPVr9+FwY9JYNnHIzqSunkLjvAj2aQamsQK47ebXuHtEeAtkUTCdUq1iN/xTgJw3eOIY6mq14OmEldeuc2TgpgaO3wzHhQJPrTfxvz5dvQ8BhZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+J9jXJokKBOTxodSxaskDqb6UMlbKwDAv6IUICcq7I=;
 b=Y3mWmufn1YYyqi4ris6WSl2taxRgfC4UofwAHJl/JBb4M0qIMYaIureJlUvz7XogCP6X6xyrdIkEdVAEDEN1QARpHTzZahBmkrViW8nLpOZqPIPzTaHll1i5KMznfOfiOiGk/tY2ibKTk5+zuaFuiNUV7bEjlPJejDkp2jQywxI=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2837.namprd10.prod.outlook.com (2603:10b6:a03:81::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Wed, 22 Dec
 2021 23:04:36 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.024; Wed, 22 Dec 2021
 23:04:36 +0000
Message-ID: <a9ad1200-574d-b763-c8ba-2d7a6be88428@oracle.com>
Date: Wed, 22 Dec 2021 15:04:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6 10/13] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211222142100.158423-1-elic@nvidia.com>
 <20211222142100.158423-11-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211222142100.158423-11-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b3b100b-3e10-4b10-f33f-08d9c59f6cc8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2837:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2837EACC008B6CDFB88E9741B17D9@BYAPR10MB2837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rO374HsCPNW2aE0AQo+f9SZYdKwRUPDId8dna9Riuhwn/yCQjvEy2755hjZelJwO6ElKxOc3nJKBmSgF7P0DhxR3Ld1Ax4Q2xkmqYb8SO66d1leaI5mLDVhCaWooV+z2ISVYZU+tw41T5K40WmdhVfcl6/Pu5R9ICLERvelDQS1omcWSf7YBe62hg+mSB0V2btTOYspEUYtVP2w6m84Sg/MLiEYhpRkWm+PJzkUr+Ijx4PM6lOLSldsWSmzQtoZyeHWpRwfZRYyiKS343kLgsT9CK+jaGLuCEK8ZmXzZ+KX17zj7bmqMirlofmyZlyQDa2ONf2cqsiTrQoWUYfozc/EpMVYB3HOOAUcJcZi9pcthp3BNC7Lm4sKvwu5PF7NOqX25FCHQoFLY4H2xasJXDKk1QwHPYCjUTmt3Yv3kj6oZUHYPAll4rXU+4Ei4oLZKdrmfzRnmGibzIqSRDoaY+9xYjgbju4eRq0O4snOfH6kxdCMP0bclpqAbDupAHLI7cPzDkJtChd78Jjy/ZejXeV0muA0clQck/roScj0Jf5wKRi/B0kRo47tyBfdsl/T9inAL0h1TT1seci/YwpOeTe0n4G8WizxGekk1UtPVSzBTXG5LZyHcAFjH+oZe2HAEYN/iXmBqTcMXjOVWHHWQNP+1aUQNoDJnY35ixNDSKBQr3jdDhUVT24Mw0+p2elf6v1DIzluSU3xnInRnl6y3oR7el2Os6UAsEg2x7LI7/eE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(31696002)(36916002)(66556008)(38100700002)(5660300002)(6506007)(8676002)(66476007)(6512007)(86362001)(6486002)(2616005)(4326008)(66946007)(53546011)(26005)(83380400001)(6666004)(508600001)(186003)(316002)(2906002)(8936002)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVV2RnNlYklBdm5CVSttNUpiRjBrUlVGaGFsc1Bad3VBNXBkTFNRdEsrNnZG?=
 =?utf-8?B?cEFRRzFyZjhJQng3bVZZR1ZXcHBNQTBUL2llSm1QYjNRYkdNZkw0cmRCOWh5?=
 =?utf-8?B?NG4wYTN3TmJtZTRvUnVKSXZES2MwSWtRblNuZnpPbGFrRElFTHVKVnZCelZ1?=
 =?utf-8?B?QlRvMnVXUy9mYkFrWVBzMUEvdDlXTi9sVU9tQnN1V2RGb2NKdGkvZmh5RE9r?=
 =?utf-8?B?MzNoZEgwOW95Zm5aOGFaRTJHbTR4S2VaSVQ2N2hBM0I3YlU0eThIRFJTaUd2?=
 =?utf-8?B?cklLRm5JdkZlTnRkQ3krMFVTUWFaTHhQWGZCTmxuRjJ5Uzl1aVU1ZG14eTY1?=
 =?utf-8?B?bTl5U3JqTUc4cWlRenk1TkRML1dXWGlJUmxvK1Z0Ui9zemhNczB0ZkNtOEpk?=
 =?utf-8?B?dnBYbjQvWUIyZzN2UXY2NVhyRUE5NnROY0U3bjAvS0tsSDhhck9teGwyTW0w?=
 =?utf-8?B?THF1VFhPYTEyblM4VnVvanVIVmlya2ZFaURxbkFyYzhESnFUQ2Fjbzc2Ry9k?=
 =?utf-8?B?cTloRlYwYW04S1g0eThYSFMzN242RjZhZzRNdEpOTWpvdlhlUW16eDk5dWNz?=
 =?utf-8?B?ZTlSenBkbFhyTGRGSTNYSG5uZlNEejlNeStKbWFjcnZNRUJzRXRPNUlhUGFM?=
 =?utf-8?B?c2FTbFl5aDNvNi9xaUxjNUE2WmpVREpDTHFidlpJY1BQWnV0Ylo2UVBvN1Yv?=
 =?utf-8?B?a0hLNVplTngxTEdxQnNhUy9rNmZXSlNqVVprR1FDM2NTWE1UTHBCcVBuN0Zm?=
 =?utf-8?B?TDk2a3cyUW9JaWttcnU5WVAySjdteGhQVmdwWXhqTnE4bmJEeVd3dEFIb0Yy?=
 =?utf-8?B?WWduT3RnemVFRERqQ1pxNE9VUmoxVi9xME55QVhNR2dNVzNnVzdUMjBEZEFX?=
 =?utf-8?B?VERZYWx5QnNHTUphbmZZVTNCUklWTWJialZiSS84MkZEUlRpZndPTmdaWHNt?=
 =?utf-8?B?QktVb3UwcEVKTUthL0RwaURtOFRtWUo1ZmNCY2V3UVQ0R3ovS2ZuNFRZTU94?=
 =?utf-8?B?NjdUVE1MTVVzSysyNlhsS2pYdk9sdDNlbWJFc3NaYlZIU3YxVDQxL211c09U?=
 =?utf-8?B?b2FHQy9LYVBFR2VVYlJNQ2JobTkzZnQrU2duMVpwTkRUMjhSSWg4VFhsdnBn?=
 =?utf-8?B?d0tRWTdqWVVjLzJ6bVB6T3Q0WDlQdko0RWpTbUd5eDBkS0cwdjlHaDk1dmlY?=
 =?utf-8?B?TDRPQzQxOWI5VDZhMDFGK05LbmFSeDJ6TVRRMUFpVklIY3JKeTM1Zk1VODg1?=
 =?utf-8?B?bnlqTk9ML25PMDR2SElmYTNYRWpyU0orMElDTHdDQlBtSHpkRmJBckNwbElo?=
 =?utf-8?B?Y01HSzMzcFVBNWNBMExTR0Q2QVM3amNYQi81YXdTTlBISWdZOHdNUlBzWW9G?=
 =?utf-8?B?YnYrTGsvTlk1ajByV1p1SEwyOGE3Um5jRmJ5NXNWMkFxUnBQNW8vTmhteG9n?=
 =?utf-8?B?N3YzdVRHY2l4cFlSYnZiRE9OaDdmSzRmSmc2bFBKRkRpVFZ5ZUpUajBaSWJl?=
 =?utf-8?B?R3R2TjYrUkIweGZuakszMzZYMlQvV1B3enhVK24vRHdEMWN6c1N6Qys1M05G?=
 =?utf-8?B?ZEJNcDZWYzlTT3luNkdKQU1oaEdsemY0ZnlySnZYa0YyVFhMZ1hqVDFnQUZz?=
 =?utf-8?B?S0RjQXE1TnJyKzk5UE8yVXp3M2RIa08vYkVvU1JIT0YwVnI3Q2pFejJnZXpR?=
 =?utf-8?B?UG15S0xsQ1lLNXZJUmFlVGZPYnN3dklDSHFmNElxV2UrNGxmRldiRktaSElH?=
 =?utf-8?B?WC95U2JocFAybTJUSkZpQ2xpSUpjeUpCR1l6VmJLRkxiUlZwMnBXZTVzRzUz?=
 =?utf-8?B?TFBWNkhHeURvZDgvQTdDRkpuM0tLMHVjMHNCUkhJNnFSVVl1d1h4cEJ4Sk5m?=
 =?utf-8?B?YnR0Vmh6Ni9VMmhabWY3TWY5MWtCbFBzSVpCLzNrcStzN2dvL2ZuY0xEYXpE?=
 =?utf-8?B?OEV1K0xaQjdiRmlIRlY0QUpVcnZsalJjZWtxTkpDcktrblNhTXEvallWQ1hO?=
 =?utf-8?B?cHpYay9HS1dNZ1RFcjdDYWNyaUVmdGQ0OTNkQUlVYmJtTWhIQmN2ZnVQOXdJ?=
 =?utf-8?B?b0RVYndUWnFXa0t6M3lSQkZJUWtNZmREM094dVVxYURyTjFISlF0UE9Qa2dK?=
 =?utf-8?B?aWpZa1k1UHJxSDk5azQ2TVJFT2Y0RTZLcUZucWtScDUxQ3VJMWpkVGZSaTZX?=
 =?utf-8?Q?gn2vLLlAA2dusMEWiBVVHCY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b100b-3e10-4b10-f33f-08d9c59f6cc8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 23:04:36.6466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/XzHyX8gTDGxlCfzZQexd6OMvhdgY8OR3qwjYL1p/i8l7utkMKngz7fez9Rr7h6sw3yfJSw7mceE2cNDh5y4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2837
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10206
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220119
X-Proofpoint-ORIG-GUID: QJxwFuYA_Itvd1JGWa8sllaaNt9stCUO
X-Proofpoint-GUID: QJxwFuYA_Itvd1JGWa8sllaaNt9stCUO
Cc: lvivier@redhat.com, eperezma@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 12/22/2021 6:20 AM, Eli Cohen wrote:
> Add max_supported_vqs field to struct vdpa_mgmt_dev. Upstream drivers
> need to feel this value according to the device capabilities.
>
> This value is reported back in a netlink message when showing management
> devices.
>
> Examples:
>
> $ vdpa mgmtdev show
> auxiliary/mlx5_core.sf.1:
>    supported_classes net
>    max_supported_vqs 257
>
> $ vdpa -j mgmtdev show
> {"mgmtdev":{"auxiliary/mlx5_core.sf.1":{"supported_classes":["net"],"max_supported_vqs":257}}}
>
> $ vdpa -jp mgmtdev show
> {
>      "mgmtdev": {
>          "auxiliary/mlx5_core.sf.1": {
>              "supported_classes": [ "net" ],
>              "max_supported_vqs": 257
>          }
>      }
> }
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c       | 3 +++
>   include/linux/vdpa.h      | 1 +
>   include/uapi/linux/vdpa.h | 1 +
>   3 files changed, 5 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 462da4968270..ea22aa864dd5 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -514,6 +514,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>   		err = -EMSGSIZE;
>   		goto msg_err;
>   	}
> +	if (nla_put_u32(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
> +			mdev->max_supported_vqs))
> +		goto msg_err;
>   
>   	genlmsg_end(msg, hdr);
>   	return 0;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 47e2b780e4bc..bd75af4feaf7 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -448,6 +448,7 @@ struct vdpa_mgmt_dev {
>   	const struct virtio_device_id *id_table;
>   	u64 config_attr_mask;
>   	struct list_head list;
> +	u32 max_supported_vqs;
>   };
>   
>   int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index db3738ef3beb..995257c6bf2a 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -44,6 +44,7 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
>   
>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
> +	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u16 */
s/u16/u32/

-Siwei

>   	/* new attributes must be added above here */
>   	VDPA_ATTR_MAX,
>   };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
