Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30608EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 16:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9157282334;
	Thu, 20 Jul 2023 16:44:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9157282334
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ew9QwA8J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id md9rGvD78_NT; Thu, 20 Jul 2023 16:44:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CECC982331;
	Thu, 20 Jul 2023 16:44:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CECC982331
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E6BDC0071;
	Thu, 20 Jul 2023 16:44:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41F06C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 16:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 257AF61204
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 16:44:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 257AF61204
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ew9QwA8J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MVaVZcxM1zpS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 16:44:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::604])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EC85611FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 16:44:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EC85611FF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9OfYleDQkVBt8sXbfXxP1DE1c84zrCeOf14R4ZbjH74dO6lzd41ItaiLnIXVlKG/R1gEoDh8H59nHh6+gr8SGwUGolAJKYSKI/3IcxsEGiA1bd/oVS00Ui+G8P77vkkOuN8G/uZ1evoQDZTJKLkRULiKvRFpLlWwhS54rOJCY9Ro+cWBTPXhvJJXDJ9NafO8ji0J6/UqawRjJXsHkJkjxWDSnc/4dgawadCOcwskwsRriQaALK7UE7Z+zUJKpfulJ1v5xoTPrxnSws9faLDTFcKTlXhZ7il0G+CyTIvtsT7L4SHVhJlptFYCgLUhj304lbQfGgUR+G9Wlf0B9e/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77y4nqgRG3VPfB+i9VDLwPuNNpSUn8MbdRrIoJRGtI8=;
 b=QoI1p3jP9WHFPVTxnUQwF/rxtH4xl3BHEzevyKhyPXo/SrFunm0Oy8Pw61GkhWFx0FRODKpqTEjVk1bVH8zC/nedhjWieGdBdrD1WXbUSfXz2ferSw0zbdPzKaLVYndv76G8mOaJD/wgKSfFEUKC/Lv6iOJL2Iy9M7AZ7ycwpmqm8YCVpvDLwMe0y+pLSf4Tm8yGPQX569xZAA1/s17ZlHFLLayFkeslqwcQwfkydiZNhZ62yQyH4k/B8XFuLCIZsQO6YF4RUzUvNPvTg2yV9nwElnNpn3V+NNDvuPU51elBpByFgrNtrBJzAH3M2CgOi5uRH2XokKBmlXZqb4Hzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77y4nqgRG3VPfB+i9VDLwPuNNpSUn8MbdRrIoJRGtI8=;
 b=ew9QwA8JcmPCMyB4VUph7AS7J+Ky9dWfKPlmT0INffLT0cdD/oKiH5Qzs9ccxhAMDoJHDrLOs/j1EFUbnJTXLFhzihGZ0XGy3K8OcSfsaH1S14b5ZYCYdc0UZIhimznLisZDGF2Het3uzyPVyAgmMDHXGyxk8lVIz+dK3adxbufyxV47Et3yvwN9RAqmCX+Tw5L1FLXteA9jtwOOTsdbZYT3rxXlPOmrICKCU6b9qpm4QNgq/dQhdLsJchZI1/e7Msh8X7Qa0ywo0ticUrX2y8u5lP9oVPsygsCAwJZKfHtubmUa12wIVNRauO8MacHKD/TBbZ5SvBcjGbtIN542dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 16:44:01 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 16:44:01 +0000
Message-ID: <a6bf9478-af97-4f3f-7600-1c52e27242bc@nvidia.com>
Date: Thu, 20 Jul 2023 12:43:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
To: Jason Wang <jasowang@redhat.com>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
In-Reply-To: <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::26) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW3PR12MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 22151725-0b23-4468-3179-08db89408597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfm6h+cFWchrY3vBFaAm/zrjQ5IG+dFpLEXr/vBeddjfRBOExy4mikK1MQRNymkub2pLawAo1yAdjY+5R0qEbCGStpU0dgVugPyWE2ZWL8FByUtFTEV0KP0JMuSCaat+PEkGR/tNiFOkeb3uRrVfrpHhf4hYEr8/LNfCjmOusTfKVUotmrU7eyXGqlkEWdCF+2wGK8fxyJi8kHILSsj6F7ISpGVLVwaDRYYRBoZB4KjA7CeFXtmKTySXFkg7prxU8GhENOwurMoEIUUhHw/irhI9dHA2rVfSwwInC5iXvvX5+vNgqu+vWmhcd0RLP19ISNR5CUQudGhcraPah8ruT/L2YBGiveYVrRxLc7fqu/7Si5VzUICDWyBzFlfKYp6Ic1DkwNVpIAdAevCcrc87zkXJqoH+QRUr6I5pL00wJblRhrble2onTv1cCT2hs7HBVkaLFiiEawIv+HUa46DdTsB0YeqAZ/Ytm7J4zGSWusBRbPaX+swOMUlL1lguFK/r52nAbTCBwODWZ3muSOD2pspzhDE9yKkrYWY87rNeU3O9r5NweET0ggKCWMSz3mepXoyq/jG1hiQ4WcZLW1axJ2FmQG/QUAu+mMdbMIQ2dAO7HPZVTwmijByIsEs/9OZ2+6+EMIpIxyZyZPTAD8f1nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(31686004)(54906003)(478600001)(6486002)(6512007)(6666004)(36756003)(31696002)(86362001)(83380400001)(66476007)(2906002)(66556008)(4326008)(107886003)(2616005)(6506007)(53546011)(186003)(66946007)(38100700002)(316002)(26005)(6916009)(8936002)(8676002)(41300700001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEtOUDZaVENvdTE3SU1IYk9YZmNWaFB1bXJYSHRHZE5yK2hBWnFSLzltSy96?=
 =?utf-8?B?WWlraXVPVTZXZjhRWGFEMFAwUXlTM1UyTm9FOU1wS3luMVdYNGJUaWJzOGNK?=
 =?utf-8?B?N05WZUpiZ08wcWQ4YVdISGJMK1F1L3lmVnhta0p1R0xiT1orL3J5MnVpcno5?=
 =?utf-8?B?dGZIcnc5TzMzMDRsSW1KUmFzZUJDeGd6aVZ2ckJ3dS9UWlhyWkVXUTR5UGx1?=
 =?utf-8?B?YmVTVk84TlZ0eHpxTW1jakZWQzh3bzZkaE5QNHFBMmY2WTFFemhDUlhENWpN?=
 =?utf-8?B?L3JGL1ZuZnJEcGhWRk1FR2RmLzFmSFhpcEwvUFQ4TkFuK0l4QUFhZTFHcWhQ?=
 =?utf-8?B?V2l1UWRBWlhIdUpiOTFwZzZVTEE4TkxMR1I2RU1Fc3oxTjFqd01TUE03eHlJ?=
 =?utf-8?B?T0FySXlXMUNsc05VY2ZXZVgvVkpxaDJZMldueit6RVdrRkQ1Y1pCMWlETkUw?=
 =?utf-8?B?aUFXTXZGdzJ5aVpOaXFFNmloWncwY1N6VFYxNXdqU1dhWUtmdkNPUkFmR0lE?=
 =?utf-8?B?YjQ3OXRmUzNhWTFSQTZDc3RseWRYMHhkTkJEMG1EaE5aVU1YcVNrK0dPUi8x?=
 =?utf-8?B?RjB5Ly9naEFoTUYrMlZ2RzBCVlREeUtnaWhvc0llMjYzWGFTRGF2emZaelho?=
 =?utf-8?B?R3B0bUNFT0xTbC92UzBxSC9ZVzVsWEpINXRqMUlNRUZ6eWMzWExXYmF5ejNo?=
 =?utf-8?B?b3ZQN1o2S1gvNThKSzJ1UHNUY21uNVBpSTc1WEVkMjlUL3hkQzdQTEZ6YlAy?=
 =?utf-8?B?eDlzUXNVM3YvLzVxdEk5Rmt6RkxXQmQyS3J4RnYybG9tbTRXSndtYVU3TGxH?=
 =?utf-8?B?ck9Gdi9lbmdNSlRaRWo1YzBZWnRGeHpKbjR4a3pFdGVBbHVnN3JuNHRSRmNv?=
 =?utf-8?B?ZkY5aDF4MHFRcEJGeFdpY1g3Q3MrRlByNlNiR25FZlVoZS9qM1BoSFNIOXdF?=
 =?utf-8?B?U3pBbHFjY1NHNkxEUFVveU9FYWZkaXJoUFFxTjhjY1RuOTNDK2p2MjJyd3pr?=
 =?utf-8?B?SG5FQUY4OXVNS05wQUYxbDVtbUVnL0RoOHRta09HMGtIaTYvYUhieTZSS2Ro?=
 =?utf-8?B?aU5STC9hS0ZGRXdPdk5ZVXM0RFRqNjUvdlk2NCsveGxOSVBxZ2tLV0ZZZG81?=
 =?utf-8?B?Wll6eDlxajAvZ2R2Mi9PaE5VTXpGb083ZWtaSmdqaHhXR1pDUG9QNkhLdUtK?=
 =?utf-8?B?U0JtQ29SQ00yREZPMEtiZlh2K3R3eXFYc21DN05BckoxVzJOcHhQL3R1QU91?=
 =?utf-8?B?UkRFRFc3UWcvRDIxSDZEbG1BZnhnQjQwSDJBSUg0Vk90YjhZYkNxZ0ZJbmJn?=
 =?utf-8?B?TVRFUk5LdTNqZzAwODFGbllJSWxKOHFxTkZpRmFXUTQ2aUoxc2xZVFM5OW1P?=
 =?utf-8?B?Q1gvRGluMkpPVU0xRHRqR1Azdk5NZzhtaThuaUlsRUJ5czc5VFJ2ZmhiamJ2?=
 =?utf-8?B?cGZuZlhnbHFuMmJmOXUvQkgrb0hXRjFlR3I4aEFrK1AvcGZ1eHRkUFlTZlRq?=
 =?utf-8?B?RXNVMUFIUS9IWUVCUHJmQjFyVjdlazl3UzQxazhCTm41QkxpaUZNY05nUFJn?=
 =?utf-8?B?aS9EL20zMlk4cUJqODV1VElOZTBGOXkxZnl0Z2hmS1JUZnNKeXQ1Q1k1MVRF?=
 =?utf-8?B?TytpR2FRdWUxOHZnTlp5OTVSdHNoai9IQ01tQmMxMWJpMG9zMHl5bkpDaXc0?=
 =?utf-8?B?aWRickZOeDlHQzJDTGttNHQvSERHdVdSTk9VQ2k2UlZRamtpbEE3NE5FM1p4?=
 =?utf-8?B?U0x0emdlbEx3ZGoyUFRyaWkvV2hOWVVvc2h5NFEwakZMaXpSNXE4ZGFsMk1J?=
 =?utf-8?B?SEhjaVV1NEN4ZWdsZGlLNTM4cGxQbmdyZDQrTVpXOVJ6Qmg4bUhGUDZDZ3Fy?=
 =?utf-8?B?NTllV3lHNVRNd2J0WjhwdUxXNzd5WjVVQXFXT1RVdmJOblcwRzRZSkthK2FR?=
 =?utf-8?B?UGxEMHFBNVFsbkJsdk5OK1dYVzk5YTIyT2lmV3lrTm8wcDNpNDhpQnlYQ25a?=
 =?utf-8?B?bFE5bzVQYU5uaDVjbnRPSGpzdjBhV01MUllma0c0QlpwbE5yOUpUWmhVWGtn?=
 =?utf-8?B?RWdTUlR2WTdJeFRkYWVoaFBtOTJSb09zUnFOSnBjTmNKSjUzc0V4NVB4cENv?=
 =?utf-8?Q?ua9sgfHhMJGgha9r9skPvG/Mu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22151725-0b23-4468-3179-08db89408597
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:44:01.6530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0s8It8lODzLRg0OBcZRRkfJkJTdjFeipVwibmuV9d0lwNCjIywz8endU+qPbXQtrLMxtxs05mMkDVgiE/ORjSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyMDIzLTA3LTE5IHAubS4xMDoyNywgSmFzb24gV2FuZyB3cm90ZToKPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+IAo+IAo+IE9u
IFdlZCwgSnVsIDE5LCAyMDIzIGF0IDExOjQ24oCvUE0gRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5j
b20+IHdyb3RlOgo+Pgo+PiBUaGUgJ2lzX2xlZ2FjeScgZmxhZyBpcyB1c2VkIHRvIGRpZmZlcmVu
dGlhdGUgYmV0d2VlbiBsZWdhY3kgdnMgbW9kZXJuCj4+IGRldmljZS4gQ3VycmVudGx5LCBpdCBp
cyBiYXNlZCBvbiB0aGUgdmFsdWUgb2YgdnBfZGV2LT5sZGV2LmlvYWRkci4KPj4gSG93ZXZlciwg
ZHVlIHRvIHRoZSBzaGFyZWQgbWVtb3J5IG9mIHRoZSB1bmlvbiBiZXR3ZWVuIHN0cnVjdAo+PiB2
aXJ0aW9fcGNpX2xlZ2FjeV9kZXZpY2UgYW5kIHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZp
Y2UsIHdoZW4KPj4gdmlydGlvX3BjaV9tb2Rlcm5fcHJvYmUgbW9kaWZpZXMgdGhlIGNvbnRlbnQg
b2Ygc3RydWN0Cj4+IHZpcnRpb19wY2lfbW9kZXJuX2RldmljZSwgaXQgYWZmZWN0cyB0aGUgY29u
dGVudCBvZiBzdHJ1Y3QKPj4gdmlydGlvX3BjaV9sZWdhY3lfZGV2aWNlLCBhbmQgbGRldi5pb2Fk
ZHIgaXMgbm8gbG9uZ2VyIHplcm8sIGNhdXNpbmcKPj4gdGhlICdpc19sZWdhY3knIGZsYWcgdG8g
YmUgc2V0IGFzIHRydWUuIFRvIHJlc29sdmUgaXNzdWUsIHdoZW4gbGVnYWN5Cj4+IGRldmljZSBp
cyBwcm9iZWQsIG1hcmsgJ2lzX2xlZ2FjeScgYXMgdHJ1ZSwgd2hlbiBtb2Rlcm4gZGV2aWNlIGlz
Cj4+IHByb2JlZCwga2VlcCAnaXNfbGVnYWN5JyBhcyBmYWxzZS4KPj4KPj4gRml4ZXM6IDRmMGZj
MjI1MzRlMyAoInZpcnRpb19wY2k6IE9wdGltaXplIHZpcnRpb19wY2lfZGV2aWNlIHN0cnVjdHVy
ZSBzaXplIikKPj4gU2lnbmVkLW9mZi1ieTogRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4+
IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4+IFJldmlld2Vk
LWJ5OiBKaXJpIFBpcmtvIDxqaXJpQG52aWRpYS5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAyIC0tCj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9sZWdhY3kuYyB8IDEgKwo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2NvbW1vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+PiBpbmRl
eCBhNmM4NmY5MTZkYmQuLmMyNTI0YTcyMDdjZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9jb21tb24uYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X2NvbW1vbi5jCj4+IEBAIC01NTcsOCArNTU3LDYgQEAgc3RhdGljIGludCB2aXJ0aW9fcGNpX3By
b2JlKHN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2LAo+Pgo+PiAgICAgICAgICBwY2lfc2V0X21hc3Rl
cihwY2lfZGV2KTsKPj4KPj4gLSAgICAgICB2cF9kZXYtPmlzX2xlZ2FjeSA9IHZwX2Rldi0+bGRl
di5pb2FkZHIgPyB0cnVlIDogZmFsc2U7Cj4+IC0KPj4gICAgICAgICAgcmMgPSByZWdpc3Rlcl92
aXJ0aW9fZGV2aWNlKCZ2cF9kZXYtPnZkZXYpOwo+PiAgICAgICAgICByZWdfZGV2ID0gdnBfZGV2
Owo+PiAgICAgICAgICBpZiAocmMpCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2xlZ2FjeS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+PiBp
bmRleCAyMjU3ZjFiM2Q4YWUuLmQ5Y2JiMDJiMzVhMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2xlZ2FjeS5jCj4+IEBAIC0yMjMsNiArMjIzLDcgQEAgaW50IHZpcnRpb19wY2lfbGVnYWN5
X3Byb2JlKHN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2KQo+PiAgICAgICAgICB2cF9k
ZXYtPmNvbmZpZ192ZWN0b3IgPSB2cF9jb25maWdfdmVjdG9yOwo+PiAgICAgICAgICB2cF9kZXYt
PnNldHVwX3ZxID0gc2V0dXBfdnE7Cj4+ICAgICAgICAgIHZwX2Rldi0+ZGVsX3ZxID0gZGVsX3Zx
Owo+PiArICAgICAgIHZwX2Rldi0+aXNfbGVnYWN5ID0gdHJ1ZTsKPiAKPiBUaGlzIHNlZW1zIGJy
ZWFrIGZvcmNlX2xlZ2FjeSBmb3IgbW9kZXJuIGRldmljZToKPiAKPiAgICAgICAgICBpZiAoZm9y
Y2VfbGVnYWN5KSB7Cj4gICAgICAgICAgICAgICAgICByYyA9IHZpcnRpb19wY2lfbGVnYWN5X3By
b2JlKHZwX2Rldik7Cj4gICAgICAgICAgICAgICAgICAvKiBBbHNvIHRyeSBtb2Rlcm4gbW9kZSBp
ZiB3ZSBjYW4ndCBtYXAgQkFSMCAobm8gSU8gc3BhY2UpLiAqLwo+ICAgICAgICAgICAgICAgICAg
aWYgKHJjID09IC1FTk9ERVYgfHwgcmMgPT0gLUVOT01FTSkKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmMgPSB2aXJ0aW9fcGNpX21vZGVybl9wcm9iZSh2cF9kZXYpOwo+IAo+IFRoYW5rcwo+
IAoKSGksIEphc29uCgpJbiB0aGUgY2FzZSBvZiBmb3JjZV9sZWdhY3ksIGlmIG5vIElPIHNwYWNl
IG9jY3VycywgZnVuY3Rpb24gd2lsbCByZXR1cm4gCmRpcmVjdGx5IGFmdGVyIHZwX2xlZ2FjeV9w
cm9iZSwgYW5kIHdpbGwgbm90IHJ1biB2cF9kZXYtPmlzX2xlZ2FjeSA9IAp0cnVlOyBiZWNhdXNl
IHZwX2RldiBpcyBhbGxvY2F0ZWQgdGhyb3VnaCBremFsbG9jLCB0aGUgZGVmYXVsdCAKdnBfZGV2
LT5pc19sZWdhY3kgaXMgZmFsc2UsIHdoaWNoIEl0IGlzIGV4cGVjdGVkIGZvciBtb2Rlcm4gZGV2
aWNlLCBzbyAKaXQgd2lsbCBub3QgYnJlYWsgbW9kZXJuIGRldmljZS4KCldoYXQgZG8geW91IHRo
aW5rPwoKaW50IHZpcnRpb19wY2lfbGVnYWN5X3Byb2JlKHN0cnVjdCB2aXJ0aW9fcGNpX2Rldmlj
ZSAqdnBfZGV2KQp7ClsuLi5dCgoJcmMgPSB2cF9sZWdhY3lfcHJvYmUobGRldik7CglpZiAocmMp
CgkJcmV0dXJuIHJjOyAgLyogaWYgbm8gSU8gc3BhY2UsIGZ1bmN0aW9uIHdpbGwgcmV0dXJuIGZy
b20gaGVyZSAqLwoKWy4uLl0KCXZwX2Rldi0+aXNfbGVnYWN5ID0gdHJ1ZTsKfQoKCj4+Cj4+ICAg
ICAgICAgIHJldHVybiAwOwo+PiAgIH0KPj4gLS0KPj4gMi4zNy4xIChBcHBsZSBHaXQtMTM3LjEp
Cj4+Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
