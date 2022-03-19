Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0E0C433EF
	for <virtualization@archiver.kernel.org>; Sat, 19 Mar 2022 05:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7EB2415E1;
	Sat, 19 Mar 2022 05:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L0Aqw7_fLwtx; Sat, 19 Mar 2022 05:18:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B3588415BD;
	Sat, 19 Mar 2022 05:18:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A9C0C0012;
	Sat, 19 Mar 2022 05:18:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B742C000B
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Mar 2022 05:18:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6491402E1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Mar 2022 05:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="TP4i7ZfE";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="pa0f01nH"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R-cmbBrhgiKj
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Mar 2022 05:18:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B41440139
 for <virtualization@lists.linux-foundation.org>;
 Sat, 19 Mar 2022 05:18:29 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J1uTeG027608; 
 Sat, 19 Mar 2022 05:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XUTN3konkKQAPI7U2Dj5IkYj6Osg81ceReR3k0oEeyA=;
 b=TP4i7ZfEEHO5fDqp5GRMhVmvevEER/t1WsqG+YBgopKC2f/3vsSx4w9FCA6q8CSo5sak
 9dU22YS6gaiC6Gr9SeBUr44DlAetqOcbChWV6Yn//qjDkHPqzMZAgmc1IAdvrqI1MB8V
 IibjU+7Um+Nqd9oaRts1ClQeXLIjFM9EFsdXca7ojRIm88ndGfZVAcwgwnqyhQU+0BUC
 gWPtLwcG2YJfKKyGgwpbODGRrO7HhD1Tnv0b0wfXHcM6B8n83FXBO3gxzqInQJY1xyHr
 ebktjLYBxgPi+/sEsLS9hIelFIuORXA/NKvDtlLsYaE9gGiGAc2T7bEEaMGDqBLSXRKx KQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y1r3r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Mar 2022 05:18:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22J5FqMI140543;
 Sat, 19 Mar 2022 05:18:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by userp3020.oracle.com with ESMTP id 3ew8mfr51t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 19 Mar 2022 05:18:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz45qxbK4bfycWL5ijf9xnOY7693zeFOQ6+SMcXJXUObu/IZsOuU6r5QR6OC2JT512FVNXqSkJMd0SAm+3/lOkVm4rl72MdjuT/flw+dk4HRS9bBcYl65h8FRKFcGVLWIOnmJy81pRx+k3Xeq42delyhHfl37jIL/73+/u21WzUnjaGDIITBKRj2GbUmwqV/DRUqZsHL5fWa+CqpAbxrLutjKeT3KamjT67YxK64lcU+aRY0tGZqkTT7AylXE8dgMCMvTrlEBAzYB7A1NfWCGzYif3zhdxcGDNOXyRdq6W/eB3VOCwVexJGo+uS1H+mTnKu3JS+nib2wrvuFHDtWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUTN3konkKQAPI7U2Dj5IkYj6Osg81ceReR3k0oEeyA=;
 b=dfBEUwxADLJCF5Bzfr3C2QNRn1jtR8YC3qqbfcxwyvTPpt1wWeItio6381f+6zi5BsDfIw/nuxbxYjI/reEf3RCnp37X+mPt1r61q8yy3hR4yLtq2uIJ2sgWQkL2irLhrdNNWw6a83J2Rn4m0ZIAhJt9Bl5ccTVwmNGaB0uVVjeb1QlanrVxZkl0HpVoDBL7Vkl7jQQf/plT4nOWRtwUne+Lx80l/tZa4v8XccV6grypm+S8bqmj0SEt6mWu0Nl+ZcufUE+tfg4u8HmxdmUEgfu1H1uLUy/pq88lTfHXbkepOdFnZpJ/CEVFmkzlaPi2QN8dycHMQhwNPyvbgZYL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUTN3konkKQAPI7U2Dj5IkYj6Osg81ceReR3k0oEeyA=;
 b=pa0f01nHYjbRNODBuiyu46QyB4e9SMAr9MK7mb0I82FL23IHeQHQfXHWlRHBNOJ/S1MP8zLQRntVPSg83FeBWvHmjTz8+9Y9nO0GxCx3q7HY+0v2nP60LOlGCMnGAa1sQDTXOxcpBmOuARfmUqQVcL3zqZT9aJeuoMAIHBcphrI=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2917.namprd10.prod.outlook.com (2603:10b6:a03:87::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Sat, 19 Mar
 2022 05:18:24 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::e478:4b5e:50a8:7f96%6]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 05:18:24 +0000
Message-ID: <8b7e1fec-4f58-b2be-66af-454928f79814@oracle.com>
Date: Fri, 18 Mar 2022 22:18:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20220216080022.56707-1-elic@nvidia.com>
 <6175d620-6be3-c249-5482-0a9448499e4a@oracle.com>
 <DM8PR12MB5400E03D7AD7833CEBF8DF9DAB099@DM8PR12MB5400.namprd12.prod.outlook.com>
 <74495f15-8f1c-93db-1277-50198ac3284e@oracle.com>
 <DM8PR12MB540086CCD1F535668D05E546AB0A9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <a30ac3c0-059d-4588-c5ac-599c060f6bbf@oracle.com>
 <DM8PR12MB54000042A48FDFA446EFE792AB0E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <61748d91-153c-ec79-c1f0-e3c44cdbea5d@oracle.com>
 <DM8PR12MB540054565515158F9209723EAB109@DM8PR12MB5400.namprd12.prod.outlook.com>
 <53dd5c21-5045-bb66-05fe-1a1157f7abe8@oracle.com>
 <DM8PR12MB5400E7B2359FE4797F190AC5AB119@DM8PR12MB5400.namprd12.prod.outlook.com>
 <7fa43ec9-202e-0cbc-22fb-0770ed023c35@oracle.com>
 <CACGkMEuvbWWiCrmuCKG7Z9OWUaFU5GT+U_yEBVg=QcWDrwOSzA@mail.gmail.com>
 <f9cd0cf9-dbbc-78e1-c6f1-50597b796545@oracle.com>
 <CACGkMEtbY07y=_CPpeoSYyd7oPEbB2OwKssQfw9=_Ly4igsEEw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtbY07y=_CPpeoSYyd7oPEbB2OwKssQfw9=_Ly4igsEEw@mail.gmail.com>
X-ClientProxiedBy: DM5PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:4:15::25) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6cff57a-37f1-4040-4af1-08da0967e3fb
X-MS-TrafficTypeDiagnostic: BYAPR10MB2917:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB291709A95C56830B0DBE2D7AB1149@BYAPR10MB2917.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NNeHJW6LPIl8IuON32x0/3j0s94LNal3aog1Rbvca1ksRT4yH2DkrJPvt/NLSBBukOd1z9e5BoPSE4sJZe3eVldL2OlZcXZAhki3esYQdrqr5JiK6mS7yUezcvld0OdlbGS1nX782ItkqxEmIjj3q0yj0jAPMIEiUYMhA4cSRIbiZKphN2APCTc38wrDZLMjeWCk9juNhEOIc1ClaBfZouOLZzFPEY4xnHMidZ58djZCvVFOPQ3FhIl8Fm/iInAIdrGCq4MbpfD+ZK3chYYzV7mW025J4ZkMop8vPDaP6+QrWkw6plODrtUOGimIOldtJPGMMO15b4ElkigHtrBxkyQaRou5bI/yXtB4IW/54jmrbC0O5RalEkt4IcWN3iM/okNTNf4IWuNDFrIo+2AtSo+4Kxr3WcXmMYjKJpIcnOMr9xJ7XgWqS2AgCT4TfQ7m5plG1OnxZJJqctMdGDr3gavXSjobflJr6GIBCkeUovtIP3zlFUec1mf5X0rp9KAuxfSZoz50FFdfNgweCcIcGgQw6pAGnM4AFdUEo2c0NYIkbUNdtcsNP+JQWwc3eKop5DF50Xxv31GsNMkvSt6aWNuSX0xnstME2Yr5EqBq0GzGkD4hPEzuuuJ9QbOXlvlZDe5/yLOXkiDPrkLdZk4iC8yejptDupNmqQz/N1sAhZYrnEpfSspmi50AKeUXFW6vyCpwO5VS3of8sJAs3Hv0hbp4vcrE255NkLptZLUdqDjmVY9UGCValt97wwiGjqH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(66946007)(66556008)(6486002)(8936002)(2906002)(66476007)(6506007)(36916002)(86362001)(53546011)(6512007)(6666004)(508600001)(31696002)(5660300002)(38100700002)(2616005)(186003)(26005)(31686004)(83380400001)(8676002)(30864003)(4326008)(316002)(6916009)(54906003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnl2cVphbjNiWE5Rd2NMcW1Rd21YQmlEUUxxQkUxQ1pkdTNnRFdRRmkzZ1l2?=
 =?utf-8?B?Q08xTlBKMkNYS1lNb2lIbFRwaWJRZVJIRHZqMGRoL2hxMDN4Nnl6bW1wZmNx?=
 =?utf-8?B?R2JCejd5TTU1MjBDb0xuRFlpVU5PS1FjakpTTmIyQnc1cXdqNG0xeHprSmJZ?=
 =?utf-8?B?dzBnUTNjY25HRFdtNDlwR3UxWWdMbVJuekNNY1hBeDFtTXhPaGMrVE1xSUsz?=
 =?utf-8?B?VG9tSGwrWWFxVEdBL2ZYMXpKTWs4Zy9xMUs3cFY0YmRERUFVOUlDMVVmalAr?=
 =?utf-8?B?NmFYSy9xZWJOQXplRm5kZ0xxNTMzVXdtZ2tiK1JENlp1clhnNUVROUZxQzh4?=
 =?utf-8?B?TmlmN1RseENIclVYMzJiWFV5YWdieUIxSTROeHEvSjJoSUJWL1p4RXBWK2xa?=
 =?utf-8?B?STR5UVZWdFVwM1J1Z3p6MjZFNEFCMTRYdHVvNmc2dldzemlDblpnZlkrb2pO?=
 =?utf-8?B?R0Z6aDY0dzBLU1VhYmVRcmpGc1JJbVA2VXl5UEtrdldEVUZXd3lUUFhSbHZF?=
 =?utf-8?B?aWNsY05nTERrb1A1ZEpKdDZlL1ZvQkJxQXdpTXpBb2FwaW1YNzFNMXhsamxw?=
 =?utf-8?B?V0RFSFY0bWp1bFBjVFBUTkpjS0pJSjRnNjBDb0ZaWFIwVU1MN0hqdDJFMEYx?=
 =?utf-8?B?azNGSGhCNnBoTmJVdm5iSnVpTkRScGlRUGJkRXg4ZTk2ZDNodWUxZDZCZVc4?=
 =?utf-8?B?alEzQTh6SE5HcjdDZW1JNDdtM2JwOEhZaHltcExmNWpzdG5WY09hSzlSWElJ?=
 =?utf-8?B?V1pzU0hMcnNhQWJZdWtGaHRIWnFaUWpMSU9GcTlaUFZnZ1poc3VKVkdkTjVB?=
 =?utf-8?B?bHlPMFloZ0crQTdrQ0RaTkc0OVYrbWd5S2FtdDNaVnRSTWh1WGQvOHhhcldo?=
 =?utf-8?B?K2h5WFRvMGtLOGp4SEtocG9LaWRvZU5UVmk1dUN4MSt5bHo1YjRGajhnM2l0?=
 =?utf-8?B?NFIxaTRyS0JuRVNMTnlMUmF6RG1XN09PT29vSHVLN3BuZVlodWRwRlpaNjU0?=
 =?utf-8?B?Vno0d2lTaFBNbHFhY2JiMmRUblRraG5MSGc0Y2VvSnA1NTI3K1RkTXZkRXZX?=
 =?utf-8?B?cmwxVmhIM2NhUXp2UE5IakhvQjlPU0Y3S1NCMjJPZnJlRmNGaFIyRVN2RnFF?=
 =?utf-8?B?UWl4ODhzMWY5bFp0U1VOWHFnN3BGSXlDMG1ZbnkyVXY1dmluZVJoVk83MEV4?=
 =?utf-8?B?MXBUZ0p0SjNBdkV5TjU0bFlUc3kwQ1VqVWhhWEVldk5oODl2SFZiUGhobElQ?=
 =?utf-8?B?Q2xxMkhxQzNtaWc4V2JqNVc4REE5RWJPUG0rNVp0R2tNK1pZZ0NWWlV3K0Na?=
 =?utf-8?B?T0l6Njd3U3ZVR00zeTNESVJUZ3o1VFgwUllZVzlnYTdTMEJDWDkrYmZ5TEF5?=
 =?utf-8?B?OVhUdzBhUFFLQlBPZW05RmJsaWFkZVpxcEtod0xXNTAweE5XNDdVaUpQYk9H?=
 =?utf-8?B?RUhUbWY0R1A5L3p3bko2ZTRuaEI4YWhYc2RGUkQxbVFvSEFvWFViam4wR0ow?=
 =?utf-8?B?L3ZuOHlkYXlra0lIcTA0d1BQU1g2VTJnSTZscUNlZ0owa1JkSWZMalVldDZD?=
 =?utf-8?B?Z05CUmJtSWlXV0F2aDNOVzhnTDNpY2FlNk9SVGNhV2xIUkxDbTB6cGQ3TDhs?=
 =?utf-8?B?eTJjYVNGUW05Y0NsNHlxQVJ4Zi9jWDZIRzlZcXFGWnUzWTRoTk5QK24relBw?=
 =?utf-8?B?eUVSc0o2aU5GSTZVNHlXMEZhRjlBRnNqNytBanhKc3VZWHB0cEt4SWN4SlM4?=
 =?utf-8?B?L21ubE5TZXVYdzFDbEZmOTF3ZFc5aHRZRjUwWCtRU2dDRDIrdTMxRFBKcnd4?=
 =?utf-8?B?emRjQ0pnVWF6STc2czMxOEx6MmpJY3dWOUpLUy84VVEwVUc3MW9KU0JMRjg1?=
 =?utf-8?B?aFdPSXJ0WDJPSzFmakZ0SkNCeDI2SkFKS1pCdWZVaXZKQkNHWmg2dWdzMWpa?=
 =?utf-8?Q?PGn1MEaFSY6YblHOwOcH3HKegwU9kRsg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cff57a-37f1-4040-4af1-08da0967e3fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2022 05:18:24.0024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3RZljT7srNYgQGr+tnExdMMhdAe7ilo+P7HEl0OcHLflfhgOd4e43RPvYSzjzhYh4AC7ZZX8zUCiyAULF5F8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2917
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290
 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203190029
X-Proofpoint-GUID: wjAhHM2HO-NFtXEx9_oqErlJdFT8Jua3
X-Proofpoint-ORIG-GUID: wjAhHM2HO-NFtXEx9_oqErlJdFT8Jua3
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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



On 3/17/2022 7:27 PM, Jason Wang wrote:
> On Fri, Mar 18, 2022 at 8:59 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 3/16/2022 7:32 PM, Jason Wang wrote:
>>> On Thu, Mar 17, 2022 at 6:00 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 3/16/2022 12:10 AM, Eli Cohen wrote:
>>>>>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>> Sent: Wednesday, March 16, 2022 8:52 AM
>>>>>> To: Eli Cohen <elic@nvidia.com>
>>>>>> Cc: mst@redhat.com; jasowang@redhat.com; virtualization@lists.linux-foundation.org; eperezma@redhat.com; amorenoz@redhat.com;
>>>>>> lvivier@redhat.com; sgarzare@redhat.com; Parav Pandit <parav@nvidia.com>
>>>>>> Subject: Re: [PATCH v1 1/2] vdpa: Add support for querying vendor statistics
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 3/15/2022 2:10 AM, Eli Cohen wrote:
>>>>>>
>>>>>> <...snip...>
>>>>>>
>>>>>>>> Say you got a vdpa net device created with 4 data queue pairs and a
>>>>>>>> control vq. On boot some guest firmware may support just F_CTRL_VQ but
>>>>>>>> not F_MQ, then the index for the control vq in guest ends up with 2, as
>>>>>>>> in this case there's only a single queue pair enabled for rx (index 0)
>>>>>>>> and tx (index 1). From the host driver (e.g. mlx5_vdpa) perspective, the
>>>>>>>> control vq is the last vq following 8
>>>>>>> If the host sees F_MQ was not negotiated but F_CTRL_VQ was, then it knows
>>>>>>> that control VQ index is 2
>>>>>> Right, but I don't see this feature negotiation info getting returned
>>>>>> from your vdpa_dev_vendor_stats_fill(), or did I miss something? How do
>>>>>> you plan for host user to get this info? If you meant another "vdpa dev
>>>>>> show" command to query negotiated features ahead, this won't get the
>>>>>> same lock protected as the time you run the stat query. It's very easy
>>>>>> to miss that ephemeral queue index.
>>>>> Right, so I suggested to include the negotiated features in the netlink message
>>>>> for the statistics. That would save us from using two system calls to get the
>>>>> information required and it answers your concern with respect to locking.
>>>>> I think Jason was reluctant to adding this attribute to the message but can't
>>>>> find where he explained the reasoning.
>>>> Maybe Jason can clarify and correct me, but I just did not get the same
>>>> impression as what you said? I just skimmed through all of the emails in
>>>> the thread, only finding that he didn't want device specific attribute
>>>> such as queue type to get returned by the vdpa core, which I agree. I'm
>>>> not sure if he's explicitly against piggyback negotiated features to aid
>>>> userspace parsing the index.
>>> I think we need piggyback the negotiated features, otherwise as you
>>> mentioned, we will probably get in-consistency.
>> Great. Thanks for confirming it.
>>
>>> But a question for the "host queue index", as mentioned before. It's
>>> something that is not defined in the spec, so technically, vendor can
>>> do any mappings between it and the index what guest can see. I feel
>>> like we need to clarify it in the spec first.
>> I have been thinking about this for some while today. Actually I am not
>> against exposing the host queue index to the spec, as we know it's
>> somewhat implicitly defined in the QEMU device model for multiqueue. The
>> thing is, I'm not sure if there's extra benefit than this minor
>> requirement (*) given that all of the other vDPA kAPI are taking the
>> guest queue index rather than the host queue index.
> Rethink of this, consider currently we do this via vendor stats, so
> it's probably fine. Maybe we can have a better netlink API like
> "vendor_queue_index" etc then everything should be fine.
True. Or if there's netlink API that simply dumps the stats for all of 
the available queues in one shot, that would serve our cloud use case 
quite well. :)

>
>> It works for
>> mlx5_vdpa as the control vq is implemented in the software, so it can
>> map to whatever guest qindex it wishes to. But would it cause extra
>> trouble for some other emulated vDPA device or other vendor's vDPA such
>> as ifcvf to fabricate a fake mapping between the host queue index and
>> the one guest can see? I would have to send a heads-up ahead that the
>> current vhost-vdpa mq implementation in upstream QEMU has some issue in
>> mapping the host qindex to the guest one. This would become a problem
>> with MQ enabled vdpa device and a non-MQ supporting guest e.g. OVMF, for
>> which I'm about to share some RFC patches shortly to demonstrate the
>> issue.
> Sure.
Please see the RFC patch just sent with the subject "vhost_net: should 
not use max_queue_pairs for non-mq guest", option #3 is to leverage host 
queue index.

>
>> If exposing the host queue index to the spec turns is essential
>> to resolving this issue and maybe help with software virtio QEMU
>> implementation too, I won't hesitate to expose this important
>> implementation detail to the spec.
>>
>> (*) another means that may somehow address my use case is to use some
>> magic keyword e.g. "ctrlvq" to identify the control vq. Implementation
>> wise, we can extensively pass -1 to indicate the last guest qindex to
>> the get_vq_vstat() API given that we know for sure the ctrlvq is the
>> last queue in the array when the relevant features are present. Since
>> the negotiated features are piggybacked, it's not hard for the vdpa tool
>> to tell apart whether the last queue is a control vq or not.
> For virtqueue index (guest index) defined in the spec, I'd let
> userspace to deduce it.
OK, that'll be fine. Although I thought by extending 
get_vendor_vq_vstat() a bit, the virtqueue index is still guest based, 
from which the userspace can deduce control vq for its own.

> But for the host or vendor index, we probably can do this.
Does vendor index means it's optional and vendor specific, host index 
means it is mandated and universal to all vendors? I hope we can define 
some generic indexing scheme for virtio stats defined in the spec across 
all vendor's devices, while limiting vendor's flexibility to define its 
own index mapping to only those vendor stats.

> (Btw, I feel like we need to separate the features, if we agree to go
> with host/vendor index, we can let guest index part in first).
OK. Sounds like a plan. Thanks Jason.

Thanks,
-Siwei

>
> Thanks
>
>> I'd also welcome other ideas that can make virtqueue identification
>> easier and predictable from the CLI.
>>
>> Thanks,
>> -Siwei
>>
>>> Thanks
>>>
>>>> Another way around, vdpa tool may pass down -1 to get_vq_vstat() to
>>>> represent the queue index for the control queue - but that's less
>>>> favorable as the vdpa core needs to maintain device specific knowledge.
>>>>
>>>>
>>>>
>>>>>>>> data vqs of all 4 pairs, hence got
>>>>>>>> the 8th index in the rank. Since F_MQ is not negotiated and only 1 data
>>>>>>>> queue pair enabled, in such event only host qindex 0,1 and 8 have vendor
>>>>>>>> stats available, and the rest of qindex would get invalid/empty stat.
>>>>>>>>
>>>>>>>> Later on say boot continues towards loading the Linux virtio driver,
>>>>>>>> then guest could successfully negotiate both F_CTRL_VQ and F_MQ
>>>>>>>> features. In this case, all 8 data virtqueues are fully enabled, the
>>>>>>>> index for the control vq ends up as 8, following tightly after all the 4
>>>>>>>> data queue pairs. Only until both features are negotiated, the guest and
>>>>>>>> host are able to see consistent view in identifying the control vq.
>>>>>>>> Since F_MQ is negotiated, all host queues, indexed from 0 through 8,
>>>>>>>> should have vendor stats available.
>>>>>>>>
>>>>>>>> That's why I said the guest qindex is ephemeral and hard to predict
>>>>>>>> subjected to negotiated features, but host qindex is reliable and more
>>>>>>>> eligible for command line identification purpose.
>>>>>>>>
>>>>>> <...snip...>
>>>>>>>>> So what are you actually proposing? Display received and completed descriptors
>>>>>>>>> per queue index without further interpretation?
>>>>>>>> I'd suggest using a more stable queue id i.e. the host queue index to
>>>>>>>> represent the qidx (which seems to be what you're doing now?), and
>>>>>>>> displaying both the host qindex (queue_index_device in the example
>>>>>>>> below), as well as the guest's (queue_index_driver as below) in the output:
>>>>>>>>
>>>>>>> Given that per vdpa device you can display statistics only after features have
>>>>>>> been negotiated, you can always know the correct queue index for the control
>>>>>>> VQ.
>>>>>> The stats can be displayed only after features are negotiated, and only
>>>>>> when the corresponding queue is enabled. If you know it from "vdpa dev
>>>>>> show" on day 1 that the control vq and mq features are negotiated, but
>>>>>> then on day2 you got nothing for the predicted control vq index, what
>>>>>> would you recommend the host admin to do to get the right qindex again?
>>>>>> Re-run the stat query on the same queue index, or check the "vdpa dev
>>>>>> show" output again on day 3? This CLI design makes cloud administrator
>>>>>> really challenging to follow the dynamics of guest activities were to
>>>>>> manage hundreds or thousands of virtual machines...
>>>>>>
>>>>>> It would be easier, in my opinion, to grasp some well-defined handle
>>>>>> that is easily predictable or fixed across the board, for looking up the
>>>>>> control virtqueue. This could be a constant host queue index, or a
>>>>>> special magic keyword like "qidx ctrlvq". If cloud admin runs vstat
>>>>>> query on the control vq using a determined handle but get nothing back,
>>>>>> then s/he knows *for sure* the control vq was not available for some
>>>>>> reason at the point when the stat was being collected. S/he doesn't even
>>>>>> need to care negotiated status via "vdpa dev show" at all. Why bother?
>>>>> So, per my suggestion above, passing the negotiated attribute in the netlink
>>>>> message would satisfy the requirements for atomicity, right?
>>>> Yes, it satisfied the atomicity requirement, though not sure how you
>>>> want to represent the queue index for control vq? Basically if cloud
>>>> admin wants to dump control queue stats explicitly with a fixed handle
>>>> or identifier, how that can be done with the negotiated attribute?
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>>>> Do you still hold see your proposal required?
>>>>>> Yes, this is essential to any cloud admin that runs stat query on all of
>>>>>> the queues on periodic basis. You'd get some deterministic without
>>>>>> blindly guessing or bothering other irrelevant command.
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>>> $ vdpa -jp dev vstats show vdpa-a qidx 8
>>>>>>>> {
>>>>>>>>          "vstats": {
>>>>>>>>              "vdpa-a": {
>>>>>>>>                  "queue_stats": [{
>>>>>>>>                      "queue_index_device": 8,
>>>>>>>>                      "queue_index_driver": 2,
>>>>>>>>                      "queue_type": "control_vq",
>>>>>>>>                      "stat_name": [ "received_desc","completed_desc" ],
>>>>>>>>                      "stat_value": [ 417776,417775 ],
>>>>>>>>                  }]
>>>>>>>>              }
>>>>>>>>          }
>>>>>>>> }
>>>>>>>>
>>>>>>>> Optionally, user may use guest queue index gqidx, which is kind of an
>>>>>>>> ephemeral ID and F_MQ negotiation depended, to query the stat on a
>>>>>>>> specific guest queue:
>>>>>>>>
>>>>>>>> $ vdpa -jp dev vstats show vdpa-a gqidx 2
>>>>>>>> {
>>>>>>>>          "vstats": {
>>>>>>>>              "vdpa-a": {
>>>>>>>>                  "queue_stats": [{
>>>>>>>>                      "queue_index_device": 8,
>>>>>>>>                      "queue_index_driver": 2,
>>>>>>>>                      "queue_type": "control_vq",
>>>>>>>>                      "stat_name": [ "received_desc","completed_desc" ],
>>>>>>>>                      "stat_value": [ 417776,417775 ],
>>>>>>>>                  }]
>>>>>>>>              }
>>>>>>>>          }
>>>>>>>> }
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> -Siwei
>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> -Siwei
>>>>>>>>>>
>>>>>>>>>>>> Regards,
>>>>>>>>>>>> -Siwei
>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Looks to me there are still some loose end I don't quite yet
>>>>>>>>>>>>>>>> understand.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>                       "queue_index": 0,
>>>>>>>>>>>>>>> I think this can be removed since the command is for a specific index.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>                       "name": "received_desc",
>>>>>>>>>>>>>>>>>>>                       "value": 417776,
>>>>>>>>>>>>>>>>>>>                       "name": "completed_desc",
>>>>>>>>>>>>>>>>>>>                       "value": 417548
>>>>>>>>>>>>>>>>>> Not for this kernel patch, but IMHO it's the best to put the name
>>>>>>>>>>>>>>>>>> & value pairs in an array instead of flat entries in json's
>>>>>>>>>>>>>>>>>> hash/dictionary. The hash entries can be re-ordered deliberately
>>>>>>>>>>>>>>>>>> by external json parsing tool, ending up with inconsistent stat values.
>>>>>>>>>>>>>>>> This comment is missed for some reason. Please change the example
>>>>>>>>>>>>>>>> in the log if you agree to address it in vdpa tool. Or justify why
>>>>>>>>>>>>>>>> keeping the order for json hash/dictionary is fine.
>>>>>>>>>>>>>>> Sorry for skipping this comment.
>>>>>>>>>>>>>>> Do you mean to present the information like:
>>>>>>>>>>>>>>> "received_desc": 417776,
>>>>>>>>>>>>>>> "completed_desc": 417548,
>>>>>>>>>>>>>> I mean the following presentation:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> $ vdpa -jp dev vstats show vdpa-a qidx 0 {
>>>>>>>>>>>>>>             "vstats": {
>>>>>>>>>>>>>>                 "vdpa-a": {
>>>>>>>>>>>>>>                     "queue_stats": [{
>>>>>>>>>>>>>>                         "queue_index": 0,
>>>>>>>>>>>>>>                         "queue_type": "rx",
>>>>>>>>>>>>>>                         "stat_name": [ "received_desc","completed_desc" ],
>>>>>>>>>>>>>>                         "stat_value": [ 417776,417548 ],
>>>>>>>>>>>>>>                     }]
>>>>>>>>>>>>>>                 }
>>>>>>>>>>>>>>             }
>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I think Parav had similar suggestion, too.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>> -Siwei
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>> -Siwei
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>> -Siwei
>>>>>>>>>>>>>>>>>>>                   }
>>>>>>>>>>>>>>>>>>>               }
>>>>>>>>>>>>>>>>>>> }
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>            drivers/vdpa/vdpa.c       | 129
>>>>>>>>>>>>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>>>>>>>            include/linux/vdpa.h      |   5 ++
>>>>>>>>>>>>>>>>>>>            include/uapi/linux/vdpa.h |   7 +++
>>>>>>>>>>>>>>>>>>>            3 files changed, 141 insertions(+)
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>>>>>>>>>>>>>>>>>> 9846c9de4bfa..d0ff671baf88 100644
>>>>>>>>>>>>>>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>>>>>>>>>>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>>>>>>>>>>>>>>> @@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device
>>>>>>>>>>>>>>>>>>> *vdev,
>>>>>>>>>>>>>>>> struct sk_buff *msg, u32 portid,
>>>>>>>>>>>>>>>>>>>                   return err;
>>>>>>>>>>>>>>>>>>>            }
>>>>>>>>>>>>>>>>>>> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct
>>>>>>>>>>>>>>>>>>> +sk_buff
>>>>>>>>>>>>>>>> *msg,
>>>>>>>>>>>>>>>>>>> +                              struct genl_info *info, u32 index) {
>>>>>>>>>>>>>>>>>>> +       int err;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
>>>>>>>>>>>>>>>>>>> +               return -EMSGSIZE;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       err = vdev->config->get_vendor_vq_stats(vdev, index, msg,
>>>>>>>>>>>>>>>>>>> +info-
>>>>>>>>>>>>>>>>> extack);
>>>>>>>>>>>>>>>>>>> +       if (err)
>>>>>>>>>>>>>>>>>>> +               return err;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       return 0;
>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +static int vendor_stats_fill(struct vdpa_device *vdev, struct
>>>>>>>>>>>>>>>>>>> +sk_buff
>>>>>>>>>>>>>> *msg,
>>>>>>>>>>>>>>>>>>> +                            struct genl_info *info, u32 index) {
>>>>>>>>>>>>>>>>>>> +       int err;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       if (!vdev->config->get_vendor_vq_stats)
>>>>>>>>>>>>>>>>>>> +               return -EOPNOTSUPP;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       err = vdpa_fill_stats_rec(vdev, msg, info, index);
>>>>>>>>>>>>>>>>>>> +       if (err)
>>>>>>>>>>>>>>>>>>> +               return err;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       return 0;
>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
>>>>>>>>>>>>>>>>>>> +                                     struct sk_buff *msg,
>>>>>>>>>>>>>>>>>>> +                                     struct genl_info *info, u32 index) {
>>>>>>>>>>>>>>>>>>> +       u32 device_id;
>>>>>>>>>>>>>>>>>>> +       void *hdr;
>>>>>>>>>>>>>>>>>>> +       int err;
>>>>>>>>>>>>>>>>>>> +       u32 portid = info->snd_portid;
>>>>>>>>>>>>>>>>>>> +       u32 seq = info->snd_seq;
>>>>>>>>>>>>>>>>>>> +       u32 flags = 0;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>>>>>>>>>>>>>>>>> +                         VDPA_CMD_DEV_VSTATS_GET);
>>>>>>>>>>>>>>>>>>> +       if (!hdr)
>>>>>>>>>>>>>>>>>>> +               return -EMSGSIZE;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME,
>>>>>>>>>>>> dev_name(&vdev-
>>>>>>>>>>>>>>>>> dev))) {
>>>>>>>>>>>>>>>>>>> +               err = -EMSGSIZE;
>>>>>>>>>>>>>>>>>>> +               goto undo_msg;
>>>>>>>>>>>>>>>>>>> +       }
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       device_id = vdev->config->get_device_id(vdev);
>>>>>>>>>>>>>>>>>>> +       if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
>>>>>>>>>>>>>>>>>>> +               err = -EMSGSIZE;
>>>>>>>>>>>>>>>>>>> +               goto undo_msg;
>>>>>>>>>>>>>>>>>>> +       }
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       err = vendor_stats_fill(vdev, msg, info, index);
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       genlmsg_end(msg, hdr);
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       return err;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +undo_msg:
>>>>>>>>>>>>>>>>>>> +       genlmsg_cancel(msg, hdr);
>>>>>>>>>>>>>>>>>>> +       return err;
>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>            static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff
>>>>>>>>>>>>>>>>>>> *skb, struct
>>>>>>>>>>>>>>>> genl_info *info)
>>>>>>>>>>>>>>>>>>>            {
>>>>>>>>>>>>>>>>>>>                   struct vdpa_device *vdev;
>>>>>>>>>>>>>>>>>>> @@ -990,6 +1058,60 @@
>>>>>>>>>>>> vdpa_nl_cmd_dev_config_get_dumpit(struct
>>>>>>>>>>>>>>>> sk_buff *msg, struct netlink_callback *
>>>>>>>>>>>>>>>>>>>                   return msg->len;
>>>>>>>>>>>>>>>>>>>            }
>>>>>>>>>>>>>>>>>>> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
>>>>>>>>>>>>>>>>>>> +                                         struct genl_info *info)
>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>> +       struct vdpa_device *vdev;
>>>>>>>>>>>>>>>>>>> +       struct sk_buff *msg;
>>>>>>>>>>>>>>>>>>> +       const char *devname;
>>>>>>>>>>>>>>>>>>> +       struct device *dev;
>>>>>>>>>>>>>>>>>>> +       u32 index;
>>>>>>>>>>>>>>>>>>> +       int err;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>>>>>>>>>>>>>>>>>> +               return -EINVAL;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
>>>>>>>>>>>>>>>>>>> +               return -EINVAL;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>>>>>>>>>>>>>>>>>>> +       msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>>>>>>>>>>>>>>>>>>> +       if (!msg)
>>>>>>>>>>>>>>>>>>> +               return -ENOMEM;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       index = nla_get_u32(info-
>>>>>>>>>>>>> attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
>>>>>>>>>>>>>>>>>>> +       mutex_lock(&vdpa_dev_mutex);
>>>>>>>>>>>>>>>>>>> +       dev = bus_find_device(&vdpa_bus, NULL, devname,
>>>>>>>>>>>>>>>> vdpa_name_match);
>>>>>>>>>>>>>>>>>>> +       if (!dev) {
>>>>>>>>>>>>>>>>>>> +               NL_SET_ERR_MSG_MOD(info->extack, "device not
>>>>>>>>>>>> found");
>>>>>>>>>>>>>>>>>>> +               err = -ENODEV;
>>>>>>>>>>>>>>>>>>> +               goto dev_err;
>>>>>>>>>>>>>>>>>>> +       }
>>>>>>>>>>>>>>>>>>> +       vdev = container_of(dev, struct vdpa_device, dev);
>>>>>>>>>>>>>>>>>>> +       if (!vdev->mdev) {
>>>>>>>>>>>>>>>>>>> +               NL_SET_ERR_MSG_MOD(info->extack, "unmanaged
>>>>>>>>>>>> vdpa
>>>>>>>>>>>>>>>> device");
>>>>>>>>>>>>>>>>>>> +               err = -EINVAL;
>>>>>>>>>>>>>>>>>>> +               goto mdev_err;
>>>>>>>>>>>>>>>>>>> +       }
>>>>>>>>>>>>>>>>>>> +       err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
>>>>>>>>>>>>>>>>>>> +       if (!err)
>>>>>>>>>>>>>>>>>>> +               err = genlmsg_reply(msg, info);
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       put_device(dev);
>>>>>>>>>>>>>>>>>>> +       mutex_unlock(&vdpa_dev_mutex);
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       if (err)
>>>>>>>>>>>>>>>>>>> +               nlmsg_free(msg);
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       return err;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +mdev_err:
>>>>>>>>>>>>>>>>>>> +       put_device(dev);
>>>>>>>>>>>>>>>>>>> +dev_err:
>>>>>>>>>>>>>>>>>>> +       mutex_unlock(&vdpa_dev_mutex);
>>>>>>>>>>>>>>>>>>> +       return err;
>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>            static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1]
>>>>>>>>>>>> = {
>>>>>>>>>>>>>>>>>>>                   [VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type =
>>>>>>>>>>>>>> NLA_NUL_STRING },
>>>>>>>>>>>>>>>>>>>                   [VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING
>>>>>>>>>>>>>> }, @@ -
>>>>>>>>>>>>>>>> 997,6
>>>>>>>>>>>>>>>>>>> +1119,7 @@ static const struct nla_policy
>>>>>>>>>>>>>>>> vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>>>>>>>>>>>>>>>>>>>                   [VDPA_ATTR_DEV_NET_CFG_MACADDR] =
>>>>>>>>>>>>>> NLA_POLICY_ETH_ADDR,
>>>>>>>>>>>>>>>>>>>                   /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>>>>>>>>>>>>>>>>>>>                   [VDPA_ATTR_DEV_NET_CFG_MTU] =
>>>>>>>>>>>>>> NLA_POLICY_MIN(NLA_U16, 68),
>>>>>>>>>>>>>>>>>>> +       [VDPA_ATTR_DEV_QUEUE_INDEX] =
>>>>>>>>>>>> NLA_POLICY_RANGE(NLA_U32, 0,
>>>>>>>>>>>>>>>> 65535),
>>>>>>>>>>>>>>>>>>>            };
>>>>>>>>>>>>>>>>>>>            static const struct genl_ops vdpa_nl_ops[] = { @@ -1030,6
>>>>>>>>>>>>>>>>>>> +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>>>>>>>>>>>>>>>>>>>                           .doit = vdpa_nl_cmd_dev_config_get_doit,
>>>>>>>>>>>>>>>>>>>                           .dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>>>>>>>>>>>>>>>>>>>                   },
>>>>>>>>>>>>>>>>>>> +       {
>>>>>>>>>>>>>>>>>>> +               .cmd = VDPA_CMD_DEV_VSTATS_GET,
>>>>>>>>>>>>>>>>>>> +               .validate = GENL_DONT_VALIDATE_STRICT |
>>>>>>>>>>>>>>>> GENL_DONT_VALIDATE_DUMP,
>>>>>>>>>>>>>>>>>>> +               .doit = vdpa_nl_cmd_dev_stats_get_doit,
>>>>>>>>>>>>>>>>>>> +               .flags = GENL_ADMIN_PERM,
>>>>>>>>>>>>>>>>>>> +       },
>>>>>>>>>>>>>>>>>>>            };
>>>>>>>>>>>>>>>>>>>            static struct genl_family vdpa_nl_family __ro_after_init =
>>>>>>>>>>>>>>>>>>> { diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
>>>>>>>>>>>>>>>>>>> 2de442ececae..274203845cfc 100644
>>>>>>>>>>>>>>>>>>> --- a/include/linux/vdpa.h
>>>>>>>>>>>>>>>>>>> +++ b/include/linux/vdpa.h
>>>>>>>>>>>>>>>>>>> @@ -275,6 +275,9 @@ struct vdpa_config_ops {
>>>>>>>>>>>>>>>>>>>                                       const struct vdpa_vq_state *state);
>>>>>>>>>>>>>>>>>>>                   int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>>>>>>>>>>>>>>>>>>>                                       struct vdpa_vq_state *state);
>>>>>>>>>>>>>>>>>>> +       int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
>>>>>>>>>>>>>>>>>>> +                                  struct sk_buff *msg,
>>>>>>>>>>>>>>>>>>> +                                  struct netlink_ext_ack *extack);
>>>>>>>>>>>>>>>>>>>                   struct vdpa_notification_area
>>>>>>>>>>>>>>>>>>>                   (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>>>>>>>>>>>>>>>>>>>                   /* vq irq is not expected to be changed once DRIVER_OK is
>>>>>>>>>>>>>>>>>>> set */ @@ -466,4 +469,6 @@ struct vdpa_mgmt_dev {
>>>>>>>>>>>>>>>>>>>            int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>>>>>>>>>>>>>>>>>>>            void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>>>>>>>>>>>>>>>>>>> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>            #endif /* _LINUX_VDPA_H */
>>>>>>>>>>>>>>>>>>> diff --git a/include/uapi/linux/vdpa.h
>>>>>>>>>>>>>>>>>>> b/include/uapi/linux/vdpa.h index 1061d8d2d09d..c5f229a41dc2
>>>>>>>>>>>>>>>>>>> 100644
>>>>>>>>>>>>>>>>>>> --- a/include/uapi/linux/vdpa.h
>>>>>>>>>>>>>>>>>>> +++ b/include/uapi/linux/vdpa.h
>>>>>>>>>>>>>>>>>>> @@ -18,6 +18,7 @@ enum vdpa_command {
>>>>>>>>>>>>>>>>>>>                   VDPA_CMD_DEV_DEL,
>>>>>>>>>>>>>>>>>>>                   VDPA_CMD_DEV_GET,               /* can dump */
>>>>>>>>>>>>>>>>>>>                   VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
>>>>>>>>>>>>>>>>>>> +       VDPA_CMD_DEV_VSTATS_GET,
>>>>>>>>>>>>>>>>>>>            };
>>>>>>>>>>>>>>>>>>>            enum vdpa_attr {
>>>>>>>>>>>>>>>>>>> @@ -46,6 +47,12 @@ enum vdpa_attr {
>>>>>>>>>>>>>>>>>>>                   VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>>>>>>>>>>>>>>>>>>>                   VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /*
>>>>>>>>>>>>>> u32 */
>>>>>>>>>>>>>>>>>>>                   VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
>>>>>>>>>>>>>>>>>>> +       VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
>>>>>>>>>>>>>>>>>>> +       VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /*
>>>>>>>>>>>> string */
>>>>>>>>>>>>>>>>>>> +       VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>                   /* new attributes must be added above here */
>>>>>>>>>>>>>>>>>>>                   VDPA_ATTR_MAX,
>>>>>>>>>>>>>>>>>>>            };

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

