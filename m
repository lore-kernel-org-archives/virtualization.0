Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C8CDB474
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 01:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B604941ED2;
	Wed, 18 Oct 2023 01:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B604941ED2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=1s3r14YT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36DwIZN5zduF; Wed, 18 Oct 2023 01:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE7AF41D9C;
	Wed, 18 Oct 2023 01:06:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE7AF41D9C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A52C6C0072;
	Wed, 18 Oct 2023 01:06:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65D70C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 01:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3544E40273
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 01:06:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3544E40273
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com
 header.a=rsa-sha256 header.s=TM-DKIM-20210503141657 header.b=1s3r14YT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0rz4tiGNzY_u
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 01:06:26 +0000 (UTC)
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu
 [18.185.115.25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44089400CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 01:06:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44089400CE
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.187.19])
 by repost01.tmes.trendmicro.eu (Postfix) with SMTP id A993C100004F5;
 Wed, 18 Oct 2023 01:06:23 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1697591182.581000
X-TM-MAIL-UUID: 557525c0-dffe-4ecd-a061-c9d39afa9af1
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown
 [104.47.7.169])
 by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id
 8E1A6100010CE; Wed, 18 Oct 2023 01:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzd6TuKCP9ja7swjkDrcN18qOb4ZRC5oFeXKN8J7CXh40cx8BpQxxzWDQ5Jmp1tA0OB/arBI6c5Eho0sHd+eQ6qSl0ZelekCaKoEz6WswzpAyA9FzykpsFjCrvSeHz12RlSpP1fIM9YO0QOOGRfHtDORpgzQtT10xl6gHYhv1dXzbVzRIUMQXVhKCPqPKbNTArcUdIqaG+hesor0gJwMCw9hTdJLeRVYbCkPMlCy7AVUhlvJJrL8OPZ9X6Sk+rkCNQ2KB7wFBcVwUNf3JQO5f8lE9773UQjnCrcynEgqyE6qn+sGfe5BjNj6vibQjS94z611Zd5qGEBLViuMtunojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq5FZgTVfjRVIE1Cjh6KU6dt7v+5CbRIL9SYhL5CW5w=;
 b=bJB3N2eQXfq1fhziJnuMfzi3ld8rDz06TT44kKFlmWV+VbX7e6rkUyGsp6KWKmKQ8PuSToHFHRWuKfiHrN6hw9gwHd/ivxKWBCCcKEdIjrG29/FMKsOOD6FQHiRZIQkWFrEP5vQf0pKMpDqamlIJhHC6oka79kLHMvAd+vXmXRyevwceRFKE8ASajbl1yr8e6DtialAe3szrjgViWsfgeTHkrH5iTGCJ+P3hVibNnEou03LFjAPwdsYJcSXuG0l5RjlfLq/xC/vbayQHfDK37kdrRP8D+gWNRsyUZAa/bBccGpDEIOoMgr4JjGci/jG6zgzdAuq/Ei/Rh0RcUQIR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <1a54feab-5de9-4b39-a4ce-7ff22e23cf52@opensynergy.com>
Date: Wed, 18 Oct 2023 10:06:05 +0900
Subject: Re: virtio-sound: release control request clarification
Content-Language: en-US
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <ZS6mA6/EsmvDVlTC@fedora>
In-Reply-To: <ZS6mA6/EsmvDVlTC@fedora>
X-ClientProxiedBy: BE1P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::14) To FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:22::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR0P281MB2382:EE_|BEZP281MB2390:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d834c5-a7cd-472a-68f6-08dbcf7670cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vlL8iUqsiyRlLFmLvljUn8zZEu87EBwCJfP3YgpQgA7sav5n0O1+StkURGrwgKCqwI7s9NRw80l5sg8dFHZ0JYDVN+ow/Jn3eLiwa9PGwV9iPEv1kqA7oyhNag4PZMQf+Xv9XGKq5PVTvED/rs0xJZVO0IP3PV0MQHvuyrWT4QFxWFxBIJTBwIT6icjF8w1+4RbzD31gBUisFSP4wEUzYmGzIJ99Q0UoDPRRYWOgDFJdeoEyP6P46XZSAERyQp6QMqrsucKg1I1jSMm9qTeBAQyi17k1k1XZj+azZ3GVoQS1TtmblPmqNZOcrs03KREJWDh/CjqQdmdLAtwtIHctljriRHgDnZ54l7w31xUMXHvfYooEMkVz4LlqiBTnQBqXWKQwr7IvLcrij7n28acqzFe3d7E25O+zXnO9aEbSM/M93epmjFU/yb1SgaFF958HH56KrHgNtv/Jo6MeIMdS0p7ktG8xH/GdQzesT0T85w6QFSkimEu1ju+yGkOikzNReBD0Qrz4b6rt0suEwW1wpOBYNnXmuylpap+rhE5dKM0mnX9et93bCogPcwAKe6x0leqbNOslTiaL6YhB0UnDSOqJ1amERlKskF+sRmBua7yoqIicGJnFoDBHwDp6uH/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39840400004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(478600001)(966005)(83380400001)(2616005)(42186006)(2906002)(41300700001)(8936002)(8676002)(66946007)(66476007)(66556008)(5660300002)(4326008)(44832011)(316002)(36756003)(31696002)(86362001)(38100700002)(26005)(31686004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUM2TUZ6WUhUcEtjd2RUYXZqOUg3VnJHakN2YzBBanFaeEs0bTZYcThzdG83?=
 =?utf-8?B?eXFJa3lFdDBvOWt6L1ZzZit2WFpuY21SKzh3TEgrS25zNnVtWHpyWkZ3aVRD?=
 =?utf-8?B?dDNuaHFXUEE1Q2hKK0t5VDB0bTZlSFhtOTVETGI3N3lPSytkQTRrMDdvNytV?=
 =?utf-8?B?SXZMNi9rTjcxKzdDemI1a21CQkhOZjhZUUkwWWJpTlVlRWlkYVVYSWEwRFhn?=
 =?utf-8?B?NWJOQXBoNFU0cGd0ZnhTcndta2EyTDZuVjBpYkRobUFKMjN4bnFUQ0ZEUEQw?=
 =?utf-8?B?RzZLVUlrbXBiYTR5V2tjb2VkQXlCc1VMNi93WkRxV3dpeW9sUDlRb2k4a2Ju?=
 =?utf-8?B?SXUzWUZPQnd0dWJLLy8rOGFFRlhBdGFGSFd5WFpDbFFFVTEyZmdCcDhybDBW?=
 =?utf-8?B?eFdDa3c0cGNLRDg1dmVJZWNpZ0NwNnRkL3ZRSjBLKzhzZi9JcFk2eFc5RmNh?=
 =?utf-8?B?a1doMGZYL0NDOWdVdjhKcDRwcUs1Z2ljV000ditUUTRWZVZNU1BESDZTLzdS?=
 =?utf-8?B?aW5GVTdGT0VOdG1lQzdMbFBsc0xOcHk2Z0ZmekxrZHAxMlNhbFVXMmpFalhS?=
 =?utf-8?B?SmdNcW4vYUtTVHJUQzNvSkhlTFBxYURaZitINnYxQlloWkdiWTdZZkszcUlj?=
 =?utf-8?B?aHdTSWFkSmsrVWR1SkszR1BpNDlyNk9DSWlZeWVpVno5ak84Mm83TnpJbExC?=
 =?utf-8?B?aUlkb1dUa3NFcnNBeXRDZHM3WFk4NzJqQjNqZmNzcENVWmRYbEhOR1NnOGtR?=
 =?utf-8?B?bGtiZmhZd0dwRlN1R3JWaCtPcS91WXQ5eW1qM3VxK2xlZWFOckIrUkplaGpH?=
 =?utf-8?B?emNQMnExbGo1V2h2QUhZRkpnaUVKQ0lwWm9kMjRzVmtSSmltbGVNVTBYTnM2?=
 =?utf-8?B?M096aG05YkhrUEtYWCt2NWp1TGVaTkU3M25GWXJLRlFMQmFQUVFwbXBEczJG?=
 =?utf-8?B?UUNOUVJIamZMQTI5a3RCYkdVRGdWV09qM3FNMStkMUVIdFREeWVUbWR5QUhp?=
 =?utf-8?B?L2pIZFE1T25UaDIyU3lXYkc4YitqeStUYU1mSUsxaXh6bTZXKzRobHB2Q2Vz?=
 =?utf-8?B?dHViYTNkTVMzZlFZWjdzYzJQYXZOSjFLNTdvanpMNFpqZnlDUm9TWXlhWjZn?=
 =?utf-8?B?bFRENG0xdWZRbEFDcFE1MWRaZmkwK3BncVp6Nk9vNDRyVnJwTDFHay9hei90?=
 =?utf-8?B?OFp5ZHZmMGxSaHNmME0yVjM2dDduOUplZzM0NHBGaXNjdmp1eU0veFE4aDc1?=
 =?utf-8?B?QzdTOGFCcktMejc5V1lSNEkxUVAwZTFYZmttQnUyaWh1NHQ4QkFieVNLSFpC?=
 =?utf-8?B?cmxhSU5MWG1SbjdncnovdVo1RXFKUUtLQWdYNjNaeHMrT1dzMFZIU3Nka1pX?=
 =?utf-8?B?VElGTmdzMGNSQ2Vaajl0bjlBeGk4cEh4RGl3dHdlN0tyRkFqY2tsVnBrV3Uw?=
 =?utf-8?B?SmZueGc5Y2NQVTc5VVFwd1ExNG4xWDNOUmJyelJjcm5oWE5QOGYyVnJBSmhL?=
 =?utf-8?B?cjZYNkEzcGs1MlpqWUxaN2t2OFZFdkFkalQzRnFOcGg3WllsN1VMaG9ETnRp?=
 =?utf-8?B?NFVDaUlYZWZzME9PUGVCa0ZYbEV4NlhjTGdvbW0zZUcyWU9nenZvbm1sdDhQ?=
 =?utf-8?B?VVRlRnROU3FvOU9JMkFFZ0JHVmlRc085WmMvZ2NvakRiVXpxcHFleGUrZGZ5?=
 =?utf-8?B?Zm9uSDZBdWVKOHFQMGJhZjN1R3F6ejNUR0lmVmRodDBHU3g2ZHdJSWdFNU00?=
 =?utf-8?B?TW5IMi9rL2QxN0hydlErYUVhd21tZjFGemtEL0NTL1dUVDNLZHB0VG9KeS9n?=
 =?utf-8?B?V0VjaTBreTZMWGJLMWw3U2NiZFVlZnVMNGNwblBOQWpFM1hlWkdtM1ROa2VT?=
 =?utf-8?B?VU9OTmZDelBvek55YUk5ajJxbXY5VFdhdWpQL0hZS0FYUDcwRGRSNTY4eDdp?=
 =?utf-8?B?Rlk2Mm91RUREV2dqcEVWSm91VWY2bEVqVjNkUTFvdDRzR1dNUTdBMkkwYnV1?=
 =?utf-8?B?eHZsNUlSM3hzMklNbFNmakMzOUJVOVZhUWppQytWUzB4R2lzMkh2eUZ4RkNM?=
 =?utf-8?B?MWJJSWFicmRKaFh3byt6WUxVakxTZFd1QWJ4MEllc2cvbGtTMU9Tb3FYUVlU?=
 =?utf-8?Q?ngrf2KDjfYynH3Arp/CbIOx1d?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d834c5-a7cd-472a-68f6-08dbcf7670cb
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2382.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 01:06:20.9430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9U0HfcIWgKzcEZqIgW3gzIaRGRZV2iTDlfy9F1djMRlYBiA1WzINqEtHKaxduudghxJThWsbUTObsVe/9djlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2390
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27942.003
X-TMASE-Result: 10--23.246000-4.000000
X-TMASE-MatchedRID: C/snMIRQLS1TzAVQ78TKJRhvdi92BBAuMKBMviil9LKKMQwAakyaVyMy
 182qkOvS4oxXoEV1CmSIGwa8HKVS+zEo/j9IWJ0hgeiGYvM7ol7yQ6dAmPdzEg/vgpq6rRaAX4n
 1oiCc8om+VUvWDdd5wwukPjTxMOtXI4c3C+5nuZ2K7q7iyFn58b6JFLmgip31l2KBmLXt0eq3k4
 kdd7zhZFwMy5GGxrdrK2RhJ2Wdc2AUm1NPF16gQjfKfE3iPHU3VhKZogdsCNvKAd0YkM9ab7RvS
 IF4L27/qY1FFaUQdQWq+oRn9TlAHE3CnMPBXN22H7WbjGX5tklCKdqcEPNeCwJbjXe6/CO3OAwx
 jOvsJG3aJrCAW8AFlNOJtkUhH1HpfxxKoPpscnOHSpOq1C5m8FbWfhsdMehBo1QwDrAdWsqOLfK
 nBtebPoGwjJO9Z+9p6xA0Ava73nAPm15xyht8lcTvQx6Ny2Cru55PhDswmTUKP+E/IoeAkjcabh
 krpnaCv9rSd36EgUI+Mqg+CyrtwA==
X-TMASE-XGENCLOUD: 7553c3ab-7ae8-445e-bfa3-08311f32a93a-0-0-200-0
X-TM-Deliver-Signature: AED24FFB4B914A1EB02EAF898552E59C
X-TM-Addin-Auth: aVwFb155ygBMvYjy9AAcnH5fsztuzpzOPDrxHvU75gDl647Arz+Q23e39I5
 foS57EDPE3qLKSZlIt9LrzqvNxIfHneA//apKzEQa3A2g/1qZNr9ope/efo5zR51O27nbcYei91
 4qHbF+QURTgzBWEWs6UcbUkPnhEswYi33sJY0CIZGpHN8F1Nrt2ePdCAnH8HWeE7EeHo/3rhJt+
 t/6bIVvXH3TB6p7MQ2/qrUS7rJuwl8XRiylGZViqdPDHXfAA8kszIOvqHZDnj75ZMtBsZ04Rsbi
 fkV6V7Br2aF0uuw=.npuCXmvmQOQSUZLquFvIjeKt1bsgyO/1xVbKwSr/DwGjFKPx/ophIz1RGH
 D/n7Z/ZMrdS6HWCUClv2hSxdNvmd1aKiyNlC0lnHYhDKRGE72gS0oME+W03OxtcahTExiBnDt6C
 5tDLuWZ6XRnrpiB8nwtMegYH9Z7bgIRby7YmrUquoPAvXyj2l9x8o3+SuLGqELGVF4i4E6mvQvF
 E2HrDQ6G0rUpvcdLIYhixJkG8EoHIC9kx6JKHeHLMYJ732LPFKIkzA7vsbUySGmEXElTJhRxnzL
 7mRZX3IOdtk6pRxQZH0cHqmBUFIbnK1Rxs6bVT2j1jwYsXyjgEoGHIy/NTw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
 s=TM-DKIM-20210503141657; t=1697591183;
 bh=SeatEkYjlXjrfNPVyTfRccDzt9kkLEJBHeTiPUTqArQ=; l=3897;
 h=Date:To:From;
 b=1s3r14YToA/wSNYV5wBeaF/HdFS69zL41osVV2R+TEbjHxju9TXMVd3CcWHhPN2sO
 S+4AYHVjAnQRRs07RIky8y3OgLT8Ray00Zg62YB8eHzZjLPFplnl2yNq7X4cO0Ela3
 1fE3PubzyIsZaLsbxmF6b/i6fY4ou/5tVeFqrYZuV8UFZdCaSE2YbJfK03Hb419Yd/
 vR6VRvewGnF/tDIY6oa0to6H+QK/1lpX67SCBZJsjsSKexFReY5xMrTyrIAr4zY8BB
 RvQ03ez7E1N4K/oV3/s+vARM5ABmK+G5lnIwBLQlaAa++Qjze4y6pn/S3zcusfqdDT
 dBde7+IflH3/g==
Cc: mst@redhat.com, stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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
From: Anton Yakovlev via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Matias,


On 18.10.2023 00:19, Matias Ezequiel Vara Larsen wrote:
> Hello,
> 
> This email is to clarify the VirtIO specification regarding the RELEASE
> control request. Section 5.14.6.6.5.1 [1] states the following device
> requirements for the RELEASE control request:
> 1. The device MUST complete all pending I/O messages for the specified
> stream ID.
> 2. The device MUST NOT complete the control request while there are
> pending I/O messages for the specified stream ID.
> 
> The 1) requirement does not indicate what "complete" means. Does it mean
> that the pending I/O messages in the tx queue shall be outputted in the
> host, i.e., consumed by the audio backend? Or, completion means simply
> to put the requests in the used-ring without consuming them?

Here "to complete" means moving the buffers to the used list in vring.
Technically, the specification only requires that the device "return" all
referenced DMA memory to the guest before completing the RELEASE control
request. What the device actually does with these I/O messages is
implementation dependent and is not within the scope of the specification.
Thus...


> Regarding 2), I interpret it as "the device shall wait until all I/O
> messages are proceeded to complete the RELEASE control request".

...you can do this way if you really need to.


> Currently, the kernel driver seems not expecting such a delay when the
> RELEASE command is sent. If I understand correctly, the kernel driver
> first sends the RELEASE command and waits a fixed amount of time until
> the device can process it. Then, the driver waits a fixed amount of time
> until all pending IO messages are completed. If the device follows the
> specification and waits until all messages IO are completed to issue the
> completion of the RELEASE command, the kernel driver may timeout. The
> time to complete N IO messages in the TX queue could be proportional
> with the number of pending messages.

The default timeout for control requests in the ALSA driver is 1 second. In
theory, this time should be enough to completely reproduce/fill the 500ms
buffer, and complete all requests, including the RELEASE control request. If
the device fails to do this, then most likely there are some problems with the
implementation.


> In our device implementation [2], RELEASE is handled as follows:
> - Drop all messages in the TX queue without outputting in the host.
> - Complete the RELEASE control request.
> 
> This seems to be working, however, I can observe that sometimes there
> are still requests in the TX queue when we get RELEASE. Those requests
> are never reproduced in the host.
> 
> My questions are:
> - In the specification, should we modify it to clarify that all pending
>    IO messages in the device are discarded during RELEASE, that is, not
>    output to the host, but signaled to the guest as completed?

No, we shouldn't. See comment above.


> - According to the specification, should the driver wait in RELEASE an
>    amount of time proportional to the number of periods yet to be
>    reproduced?

This is purely a matter of driver implementation. It is possible to implement
the driver without timeouts, but this would be a bad idea. Because bugs in the
device could lead to an infinite wait in the kernel.


Best regards,

> 
> Thanks, Matias.
> 
> [1]
> https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.2%2fcsd01%2fvirtio%2dv1.2%2dcsd01.html&umid=31e1136e-6322-4698-9f1d-d631ac36403e&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-586f0596c89224a3bc9e20df81eaea8933bb129a
> [2]
> https://github.com/rust-vmm/vhost-device/tree/main/staging/vhost-device-sound

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
