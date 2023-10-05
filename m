Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7A4E9271B
	for <virtualization@archiver.kernel.org>; Thu,  5 Oct 2023 17:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3016F83A05;
	Thu,  5 Oct 2023 17:44:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3016F83A05
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ptTynJJ4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HkUEJf0ZxSnT; Thu,  5 Oct 2023 17:44:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 82DD5839DB;
	Thu,  5 Oct 2023 17:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82DD5839DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 593DCC0039;
	Thu,  5 Oct 2023 17:44:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4D6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 17:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEA09428AA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 17:44:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DEA09428AA
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ptTynJJ4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mhUpY57nwRlS
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 17:44:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::624])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C12342888
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 17:44:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C12342888
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heM4gAm0Ax2tNWdLSpgoXhvZfhLRIT8YkC9Ich8TVF7jF/mBptrbhrioYlU+0PxJLcI0kQlWL86b/WfyD/Pepmk3dRlYQxlEw8Gk2p+CWjjUYMfS1b9ooLa8pwyEqp63kEjNyH++oEMKShBMAIitB6DbTxx/HXqY5Gsaj2G3jzvm+I3EtGlXhG0gLgNVOtsAaYk1t/tWyO+26kASzAVbEEUrI52gsQDtprlMEUfY4fo2kysselSqAUh7HIr7H6yB02TIcx7VFTchjYXFtPRyCnsKIKg74AZCNcx56k/I6cEJcjRfzl412VC0K48byvIu06uuMxIF3MjrKLC0Cl8SrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGgWUaKxeafnhuP9kHAMW3wn1lug/ZLqWSpsV+1V/RA=;
 b=jF4NHtP5jOdFEYgQZBzM1ZeN4ZGAYo9xTfn34QgA8gFf6hVChgufz8Yrzr+eCIoKYEE4/PkmpxhDKLQM5CfxvyIgCa2ulHgFh+9WwfVGBHMdwc5GrstZJjOyAvVoImCVA2lcdjT8ZOLsYl5puvS7pjRGBh/6aWat2u8nDxLjiD2j85VQPXtVSsfSPAoD43Y+8dpfBwTA7L7dJo7K3VYOpawLW+YRnZ45iHhQVku0pmOqVo6LFQryRj7hRDyL0eVzb7N1RYjIts2M6QXDJYtJg4LEZHJYdsJKqiReKYofIWzccMsUIW2H9KubtNoX60qAhjuhRU0khPsNaYjpwDE31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGgWUaKxeafnhuP9kHAMW3wn1lug/ZLqWSpsV+1V/RA=;
 b=ptTynJJ4w51idXi9YE3tlxslRQXkK9DgKyHZ7WkPiSpYQC+UEaVJb4rWp34ECfsTblqBggir0mL8BRzlhzoLeQzkPYVCuFYrujhW6ay41iT60o6rma2is4sRv6Ub/BxaqwvAOvMA5qN1XFV8o8w5648wIDYYJj8JkHMcytYb//ajM/EactAPzG5UMDPzKs/PfYCs1S8LLnAwWTEkv6l+9sKNxeJr8MZw/eWJMYmCKE6hQnNtmQZBR6QlVsIzBEEkerHQ1lqG6bt/sgiDjLu2L2FodXiI8yZE6ZtnHuysIkMZYkk3vCq3KyNWxbU69Vlcs4go/D0RsVsvg4mNyg8Ujg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 17:44:01 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fddf:d4b8:44d9:d378]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fddf:d4b8:44d9:d378%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 17:44:01 +0000
To: "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH vhost v2 00/16] vdpa: Add support for vq descriptor
 mappings
Thread-Topic: [PATCH vhost v2 00/16] vdpa: Add support for vq descriptor
 mappings
Thread-Index: AQHZ8iu9QjfYnf13qE2SCfnrjnsDFbA7fxsAgAADmQA=
Date: Thu, 5 Oct 2023 17:44:01 +0000
Message-ID: <9dfa552011c20a58d8550bd794977de821212df4.camel@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
 <20231005133054-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231005133054-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|DS7PR12MB5790:EE_
x-ms-office365-filtering-correlation-id: f54424d4-084b-4d3f-4722-08dbc5caa931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8IdnlDXlGIxOmarby5L1SQCGolyv3RsZg4mZN6Dg1bGsrKBuPxhOd6fyHqsGFC2eS3pd/b1sf+IMaGCmgwtwnvnihmTFHLJORH/9kHH4WNuy61K8MyIwLVCUOXI7AK1wP6rPxvVS1QlrnXHp7mQC4w+/kBB0lK3iz1iO3YJ/vQcklumSdPbFzXJAmmc2HOs21u8chgYPMhoM3V8j1mxxD8zrRY8N5yDvVO8xAERdip8/+9mEpEGIRGDwHBhweDWOLioUFLP0Xin21wqU2AjIMFHasV3pzR6qSFIuUJKkJxrwjXJsMJGpJaThmdokXtH0wVAxTRR79tObZyZ7qEFoOTkxw6l3LycZJWm6ALSzo++brgCP+ykEJEEOaMJ/l9O0r+spJiBAew3wv1WIj+41qcEMMERHUZj2JlGBVWAuDe5XSmJeJ9JCGijsIh6DJlizRTv3QzL44mDGrsXPD08KvfAVRzJV2v6o1dHn/v8KIAlhLnZisBIC9fX0ivmA9sQE9fzHe6FdLIDfFcsVdkP1Z3R4VncDlY07B33QRoquFziHuB2GGl4pbpQpJHouphNWOPtqrJo9b+p7N207njSr4Uo9B1ZOiGG8/SnhlBewMQvz5EYdR9lZaobaSBzftllfmQDx0ONcvPFl2y6hvSgT6pp5JoMD+vDnN9916p4YA4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2616005)(6486002)(6512007)(6506007)(83380400001)(478600001)(36756003)(38100700002)(122000001)(38070700005)(86362001)(66446008)(2906002)(4326008)(91956017)(71200400001)(76116006)(8676002)(966005)(316002)(64756008)(7416002)(66476007)(41300700001)(66946007)(8936002)(6916009)(54906003)(5660300002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVkyalZFenhTcWpGOWRFSkNoQllSYk1VY0c5LzRqWDJFZXFhdlNJS1dFdEJj?=
 =?utf-8?B?R2RneFZuS2VmcGFBNG56ZVM4SkNhVTRWTEJpY2txSENPNzNpeWw2cm94RTRQ?=
 =?utf-8?B?VGN3eE5JaDhmSXZMcVNnZ2tZeWxUeENTWUF5N2xmZ1FNcXF6Q25zR1QzU3FH?=
 =?utf-8?B?bnpWVFVtaVBBR2JzRUNJMlZsVGtRaVdMdHl1MSt2Y1BFUjFvbkd1eFlKVHdi?=
 =?utf-8?B?amsvdVREbjdjTGJaUFc3Rkk2Z3lMN0tXeFRLbnBwMEIwWVhSWWZBUnFzVDFW?=
 =?utf-8?B?T1pRWmpWUXM3VTh1S0ExelBheXVPbUJ6NDlTMWZvMDR2WDRZQ1hGNFFGcGFO?=
 =?utf-8?B?M0JUMkRLRzVZM0ppR2ZRQXlUUE5Fa25za1hFTDF3VmFmRDhaMzVXTGIya0Uz?=
 =?utf-8?B?QkwrNTMzVGpyV1RBbGh1UHhQUmJnRlVTVnFtRHZrTEZrU1ljZDBZdXc4R2JF?=
 =?utf-8?B?d1RVSnJZamNFa0FoTUVGWHVja1BiVXdvSTcvMEdQYncxMSt3N3RWblhkbFBU?=
 =?utf-8?B?NnRjbzl4RFM1YmdiTjRGUVR1Y0Vvd3NQSEZNN0g1cXVuRWRpMGJXUWZsQ215?=
 =?utf-8?B?UGx4NElXTGpzZEN4WGh5allmNXRjU2xSUG5pelloQ290Slh2bTFiaW5SdHpE?=
 =?utf-8?B?dENkbDRjNW9kaFlxcG0zUE9icVlTYkFOeklWN1BnNHFmSFozeDhQZE9kSEVy?=
 =?utf-8?B?clFEelFOWCtoV1ZZT3BEa214VjV1bnB6ZVFMTmZhbWRVWW5QdVRHVllSQTdn?=
 =?utf-8?B?VlNkTHhIK1NKcFZrUHV2MWwxVmxBbmd5RlMyaXhrOGVTUW5CUzRGelViWGVH?=
 =?utf-8?B?TkljY1dRN2hMbWNjUWVJUXVRdmVvdlBJZlhwZWhUNUEybzFTcVZLbHBzcExt?=
 =?utf-8?B?RnBDYzA0Sm0zdkJRMFJIbGhJWlhwOW9pTTN0Zm5qTFRzdkw5R0hIcXFFQ2dz?=
 =?utf-8?B?N3Nid21vRnYzazQ0UTBCbU9MWU56TEI2WERQeVhIeHY4WmVxVzcrZW1WV3Bm?=
 =?utf-8?B?a25CcVRyS2pQZEs4SFJaS25pMjNCWnZKQlB0aHBPaW9WbTBjemh6ZldOaFd1?=
 =?utf-8?B?WTY0TDBiamp6enZTYlBOQjdQNGhBRW00RDcrMExhOFJKTXVSRUdSTFpTZktn?=
 =?utf-8?B?UEdtU2c2OEErbG9CYUJMSW04WWNGd3l4Y2p5bkRidEdBV0hySEVBckVMak1J?=
 =?utf-8?B?SFNXbmZydUk0ak5uSGpRS0k0TVRtcWQ0OGhwQ0VudHF1NklRdUF0dHNuaXVO?=
 =?utf-8?B?cW0rVVpVWW1Pc3loQ014ZllzenhibkF2blBRc0pWOUx2Q1ZDa2UxTnRMZ3ky?=
 =?utf-8?B?VUs2b25jWUNxdFI2dWhnbFFjMkV2NG9ORDZLTFVBWVJEV0VXa3ZjbFpuS1pH?=
 =?utf-8?B?NTl4TzE3QjR6OStudDR5bDB0S3BhQzVIYUxjQ0cxd1hqd3lRbENSTjlrKzY5?=
 =?utf-8?B?N3pSblJGcXRqcVZhT1l5SkJ6VmVUS1ltdEkvQU5seGQrcElBRjl0RnBlTUxx?=
 =?utf-8?B?cSs0KzliUnhMaUx4SUxxTzZNZ1FlT1JHZnZMa2tWV25jaWZTa1paNUJIS2tF?=
 =?utf-8?B?SG8zeVI5NXkzK1pWREFsK2l4SW9LNTlNekhEenU1dEkvcWdHWkN2REEvK3k1?=
 =?utf-8?B?RHo3NlNHRE1PcUpyRHVBYUtCcW9VNlhWYktyN3hFZGhuT0VoVStZeVU1djNE?=
 =?utf-8?B?M2JXa3NHNGxaMTAvdUtISWhEV2k0WHNndE5KMzFsRFY2amdsalFXL1M2d21o?=
 =?utf-8?B?dExUNlJ1aUVYVUJNV2Y4RmVRb3ZPbGJudWtHUjZVcVVvZHVsV1NzY0FKLzRW?=
 =?utf-8?B?MEhETXRxZHdnYTdORHFtZmtLVUhvMEFSdy9rV1BQTjVlMXlmSWoxdi9YcWNS?=
 =?utf-8?B?Z1o3bHE4WUJrTWRBb3pFMTNuUm0zOHBrcVUxWGtFL0hRZXd2RXlEL3YzTzBV?=
 =?utf-8?B?eWxodEEycmtwT1VWSHVobFNZdlV6QWFXbHJySGdmUFJCbEEwRC9hcERTZEN0?=
 =?utf-8?B?MWJjOGxtTmxGREM4NU9PYUJmMXVGbWI2RWQvMGNCbThPTHZzS2ZQRW0rWDR6?=
 =?utf-8?B?MVNYYS9Ceis4YU9KZHBWVkZhdmlrbVFPdkNhQWMxSWVVckpOUHhqSlZKOFNE?=
 =?utf-8?B?bGU3ckxweng0S204WjFjaGRiVmtXaWs5TXNJQmlQcFUveC84ODdkRjZzT3h6?=
 =?utf-8?Q?DZPkdT5iDOtDE5y998fbbXlcexoAgDd9aVuv2GsGeN0I?=
Content-ID: <5839D0696C5D9B48BE9132C6D8B058E9@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54424d4-084b-4d3f-4722-08dbc5caa931
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 17:44:01.5370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDWjuSgrBAkA722ORLMWeZM3OstB8dQJen1z32UImLMsge4lEmAu2pAF+GM3adSZVdKvkenjCUznYmCXpi6c3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "leon@kernel.org" <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Gal Pressman <gal@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCAyMDIzLTEwLTA1IGF0IDEzOjMxIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIFRodSwgU2VwIDI4LCAyMDIzIGF0IDA3OjQ1OjExUE0gKzAzMDAsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdnEg
ZGVzY3JpcHRvciB0YWJsZSBtYXBwaW5ncyB3aGljaA0KPiA+IGFyZSB1c2VkIHRvIGltcHJvdmUg
dmRwYSBsaXZlIG1pZ3JhdGlvbiBkb3dudGltZS4gVGhlIGltcHJvdmVtZW50IGNvbWVzDQo+ID4g
ZnJvbSB1c2luZyBzbWFsbGVyIG1hcHBpbmdzIHdoaWNoIHRha2UgbGVzcyB0aW1lIHRvIGNyZWF0
ZSBhbmQgZGVzdHJveQ0KPiA+IGluIGh3Lg0KPiA+IA0KPiA+IFRoZSBmaXJzdCBwYXJ0IGFkZHMg
dGhlIHZkcGEgY29yZSBjaGFuZ2VzIGZyb20gU2ktV2VpIFswXS4NCj4gPiANCj4gPiBUaGUgc2Vj
b25kIHBhcnQgYWRkcyBzdXBwb3J0IGluIG1seDVfdmRwYToNCj4gPiAtIFJlZmFjdG9yIHRoZSBt
ciBjb2RlIHRvIGJlIGFibGUgdG8gY2xlYW5seSBhZGQgZGVzY3JpcHRvciBtYXBwaW5ncy4NCj4g
PiAtIEFkZCBoYXJkd2FyZSBkZXNjcmlwdG9yIG1yIHN1cHBvcnQuDQo+ID4gLSBQcm9wZXJseSB1
cGRhdGUgaW90bGIgZm9yIGN2cSBkdXJpbmcgQVNJRCBzd2l0Y2guDQo+ID4gDQo+ID4gQ2hhbmdl
cyBpbiB2MjoNCj4gPiANCj4gPiAtIFRoZSAidmRwYS9tbHg1OiBFbmFibGUgaHcgc3VwcG9ydCBm
b3IgdnEgZGVzY3JpcHRvciBtYXBwaW5nIiBjaGFuZ2UNCj4gPiDCoCB3YXMgc3BsaXQgb2ZmIGlu
dG8gdHdvIHBhdGNoZXMgdG8gYXZvaWQgbWVyZ2UgY29uZmxpY3RzIGludG8gdGhlIHRyZWUNCj4g
PiDCoCBvZiBMaW51cy4NCj4gPiANCj4gPiDCoCBUaGUgZmlyc3QgcGF0Y2ggY29udGFpbnMgb25s
eSBjaGFuZ2VzIGZvciBtbHg1X2lmYy5oLiBUaGlzIG11c3QgYmUNCj4gPiDCoCBhcHBsaWVkIGlu
dG8gdGhlIG1seDUtbmV4dCB0cmVlIFsxXSBmaXJzdC4gT25jZSB0aGlzIHBhdGNoIGlzIGFwcGxp
ZWQNCj4gPiDCoCBvbiBtbHg1LW5leHQsIHRoZSBjaGFuZ2UgaGFzIHRvIGJlIHB1bGxlZCBmb20g
bWx4NS1uZXh0IGludG8gdGhlIHZob3N0DQo+ID4gwqAgdHJlZSBhbmQgb25seSB0aGVuIHRoZSBy
ZW1haW5pbmcgcGF0Y2hlcyBjYW4gYmUgYXBwbGllZC4NCj4gDQo+IA0KPiBJIGdldCBpdCB5b3Ug
cGxhbiB2Mz8NClRoZXJlIGFyZSBzb21lIHZlcnkgc21hbGwgaW1wcm92ZW1lbnRzIChjb21taXQg
bWVzc2FnZSBpbiAxMy8xNiBhbmQgZml4IGluDQoxNi8xNikgdGhhdCBjb3VsZCBtYWtlIGEgdjMu
IFRoZSBsYXR0ZXIgY2FuIGJlIGFkZHJlc3NlZCBhcyBhIHNlcGFyYXRlIHBhdGNoDQp3aGVuIG1v
dmluZyBkdXBfaW90bGIgdG8gdmhvc3QvaW90bGIuIFdoYXQgZG8geW91IHRoaW5rPw0KDQo+IA0K
PiA+IFswXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnR1YWxpemF0aW9uLzE2OTQy
NDg5NTktMTMzNjktMS1naXQtc2VuZC1lbWFpbC1zaS13ZWkubGl1QG9yYWNsZS5jb20NCj4gPiBb
MV0NCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9t
ZWxsYW5veC9saW51eC5naXQvbG9nLz9oPW1seDUtbmV4dA0KPiA+IA0KPiA+IERyYWdvcyBUYXR1
bGVhICgxMyk6DQo+ID4gwqAgdmRwYS9tbHg1OiBFeHBvc2UgZGVzY3JpcHRvciBncm91cCBta2V5
IGh3IGNhcGFiaWxpdHkNCj4gPiDCoCB2ZHBhL21seDU6IENyZWF0ZSBoZWxwZXIgZnVuY3Rpb24g
Zm9yIGRtYSBtYXBwaW5ncw0KPiA+IMKgIHZkcGEvbWx4NTogRGVjb3VwbGUgY3ZxIGlvdGxiIGhh
bmRsaW5nIGZyb20gaHcgbWFwcGluZyBjb2RlDQo+ID4gwqAgdmRwYS9tbHg1OiBUYWtlIGN2cSBp
b3RsYiBsb2NrIGR1cmluZyByZWZyZXNoDQo+ID4gwqAgdmRwYS9tbHg1OiBDb2xsYXBzZSAiZHZx
IiBtciBhZGQvZGVsZXRlIGZ1bmN0aW9ucw0KPiA+IMKgIHZkcGEvbWx4NTogUmVuYW1lIG1yIGRl
c3Ryb3kgZnVuY3Rpb25zDQo+ID4gwqAgdmRwYS9tbHg1OiBBbGxvdyBjcmVhdGlvbi9kZWxldGlv
biBvZiBhbnkgZ2l2ZW4gbXIgc3RydWN0DQo+ID4gwqAgdmRwYS9tbHg1OiBNb3ZlIG1yIG11dGV4
IG91dCBvZiBtciBzdHJ1Y3QNCj4gPiDCoCB2ZHBhL21seDU6IEltcHJvdmUgbXIgdXBkYXRlIGZs
b3cNCj4gPiDCoCB2ZHBhL21seDU6IEludHJvZHVjZSBtciBmb3IgdnEgZGVzY3JpcHRvcg0KPiA+
IMKgIHZkcGEvbWx4NTogRW5hYmxlIGh3IHN1cHBvcnQgZm9yIHZxIGRlc2NyaXB0b3IgbWFwcGlu
Zw0KPiA+IMKgIHZkcGEvbWx4NTogTWFrZSBpb3RsYiBoZWxwZXIgZnVuY3Rpb25zIG1vcmUgZ2Vu
ZXJpYw0KPiA+IMKgIHZkcGEvbWx4NTogVXBkYXRlIGN2cSBpb3RsYiBtYXBwaW5nIG9uIEFTSUQg
Y2hhbmdlDQo+ID4gDQo+ID4gU2ktV2VpIExpdSAoMyk6DQo+ID4gwqAgdmRwYTogaW50cm9kdWNl
IGRlZGljYXRlZCBkZXNjcmlwdG9yIGdyb3VwIGZvciB2aXJ0cXVldWUNCj4gPiDCoCB2aG9zdC12
ZHBhOiBpbnRyb2R1Y2UgZGVzY3JpcHRvciBncm91cCBiYWNrZW5kIGZlYXR1cmUNCj4gPiDCoCB2
aG9zdC12ZHBhOiB1QVBJIHRvIGdldCBkZWRpY2F0ZWQgZGVzY3JpcHRvciBncm91cCBpZA0KPiA+
IA0KPiA+IMKgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCB8wqAgMzEgKysrLS0N
Cj4gPiDCoGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuY8KgwqDCoMKgwqDCoMKgIHwgMTkxICsr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gwqBkcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L3Jlc291cmNlcy5jIHzCoMKgIDYgKy0NCj4gPiDCoGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuY8KgIHwgMTAwICsrKysrKysrKystLS0tLQ0KPiA+IMKgZHJpdmVycy92aG9zdC92ZHBh
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyNyArKysrDQo+ID4gwqBpbmNsdWRl
L2xpbnV4L21seDUvbWx4NV9pZmMuaMKgwqDCoMKgwqAgfMKgwqAgOCArLQ0KPiA+IMKgaW5jbHVk
ZS9saW51eC9tbHg1L21seDVfaWZjX3ZkcGEuaCB8wqDCoCA3ICstDQo+ID4gwqBpbmNsdWRlL2xp
bnV4L3ZkcGEuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDExICsrDQo+ID4gwqBp
bmNsdWRlL3VhcGkvbGludXgvdmhvc3QuaMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOCArKw0KPiA+
IMKgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmjCoMKgIHzCoMKgIDUgKw0KPiA+IMKg
MTAgZmlsZXMgY2hhbmdlZCwgMjY0IGluc2VydGlvbnMoKyksIDEzMCBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiAtLSANCj4gPiAyLjQxLjANCj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
