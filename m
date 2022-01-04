Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB48C433EF
	for <virtualization@archiver.kernel.org>; Tue,  4 Jan 2022 13:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99C3C8261C;
	Tue,  4 Jan 2022 13:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qe3CR1yoQ9E5; Tue,  4 Jan 2022 13:28:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F1E0813FA;
	Tue,  4 Jan 2022 13:28:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16907C002F;
	Tue,  4 Jan 2022 13:28:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A902C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 13:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1834C60E64
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 13:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="yHpHaxPf";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="hhgc+nhq"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4-spBb3MQFry
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 13:28:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCC7060BE3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 13:28:13 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204C6ikO006516; 
 Tue, 4 Jan 2022 13:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B6Q9XKPSiT7tJdEgvw2KxlleMKfj2IAkZsocG8/2IXY=;
 b=yHpHaxPfEhigOSoe5aRegNZRgIZwe7tkoIyLtowBX8+KvEDl/bvLy1n5y3Cw6Cq2gJDQ
 CWw3WCuzBgMQGlMxsmCTM/2atoMIQoHvLAE1vLQEo8tp/3w7tobWhmAJBSBh2gfc1UFe
 JVNW2pOE+o8c0erwH+dR0pU/h8GhGrwBIFOBJKf2ZINIDooPPj6RqAfLswecG7ldtyTU
 gKb7lYsit6jUwnDuvs/yjeO2+v0QMH4hRQwTJMiJTVT5ddAgEkDA8K1A1sjAsdtDUNa/
 bDeXEg6DL+pFZltb8lo4fZ1z2c/rjqw2DY6yEeh4ExVaWsHjBPJ+ha+sl4Vx7VgBYzIZ PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4j5wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jan 2022 13:28:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204DG3Uk023906;
 Tue, 4 Jan 2022 13:28:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
 by aserp3030.oracle.com with ESMTP id 3dad0dhdyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jan 2022 13:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVX5N+fgCWWvxNNL+URIaASHwk6d/JwQ/VbQkg8Av/FOPlOyJ83RUGDu1NME4OI/IchX0VwMnXfI2bWEisGJDCZ4EPdy+xKcR5aPYME4y1UgfXa+ouiwrvVuXeukrznsxC8tQMNtR7y8sUOcPNOvU+o/VtR8OKfWg5hYT09Di2ZMLlFJ0Kcee8CCjAp367u5H8fGsNGBjnd1BO3eZxzrzysWcs0UpiwBt67yKRzeCFOHcFMB5oX66HeuNsd2PgjeoaNSuDG7mdCYw3l5IwchL4G59dag7dTsyxIHxhtTWXPuQJ9Q39S2ISvBGh5Wlev0tXyfJlvcVEzQYNuzYdNJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6Q9XKPSiT7tJdEgvw2KxlleMKfj2IAkZsocG8/2IXY=;
 b=QgaQih3/XbaJGNBUARwdxpex2T2+8eq4UJYnQKmj/tWJjg0tcRR4MflbI5Te0Xftpsgk1KGFs0eRsl2Bov64KmekvxpACTmKIX+ULW/qAR3YW4a+DsL/2vnMsP6lWJ3hWFOm8MQ2zCTG6XYJzPXh2BnCEMma8dQ8rabMwvJz6QIeiG6tvYw67d+3RYqAl8tkG0NsufFRFw6eBeKpv+6iKy6PUbVaEViWKusPmoQC9M4ZEL3MUW3177iSMyV8tR/dpEfsmVdUEwydrS2NY7gGDmTb88SUE31ugo9bvDqYUgL5zxf9XFbXLKWu9wrcOtKHVNTROGkbRaBBKm+WgrTi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6Q9XKPSiT7tJdEgvw2KxlleMKfj2IAkZsocG8/2IXY=;
 b=hhgc+nhqk41EDUOSaIlH18W8hg5uzFPE5x7mqn6VXO4U+yvAmA10fWK/bMLWtdmbcHg8w9XcKb3DwajpVC46eP5liGmlFmac/PvLhmifY1pRbcIHjNMhMI1yJVAw+9HyLPDOsTfG0PTAVPcGQ2rIpXelp4OZQPvqfDDW/c/OMxU=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2632.namprd10.prod.outlook.com (2603:10b6:a02:b2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 13:28:09 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 13:28:08 +0000
Message-ID: <6f5197b4-7d4f-0e70-2971-ac38345458ae@oracle.com>
Date: Tue, 4 Jan 2022 05:28:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] vdpa/mlx5: Fix wrong configuration of virtio_version_1_0
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211230142024.142979-1-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211230142024.142979-1-elic@nvidia.com>
X-ClientProxiedBy: SA0PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:806:d3::9) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3b21789-eaa7-44b4-fd2c-08d9cf860c37
X-MS-TrafficTypeDiagnostic: BYAPR10MB2632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB263290F1C47156A420CDEDA3B14A9@BYAPR10MB2632.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBMiUbL65MN2xDZwAb2P0O57Jr+FeARwU4jeqxuT4BwABEkcplfuBQZ1BKrl1IOvFLbDCvbEEQHSx8kC8rBVjbJ6rBhsxcK+0VIOgL3zBLKI+ro7D6m+Uuy5C6xFh5Rwi63X8Ds1BQIisndUuEdQscnCiTaPCj0CyYd/ih465ePABaErHSqc86q6D8Jo+PznAgQ06K+Svzxw3mf045Np+dlmZSAf46RAtf9UaUzyGNknA3HbtQX/f0pH2vO839tlo2UQa1CoTAORqOT/xxH9NLo/kwQar6Fy3Jt+zYFLT9qpRRzx9K/2wGdv184ak/5eCknjxD8TQOYbtDOGEYi9VGe8X5mGt6e7pUnEjnplLjZp1DGd806HNjgK0a2RsO2B13mXEHFzxcAEMTtw0SGso5V1GPmX4tVPiAz/1qxRjmBtY4fDpAjYN07NcXyoa08G0qDl/2Z81hVulK/7bVicyG1Xa4PMbazdlrqUfPlPuRLWAjABfqj61IKWtEuMxjGnLNM/lOVjuwo3eqwROk1MWHhC1l0KEN5oRQXYQ2Jbm2QiVQK6K9RNWCzW2PmCjIhymrhOAVu6FzYIPlP9eixVxcoG3KnTwc9Qe3flh6IFun5T2VOtrvuqEy6PpmS1B/pdRBadwVIxjKTVdOicifvtViO0or6/+iCrgZmc4D3ynzTdUPNbunsZ9Z3U/2A+C8x87Oa1fRlUkL1n72sd82DrkVbqk18HWRCzK22Um0hqoFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(316002)(86362001)(6666004)(36756003)(6486002)(6512007)(2616005)(508600001)(26005)(6506007)(31686004)(8676002)(53546011)(5660300002)(2906002)(66556008)(31696002)(66946007)(66476007)(36916002)(4326008)(83380400001)(8936002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUZLWVc4L0tuOVh3dVhRVExLUytWZGF5QU5OSEo4bW9mL2Q4OWRqTk9iV2JY?=
 =?utf-8?B?M3NhbjRSQWVtNVNJYnQ1N1dqelA5R1VFaGJwYkpJRHZwaVIzUG1QZ1ZsOWJP?=
 =?utf-8?B?ZEFuSStvTkV2Z0ppS2YxWldJcVJuR0RXTENLOEs5VU5oMUl2YkJJbU1KRmJJ?=
 =?utf-8?B?QXhTZTI5NnQyMmtabkNzdVY0R3pCa0VGUG1zMFNJZUtQVmcvODhMRmRza29l?=
 =?utf-8?B?K0NGaXJvRlk2Vm5rdUJVVWsyeGJnOTM2amlGQ0NOd1ZGa1RVQUVtbzRDVG5O?=
 =?utf-8?B?ZlNDWVQweUZlK254N0RLYitzSm9DR0w1TG42R2hVOTJOYmNDMlB1OEZRWEtv?=
 =?utf-8?B?a3BJWHN1OXpxelFndC9pTWRaUXFuZHpJOU9CNDdpK1J1eHNCamxqNmNVNUVD?=
 =?utf-8?B?aHhBQi84L25LMlI0bzg2Q0RNVng1OEd6RFpVRU5TNmJCcU1oMlh3VmFQajVU?=
 =?utf-8?B?RzVhYjVHemQzSGdWZ2szcit6SEQ4M0V6bHFyejJWTU5iRi9SMkRuYktLRVd0?=
 =?utf-8?B?L25Kc1FQUjkraDc1QmFuZzZzSU1abFZ6UE84VjVMSGlWSnNTYkJjbit0QVk4?=
 =?utf-8?B?YnE5aWYwUXRGNDd0RVZ2ZU5iNUNtQlJqOGNvYjBrVDFPSFZjTzU3Q0RFa29C?=
 =?utf-8?B?dTFxWURoT0JaL2I2Sjd5elk5K0dPaldqQkRmWFBXZG5uSGJOMTJhd3FpdWhZ?=
 =?utf-8?B?MktCY0pyVDlMYmZERWFLZlVxVVJqaHlESDNuS0twaVJUN1NuVnNuZjlZdFFR?=
 =?utf-8?B?dEozWExIUmFzbjFodWRCenE1R0FSMks5WFNtblVWdnppL251WmxPMG9reXNv?=
 =?utf-8?B?ZGJZTVN5dFo3ZEw1UlV4QWVYbHREczFFY080bnc4ZHh0UGV6YmNlLzNvZHJy?=
 =?utf-8?B?eTk0UDRzZDRtQnA5R3NYVnNOcDlTQzNBWlR3Qm9VdlZqL2R0RmQzWGtoRlgz?=
 =?utf-8?B?RVZXUHhmNTdFeHJvU2NJMEZqdGEwQ0wvNTdUOEZzMnYveVpvUXdmOUQzR3M4?=
 =?utf-8?B?UGF2Z1NxM25UNWkydzM5cHA3YndVVkZFd01pRUJHWE9yNlRNZkNvNlQzT1VB?=
 =?utf-8?B?N3BwZlhlallMY1VRUSt2MkwrRGQ2d0lJK0tDOWU4ajlXcVE2cWJTaS9HMEI4?=
 =?utf-8?B?OGdMZEdPdFRNbEd0aW9UZWgzanRPUzlkUHZneGcrSmhLUS9yWXpESTVSdmZo?=
 =?utf-8?B?RDZpcVZwWHRuQzAzMXdleHI0UlgzYkVMWFQ0VWdaUlFBUGorQnhPSExlcXpq?=
 =?utf-8?B?NmtrMStMdVBGOWc2ZDJhOE1rWjBGenBQTnRiUGlpaldGOC9DOEViRSttRFRp?=
 =?utf-8?B?WGdFQ1J1M1p3Z3BOUzZYR0M4V0N6ZTliQkVJaGNuYmQ2VUZFeXd4aTZYVWpv?=
 =?utf-8?B?OUtEd3lBeitOMnJqd3NIRVhnek45dW9nNSttd1doNll5VFlPUlF0RW9nS1lO?=
 =?utf-8?B?aXBmRXdiRWhGWEp2ZCtCV3FPK2ppKzFrR1czMnlFbXNxZDVZUk1zTFNaMkFF?=
 =?utf-8?B?Ui9iRU9HMW53YzlLRWowNTk2UDBlUG03Q29RZ3JobGhIbFVoYi9JczFSczlW?=
 =?utf-8?B?T0dkYm5VeU02M0NiOXpiY0tiaGpQYjh2VUsvSUc0ejNPYUZaYmh0TCt3QkVo?=
 =?utf-8?B?QlpzcHRsanJES0ltZjFxOU1lbXlXV3F1NHNZYlVtYTJOSlFNRWJHNVFtMkV5?=
 =?utf-8?B?QmZ5VEU4NWNBNVlBWUhaNllQQ21nc2pseTFhWkJZWFBtNU45cGZ3N2w0VFNt?=
 =?utf-8?B?TXZNdXhPMlFRYUFQMjBCVnl0VFA0aGg3d3BQMXMxbkd5dW9tMWt3c0k0R2dn?=
 =?utf-8?B?cTBkVG9EZXpRTUg2R01lOW0zSHQ3dWNsYmdmdGdMWm4xNEFTdkJWcUpOWU1y?=
 =?utf-8?B?cEdxTkZoTWFTVC9SUTdDMkUwb1VSWVpOWmxwWDk2a1dQTHRDcWVqYzBMSU1q?=
 =?utf-8?B?a1Bscm50b0FXbXowc0IrcWZLS1VicnV0Smk1UXpPTlVSREU3Mm5UTkQ4ekFW?=
 =?utf-8?B?b3d0dUEyMlBGUmcvRmJqQWVXMC9IQ0NCQ2RQV1B6alBmNFNjSjZoVzRpc3lE?=
 =?utf-8?B?SlkyZ09vakU2MXpYd2h6MjJqaUhiRldjczVxY2t0aFFEdWtYbkUxR0NEWW1q?=
 =?utf-8?B?RU5QY1ZmdzRxWUMrdVlpcE1GMXVOQzltclMvTllOV3laYTR2WlBsazdSRURV?=
 =?utf-8?Q?mAEoTVQVANBB4RC309nAqFs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b21789-eaa7-44b4-fd2c-08d9cf860c37
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 13:28:08.8448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1LYZklqyHAHYobd7LMfpdrfioIZ4NhSNsvxAKvfK37mTUJRXwwo4ePNl0Fmj1e1JWiRH+4SW/cwlfuvfpD70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2632
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040090
X-Proofpoint-GUID: QZUtkgJTj_rwLN_kIKwuFXHTptW03-wX
X-Proofpoint-ORIG-GUID: QZUtkgJTj_rwLN_kIKwuFXHTptW03-wX
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



On 12/30/2021 6:20 AM, Eli Cohen wrote:
> Remove overriding of virtio_version_1_0 which forced the virtqueue
> object to version 1.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

-Siwei

> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1eb473cb9d4d..e946a36bf7ee 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -871,8 +871,6 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>   	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
>   	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>   	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> -	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
> -		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
>   
>   	err = mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(out));
>   	if (err)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
