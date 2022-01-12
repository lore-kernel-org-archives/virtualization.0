Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA36C433F5
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 07:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FF0C401A4;
	Wed, 12 Jan 2022 07:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLWSX1MbbJ-4; Wed, 12 Jan 2022 07:47:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 666D140186;
	Wed, 12 Jan 2022 07:47:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EF88C002F;
	Wed, 12 Jan 2022 07:47:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9F95C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF8AA6FB4F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="XPYRPrG/";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="rF++K2AP"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4kyGj3PpdktI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A1656FB3A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:46:59 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20C3vuZ9025160; 
 Wed, 12 Jan 2022 07:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kv6D4+Up8DAjGCiymTicBUVagzuBhOzy8LIhlFRpVI4=;
 b=XPYRPrG/GLvh11ByH4Zni6kpnf0MH9hDDdUIEzrlCk0iHDVRzqBjBjnefbr703g6UCcp
 6mSiBtutM+EqLNuGDIC5zR9bQwJBj7bSwOsPyy7vt4M6IP+D5gP8SiiVXLvJb0EjWrdP
 orvxNIXZaa+Turt/aHj/JuXdyfFQRbcc/QxFuXh/moVMGsWatOFHxJD8UyyIAHMnT9Hw
 Lh8UF21QA8CQo40hwYFLqc1Ks1J/TfdBYHb0crYAtxrM6J5oKBHIT+6dMLwwL5soin4n
 TXF+VDIIfKODDZ+jJSp4imPVdVxgq8DkWX8zBySSvVkqencV1Iarhdd/RTPw43afFUkC iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk9dg20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jan 2022 07:46:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20C7jfIk081911;
 Wed, 12 Jan 2022 07:46:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by userp3020.oracle.com with ESMTP id 3df42p5d93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jan 2022 07:46:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4U4oX+Ey54A5Ru4YgnQXIT1lOW2Db7Z/3fJ9gsL+yOc3QRx5RNNKPQvpFQgIv/nCt8AIAGgyajWLRgrtguJw3bXxTurwNVEt+rpz5fqWELLld0Ppe4P9qyfKm4z1oL1U6pwDKuE0wNWukEMjN2oKbIRidrRv9W7obvEl02CVo8Kf629Z3NvD1dEK3uWQG/5PGD0roG123ndYTZyAJ8EwzS5bUVQfM7DQ2e9Kdd0IGOGJ+SvlAJ1/s1ybJY88snKSwK6haZaR+szrWzrp6+ia6bfhMCNMK2d4b9v2zxySPEL89hFGnBytg21EdhOnUqvbI4Jt2E8YOTLWo9A3np9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv6D4+Up8DAjGCiymTicBUVagzuBhOzy8LIhlFRpVI4=;
 b=XCfy6C8j9JaRyh/yNjQ0uF961Au9D0cTfqYHklSUR9ay5WlMqzQoa5yc65J6INfW/uGr+dfjNZmnhNXvVpED60Bras1T8hmlT1pIO8h+s1gVvIh8BlvTtiHru5LjHmqWNlvAFK20GEZa5A2dlr4n/r5Io80AuaUMmnDwJDgfS9BVszUQkuZGxuGEOZMPAbJt1OE8mUnksy/JzGnMcGF5tM+5SqwMMTvSUKtARj2PhtIWXbrTUMCsaUO+96NJw9CSBlSjL46RKp9g5higpAfkpz7AE3WBY+AJpP8ZAdDd39ngx+lRUc/ST2ZFkhZw7CrtChwIqUUJCm7qel+9yJZuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv6D4+Up8DAjGCiymTicBUVagzuBhOzy8LIhlFRpVI4=;
 b=rF++K2APy014zKwTUowadfzIPqvaK9HK0HfXr2qfipcKPP82thwdTQIOpnBp/EKXhSmxXS98jY6ko3AObyau9LaJ0JsiKO7CNXdOoGhg+daQfjYGkiu4gMEemvY3RcYcE4No/gDAiWNP3bCd6jfJ7MpE8/yX39wGxfu/WRHsqDM=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB3937.namprd10.prod.outlook.com (2603:10b6:a03:1fe::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 07:46:55 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 07:46:55 +0000
Message-ID: <163fbf36-64d1-9840-5803-29c17680e79b@oracle.com>
Date: Tue, 11 Jan 2022 23:46:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 4/4] vdpa/mlx5: Fix tracking of current number of VQs
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-5-elic@nvidia.com>
 <8f1d7e2c-e8ca-4c09-f18c-72cd4c09c44f@oracle.com>
 <20220112063732.GA196570@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220112063732.GA196570@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::32) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b8f3f1c-9159-4f09-6a36-08d9d59fb41f
X-MS-TrafficTypeDiagnostic: BY5PR10MB3937:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3937CFD231AC8E175317CC37B1529@BY5PR10MB3937.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfqyqy28/K45xKS+w5U+p7n+w50MzMlIUOwMRCREzd4hM50WAutHcOdc3EmXeTNKEE8lUh1rtLyQcFUUB9jWsLjqe0pWH0yMA1lwFcZ4gUxILmoZNBk/OKGgNyxXA1A3YeYfYIANrQ9U6QQsybmGL5kp40mqyz+lKDdm6ClqJNkl8Lr8FEHU4+0FcpYgrl6koqZaASYSn/2PEoAkrSOdoiKsA2c7D9uqtvq1Dl91g2dFHcsbXCPzJB3avHE5TzOvb6MsrSsNrHEGKbHear+01rcIq3chgtY5KhTa/Fgx/HIdwJfh2xgc1ZK5tj/PF9SBu4/BmwjEbn2gkgudYs2APEMadJSUr5yeHUAf19o/HAgDzLsSYl9Ay+RVzoRDl8zFW7cpFnR1UOsb2Dt/RxJEoYIWqW3wZyjZvkQGsNgYDmdJs4PUDNCLYnroC1wdzIlVdre5Gldmzu+NJmVdRRlAp7qZnIE7r5Yh7qEvF5Vbq1mSAIumxfFW1uttwlcwYPH7U7fWrC5yyMjAYi5hawvX17o1Tru+X/wZxLJ+V7Sny2nMvyiaDcxiuw1KFdEslXBaqHk9cuvbCBP+T57Fdw5jujrB5hz5kym8w+kDCsga3XCJaSGLHMcKm9u3jTAPmDGxfVb2Ny0kFfFAzvz2GW8V3meq7lllVw0Zb/JiH1bxfV7KkeBA40WlhI0geZVPE6Gx0KckaZuYsNzNQxlcMU9KbbaBdro84cy/XV6/e+PivxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8936002)(38100700002)(5660300002)(508600001)(6486002)(8676002)(86362001)(316002)(186003)(31686004)(2906002)(6916009)(26005)(6512007)(66556008)(66476007)(66946007)(31696002)(2616005)(6506007)(4326008)(53546011)(83380400001)(36916002)(36756003)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHM3QUlMZ05YajN6SGIwRkpkdFlrZndkZERacVF3dFczcVRlL0JtdTMyZHNx?=
 =?utf-8?B?bXpvVnZHNStxY3NmbmNFYUJGWlRBV1FZczdNOHBqTnpPVHZ6dVVEVVVOMUZv?=
 =?utf-8?B?UTFFZkEwV04xMDNUNGl5K3AxS3lndCtMcE9lS2xISFVDS0hSZDU5c29DTkJ3?=
 =?utf-8?B?dTl2Q0pOaGhkOXBhYWtxTnNDc1R4d29pYWhHYys5NjQ5Z3lBS2xOOUhPd1kr?=
 =?utf-8?B?NEc0Y2FRWTRkNG4ydlpURDlBZy9NR0xwbGJ2TithQ3BVTmdSWHB3a3RzV3RN?=
 =?utf-8?B?WTMzbzdsTnl1VXcvNzk0UDhHd2dZMDZlUUovTjgyZmh5eXkxODJEcmoyR1Jh?=
 =?utf-8?B?c1ZrUjBIZmRxcG81RkRNRXFvUUs1ZmFJVnMvU3V3QVV3TXljNjlISjJoUE80?=
 =?utf-8?B?SUR3S0FTTkI5RC9VMkJnWC9UUENPSE1ibHJlLzliR1VNVHF1TFpoZkN6ZTNB?=
 =?utf-8?B?U0tGcVU2c0Nkd1FudmQwT21ZUzNReUFpZFdZdDJhcEFjb25ycG1LRHY3MGk2?=
 =?utf-8?B?bUFSQm1Rd2ZXZXNaMUtlSXZPZUo1bjU0VWg4QWpSdWYzaGcyOTNrN1RHY05K?=
 =?utf-8?B?T3RGclkrSzJ2aXowbkFCWmFWTTVaTXRXZDMyVEgzcm1BR1BQRmg5S1hNM1RL?=
 =?utf-8?B?ZTVXSzB0V2NkTnMxR3huT1IwTUhPOHBibk1UUTVhUy9mV21wdTlmaXJqbjdi?=
 =?utf-8?B?K3pxNnRBZ3FJNC81VmNHejFxSXdFSHBxWG1HdmlxUjhsb3dhVVRWeE1NTkt0?=
 =?utf-8?B?WmViQ3FQV3F5T0l5a2FTSmxPZENWdHNqU1hMU01BZ21aUEFKUXVpYnpSSlpL?=
 =?utf-8?B?RVltQnBOT0QvdGk1RkhhMkU2R2J4eVZTT3kzbDFCWWRoUENuMytnUEhHdDJo?=
 =?utf-8?B?UWxzL000a3IvSDN2RzczbXJrM0VVTFQzaitqU0JhMFVHSkx2c0hLTzhZM1lE?=
 =?utf-8?B?OUdESy9KdVNXb1htVk5pLzVvU0h0TWMwTjVTU1BNdCsyY29uVTVGQnYwWHdS?=
 =?utf-8?B?ZHVqaEU2VjJvNlZYVlFzYmNOdHZ3Vk9WSWpxNWtDWFJYZkZMbTRmQjJoOEFI?=
 =?utf-8?B?SUtNRUF4R090Q0thREM0VjN5TEdoRVM5SFlEUTRZakRScW1FaUxKZjM0S2NG?=
 =?utf-8?B?UEVhRWRJT3RPd3ZyR3NrWjdNOEZ0V1g5am9LTlgwUmtTMGErcDVhRUFqN0d6?=
 =?utf-8?B?dURUT2lnSWJvbkdnaDlJZEwrUkJDYmR3L1FxVnF1SEhxcUI3cElDd0JJQlFT?=
 =?utf-8?B?QU9LNGNHQTR6aXFTWVF4MnQzMDZYNXhObHhnY05NSURBMUU4ZTcwMWZOSTll?=
 =?utf-8?B?L1hrYk1BZ2Zxa2xud0lMbFNzeG1NM25DYU5rcFcxY3NiRTRzRExaWDMzMi8v?=
 =?utf-8?B?RUFXYnM3NVV6MzA1OUk3blQ5aGZ4VVBFM2RnREZLeTg5Y2NjTWJybEw4Z0hm?=
 =?utf-8?B?amtWRHFjZDNUajZaQ1o2QkxFckZFb3pyRXhvOHFJWFpvdHpqdFZhL25wbFpF?=
 =?utf-8?B?NHY5ZS9PaFRLZTBGQy83RWxlOUx1RS9ERE1OTi9lVnNoa3BCdWVLL3ppMFJB?=
 =?utf-8?B?VmRQK2N2MjhKeDB6UWhsTmltdFEySGNGeFlVcUZKZkMyR1hKQzVmdW9ld2xw?=
 =?utf-8?B?TlQ3ZEw3V1lmc2lZTnY5WUw0V2NXVnN6SGRpWTI5YnNVZGVTQ1ljT1d2ZEVH?=
 =?utf-8?B?YkM0YlEvbFQ3bFBlQ2ZOTkM1eGpqTTJOcWxWVitXbjFuNXdjU3lsemEvK2lj?=
 =?utf-8?B?bGxWV1Zzckl0d2xUMDZhLzNySndWN1pFMGZCSCtuVWVPd08zcU5nNld2emF5?=
 =?utf-8?B?Z1lFL1hjLzF2M0Z6MzBaTnlLZWtnV1NpamF0S2M3d3FkU2FGRjhNaW1VaUFQ?=
 =?utf-8?B?Yllua2IxNWdiVW9hTWpaaXJNVWp6dnNQb3NGNmdkMzF0L1VCRnU3VGxCNXhz?=
 =?utf-8?B?WkY0NUVxcjRXdDBMTklra0hHYTk3c2ZPcVlKV2FTZ1hyNUlPelEwNWp1MlV6?=
 =?utf-8?B?clhYUjJIYlRRTnJ5YjVvY0FsUXlxdlJhVXUvNnUxYktLalNlbUFOUnJyMy94?=
 =?utf-8?B?WmVrREJObDZocXRNVjhNV1diZ2J0d3lsL1ZWcWpJOHNYcmt6eFlUY1lkTGhR?=
 =?utf-8?B?cHI3eUpZckFxVXdNZCt4Um91djhDOFdBM1FTSTZzN2RZYjJGUElUY2VGdjhr?=
 =?utf-8?Q?2rpSbXYsZ/6iGPna7lpVqCo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8f3f1c-9159-4f09-6a36-08d9d59fb41f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 07:46:55.0609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpzAsrBOg3w8oE4nrb+Y4CHQPzQR67eOqYaa7fXTfz9VBdRqFC20gF4xNSsAYlcjKmr5rNGV7m2VnvcjBv5OLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3937
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120049
X-Proofpoint-GUID: vsBexdJs7v-T7A1qE8kiqXikK8a-acGZ
X-Proofpoint-ORIG-GUID: vsBexdJs7v-T7A1qE8kiqXikK8a-acGZ
Cc: lvivier@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

CgpPbiAxLzExLzIwMjIgMTA6MzcgUE0sIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBUdWUsIEphbiAx
MSwgMjAyMiBhdCAwMjoxNDo0N1BNIC0wODAwLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pgo+PiBPbiAx
LzExLzIwMjIgMTA6MzQgQU0sIEVsaSBDb2hlbiB3cm90ZToKPj4+IE1vZGlmeSB0aGUgY29kZSBz
dWNoIHRoYXQgbmRldi0+Y3VyX251bV92cXMgYmV0dGVyIHJlZmxlY3RzIHRoZSBhY3R1YWwKPj4+
IG51bWJlciBvZiBkYXRhIHZpcnRxdWV1ZXMuIFRoZSB2YWx1ZSBjYW4gYmUgYWNjdXJhdGVseSBy
ZWFsaXplZCBhZnRlcgo+Pj4gZmVhdHVyZXMgaGF2ZSBiZWVuIG5lZ290aWF0ZWQuCj4+Pgo+Pj4g
VGhpcyBpcyB0byBwcmV2ZW50IHBvc3NpYmxlIGZhaWx1cmVzIHdoZW4gbW9kaWZ5aW5nIHRoZSBS
UVQgb2JqZWN0IGlmCj4+PiB0aGUgY3VyX251bV92cXMgYmVhcnMgaW52YWxpZCB2YWx1ZS4KPj4+
Cj4+PiBObyBpc3N1ZSB3YXMgYWN0dWFsbHkgZW5jb3VudGVyZWQgYnV0IHRoaXMgYWxzbyBtYWtl
cyB0aGUgY29kZSBtb3JlCj4+PiByZWFkYWJsZS4KPj4+Cj4+PiBGaXhlczogYzVhNWNkM2QzMjE3
ICgidmRwYS9tbHg1OiBTdXBwb3J0IGNvbmZpZ3VyaW5nIG1heCBkYXRhIHZpcnRxdWV1ZSIpCj4+
PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+IC0tLQo+Pj4g
ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTIgKysrKysrKystLS0tCj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4K
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+IGluZGV4IDllYWNmZGI0ODQzNC4uYjUz
NjAzZDk0MDgyIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+IEBAIC0x
MjQ2LDggKzEyNDYsNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV9ycXQoc3RydWN0IG1seDVfdmRwYV9u
ZXQgKm5kZXYpCj4+PiAgICAJaWYgKCEobmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzICYgQklU
X1VMTChWSVJUSU9fTkVUX0ZfTVEpKSkKPj4+ICAgIAkJbnVtID0gMTsKPj4+ICAgIAllbHNlCj4+
PiAtCQludW0gPSBtbHg1dmRwYTE2X3RvX2NwdSgmbmRldi0+bXZkZXYsCj4+PiAtCQkJCQluZGV2
LT5jb25maWcubWF4X3ZpcnRxdWV1ZV9wYWlycyk7Cj4+PiArCQludW0gPSBuZGV2LT5jdXJfbnVt
X3ZxcyAvIDI7Cj4+IE5pdDogdGhlIGlmIGJyYW5jaCBjYW4gYmUgY29uc29saWRhdGVkCj4+Cj4+
PiAgICAJbWF4X3JxdCA9IG1pbl90KGludCwgcm91bmR1cF9wb3dfb2ZfdHdvKG51bSksCj4+PiAg
ICAJCQkxIDw8IE1MWDVfQ0FQX0dFTihuZGV2LT5tdmRldi5tZGV2LCBsb2dfbWF4X3JxdF9zaXpl
KSk7Cj4+PiBAQCAtMTk4Myw2ICsxOTgyLDExIEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF9k
cml2ZXJfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4+
PiAgICAJCXJldHVybiBlcnI7Cj4+PiAgICAJbmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0g
ZmVhdHVyZXMgJiBuZGV2LT5tdmRldi5tbHhfZmVhdHVyZXM7Cj4+PiArCWlmIChuZGV2LT5tdmRl
di5hY3R1YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9NUSkpCj4+PiArCQluZGV2
LT5jdXJfbnVtX3ZxcyA9IDIgKiBtbHg1dmRwYTE2X3RvX2NwdShtdmRldiwgbmRldi0+Y29uZmln
Lm1heF92aXJ0cXVldWVfcGFpcnMpOwo+PiBIbW1tLCBub3QgdGhpcyBwYXRjaCwgYnV0IHRoZXJl
IHNob3VsZCd2ZSBiZWVuIHZhbGlkYXRpb24gZG9uZSBpbiB0aGUgdXBwZXIKPj4gbGF5ZXIgdG8g
Z3VhcmFudGVlIHNldF9mZWF0dWVycygpIGZvciBWSVJUSU9fTkVUX0ZfTVEgYWx3YXlzIGNvbWVz
IHdpdGgKPj4gVklSVElPX05FVF9GX0NUUkxfVlEuIE1heWJlIGNoZWNraW5nIGJvdGg6IEJJVF9V
TEwoVklSVElPX05FVF9GX01RKSB8Cj4+IEJJVF9VTEwoVklSVElPX05FVF9GX0NUUkxfVlEpPwo+
IE5vdCBzdXJlIEkgZm9sbG93LiBJdCdzIHZhbGlkIHRvIGhhdmUgb25seSBDVFJMX1ZRIGZlYXR1
cmUgYnV0IG5vdCBNUS4KPiBJbiB0aGF0IGNhc2Ugd2Ugc2hvdWxkIGhhdmUgb25seSB0d28gZGF0
YSBWUXMgYnV0IHRoZW4gY3VyX251bV92cXMgd291bGQKPiBiZSBzZXQgdG8gd2hhdGV2ZXIgd2Fz
IGNvbmZpZ3VyZWQgYnkgdGhlIHVzZXIgd2hpY2ggY291bGQgbW9yZSB0aGFuIDIuCkluIHRoYXQg
Y2FzZSAoQ1RSTF9WUSAmJiAhTVEpLCBpdCB3aWxsIGVuZCB1cCB3aXRoIGp1c3QgdHdvIGRhdGEg
VlFzIAoocGx1cyBvbmUgY29udHJvbCBxdWV1ZSB3aGljaCBpcyBub3QgYWNjb3VudGVkIGluICdl
dGh0b29sIC1sJykgCm5lZ290aWF0ZWQuIFRoZXJlIHNob3VsZCBiZSBzb21lIHZhbGlkYXRpb24g
aW4gaGFuZGxlX2N0cmxfbXEgdG8gCmRpc2FsbG93IHVzZXIgZnJvbSBjb25maWd1cmluZyBtb3Jl
IHRoYW4gMiBkYXRhIFZRcyBmb3IgdGhhdCBjYXNlLiBZb3UgCmRvbid0IG5lZWQgdG8gd29ycnkg
dG9vIG11Y2ggZm9yIHRoYXQgYXQgdGhlIG1vbWVudCwgSSdsbCBwb3N0IGEgcGF0Y2jCoCAKZm9s
bG93aW5nIHlvdXIgc2VyaWVzIHRvIGZpeCBpdC4gTGV0J3Mga2VlcCBpdCBzaW1wbGUgZm9yIGp1
c3QgY2hlY2tpbmcgCmJvdGggQklUX1VMTChWSVJUSU9fTkVUX0ZfTVEpIHwgQklUX1VMTChWSVJU
SU9fTkVUX0ZfQ1RSTF9WUSkgdG9nZXRoZXIuCgpUaGFua3MsCi1TaXdlaQoKPgo+PiBvdGhlcndp
c2UgaXQgbG9va3MgZ29vZCB0byBtZS4KPj4KPj4gUmV2aWV3ZWQtYnk6IFNpLVdlaSBMaXU8c2kt
d2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4gKwllbHNlCj4+PiArCQluZGV2LT5jdXJfbnVtX3ZxcyA9
IDI7Cj4+PiArCj4+PiAgICAJdXBkYXRlX2N2cV9pbmZvKG12ZGV2KTsKPj4+ICAgIAlyZXR1cm4g
ZXJyOwo+Pj4gICAgfQo+Pj4gQEAgLTIyMzMsNiArMjIzNyw3IEBAIHN0YXRpYyBpbnQgbWx4NV92
ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4+ICAgIAljbGVhcl92cXNfcmVh
ZHkobmRldik7Cj4+PiAgICAJbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoJm5kZXYtPm12ZGV2KTsKPj4+
ICAgIAluZGV2LT5tdmRldi5zdGF0dXMgPSAwOwo+Pj4gKwluZGV2LT5jdXJfbnVtX3ZxcyA9IDA7
Cj4+PiAgICAJbWVtc2V0KG5kZXYtPmV2ZW50X2NicywgMCwgc2l6ZW9mKCpuZGV2LT5ldmVudF9j
YnMpICogKG12ZGV2LT5tYXhfdnFzICsgMSkpOwo+Pj4gICAgCW5kZXYtPm12ZGV2LmFjdHVhbF9m
ZWF0dXJlcyA9IDA7Cj4+PiAgICAJKyttdmRldi0+Z2VuZXJhdGlvbjsKPj4+IEBAIC0yNjQxLDkg
KzI2NDYsOCBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRf
ZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4+PiAgICAJbmRldi0+bmIubm90aWZpZXJf
Y2FsbCA9IGV2ZW50X2hhbmRsZXI7Cj4+PiAgICAJbWx4NV9ub3RpZmllcl9yZWdpc3RlcihtZGV2
LCAmbmRldi0+bmIpOwo+Pj4gLQluZGV2LT5jdXJfbnVtX3ZxcyA9IDIgKiBtbHg1X3ZkcGFfbWF4
X3FwcyhtYXhfdnFzKTsKPj4+ICAgIAltdmRldi0+dmRldi5tZGV2ID0gJm1ndGRldi0+bWd0ZGV2
Owo+Pj4gLQllcnIgPSBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoJm12ZGV2LT52ZGV2LCBuZGV2LT5j
dXJfbnVtX3ZxcyArIDEpOwo+Pj4gKwllcnIgPSBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoJm12ZGV2
LT52ZGV2LCAyICogbWx4NV92ZHBhX21heF9xcHMobWF4X3ZxcykgKyAxKTsKPj4+ICAgIAlpZiAo
ZXJyKQo+Pj4gICAgCQlnb3RvIGVycl9yZWc7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
