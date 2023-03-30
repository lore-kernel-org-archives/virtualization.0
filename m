Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5829C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 18:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35BFC60E5D;
	Thu, 30 Mar 2023 18:21:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35BFC60E5D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kkXvAI/0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kfffl9ELebLW; Thu, 30 Mar 2023 18:21:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66A9F61679;
	Thu, 30 Mar 2023 18:21:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66A9F61679
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 237A7C0036;
	Thu, 30 Mar 2023 18:21:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B9F5C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03BAD8441E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:21:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03BAD8441E
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=kkXvAI/0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3fOk9-pIqtW8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:21:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCF5184450
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCF5184450
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 18:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzCYt+n91P74Dy58E+e+xxFS7L8lVPosm8vX3Zlek5hpIb86Mj1B5ntW9wZIZVeWO3cC1aMnyTCZqd4oB91Gh04zSnWfMHlziCW+1okz+3irD+kNK/D5hUYj7jOa8d2nbRXkuhSJltvIZeaMknq+eb0M0SXKojJ4b2yuyAklaNQUewkJ+F99ImNXMGcfgExowi1aZR2H7T8nMmaYBaeZ0LXY4KiwlTsJTYj5PXBY1joh01G7BBFL+Zz+v9s+cuh0IGdH4N+5ZDusENA6rJMCVH4J36hEk0YEDrsC2HEk9CFjnk3CEVaRda5KQdu3AsJNOz0LtEDW52jwYwLwd5e79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/PSjyh+ET+zq6kMVuQw7AwtJBJL7+NLJQCgdaElEY0=;
 b=GhLgbxVLDdQ06P2ADHCpRT9k23bLmcTGRSi+eFu8dO35I08tDErqDxa0Lytu28dnJXVJmZTGUYgfZP7upCBDSdRw/x2A9o45Fg1SFDMz7iCwczO7/oLwTE0BvlKaLXtJwB9B//bDt8MLBrPN6USMBl4sVhuQCq584v+8ecKRFV+T0Kfv2vouoKlkxIuhmPaBK4gAClvFJ4OoZlZXKSnc75mZVMb9Nsj+KhqDQSOl4cZOxP6t8qsD1xXA8+/GlohNB98wW83vZN/jvCFXF0cjTwqqAc6o+ksgjzcb/B776Uk6++lmJ5m127v1+Ir5l1UwwgiqbkqQoXkqzdU12u7o3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/PSjyh+ET+zq6kMVuQw7AwtJBJL7+NLJQCgdaElEY0=;
 b=kkXvAI/03cGsVmfnQwJyIKwcVnFil3Vfkj4A9TApVs38JEqzVeqyhomoIz1Kp6KceY3t7ROEWyCZw8nDxRN8cECTkdQJCVMGS4OHPrI7pCbYGpc97clfKjUquREuhgFMHLqBsJHYbkQUWl1BZY49x/T0w2jkHGhx3M2X5q90BtrrErfblAzFiDXTByz1PzKaaAsArqIKo8PiPVfkaKLO07bqCTbiWjoGZh6UHkTu7JWfA4QYflqyqA6QRDcVLmGjGRrLXmeP84Y3JxSq5TqUj4j2pygFjq6Q77ZT+I+khjklNWzx6a2ELOHPp+4KECQgZxsHsbQNGHB0t0jmVgcMsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 18:21:22 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 18:21:22 +0000
Message-ID: <f80b225d-2f07-c079-da77-d64aeae61473@nvidia.com>
Date: Thu, 30 Mar 2023 14:21:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] virtio_ring: Allow non power of 2 sizes for packed
 virtqueue
To: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-2-feliu@nvidia.com>
 <CACGkMEvPtS9pGqkxr6=UJj7myQZw8A2qMdV2CnPtksDESvn5Gg@mail.gmail.com>
In-Reply-To: <CACGkMEvPtS9pGqkxr6=UJj7myQZw8A2qMdV2CnPtksDESvn5Gg@mail.gmail.com>
X-ClientProxiedBy: DS7PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:8:2a::11) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e336cec-6b5b-43aa-9b3e-08db314b9070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKeCFXxq4hqgMDL7nrxMw7rhRIdyKLhD+vrPoKKs0A6bq+bU1OPOJLGOgJM/caaV2E6z7UB5Zm8EX7tdrM/EpM/NxfzPulBCnKh3HdLecW/1B8asi8Qqq4jSyX9CzQM/zmI8jEEYUNCE6Nlp2DrND/gaQYTVTnNvpWYbVfsI1HnjUZi6FED/8mVQ3xsJM+ExEfKDj0IyA2kIBN2BKssyDl5kBoa/pOtpQyUXsQrZMhgDwsokDgOP7NS3MxwFm7rSrNe/jSP7hOZFesCppYU44sAOeSFKOF6CJWBX0WWJv8BNq/G2xj/U85pczPKc+V+Ms9Kqp5pR0+vl69ESW2jh57wiJz/6V2JDf/44fQYOWoWFBqWuRggGF+h8jx4SNKi5qXQrxiSkVXsXfcOBO7JaMzdJ8Ibn49SnFXbY5mDPv+mIC6dsAfOy0cRHVqEsy7BNdZz8xKaNIPivyu25dKbpaDAGoWNZSu3qduPlMwuPkE/INKLVfF9EL+IkiFBTXgyUmNOmeVWzSP2B1Oh3ifdHkI9GiV+1Vw0t7NIOl5G9RYIm+fBYwLcgc6/fd//+SofECLfK1NKKFtJvEGFSFuXGiFHRu0Wnrq02SSB9DoM2hsarkuLC07fXKk1eoqSeksCgnhx73R63FK6zR2qmRaK/DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6201.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(66946007)(66476007)(8676002)(66556008)(41300700001)(4326008)(38100700002)(2906002)(5660300002)(8936002)(53546011)(6512007)(6486002)(107886003)(6666004)(36756003)(83380400001)(186003)(31686004)(2616005)(110136005)(54906003)(6506007)(26005)(316002)(86362001)(31696002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJCNDBpMXBHejU5TGU1bmdmVHE0Nkk3R2ZDeUZOVzBaYUNHc3cxaDhqVzhp?=
 =?utf-8?B?OTlVK1lHelNKYmtLRGRzZ1k3Y3NSemszR1M0clExNU1PUldMcHdSL1pSSFhN?=
 =?utf-8?B?WkpJUTdGbUJZb0tYVm1ZeVhMK1U3ZFAxY2dZbzFRaXVxQWEza1JRYW9vZkRE?=
 =?utf-8?B?MFljWFJGakplUUxuZFZmd295eHlBaERDUTFQVndFNklGU1VSVllMRitLcGxB?=
 =?utf-8?B?bjhyMCtZa3pwTm9wOTd1OE5IWHdDR0Fma0hvMUs0ZUduaWhCT21weUxKOVJW?=
 =?utf-8?B?ZTNGaHAyV1pDc3RIbEM2UDhhb3diNmJRNHd1aVZ4T09hTnQ2dTJPb1RmWjU2?=
 =?utf-8?B?MnhlSm1Db24zSEpRMGNQR2V3Wkw3dDB0YUZrc3ZLdm1DaHFPSHdOZGxEa09E?=
 =?utf-8?B?NU9YWGd2M0lzOXE0YlRLYW9zN1NHcDhaQ3pMNjI1SkhaaGF3a2h5dXY0N2lZ?=
 =?utf-8?B?bnBFZ0RHdW1nbUhTTGR6Tm92NFFEelljTHBSN1NURS9mT0pXQy92ZVFGbTFs?=
 =?utf-8?B?ZUhXaHlyUnI1SEZ2cms4d1hlVmxWRGNZekZ4YjQ2YkQ1eTdkVEd3VGdMZmc0?=
 =?utf-8?B?SjJWZ3BOY1FjWGw3ZFFZclo5djExOUYwamNKdlYwN05jMldrSkJPaFVJWjQr?=
 =?utf-8?B?WVhWVEZ0VDF5QldibVhpMDFFVEVycGxUQVVKQ1BQTXRRYVZQWjZaQk40Sitm?=
 =?utf-8?B?VHRuQWNHbEhlSVA0TWtUcWpUUExFbzJIV3hhT0wxckFhL3o5dzVnZmJiMGxG?=
 =?utf-8?B?eVluOGV4d2JrZE9YV0c3Z1pnaXNxZHVSS3liQ1hwMk9QdnV5cjRPOGFRT2ww?=
 =?utf-8?B?eThaTk9qVFY2Z0Jza0RRWHZzWXNWTU1kS3RuRXh4NlZkdnNkZjYveVlZdlZM?=
 =?utf-8?B?T0RIODE5R1k5M24rbktnTEFCQWl0OE81dnd2RG1KVHVQaXVXbk5tdkNySTh4?=
 =?utf-8?B?ZnVHNVlqcmo2S1F3TmxMVlpveDMvOVN3dTJ6eHIzUlpqOEZxMUlwRWpSUnFh?=
 =?utf-8?B?NTBMWjRNdW83Q21yQk1jYVJYcnppV3RxVVp4bDNvR3psQzc2ejdSN1puUERx?=
 =?utf-8?B?SUpucmlOY3c4NFk3SXdLQkRRYUZGZ3M0UkVzL0dhRTFqbm1XNTFWd0RJNXYy?=
 =?utf-8?B?OUJXUmhteWtOVnJ6cGdnRE1wU2cvSmRueUNRK1grUXhwQzVTVW04N1JmVFZq?=
 =?utf-8?B?em05dkEzT0p5aElwQ1FqR0JrUWppcy9aeUlEU0E0T2orT2Zza1BUcjR6WDda?=
 =?utf-8?B?b1VIc1BwQXdNNVNtVDMrVENrOU8xQWpiN09iOEJ3QktnWE1TMFdQNDgyUENZ?=
 =?utf-8?B?YzRHTE11MUI0NjE5Um5EN1U1TlJHU2pKVjJUUElPeU1Qck8zcWJCVHo3cm1W?=
 =?utf-8?B?N2dNMFJXdXMxMFAwL00wbVc3NEpDelZxL0dWVytkbVVkbHo1TlluV09tT0Na?=
 =?utf-8?B?TUlHTlRnM0tiaGczZkxaVGRFQkR2NlBIekg3OWduZ3RKZXZDTm90RWE4WVZw?=
 =?utf-8?B?amJsZUNlcXBlUm1kenE5M1FGSHZTNDY1UGZGYjZkZ0k4a1pxL0NsaStCSFRV?=
 =?utf-8?B?TWlxaUNTYVgyeEV3a3k2dk1FMWxWbDJXNWZWNWErSVlvYWFiSGJ3aGZIWGoz?=
 =?utf-8?B?TSthVkVWYXYzM3Q5RGd4T2Z3UHJDZTVmeGgwM05QeW1kNFNrMXV3VlBseFhR?=
 =?utf-8?B?bkhoTEhscXB5KzJjQ2E0RGZsRUpuZGVyblRNajNja2ZkWU9CQ2dUU2pOTHdh?=
 =?utf-8?B?N3JxdHdnbkhaZEdXV1I4NWxybnJjNHNMRGYzZ2dvMW04TFJQTGpsaGdRSzRS?=
 =?utf-8?B?UkphR1lqekVqRzNwUFNmWDZUaStiSXJycklZbHhZaGREendMM2dvRnNhbDk2?=
 =?utf-8?B?WjgyYzVhOS9hZmZraXFXNktVSDRTSjFxaXVRaExtc29HWUdadzFHWnl4OUZh?=
 =?utf-8?B?bHVxSWxTUTZQNDYxRlZDTkYxVmg2cERpMWRGM3hIRDNKTGllMlJpM1BIQ2VW?=
 =?utf-8?B?YUpJQUszQXBXWjNJV2ZiOUtoNzdzY0RlRmdlQkI1cTRQN0J4alFVYzZlckw0?=
 =?utf-8?B?dHN4RFR6dnd3NFlBQ0lFS09uME12OWJBQVB0bEorc0dCR0ZORVVBVzRUNGc1?=
 =?utf-8?Q?7VGQ3X8HEbO66KQZL302QbBjb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e336cec-6b5b-43aa-9b3e-08db314b9070
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:21:22.1695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLZ8GCNSJudv8sCn0Qi3QcegLpr7rREUpMn5MpsROL4BoBXG5nCbcj8DiWuO3odrAXA844mMskOs9SY/PE/nMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

CgpPbiAyMDIzLTAzLTE2IHAubS4xMToxNiwgSmFzb24gV2FuZyB3cm90ZToKPiBFeHRlcm5hbCBl
bWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+IAo+IAo+IE9u
IFRodSwgTWFyIDE2LCAyMDIzIGF0IDI6NTXigK9BTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4+Cj4+IEFjY29yZGluZyB0byB0aGUgVmlydGlvIFNwZWNpZmljYXRpb24sIHRo
ZSBRdWV1ZSBTaXplIHBhcmFtZXRlciBvZiBhCj4+IHZpcnRxdWV1ZSBjb3JyZXNwb25kcyB0byB0
aGUgbWF4aW11bSBudW1iZXIgb2YgZGVzY3JpcHRvcnMgaW4gdGhhdAo+PiBxdWV1ZSwgYW5kIGl0
IGRvZXMgbm90IGhhdmUgdG8gYmUgYSBwb3dlciBvZiAyIGZvciBwYWNrZWQgdmlydHF1ZXVlcy4K
Pj4gSG93ZXZlciwgdGhlIHZpcnRpb19wY2lfbW9kZXJuIGRyaXZlciBlbmZvcmNlZCBhIHBvd2Vy
IG9mIDIgY2hlY2sgZm9yCj4+IHZpcnRxdWV1ZSBzaXplcywgd2hpY2ggaXMgdW5uZWNlc3Nhcnkg
YW5kIHJlc3RyaWN0aXZlIGZvciBwYWNrZWQKPj4gdmlydHVxdWV1ZS4KPj4KPj4gU3BsaXQgdmly
dHF1ZXVlIHN0aWxsIG5lZWRzIHRvIGNoZWNrIHRoZSB2aXJ0cXVldWUgc2l6ZSBpcyBwb3dlcl9v
Zl8yCj4+IHdoaWNoIGhhcyBiZWVuIGRvbmUgaW4gdnJpbmdfYWxsb2NfcXVldWVfc3BsaXQgb2Yg
dGhlIHZpcnRpb19yaW5nIGxheWVyLgo+Pgo+PiBUbyB2YWxpZGF0ZSB0aGlzIGNoYW5nZSwgd2Ug
dGVzdGVkIHZhcmlvdXMgdmlydHF1ZXVlIHNpemVzIGZvciBwYWNrZWQKPj4gcmluZ3MsIGluY2x1
ZGluZyAxMjgsIDI1NiwgNTEyLCAxMDAsIDIwMCwgNTAwLCBhbmQgMTAwMCwgd2l0aAo+PiBDT05G
SUdfUEFHRV9QT0lTT05JTkcgZW5hYmxlZCwgYW5kIGFsbCB0ZXN0cyBwYXNzZWQgc3VjY2Vzc2Z1
bGx5Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBGZW5nIExpdSA8ZmVsaXVAbnZpZGlhLmNvbT4KPj4g
UmV2aWV3ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4KPiAKPiBBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAKPiBUaGFua3MKPiAKSGkgTWljaGFl
bCAmIEphc29uCglDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gdGFrZSB0aGVzZSByZXZpZXdlZC9h
Y2tlZCBwYXRjaGVzIGZvcndhcmQ/IApUaGFua3Mgc28gbXVjaAoKPj4KPj4gLS0tCj4+IHYwIC0+
IHYxCj4+IGZlZWRiYWNrcyBmcm9tIEphc29uIFdhbmcgYW5kIE1pY2hhZWwgUy4gVHNpcmtpbgo+
PiAtIHJlbW92ZSBwb3dlcl9vZl8yIGNoZWNrIG9mIHZpcnRxdWV1ZSBzaXplCj4+Cj4+IHYxIC0+
IHYyCj4+IGZlZWRiYWNrcyBmcm9tIFBhcmF2IFBhbmRpdCBhbmQgSmlyaSBQaXJrbwo+PiAtIGtl
ZXAgcG93ZXJfb2ZfMiBjaGVjayBvZiBzcGxpdCB2aXJ0cXVldWUgaW4gdnJpbmdfYWxsb2NfcXVl
dWVfc3BsaXQgb2YKPj4gICAgdmlydGlvX3JpbmcgbGF5ZXIuCj4+IC0tLQo+PiAgIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgfCA1IC0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDUgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX21vZGVybi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+PiBpbmRl
eCA5ZTQ5NmUyODhjZmEuLjZlNzEzOTA0ZDhlOCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X21vZGVybi5jCj4+IEBAIC0zMTAsMTEgKzMxMCw2IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVl
ICpzZXR1cF92cShzdHJ1Y3QgdmlydGlvX3BjaV9kZXZpY2UgKnZwX2RldiwKPj4gICAgICAgICAg
aWYgKCFudW0gfHwgdnBfbW9kZXJuX2dldF9xdWV1ZV9lbmFibGUobWRldiwgaW5kZXgpKQo+PiAg
ICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwo+Pgo+PiAtICAgICAgIGlm
ICghaXNfcG93ZXJfb2ZfMihudW0pKSB7Cj4+IC0gICAgICAgICAgICAgICBkZXZfd2FybigmdnBf
ZGV2LT5wY2lfZGV2LT5kZXYsICJiYWQgcXVldWUgc2l6ZSAldSIsIG51bSk7Cj4+IC0gICAgICAg
ICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPj4gLSAgICAgICB9Cj4+IC0KPj4gICAg
ICAgICAgaW5mby0+bXNpeF92ZWN0b3IgPSBtc2l4X3ZlYzsKPj4KPj4gICAgICAgICAgLyogY3Jl
YXRlIHRoZSB2cmluZyAqLwo+PiAtLQo+PiAyLjM0LjEKPj4KPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
