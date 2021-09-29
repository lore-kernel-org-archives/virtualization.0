Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0311FC433F5
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:00:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950E5613A6
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 950E5613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EDD14218B;
	Wed, 29 Sep 2021 15:00:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTRr3XdztvSp; Wed, 29 Sep 2021 15:00:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F1A3E4197A;
	Wed, 29 Sep 2021 15:00:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5314C000F;
	Wed, 29 Sep 2021 15:00:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A6CAC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 48A524197B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eaYky7npsRxH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:00:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E87E4197A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:00:47 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TEeOlJ013625; 
 Wed, 29 Sep 2021 15:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cNa49YG+pdjys2nA8WWc5jfkEudTq1iUfeKyNbDTooA=;
 b=cXvBmSyj3W/jJmpWwvYYGVd3eFK3lprQnDCXVCKTZIyqZJXuGZl6cizj0X7lwX9gIO7G
 uWjqjrrhRfXkgvbNOjR3YymhskZXOsfpqI0L1YwuAyHMr1TNftuZnGbqsbMSi8vcZk3L
 H85+QVpdYCiTG832o8IIuazK8xDnmIbiTSyZ1+ZhzIWgo+weq8y7AQLfJV5wNstR8N7z
 +RnJNrjA84pHeF2GhS2LgMvbcHMO99TJ049qnCzlfBkEI0Dj6O5Vei3z4vSg7dMVUJu4
 opSfQRizy4esAqaOGK0tu5gxkDihguNN/POKhdBnH+ouTXOmPo+fSRx7JmVOu754TIIU Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bcf6cuubc-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 15:00:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18TECWx9088712;
 Wed, 29 Sep 2021 14:22:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by userp3030.oracle.com with ESMTP id 3bc3bk02wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Sep 2021 14:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7sLU61+kNwi9sNIJFY0/QXNmz8DombIWW9jFiaMNA5Os5KPFWUVGKhnbqQewtpy4GXLrL7gGJItiDXfBrIx7/Jot22pdYgl2PrEOhasPZFo8gNiERQGusxkKcg4vA5AZ67oD8fTLf4/UvSt3tgkWmUrWurjzGkn4ua7L7nBLZ8gB907kOnv9rzSTxJem5nL9Ah866TaAsDojn7oqCocij28APZsopH0HIJ3R1AE6Vrs0BSYU8XZkwKf9QS2qZ0m+lH5+rhZ82ft8Y+73fOLHwcU7yzig4J+KrWsxCsAlL5dmyafoiTH72ZgnzZqxaig7aq/06RCfvIwldEfTLiZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=cNa49YG+pdjys2nA8WWc5jfkEudTq1iUfeKyNbDTooA=;
 b=fmNe3Dki4C+OZI58WwwDszwu0c7DwdWod7h+d1VI8YztFtcwuOcFejDSgsmvDrX+Mz+Y92IqPXu3V079WWHQmoT3iwqbJvJXhNKDLlvVuDiiaSHvxG7eWpsQn6hoTAOqild3NUuopqWee3URYquoMqjTyTGYkJpPGFqFDU/cCfLsrWFwqFgnS3B6x+BA0dSuuqVwrgBoCe1MfjDmdbpAb0IuksVwsnX/A2y4l+eKAgyLVjaThltQz4sRURqadErO6tauqyuYYTNXyEzEE3SVe4ACIXS9xrPjm9GHcyn7mZZ6Ztp2SnxZl81PuPCsBrDUASVNjBcmcaVZVbBNofb1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNa49YG+pdjys2nA8WWc5jfkEudTq1iUfeKyNbDTooA=;
 b=DBTLHDlrMvC3RoiGNYmbJxRlmQFT0n2qh1WLIz7chzntd7pK17MgfQNQ9tfwzAYxHTj/mVCgtCPKrYpS5Po9qqQQ7Xn4x9U9N2nCLIFHyahZlFtztOliaqTwNxfFwAn2voUL0Lz2f5iELBTP+FX2fR0B6uhiaRVUODZpD636nW8=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 14:22:11 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::3c49:46aa:83e1:a329%5]) with mapi id 15.20.4566.015; Wed, 29 Sep 2021
 14:22:11 +0000
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
 <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
 <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com>
Date: Wed, 29 Sep 2021 10:22:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <e9a230f9-85cb-d4c1-8027-508b7c344d94@redhat.com>
Content-Language: en-US
X-ClientProxiedBy: BLAPR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:208:32e::20) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
Received: from [10.74.99.231] (160.34.89.231) by
 BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Wed, 29 Sep 2021 14:22:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3bbbc54-c9df-4045-f8c6-08d983548687
X-MS-TrafficTypeDiagnostic: MN2PR10MB4256:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42568C672075B186D7D71A048AA99@MN2PR10MB4256.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azXtEWuJiK0fdiSDxA7JVs8roo0D2WShIYFkYSvmFe0X4rt+0FOxoBhCpAD9CVgOGKKE+0PiLuq+9sUsxGPoXXyMPUYGlNY55e4vmORntr1hk+KDetSX8rfvu+6rALsCYRiT4xvsjysQvu2BFemm4NMy8sG1Ur51H/MQ220hJIcH8MSVEXm9MfMCC7kOmPpeOiX/FrTTH5SMck/rv3Pm9abliFJ+aUqVWir8/dY/RmZyo9Zc6ZXfRmqPpbs0J8s2Pr97DLgsjgbKhwm/oaVlaOFdmibGCKmCKaJiiFnSn68mtmQorJ1XpWdfqT4Gkc4EANuAPmaaJLdn6HgH/ZPenViafbzX9q4xQxotl8sqPwovdT97+mjr7uWwhwoUMfPSHxkP990lCyCiJDvKVJFc0AOsX1xeZ6s8KGmllLXKo+D7KLJeHbS4xl/ZtLL1DtaiJC4Z1OgskwpQM6g9SnPkp4DnsEZ6Q6wo8ou4ZFa/CAQnR2n0iD9kVitoemz2AeaqWNB9IL92eaNaMVn8UiPS9RNSuwZiebDeVdXRLe3PSI8YAZw/fuew/zYwS0iVXDsK0/wyI86UELdu7hAsvKVtiQ1SoHhDsotSimFIw2dDhZAtmiZc71LyLUxLP8CC0tZtLCOOZc0jjAC1LhJsEPmldYb2Dv40z0/KK/qWgwoZYRKyJ2WLAOS59uK9IV4jKcLT55XDT2s0IXkDI1oMPvsjTLdIAeaDOPHXlKWdcQ9Sk3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5009.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(508600001)(316002)(54906003)(7416002)(8936002)(86362001)(5660300002)(38100700002)(66476007)(16576012)(66556008)(36756003)(66946007)(31686004)(4326008)(6486002)(2616005)(8676002)(956004)(31696002)(26005)(186003)(44832011)(53546011)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZGejU1YkRyZnVacitYRk5JR3BmMFJFZzV2bSt1cWJGTU1nektNK0V2ZDYx?=
 =?utf-8?B?TEIvWlR5Q1BBekMyUkRKai95N0RiUnhxNVZtcVdtR216eUIxS2gyYjREdS9o?=
 =?utf-8?B?TXBYVC83TGVwQnBUSmszU1RPcmtOZFVoMUZxRU4wQmZuT2xzNWtZMFpudGZs?=
 =?utf-8?B?V3hhY1lSU0QzeVU3dDFlMFZnUmhOM29qelJJOHo2VkJFbmlKYzBTSUliVXI5?=
 =?utf-8?B?SFFoOWU4M1pwUnNsNW1waDFKT2IzdEkwcVJjWHBLUk1NWlNrZnp3b29tdnl0?=
 =?utf-8?B?VDdWQ2NuL2Y1d3VOTy9laHZhNzhmQlkwMStqTXB6MjN1OXJqUFFGWUtuaDJI?=
 =?utf-8?B?ZktVR25kYXhtdGJlWXNpQkc0RWI1SUhLOE9TYTh2TzJZVWY4UzJhZk9XbnVJ?=
 =?utf-8?B?d2VJczZpQlZLMSs3cTV0NUdDbTJqYWxsb2dtWHJYRmo2T0RjMFJsdStUZVZ6?=
 =?utf-8?B?UmUxaWZPaGw0Y0Fza3JmZEZMbnVFaGNUdnJhSytMVE9nWHN2UDVvYUZJMzdD?=
 =?utf-8?B?TkttTGFFWFBUQjdoVy9iUWZDcXoyb1luSlVUTHJhcERoUjVoQ2pFZXFjT1l0?=
 =?utf-8?B?elNoNWZUKzN4ZllHVXVYeWMzbjZCQ0pVdFJ5R0FFc1hGVXJOdXNaZEIvcC9Z?=
 =?utf-8?B?citIOXhDWHpzclZscktBcjcwN2twMFFKbkpUOHpLb0Y0S2x5Tkw4S2ZNdnZU?=
 =?utf-8?B?ZGozZkF6M3Zady9VeERhQjF3dFZhSUs5YzVhM091blBwbklrYVFKcytjNlBt?=
 =?utf-8?B?WVRVTk1Pem1zNm43N1k0OW9yeHJPdi9BSVJlVE1kMUlIV3RNUnFsNlFsMUx6?=
 =?utf-8?B?U2JsM1JSaEI4dXZodW4wbjNyN212WXp6NUJ0OHpPWmsvRG9nV1NGK2c2ZGpS?=
 =?utf-8?B?Z0Iwc1ZQU3hjV1JpRkN2WlNFZFE2dXpzd1g0bUFJOTBOZnZxYnFrbU9Ib1hv?=
 =?utf-8?B?eDdaTDVIQ29nTjJyVk1DWUtDVGR1cnhhemNwMEVCNXVwVEZjNVZ0ODRCQUh4?=
 =?utf-8?B?cnMvWEpaVTlzbk9pNEVaVlNwNVVjWUxUM281dE4zcDVIVk45dnZFUjMyY3RD?=
 =?utf-8?B?RENqaXZQTU1BRXdBVy9heE5pb251MnN2SzhzVUE1ZG9BaEhnRkorSzd4ZGNV?=
 =?utf-8?B?TFp2djl3MjlnZGxFaFFVaUx0VVVkM1ZkaE5WVVlIeGg0cUNIYUtPckhqRDlM?=
 =?utf-8?B?SDcwVkROaXN6V3Y5WlY3MXFUYUNrdVhkamJXVU4zem9VMy9EUmhVMFNESzJT?=
 =?utf-8?B?R0NyUE9yUXlSOVg0djVFYWRXRGlGSnF3ME9wbFJ4K2JheGlsZUpaOHFoZzNB?=
 =?utf-8?B?Vnl1c0ZDQjJaa1pLcG91ZUw4bmI3blVNbXpkV0R6UXpMZFNGeDFoTkordkxP?=
 =?utf-8?B?aUxPK3N5UWE1SFRXNWJRbzlEblBwbXhZanlNekhoUFZDZFRQV2FaT2MyU2kz?=
 =?utf-8?B?dnduWmJianVpYXlaUi9rSG83MlFFYllGSEt0aWdpUkJEbGhoMGRmdElmR1c1?=
 =?utf-8?B?Z2sya1hSTnowRm41UmpDRitla3A5bTBEZTdkd3U4Q1VCY1Z5SmZYYllDYTRQ?=
 =?utf-8?B?L01XU25kQmlvNU83S0pDWEx1dUNRaXZNVWxSNlg1eUlRNi9vcUJ2dGZHMkNN?=
 =?utf-8?B?RURvUmE5VHQ0SVI3WWlDbEhTb2JSVWVRQlFZZndYajFwdU9mR05HRXRHU2Ux?=
 =?utf-8?B?K005WG5pYTUzWlV3c2lXNytoamp0NjcyeHpuUS9JNnBCdDR2cGpPV1FtMys1?=
 =?utf-8?Q?m78cTlBTE3d58Vjajl2WQl19AH0Znv9xj9BWUC6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bbbc54-c9df-4045-f8c6-08d983548687
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 14:22:10.9515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMdriNBFwQVFfWL3dz6ApDwfdbfGxJEWfnKdCmTuP7hK5ZnmAKZ5whRtqfqQ356giLcxBDbI4x+W0yHFjGfuPO4TPuIuTI3olX5XhXFy+n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290089
X-Proofpoint-GUID: PkBLbRGZ5d5dZzyjxXUaMDKbPdBPQLe0
X-Proofpoint-ORIG-GUID: PkBLbRGZ5d5dZzyjxXUaMDKbPdBPQLe0
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 x86@kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Baoquan He <bhe@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDkvMjkvMjEgNTowMyBBTSwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gT24gMjkuMDku
MjEgMTA6NDUsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+Pj4KPj4gQ2FuIHdlIGdvIG9uZSBz
dGVwIGZ1cnRoZXIgYW5kIGRvCj4+Cj4+Cj4+IEBAIC0yMCwyNCArMjAsMTEgQEAgc3RhdGljIGlu
dCB4ZW5fb2xkbWVtX3Bmbl9pc19yYW0odW5zaWduZWQgbG9uZyBwZm4pCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgeGVuX2h2bV9nZXRfbWVtX3R5cGUgYSA9IHsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuZG9taWQgPSBET01JRF9TRUxGLAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5wZm4gPSBwZm4sCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC5tZW1fdHlwZSA9IEhWTU1FTV9yYW1fcncsCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCB9Owo+PiAtwqDCoMKgwqDCoMKgIGludCByYW07Cj4+IMKgwqAgLcKgwqDCoMKgwqDCoCBp
ZiAoSFlQRVJWSVNPUl9odm1fb3AoSFZNT1BfZ2V0X21lbV90eXBlLCAmYSkpCj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5YSU87Cj4+IC0KPj4gLcKgwqDCoMKgwqDC
oCBzd2l0Y2ggKGEubWVtX3R5cGUpIHsKPj4gLcKgwqDCoMKgwqDCoCBjYXNlIEhWTU1FTV9tbWlv
X2RtOgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW0gPSAwOwo+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPj4gLcKgwqDCoMKgwqDCoCBjYXNlIEhWTU1F
TV9yYW1fcnc6Cj4+IC3CoMKgwqDCoMKgwqAgY2FzZSBIVk1NRU1fcmFtX3JvOgo+PiAtwqDCoMKg
wqDCoMKgIGRlZmF1bHQ6Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhbSA9IDE7
Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiAtwqDCoMKgwqDCoMKg
IH0KPj4gLQo+PiAtwqDCoMKgwqDCoMKgIHJldHVybiByYW07Cj4+ICvCoMKgwqDCoMKgwqAgSFlQ
RVJWSVNPUl9odm1fb3AoSFZNT1BfZ2V0X21lbV90eXBlLCAmYSk7Cj4+ICvCoMKgwqDCoMKgwqAg
cmV0dXJuIGEubWVtX3R5cGUgIT0gSFZNTUVNX21taW9fZG07CgoKSSB3YXMgYWN0dWFsbHkgdGhp
bmtpbmcgb2YgYXNraW5nIHlvdSB0byBhZGQgYW5vdGhlciBwYXRjaCB3aXRoIHByX3dhcm5fb25j
ZSgpIGhlcmUgKGFuZCBwcmludCBlcnJvciBjb2RlIGFzIHdlbGwpLiBUaGlzIGNhbGwgZmFpbGlu
ZyBpcyBpbmRpY2F0aW9uIG9mIHNvbWV0aGluZyBnb2luZyBxdWl0ZSB3cm9uZyBhbmQgaXQgd291
bGQgYmUgZ29vZCB0byBrbm93IGFib3V0IHRoaXMuCgoKPj4gwqDCoCB9Cj4+IMKgwqAgI2VuZGlm
Cj4+Cj4+Cj4+IEFzc3VtaW5nIHRoYXQgaWYgSFlQRVJWSVNPUl9odm1fb3AoKSBmYWlscyB0aGF0
Cj4+IC5tZW1fdHlwZSBpcyBub3Qgc2V0IHRvIEhWTU1FTV9tbWlvX2RtLgoKCkkgZG9uJ3QgdGhp
bmsgd2UgY2FuIGFzc3VtZSB0aGF0IGFyZ3VtZW50IGRlc2NyaWJlZCBhcyBPVVQgaW4gdGhlIEFC
SSB3aWxsIG5vdCBiZSBjbG9iYmVyZWQgaW4gY2FzZSBvZiBlcnJvcgoKCj4+Cj4KPiBPa2F5IHdl
IGNhbid0LCBkdWUgdG8gIl9fbXVzdF9jaGVjayIgLi4uCgoKc28gdGhpcyBpcyBhIGdvb2QgdGhp
bmcgOy0pCgoKLWJvcmlzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
