Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5399AC07E94
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 15:17:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEE761404
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEE761404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A157D606DF;
	Fri,  4 Jun 2021 15:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsBTjWtiaRfJ; Fri,  4 Jun 2021 15:17:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id B683F606EC;
	Fri,  4 Jun 2021 15:17:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98E02C000D;
	Fri,  4 Jun 2021 15:17:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C05E0C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD4D1415AC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="atmPTtnG";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="cf/5aAY9"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UB8gk75fI90l
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:17:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B0E24159C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:17:44 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154FFhg1118927;
 Fri, 4 Jun 2021 15:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lkdmvMJ0L79F4fBteLVyjOkCyOTa9DFq93wn9vo2NQw=;
 b=atmPTtnGVqca3OzUIAYDIwHdaJlVvXS0ujseLq6jYYZfgHnOmToxenPNp1wJDDRRd0i9
 AYZrlxX7fb4Wk5qca+pWFwckbc1o+QT4vZufBQohvsfwDh/RviY7YyO1QbBFpL/eKheC
 gxMGQcNnAH/MmGkCQycUdR5BVYH9j8Jrf7CdOeUIg1IOd8qkUZXevufr9ZSl7xL/4Z43
 3jWiCKWPrTpeLb6KcVYU6FOabl3W4J6qNoINFYhYCSap4MNsWomY7LzIHlKPfOEkV3dl
 E2QdrxIqZxf9wK46W0jFps8qW0XesytDtGPt7mNWkaCzEhewjhOELF7CN+hiJr7BXx7q Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 38udjmx82b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Jun 2021 15:17:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154FFelU022346;
 Fri, 4 Jun 2021 15:17:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by aserp3020.oracle.com with ESMTP id 38xyn3uxn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Jun 2021 15:17:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU6QKuORwFicpWZzYar2VtN/c19QCBPa3sq6EgJteHWvlkgozJlc420NEIzZAgSVmhwFf9PkpWtrt6PtGSwe5x8yG2jyoU75gyZp48YT/e3w0t0lx48rb2NY5CqAsNUZXznjSXX+Xk5OysaT8L6/3IySssGOVsge/7Wil+jJOKlIpkIa5qWZYfACOuOFe12zjtHIXD5B6h2/Alp8XJKiTF3ibyoQ92gMAHKYFGn/WZehJIh1EXhUPy6JKlioqYMOkfxUqZE6sH/xACRIVDbbh/haCg6lt/8aJ+gHmiLWfQaup9TneyjETQYHoEvz6cbI1x2dCiQOafJAe8XkEx6jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkdmvMJ0L79F4fBteLVyjOkCyOTa9DFq93wn9vo2NQw=;
 b=k9ymQy5yPKDLwF8QQlpxSlcHpwPeY1mX3JQ1zXll0UVBbt3XMrQhplw041NCh0YRXN+GQrF7NqbdvRmeLInEwQ6tYA7X8xJ1QJDt4d0kZSBN+9nY2FqM8UjxdkNkyXH61KSViurNQYaUs+A5DdLNGmw065Va6Xrp1DprYsZgj4keY2evS38ipoedRBbTbP4bamI8Dk5E6PVfQUj9uQC+l/To8Vk5xgMpqy3huNV/fGoaIAVQ4QrAiBnvJkzUXuCkYx6/5CB8lpbaa0cRgFtWgJKjxgC3/D46U63BZUSWxrCSwSGy/+M2NahXUbgbiwM8WTq/t8e3W0JjQRSZa4GXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkdmvMJ0L79F4fBteLVyjOkCyOTa9DFq93wn9vo2NQw=;
 b=cf/5aAY9XWDc52kUyoJpJztwIIrT8IvXVsSMoRDUU6XCnUdGfOqO9kA/K0+29uxg5WBkdMGTpEKGw868aCdjKlUmzC7ZquB4raN7/R5MBgaxvAudmUgwDOcqNZlwgX7yw4/w6Un2VNrwzC4w5jQL1lcmreLT/CaSNF9ifmaYl0Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3971.namprd10.prod.outlook.com (2603:10b6:a03:1f6::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 4 Jun
 2021 15:17:26 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8111:d8f1:c262:808d]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8111:d8f1:c262:808d%6]) with mapi id 15.20.4173.027; Fri, 4 Jun 2021
 15:17:26 +0000
Subject: Re: [RFC PATCH 0/7] Untrusted device support for virtio
To: Jason Wang <jasowang@redhat.com>
References: <20210421032117.5177-1-jasowang@redhat.com>
 <YInOQt1l/59zzPJK@Konrads-MacBook-Pro.local>
 <9b089e3b-7d7a-b9d6-a4a1-81a6eff2e425@redhat.com>
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <e8a35789-5001-3e17-1546-80fa9daa5ab1@oracle.com>
Date: Fri, 4 Jun 2021 11:17:13 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <9b089e3b-7d7a-b9d6-a4a1-81a6eff2e425@redhat.com>
Content-Language: en-US
X-Originating-IP: [160.34.113.159]
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (160.34.113.159) by
 BY5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Fri, 4 Jun 2021 15:17:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7f79873-eb85-4c83-3471-08d9276bdc55
X-MS-TrafficTypeDiagnostic: BY5PR10MB3971:
X-Microsoft-Antispam-PRVS: <BY5PR10MB39710CECDF621A624DD82309893B9@BY5PR10MB3971.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: De4mhXAwhA6hIeBmz+F6y4Jad/A95QDjh3NruzXUpHqI2BnKN/SvJLjexWjUEJ9/8Fsna43rghRsaEcqT+BqAcS+Im3n6pLQOwGCqmxYsNKruJXMNIS0EbDn5mhlXnkr/Ipw91XrQHHNTc7X6KPY64u2I0IdWXP3grWPLDMwvhmaJt45nmdUzOld/5nTtXpnmK7qTb56EBfUGv+ZH8fbyikqbmJFIjX/oE476ZvbRkN6gWTaEoODeJ3Vll7W+Gky9AJ5yr+v8mk/07JZ0X/HYwXRWOd3IIiyzm3lk8PmusBJJhEhCILcnkqrb5R+pSqOcJrwhHgVrJx+I+/b6wZcrS2kytbr1oSy7FgT94BELW1LeSr7oI5seFuzhXJrM8wVnwLiAHuGuZu2RI/znK+Uc+ZJ+A9MXRcaQwCAyvNTMml+3GlCceOKuVQu0tvosfXC6uxzji06+KS+oHnyxQ0xzSJe5JGtPKFkQs/ZEA6swlxkOZfvuIcR5IwYMe7WVkSnOcIq/W+S4OeYfVCI9TxAnrUDkoTYVUvuLr23Lz/tyJIj6lxO0nyGEvFBJDm117HgtC36L98BgeRQT0wigYtOoibVC1nbBpiNep0JNQMHhRgCq/nW/JR6IFq+JZBxn8WmtQFlDDwtddws+BkB9ZmI0euwZYl1rWHZLqv1QHOPgch5ycew4b+IN5GCsrhDPaa6zEtYjCtHWDi+f1Erdb+gw9aC3KmR9eQ2cGqMgMuJR7SFM/JZlJtXBf8YhIFxLqcZkFPGLnReJiPK/TwLos7qksVZrUGMIy7dtO40U/JwaBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(376002)(396003)(346002)(136003)(6666004)(6916009)(5660300002)(6486002)(31686004)(6512007)(38100700002)(83380400001)(36756003)(53546011)(86362001)(31696002)(6506007)(956004)(966005)(2616005)(7416002)(4326008)(316002)(2906002)(26005)(66946007)(66476007)(8936002)(16526019)(478600001)(8676002)(66556008)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Nk0yVTJycjlRSFhSN0N4TTNHcGNNcXF6Z0xXV040NFR3S2x6UGJYWktGdGdZ?=
 =?utf-8?B?VDhxd2lLajFLanozUzlrR3JTZjBCWUNGSS95NEhKU21wNjRSU0IwaW5oK2Vt?=
 =?utf-8?B?b2RIVk4rSlh5MTU1Q2dEQW92TmdXY2FjQkhqRHdISTdFYW5zZWdlSjdnL3Jz?=
 =?utf-8?B?NDg1ZUJWYUFUaEhOYm9ZMnVqSHhSRVY0VUpjaHpjQVlQV2JhcFFMYlppcmlo?=
 =?utf-8?B?Yy9QdHVSZTEvcHM1ZmNBODVrVkppRngyNE1KVk16YU5LQnpSNU9NbCtUNjIz?=
 =?utf-8?B?c1dnVmVaQlJPNTZyK2Q2V3RiR080RGJJWmUrNHZHK3piYlZZYi9WZ2R2SEpK?=
 =?utf-8?B?Qno3UU5jVkJLSDUzM2x0UE9LazFEUk11dittSUMxZlRNMTdxbGY1UlM2L3lD?=
 =?utf-8?B?UVBOOTd1WGVRdUdFcWpLM1hWaFN5NkgxSjk3a29kTHdXblVYZEUxTjl5eUJj?=
 =?utf-8?B?dDZvSE9ldUNjOERVWDk2MHhXcnArcE9yaWRCTUtmcDQ4NUxyaEJJRFg3MFdp?=
 =?utf-8?B?SHBzbENLWllhSzdnV1dqZlU0Y1JqS1NlWjFQZUdKQWlHeDYxbmVuS2Y1ZjV5?=
 =?utf-8?B?dm5rYXRIbzh2dC9tWnNqWHllMGhaNzhKK0d4Q1hoMEZ3NyswVmxtNXhtUHlQ?=
 =?utf-8?B?QXN4ZURUQnV5Vzc0QTVzc3NGdXBhWFprTHNuK2JZZ0tUQk1KZ3lIU1EyUDJB?=
 =?utf-8?B?bXc1ekN5UnkvT2hFY04wdXNTUkVsMmRnLzBmeDNUUFMzMnJrWWx3VFhxQkc4?=
 =?utf-8?B?QUQvUmhlNFUyaW9wcFV4VC9zaXlQUUloT3RCUm9hOFMxNFBFRE51MmZOQW1a?=
 =?utf-8?B?OUxqd1dieFhtTHBFNmlFZ2dHWnFvZXMwT1RkcDJOSzg5VU80amhRZE5jZm5O?=
 =?utf-8?B?d2FUbFc5L3A0T2JobklVMDNTVVppTmNqMEtWTEovWjA0WVNYTENueVo5dkcv?=
 =?utf-8?B?VWgvUG1WTnFidW1qUTdGZXRrYkNNdUZNbCthNEtGenV3TUpta0RPSnQreXlp?=
 =?utf-8?B?TjQ1NTFwSG1QQ3FPU25WNTVoTlpKbVp4SlpSZjJWQThnWWFROVdPZDFBNy9C?=
 =?utf-8?B?eDlidnJVWml1SkZXekZDQ1Bjd0VIb1FpQ2FqRDVEbnc2a0ttVGNQaHFEQTZ0?=
 =?utf-8?B?RFlnUXlyRzdWeTkrS0V2cndGWWhLSVFrMXNvQndRT05SWkNiajBmOVZ5MVJ2?=
 =?utf-8?B?MFBBVnNiSmVmcmVRU3VZU0QyclNvZ3VUWTdHUW9wUllPeVpOZFhyOGJnUFlQ?=
 =?utf-8?B?Z0FUSU9zVlo1bURaKzQyNkdVQ1RybE5IYU5Xek5vSFRUODdJN3k4bHNIYWpz?=
 =?utf-8?B?WkV0VFo4V0oyUVFEUEkyamQxNDloR0Z4ZjR1V3czYjA1aXdQZmdtOWM5RXp5?=
 =?utf-8?B?V2RZQ2Z0VXk0SmwySTRZd3VwYUp2S3crbGdMMDRhZmxmTGpNZUVoSUxscjVJ?=
 =?utf-8?B?clprSnpaY1VaMTIrS1VtQ0J3VUZ0bGVLMTlGWUhhN3ZhVzU0bjhyY0M5NG5i?=
 =?utf-8?B?ZHdRQWltNHhVRVIzRlRNSVVqTXBBVERNclBzVjYzSDFnclNnSTdSb0JmZWNl?=
 =?utf-8?B?d2ZnUStKWGMxMmY3bkdRVkgyT3QrSWsyMUtzK00xNm5hZjRNci9OWjYxQzN3?=
 =?utf-8?B?UHpseUxrMUFBeXFPVkZNQUFGNXFCRXF1WnhBeHFLQWZLbXZJQzU1eHpQUDlW?=
 =?utf-8?B?a29FaERiT0RyOGhJSk5vNzRBT3loMWh3cXBvamUzV1B2OUpxR1d5K1FQL29x?=
 =?utf-8?Q?jlOvWABn+Lfe2VdRN7s//PxydUsQnzG+/wtCMUy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f79873-eb85-4c83-3471-08d9276bdc55
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 15:17:26.2030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnVh+4zYFtARLnDHhx+QAGcO7utjOBStIVlyQVSPOes/Gl3vQU7m8moNmK/7PJNiWLhjvS+ejEDL0uHAjjVVew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3971
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040113
X-Proofpoint-GUID: xWAyF49LS7lSjX8NkiqydekofsMfSr0B
X-Proofpoint-ORIG-GUID: xWAyF49LS7lSjX8NkiqydekofsMfSr0B
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040113
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de,
 martin.radev@aisec.fraunhofer.de, kvm@vger.kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gNC8yOS8yMSAxMjoxNiBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiAKPiDlnKggMjAyMS80LzI5
IOS4iuWNiDU6MDYsIEtvbnJhZCBSemVzenV0ZWsgV2lsayDlhpnpgZM6Cj4+IE9uIFdlZCwgQXBy
IDIxLCAyMDIxIGF0IDExOjIxOjEwQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBIaSBB
bGw6Cj4+Pgo+Pj4gU29tZXRpbWVzLCB0aGUgZHJpdmVyIGRvZXNuJ3QgdHJ1c3QgdGhlIGRldmlj
ZS4gVGhpcyBpcyB1c3VhbGx5Cj4+PiBoYXBwZW5zIGZvciB0aGUgZW5jcnRweWVkIFZNIG9yIFZE
VVNFWzFdLiBJbiBib3RoIGNhc2VzLCB0ZWNobm9sb2d5Cj4+PiBsaWtlIHN3aW90bGIgaXMgdXNl
ZCB0byBwcmV2ZW50IHRoZSBwb2tpbmcvbWFuZ2xpbmcgb2YgbWVtb3J5IGZyb20gdGhlCj4+PiBk
ZXZpY2UuIEJ1dCB0aGlzIGlzIG5vdCBzdWZmaWNpZW50IHNpbmNlIGN1cnJlbnQgdmlydGlvIGRy
aXZlciBtYXkKPj4+IHRydXN0IHdoYXQgaXMgc3RvcmVkIGluIHRoZSBkZXNjcmlwdG9yIHRhYmxl
IChjb2hlcmVudCBtYXBwaW5nKSBmb3IKPj4+IHBlcmZvcm1pbmcgdGhlIERNQSBvcGVyYXRpb25z
IGxpa2UgdW5tYXAgYW5kIGJvdW5jZSBzbyB0aGUgZGV2aWNlIG1heQo+Pj4gY2hvb3NlIHRvIHV0
aWxpemUgdGhlIGJlaGF2aW91ciBvZiBzd2lvdGxiIHRvIHBlcmZvcm0gYXR0YWNrc1syXS4KPj4g
V2UgZml4ZWQgaXQgaW4gdGhlIFNXSU9UTEIuIFRoYXQgaXMgaXQgc2F2ZXMgdGhlIGV4cGVjdGVk
IGxlbmd0aAo+PiBvZiB0aGUgRE1BIG9wZXJhdGlvbi4gU2VlCj4+Cj4+IGNvbW1pdCBkYWY5NTE0
ZmQ1ZWIwOThkN2Q2ZjNhMTI0N2NiOGNjNDhmYzk0MTU1Cj4+IEF1dGhvcjogTWFydGluIFJhZGV2
IDxtYXJ0aW4uYi5yYWRldkBnbWFpbC5jb20+Cj4+IERhdGU6wqDCoCBUdWUgSmFuIDEyIDE2OjA3
OjI5IDIwMjEgKzAxMDAKPj4KPj4gwqDCoMKgwqAgc3dpb3RsYjogVmFsaWRhdGUgYm91bmNlIHNp
emUgaW4gdGhlIHN5bmMvdW5tYXAgcGF0aAo+PiDCoMKgwqDCoCBUaGUgc2l6ZSBvZiB0aGUgYnVm
ZmVyIGJlaW5nIGJvdW5jZWQgaXMgbm90IGNoZWNrZWQgaWYgaXQgaGFwcGVucwo+PiDCoMKgwqDC
oCB0byBiZSBsYXJnZXIgdGhhbiB0aGUgc2l6ZSBvZiB0aGUgbWFwcGVkIGJ1ZmZlci4gQmVjYXVz
ZSB0aGUgc2l6ZQo+PiDCoMKgwqDCoCBjYW4gYmUgY29udHJvbGxlZCBieSBhIGRldmljZSwgYXMg
aXQncyB0aGUgY2FzZSB3aXRoIHZpcnRpbyBkZXZpY2VzLAo+PiDCoMKgwqDCoCB0aGlzIGNhbiBs
ZWFkIHRvIG1lbW9yeSBjb3JydXB0aW9uLgo+IAo+IAo+IEdvb2QgdG8ga25vdyB0aGlzLCBidXQg
dGhpcyBzZXJpZXMgdHJpZXMgdG8gcHJvdGVjdCBhdCBkaWZmZXJlbnQgbGV2ZWwuIAo+IEFuZCBJ
IGJlbGlldmUgc3VjaCBwcm90ZWN0aW9uIG5lZWRzIHRvIGJlIGRvbmUgYXQgYm90aCBsZXZlbHMu
Cj4gCgpNeSBhcG9sb2dpZXMgZm9yIHRha2luZyBzbyBsb25nIHRvIHJlc3BvbmQsIHNvbWVob3cg
dGhpcyBkaXNhcHBlYXJlZCBpbiAKb25lIG9mIHRoZSBmb2xkZXJzLgo+IAo+Pj4gRm9yIGRvdWJs
ZSBpbnN1cmFuY2UsIHRvIHByb3RlY3QgZnJvbSBhIG1hbGljb3VzIGRldmljZSwgd2hlbiBETUEg
QVBJCj4+PiBpcyB1c2VkIGZvciB0aGUgZGV2aWNlLCB0aGlzIHNlcmllcyBzdG9yZSBhbmQgdXNl
IHRoZSBkZXNjcmlwdG9yCj4+PiBtZXRhZGF0YSBpbiBhbiBhdXhpbGlheSBzdHJ1Y3R1cmUgd2hp
Y2ggY2FuIG5vdCBiZSBhY2Nlc3NlZCB2aWEKPj4+IHN3aW90bGIgaW5zdGVhZCBvZiB0aGUgb25l
cyBpbiB0aGUgZGVzY3JpcHRvciB0YWJsZS4gQWN0dWFsbHksIHdlJ3ZlCj4+IFNvcnJ5IGZvciBi
ZWluZyBkZW5zZSBoZXJlLCBidXQgaG93IHdvbGQgU1dJT1RMQiBiZSB1dGlsaXplZCBmb3IKPj4g
dGhpcyBhdHRhY2s/Cj4gCj4gCj4gU28gd2Ugc3RpbGwgYmVoYXZpb3JzIHRoYXQgaXMgdHJpZ2dl
cmVkIGJ5IGRldmljZSB0aGF0IGlzIG5vdCB0cnVzdGVkLiAKPiBTdWNoIGJlaGF2aW9yIGlzIHdo
YXQgdGhlIHNlcmllcyB0cmllcyB0byBhdm9pZC4gV2UndmUgbGVhcm50IGEgbG90IG9mIAo+IGxl
c3NvbnMgdG8gZWxpbWluYXRlIHRoZSBwb3RlbnRpYWwgYXR0YWNrcyB2aWEgdGhpcy4gQW5kIGl0
IHdvdWxkIGJlIHRvbyAKPiBsYXRlIHRvIGZpeCBpZiB3ZSBmb3VuZCBhbm90aGVyIGlzc3VlIG9m
IFNXSU9UTEIuCj4gCj4gUHJvdmluZyAidGhlIHVuZXhwZWN0ZWQgZGV2aWNlIHRyaWdnZXJlZCBi
ZWhhdmlvciBpcyBzYWZlIiBpcyB2ZXJ5IGhhcmQgCj4gKG9yIGV2ZW4gaW1wb3NzaWJsZSkgdGhh
biAiZWxpbWluYXRpbmcgdGhlIHVuZXhwZWN0ZWQgZGV2aWNlIHRyaWdnZXJlZCAKPiBiZWhhdmlv
ciB0b3RhbGx5Ii4KPiAKPiBFLmcgSSB3b25kZXIgd2hldGhlciBzb21ldGhpbmcgbGlrZSB0aGlz
IGNhbiBoYXBwZW46IENvbnNpZGVyIHRoZSBETUEgCj4gZGlyZWN0aW9uIG9mIHVubWFwIGlzIHVu
ZGVyIHRoZSBjb250cm9sIG9mIGRldmljZS4gVGhlIGRldmljZSBjYW4gY2hlYXQgCj4gdGhlIFNX
SU9UTEIgYnkgY2hhbmdpbmcgdGhlIGZsYWcgdG8gbW9kaWZ5IHRoZSBkZXZpY2UgcmVhZCBvbmx5
IGJ1ZmZlci4gCgo8YmxpbmtzPiBXaHkgd291bGQgeW91IHdhbnQgdG8gZXhwb3NlIHRoYXQgdG8g
dGhlIGRldmljZT8gQW5kIHdvdWxkbid0IAp0aGF0IGJlIHNwZWNpZmljIHRvIExpbnV4IGRldmlj
ZXMgLSBiZWNhdXNlIHN1cmVseSBXaW5kb3dzIERNQSBBUElzIGFyZSAKZGlmZmVyZW50IGFuZCB0
aGlzICdmbGFnJyBzZWVtcyB2ZXJ5IExpbnV4LWtlcm5lbCBzcGVjaWZpYz8KCj4gSWYgeWVzLCBp
dCBpcyByZWFsbHkgc2FmZT8KCldlbGwgbm8/IEJ1dCBuZWl0aGVyIGlzIHJtIC1SZiAvIGJ1dCB3
ZSBzdGlsbCBhbGxvdyBmb2xrcyB0byBkbyB0aGF0Lgo+IAo+IFRoZSBhYm92ZSBwYXRjaCBvbmx5
IGxvZyB0aGUgYm91bmNlIHNpemUgYnV0IGl0IGRvZXNuJ3QgbG9nIHRoZSBmbGFnLiAKCkl0IGxv
Z3MgYW5kIHBhbmljcyB0aGUgc3lzdGVtLgoKPiBFdmVuIGlmIGl0IGxvZ3MgdGhlIGZsYWcsIFNX
SU9UTEIgc3RpbGwgZG9lc24ndCBrbm93IGhvdyBlYWNoIGJ1ZmZlciBpcyAKPiB1c2VkIGFuZCB3
aGVuIGl0J3MgdGhlIGFwcHJvcHJpYXRlKHNhZmUpIHRpbWUgdG8gdW5tYXAgdGhlIGJ1ZmZlciwg
b25seSAKPiB0aGUgZHJpdmVyIHRoYXQgaXMgdXNpbmcgdGhlIFNXSU9UTEIga25vdyB0aGVtLgoK
RmFpciBlbm91Z2guIElzIHRoZSBpbnRlbnQgdG8gZG8gdGhlIHNhbWUgdGhpbmcgZm9yIGFsbCB0
aGUgb3RoZXIgCmRyaXZlcnMgdGhhdCBjb3VsZCBiZSBydW5uaW5nIGluIGFuIGVuY3J5cHRlZCBn
dWVzdCBhbmQgd291bGQgcmVxdWlyZSAKU1dJT1RMQi4KCkxpa2UgbGVnYWN5IGRldmljZXMgdGhh
dCBLVk0gY2FuIGV4cG9zZSAoZmxvcHB5IGRyaXZlcj8sIFNWR0EgZHJpdmVyKT8KCj4gCj4gU28g
SSB0aGluayB3ZSBuZWVkIHRvIGNvbnNvbGlkYXRlIG9uIGJvdGggbGF5ZXJzIGluc3RlYWQgb2Yg
c29sZWx5IAo+IGRlcGVuZGluZyBvbiB0aGUgU1dJT1RMQi4KClBsZWFzZSBtYWtlIHN1cmUgdGhh
dCB0aGlzIGV4cGxhbmF0aW9uIGlzIGluIHBhcnQgb2YgdGhlIGNvdmVyIGxldHRlcgpvciBpbiB0
aGUgY29tbWl0L0tjb25maWcuCgpBbHNvLCBhcmUgeW91IGF3YXJlIG9mIHRoZSBwYXRjaHNldCB0
aGFuIEFuZGkgYmVlbiB3b3JraW5nIG9uIHRoYXQgdHJpZXMgCnRvIG1ha2UgdGhlIERNQSBjb2Rl
IHRvIGhhdmUgZXh0cmEgYmVsbHMgYW5kIHdoaXN0bGVzIGZvciB0aGlzIHB1cnBvc2U/CgpUaGFu
ayB5b3UuCj4gVGhhbmtzCj4gCj4gCj4+Cj4+PiBhbG1vc3QgYWNoaWV2ZWQgdGhhdCB0aHJvdWdo
IHBhY2tlZCB2aXJ0cXVldWUgYW5kIHdlIGp1c3QgbmVlZCB0byBmaXgKPj4+IGEgY29ybmVyIGNh
c2Ugb2YgaGFuZGxpbmcgbWFwcGluZyBlcnJvcnMuIEZvciBzcGxpdCB2aXJ0cXVldWUgd2UganVz
dAo+Pj4gZm9sbG93IHdoYXQncyBkb25lIGluIHRoZSBwYWNrZWQuCj4+Pgo+Pj4gTm90ZSB0aGF0
IHdlIGRvbid0IGR1cGxpY2F0ZSBkZXNjcmlwdG9yIG1lZGF0YSBmb3IgaW5kaXJlY3QKPj4+IGRl
c2NyaXB0b3JzIHNpbmNlIGl0IHVzZXMgc3RyZWFtIG1hcHBpbmcgd2hpY2ggaXMgcmVhZCBvbmx5
IHNvIGl0J3MKPj4+IHNhZmUgaWYgdGhlIG1ldGFkYXRhIG9mIG5vbi1pbmRpcmVjdCBkZXNjcmlw
dG9ycyBhcmUgY29ycmVjdC4KPj4+Cj4+PiBUaGUgYmVoYWl2b3IgZm9yIG5vbiBETUEgQVBJIGlz
IGtlcHQgZm9yIG1pbmltaXppbmcgdGhlIHBlcmZvcm1hbmNlCj4+PiBpbXBhY3QuCj4+Pgo+Pj4g
U2xpZ2h0bHkgdGVzdGVkIHdpdGggcGFja2VkIG9uL29mZiwgaW9tbXUgb24vb2YsIHN3aW90bGIg
Zm9yY2Uvb2ZmIGluCj4+PiB0aGUgZ3Vlc3QuCj4+Pgo+Pj4gUGxlYXNlIHJldmlldy4KPj4+Cj4+
PiBbMV0gCj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvZmFiNjE1Y2UtNWUxMy1h
M2IzLTM3MTUtYTQyMDNiNGFiMDEwQHJlZGhhdC5jb20vVC8gCj4+Pgo+Pj4gWzJdIAo+Pj4gaHR0
cHM6Ly95aGJ0Lm5ldC9sb3JlL2FsbC9jMzYyOWEyNy0zNTkwLTFkOWYtMjExYi1jMGI3YmUxNTJi
MzJAcmVkaGF0LmNvbS9ULyNtYzZiNmUyMzQzY2JlZmZjYTY4Y2E3YTk3ZTBmNDczYWFhODcxYzk1
YiAKPj4+Cj4+Pgo+Pj4gSmFzb24gV2FuZyAoNyk6Cj4+PiDCoMKgIHZpcnRpby1yaW5nOiBtYWlu
dGFpbiBuZXh0IGluIGV4dHJhIHN0YXRlIGZvciBwYWNrZWQgdmlydHF1ZXVlCj4+PiDCoMKgIHZp
cnRpb19yaW5nOiByZW5hbWUgdnJpbmdfZGVzY19leHRyYV9wYWNrZWQKPj4+IMKgwqAgdmlydGlv
LXJpbmc6IGZhY3RvciBvdXQgZGVzY19leHRyYSBhbGxvY2F0aW9uCj4+PiDCoMKgIHZpcnRpb19y
aW5nOiBzZWN1cmUgaGFuZGxpbmcgb2YgbWFwcGluZyBlcnJvcnMKPj4+IMKgwqAgdmlydGlvX3Jp
bmc6IGludHJvZHVjZSB2aXJ0cXVldWVfZGVzY19hZGRfc3BsaXQoKQo+Pj4gwqDCoCB2aXJ0aW86
IHVzZSBlcnIgbGFiZWwgaW4gX192cmluZ19uZXdfdmlydHF1ZXVlKCkKPj4+IMKgwqAgdmlydGlv
LXJpbmc6IHN0b3JlIERNQSBtZXRhZGF0YSBpbiBkZXNjX2V4dHJhIGZvciBzcGxpdCB2aXJ0cXVl
dWUKPj4+Cj4+PiDCoCBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTg5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTQxIGlu
c2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygtKQo+Pj4KPj4+IC0tIAo+Pj4gMi4yNS4xCj4+Pgo+
IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
