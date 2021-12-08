Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F357FC433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 16:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B89540920;
	Wed,  8 Dec 2021 16:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l0GEqzOSiQj4; Wed,  8 Dec 2021 16:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0440F408F5;
	Wed,  8 Dec 2021 16:45:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE8AEC001E;
	Wed,  8 Dec 2021 16:45:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE45C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EB59403B6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:45:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="GEriBD4R";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="XG5YXETe"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eiVVAjUX-9rw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:45:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3366240258
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 16:45:06 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8F9ZX7025793; 
 Wed, 8 Dec 2021 16:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fY0CeSMngH9xHT82Y8wpAYVZy0KZf9uWx/2+egTqrwc=;
 b=GEriBD4R2zMCUG++TcjZwXnijegEsUpPI2+Ui+jIcU0lXTs/YFDeNs8POQgH4vGRyJN6
 Btk//hGFMnZr9xMR5BMNfernhsGMIJozqkde32hu1JytZbIUaY5rZrgX5YRMmchbO57p
 re5mIctghWEz6UAgk7Q0aaANeHW8ovl/2ye9JZdBQQO1RZmX7BCSZsmH6zVnBSAtBSpC
 ejbFU8XeqaQzluB32NMqt1Tv9v8FTlo7gKdDeLnLyz6UqhLIHG0PVMIpSK1tTTDozRjx
 hZJ0ILknwxw+I8kq2soI6olCohkP6zysnmHu0dDt344AGI1QDhluiz3PSh58+OipbWUV vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9ms05q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 16:45:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8GKBMK143994;
 Wed, 8 Dec 2021 16:45:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by aserp3020.oracle.com with ESMTP id 3cr056k0ah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Dec 2021 16:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXxfjZawJbiFL2UlKUevCdfx+L9Y0v1TEgHe9/KmILX8axa2d4OcUA7kGIHL512On6zCkH4gYRTDeRT9k6XJFHimji1Wd3QU7Pr/8QazsmQeLxwCM2Uf7bCquefXBu2XNO/6piac2mIFUfD6YsY/MB4QG8/yHb6BZD68+0QOWZVz8CDB0yss/gcsL39y5sch8E+vMxSue4TcII/uXPObjT9i5B1wz7FEwupA9KOyMyxhmKmoMpZhZ/LmSqN5Gyh21KwxfBuaELmBWgAkMtLI7i7YrnwvBZsyla6S3m4Vug1/OL7f1cDtncb7mIT3+Leej5Y6ewe2yuHS7hjvpxGV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY0CeSMngH9xHT82Y8wpAYVZy0KZf9uWx/2+egTqrwc=;
 b=gadmOEK2BZqqTxKAf+s+SU2DZWvwxq55Frak/LLQhQb4imuey5NodyRkCD1bLAXsoI837dNnPqcnR55cGgU5gOu3kUGlMl2iUSJMP1gn3KMPyorNhCrPfa/xREWSD6Oe5jisCfmfcmyliBDQq7ytfoDIosmi/+K9U00SIXAhEgjW5NDD1qFJfxT97YyFnfHWeJAjjbxV59NN1sYl0/0scyj8YFHBJsQt5sUf62rST6FeKN9Tl8jgiAmLhF/S/MqpqVqtcz1Z2oFmE9cZTHyyk+NKnNbXZV3nUM0tQXUraDNZBbUHgJq2R/dj6sPkOF6DqWzndQXpySqrtL5s023jrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY0CeSMngH9xHT82Y8wpAYVZy0KZf9uWx/2+egTqrwc=;
 b=XG5YXETe/P611UkeNwmeBKiz1vt5expgDzc0rnPTlQgcLzcpfjIHvLYekJQjgr4OryyKIrZ0KrHjE8LoYb2XqYlAUXAoh9wEwLJlL7ou+rEPV3D2jbgCdoELJP7oLzUzsKgySZvpGnA4L5eL90RmL3Ejv7cSE7waBfChx2J0oI0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1609.namprd10.prod.outlook.com (2603:10b6:4:11::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Wed, 8 Dec 2021 16:45:03 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 16:45:03 +0000
Message-ID: <e739499f-dbb1-f249-4c36-969dd810eb5c@oracle.com>
Date: Wed, 8 Dec 2021 10:45:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 6/7] vhost-scsi: drop flush after vhost_dev_cleanup
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20211207024510.23292-1-michael.christie@oracle.com>
 <20211207024510.23292-7-michael.christie@oracle.com>
 <CACGkMEtsMauWPP5zQQg0Z09A-jDVPcsoHTEAksy94aYbpZ0huA@mail.gmail.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEtsMauWPP5zQQg0Z09A-jDVPcsoHTEAksy94aYbpZ0huA@mail.gmail.com>
X-ClientProxiedBy: CH2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:610:54::26) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from [20.15.0.204] (73.88.28.6) by
 CH2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:610:54::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20 via Frontend Transport; Wed, 8 Dec 2021 16:45:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a28a309-4451-48df-0ae7-08d9ba6a14f6
X-MS-TrafficTypeDiagnostic: DM5PR10MB1609:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB16094EA9753F42BBF0827FC9F16F9@DM5PR10MB1609.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgqEwo9RWbsHt0FN8SoOhoJA6BitKJGpcDi1XSK5yoNd52JkhJcyTDeWwREiMGctRCe0wJSwntilJdoDUwn6fGQ4/pmBqfU42vOmYfUOleoR82HduW5s5vczri3TJjcIChPlppLqjuQnvvDJXKHvTkXTAjFaXCND9veN+BNhdDDEvX90ZABWnFhXgiZ661i3lvwm/z5E8YV7AeYeq2FIQsIfCPknA7RyugfwiVKOPfiTg4nSfiIYre93fZtaQoLsZigaSq1GziwaMjJaQyVQehTyWXmSS1IspSjqxCM9YSu+7+2kKkoBXz1fpnihif+7oku/hI4H+KLsypup4ZUKE05DtWlRTjVdR5BKmf0fWolFtYc4zyiwnH1csiyzzATrHt8yHHcQQmUCt1qH5NOaDvdqawGFWh2cm4YbFZ+RtamCcLpJX5wl49dFIfqBPesDP3smtQRTKYw79Pf7GzWDxTxOHPP75///JKU2qylzkQNRATRmVtHW0xwefMwPaTeSy9JqtVG1543ZqZpd8AU5w+lD3lS7FgpP69XnI7QX1n1qhKOOg3jOZNSdHhAHvRQUs9Pc1wMH3cd7MizAk4V5GTUbPIdrM1Ui+nzA8EAeyxRMEZAEW1ux8HmvDJdhC6n9bB+t9zox10JR8KxkxUjwFwF/djvt+i/MhmVIg52a1k7X/YQ5LWVnTNg42qYWXwCiZXJVroV89PLsE32C4VjJ0yW6dm9pvUV6M3wKGMRxiEX2n1O6DgkQ8+Zdwc4bRUu2qMIImc5Bt0r++yEImkIHOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(38100700002)(186003)(66556008)(31696002)(6916009)(83380400001)(54906003)(86362001)(66476007)(6706004)(66946007)(16576012)(8936002)(31686004)(2906002)(956004)(36756003)(316002)(26005)(508600001)(8676002)(4326008)(53546011)(6486002)(2616005)(78286007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmR1NFcyMlFUZXZSbldTTjNTS2JyVlMvZDY4ckJIZENjeHc5c3c4SDR4NUU0?=
 =?utf-8?B?cC9hNjBVdDZNVGZSbHFQRmF4bnBBZkgzK01iQkVHZmpwemtwendETlFJbmpO?=
 =?utf-8?B?K0VYYmVJblg2R3pLWXJjWWpXclgxaXN1Z1kvYjJ1RHRadnl2OGVYNE5vVWw5?=
 =?utf-8?B?NkxqbzZpUWJvUDBCeU5WT1RoSFhVT3loczdhdWErK3gwUjA1RlZJTzRaajZw?=
 =?utf-8?B?ekNLVGhNeHVYYjNMQUR6azIrSGdzRytOMGhFQlFHb01wSTBrV0M2OE16aEZt?=
 =?utf-8?B?SU9wZDQ5UTB0bGlVWEZRQ2lSdXVrTGh4ZENRcGQrWDBuY2p3WElBVWtxSnNF?=
 =?utf-8?B?STVyMVk5QmFkdkl2aEt6MC9oYWoxRUUwZlg1Nk5rNVhQdmlxZWtRZW5OcmJw?=
 =?utf-8?B?L1NLcVdlVytTZkxrRTd0K2wxVlF5bEV6MmVuc3VXbTlHY2xzVWVHL2l1V3RB?=
 =?utf-8?B?eEVEUGFXYWp0dXk1K2xDOWZPL0dIcjlJZ2tTVDB1NWY2ZE5IMTY4VUJaMmsr?=
 =?utf-8?B?bXdBbmFNT0Q4ZW9UTEI3UWg4WXNqbWJWNEdPZnhkSldnalY1MytWNG1KMTZo?=
 =?utf-8?B?Mjg4d2pTYklSekFDUWFNNlVDdGY3bGNqK1FTcEpJR0JFb2M3SVlSQklaVXl5?=
 =?utf-8?B?VnNlNkx3NzQ2WUphVk9uaEs0NXJucXN5Y2J3cUFhWHUzTnpmNFdhbDlxSkZv?=
 =?utf-8?B?cmIweWJ0dmx2cHNNY3NzUzVkaXhpblVzRFFPcWFBSmxvQzl1SFF4bG5qZXBG?=
 =?utf-8?B?RVFEMlJRaGNUVHNaSnFIZGlWMmY3dEFtbGs4UEhhWHFvOTg1SkFmcUlUSzJR?=
 =?utf-8?B?RUQzSm9VYWpuaTdyZHd4MFh0VUx4Y2pVLy8xTTRkdXl1U0hCK3lZQmM3SVZq?=
 =?utf-8?B?V0l1ejdjcERETitCZytnZURWUW9ya1ZrTFZuNUtwVytlYlY4SlVvQnV6WnlM?=
 =?utf-8?B?c1UvSzFIT2RaUkhxMjNDdjR4ZjRKQUFGeldOY3Z2NzkreDFZWGtkL2ZlMThh?=
 =?utf-8?B?YmRJYkVhYWpPeWQ4ZUVYNEdIYVE4YXRWWHQvY2ZKSC91a0lXS1RsWVZ0dUds?=
 =?utf-8?B?TW8wNDF1L2xPZXNDQkNNYmtlYXF3THVYaExoSGUvK3FiMS85MEdjTy85bmti?=
 =?utf-8?B?ZFhFN2w3UEZscGYxWVowWU9Hbmw5QUxaSHh3ejBJV2VFaHAyWGxjREVKQlZD?=
 =?utf-8?B?ZE1kQlo2ZkU4OHVvL3R4VjU1YnpCWjBCQmcyWEJqcTBWZXJjV2Vna0FVbDQ1?=
 =?utf-8?B?OUwzaUlGclJzNWVzODR0Zkw5SlZSREkzaGZpRHBERlM1aHlXWTA2L2R6Mno3?=
 =?utf-8?B?KzNZOVAyOVhSdnpkUmNiRzZoNzQrY0NjUndTd1dEVmNnL1A2cXBYL2VBRjNF?=
 =?utf-8?B?Y1RqOU5FenFCb2JxQnNscFhiSHFKemtPaldFeVdxUnRsYXA2UUZmdnlvejB0?=
 =?utf-8?B?L013RVdJME5WaU9VNlZtcThRNzE1R0lGdVNFamptcWhVRFE3aERWd1FiQ0k3?=
 =?utf-8?B?OHIvc0YvUEYrNjltNzBiTDFabHlRcWhRN2FBdEtJWTZmQ3NRN2x6QUhDRWNu?=
 =?utf-8?B?ZFZzY2J6WCtzbG1IdGIyaUdyNTVNOE1UWnluL1FUckVOL1NaN0hxM0pncjhI?=
 =?utf-8?B?OXFGK1UrNlhMYjByNFNVL1F3cnFpVmNVSzcwZVBFYXloQjVRYmNWSTBkVFk1?=
 =?utf-8?B?aTZqUWNyaEM4L1drMlhMYko4azdNU1pJeUNGQ2d6ZWdYL3ZnOEw4d2NFNzZy?=
 =?utf-8?B?RW9BSmxkaE5OcVdqR0VtQm14TlpEMjdINzE4RVlheW9Dc2lSMTlJREYxQmJR?=
 =?utf-8?B?aWJGeFVNb2VBQ21mN3FoaEdRcHpxbHNjTkloaGlDUmZkVVlRaUR6a2o5UjlZ?=
 =?utf-8?B?eGYvTWZsTUFnRGtTOUNKZWxxNmtmVTlIRFJhaDNVbXV2SmoxZjBsOHFQUTlP?=
 =?utf-8?B?T2JWN0p1UHA1eUc3c2pVajF0Q1NUN0g3UW5GeEExNy9RVTNZTGhIanNrZ0F6?=
 =?utf-8?B?bGZubitqdHZvdUg5dXo0T3dtZFRIKzVrZFpsdXg4ditTaUlyY2ZLU2ZwdGsr?=
 =?utf-8?B?N0xQV0JKRnJlSFJRN2hrelhJa0xLaHZDMW5BYnVpQ3A1Nkp6ZlNNN21qQzFW?=
 =?utf-8?B?a0ZxRXBzQWJyY3BIbXhzUlBDOWN5TGptOEp5M3N0cE9lTm9jMTZJc1Ftdnpm?=
 =?utf-8?B?VnNxNHE1S2oxM2tSVG45NjQxZzRBQ2lQaXQ5VEFuVkFBYmthTWg0T2lEcUVq?=
 =?utf-8?B?d0xEVk4xWGZ2Z2hjSmd3YitlWjJ3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a28a309-4451-48df-0ae7-08d9ba6a14f6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 16:45:03.1923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ten8pJSDDyg6Im8yZCkfBe6D/2rlsZPTBRwynSXklXcjc+PEIDxM5l189Q+4l+WZBxUZWH5MW4CHmSgjmwjnxA4eDNdIigKP4EOCFeth3YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1609
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080097
X-Proofpoint-GUID: DJqeN8pZcrX0P2Zpg6mnrBqE-UZGf_qP
X-Proofpoint-ORIG-GUID: DJqeN8pZcrX0P2Zpg6mnrBqE-UZGf_qP
Cc: Andrey Ryabinin <arbn@yandex-team.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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

On 12/7/21 10:07 PM, Jason Wang wrote:
> On Tue, Dec 7, 2021 at 10:45 AM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> The flush after vhost_dev_cleanup is not needed because:
>>
>> 1. It doesn't do anything. vhost_dev_cleanup will stop the worker thread
>> so the flush call will just return since the worker has not device.
>>
>> 2. It's not needed for the re-queue case. vhost_scsi_evt_handle_kick grabs
>> the mutex and if the backend is NULL will return without queueing a work.
>> vhost_scsi_clear_endpoint will set the backend to NULL under the vq->mutex
>> then drops the mutex and does a flush. So we know when
>> vhost_scsi_clear_endpoint has dropped the mutex after clearing the backend
>> no evt related work will be able to requeue. The flush would then make sure
>> any queued evts are run and return.
> 
> What happens if a kick after vhost_scsi_clear_endpoint() but before
> vhost_dev_stop()?

vhost_dev_stop also does a flush, so:

1. The kick handler would see the backend is null and return immediately.
2. The flush in vhost_dev_stop would wait for those kicks in #1 to complete.


> 
> Is this safe or the kthread_stop() in vhost_dev_cleanup() makes us safe?
> 
> Thanks
> 
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>> ---
>>  drivers/vhost/scsi.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> index 532e204f2b1b..94535c813ef7 100644
>> --- a/drivers/vhost/scsi.c
>> +++ b/drivers/vhost/scsi.c
>> @@ -1827,8 +1827,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
>>         vhost_scsi_clear_endpoint(vs, &t);
>>         vhost_dev_stop(&vs->dev);
>>         vhost_dev_cleanup(&vs->dev);
>> -       /* Jobs can re-queue themselves in evt kick handler. Do extra flush. */
>> -       vhost_scsi_flush(vs);
>>         kfree(vs->dev.vqs);
>>         kvfree(vs);
>>         return 0;
>> --
>> 2.25.1
>>
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
