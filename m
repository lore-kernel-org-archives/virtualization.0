Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9454EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 02:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D74560E61;
	Tue, 11 Jan 2022 02:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KyDaH7Sqwcs0; Tue, 11 Jan 2022 02:02:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8C09A60D6B;
	Tue, 11 Jan 2022 02:02:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 413F4C002F;
	Tue, 11 Jan 2022 02:02:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 957E6C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CEDB83077
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="biTzlnu4";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="jDMJao3e"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AzhVu9ry2SA2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:02:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B2E683004
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:02:42 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B0KDiG007285; 
 Tue, 11 Jan 2022 02:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wDKEc1+NTEibj6iDIyBacVaP13MAP5LEAaFv+KpGfHo=;
 b=biTzlnu4GEXYPWO5gFWNYsjtTuYNiJGcu6+J9HTn+ea1ll1uMWJx1mOQQ18TNrdPOSRH
 vYFrLFYnFs75lhhf3PXlBQ244HbPDLkPTLR8eqRwKiHopgyIksDghqlQF1uBabuYtn/i
 MiiMiafgzTY72I5pT1OiROc8LlR1YM3DcnElzGMvvY/QkozCLJwh9c/0GlW4YAsPRTYF
 7d6bE/Wd3EWgd/vohjUTcc2dpA707ig5fxIBAt6JaabuiEQr6kmMSpXSGd+9h7Tr1O45
 P5mzHWQe1oPrFh1svgBVOpgyW7Rxt6A9d3D+UbfyKLg2ICbHs9NkObdje1+MTsuLJpWU 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx1ycx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 02:02:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B1a6EI121944;
 Tue, 11 Jan 2022 02:02:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
 by userp3030.oracle.com with ESMTP id 3deyqwbg7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jan 2022 02:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL3zf9qmmEQKirb49swL6PR7Wx7kxDHS1zRyoLp8A3kvpVvJrG5alSY0pNnhJ4JbVkll8pHP+kP1SJyPagvL+mHrnXdoPOjwLREcsnyKaeiABtjTtr1XE1xP+OgcQ8bEJkoxaecZ1X8NiaNZUMNwzBYBXivBK4t/izmHVSQtJO8VkV4c4426rW0tkkNV71whgkiGATTc30oiLys4h1p0C6R2uSGz03mqKJMjtJf3Nx0n7mIgdN80U1TSNhhA8oeQgp4NgegX4yt1HRnnkm10SZ49DhEHUzlJPXGipFfN08L8vVAbat7pNgWIPeq0nEMAAnMPpIIinGcBjcDsjgo75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDKEc1+NTEibj6iDIyBacVaP13MAP5LEAaFv+KpGfHo=;
 b=C43RkxkOdT1cy/QWxTEAjSPTEgGI7RS7mzYZlCQ1aJC7XDnwUPXsMaUtndFthOpQod2KcdOcHazDtZ8bnBw3dJoHe629Odod3OL7wsUcdHHkgYuCY1EoufXa5I6QmiMNU6IqRENXCtOYIbcBAfVUf0a7gNZepHBMjzBpzGUxQgbrm2v9fzOaw1sdeaQCyw3GTjMNLoZi0QICDb3QLcUHoM06LUhr1JupUxdS/cxJpNGdx0IuklQjHoNjA07eIXM+J53VJoTHU3vtR5ARm8XJmL59s6T6L+j8oX27es0f0g3iZ16o8Y1f14TgzTBMCCXSBTAt+PJ8rMNnMAPo965Jhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDKEc1+NTEibj6iDIyBacVaP13MAP5LEAaFv+KpGfHo=;
 b=jDMJao3er/xj3uxjtHPSIHO1dseJeJID5c2i0clzzd8JM3KQaD4nxWvTfJ1j8VczioiV5RSpuf9tWz6NXDS6TD5yo4DZkUPU21viOMEFXBsSL+N9/RwCb+YOSOoYirk1bfR52hlcgEOFhqT60UvrbPyxSgE6zWGrYEj2GHXVPUk=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BY5PR10MB4324.namprd10.prod.outlook.com (2603:10b6:a03:205::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 02:02:37 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::2939:d1bd:67c8:4f25%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 02:02:37 +0000
Message-ID: <a6e11689-7b6b-a1c6-2de4-d9f220cd3f16@oracle.com>
Date: Mon, 10 Jan 2022 18:02:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v7 00/14] Allow for configuring max number of virtqueue
 pairs
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20220105114646.577224-1-elic@nvidia.com>
 <20220110020122-mutt-send-email-mst@kernel.org>
 <20220110074958.GA105688@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220110074958.GA105688@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SA9PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:806:21::8) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd34262f-c455-452e-229c-08d9d4a6710b
X-MS-TrafficTypeDiagnostic: BY5PR10MB4324:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4324DE7A0360FEFF213611E7B1519@BY5PR10MB4324.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8azTrWtdZ6x2+JBWRxSG3+f6Q8kchjSf7m9CiLQCSw0Jy4BjJVSq/87X3lAInotEllu7hvnsW0nC/Ljce7PDpuu2Qkv43g5CWIkJdWcIIGrrlzLEUAVl6lDwmllHdNv3MNThfbe4ViN41Rsl9l+fRjbJlKAI9OC0UFOFW7LNDSrpl4ZvK2dU+deum7DzKzcF2lvZfFbX0J7Mu4EnjWpSJEb+XltObt2oDkDrkfPlBKNJs2Gap9SMKb8uAso8yZ5WTtvF7uAaO2jEgjsduDB3OT74YK+TcWlcWzr8f6birHc5NG1hUA4HQ5VnG4gdtlSdSASoGaCpNLKabYM5bWfKX+wBToS905VK2TWFjt4ws3Eh34KE58OHm+8iOKPm+tzxmgE1k5y8Ff0gT8NWe+OIApnEREEaSsjJeyyr30fPshDH5Wk1RSHYP0NCqVjwF+wH6FvLwsbjnVFOs+x8xSu+ux1KOHB0f+srxuflxwgjna2RP3FYkPgBbam1cejqmkkz1ktRk/cSfkjHoYdW46YvHp8AC5GARVJZoeV4YOtL7h1HEEdRtcRAPolRv0u2A3ob7u0v/dQCj8EG7YDbm0TgLHu9WDrEY8UTROiYspEsZgel07xijRcqnV3zzU54nX9iIy4m8RMjJo/7YIR+/7uqWb6WHxBiLzOaHvPWyVeYyhSF2/QeNwhE1WCPD1xOlJC6eAV1jENbaww5OspLkE+tdJpYO6LpULii0HXwy/T3T7RRoRB6kcw1/6cyDcK8fcR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(36756003)(186003)(31686004)(38100700002)(2616005)(31696002)(6486002)(36916002)(6506007)(53546011)(26005)(8936002)(4326008)(8676002)(508600001)(6512007)(2906002)(86362001)(6666004)(5660300002)(66556008)(66476007)(316002)(110136005)(66946007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhOYzRFOEhkcjB1QlpTaFpsRjNaK1JVSGNqL3psSmlCMkZsaSt5Z1ZMQjBz?=
 =?utf-8?B?Q1JJTGplN3I2T2dsS1N4dy8xbjR4Ynp0WTZJek5ETVFvSDlkR0ZDdXZOaVYr?=
 =?utf-8?B?eENpSjJlRWpnRm01eXdWa1pEK2tKb1IrenNDdFVZak1RcVFVUmV5YkdEYWFL?=
 =?utf-8?B?WlowTnRBbVB0ckVZRHZibVNTVEJRYzlWQXd3QlhmeTNBb3UzQU13dVl1RExS?=
 =?utf-8?B?c3hsME4vT3F4bmZqNFlMSXdMbEhCWXRnL1l1RzZBaDBDVU96TDZqemMrblpk?=
 =?utf-8?B?eVlBNWZFVEJ1Nm1xU2twS1M0WXIyV3ExMkJMc3V5NUdoQ2lHcFRvU1FJanJa?=
 =?utf-8?B?VlEvY2lqMXNjYWMxa1BYbnRlSThpS0wzUzdBN215cWx0cDVLaWIrK2Qrc0pm?=
 =?utf-8?B?Y3AyUUg3RUxmT0I4MERLTHpLUXEzQVB1cFg5c0VKVjljUEl4VVRIaVBHWXpK?=
 =?utf-8?B?MlQ4NEFtaEFTSG1kR1BDUXZtRk9jZlR5OGZFNHZzd2xzb3BReTlOcGVZWm9n?=
 =?utf-8?B?cVd5WlVqTWYxczJLek1EdXNhWVFkUXZncTNGOXU0c2Z3QUlZclBFdDdjU29x?=
 =?utf-8?B?ZEVyU1p0OUhQRzYrSi9ZRis4N3M5aUU2eHdlVXJ0aElVdVErZDUzR1JneitR?=
 =?utf-8?B?akFENGI1Z0s1MmJaZWJBNzJvZjRRdU1sVGF3RkxtNTl1TzhaTTJnTi9vd3ly?=
 =?utf-8?B?eGd4ZWEwRmhFRmpLZklTUHpFdUVDbzNvcEFKaTNjRk9UUG90NWxxcHRNZW5w?=
 =?utf-8?B?UThwdVZNaTBYT01paE0xWVViUlBqMGJRcFhISEpmWWpOTFV0djIrZzdwVWtw?=
 =?utf-8?B?b3g1WGFoa2ZiREZWVm5nb1pDbEJGdU1OaGFwUnAvbEdQOTRTVUUrekppbFpV?=
 =?utf-8?B?cS9iYjM1Y3l2TzdYSmZkdjdFZjA2QXhFWVZUR1NiOTYwbEh5bldiTnZaVDVi?=
 =?utf-8?B?S0hBNkxvbU9lTWVYbjBLN2VNclR1N0J5djNiR3B2NGd1VXBnNkhrNlh4K1FT?=
 =?utf-8?B?d1VOR0VwdXppQTZxOGpLaVpva3FLbE1vRFVORUhuVXNUYU1OOEkzYWdSWFhN?=
 =?utf-8?B?Vm1pSC82b0NIdTY1V0tmdG0vK2N6ZlNZNkVBcW1pM0dDaWY4S25BK3BvcDhl?=
 =?utf-8?B?OWxnRjFNZS9iNU80NkFlVC9lMWo5clBkMmtDQVhxSWNXcTc3aGtrTjNqVVBG?=
 =?utf-8?B?Q2ZoTXEyTlhiOXdHUUNrUHVKZkt2bHRwbDVibW1sZXI2dXNWMVA5aml0NmxO?=
 =?utf-8?B?eXlZMVhqRWNZM25ra3cxTEdTazM3NXNUK3liQXJVNUErN0dOT2VCWlpSZ0FB?=
 =?utf-8?B?Z3l5N2QvNUpDQjZqSXQ4dzlpdFV1VGYrY0ZheDRwSkNEZmNLcGZmeTZiU3Vv?=
 =?utf-8?B?TENmN0lONHNiV2doalRVY2RCU0pqZTQza2FlL2tTMHh3ZGt6aHdXL1dhUHdY?=
 =?utf-8?B?Y2F4M240VkxwM3ZHclFObTFaaThtVWxhSTF3UkxHb2NRd2dGaDVrM0pGU3JU?=
 =?utf-8?B?MVBPQXBqcUZMRjc1SGtQVlN3dmtJNzY2R1Jlcm5IanBBMzVaQWxIN0FYaUls?=
 =?utf-8?B?SnZudjlZaDZpb2ZDNFJVVHVEYStBcHEyYUxCQlNrUGpaRFBZQVNzSGxqS0xS?=
 =?utf-8?B?U3UxYkh3UFhrakF2RTd3ZFRsU29DRUVNUVZnYnhKWGZMYXJlclRDL0haYUVW?=
 =?utf-8?B?b2dJQTd3L1RwdDJVeDV6ZmQzbE9wS0IzNTloc1VtTnpnNFhqcHlUQ2NCMG5v?=
 =?utf-8?B?eWFtNUs2cmw3TTVyeTYycjR5ZnZ6OUlZN3RiYzcxT0hUZDd0QmRYcmFya0VP?=
 =?utf-8?B?OUthR21nOFJXREhiTW85S0p0VTZnQ0N6RmtORGttL28rZ2JlRmFNK21ZdUtT?=
 =?utf-8?B?YmVIcmNOSUtXOEl6UEY2UXp5cXYvMThWOVhSREhzdmJTZ0RwSitLWHZnYStQ?=
 =?utf-8?B?YTZUZDJHcVlXeFZ1VS9Ia05BbUgyQStTN29CV0R4SWQyRVR4cCtyU3JWZ0Ra?=
 =?utf-8?B?R0hOa0FpY1VhR0tYd3ZIQjYrTTNndWhrOXJ1RytVNUhQOVdZUjMwU0s2dmlU?=
 =?utf-8?B?RDFWMklEdjRYQWtKVHBjRmpXQ2ZIakd3T0l0MFY3em54bzg1bDlQWi9FM3N5?=
 =?utf-8?B?UncxdzYzT25WOWcwMjFNNFZ4QzBVRGNhSmloWlYvMEhZVnNUYkd2VU1ISDg0?=
 =?utf-8?Q?kcq5R3IpVCE3m+0n5vIKxAE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd34262f-c455-452e-229c-08d9d4a6710b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 02:02:37.7569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQ+hIvvX0jBtSvCgGmREb27RzrdNumw0LslzvzJFTykQ8HKm2K50yiNMF7zikXEWygvNx8Ywi9lb4lQyFtN6Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4324
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110003
X-Proofpoint-GUID: gTjpr-PNv3R20M8w3dsfJFWAtjzeyFMn
X-Proofpoint-ORIG-GUID: gTjpr-PNv3R20M8w3dsfJFWAtjzeyFMn
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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



On 1/9/2022 11:49 PM, Eli Cohen wrote:
> On Mon, Jan 10, 2022 at 02:04:32AM -0500, Michael S. Tsirkin wrote:
>> On Wed, Jan 05, 2022 at 01:46:32PM +0200, Eli Cohen wrote:
>>> Allow the user to configure the max number of virtqueue pairs for a vdpa
>>> instance. The user can then control the actual number of virtqueue pairs
>>> using ethtool.
>> So I put a version of this in linux-next, but I had to squash in
>> some bugfixes, and resolve some conflicts. Eli, please take a look
>> and let me know whether it looks sane. If not pls post a new
>> version.
> I see you squashed two fixes.
> There was one more comment from Si-Wei which I addressed by sending a
> distinct patch titled "vdpa: Protect vdpa reset with cf_mutex".
Sorry, but I did not see this new patch that addressed reset. Please 
copy me when you get it (re-)posted.

-Siwei


>
> It was not reviewed yet but maybe you can squash it on patch 0005 after
> it has been reviewed.
>
>> Jason, what is your take on merging this now? Si-wei here seems to want
>> to defer, but OTOH it's up to v7 already, most patches are acked and
>> most comments look like minor improvement suggestions to me.
>>
>>> Example, set number of VQPs to 2:
>>> $ ethtool -L ens1 combined 2
>>>
>>> A user can check the max supported virtqueues for a management device by
>>> running:
>>>
>>> $ $ vdpa mgmtdev show
>>>      auxiliary/mlx5_core.sf.1:
>>>        supported_classes net
>>>        max_supported_vqs 257
>>>        dev_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ MQ \
>>>                     CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>>>
>>> and refer to this value when adding a device.
>>>
>>> To create a device with a max of 5 VQPs:
>>> vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5
>>>
>>> Please note that for patches that were changed I removed "Reviewed-by"
>>> and "Acked-by".
>>>
>>> v6 -> v7:
>>> 1. Make use of cf_mutex for serializing netlink set/get with other
>>> calls.
>>> 2. Some fixes (See in each patch)
>>> 3. Add patch for vdpa_sim to report supported features
>>> 4. "Reviewed-by" and "Acked-by" removed from patch 0007 since it had
>>> slightly changed.
>>>
>>> Eli Cohen (14):
>>>    vdpa: Provide interface to read driver features
>>>    vdpa/mlx5: Distribute RX virtqueues in RQT object
>>>    vdpa: Sync calls set/get config/status with cf_mutex
>>>    vdpa: Read device configuration only if FEATURES_OK
>>>    vdpa: Allow to configure max data virtqueues
>>>    vdpa/mlx5: Fix config_attr_mask assignment
>>>    vdpa/mlx5: Support configuring max data virtqueue
>>>    vdpa: Add support for returning device configuration information
>>>    vdpa/mlx5: Restore cur_num_vqs in case of failure in change_num_qps()
>>>    vdpa: Support reporting max device capabilities
>>>    vdpa/mlx5: Report max device capabilities
>>>    vdpa/vdpa_sim: Configure max supported virtqueues
>>>    vdpa: Use BIT_ULL for bit operations
>>>    vdpa/vdpa_sim_net: Report max device capabilities
>>>
>>>   drivers/vdpa/alibaba/eni_vdpa.c      |  16 +++-
>>>   drivers/vdpa/ifcvf/ifcvf_main.c      |  16 +++-
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c    | 134 ++++++++++++++++-----------
>>>   drivers/vdpa/vdpa.c                  | 100 ++++++++++++++++----
>>>   drivers/vdpa/vdpa_sim/vdpa_sim.c     |  21 +++--
>>>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   2 +
>>>   drivers/vdpa/vdpa_user/vduse_dev.c   |  16 +++-
>>>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  16 +++-
>>>   drivers/vhost/vdpa.c                 |  11 +--
>>>   drivers/virtio/virtio_vdpa.c         |   7 +-
>>>   include/linux/vdpa.h                 |  36 +++++--
>>>   include/uapi/linux/vdpa.h            |   6 ++
>>>   12 files changed, 271 insertions(+), 110 deletions(-)
>>>
>>> -- 
>>> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
