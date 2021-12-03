Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D72BC433F5
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 07:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F7BB40433;
	Fri,  3 Dec 2021 07:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFCHV-XulqAf; Fri,  3 Dec 2021 07:40:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E39EF401F8;
	Fri,  3 Dec 2021 07:40:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93932C001C;
	Fri,  3 Dec 2021 07:40:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E27FC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:40:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48D67401F8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nBDqrvTUa1wG
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:40:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FD994043C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 07:40:14 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B37K0s8032271; 
 Fri, 3 Dec 2021 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wEf2k8aKJVSWGio34gxpEXXWqVJqHVPZNs8AVX6YT7c=;
 b=xNlFVp73o8SVmbo0qduS9aKosTtPU05vnF+am4eHS5F+G9aya7fTGWf/xu/R/8Ydvpq2
 aaz8pKpYQXf5k/uG3SJAg7SJugoGh+Boq/2bZkWJ+V6ijNXCKErbvs/2IWIu5MA2nNLL
 +UyYHlisBtTpNNAJ12qDJep0Af18BpvDcNJItWZh7wbMcwgkQrFTAJlVkozfE88Y/A4o
 wKYO7ZwgzbiqWjkXWFLBSiW2IsixW2hPD4SFHjpZ0o5CJ3qgRYcMoOf4gnBeZu5jhyY9
 /OAZ8PB/owoFdRoJ19FHSoQZF5anzMXgcYOVLfxw4diJt1OlVUYR3J9D2+IWo2kv8eQ0 kQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cp7wex9vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Dec 2021 07:40:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B37VlWa095834;
 Fri, 3 Dec 2021 07:40:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by aserp3030.oracle.com with ESMTP id 3ckaqkw77u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Dec 2021 07:40:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1kxJ85JHTHqATsqSh+hhKz46weAVj7a7/+N7YFo3GT/YPJkGkL6B+PggDHSCLw9q58H6DtAKYeNgmq97gK9AE/vn/B7cLiXhF1k+ROSX22gAiGC3JYVJUQJQ4F14hHa/97wDwkC5hSSUF9iq6cpPT/KRkq+tismiVV35P/YUNE7EEXJ3rvrVaoJAL2zGDUUBTD7aAVgGnK7q8YWbNjWnDpgW5cwqR0TfVslF6Dxpw96GwQ2oQcvOk9qSXQFoSClredOxeBNR9LOFSDCDNuRk9d4drHUupKO7vDRuGYT+5RaWHkeeAgXglxwjGUkP18LUHO0MC0qT+xBMh1hEXdRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEf2k8aKJVSWGio34gxpEXXWqVJqHVPZNs8AVX6YT7c=;
 b=a8eD1Cos8TuHepkh3e10o1EbJ5Nw5ORTIsikEDpkVqmn9+qzNRSQ3EB17lf2HHJFu1/dCWd+mMK1wRcATBMk2YpEOEPCNU9BOP0hcUyVKBJEw1hxUpdcoS2+HTCCLkYkN03R0E9uwm3Xi+4i/KgzGQm6WZsdGFz0Oxgf3B8WX8thZ/yHCY4jegAP5swnzwMikqSoHSHofX0hsfrYQLg/0KevdUM/niRuwarpVLnM+QlboQlHoYkJL9cRgi34RHdNDln8/vFf82Tljb8QWFn24jGBj2/PpN+2ubzu9a/+4XdQu3qk3+NWatWLRvC+hnemzlN47W+FV1Kv6h5+ksgzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEf2k8aKJVSWGio34gxpEXXWqVJqHVPZNs8AVX6YT7c=;
 b=ETX1c4ezDfG2++3eXnCJVDRapSiDxaR/rxR9wrkO7f3x9syPh4CTv0QAekXUuH1ggAnsW7NhTX7RNU8u+EcU2hKM4UGTCiqm+O9gUIXUYhlrZjbQOrlIJW+ix+bwzD3AUWpJl+XR2gVHth1ErOsmJJeUHfSvLxe++/deJqgztVA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4430.namprd10.prod.outlook.com (2603:10b6:a03:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 3 Dec
 2021 07:40:09 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::89e7:42b2:b226:2182%7]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 07:40:09 +0000
Message-ID: <8a2d8129-19bd-956b-d1a7-05c1054b3554@oracle.com>
Date: Thu, 2 Dec 2021 23:40:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] vdpa/mlx5: Support configuring max data virtqueue
 pairs
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-4-elic@nvidia.com>
 <0e6de504-38e8-a1a9-5dc9-00c52571b21b@oracle.com>
 <PH0PR12MB54813FD2D0C389E1A7F0B31FDC6A9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB54813FD2D0C389E1A7F0B31FDC6A9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: SN4PR0201CA0040.namprd02.prod.outlook.com
 (2603:10b6:803:2e::26) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
Received: from [10.159.148.88] (138.3.200.24) by
 SN4PR0201CA0040.namprd02.prod.outlook.com (2603:10b6:803:2e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 07:40:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48736dbc-cc3a-4c56-eb60-08d9b6302229
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4430:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44301AF856375578D9834FF4B16A9@SJ0PR10MB4430.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1ehxhkKZmSk4nVJnWMLM0Ms2UPfWdyvQiXtYHbHU9v+AJnX/ztcb5HcW0laikSOPOPFvehnYEyFOWieD8OWHW8JoXXQcuj4Ivkap2Bef342P04p8dZlkQZ0Ab3kVA6KRGn/gzSpiedjEGqQdAXSCs8pZy8upk06IBPQVz7N/w+HVIDNv96ZsHjXxaJBTjGyZ5qGkMZZ3oVlnI+Q1rJQdq+1xFHq0VBaDDsmq3jCuPXYY5nbCovCJn5ycF4Vjy5vIrnn8D0+taf1pbfmX+e6AxRWCUrlnkqf4PiIFXqpQKW8j8lddr91wPABhm97wG1lI9FHDxCOa6NH/Aun8lD8D1JY8dAHfam18qtMs/2D1crdbhYru6ZwFpyC3M/iz/LLDH5tZOApXrgIO3h1zO3MhlRNl046XLsv/IubgBONNuo2XVBhe9royDRE2R6E8+NeeUbHddP9ZX9wrHpDBykw5BH0NrfcLsCrKIhX6Sfj+KKGlT9SXL4G/6hnbOL4dxwvsSEuhgClYbidXKw59xLWq0n8uM/0zI6G9WIMOp2kx0M1yosTH+hORKNfWPtalg4kKDg/oyBIzsTSiPVZB1sek0gQdSYbqgOhvXLGniRZSjpnzGvWpGESveptrwfvYJTeWg3/VhsTTNKscSManB00aZSHHh1my6Ii1hQx/i/4lKY1w+19O/p1rIbO+F6FMqe72CtNVMXsMDAQMNjEiDXldBVoUWkavCgYN/J7BWOJQho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(5660300002)(53546011)(2906002)(956004)(2616005)(38100700002)(16576012)(316002)(83380400001)(26005)(31686004)(54906003)(110136005)(8676002)(8936002)(86362001)(508600001)(4326008)(66946007)(6666004)(31696002)(36756003)(36916002)(6486002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1V5Ukg4WDh2Q0cvdGJweFlYbW9qK3VaeDBCSDVOMlNYaUlKM1cvdmFQM1VZ?=
 =?utf-8?B?NjZhTUdEcVFCYkVrMk1SNm5UVkFQUnYrR2orbUxxWWlyWWI5L05RUHB4UEk4?=
 =?utf-8?B?OVNBOVhCS0EzbDU3eXhSQlB0U3N2TWdVRUtXVDVNaTV2Q2lxNFl2VTRuTHN6?=
 =?utf-8?B?K3d6YVVWR2VackZCL292Vm5pWVFqTXhTYjV4bnNOeWplYlBFZHBUU1YyZFVu?=
 =?utf-8?B?dFhBT3N6T0JMN1dOck1wVXVTcFg0d2VDNFpCOG1BeEdWa2lpZ3BSeDllVytv?=
 =?utf-8?B?ck1NV1BKanlaMFFOL2R6Y1JiUmVNRnlPaGY0bDlUZ2pma3lVeTFybTVrZklJ?=
 =?utf-8?B?TzNOK0ExZGQwSHhOa1ptNHN6R2tZVXBzdWRzcTFET2t0UkNSTWo3MmtNYmYw?=
 =?utf-8?B?cEp6T3plajZkdjAwbVBOMmlUNjl2V0NuRTZ4aG5NeFZFemhXSzJYd3hYdlBI?=
 =?utf-8?B?YnBOYVd4dnVMdUpJekhQWUNwN09QdlI0aEczb0RmMCtZTU1zRG1zK3p1RUN6?=
 =?utf-8?B?UlVva1hSbnRzWmpUL1F2UWEyRGlZeGowOFRCakkyZjFnek4wMWRuOVlqSG1y?=
 =?utf-8?B?VWJaM0RnNWRPMXloeHVTeXNKK0VsMWFuZHd3SHpzRVdPWHdzTFcvQkxvK2Ri?=
 =?utf-8?B?L0ZkNEIwNzVQYytxNHRVd1ZrTnlpU1grNEd3WmNiWWtiNDZCT3VjU2EwVnl0?=
 =?utf-8?B?d0FRTEh2M2tuQnFNcGQ3TG9yT1k2U24zTlVpS1NucEtLR3ZPMFl5UlVGdFBF?=
 =?utf-8?B?NlAvNGp1eUpqZUlHSGxMcXlZMVRxb0VBa0NDUGhyd3BFcjN2R1pCa0ttSEFy?=
 =?utf-8?B?ek9leVdxaUdlLzRNYVlQSlpNRkQvczJVT1FQMGNFQ3pqNUpPTURIZHgreDAw?=
 =?utf-8?B?UDUvaUEwdlNhVEE0TWRTckZ6eEc0eTI2aDFxdTcyWFVlZ3gvck41YzF3THds?=
 =?utf-8?B?MDBIMUhrVTUrYmNpcDVwVm80b09tSGVHUkNucmZDLzRubTFMOW8wUWFreWlQ?=
 =?utf-8?B?eDljNEhGdTlucmdtVW5lcjNTUGxBN2pQWjJORnlueWxoblVLaVFkOEtFeGNO?=
 =?utf-8?B?bEVoekQ0QXhjT09ld3l4K3ErV3Jici9WZHNEa0tpRFB3VUlNcUxXUlpRQmwr?=
 =?utf-8?B?Lzg4QlphbGNReStXcG9DSDlFeTl0V2hJSkdnUmJnemlpSU83V0hFMVhuNUV4?=
 =?utf-8?B?OU84UFJoNlQ2eFZ0UHg1VmNUeEluTWdURitEV2d4c2xyaVpha0R4VU1tUllJ?=
 =?utf-8?B?VFVrbTZuRWJtdkJkK2NvdlRtbWF0NHhvVVJacXd3dXpaZDZxVlFBSmhJM25Y?=
 =?utf-8?B?NDJLV29kSis3STZWMWl3Q09DS1ZaU1pNcWJYZ0hoemtUUlJmRjV4QWtYSHQ1?=
 =?utf-8?B?NFRPM1lGNXZmOUxjaHRNK1RNMjJwS1ZWam5zc2tpNG1VS1lqMmdKWVZrL2xL?=
 =?utf-8?B?VkZ1eXYxbEJmb3M1WUZ0UDRadHExMzBweGFHNzdYNWh1Z3lMelNxZ2J1dXM0?=
 =?utf-8?B?SytsM241aThybXJZU3FLbzJXeVRzNVVFK1ZwdDQ0cW1PUWlOVitLcU5weHZt?=
 =?utf-8?B?VHY0Y09Ub1VKYnNBelRPYjZIYTRXZ25BTXEyK2ZPUjVuMllQbDk0WlJiRjFM?=
 =?utf-8?B?V1FZb2JqVXMwWHMrNmgzS0V6eG9Mem1RTVgvNUdwUXJQYS9mS0hyWWhqYTBY?=
 =?utf-8?B?TjBCckcwRkQ2azN1Q25nUWZKT01aSHFkNmkzMlVHQ2oxMDRSVitsTEducldX?=
 =?utf-8?B?ZkNrRWNISHBLQmlKdnJvRURmbXJSR1NkeXRvK2pmYzZtVVo5SWEvc3EzMlYy?=
 =?utf-8?B?S093dllDNG1OQXRGNitEWDJMQTNyNGJ5YldlSzl4UVVkZThML3IxTUxnRXY4?=
 =?utf-8?B?Mk9TRU1tK2I2blBidUlkRERTNUdoZ0greEwzZ3ExK0FqalhrZ0V3RTRNSUNi?=
 =?utf-8?B?VzJPYlFzMzNNVzF0bWN5Q0JFTldSNFpUMEtBV29aVmE1cElpVVBXWGluZ0lQ?=
 =?utf-8?B?eUpBcHBLVWduYUJQNEMxV0twR0VDbU51NDhKREEvYnh5REg2M3dKWkViai9o?=
 =?utf-8?B?WFpwTGxJZUJiNy81QjlDeHlza08zeDhsY1hrMDlYWnU0YWsrY1U3d05Da0Rv?=
 =?utf-8?B?TzluSVlrdTdnTlJVR09CL1ZQdFBVQ2pXaUQ5OW5YdWl5ZVZVTmxCOXJNbDJJ?=
 =?utf-8?Q?hDlGZUiFwl49LgSPs9uUAUc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48736dbc-cc3a-4c56-eb60-08d9b6302229
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 07:40:09.9082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebnguAmg17Gn4M/f+gWa6Zwd7ptKXh+z/68HS7vPA5IjKe8HEQlZR1Ss4UaSrczI8PBzRL9kuGZxur3+5tqAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4430
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10186
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112030046
X-Proofpoint-ORIG-GUID: D1ZzjDQ3kMww3oaakXd8sTk-MSwH95Z7
X-Proofpoint-GUID: D1ZzjDQ3kMww3oaakXd8sTk-MSwH95Z7
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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



On 12/2/2021 11:31 PM, Parav Pandit wrote:
>
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Friday, December 3, 2021 12:58 PM
>>
>> On 12/1/2021 11:57 AM, Eli Cohen wrote:
>>> Check whether the max number of data virtqueue pairs was provided when
>>> a adding a new device and verify the new value does not exceed device
>>> capabilities.
>>>
>>> In addition, change the arrays holding virtqueue and callback contexts
>>> to be dynamically allocated.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c | 33 ++++++++++++++++++++-----------
>>>    1 file changed, 21 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index b66f41ccbac2..62aba5dbd8fa 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -131,11 +131,6 @@ struct mlx5_vdpa_virtqueue {
>>>    	struct mlx5_vq_restore_info ri;
>>>    };
>>>
>>> -/* We will remove this limitation once mlx5_vdpa_alloc_resources()
>>> - * provides for driver space allocation
>> Is this comment outdated, i.e. driver space allocation in
>> mlx5_vdpa_alloc_resources() already provided?
>>
>>> - */
>>> -#define MLX5_MAX_SUPPORTED_VQS 16
>>> -
>>>    static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>>>    {
>>>    	if (unlikely(idx > mvdev->max_idx)) @@ -148,8 +143,8 @@ struct
>>> mlx5_vdpa_net {
>>>    	struct mlx5_vdpa_dev mvdev;
>>>    	struct mlx5_vdpa_net_resources res;
>>>    	struct virtio_net_config config;
>>> -	struct mlx5_vdpa_virtqueue vqs[MLX5_MAX_SUPPORTED_VQS];
>>> -	struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];
>>> +	struct mlx5_vdpa_virtqueue *vqs;
>>> +	struct vdpa_callback *event_cbs;
>>>
>>>    	/* Serialize vq resources creation and destruction. This is required
>>>    	 * since memory map might change and we need to destroy and create
>>> @@ -1218,7 +1213,7 @@ static void suspend_vqs(struct mlx5_vdpa_net
>> *ndev)
>>>    {
>>>    	int i;
>>>
>>> -	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
>>> +	for (i = 0; i < ndev->mvdev.max_vqs; i++)
>>>    		suspend_vq(ndev, &ndev->vqs[i]);
>>>    }
>>>
>>> @@ -1245,7 +1240,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>>>    	int i, j;
>>>    	int err;
>>>
>>> -	max_rqt = min_t(int, MLX5_MAX_SUPPORTED_VQS / 2,
>>> +	max_rqt = min_t(int, ndev->mvdev.max_vqs  / 2,
>>>    			1 << MLX5_CAP_GEN(ndev->mvdev.mdev,
>> log_max_rqt_size));
>>>    	if (max_rqt < 1)
>>>    		return -EOPNOTSUPP;
>>> @@ -2235,7 +2230,7 @@ static int mlx5_vdpa_reset(struct vdpa_device
>> *vdev)
>>>    	clear_vqs_ready(ndev);
>>>    	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>>    	ndev->mvdev.status = 0;
>>> -	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
>>> +	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) *
>>> +(mvdev->max_vqs + 1));
>>>    	ndev->mvdev.actual_features = 0;
>>>    	++mvdev->generation;
>>>    	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) { @@ -2308,6
>> +2303,8 @@
>>> static void mlx5_vdpa_free(struct vdpa_device *vdev)
>>>    	}
>>>    	mlx5_vdpa_free_resources(&ndev->mvdev);
>>>    	mutex_destroy(&ndev->reslock);
>>> +	kfree(ndev->event_cbs);
>>> +	kfree(ndev->vqs);
>>>    }
>>>
>>>    static struct vdpa_notification_area mlx5_get_vq_notification(struct
>>> vdpa_device *vdev, u16 idx) @@ -2547,13 +2544,24 @@ static int
>>> mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>
>>>    	/* we save one virtqueue for control virtqueue should we require it */
>>>    	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev,
>> max_num_virtio_queues);
>>> -	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
>>> +	if (add_config->mask &
>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
>>> +		if (add_config->max_vq_pairs & (add_config->max_vq_pairs -
>> 1) ||
>>> +		    add_config->max_vq_pairs > max_vqs / 2)
>>> +			return -EINVAL;
>> It'd be the best to describe the failing cause here, the power of 2 limitation is
>> known to me, but not friendly enough for first time user.
>> dev_warn would work for me.
> User commands shouldn't be creating dmsg unwanted messages.
> dev_warn_once() is better.
I said it works for me because there's already a dev_warn() instance in 
the same function.

> But instead, extack error message should be returned that reaches the user who issues iproute2 command and makes user aware better.
Yep, extack's more preferred than dev_warn_once and dev_warn.

-Siwei

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
