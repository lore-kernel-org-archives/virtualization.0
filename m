Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB18C433EF
	for <virtualization@archiver.kernel.org>; Sat,  8 Jan 2022 01:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A98D660AA4;
	Sat,  8 Jan 2022 01:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2vFqgRBviNc2; Sat,  8 Jan 2022 01:23:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E60E0607F9;
	Sat,  8 Jan 2022 01:23:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF254C0030;
	Sat,  8 Jan 2022 01:23:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 852F1C001E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67D4760A85
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:23:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i3-26oEVlglT
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:23:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EA7C607F9
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jan 2022 01:23:13 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207MEqUU012577; 
 Sat, 8 Jan 2022 01:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8dZNYJ9LVF1hDe7sfYzr6H03CgDVruST6xGRRWeXMug=;
 b=YVBqp12637CHhKc1+DustgZkKLqAfWx1QHTxFw2LAWuPRqdpK2oPDFCKFr0Xjdm9ZDPy
 sYxRFMVl2jU66+fwB+y0/GEiVr06+m0vAnnMgD1D2qBh4dvhxXeAra/B4oASYDVRyMy8
 Llr8wNnLjReeXLIhiJCB/zuMfLXSoabqCHvlfIASZ8JdZ5XI39P+Us/mMmWLYSgxz/tH
 LW6Xiq3Sp36mj5tZPxKUtoq00QY2X06wVhJyi+DflW1UaiuFvucEEn3j2erfMgoAQ97p
 HrAI9nQoP/D1JI/zNHhoCd2qxo/vNPhfKUj9PJgHE2ZInT5fBWRVFFKYa3wHmP5DIcgq 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3de4v937gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 08 Jan 2022 01:23:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2081FmJC048890;
 Sat, 8 Jan 2022 01:23:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
 by aserp3020.oracle.com with ESMTP id 3dej4thtt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 08 Jan 2022 01:23:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggBNau0CoSardPV5xasjGvt93hsZIAgGaR/13FMCcmQFD+xMKUgp0BjsXaMRxpQeaH2jBq9WeKfeq8o1iek/PW0zahyvJIgAyYoi9suCQTCdKK2bQWkynr5SctLGTlXQlxEMY0uxJN8jQ/xTjHIzlhnI4BymdGXxEzQPTGCOAWJPWJOAkIMAKglHs5ElEOtRR9MBj9mbFE8i77FDH8d5lT5xRDTZgwe5TVUio0XBXq9uXhvl1nqIDwtJzja4gpcdwuh3iQG7yPYGXsDzhru4dG9/f9BBZ+F+VntiE7p0FKgs1xZyf+Nn2FerYef7OfZyXlpXqqu3UU0Cv2TP/Ot4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dZNYJ9LVF1hDe7sfYzr6H03CgDVruST6xGRRWeXMug=;
 b=P3b1j2HjZ03Mggi4GhX3D61vT+/utJ3hCYntEpNNAB35SQbABEC/2NkDK8d7pcs31eJKzffF8kmFxwoDXQ0EjYhOXb+hliimSLVq8DkQ9gvzzt8W1E0kxUvopv0TnXI+dEsXPE98Yqf2LzclGLXp3eCuniZ9rNAKvHqiNif//1fu6iaO4kX9z1yjSHiXd6PpvAswOWFkbMTLoHYEFov//pFqLcz2aYy09qmbme/4ysyaFWpe4wqTRTCq1jl00EuPiEZZ85IQ+/QXr9tALxKLoNiwX5TsHQUN4wm+RFJnQFOixu7ruSNSzQGFXcgDsqvKgW7KZRLliqI3+m67UG3ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dZNYJ9LVF1hDe7sfYzr6H03CgDVruST6xGRRWeXMug=;
 b=Iy4uWONSWY5YbyqLuA8wsldQ9Homf3E9y0LZJ87duZU7lEDdvvh2vTmxZqYdAlZseuucr4wum7MotETtj+8nDRX2Iyk9aaIcxdUrDQPL3Olh7HECV8HBs5x4FPJzOIu9qcr2gEoEkT+DahPgsAe7+GPltoLuHzvtd6UAhDcQ7v0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3126.namprd10.prod.outlook.com (2603:10b6:a03:15c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Sat, 8 Jan
 2022 01:23:09 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4844.019; Sat, 8 Jan 2022
 01:23:09 +0000
Message-ID: <cca0ff36-63ca-701c-30ed-f368cb80a813@oracle.com>
Date: Fri, 7 Jan 2022 17:23:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 03/14] vdpa: Sync calls set/get config/status with
 cf_mutex
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
 mst@redhat.com, virtualization@lists.linux-foundation.org
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220105114646.577224-4-elic@nvidia.com>
 <e6218f34-a7e6-9bc5-8de7-7690dec9aa01@oracle.com>
 <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <586d5d2a-e57c-117e-81d9-8b1366236002@redhat.com>
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b05885db-fbb3-4895-2d7f-08d9d2456e3e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3126:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3126462F939A1D28BA6B843DB14E9@BYAPR10MB3126.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0sYjvvTmUC6ptA4eprjeXuoPuRzso4We6oVvfPYlpJSgwKHr7EiKY6pvTSS2pzH1lcdMS7nXcbvqS0iUvSkdqYUdO/PhXXGfehtZvdyVx+dSPR1zHBex6DZJZEj/0qgF2U7TqdKmLKEyj9y94BuA1pVBiINuqWC4btblqBwiOtTY7UicU0d/nRnrRSmsUncZx8l9wBVqxuoYwkC44WLVGg3FmpZfWydiPkRsqFYadcI5noPOGVkqesKEujI5qhUTa9wJ7q3DfZmzK9UAXt9Tdis7bPNs4OmQDFXVl59QNB8t3mdF64FgbdjjHWr1kTkvlyn0upBXsEcFO5qNNxHB7kfb6GvTcuo1Xwn3yJ81MgEC061wiAjcVkVUOSXDSRBn9YO+1FDjJw6OMZcEOq2kkmcz3+VznaVd+tyt8ClnlFqPEda/5eOw40ChT013Z6HJXeY0ChM1fRuUnCa0h8jUFh8xbz86lYfj0kbDJQs4rurOATgwC/seoZdZ22KMwj3hw3MRdzqyqn5yGmQaVB9LSGwyE1PZO05ohflD55mE5RaVofocx5zZWb2iG7uVe3Zhq7+dbaTs0WLZoSMnibHg+29alxLT3Sb0TAquFZaaHP/zREANXzysjhPKw2js/3Yfp+zccCZhuxDOlm3O6q212JfX//P1O1Ucyu5A70Uzl912IEh46ZZZV+S7V34E6LX4ezPaO3R6QVkxDCpOwb3e8fOPMHIz8FUQoNIKxTHGmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(8936002)(31696002)(6486002)(36756003)(66946007)(508600001)(86362001)(31686004)(36916002)(8676002)(2906002)(83380400001)(186003)(53546011)(6506007)(26005)(316002)(2616005)(4326008)(110136005)(6666004)(6512007)(66476007)(66556008)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0orVVlDdE90UGI4Z2ZUdmg0TmU3MGxiZDNqR0wzQ2wxMjVnWGkyc1dIQlFD?=
 =?utf-8?B?V3J0UmNlV3JCaDlXSWQyc0I2bXI5U2hCV1cyQXAyQUFPZkhheUxoSUM4dEpV?=
 =?utf-8?B?aERzd2JGTzl1M3ZVdGZ3bVRPNVp6TWtlcW0zVy91TFdnOE9Nc3ZjYjJaOFFF?=
 =?utf-8?B?VUtmREJFN3VEQ0NVWHFpZmxIMHVJRVJDMVhibjh4VWxuanJSV0NOWnAzWTdt?=
 =?utf-8?B?RzJhdS9scXhMaDc5RS8weSt0TkRvalcxSFB0SExMaDVPcDYxTldpZVkxT0tp?=
 =?utf-8?B?NHE1VGd4NnBEb0JBQ3RQbDVGVG1HVnM3RHo2N2FoODFrdUl1VmhqN0hCZy9D?=
 =?utf-8?B?cmdNb3hLbHZZMlJ0NGZVeG9qbzkwWjVIckxmVFN6c0dMRS90UlFldzYzU1JY?=
 =?utf-8?B?OE9INGFaTk1PWDNJTTgwSXJmWHZGUG9ISTZDOE5PYkQveFNsVVo3b1FiMlNC?=
 =?utf-8?B?VVh0T2xKMk4weDNwekN4bDVUM0ZFZUd3TTRlN2w4NTBVOWFaMDNWZXVldnNX?=
 =?utf-8?B?Y2RqOXBjY0hyUmo3SS9NRC9BNituMVMvV0tGeS9RTERKMkpqMTVrSnlYR28r?=
 =?utf-8?B?UUtMODBPRXpGNVg0VTYyVHpKNUdCbkthb0NHOC8vd040cW1xbUhVNFlSTzcz?=
 =?utf-8?B?bSsvTmZGTE81Z1dXZE91TEJ3S2JtNG03ZHpJdzhpOXAxY244SWxma2dDRjlu?=
 =?utf-8?B?aW5Va2FieXBRMVJBL0ZZRUI5ekNhVmZDR0EzbXlTOTNmanRYeHJTR0xrRnB3?=
 =?utf-8?B?M05taXpub2NWZVRjTk5qa2hxcTNoSkNIK1IzdWphek42UHVVNHE1U0xJYTU2?=
 =?utf-8?B?MFRJaUREUUxUeDhqZVluTUR3K3dGN3lDNitLREJrK01JWHZUQlRweCt3R1Yx?=
 =?utf-8?B?YjJQemwyMTZidXhmL3NzVXEyYUFLNmdBcDUxeHlCaHYwbytlblZIMWJPVkdq?=
 =?utf-8?B?TERLUysrcmtoWXJ5aWVzclpweVE3MW1vN0JtbitaaXo3MG9odjVtQlBtSTR5?=
 =?utf-8?B?S0JkOXM2YVdVRUJjejVqcnZyQURNbmpxVmtjdG4yeXA0MWppVTRKQm5PNVlx?=
 =?utf-8?B?bkp1aDlyUmVIbmEwZXA3VFIzY29aQ21nVTJrNnpwNlY3NkF3MEhtL0xib0JP?=
 =?utf-8?B?RzlKck1rUVR6dVN6bFdJb3A2UUJOOXl2RFMxeVJvWGJvTytZZ0VCaTQ3WGNt?=
 =?utf-8?B?YjREVlpXakxtc3BsUy93ZnMyQ0NEcExJcnVnN3BOVmkyTjhpMkVoT2cxQjJw?=
 =?utf-8?B?dkd4cDZFY3ZYQjc4b2VpUFpqS08zZjJVaWF5eG1lN0JmRU8ySFpObDJMcHRZ?=
 =?utf-8?B?c1RMbmM3KzcvR2djaHY0V0RBMXVtbVl0QmlwWUsyV1VNb2I5QWh0K3F1dWlM?=
 =?utf-8?B?NEN3cmZyYzM4d0lWSGlCek12NmQyN2VYNHNjbFY3YkJBRTFsVFlvQVpoRTV5?=
 =?utf-8?B?U2xHUFpJakpONHp4TURBL0lSWU90bUxJanJWbGNBelFoUmlYdi9ETFZHMXJK?=
 =?utf-8?B?S28zUnF6UXpMaUNhNExuTnp5R05YREUwaGY5aUE1ZTlBQnY5cTN4QWZIZ0gx?=
 =?utf-8?B?K3d6VzZURW5pREFmY3htcDJJQlhSZERtWGdqVXppcUdpU3o2cm00SGdNVW1x?=
 =?utf-8?B?all6L1JUMzV0Wmt4NmdhZjU1WUxFZkY1STBDS2pvWDRPWGhpL1NyR05iYkxC?=
 =?utf-8?B?NzZPeC9Cc3RKazZqbWtqcGJDSldjZmdNL3FHb0crSGtJenppdE5HWDd4cjZp?=
 =?utf-8?B?dGlYRnBzNkZDbnRTUUFpS0wvWEpRa2dtOVRkMkJXNUloSERIbHZLdTRRazBI?=
 =?utf-8?B?dXQ3eEY4VXFGOFBxeE03aDE5ZTBJdFcyZ2VacUkzdkhaUFhMN2N4UVRWdDc2?=
 =?utf-8?B?aTVicXpaeFR6ak9UNkdKN0Y2SjIzUlJoVDFrY2I2VWpNTWtYcVhIODJsRzV3?=
 =?utf-8?B?cXczQlV4OFFORmI5Z0J5WDRuUC9mdXA0YXZRODFtUHpaT3A4M0FXM293Yjli?=
 =?utf-8?B?WUViYTR0Zk5xaEpxMkM0aGt3djIzZVArVkZKb2RaMHVkakJnME1HK3lBMjQ3?=
 =?utf-8?B?c1NGQnlsYWtJYmpjUlVEZlYrektSV0piZlk1cWpmK1dLRXY4N0RRbDEzWjg5?=
 =?utf-8?B?WVZJTS9YOGFNUC9HekI3bitDSmkvWXNIT25ockJtdG0xbVBKdjZFN3pLQko0?=
 =?utf-8?Q?Q1KLbIY8K84O5fsj5+MOiwI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05885db-fbb3-4895-2d7f-08d9d2456e3e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2022 01:23:09.5655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYCiJ+c1t1yQgircm9NZYVO1vMt9Szqe4C3lu6wtFuRa+bFUtFg0fBwcNQLvkl0w9j6TNQIP1NI7KKcCfC1MAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3126
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10220
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201080005
X-Proofpoint-GUID: qg4tZEJ_P73AY-LJ2evoqHwNNAT7hPEf
X-Proofpoint-ORIG-GUID: qg4tZEJ_P73AY-LJ2evoqHwNNAT7hPEf
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAxLzYvMjAyMiA5OjA4IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4g5ZyoIDIwMjIvMS83
IOS4iuWNiDg6MzMsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Pgo+Pgo+PiBPbiAxLzUvMjAyMiAzOjQ2
IEFNLCBFbGkgQ29oZW4gd3JvdGU6Cj4+PiBBZGQgd3JhcHBlcnMgdG8gZ2V0L3NldCBzdGF0dXMg
YW5kIHByb3RlY3QgdGhlc2Ugb3BlcmF0aW9ucyB3aXRoCj4+PiBjZl9tdXRleCB0byBzZXJpYWxp
emUgdGhlc2Ugb3BlcmF0aW9ucyB3aXRoIHJlc3BlY3QgdG8gZ2V0L3NldCBjb25maWcKPj4+IG9w
ZXJhdGlvbnMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5j
b20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvdmRwYS92ZHBhLmPCoMKgwqDCoMKgwqDCoMKgwqAg
fCAxOSArKysrKysrKysrKysrKysrKysrCj4+PiDCoCBkcml2ZXJzL3Zob3N0L3ZkcGEuY8KgwqDC
oMKgwqDCoMKgwqAgfMKgIDcgKysrLS0tLQo+Pj4gwqAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Zk
cGEuYyB8wqAgMyArLS0KPj4+IMKgIGluY2x1ZGUvbGludXgvdmRwYS5owqDCoMKgwqDCoMKgwqDC
oCB8wqAgMyArKysKPj4+IMKgIDQgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2Ry
aXZlcnMvdmRwYS92ZHBhLmMKPj4+IGluZGV4IDQyZDcxZDYwZDVkYy4uNTEzNGM4M2M0YTIyIDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGEuYwo+Pj4gQEAgLTIxLDYgKzIxLDI1IEBAIHN0YXRpYyBMSVNUX0hFQUQobWRldl9oZWFk
KTsKPj4+IMKgIHN0YXRpYyBERUZJTkVfTVVURVgodmRwYV9kZXZfbXV0ZXgpOwo+Pj4gwqAgc3Rh
dGljIERFRklORV9JREEodmRwYV9pbmRleF9pZGEpOwo+Pj4gwqAgK3U4IHZkcGFfZ2V0X3N0YXR1
cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4+PiArewo+Pj4gK8KgwqDCoCB1OCBzdGF0dXM7
Cj4+PiArCj4+PiArwqDCoMKgIG11dGV4X2xvY2soJnZkZXYtPmNmX211dGV4KTsKPj4+ICvCoMKg
wqAgc3RhdHVzID0gdmRldi0+Y29uZmlnLT5nZXRfc3RhdHVzKHZkZXYpOwo+Pj4gK8KgwqDCoCBt
dXRleF91bmxvY2soJnZkZXYtPmNmX211dGV4KTsKPj4+ICvCoMKgwqAgcmV0dXJuIHN0YXR1czsK
Pj4+ICt9Cj4+PiArRVhQT1JUX1NZTUJPTCh2ZHBhX2dldF9zdGF0dXMpOwo+Pj4gKwo+Pj4gK3Zv
aWQgdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+
Pj4gK3sKPj4+ICvCoMKgwqAgbXV0ZXhfbG9jaygmdmRldi0+Y2ZfbXV0ZXgpOwo+Pj4gK8KgwqDC
oCB2ZGV2LT5jb25maWctPnNldF9zdGF0dXModmRldiwgc3RhdHVzKTsKPj4+ICvCoMKgwqAgbXV0
ZXhfdW5sb2NrKCZ2ZGV2LT5jZl9tdXRleCk7Cj4+PiArfQo+Pj4gK0VYUE9SVF9TWU1CT0wodmRw
YV9zZXRfc3RhdHVzKTsKPj4+ICsKPj4+IMKgIHN0YXRpYyBzdHJ1Y3QgZ2VubF9mYW1pbHkgdmRw
YV9ubF9mYW1pbHk7Cj4+PiDCoCDCoCBzdGF0aWMgaW50IHZkcGFfZGV2X3Byb2JlKHN0cnVjdCBk
ZXZpY2UgKmQpCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+Pj4gaW5kZXggZWJhYTM3M2U5YjgyLi5kOWQ0OTk0NjVlMmUgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92
ZHBhLmMKPj4+IEBAIC0xNDIsMTAgKzE0Miw5IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0
X2RldmljZV9pZChzdHJ1Y3QgCj4+PiB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKmFyZ3ApCj4+
PiDCoCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX2dldF9zdGF0dXMoc3RydWN0IHZob3N0X3ZkcGEg
KnYsIHU4IF9fdXNlciAKPj4+ICpzdGF0dXNwKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCBzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+Pj4gLcKgwqDCoCBjb25zdCBzdHJ1Y3Qg
dmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4+PiDCoMKgwqDCoMKgIHU4IHN0
YXR1czsKPj4+IMKgIC3CoMKgwqAgc3RhdHVzID0gb3BzLT5nZXRfc3RhdHVzKHZkcGEpOwo+Pj4g
K8KgwqDCoCBzdGF0dXMgPSB2ZHBhX2dldF9zdGF0dXModmRwYSk7Cj4+IE5vdCBzdXJlIHdoeSB3
ZSBuZWVkIHRvIHRha2UgY2ZfbXV0ZXggaGVyZS4gQXBwZWFycyB0byBtZSBvbmx5IAo+PiBzZXR0
ZXJzIChzZXRfc3RhdHVzIGFuZCByZXNldCkgbmVlZCB0byB0YWtlIHRoZSBsb2NrIGluIHRoaXMg
ZnVuY3Rpb24uCj4KPgo+IFlvdSBtYXkgYmUgcmlnaHQgYnV0IGl0IGRvZXNuJ3QgaGFybSBhbmQg
aXQgaXMgZ3VhcmFudGVlZCB0byBiZSAKPiBjb3JyZWN0IGlmIHdlIHByb3RlY3QgaXQgd2l0aCBt
dXRleCBoZXJlLgpJcyBpdCBtb3JlIGZvciBmdXR1cmUgcHJvb2Y/IE9rLCBidXQgSU1ITyBpdCBt
aWdodCBiZSBiZXR0ZXIgdG8gZ2V0IHNvbWUgCmNvbW1lbnQgaGVyZSwgb3RoZXJ3aXNlIGl0J3Mg
cXVpdGUgY29uZnVzaW5nIHdoeSB0aGUgbG9jayBuZWVkcyB0byBiZSAKaGVsZC4gdmhvc3RfdmRw
YSBoYWQgZG9uZSBpdHMgb3duIHNlcmlhbGl6YXRpb24gaW4gCnZob3N0X3ZkcGFfdW5sb2NrZWRf
aW9jdGwoKSB0aHJvdWdoIHZob3N0X2RldmBtdXRleC4KCi1TaXdlaQoKPgo+IFRoYW5rcwo+Cj4K
Pj4KPj4+IMKgIMKgwqDCoMKgwqAgaWYgKGNvcHlfdG9fdXNlcihzdGF0dXNwLCAmc3RhdHVzLCBz
aXplb2Yoc3RhdHVzKSkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FRkFVTFQ7Cj4+
PiBAQCAtMTY0LDcgKzE2Myw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhz
dHJ1Y3QgCj4+PiB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4+PiDCoMKgwqDC
oMKgIGlmIChjb3B5X2Zyb21fdXNlcigmc3RhdHVzLCBzdGF0dXNwLCBzaXplb2Yoc3RhdHVzKSkp
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FRkFVTFQ7Cj4+PiDCoCAtwqDCoMKgIHN0
YXR1c19vbGQgPSBvcHMtPmdldF9zdGF0dXModmRwYSk7Cj4+PiArwqDCoMKgIHN0YXR1c19vbGQg
PSB2ZHBhX2dldF9zdGF0dXModmRwYSk7Cj4+IERpdHRvLgo+Pgo+Pj4gwqAgwqDCoMKgwqDCoCAv
Kgo+Pj4gwqDCoMKgwqDCoMKgICogVXNlcnNwYWNlIHNob3VsZG4ndCByZW1vdmUgc3RhdHVzIGJp
dHMgdW5sZXNzIHJlc2V0IHRoZQo+Pj4gQEAgLTE4Miw3ICsxODEsNyBAQCBzdGF0aWMgbG9uZyB2
aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IAo+Pj4gdmhvc3RfdmRwYSAqdiwgdTggX191c2Vy
ICpzdGF0dXNwKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4gwqDCoMKgwqDCoCB9IGVsc2UKPj4+IC3C
oMKgwqDCoMKgwqDCoCBvcHMtPnNldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPj4+ICvCoMKgwqDC
oMKgwqDCoCB2ZHBhX3NldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPj4gVGhlIHJlc2V0KCkgY2Fs
bCBpbiB0aGUgaWYgYnJhbmNoIGFib3ZlIG5lZWRzIHRvIHRha2UgdGhlIGNmX211dGV4LCAKPj4g
dGhlIHNhbWUgd2F5IGFzIHRoYXQgZm9yIHNldF9zdGF0dXMoKS4gVGhlIHJlc2V0KCkgaXMgZWZm
ZWN0aXZlbHkgCj4+IHNldF9zdGF0dXModmRwYSwgMCkuCj4+Cj4+IFRoYW5rcywKPj4gLVNpd2Vp
Cj4+Cj4+PiDCoCDCoMKgwqDCoMKgIGlmICgoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZF
Ul9PSykgJiYgIShzdGF0dXNfb2xkICYgCj4+PiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSkK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnZxczsgaSsrKQo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgCj4+PiBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb192ZHBhLmMKPj4+IGluZGV4IGE4NGIwNGJhMzE5NS4uNzY1MDQ1NTliYzI1IDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+Pj4gKysrIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+Pj4gQEAgLTkxLDkgKzkxLDggQEAgc3RhdGljIHU4
IHZpcnRpb192ZHBhX2dldF9zdGF0dXMoc3RydWN0IAo+Pj4gdmlydGlvX2RldmljZSAqdmRldikK
Pj4+IMKgIHN0YXRpYyB2b2lkIHZpcnRpb192ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYsIHU4IAo+Pj4gc3RhdHVzKQo+Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCBzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2ZF9nZXRfdmRwYSh2ZGV2KTsKPj4+IC3CoMKgwqAgY29u
c3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+Pj4gwqAgLcKg
wqDCoCByZXR1cm4gb3BzLT5zZXRfc3RhdHVzKHZkcGEsIHN0YXR1cyk7Cj4+PiArwqDCoMKgIHJl
dHVybiB2ZHBhX3NldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPj4+IMKgIH0KPj4+IMKgIMKgIHN0
YXRpYyB2b2lkIHZpcnRpb192ZHBhX3Jlc2V0KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBh
LmgKPj4+IGluZGV4IDljYzQyOTFhNzliMy4uYWUwNDdmYWUyNjAzIDEwMDY0NAo+Pj4gLS0tIGEv
aW5jbHVkZS9saW51eC92ZHBhLmgKPj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+PiBA
QCAtNDA4LDYgKzQwOCw5IEBAIHZvaWQgdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldiwgCj4+PiB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pOwo+Pj4gwqAgdm9pZCB2ZHBh
X3NldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQs
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHZvaWQgKmJ1ZiwgdW5zaWdu
ZWQgaW50IGxlbmd0aCk7Cj4+PiArdTggdmRwYV9nZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldik7Cj4+PiArdm9pZCB2ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCB1OCBzdGF0dXMpOwo+Pj4gKwo+Pj4gwqAgLyoqCj4+PiDCoMKgICogc3RydWN0IHZkcGFf
bWdtdGRldl9vcHMgLSB2ZHBhIGRldmljZSBvcHMKPj4+IMKgwqAgKiBAZGV2X2FkZDogQWRkIGEg
dmRwYSBkZXZpY2UgdXNpbmcgYWxsb2MgYW5kIHJlZ2lzdGVyCj4+Cj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
