Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290DDC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 23:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB6A3401CC;
	Mon, 13 Dec 2021 23:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXbudNzL15zd; Mon, 13 Dec 2021 23:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9524B4017B;
	Mon, 13 Dec 2021 23:52:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B1C1C001E;
	Mon, 13 Dec 2021 23:52:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68AC9C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56BF660B60
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="IMd9H5kL";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="AMvgIPNP"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z2Qcx04v5pSE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:52:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81AA460B5F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 23:52:05 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BDL6oTI021570; 
 Mon, 13 Dec 2021 23:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=a5Mg05oEryQjABr3Awf24h0qVDQk7g5KyJGPqWV5r/8=;
 b=IMd9H5kLduD6f/5PwRCG61FMEs1399VWSmXrMmnnd76/UJbz2aZ+/okP6vMEQadfjmvR
 KDq5tUkNc37TT2LhYozo8jcWyF7nvA+gajBMRhksFAjBZZNsgP4hUNa0cy7tDLHO/tba
 PUmQ8KDWX0V10WNypMZPtabptbUnZc4SeToVVe2oOJMoOrlyOFt1KSwY4x0c0iZ9QEQw
 Y9GFVup//hm/3QJ9i9LHrx1S3MY1gJTAoKcy8JGIs3+ybNUFlR8koPVDXcwfX8iOZgHE
 NCHU85HZaQWEuZmHKgwxy2/d7ZE5/P4VS5B8SuhTboSybDnhaPIlfM2r91HQleA2vSwg 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cx3uka8k1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 23:52:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BDNkRtA096652;
 Mon, 13 Dec 2021 23:52:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by aserp3020.oracle.com with ESMTP id 3cvkt3qa9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Dec 2021 23:52:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPDLoBny4HA1JGGgDSx33Ls4YxoTrBRB5Lg6PVYVAVHh3AFxpj3Tl3Klc+WG3OQaM8iOZlekl0xcwRkDUjXAe8jeBZsBGarb+kIybvZGsjJBm3GmCVbEDSVqwW07f3Fv8737QPeOwE6s9HAKKmewMiRb3G7l/D4rCTmX5T9OipBHYIHtWOAYbAxNjGIH+36kLN3pbgL4dJiS4vWF5jdhDiEwnwKfoRu95tRrAr23A7Muwt9u0Ox6R/fXc+u5sO61OjbPyQaGjCUTgdX+WkgVqBklsVokhCRkVP4zO9j0bDIsrX4MRFOKvJLtNjuMp4tvOyeHxhz1TQnncnwrpJOp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5Mg05oEryQjABr3Awf24h0qVDQk7g5KyJGPqWV5r/8=;
 b=HgPZLOYqbENOMkn+f6KGcNJqEBnU0WPcLnNlvGM1F6TwXtjhZpYZEGo1S6mqp7YUqy2NAWx++WK9je+GBGBnfiv32ls9qIFUG7qLfXd4Fcclp6wVx91EPFdAwen9KqqBhhgmjgPf5jd7jB25pGgiPPHUNGEQMAClMz5xL1btiqWIG+YetSD4BLSGf2puLgDKIMghDKwYBiS1d6Ueogt6FhWHagt3Dt3AIkJOYj9ZdX52Ro4B0BOTmeeGgnbiPcq3hwyjPP0IbXGx78+abNDmgOiC/wL+hPyRZiTBavk6lFGJKzluZlsgRVOTSvK3QFcm/okCe4PZhiyas44ph8R6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5Mg05oEryQjABr3Awf24h0qVDQk7g5KyJGPqWV5r/8=;
 b=AMvgIPNPZsVF7aJKYpG3E5wynkd7m2m4S7l57DGR83jwqWmkHJfGTWBbFu0xsDNFLri69vpteN1ftQJt1KUa0FqEgVevw+lD/O+BYW9ohxKjFKX6B9NUGaAq8Z7cYZXAVgEqH1fsrzRG64veGvHlKPfUGXG2aMksYYu2b0X2A+o=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 23:52:01 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 23:52:01 +0000
Message-ID: <15cf053c-ae7c-86f0-4ee3-744bded066c1@oracle.com>
Date: Mon, 13 Dec 2021 15:51:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 05/10] vdpa/mlx5: Fix config_attr_mask assignment
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211213144258.179984-1-elic@nvidia.com>
 <20211213144258.179984-6-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211213144258.179984-6-elic@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b4c3d3-ef89-420b-41b9-08d9be938ebf
X-MS-TrafficTypeDiagnostic: BYAPR10MB3287:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3287C10BA84D05335CB9545AB1749@BYAPR10MB3287.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvI0N18zS6dlcVU1nBDyeCzxFKR43z36HDyOy9gyC8/lzkLyXQXAx3T48OU3RK9UsRQ4htuDeAPbZTg5NQ1ZXBvuqdM7P6Kcdz5tDUPJ6AV16C8thFbiPO44fE49MfYNQlET+NgN5BKFcHMTrE0MnoKGLOVS/ojTFrHe7T98SRuTbq7qYw+BzM1WwnpgSzPcuOItGKlCeWCG4vlE5Qwjul0Z5MQgEFLXFPwzsfdJc9321hZS85Nl/na0jyKU9bHh04TvpAYFSC01mvlNsALfHYcziPtXfuchLwBVVlm6i77KratrRagyT/ZhmOtJk2iH2PlTY2t8iet/77uiopyGOvcYyVa/frjKsxyy8hdSTZAnXIRHz9Xh++k0gMAUH1kE+80qk5MuFCDjStacy2Ow0hFbGE4P2wdblgazbHdsC4qgwbq+LsHG+dDYI3p8Q8G3jE32U6vmed4HInxHEoa1E3tRqPevoqwIAPHmSVWGQbmHPxwssG2NgOgW0o/vDNHpRC01W3/kv4lQe/h0YieCmDOHvHcQbscUFAFgizoAA32gbHqihJTPoPbNxRgLyewgu7x5GsrViTqNbPPeE9JtXh1OgKogupmmS/a3ZOY+i4UK7maXNgR64nF/r+tH4il0LKscr9nA3xleP8Rr3giqokyl7XjDMBTAIOTuV60hUPNtAx9AEIK3yIeBul7RsNHI2i1nC7vp6BaFF3TRyHkbIJza+H5QTiXVcfc6RtOrCtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(186003)(38100700002)(4326008)(31696002)(26005)(508600001)(6512007)(316002)(8936002)(83380400001)(6486002)(66476007)(8676002)(36756003)(2906002)(6506007)(53546011)(66556008)(36916002)(86362001)(31686004)(5660300002)(2616005)(6666004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUN4VW9ObzZNVitWanhCclk4d2RITlBQMG1xR3c3Mjl3a3NndFZHNVhJZkFF?=
 =?utf-8?B?NEVLczd6Z0ljQ2IyUzEza09TbTJ3VUpxUThBaUJ5eC9tWFZUUk1QMUE0bUM3?=
 =?utf-8?B?dXlZTTdPelRrU1ZRTnFSS1h0dzlhRmNNcGovbTBqTFEwYkVuL3pmSFZxa2VN?=
 =?utf-8?B?MzQvL2xHQlFEKzgzYjRGdDF1UUlKelUyL1VxUGNSRVdJU1ZmU1NwUE96K01R?=
 =?utf-8?B?VWZoU2Q0MysxeThOcGllb1phY05JUXFWM1FGbmRzVEV4bXdiSk1jUHY3Q25v?=
 =?utf-8?B?bGFEelMwdm5jN01KUWxMYjRYRkIzc0ZWQXl6czdXd2h2Sk9BZUJUUUhzNkht?=
 =?utf-8?B?TG5FdmpCelJsQlZjVWlrUG9oZ0J6WjFMT0FTdzZFakZUdU1wRHRSdER1eEhE?=
 =?utf-8?B?bTJPaDRDVTFnclYreG5OS0RhR3orMU0yUjV0ZFFOTGZmRXNmdTFaSklXRWxV?=
 =?utf-8?B?K2JjUG1leVZnQ2k1bGtKRjVqMEw4NFBNc1UwZ1lxdlUyYWdYVUM0WHZLYyt5?=
 =?utf-8?B?THNVeDBoZ1RYaUhUNXp6NUI5RFlFYzVSd0VpdjdWN21YSU1vUHpJUkg1UHYv?=
 =?utf-8?B?Ujd6MUp1cG5JeEJ6M0xhOTZxVjFzUW9Nc2x0Mll4eFg4Nk00akNWekdxbUQ0?=
 =?utf-8?B?Z2F0cnJnamtvM0JVUktFVEtxdit6UGlKRFFvK0N4L25SWDZKOFBUVmdwSFRh?=
 =?utf-8?B?K0hlSmxMdVdqK3JPNzV3c1VXMDJNa2ladGNnamQ1Ti8yZkx0dHdjbTdiRTdn?=
 =?utf-8?B?T0xLR1pHVG1lZXlTVEIxdnVJelBrRXFiWUtRTEdsNE9qY25KRXlOcVBUajRE?=
 =?utf-8?B?bEViSlBjekFrbVJtT0U2NUxPZEdlVDJ3dG5kck5QU2kwL2tpcmFwM3VhWk90?=
 =?utf-8?B?R1l1QjVkbFhvSU9yTGFZbzUwdDRoT0VJaDBGMnZvY3pXSUw3UWRlRmRWaHMy?=
 =?utf-8?B?eWlITzlIalRhVkxlVERNS0F6UW1WQ0p4NFlpWlpaSHQzeTRuZ3RlMU9Rdi80?=
 =?utf-8?B?amNORndoTlNkQnVpUnE1ZXZlQjU1V3RsK0hFMkFQM2R5V0hJM296c0JFa0FF?=
 =?utf-8?B?MlNTMytCbVJORm9RbDlxenpVU3JLL1AwMm9yT3FhYlhGY1I5Q2k2OHVnZDBM?=
 =?utf-8?B?VS9WZU50Q0dKckJIeGc4amZrTGw0NURYbXV2SDNZVkkyeGM2TVBDeUprODQz?=
 =?utf-8?B?T0s4VWVTaEtLYzQvY21qeVJGbDIwcWdSZGthdXpQWXJYOHgrL0swT0NHMVNp?=
 =?utf-8?B?WkhsQ2xUdnJJTUJnb3N2amxRYzJEV3BWY2NQUEFRQytoZkU1V3lvalZLZkYx?=
 =?utf-8?B?dlpSZVVGYktUa0Zid0VnME5ueGpSN1BXckZUL29iMnppWEdDYVFwZHI5U3dJ?=
 =?utf-8?B?dmpJQmtIRUVRa2tialJTYXlDdU56Rmp2RlRqM0ExR1dtZGVaN09ta284Vys2?=
 =?utf-8?B?NWVUR2lGdTBhSElNeG42WTQzL3oyd1B0Wk5KRTRDeXNhejMxRlFrYmVXWGxM?=
 =?utf-8?B?MEpGbys3eXlrN2Y1Y0lMa2l1N0lFTlQ2eEVWaVJ4SFBSMUZhZElaZVdvREVp?=
 =?utf-8?B?VTZKWkZpMFpyS3VmOEZpR245ZU9uSi9OSTRid0RYY2ZuMWNMZVlJMmpPTWxt?=
 =?utf-8?B?M3ZXZW1Sd1FLMmpsdmpFQVhwOEIxUXFXS0ZWM1dkN1pGOVNXalk0c2tucXRR?=
 =?utf-8?B?QU9odHlQc0tPUURQc3RudjA4Q25WR2grSEwwYVZINk83U0tmbUFZMXBBOUlF?=
 =?utf-8?B?bis3MExTeDhzRFM0d0JRd2dDa0NUc0o1S2c1Ynh2b3pZR3c2dkN0V2srQ3pD?=
 =?utf-8?B?NnJDUFh3WmZjMnFYYWV3TzlRQklrK25GblUvVWJ4QmkxVUdYOEpYSFA3blU2?=
 =?utf-8?B?TFg4bC9lbHpGZk4vRDFpN3FpUnZ4ek1LLzVsZUFWVWRZUlk2WEtqVEpsNEhG?=
 =?utf-8?B?Vm9qOUE1NlE1UHM2dm5kbmFscEkvNG1yYjdVeERiQzRWd2EycmcrSnZlenNK?=
 =?utf-8?B?SHIzTWdsNTVCVkNhR2dqS3Q4djg3Rm13aUdDTjlVa0gxL3RRVmU0L2VGVEJ6?=
 =?utf-8?B?THNTWHF6NnFFcStySTVSZHo2S3loTFo1WHMrYm9HT0pNSkVsY1Awc25lT2JP?=
 =?utf-8?B?MURlaHNNQmt4SDZROTBGRW1EUVowMHI0NnBxMzNEaDRzYnE0VnI3SDRVYVA2?=
 =?utf-8?Q?nJIaWg/+7OGoPov0XQ5K3Yg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b4c3d3-ef89-420b-41b9-08d9be938ebf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 23:52:01.6504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qugiwOcG75xFr6UA6CTLWxP90GchM7XwDlk30rfUT13ifraXjLjFrY6BQVAd8AsEHs5MdwHRfs6+YoKsy+ZUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3287
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10197
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112130139
X-Proofpoint-GUID: GD0trSrRO0FqinVmoAzZYOLlW1SMiLXI
X-Proofpoint-ORIG-GUID: GD0trSrRO0FqinVmoAzZYOLlW1SMiLXI
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
> Fix VDPA_ATTR_DEV_NET_CFG_MACADDR assignment to be explicit 64 bit
> assignment.
>
> No issue was seen since the value is well below 64 bit max value.
> Nevertheless it needs to be fixed.
>
> Fixes: a007d940040c ("vdpa/mlx5: Support configuration of MAC")
> Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 98aed4b36c3f..4a2149f70f1e 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2669,7 +2669,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.ops = &mdev_ops;
>   	mgtdev->mgtdev.device = mdev->device;
>   	mgtdev->mgtdev.id_table = id_table;
> -	mgtdev->mgtdev.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
>   	mgtdev->madev = madev;
>   
>   	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
