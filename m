Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5868FC433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 02:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10D4660E8D;
	Wed, 22 Dec 2021 02:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2kyqgA1V7xp; Wed, 22 Dec 2021 02:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E71B60E8A;
	Wed, 22 Dec 2021 02:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 758FAC002F;
	Wed, 22 Dec 2021 02:07:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CBD5C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C61C60E8D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VzbldWouHL-j
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8796060E8A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 02:07:23 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLLDqaR030882; 
 Wed, 22 Dec 2021 02:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m/HWhSlUQnh46UkO+s7t9OFT+D5By4NUltB4VOR4Wg0=;
 b=JzemytnYpHxPkeFxAsftNatCAyszPl5CYo0Tyw3f9BoGBtfmgvkBFwLF7CRjgMvngIeo
 uH7dXmF2L6bq0GMjZqkkItn805tdfB+NbRyegSUiaaFrqFTJkpX508YVRYPSb5IDZpWC
 P5Ji983mES4gARPIJP7TL06cbGmWn2dNzL0SuRdE9ds0PMX5GUKiIPW4NPFUPY0EdpOj
 liwlP69J5voQVgcCpgH/H0N5ZWu7skQx4GSxd7Njro1DZjksj+vgU+90PWh0VUSwO5T0
 9rlpiXK1JPKlAtnbQHVBapStQhrciusdqkiHoY4hOcSiRgRhvPlouX+QkGyyE7FVntPS 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d2q6emvqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:07:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BM26T7j096830;
 Wed, 22 Dec 2021 02:07:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by userp3020.oracle.com with ESMTP id 3d193p2uy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Dec 2021 02:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftpBBWtf8uea/0X90Npqn0/+5IpK5TWW1YkimY6nSz+25DR6mHN7HEi8Iim3f1jieu7ZkBJa/TxuyAwgVxULb+P1eaLneDG+6iKD+fGbsCfCUg3GX4Fy00ggzNnQevmpzvqNfWYco8NyC6WOkP6n7DgbK194+bLIRl7JvRm4xAXb/Vx6DE26sTxz3OZve/YR+g+9fVGChhMxitmiTKNv/gtTMmjifAxtTjqcVnlzhzRNiSphCeXYXxxc5hAuUd7SZnu9BtRSTsIOom5X+RbABk4H0ui5qKAvOqEUTKUFwHiD99ieD5XBTz6pKtY7n2NB7e9Nqeogl0XVvXT+hhiN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/HWhSlUQnh46UkO+s7t9OFT+D5By4NUltB4VOR4Wg0=;
 b=hx5x5SD32eOJ37FWkBHL0cBiw+dZI80U7G9LMZd9i3Avcq4Z8jnDNx3F6avn1bRXYRx0stAlXXAKkWDhfxihc5yE6p1BL/AfuzjEh3uuzt7z+ROHmHcC4sdhesROWVAEbW94oSycr+v563pVtRcnVMt1rS/wVznu9YX2YF4jN42BfyEPSKt3qCAZYzIF/+iSyMYdZ0jZJ3yq4Yq8cs/7203k/VR5KOkIVffs7e1bYySq7V/EejouTpRJg7sb7/yIY/sWJYrDAVy76uwxDKTltS1N50I4P9Z4gpRaQGYRPNLpBfJINoElHErtTbV9cVXxAG9dxnkwSQbeV6UXEV/LYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/HWhSlUQnh46UkO+s7t9OFT+D5By4NUltB4VOR4Wg0=;
 b=OuXSrlAKJRw2WSRjwZmPy0yC1MlK4UmMVtvlHLCK2lc4KD06ddqavQfGVHEmdl0oQg2ARRqe+jLltUd4bswL63Zcz2ZuLC1lBmSnYGI1e0zATLg0t2INCcdzBQDt1308D4DfLOQOuJYpOCBwcvVLuhoxnSKTyokAuqM+mW9UAMk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 02:07:18 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 02:07:18 +0000
Message-ID: <f74ebde8-6681-b302-cf19-4fbe485951b7@oracle.com>
Date: Tue, 21 Dec 2021 18:07:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 11/13] vdpa/mlx5: Configure max supported virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20211221172006.43784-1-elic@nvidia.com>
 <20211221172006.43784-12-elic@nvidia.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211221172006.43784-12-elic@nvidia.com>
X-ClientProxiedBy: BYAPR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:a03:80::26) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2a24f5b-4650-4406-c757-08d9c4efc7b8
X-MS-TrafficTypeDiagnostic: BY5PR10MB4308:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4308C00B2D7B1A717276BF27B17D9@BY5PR10MB4308.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWZBruIgbtlwib/aUYh+oQ5czuuYWPX/vKBF02uayzLjWVRVzADImVL+wLZ6Z0WY2rvBpBa6FxFuqZmGWSEpg8zQS2fOOANoGV1L8H4CyAnmmq/IiBHmUyAeovz6gTDCtJ5OA/2VFKwFKI5YIswOairiZIg6q/HEoIQIngENFxkiYC5xBLZe5wE7egiWEe/euhwuSoLwjND5mJb+YKuVkVs3YBmzuS0y9LKrpgB+Y5Wfy/o4EgLb4O5+ebahxnju+MmRQzX6SFZys9Tl16qpYZijRog/f56KZvkNwxNeshPCKy6/8Ytfpdttshwt+yvoAXNVXUgQgFtgsUZ8EHWYmKSxjDSGHJ6qvnaoivGXVjwKNZ0yIsVQwUgWl+03/HbRww8kbjgnTdM58mzyILz4F1kXKNQiW4ee+cW+Dud3UBs8wzkIYveT+/NFUOlN7x/BA8TgFsM2X4ian+P4ANTw6LwgTZGH5gYtP/mtbowvyjJo38+vYrK+VJIcDn2OPmpOwHjgFPxB3vhY6E4bcwk0omZafKc//CoUE293HqdBBWB6PHt2ZVmTZmaN4lsdAWp8+PoAHZVziskBaE6Z6HT4jEfaiu1c1WWHwucr+i5IqA3mEahk/kFyASjrB2hrhdsCBYMqFxDWbM/DVaGW0U2fbuocB0NTlcGEEkhCmWHeUawl0cTnAa2ms3WPyhbPTm+gJ6PYizyyiP6Hji05DQdPgxUu2FtX16ur6PyoZLptv/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(6506007)(38100700002)(66946007)(53546011)(2616005)(31696002)(66556008)(508600001)(4326008)(26005)(6512007)(66476007)(5660300002)(31686004)(36916002)(6486002)(36756003)(316002)(8936002)(86362001)(186003)(2906002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3V3RXJiNTF1b0V6RktUMTVjd1VDVXJ6ekFFRHY4T1ZhblRVdlFRdS9TWWFr?=
 =?utf-8?B?QUZEelllZnEzb0RJbURCcHdZWUs4Ym5kMnIxYzVXK0hrUCtDVjFBNnRWUTRx?=
 =?utf-8?B?MmdvSWRmb29Xdk83MktPTXpZYUZtMWJkMmk0VDBhM2FJNXRIT1poeXVPOUR3?=
 =?utf-8?B?UWp3cTZhd091dE1pUUlwYzNNcXUxeXNuK2tmaFk1UVJzRHV2ZG5lQ09FRGhp?=
 =?utf-8?B?cGRTUncvbmRIUEc0WTREVUM2TkZ0N2RLd2s4M0hra2dMNDVrNmk3N3JBTTVs?=
 =?utf-8?B?TDhNMzhrRzZIV3UrVXpYb3VnaWlUdFJIaFdBVk0xdWxPZmE3Vk90ZFFXNmhw?=
 =?utf-8?B?bjhrQm5TWE5RaXdGMlNwTzhXaVB0UXc0S3gwV3NpRks2a0FKVDc5RU1wbzcr?=
 =?utf-8?B?empJb3o0Z0dWWlVodFYwQzRWNXNtRDR3RVBiaE81V3BuaFJsb0pCcXNFbWhu?=
 =?utf-8?B?c3BzampUZVp5b3JzSnFUK2pKTnkweVREcEE1RjVqWFFxRDRvSmx3OVBydHIr?=
 =?utf-8?B?UGZVaXlyQlA1YjY0YjdxazFldVpOQy9leWp3NDZCdmZEZ1NQVGlRZU1XdzBT?=
 =?utf-8?B?aDdvb3cxUnpjTDQvRlUySkltdjFWR2pGTUk4Q0IweWtJZytORFRDaUlOUTda?=
 =?utf-8?B?c0FDRGxwNU02MHZKelVJM1NHSUhIOC96RWJuNmNTdy9hZEx3a1d5RXlGNkxR?=
 =?utf-8?B?aVhCemttR1Y5STlFZXM3MlJGWXNJWmcxOGNXdUJLd3hFekEycnM2UmM0OXNK?=
 =?utf-8?B?bTlEREZRWGhrTHFuRndpaXZlUDM3YnpMaUUyaGM2b0VHMXJPNDRRb3ZtN3hK?=
 =?utf-8?B?NHR5dWttWUdXTzhDeGJOKzYzV1ZZMFVCY2xMU3RGN09JL1ROeUdvcHRhd1ht?=
 =?utf-8?B?OXpyTHN5endqWGRJVlRPVlFmRWdzeGhVNG5sdzJjRTlPV1JlTVNDdXFFL1NM?=
 =?utf-8?B?Y0h2STAwTnNhVnZjMWk2ZllueWFZaXVZaU1zS0lrdENnS2IvaldBYThzTEJ5?=
 =?utf-8?B?L3dTOUlPaURoWmMwN3JhWExUMUg0STN1cjhucFJrekN5Z2dPTnRXKy9QZUhm?=
 =?utf-8?B?OElOZE9nOVYrWGE3NHhYY2VtQW11S3RqUVhwbk9ldmNlcTJ5QUFmYm5uY2Y2?=
 =?utf-8?B?OEJ4MFZiVE41c3dWZGg3Ri8zZEFzL1ltb0xKZ0JDYjdrTkFTbUFyYVpTMXRF?=
 =?utf-8?B?RHdEci9TQytrc0dFZGliSEsrcUZnd1JkaVpvWHJJZ2h5YmpJcFFYMFNBL0Jo?=
 =?utf-8?B?aEsxY05INGpYNHRBRkJWOWUwVW1NcXZ4eVVGVDYxR1Voc3cwbGl1YjdXdzYv?=
 =?utf-8?B?blcxQzVIOTVjTkx5bG1kUDVHdGcrRnd3WjF0YktOc2FLeEFMYmg2TDdEMGFy?=
 =?utf-8?B?Q1JpUVZQVWFRSWQrVGNaVzduQ2dxR2dLRG5jZEtaWXJGYXNyVUVPTjFkTUZL?=
 =?utf-8?B?cThCTE5uSGZ2bGlCTmEzbm02Q3A3K2RwNnZXSEUwK0Z2dllQL3lDMzIvL2ow?=
 =?utf-8?B?dmJRaUltM2dIeEZQaVZLekVDSVdGbExKaVViTTZoRFdNZkZ3TUE0Q0F4NTgx?=
 =?utf-8?B?M3A4Y3lXWDFnVURjbTFmZWYzV09YcFBnR3dvbG91a2xGQkRiLzFHODVMRlds?=
 =?utf-8?B?OGI2cVh4MzNsaUxSR0xreTd1ZzBhbTZTWlNHUVBvOEhDTHg5K3MwcUZyWXUr?=
 =?utf-8?B?NGZ3NkE0em9sU1lhLzNXUUt4WHUzSW5LM3FvNHZkMnVOS0x2YWpEQmZURjdw?=
 =?utf-8?B?SjhhbjJyV014RkpFRUk0dWI5U2hUVWU4NmlJeElUMVpoN3RvYnBVb01CNGh1?=
 =?utf-8?B?K2FsQTE3OGZHQVhaMW13ZU1keVVEOExzcWtjcTBCRU5laWdrZ1BSK0ZUVG5X?=
 =?utf-8?B?REh1U2k3SGxPTk5yR21aMHhyeExEZG55NFUzS3FjTFplQ1dEVE5qNHVWRWlM?=
 =?utf-8?B?cTUzSWpvVzVCTDAza3c0SkNNdjl3RHRzMVlnc3ZHOE5pZER0a2VFYVA0WGU2?=
 =?utf-8?B?M1pHL0Z0dEkrV0lmeWJqWHEzUG1WSGI3bEJhNWxUU0JSb2NQNmJzOEsreERz?=
 =?utf-8?B?YmJaMHJUYmJGNCtFWFJJbm1Eb24zckp0VjAzdm9sdWJpandSNTlmSW1JaWNw?=
 =?utf-8?B?MW9Hcm8yQVJERXpjSG5ENXVYbnV0cVN0bXAvUmdNb0d4ZFdzWmc4VnFsNDI1?=
 =?utf-8?Q?PzwGcWu3lNVrVDp5XJtjtR8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a24f5b-4650-4406-c757-08d9c4efc7b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 02:07:18.2420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LclWP+/DOhDqAERjofuJLUN730m2jV3T1cEd5W5Ok4XKDPNPpK0zRv8Y4vOScs0uyMaKCW0kJ53O1CvF9fWMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10205
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220011
X-Proofpoint-GUID: wJA9yCgLeIJSVJ5fbRfE9M1HGeai4qFL
X-Proofpoint-ORIG-GUID: wJA9yCgLeIJSVJ5fbRfE9M1HGeai4qFL
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



On 12/21/2021 9:20 AM, Eli Cohen wrote:
> Configure max supported virtqueues on the management device. This info
> can be retrieved using:
>
> $ vdpa mgmtdev show
> auxiliary/mlx5_core.sf.1:
>    supported_classes net
>    max_supported_vqs 257
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 72ed5efbe35d..67fa74cfaad8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2689,6 +2689,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.id_table = id_table;
>   	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>   					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +	mgtdev->mgtdev.max_supported_vqs =
> +		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
>   	mgtdev->madev = madev;
>   
>   	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
