Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7F6C433EF
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 23:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15AB560EEC;
	Mon, 23 May 2022 23:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHrYlUe_kwDq; Mon, 23 May 2022 23:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A4E9607F7;
	Mon, 23 May 2022 23:55:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4979EC0032;
	Mon, 23 May 2022 23:55:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5467BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 23:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B3AB82FCB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 23:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="lMgAGZPx";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="TTQgETCe"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OKrRS4Hwb7fK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 23:55:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B385682FA5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 23:55:06 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMiBf0009700;
 Mon, 23 May 2022 23:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iYDKCdbHOgcCBiIQxLpumkSHcWtQlp/pvSVdwC+ByKM=;
 b=lMgAGZPx+MbMkm18s4+VpA/7McyjSs1VB/PG9KxwRAtfzvd1LhfoNl5fUNUBZeniW+ud
 4NxaISuVqaZaom3xMcGnmPh9C3Xo2b6GISg6tzEYw8l03MJ6wf8ATXKvPjR/HdLdPD2P
 JC/K2lzUmRQqCmO4lTbSNw01H3iuV3em21dy51kpGR1E9FuQv+LLYe5hUusEMOZ5d9Cd
 U2XDIthhQ3eVEllPy59HzcUXXYYG9yruW2kldZg+aXyk+0Wq5jilF6+XXJ5bCp6N45m5
 JJyj2If5qJzMVWRQawLbIKHz8AcodVvY1dFmPtWBXa1phsC0O2NtN7oUUJbtBzyjNaub kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp04uqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 May 2022 23:54:54 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24NNkRdt010379; Mon, 23 May 2022 23:54:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g6ph7s3sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 May 2022 23:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQhJ7MqCM5sRTpXyVvVQihXA1V38Dn5TMfEYqm9ZXGU+BZzJQJKYwoUVRUXM0ktIXIRj+ZybmpG+tGVfEn7pV4uhqCfpAHz+0uUh3v4fWzdm+Lz5XHvilz97Gk4mqe8FObf3ZlKOfMn3FQspn0U/Ky40CLLR5WirXlrEwR8dJVjbBiTiaQPjrz+ph2FpovNtUYUjq4mntXNyKLin6Z73kneGbQsvhi92tmvbsuib7+aPQfG5HNVZ78lhn2gHdoHr6m1uFFeMhZ+BM7NkyNRMYNqFEvRwzFt1Zd/lPScvoxDnjn95/61VcExI3DGOVz+p0Bj88XbseYqMfbjTPFKocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYDKCdbHOgcCBiIQxLpumkSHcWtQlp/pvSVdwC+ByKM=;
 b=gTBpItgu2hVgElgwnHdCWqnUPCf/EYKzcv4ta1K2H9rgiET8gfqeJhNetmyVbLi9vxVrmxCm6X9e0772dC5Rac3r5Z9UzOWxccNDvJ/eRmkgyZAdQ3cdmBRxgrYbtMwqia/c7ICIU+fUuarUEVFGnydoPgNQ6GKexHKZHn1p3T0+ilm6/0wFRXoeqWXVYQ/K3DLjZlPdmZsGzg04lFArCtL3Gs1XmtMc9DfnzHDKUwKSHD8mH9gcvMbz8PLnEf0K0625uBk0hbwVzOJf7qTi7iPIDmW3qO/GiKqNK9b5MHWZZZmbSletB4p2SeuWLWS4oW8zrLrgyuamp8/cmEMAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYDKCdbHOgcCBiIQxLpumkSHcWtQlp/pvSVdwC+ByKM=;
 b=TTQgETCeGrBZRsfsfYe0Zon+jfLaGgAqllQAsWCGZtcCFcscclpHVYWWBYPpCReHg22IrZN6XvDq9ILNeHtu6SBBpxdpFE4LEcJiHesx2kG5EhMLY2tMxB+lZTI+n+vvGATynRHN/8jb/9jo26b87UH1DLWdVdLkRNujWnqNrBc=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by MWHPR10MB1856.namprd10.prod.outlook.com (2603:10b6:300:10e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18; Mon, 23 May
 2022 23:54:50 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c89:e3f5:ea4a:8d30%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 23:54:49 +0000
Message-ID: <4de97962-cf7e-c334-5874-ba739270c705@oracle.com>
Date: Mon, 23 May 2022 16:54:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] vdpa: Add stop operation
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220520172325.980884-1-eperezma@redhat.com>
 <20220520172325.980884-2-eperezma@redhat.com>
 <79089dc4-07c4-369b-826c-1c6e12edcaff@oracle.com>
 <CAJaqyWd3BqZfmJv+eBYOGRwNz3OhNKjvHPiFOafSjzAnRMA_tQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWd3BqZfmJv+eBYOGRwNz3OhNKjvHPiFOafSjzAnRMA_tQ@mail.gmail.com>
X-ClientProxiedBy: FR1PR80CA0003.lamprd80.prod.outlook.com
 (2603:10d6:200:21::13) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d46f06e7-1c5b-40da-90d8-08da3d179f70
X-MS-TrafficTypeDiagnostic: MWHPR10MB1856:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1856F4C448B16AC7F48CAF50B1D49@MWHPR10MB1856.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhmdrJX04bistXXC8l49pbUQvpPpxIyvUYBiU21tYuvQBLVB9vUjX+WkthVeRT18IQ2hxxFMwvfvvkMcZ6j0tbWxzAlrZ8byiQQZcF0NrWGWfMQ1RBH6tL1MR3tSq93PhyLYpBNaaicBKPRSBEj0qZGKoG1lAQ6ev5wzWRUEzRUr3OaFml1SARgENN8Bwb8EOA3hlnrU6xdq3KBxGd1GY5LPhNbT3NRumuBbE7XecgViVcO/CyWTQ3J3YOLTbdrAqLAKAYXoygAxU9+QcBHbXdu6m2gGHkMJD/DOQUMyQiABOYKVaoQVRT2JN7Y0ou5JY4OGP8zufqiD/a9Gtt9/omDPrVnyMeZANH9JkmZxQb8jUuQxgJOjQvYR3S7kjZ6dic/8EzpxTXvHIEzcOoWWGJpx9dJBDm0fNOBx5TIGaMr8XTMaNZJ9ucCY/IJRYKisGoNs9pAMgWjg0UcLgCEOCPwlt6nxnCHQrrcYce0e3PZBVoTSj7/VWhXI1WLlUyuNt7IyE+ud6rKRKL9NwA1azm6SHYXdN3nvRbt+rxnRl9bMhdSvfUIeqwG40AEpR3+wx64hUOqgWEjklFQ42itudIOxUmA8C7mcfnjlj+0fI1tDws7Q6gl8ONfrD9u22A4RAGgkHY3mRpTrEbslStlYPm0inHTAjzqpiPrAcQK3YoJJ5hv8/I+M8o3CChT6WZbe3ngC6DScPd+XZi1HmwAxsXBP4AWTIF/Y9maz2HXU6EkDpzwIDkHcZAJ+K8qPHoTu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(66476007)(86362001)(31696002)(4326008)(66556008)(8676002)(66946007)(2906002)(8936002)(5660300002)(316002)(26005)(6512007)(31686004)(7416002)(2616005)(53546011)(38100700002)(508600001)(54906003)(6506007)(6916009)(6666004)(36916002)(66574015)(36756003)(83380400001)(6486002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFaVWNEYmdmN2FWT2lrbDNoWEpETmdkc3l4UGJJazdOM0JjMEFxT3lVMjBk?=
 =?utf-8?B?ekFqNHd4U3k4THVyUjF6ck1xYXc5NnlLQlNRdlM4L2s3b3VLK0FZekpvUFNG?=
 =?utf-8?B?ak5FUEhIOWtEVlJMNUQ1L3VFQmpFTEZVWThHc042SDdlMWxUbHJnWVFzNEtQ?=
 =?utf-8?B?dmFDVmZUajZSbStFMkczS0JYdHFOOEplYnBib3piNlVzVHAzKzFjNVhydDln?=
 =?utf-8?B?R09pY0lmRmNoVU1yZnhkVUx3N2JSVzdxaFlDUlo5em9pVnpMRlN1NW1sZ0FP?=
 =?utf-8?B?K2RYQmpFdnZybENKcUcxOEdBQTREZitSd1RXdVBNRXRlNEtETG4wb2xIeU1k?=
 =?utf-8?B?SlJuS3BGVUhhLzVpczNUZGN4QVU1MnZIZ3ZEYmJ0Y1JVb3hvTldrdHJaTFBU?=
 =?utf-8?B?OW0vczAzQVhORnBtR1pKaXJPRCtFazVXZkM4b3NJcDA4Z1oyMEhJRzhyWGE2?=
 =?utf-8?B?N0ZBV0xtY2pUZk9VN0w5bkpMVHRvQ1VSS0V0Ym84cUhMSlYzNEtkVzdiQ21z?=
 =?utf-8?B?ZnhZTEJBZ2l1TEtxNkNGWFRPUWNOeVAza2xiS091dktSSVhxU0hPcWdleUVK?=
 =?utf-8?B?UHhaT0pKT2dJcDMvNjNvMnFWaVN4VGRMZ3k3eXlKWjdvZTV1cEx1c3IyTWts?=
 =?utf-8?B?OTU5WFBBSThmYTEwNUU1SkpKRFFyT0FxK0d6clFtd0ZoWXVVNy9vbUsvMWZm?=
 =?utf-8?B?WVBtbCtRQ0orOXFDS0NqbHlKNWZCM2NTZ2t1SzcxdWtMK3puYXRlT3lqRmdl?=
 =?utf-8?B?WnFYRjA1ZldJaWMzSHEzT242NnZJRG5XeWVldElZNXFFbXF5bkxnTnk2MXZM?=
 =?utf-8?B?QjkvWEh6QTNLOVV1dlgxYUFheis3Ny9pQXE0N2FHUGFLUHJ3aDdRMk1SMkJx?=
 =?utf-8?B?N0RMOUd2VUVvYWR3N3BLOGU0TXlYMm9zL3RVR0FFcmpZaEdNSlNhTW8rbEtG?=
 =?utf-8?B?M29GVnVFOEE2aTIrL1ZaK2RBS253Um4xOUpIc2NSSGZ4NW5jclFMd0xSazd6?=
 =?utf-8?B?SGpicGZyTTJUcm1wblRNZFFtbmpyRVNwZE9YejNPZUZSTzRiRlArclExeVha?=
 =?utf-8?B?M3ZQMGRmVEhZeDROQ0FBRENBbkRkN1lIQnhzbm0zYVVjM0hnNHd1SzlROTRE?=
 =?utf-8?B?UHBGWUxXdjlRNG8yMXU2ZmhnK1NUMCt1cUtUc3NkK2JUc3NIbkxwQi8zZ3Fj?=
 =?utf-8?B?Y3NyNFEwL2g0R3F3N2Q2UzR4TmtuQ2N4OUgxcmhhVmFPdnRCc3hCODVxbmhi?=
 =?utf-8?B?VDY0QjcvUmZ5MFFpcFNidHhYWm1wb0VnWHlqNldvWHJGREdzS0ljaHdGQnJt?=
 =?utf-8?B?VCtVK2ZFSlE5YjgwN0txOWpCcUgrZFM5R29icmZ0TGxDR0lJR1V5Z0tiYlBa?=
 =?utf-8?B?ZzkxK1hpdUFtOHduVzVmVXQzRnlQYytJTUxlTndXclVKTVpuVlRyZ3Q0cFhX?=
 =?utf-8?B?Skd6Q0FET2ZOaUNJRmJEUTR0STM0ZmpJN08yaDBKc2NKMjRSQ1ZWRWxYaTZD?=
 =?utf-8?B?TytzSEhZMlExdU5LVGVDZWtXeVZuNzRXTGdKN2F0OFRTS0NwM2pMbXFRVmkx?=
 =?utf-8?B?T1FIZzFsT0FGU2VSaWNKRUlibmZ0NmtGNkNmL2EzVThpY3dJcEFib0VQRTVH?=
 =?utf-8?B?akFMT1dpSnF2NmpFMzZMTzZPNnVxUmRuV2xsQUMva25LaTVmUzZtdUE1bi81?=
 =?utf-8?B?YlJtR0djWEEySmtZdlltRHo2eXN2WCtDVzVTc3ZvT2hjT1E4Nkxzdkx1ZjRS?=
 =?utf-8?B?b2UrRUhlNkRYWEFnQTJOdEhhSXpObVJraFZ0aEtZTUFXWndTUVoxOHdxUUx1?=
 =?utf-8?B?cjJ3Y2VHbWw0WnU0OXJRWkVUcUc3dG91WUhsSXlOWkQ0RzlnN0hPTzk4NWJM?=
 =?utf-8?B?dlVJMS8yUUhtN054eDVpaGZtbVlhNlphdTBycEVGUXJWcS95Wkc1RWowSjRU?=
 =?utf-8?B?Mk56MDhyNEUrYUpYcTJYRG8rSjZIQS9sTmI2TDBqRDNaREN6UzVaU0NSd3Fm?=
 =?utf-8?B?aDRGNkJDdFROZjVCTG5MaUc3T0g3TnNvTmxHbkRZS1hPN2Q4V2lSWjdoSldl?=
 =?utf-8?B?NFBGc2RucDZrckJIQzY0a3UzRmNTOGV6eDNKa2lPdnVFVUNidm52b1VsSDFE?=
 =?utf-8?B?MUFjaGhxR1BrMmdqajdRTWxRT3F1b1FZbDhIdytSUlRYKzA3bWNhNzdOaFJw?=
 =?utf-8?B?U3dFSCtBaFBmcHBLZHA4a29Gam9UUWVXcE52ZzNqdld3Q2JPNnE0b0ZNUnE5?=
 =?utf-8?B?Y2lQd1Zid241YkdZZHErYzFCbUh3YjJZM3pkd1JuSXplYWQ1cTlEbFNRR252?=
 =?utf-8?B?WG5WY0JxVis0T3JuTTBlTlNLeWY2Q1hMUTZRTituZjVWV3VZL0YzV2tnMnJ1?=
 =?utf-8?Q?Dw5+k2lF+JicxRZw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46f06e7-1c5b-40da-90d8-08da3d179f70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 23:54:49.7655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlC579FdndJSVgP39NI/qcl/ULz++kezBfgFUnurWEmtdcLvyIeg/emqaog2UnG3Lb4LhCP+FdiizK5RZsnHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1856
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-23_10:2022-05-23,
 2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230122
X-Proofpoint-ORIG-GUID: TM6HVkkxWgrjXOodyohUzvZPQ2NKCYFS
X-Proofpoint-GUID: TM6HVkkxWgrjXOodyohUzvZPQ2NKCYFS
Cc: tanuj.kamde@amd.com, kvm list <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 Cindy Lu <lulu@redhat.com>, Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ecree.xilinx@gmail.com,
 Harpreet Singh Anand <hanand@xilinx.com>, martinpo@xilinx.com, "Dawar,
 Gautam" <gautam.dawar@amd.com>, Zhu Lingshan <lingshan.zhu@intel.com>
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

CgpPbiA1LzIzLzIwMjIgMTI6MjAgUE0sIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+IE9u
IFNhdCwgTWF5IDIxLCAyMDIyIGF0IDEyOjEzIFBNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3Jh
Y2xlLmNvbT4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDUvMjAvMjAyMiAxMDoyMyBBTSwgRXVnZW5pbyBQ
w6lyZXogd3JvdGU6Cj4+PiBUaGlzIG9wZXJhdGlvbiBpcyBvcHRpb25hbDogSXQgaXQncyBub3Qg
aW1wbGVtZW50ZWQsIGJhY2tlbmQgZmVhdHVyZSBiaXQKPj4+IHdpbGwgbm90IGJlIGV4cG9zZWQu
Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5j
b20+Cj4+PiAtLS0KPj4+ICAgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgNiArKysrKysKPj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4gaW5kZXggMTVhZjgw
MmQ0MWM0Li5kZGZlYmM0ZTFlMDEgMTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEu
aAo+Pj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+IEBAIC0yMTUsNiArMjE1LDExIEBA
IHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPj4+ICAgICAqIEByZXNldDogICAgICAgICAgICAgICAg
ICBSZXNldCBkZXZpY2UKPj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRldjog
dmRwYSBkZXZpY2UKPj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICBSZXR1cm5zIGlu
dGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4+PiArICogQHN0b3A6ICAgICAgICAg
ICAgICAgICAgICBTdG9wIG9yIHJlc3VtZSB0aGUgZGV2aWNlIChvcHRpb25hbCwgYnV0IGl0IG11
c3QKPj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgIGJlIGltcGxlbWVudGVkIGlmIHJl
cXVpcmUgZGV2aWNlIHN0b3ApCj4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRl
djogdmRwYSBkZXZpY2UKPj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgIEBzdG9wOiBz
dG9wICh0cnVlKSwgbm90IHN0b3AgKGZhbHNlKQo+Pj4gKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+PiBJcyB0
aGlzIHVBUEkgbWVhbnQgdG8gYWRkcmVzcyBhbGwgdXNlIGNhc2VzIGRlc2NyaWJlZCBpbiB0aGUg
ZnVsbCBibG93bgo+PiBfRl9TVE9QIHZpcnRpbyBzcGVjIHByb3Bvc2FsLCBzdWNoIGFzOgo+Pgo+
PiAtLS0tLS0tLS0tLS0tLSU8LS0tLS0tLS0tLS0tLS0KPj4KPj4gLi4uLi4uIHRoZSBkZXZpY2Ug
TVVTVCBmaW5pc2ggYW55IGluIGZsaWdodAo+PiBvcGVyYXRpb25zIGFmdGVyIHRoZSBkcml2ZXIg
d3JpdGVzIFNUT1AuICBEZXBlbmRpbmcgb24gdGhlIGRldmljZSwgaXQKPj4gY2FuIGRvIGl0Cj4+
IGluIG1hbnkgd2F5cyBhcyBsb25nIGFzIHRoZSBkcml2ZXIgY2FuIHJlY292ZXIgaXRzIG5vcm1h
bCBvcGVyYXRpb24gaWYgaXQKPj4gcmVzdW1lcyB0aGUgZGV2aWNlIHdpdGhvdXQgdGhlIG5lZWQg
b2YgcmVzZXR0aW5nIGl0Ogo+Pgo+PiAtIERyYWluIGFuZCB3YWl0IGZvciB0aGUgY29tcGxldGlv
biBvZiBhbGwgcGVuZGluZyByZXF1ZXN0cyB1bnRpbCBhCj4+ICAgICBjb252ZW5pZW50IGF2YWls
IGRlc2NyaXB0b3IuIElnbm9yZSBhbnkgb3RoZXIgcG9zdGVyaW9yIGRlc2NyaXB0b3IuCj4+IC0g
UmV0dXJuIGEgZGV2aWNlLXNwZWNpZmljIGZhaWx1cmUgZm9yIHRoZXNlIGRlc2NyaXB0b3JzLCBz
byB0aGUgZHJpdmVyCj4+ICAgICBjYW4gY2hvb3NlIHRvIHJldHJ5IG9yIHRvIGNhbmNlbCB0aGVt
Lgo+PiAtIE1hcmsgdGhlbSBhcyBkb25lIGV2ZW4gaWYgdGhleSBhcmUgbm90LCBpZiB0aGUga2lu
ZCBvZiBkZXZpY2UgY2FuCj4+ICAgICBhc3N1bWUgdG8gbG9zZSB0aGVtLgo+PiAtLS0tLS0tLS0t
LS0tLSU8LS0tLS0tLS0tLS0tLS0KPj4KPiBSaWdodCwgdGhpcyBpcyB0b3RhbGx5IHVuZGVyc3Bl
Y2lmaWVkIGluIHRoaXMgc2VyaWVzLgo+Cj4gSSdsbCBleHBhbmQgb24gaXQgaW4gdGhlIG5leHQg
dmVyc2lvbiwgYnV0IHRoYXQgdGV4dCBwcm9wb3NlZCB0bwo+IHZpcnRpby1jb21tZW50IHdhcyBj
b21wbGljYXRlZCBhbmQgbWlzbGVhZGluZy4gSSBmaW5kIGJldHRlciB0byBnZXQKPiB0aGUgcHJl
dmlvdXMgdmVyc2lvbiBkZXNjcmlwdGlvbi4gV291bGQgdGhlIG5leHQgZGVzY3JpcHRpb24gd29y
az8KPgo+IGBgYAo+IEFmdGVyIHRoZSByZXR1cm4gb2YgaW9jdGwsIHRoZSBkZXZpY2UgTVVTVCBm
aW5pc2ggYW55IHBlbmRpbmcgb3BlcmF0aW9ucyBsaWtlCj4gaW4gZmxpZ2h0IHJlcXVlc3RzLiBJ
dCBtdXN0IGFsc28gcHJlc2VydmUgYWxsIHRoZSBuZWNlc3Nhcnkgc3RhdGUgKHRoZQo+IHZpcnRx
dWV1ZSB2cmluZyBiYXNlIHBsdXMgdGhlIHBvc3NpYmxlIGRldmljZSBzcGVjaWZpYyBzdGF0ZXMp
CkhtbW0sICJwb3NzaWJsZSBkZXZpY2Ugc3BlY2lmaWMgc3RhdGVzIiBpcyBhIGJpdCB2YWd1ZS4g
RG9lcyBpdCByZXF1aXJlIAp0aGUgZGV2aWNlIHRvIHNhdmUgYW55IGRldmljZSBpbnRlcm5hbCBz
dGF0ZSB0aGF0IGlzIG5vdCBkZWZpbmVkIGluIHRoZSAKdmlydGlvIHNwZWMgLSBzdWNoIGFzIGFu
eSBmYWlsZWQgaW4tZmxpZ2h0IHJlcXVlc3RzIHRvIHJlc3VibWl0IHVwb24gCnJlc3VtZT8gT3Ig
eW91IHdvdWxkIGxlYW4gb24gU1ZRIHRvIGludGVyY2VwdCBpdCBpbiBkZXB0aCBhbmQgc2F2ZSBp
dCAKd2l0aCBzb21lIG90aGVyIG1lYW5zPyBJIHRoaW5rIG5ldHdvcmsgZGV2aWNlIGFsc28gaGFz
IGludGVybmFsIHN0YXRlIApzdWNoIGFzIGZsb3cgc3RlZXJpbmcgc3RhdGUgdGhhdCBuZWVkcyBi
b29ra2VlcGluZyBhcyB3ZWxsLgoKQSBmb2xsb3ctdXAgcXVlc3Rpb24gaXMgd2hhdCBpcyB0aGUg
dXNlIG9mIHRoZSBgc3RvcGAgYXJndW1lbnQgb2YgZmFsc2UsIApkb2VzIGl0IHJlcXVpcmUgdGhl
IGRldmljZSB0byBzdXBwb3J0IHJlc3VtZT8gSSBzZWVtIHRvIHJlY2FsbCB0aGlzIGlzIApzb21l
dGhpbmcgdG8gYWJhbmRvbiBpbiBmYXZvciBvZiBkZXZpY2UgcmVzZXQgcGx1cyBzZXR0aW5nIHF1
ZXVlIApiYXNlL2FkZHIgYWZ0ZXIuIE9yIGl0J3MganVzdCBhIG9wdGlvbmFsIGZlYXR1cmUgdGhh
dCBtYXkgYmUgZGV2aWNlIApzcGVjaWZpYyAoaWYgb25lIGNhbiBkbyBzbyBpbiBzaW1wbGUgd2F5
KS4KCi1TaXdlaQoKPiAgIHRoYXQgaXMgcmVxdWlyZWQKPiBmb3IgcmVzdG9yaW5nIGluIHRoZSBm
dXR1cmUuCj4KPiBJbiB0aGUgZnV0dXJlLCB3ZSB3aWxsIHByb3ZpZGUgZmVhdHVyZXMgc2ltaWxh
ciB0byBWSE9TVF9VU0VSX0dFVF9JTkZMSUdIVF9GRAo+IHNvIHRoZSBkZXZpY2UgY2FuIHNhdmUg
cGVuZGluZyBvcGVyYXRpb25zLgo+IGBgYAo+Cj4gVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQh
Cj4KPgo+Cj4KPgo+PiBFLmcuIGRvIEkgYXNzdW1lIGNvcnJlY3RseSBhbGwgaW4gZmxpZ2h0IHJl
cXVlc3RzIGFyZSBmbHVzaGVkIGFmdGVyCj4+IHJldHVybiBmcm9tIHRoaXMgdUFQSSBjYWxsPyBP
ciBzb21lIG9mIHBlbmRpbmcgcmVxdWVzdHMgbWF5IGJlIHN1YmplY3QKPj4gdG8gbG9zcyBvciBm
YWlsdXJlPyBIb3cgZG9lcyB0aGUgY2FsbGVyL3VzZXIgc3BlY2lmeSB0aGVzZSB2YXJpb3VzCj4+
IG9wdGlvbnMgKGlmIHRoZXJlIGFyZSkgZm9yIGRldmljZSBzdG9wPwo+Pgo+PiBCVFcsIGl0IHdv
dWxkIGJlIG5pY2UgdG8gYWRkIHRoZSBjb3JyZXNwb25kaW5nIHN1cHBvcnQgdG8gdmRwYV9zaW1f
YmxrCj4+IGFzIHdlbGwgdG8gZGVtbyB0aGUgc3RvcCBoYW5kbGluZy4gVG8ganVzdCBzaG93IGl0
IG9uIHZkcGEtc2ltLW5ldCBJTUhPCj4+IGlzIHBlcmhhcHMgbm90IHNvIGNvbnZpbmNpbmcuCj4+
Cj4+IC1TaXdlaQo+Pgo+Pj4gICAgICogQGdldF9jb25maWdfc2l6ZTogICAgICAgICAgICAgICAg
R2V0IHRoZSBzaXplIG9mIHRoZSBjb25maWd1cmF0aW9uIHNwYWNlIGluY2x1ZGVzCj4+PiAgICAg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgZmllbGRzIHRoYXQgYXJlIGNvbmRpdGlvbmFsIG9u
IGZlYXR1cmUgYml0cy4KPj4+ICAgICAqICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRldjog
dmRwYSBkZXZpY2UKPj4+IEBAIC0zMTYsNiArMzIxLDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29w
cyB7Cj4+PiAgICAgICAgdTggKCpnZXRfc3RhdHVzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYp
Owo+Pj4gICAgICAgIHZvaWQgKCpzZXRfc3RhdHVzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYs
IHU4IHN0YXR1cyk7Cj4+PiAgICAgICAgaW50ICgqcmVzZXQpKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldik7Cj4+PiArICAgICBpbnQgKCpzdG9wKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIGJv
b2wgc3RvcCk7Cj4+PiAgICAgICAgc2l6ZV90ICgqZ2V0X2NvbmZpZ19zaXplKShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYpOwo+Pj4gICAgICAgIHZvaWQgKCpnZXRfY29uZmlnKShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbik7CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
