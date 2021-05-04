Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DDAC433ED
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 20:11:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E2E613CB
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 20:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E2E613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E2F641861;
	Tue,  4 May 2021 20:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GEXlTXe8yxzx; Tue,  4 May 2021 20:11:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1C7541856;
	Tue,  4 May 2021 20:11:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8895CC000E;
	Tue,  4 May 2021 20:11:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63906C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 20:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49F7960C34
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 20:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="k5NRBR2z";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="MEO5l0Jm"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pVspMY9Q2eKz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 20:11:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A13C60C33
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 20:11:43 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144K5TFE011586;
 Tue, 4 May 2021 20:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=azQ+wGhcGGxkZUCE7bKZRQ/wbqmbylqdAiMejMvrsWw=;
 b=k5NRBR2zTJQ6o2b8TAvXOF2lE3otmOC8kadu8x2a0QFQ93cnQw922/JZzJMQyxjZSRAI
 X9UQsTAhTY7mPvKRORtELP/IZFB21AgtQG5tkEN7peihbk7fuL7BHVKoCDjbpxr0/ibO
 Q++28ZxL6OYrr4E0+EuC91kgok7EUVHK/nphBMqQutLrJBI9MeIrX312Fl9/yIG0kaFg
 bgPrw12jBFmSYLiXq5naL4qPGtfHBbJYoVmb85ZyKN5QP4IRRh185a2K9rguoBvFpZPS
 yEdy7EoA2n1qVA/xWGSbhpp7q+AfCD5QmF5c9gK5FbthqUA4Vvi4sk8PrMmcnmkDsRL9 Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 388vgbrddr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 May 2021 20:11:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144K5PXc081935;
 Tue, 4 May 2021 20:11:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
 by aserp3030.oracle.com with ESMTP id 388w1egb45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 May 2021 20:11:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5lpl38CPqJZ2iLAdQeqn6StsLeoeVXObe3tVTZ17L2wtOMF2CAFIpc6lWgGPInNVknPu/VOLyb/zrbADr5ijeiXuHivLEI7p1fJSfmVXJfriL4f1xPaCe16pIxhTgOc1hfU+4zvOEQ492ZvcC1fYCBBG/flq6zluD5g/vDhehRwZfiCR8sy2nJOjupm1hc8bQCWSHo4bYePT/fO8cuKuauq2V7nTl+S2XdmMw8DhO3kyjNXJHlsu5muXSrZos2SVAYjrz2hHhi1WVq+79B56WX29b7EMf8aWljxKEj31DYa2RAOHOoHFPf/zmw0zXgPRcNJxiqeE8OrI+axJVcYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azQ+wGhcGGxkZUCE7bKZRQ/wbqmbylqdAiMejMvrsWw=;
 b=C6xFRANzv++4MpjV8i8BkQrg2Z8/T/pPaA3zVJ5marWtAlZnRL7mUAGVr+rd3PFNJ8mCa96Cvht0vX69840FnNwnsbIciL9tk1baaGNsIJ0sJUtUNk4YrJIsigBmx7+3OI2lD8GoWYPZQ5XejTZMi836ieDGWpGxbD7Yl8Wrvm90YN5pcceepCafUyNBaXAczDikob+UHkqnt1u/GMdbOhVl8Um5zov5EuP9AifcodQ4xS0B1OlKyLJpR5KjP8dPUZ0eg58DAjSw0tpUzNih/eyd3MwIFJVQgpFcmUEeGd6BCChjKFlzdilY8n+X4qJ2RqjZXzkniSUrUSij+I3fOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azQ+wGhcGGxkZUCE7bKZRQ/wbqmbylqdAiMejMvrsWw=;
 b=MEO5l0JmRtjAlcLlG48jl03MGLkT9hZYLJMO+U6C6NIA14vGydMW+ttIJ8gWRX2hJ4yQ3g3QE8MDDQJGjFXho4BSDO5TWPirQmCXYOA0fgsqkYyvSV4ed8O3DdSkf1FkHGXSeWgf1wkyciQXQTxq5v7q0ckBkLYOEQ+4YOcSSXI=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2534.namprd10.prod.outlook.com (2603:10b6:a02:b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 20:11:39 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 20:11:39 +0000
Subject: Re: [PATCH RFC 00/14] vhost: multiple worker support
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210428223714.110486-1-michael.christie@oracle.com>
 <20210504155606.mlkg7ydwbli56xqu@steredhat>
From: Mike Christie <michael.christie@oracle.com>
Message-ID: <4208135d-f95a-3df6-0d8a-51dbdee0bd0b@oracle.com>
Date: Tue, 4 May 2021 15:11:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210504155606.mlkg7ydwbli56xqu@steredhat>
Content-Language: en-US
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DS7PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::11) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [20.15.0.204] (73.88.28.6) by
 DS7PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:3bb::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 20:11:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e45e07ec-a612-4d8d-7f69-08d90f38d3ce
X-MS-TrafficTypeDiagnostic: BYAPR10MB2534:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2534639FFEF11CAD8C45E43BF15A9@BYAPR10MB2534.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWurpmasjGLg5RUwK4aFl+kTKzhVrTjpYR4zOGz0iZOu3Bb/afARZqtGYjCAP+dIkRol1z1fj1cmwyWEEeiuATksD61PwPi5PM2rRKhl4su117oIiN+uWkz5wc9i5Ln2gGrwehOj/wi1QgbdQlKC+wfbH4lreVHRuvUDBEtf8pqoSFldYxWsWiS1FbFMjzu07uJ1RW6wPkigbeHwH8hscG3HGi4oHc67PVzmF74LoJePpuA1sLYpnxuCf7fJD8D1qH8i78e0cjGMLFLYShpJMBJhelJZML+YRmlyfMROiArzN25w3IirFwFzJqRw16vfJD7H7wC9s317x18N/m8kAmt6V55Kipx6AgkdjwRT+rExOvsAyc8E7TzL2arCLTURSQtp6H0pgMjxX5waOwuGBSQZ0Lu7J1mZus1c9aklsW7gJLz+QBZUWrkJ3dzBicJFqkUURLKf1jNA51DjzRwi4Q3RfoZRyqWkvq5cl3GlSfA2YLcwuYUPbkq/UWfjrA4OWZ6Hkd50jgR9UkcGP5aXS0HlGfVUEZkk9Ox3n5b0Sy6/bbp0WPeEK6sYdhMq3Z/8jzKvqWj7veAJ0z/dk7c3XRODXnm4uoQdlduotLKXAEmv4dtHv19c4BdbbdzoUaqHoymlJbNr2B0H89bLPeRqYhhBrT0CIcIknUetPYCPgKUYizdsNK0930DW90r3GEJyzCnJTJrrXXun1Me1qCXfSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(36756003)(186003)(66946007)(8936002)(16576012)(66556008)(38100700002)(2616005)(956004)(2906002)(316002)(26005)(83380400001)(53546011)(66476007)(8676002)(6916009)(6706004)(31696002)(4326008)(16526019)(478600001)(86362001)(6486002)(31686004)(5660300002)(78286007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?em42STViNU8rZ21udFU5WHkySXJseFE5UDFaZUc5ci9xN0x1UXNncmRJRDRK?=
 =?utf-8?B?d1FGYUsvMmd5aTVjSnhaV1ljZGVEUzkrRGZ5bi9CUmMzV2I5SDFHZUhINldO?=
 =?utf-8?B?ODBIdnpzcE1KVTZ1bG80bDFoV1M1RHlRS084MlRJSDF5NUU4UlIwQWpXR2tJ?=
 =?utf-8?B?ZDlEWVpwMy9jaWVuZHRsYXpJTXR0NDNPRmRYYWJsRFRMMWNxbGM3UlVYT1Ir?=
 =?utf-8?B?eHNnS2M4UnBnRDNUa0o3eEpYRHRuR3NkMWtZTHRmVG9ybHlRd3htYWIraEJR?=
 =?utf-8?B?akk2dUNScUtjb0o0KzZBckExaHA1d1BnT3h5MUVVUm5WSUJoSlNlWDdNVzZJ?=
 =?utf-8?B?SXBjR0oyMmR6cUFMRksvN0hMdys0dUNLR1BxYndpUk1xbi9mbVJyNkJremFq?=
 =?utf-8?B?VTZSQXg5VWFYWis2cm9ZRzNkeXU1R3FiN1BmUVRGSjhuVTZqN0hKbXZWYkRI?=
 =?utf-8?B?dU9adUdvTVdtOW9qMlZ1WFowdVRWNnB0VEFvWit5S0oyUVZEWmJyZEV4UnJm?=
 =?utf-8?B?d3A4cStUdSs2djRQbzFWSENrbXkrdnM1TFFxTW1pNUJRbUlxYjJJeENsVFV4?=
 =?utf-8?B?a3Y3MDVGUDJBMWgweXVJU2J4RGZaRlVuL3g0Z0M3Z0lBL1JRZmlaMHIrN3dS?=
 =?utf-8?B?eXI4ZkJFNkhMVlZBb3grUHBKMHg3NkdFVW1lYk9tTEtVeDNzUDVldWlZRUMw?=
 =?utf-8?B?TGVVTEZTeHgyMzYyYmV5Z0t5NEp2MHlXMWt1aythMXlkOXNQd1JGOSs2SGNR?=
 =?utf-8?B?d3k2VW1ia0diTmxqVytuSmlpenpnVkZKWTJrRjR4UXRVTEVxbldwd28wcDd0?=
 =?utf-8?B?OXNmcmRmVUlzem1XMU5sYU5vcFluMkVjMjFBVjZJaXdUSjdoNjhiZEJSMitp?=
 =?utf-8?B?Z1VzNXlRN0RGS29JWFBZckE4enZWQ2tOSGNrU25PYkJpYVRlb1hhdmFzRmI3?=
 =?utf-8?B?RXcyRzdrSmRiK2pRUk93eFF4WjlsbXpYcGZFcktHcjBhVFZyUTZiMEN5emFY?=
 =?utf-8?B?WWk4WlhpUnhFcjloMDB2Uk9pdWJpQ3NuNzdJeEhXZ3lwOU5hVWpVSTNZU1Rj?=
 =?utf-8?B?VUtsSEI1RGl2cW9tcVhyRERZS3dnQW96ZitHeHhUdzBacXRaN21jdHFrN0dm?=
 =?utf-8?B?QVZsYmhSakxvaVdhdjJTNnVqYmRrUUcwaXVyalpGaEhjdGJjaHlOVEcwaCtR?=
 =?utf-8?B?NVo1Mk5lSWFjZDJtQWtNYmI0MTJrT1V3MExZakwrcTlzbWZCWmNGbkFDajRa?=
 =?utf-8?B?Z1RVMlFOOXBUaVRiOG5ibmlzbmx2OCt4a3NaaEN5N2R6cytxck56dm56bElN?=
 =?utf-8?B?NldaT3cwb3JkWnZ2VmNxcVZMNFNCYnQ1L3NLa3BDWnlYV2NWcnovWldzb3N4?=
 =?utf-8?B?OVc5VlpEVXh0eGlRcExmMHNpNEFiNGYvVnhhMGs0NzdJQkoyWnI0SlFQWE5R?=
 =?utf-8?B?MjAzUGQrOGdobGYxaEZaR09lM0xaRFhrakUzOVVjOS9Ucy9CMjNtRWp3ZzN5?=
 =?utf-8?B?TURkN1p2azZrb1lOYWJqb3l3S2dFR2IwNkZ2cnVQbTMwc2VDK1ZSdEF1Y25R?=
 =?utf-8?B?OUNjVkFTSFlOc2RLc1VkdkROZ3NvbmVaM2swK09FSlMrUzM2UXNGZmc2aVlE?=
 =?utf-8?B?cVA3NzJQYlV1M0k0OEpWdzJ2ckg5NE8xMmhGRDdjZjhGZkhCU1lqMzdHUkxU?=
 =?utf-8?B?MWRlck1RSi9YR1poVWlmdFk3bGhHcUFzVm5NRDkzYlQ3SHZoajMwMDFxUWgr?=
 =?utf-8?Q?m8Rr5+5rVVhu9Yy26OIWaFp/rWFByhJeZ8+1KbG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45e07ec-a612-4d8d-7f69-08d90f38d3ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 20:11:39.7915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXRBoxnKCE6iaRdDbbeVa+9iyA92gVyssnZ/D5TQk02iEYiFiPNHdx9lBC2xRy8bg7/us87wPhEoWy2tpP+vh6BDnnc0IL1jgkk6zrRKV8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2534
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040134
X-Proofpoint-GUID: FV23ygG7k-L54xMdwLfOU19hLKjrk-Yy
X-Proofpoint-ORIG-GUID: FV23ygG7k-L54xMdwLfOU19hLKjrk-Yy
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040134
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, mst@redhat.com
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

On 5/4/21 10:56 AM, Stefano Garzarella wrote:
> Hi Mike,
> 
> On Wed, Apr 28, 2021 at 05:36:59PM -0500, Mike Christie wrote:
>> The following patches apply over mst's vhost branch and were tested
>> againt that branch and also mkp's 5.13 branch which has some vhost-scsi
>> changes.
>>
>> These patches allow us to support multiple vhost workers per device. I
>> ended up just doing Stefan's original idea where userspace has the
>> kernel create a worker and we pass back the pid. This has the benefit
>> over the workqueue and userspace thread approach where we only have
>> one'ish code path in the kernel.
>>
>> The kernel patches here allow us to then do N workers device and also
>> share workers across devices.
> 
> I took a first look and left a few comments.
> 
> In general it looks good to me, I'm just worried if it's okay to use the kthread pid directly or it's better to use an internal id.
> 
> For example I think if this can be affected by the pid namespaces or some security issues.
> I admit I don't know much about this topic, so this might be silly.
> 

Ah yeah, that was my other TODO. I did the lazy loop and left the
"hash on pid" TODO in patch 11 because I was not sure. I thought it
was ok, because only the userspace process that does the
VHOST_SET_OWNER call can do the other ioctls.

I can do pid or use a xarray/ida/idr type if struct and pass that
id between user/kernel space if it's preferred.


>>
>> I included a patch for qemu so you can get an idea of how it works.
>>
>> TODO:
>> -----
>> - polling
>> - Allow sharing workers across devices. Kernel support is added and I
>> hacked up userspace to test, but I'm still working on a sane way to
>> manage it in userspace.
>> - Bind to specific CPUs. Commands like "virsh emulatorpin" work with
>> these patches and allow us to set the group of vhost threads to different
>> CPUs. But we can also set a specific vq's worker to run on a CPU.
>> - I'm handling old kernel by just checking for EPERM. Does this require
>> a feature?
> 
> Do you mean when the new ioctls are not available? We do not return ENOIOCTLCMD?
vhost_vring_ioctl returns -ENOIOCTLCMD but that does not get propagated to the app.
Check out the comment in include/linux/errno.h and fs/ioctl.c:vfs_ioctl() where
-ENOIOCTLCMD is caught and -ENOTTY is returned.

To make this reply a little complicated note that at the time when I wrote the code
I thought something was translating -ENOTTY to -EPERM but then after posting I
realized that ioctl() always returns -1 on error (I thought the -1 was a -EPERM
from the kernel). errno is set to -ENOTTY as expected when a ioctl is not
implemented, so the -EPERM references should be errno and -ENOTTY.



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
