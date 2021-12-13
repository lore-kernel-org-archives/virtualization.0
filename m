Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40F7C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 23:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A65E401C1;
	Mon, 13 Dec 2021 23:49:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6J2Vlax2ebPg; Mon, 13 Dec 2021 23:49:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2DFE401BF;
	Mon, 13 Dec 2021 23:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83DC0C001E;
	Mon, 13 Dec 2021 23:49:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6763C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFFF6403A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="aJv604WI";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="VXo7YX1q"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8MMBfaWUOri
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:49:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46EF54013D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:49:28 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDLIK64005529; 
 Mon, 13 Dec 2021 23:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lYgarocRLlj5KK9+lNxyAEDj+TS6SmRlmedj1A58hqw=;
 b=aJv604WIyOZrdy4kbg4l2Ml4ZCzfBq4g12D4BERzOmLdWGuC6ePY0whnGF/jPRE31Dax
 1M3WORslyNLo1dT6YQC0QPzVD++6R7NvQtAOMsY2Nyg+mJlhMdOGJdBWj+SaMGXBHC6c
 ECS8hij4G9bWCnIVmVOkPORtTEtf/Q0Q9lJGjrQ6qZQKn6VzTReH8f/mNrmuEoiuq5pC
 wRTyK/EA+pRUMh+ZtyaBaJoika6y5VZCuqTp00rBfFi+1P7eZk4hIHBnVfhZcNC7sAmS
 /4e+aEzlT6vi47o69zEr57KB50EaBEn8mOR+dJFd603mVWkp4ODlrN3+HM1alwTpwzTa aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u1ybg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 23:49:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDNkR1q096672;
 Mon, 13 Dec 2021 23:49:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
 by aserp3020.oracle.com with ESMTP id 3cvkt3q6m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 23:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dShd6+I60Snii/+o88xvwwVpK0/ZaCGGtSrDA8JyGZnyyG+auwgzrWosqkXMh1NW+thldwbjpYjrngg71rZKrOl3jNup9iQBqYjr1kJvZXMVaXQkRigw80amDtuE5M7njh1SB7L6oDsG2l1nLM5EJi8Gf1avVqihRxH2dFG/zKf4OJpxon6tSXe8ApKCiFL4W0fXAxGGZ+XkfxqdsppAhIc+tjifIF8IxY9tdzCqXjSta748hKmQE5CCDcAGLwHHC8K2JKOQi7wNxuBMN4xcB5qvzw0VP1NOFjSQ/DFXoejdoIMV5EHOIYCNlGTqBeJY47hLOQvSFPLNkx7Y50xSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYgarocRLlj5KK9+lNxyAEDj+TS6SmRlmedj1A58hqw=;
 b=LFNA0tys8XdqkIaEIbse6XLzPZflPPrN27lDI6ARXHhibcU4btlTzSlLR1NI69evkEPUiNIUPKWXGAwn1IJz/mqswpu05SZc/PocJx03Jy0N+Fi8HxMMOdj6UT7L4xLV7x1fWP+4vjsU44Xn3dH7lTVGJgc/IH1FswKhBtRxbUqHTGQkNSdnV1VEl5v9wUXMJC7UOzO2j6XYFAhluK6/If5PtEJzt3v3A2Bbw8xPXeUIIGLC4/6RpFwY0rRQ0SSdx7cXncUCGGHRifWj2maWzkPtO5MyKW4yoewAGorNCbq0xQifGaKMn5tbyEf8+UxZ+zwziw5GF+Mf9XOULO2G2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYgarocRLlj5KK9+lNxyAEDj+TS6SmRlmedj1A58hqw=;
 b=VXo7YX1q3q4+4wrRw4qXUNcUf/a5XSl1AJY0pcwQcoCPqg6WaiLzfizmmZ3eHcIigXESc51raE3p1NvsEzZg/vn6Et04j3A8FwhlIhWolslRJRmvQ1FbaakcTL9+lTZBBD+mzSdR6N6YIOUQXQRl2rHfSNPRtROzGNwnq8xN3L4=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 23:49:24 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 23:49:23 +0000
Message-ID: <b74e89ae-ce6c-fdf8-768e-00b4e3776f2b@oracle.com>
Date: Mon, 13 Dec 2021 15:49:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 07/10] vdpa: Add support for returning device
 configuration information
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-8-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211213144258.179984-8-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 055c7137-2885-4bd9-0900-08d9be9330a7
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5615:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5615E78BB962085072ADEE23B1749@SJ0PR10MB5615.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtH59NTyuaujozBF6yEvX9fGTxgNb1oCNMHMoSCs4H4L8VuRP7ExdGDphUA/5gIxzIx8FGSGXv2t+BlCZd/JfuqpfxoNnLc8sQWUgPWaGp4hnfqvWP/reYgSXg1FqVJ4I03pBfRh3zUfdzm4C3oHxiYZL4xVTq5E/awKU7wiaVrBGZQAB31VY31XxCnAz3udg9J4yBKcH31DCGVQXJCkE/CG8r7fkkItPc4wN31cPxOVPgCFeEsqZ6YAyE3YTnyEaRJgKPF9KgFRF/1i2u2AriHBDb93rZk9LHHXWKelj0pieRwqPTQqtRntxUPEMcnWecXzM6NnhaA81xS+WX00KFWeiB807Y5GutQDM2jqvqQ+yXt0agKnaOhlW7u5grRQri8wc3LbOpuLgvsyiaKAx5IR1wpgYIlLM0CCdLdEQGYkFvcdSIDGAibdxRB8Pqd/8vNk2lF+3xcmsn45u7VhV/jIbXudbjlOB/w1VQPWIj7w5McAoqubxU6tgVKQmTSMbewRlCoBDjQZge8BBk6SECwOOQCtAWJg/yzEyZISgqWSuoOpDhJm1wLkPzmedl2Bxemf4Gm3h6vcHqoKa7eRu1XSGBjTPPwHLyZ47jySUxKOowQ8ryWpBW40CVofbI24cW/NMr5UmmjGa8ebLG6ayErriWoKYh6CBo59a6yTAi/AMpodbZQ8+jgc2r6jp9FGmAqwJSeWMev3XaQtK6imCpTRHNjAUoFzXKG/hM1umQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(2906002)(5660300002)(66556008)(31696002)(66476007)(2616005)(186003)(6512007)(86362001)(66946007)(31686004)(6486002)(508600001)(36756003)(6666004)(6506007)(316002)(4326008)(8676002)(53546011)(38100700002)(8936002)(36916002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWQrY3BFZlcxWENaUmtORUhMTm5lRnhha2tvOEJ5aEV1TTROZEZzeUtrU29P?=
 =?utf-8?B?ejd3NzFsU0FJWmtRTnpPYWV1djlmSzQ0MyswWHRreGpkUE1udjZhc2FyY04r?=
 =?utf-8?B?YXJnT3JwY3M2TVp2aXgwQWdNd2JScW9HdFZoUWZ0dlBiK1VTZmZudXlOUWpT?=
 =?utf-8?B?RmVSdDVBeWhSLzZlQVhnaUdXMi9EWFliZithczhlSG54M2NOdUZKd3Yrdm9l?=
 =?utf-8?B?Qm9BR2VuVFBOcEVBZ0hyM1RReHdsdWlCT2lrQTZBWEdtVlptYndYMG9lWm9E?=
 =?utf-8?B?U0FobTJLM28ydmk1SXl5YS81SXhuRmlCelJkaUxndmk0aloyVGZJRHJ0NmUr?=
 =?utf-8?B?bE1UQkplRXVUekg3UlpHYkJEL0x4d0Fwck1ldnlINXRqYnFmV3hHeHN0WnhG?=
 =?utf-8?B?RXFmWWRFMlV2NFlMbDJ4L2g0Nms5c2NaSExLQ29iYWprVjhKY2xpTEpVSVEx?=
 =?utf-8?B?UHhUQ0g2Qm5EWEhpT2Q3ZEFjUGNrbWxXRmJRMlBWb01FUGkzcXF4N08vbE4x?=
 =?utf-8?B?RWlOS295TkFSWlN3KzcwZGVBWjJuM0lBbHV4QVdEeWtyQ1ZyODBoMzUrTEli?=
 =?utf-8?B?Sk5BOHppd1hHdGpLZ3JPa0NNMk1qSHVUWW5Ca0xnaVB1SE8vbmxpcTN2RTNL?=
 =?utf-8?B?YUdJRmdQdXZhSXE3V0pXZmg3VU9yTFRPZFliUUd0cjltMjVlZlBxTU03Rzdo?=
 =?utf-8?B?RnBoU2dqV2N4dkF3ekgxbXpYQ1AvOE9ObHdad0gvRVJRakVHNks2ajlwa2Fk?=
 =?utf-8?B?Z2tkUnVmUTNSWmFueHRIUUZBdVlwZU1vZjBsdVp6d2JkYXE5SVA5RlJOVmVL?=
 =?utf-8?B?eTFLdVEzZENlYkx2UmhXbGZJSDU0WjY4NlcyZ1ZPNGlXTTJQZElhMVVLZFBm?=
 =?utf-8?B?WXJPUDk2V2hkRDdsMWlxaWhkTWdVZkE3TzZQUlhxMjFIWjhjb3E3NGlSWjNn?=
 =?utf-8?B?K0d4UjFUWUFQMXVDSUlmcU5zTURybnZCT1JuVEx3em9QVGpiVGt1VDdMN1FV?=
 =?utf-8?B?K0RSd25MVTZPb2JKRFg0QmxzMnJ0UFJ2SVBUSnBzTzdvbG9Eamo5eVpNcVIz?=
 =?utf-8?B?am11bk9ucnpKZW8veUJRS2pudjVQc2NGR2hoTXlpc3RoMUljZzlFMGo0NDJy?=
 =?utf-8?B?MkUwMGxXMWVFcHBWSzJDemNLWVV3bFhXQ3pGS0pGUHVBUzB5ZXYxbklPdXVt?=
 =?utf-8?B?UFQydjVxU2hLT1V2a1RBNHVTaGhrMVIxbnVOTUhxVzZOcWxqZXRrNVZMVHNO?=
 =?utf-8?B?eS9tNlRWdElZS2psYVc5MXd4Z3N6WkhCNkUvU25ibUkrRTlNSE1QUGpoL0Nj?=
 =?utf-8?B?UHJnT3lFdC9PR2dPYXZIQkZiNzBBUmliemZMTkxhazJoc01Lb2hnNjA3YlVH?=
 =?utf-8?B?c0FIZHdYNG1jaEEzeUlxdzJWaUJUUFgxNjdZVUhWemNVdWNiZnZjTW05YlJy?=
 =?utf-8?B?eEhhVXZQVFgrMlpiVVNVclFISE10N3Q0YitqM2cweTBMcjFOdVN2UEoyQmZP?=
 =?utf-8?B?SlBPaUlud1ppWHIwa1lMdWxLUlJjT0dpTjl6bG8rZUF0T1V0UDRsRnBSVGtY?=
 =?utf-8?B?akczSytYd1ZkL3A1UFJvVUF2NU12RTIvbDluMjNPK2pSUWZyZ0RxTHJYTWda?=
 =?utf-8?B?amltWlArWXdkODBOZDRBSGIydVkwcERraXViYThMN28wWkRyNG05empUMjFm?=
 =?utf-8?B?ZngremNWZnJ6NXBVdGUwR3NpTDU0dGdWV0dKdnBCMTRsT2gxSkdpdEFRWDFa?=
 =?utf-8?B?NTkxam5ZR1hUaDM0RFhXWUM0SFFjTExIb1NaSkdnVmR4djUydlF1cFdSQktj?=
 =?utf-8?B?VkQvcW1tTCtuNHcvblhHL1VuNFBYMjMxTHlYekI4cElrY0ptT0NoTlBVQ2N5?=
 =?utf-8?B?cTl3WGJzZkd4dzl5bTcydzJhRVJCRzdUbzQyTDZROXlCNG1ZT3EwODJCU1hm?=
 =?utf-8?B?K3ZKSmY5cXFpVUovYVdWaG5vUzdPUHN3Wk9qdHFXaGV6TUtaK0NWcWpCcFJ3?=
 =?utf-8?B?ZitXWjlpUGx6NXMxaEFQOFY2YjNYVFN6aUlFMitzLzFzU21jeWtxY20wNVdH?=
 =?utf-8?B?MWhqRXp1Vmx5T3BvYkYyTE5Jd3lFV0ZjRFlPRitaVEsvL3h0cmNBMFg1dlF1?=
 =?utf-8?B?R3ByV3lCMmtINHBhS3AvUXA4QmRNTExiQVI1WkxFSkgrK1pqK3B1U2hxeVFN?=
 =?utf-8?Q?6/HsGrvf46IEMabIRHVbwb8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055c7137-2885-4bd9-0900-08d9be9330a7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 23:49:23.8640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c1aGm0/3ftXedALL6PEmpPs8M+Z4J23mVCFPaMIa+KSoedINSsYD0aGmO5THNVrv8q/7rIw3aKGN2hZOkFWVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130139
X-Proofpoint-ORIG-GUID: 0wLkn6KclGDTYKUkfaKSJ-4PXGWphXLv
X-Proofpoint-GUID: 0wLkn6KclGDTYKUkfaKSJ-4PXGWphXLv
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



On 12/13/2021 6:42 AM, Eli Cohen wrote:
> Add netlink attribute to store flags indicating current state of the
> device.
> In addition, introduce a flag to indicate whether control virtqueue is
> used.
>
> This indication can be retrieved by:
>
> vdpa dev config show vdpa-a
> vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs 1
> 	mtu 1500 ctrl_vq yes
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
>
> ----
> V1 -> V2
> Patch was changed to return only an indication of ctrl VQ
> ---
>   drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
>   include/uapi/linux/vdpa.h |  8 ++++++++
>   2 files changed, 25 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7b7bef7673b4..130a8d4aeaed 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -787,6 +787,19 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>   	return msg->len;
>   }
>   
> +static int vdpa_dev_net_ctrl_vq_fill(struct vdpa_device *vdev,
> +				     struct sk_buff *msg,
> +				     struct virtio_net_config *config,
> +				     u64 features)
> +{
> +	if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +		return 0;
> +
> +	/* currently the only flag can be returned */
> +	return nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FLAGS,
> +				 BIT_ULL(VDPA_DEV_ATTR_CVQ), VDPA_ATTR_PAD);
> +}
> +
>   static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>   				       struct sk_buff *msg, u64 features,
>   				       const struct virtio_net_config *config)
> @@ -805,6 +818,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>   	struct virtio_net_config config = {};
>   	u64 features;
>   	u16 val_u16;
> +	int err;
>   
>   	vdpa_get_config(vdev, 0, &config, sizeof(config));
>   
> @@ -821,6 +835,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>   		return -EMSGSIZE;
>   
>   	features = vdev->config->get_driver_features(vdev);
> +	err = vdpa_dev_net_ctrl_vq_fill(vdev, msg, &config, features);
> +	if (err)
> +		return err;
>   
>   	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>   }
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index a252f06f9dfd..23b854e3e5e2 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -20,9 +20,16 @@ enum vdpa_command {
>   	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
>   };
>   
> +enum {
> +	VDPA_DEV_ATTR_CVQ,
> +};
> +
>   enum vdpa_attr {
>   	VDPA_ATTR_UNSPEC,
>   
> +	/* Pad attribute for 64b alignment */
> +	VDPA_ATTR_PAD = VDPA_ATTR_UNSPEC,
> +
>   	/* bus name (optional) + dev name together make the parent device handle */
>   	VDPA_ATTR_MGMTDEV_BUS_NAME,		/* string */
>   	VDPA_ATTR_MGMTDEV_DEV_NAME,		/* string */
> @@ -34,6 +41,7 @@ enum vdpa_attr {
>   	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
>   	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
>   	VDPA_ATTR_DEV_MIN_VQ_SIZE,		/* u16 */
> +	VDPA_ATTR_DEV_FLAGS,			/* u64 */
Adding new attr here would break existing userspace that is compiled 
with the older value. Need to append to the end.

-Siwei
>   
>   	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
>   	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
