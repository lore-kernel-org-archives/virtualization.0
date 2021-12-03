Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984A0C433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 07:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12D9C40369;
	Fri,  3 Dec 2021 07:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dVlwZ6huS7Qj; Fri,  3 Dec 2021 07:28:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EDB8F401BC;
	Fri,  3 Dec 2021 07:28:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2A8FC001C;
	Fri,  3 Dec 2021 07:28:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03144C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1EBD81BA8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="KWvOvc1b";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="U5Oq4RiI"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nsKJBU0QI_Vo
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:28:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4D6481B58
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:28:21 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B36U72o032323; 
 Fri, 3 Dec 2021 07:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qjPe6HsEswN17ryzI92szg3CI8MPEl2nY8yS/xY8s6M=;
 b=KWvOvc1bPAplEI63mELPjXUKDni+u+QwxjJ9W0gF07749zycOyJsBReFAEPrr3FczNrL
 93IR3AMHnVwgfipmkT4NOGm2F8EypOiQ5R1yGm7KzQgxGZVeQYJ/gDgzRyBWZq2LWXaP
 hfLqGqRX1GAnWSmozV14gNH5fsDdq7wgGZcBXn71Cv4NC9a0HEYfK+KOoWq0KR9P8peS
 qFdks3Fwtmq56G2z8QlNs3rRfcLzUDv/1N1F1doIb7OleSLaJijWzgTVLuWiLctts7su
 UA5ouf37p1EJ4KsKmr1TZseSFTH4ymcgsBNV/hE0qYYWGGVQdDlGI3RhEYEKYPTBjNXI Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cp7wex8ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Dec 2021 07:28:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B37LmQP065193;
 Fri, 3 Dec 2021 07:28:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by aserp3030.oracle.com with ESMTP id 3ckaqkvuxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Dec 2021 07:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar9LANjZ5OZF9MR1S6/CfwtBSRd1ypX/HVuGv3+oOO+jZ3HRmCg7P1EFQErdp4j4x33DmCxngczHZcwEpQCUUOFAkkxtWgWuclHiYGsOUkaoAvExj7T6O9l4gsIzoFjr7LBrz9v0EYpaGSutD0LOXs4+uTQss0dxKJdHyEBOnZ82tK8Jc3TT381nkhnQV1xNuESvSXg4ybSfjT4aOyz/jYg4eD2TfZmMRPKEKlo0crMcqAbuQ0+hEndbQfBLW7gesUbkiTSZBOR3kUimFDW7IUQuVOW8LWjVLJrYYK3BjX2zzXFZj7jkfzGVLpA9weoS2v/vmic2iZszwoVxS5Pc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjPe6HsEswN17ryzI92szg3CI8MPEl2nY8yS/xY8s6M=;
 b=bfHfLVeY8l8CibhVfi7GeXBhtYGO8UY+X+3TDBgwO2du9s6Ms8ErmhONHp0FBhtFrb0iwGS95IeYz3KYjvwX+R04fRBycerVFuGRRDCBShLLmKMSQrMAdifNCe/h6FiAGL94hmlszt3AwpzLff0X5lkAHgi1ed+aBsrZW/HTWiF1f5zxod+fd7FdWaUGFTpqOQN2MPr3EAzzunS1T9MD5KG6IXh1p7ZZkLHErYIR8J5ssp1jIVSHBZfJ95+dKwvXL0NJqhhaFN+dap7MsgH/BQtFp36gdgzbGOHi+kBX7eOzXSsbvOWwSt8xDw8CQXWKyUvrrAAC9lElsbfQutZFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjPe6HsEswN17ryzI92szg3CI8MPEl2nY8yS/xY8s6M=;
 b=U5Oq4RiI95459+JzDzUiXM10nN+mHZFBaBXvfvj+FaInJnVOwf/2gOHX8XDKEPiNAogyG3OS8ghGU1krQHAkGs9V511ZDRnjxiDxcTicXqMp7LoKUIdr9DX0vTxhg4MG0URSVF8SmocTPIkj3hnL/ZjymMygq1u3oq1oYT/PrZw=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4324.namprd10.prod.outlook.com (2603:10b6:a03:205::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 3 Dec
 2021 07:28:17 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 07:28:17 +0000
Message-ID: <0e6de504-38e8-a1a9-5dc9-00c52571b21b@oracle.com>
Date: Thu, 2 Dec 2021 23:28:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] vdpa/mlx5: Support configuring max data virtqueue
 pairs
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-4-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211201195724.17503-4-elic@nvidia.com>
X-ClientProxiedBy: SN4PR0401CA0047.namprd04.prod.outlook.com
 (2603:10b6:803:2a::33) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.148.88] (138.3.200.24) by
 SN4PR0401CA0047.namprd04.prod.outlook.com (2603:10b6:803:2a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 07:28:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16050ff0-56db-4dd0-3cd5-08d9b62e7977
X-MS-TrafficTypeDiagnostic: BY5PR10MB4324:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4324FC57B4CF41ABBD951F9DB16A9@BY5PR10MB4324.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OchuH3CLf8koNAS47ZgiIh9ue8IunWMY/DK9CfuOldNW8/n5qBWzpC7a/2lJFLsz9s9AMF8V+AKty/Nzub/m+yEw8XzNi1GKI61EdFhd4jOKnbhEB+iXgj5WAuW3qduIP3U0ntDID1PZHrufb/bhmSLl03PFzBNIvJUqLFX62KxGD7iqAB9KY6FYvoUUGzBH0Lzx6GWPeD8cJ1mhXAjOYpKQ5q6W+azKhEiNf0iqkEXd5boy3yfjjgII+2ByZsYPMez6vITlOpMrYqIPR+/brIR94nVp4fJ01zBgM+3X0zmXmvsEXPnmelK5bgucuoeG14RqaQ8nBsGCx2b78PYBPa7c7eSqtLG4O8VdO6ZxeDXNSMe5zSuiFeRUuXnm2hf7LEE0DTU+5c62IVlC7noyistPVyy8rICnprUQFWKq8G9NRty4A2XwX/k9mm6gsfJJsKAWhxJAGvvc3cL3MA15r4aU32Yiu21Ext3yWSMiw8ki3WYvjyEeDzbC0ocbu5/ac07/MX09ZunOgjeiwIJB4eBhK4d1H7vdWj0t1NPeI8o/En5XOHBvxMUSSwmoouR1Lxkuy6E/xJ9PH2DKwDuptSLzoWmnRnHBY4zRdNpJrl60e1YNEOOFuEXgmoPDO2ZcKTiEv+olaS5TS4Zwu28FBedDI+itjxuZS8+0530rYyVtKaOclIH6xPtiiHPxLTdpLSDqDXH163TR1VqQEXVLrbv0E1bibwjsI6OUzDW6WqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(2906002)(83380400001)(6666004)(508600001)(8676002)(4326008)(16576012)(36756003)(316002)(66946007)(6486002)(53546011)(31696002)(86362001)(2616005)(956004)(66476007)(5660300002)(66556008)(31686004)(26005)(36916002)(186003)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enBQaUZlYUVPeWs1K1F2ejVBeENwdlBYT0ZrdGVuYXNPM093QlpOb3VLOXVB?=
 =?utf-8?B?OEhZNlZscmlwQWhSZENVZGd4aFdzTDdZLy9zS3VMRFh1R1I3cXV5d2hCYmhD?=
 =?utf-8?B?aFl5RnlmM2tWN2tBME1LVnhPd1R0TTNleGZva21ENHhSRDJqOU1oRGI1OEZx?=
 =?utf-8?B?Smc2SHMvYWdaU2FwRFk1ZkYwWmsvcXlQSDNTeEdGSzdkKys5K2tmYXg2TXFa?=
 =?utf-8?B?Unl6UDFOa29xdWJ3UlZZWUFkczgyTnNoNVdQL0ZDZzJTWE9kWXR0SkVSNFJU?=
 =?utf-8?B?NXdzVUxXM3QrQXFld0lubG5GRGtLODh6THExeWtZNXFFNUk0V2lvSFY2QlN4?=
 =?utf-8?B?RUJ3QklOS1VRTC9pUXRZKzRJazRJU2pENWU1YUlmb1cvbk5EV1lqL1BXUCtM?=
 =?utf-8?B?Vi9wUmlyNE5iSU9VZGExZFQ1MWtOcG9kS0lLTmhIeDg0dithOGxHcjFOZCt1?=
 =?utf-8?B?OEZjaktuMXZnSFIyNGRZdU9vUmVib3VMQkgrVDY1c0xHUGZubTBITzRjR21M?=
 =?utf-8?B?N2h3cGJGWkhzSEdhRTI5cngwTTZTSElUUlE1ekczWnl4SUZQZG9mU3hOaXBu?=
 =?utf-8?B?Zm93VUVkNVM1ZUt4S25jaGZrMEFvSkVUYXVLL0xZRVl1ejNOREVWRkhzenBT?=
 =?utf-8?B?WDVIUHFFbjlJbUpCNlI4ZnQ5WDQrWU92dEFFRzQrbkNsL2dKVEY0cWh2cW9K?=
 =?utf-8?B?cFVidDF4clFTNkd2QTA1b2hvZG5RTmp3cU1UQWxCWHQ4bEg0NHNSMFFFNmxS?=
 =?utf-8?B?VjBCMEJ5ZlRUemEwNVRyVDVVWVJvWXN3VFpNR1V3VTVuQy9SOFJpd3IzNWww?=
 =?utf-8?B?RnJ0UlV0eDVNWmlGRXE2Wi83Wk5QWkEyblgxczU3Z21QNTZLUUpkRkdhdkhl?=
 =?utf-8?B?UEYvQUkvS1hocmlabjk5MjhaYTlKMmtpSWxHSXhLblpHZ2VnZDZEalBrUzBq?=
 =?utf-8?B?bVprZjZPTFhnZGtteE5FVGR0NGdwaDEzQVZ0cG1zU0ROdmxyM2l1bWhHSlRD?=
 =?utf-8?B?L2I3aWY4ZW05SnVnU2EvYjJaVUtaRitsMzRWSmNBQ1I2T3FmVUlFZGU2cmZB?=
 =?utf-8?B?azRZYTNHR1BmUDlCbWhZUENUb0tOTDFzTnkvYmY0c3p1V0duZ0U3K0dWeURz?=
 =?utf-8?B?L0lyYWwyb3hsRld5bUI3Rmd5cHBINWhwbzUwZXhDS2N2T2JhNjY2bVNNeTZE?=
 =?utf-8?B?MzRBc3hyUVZ6NnZwSU9vSFhkZVd2TnJoOWt0TFYxZVcrcFkyZ3B2bEpVNEZx?=
 =?utf-8?B?eS92RkpLdUhTY3l6MllPdjBKWStjQ3NYeElJUThRT2tIRjZPYkFkcVV0a2Va?=
 =?utf-8?B?U1o5QmVtQXNKaXJ4WUM4ZFZOMytTNzYyYklsQy9BUHg5VlpKQXJjRm1KaUY2?=
 =?utf-8?B?Sm93Yy9ML1FjVjVBbnVYY2cvT0h2bzMvTzhMeC9iNE9FVURHTW5RQVFFTFlS?=
 =?utf-8?B?eFROdnRDTjZGRVl6MG54bVNvTEttRzRDSERkSkJUUnRETTdPQ0t1VWxZNUtW?=
 =?utf-8?B?QmZQRng0Wk5VNzVGMVlYUjkwcGczMGdiOXpNeXR0N1EzbHU5Z1UySW9RaGtT?=
 =?utf-8?B?djNIaGpoZTBzZ0t6YkZ3T1h0MVhkQVQ5MEdwMGJodzI2Vm5zSysvc3oweHFM?=
 =?utf-8?B?VXVtUWZVdlN2VkI1TG9WZW5EbGtjNXVGRmdpbElSb3JKd0pFeWZzSUEwbnRz?=
 =?utf-8?B?dFRrd2ZIUy9VOExiVGhzM0dITm1nbWpibExxT0RFREVHQ2I5dWdTUkhDSmdp?=
 =?utf-8?B?QTFCUnZGZjBIN1g0bndvT0x0N0NUQTV3UXJxRDdsR2wxOFRwdERSbjY0eDRJ?=
 =?utf-8?B?a1JleS8rMEJsZGtobThkUVdnWTJNMlF3bkJOWWRKb1BPUWR2NDZqQXZDTUlP?=
 =?utf-8?B?REZQMDgvK2NyZUFwL2ZybHBqRW5NeU1idGlGYk9oUU5tSEVhUE0vQzhoZXhU?=
 =?utf-8?B?MHZmcDBJZXg2cFJBSjdPd1kvWmI3T3pzdTBTMm1OL0xMZWV6cmttcGpJVkww?=
 =?utf-8?B?KzNzajlSMXlHTnJPS0lGTStETTdVTGdQT0Y5WjJ0SS9nUkh3SWpDME44U2F3?=
 =?utf-8?B?Nmsyd3B2V2plcm85akRxZVZ4OUxkeEk4dWUzQjlyMzBkanduWi8ybWNEeEtO?=
 =?utf-8?B?aWhtMXIrMG8zL3VJU2o4cVFSVlJuYktXS3VZM2NPTGRlcnJBR3RGY1hxc3U3?=
 =?utf-8?Q?QS9wVCosI282+n6NiOi4j58=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16050ff0-56db-4dd0-3cd5-08d9b62e7977
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 07:28:17.4802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qmdBqcgTenZ5LVlmBVt1is76PqrmxnI9nBRK7OPqjZ5A2XInW3Z8Lz0BS+c2A8U/85IX+8LPS/XLZ2czXSCKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4324
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030045
X-Proofpoint-ORIG-GUID: a59niJaDV_yC_FTZGO1ZpBcLxNci5iw3
X-Proofpoint-GUID: a59niJaDV_yC_FTZGO1ZpBcLxNci5iw3
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



On 12/1/2021 11:57 AM, Eli Cohen wrote:
> Check whether the max number of data virtqueue pairs was provided when a
> adding a new device and verify the new value does not exceed device
> capabilities.
>
> In addition, change the arrays holding virtqueue and callback contexts
> to be dynamically allocated.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 33 ++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b66f41ccbac2..62aba5dbd8fa 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
>   	struct mlx5_vq_restore_info ri;
>   };
>   
> -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
> - * provides for driver space allocation
Is this comment outdated, i.e. driver space allocation in 
mlx5_vdpa_alloc_resources() already provided?

> - */
> -#define MLX5_MAX_SUPPORTED_VQS 16
> -
>   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>   {
>   	if (unlikely(idx > mvdev->max_idx))
> @@ -148,8 +143,8 @@ struct mlx5_vdpa_net {
>   	struct mlx5_vdpa_dev mvdev;
>   	struct mlx5_vdpa_net_resources res;
>   	struct virtio_net_config config;
> -	struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
> -	struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
> +	struct mlx5_vdpa_virtqueue *vqs;
> +	struct vdpa_callback *event_cbs;
>   
>   	/* Serialize vq resources creation and destruction. This is required
>   	 * since memory map might change and we need to destroy and create
> @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>   {
>   	int i;
>   
> -	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
> +	for (i = 0; i < ndev->mvdev.max_vqs; i++)
>   		suspend_vq(ndev, &ndev->vqs[i]);
>   }
>   
> @@ -1245,7 +1240,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   	int i, j;
>   	int err;
>   
> -	max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
> +	max_rqt = min_t(int, ndev->mvdev.max_vqs  / 2,
>   			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>   	if (max_rqt < 1)
>   		return -EOPNOTSUPP;
> @@ -2235,7 +2230,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   	clear_vqs_ready(ndev);
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   	ndev->mvdev.status = 0;
> -	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
> +	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>   	ndev->mvdev.actual_features = 0;
>   	++mvdev->generation;
>   	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> @@ -2308,6 +2303,8 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   	}
>   	mlx5_vdpa_free_resources(&ndev->mvdev);
>   	mutex_destroy(&ndev->reslock);
> +	kfree(ndev->event_cbs);
> +	kfree(ndev->vqs);
>   }
>   
>   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> @@ -2547,13 +2544,24 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   
>   	/* we save one virtqueue for control virtqueue should we require it */
>   	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> -	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +		if (add_config->max_vq_pairs & (add_config->max_vq_pairs - 1) ||
> +		    add_config->max_vq_pairs > max_vqs / 2)
> +			return -EINVAL;
It'd be the best to describe the failing cause here, the power of 2 
limitation is known to me, but not friendly enough for first time user. 
dev_warn would work for me.

> +		max_vqs = min_t(u32, max_vqs, 2 * add_config->max_vq_pairs);
> +	}
>   
>   	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
>   				 name, false);
>   	if (IS_ERR(ndev))
>   		return PTR_ERR(ndev);
>   
> +	ndev->vqs = kcalloc(max_vqs, sizeof(*ndev->vqs), GFP_KERNEL);
> +	ndev->event_cbs = kcalloc(max_vqs + 1, sizeof(*ndev->event_cbs), GFP_KERNEL);
> +	if (!ndev->vqs || !ndev->event_cbs) {
> +		err = -ENOMEM;
> +		goto err_mtu;
Not a good idea to call mutex_destroy() without calling mutex_init() 
ahead. Introduce another err label before put_device()?

-Siwei

> +	}
>   	ndev->mvdev.max_vqs = max_vqs;
>   	mvdev = &ndev->mvdev;
>   	mvdev->mdev = mdev;
> @@ -2676,7 +2684,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.ops = &mdev_ops;
>   	mgtdev->mgtdev.device = mdev->device;
>   	mgtdev->mgtdev.id_table = id_table;
> -	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>   	mgtdev->madev = madev;
>   
>   	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
