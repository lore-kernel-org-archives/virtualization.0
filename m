Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE75CD8CA5
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 15:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8131E822AD;
	Tue, 10 Oct 2023 15:58:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8131E822AD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ApOvVx7p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wVs6arvkiuWr; Tue, 10 Oct 2023 15:58:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A33AF8228C;
	Tue, 10 Oct 2023 15:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A33AF8228C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F4EAC0071;
	Tue, 10 Oct 2023 15:58:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63784C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DE8E41921
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:58:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DE8E41921
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ApOvVx7p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AeivXqRvto31
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:58:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CA854191D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:58:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CA854191D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxv2Pow47e4F0KxKKFkUhwwwfJJS8kZGsb0EE5TO/CsDhL0nJA5XpNLeNMmyP689MQ2Ox0zTmzg2aTMm2LGHErJ0+tvokq9lvBC4le6ulkv1Xjv5oKIvSJGXIe2TIqVcoCgPbKhnBlC6tuOmUpvQeMjLdl2oV+/Vgv/iJAGIyDTtgOeVexHfwRKTjXBHbxY0ReVqbPhcb87Dw+bsJsIJhed+6WmoQr+2kI9bjR8FAgW6Sw8RwhBlbqBkIN0ih8c2SyT0PU9LFDCXDu7aLx9nT5OrO7Y1ul1f1jnNRmuO/Z2P7OOsvnayxKEbLJOGEancOiixhz6BT1igxCeUfXyJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP8RR3zm30JBolX6uM1q3atIsbZB8GlS7rJmxU1FShE=;
 b=dDbQVBYQsV+CzkJTrkkZwd624ztgc8lML1TLMMh8jsXe2pEstkG+4er0lGt/XfboTWJE0siT4SGsi8AK7+388/iOcG5096wTo9TQ115rNWjCvgOCYIUhZblddpd0g39upMv8Bs9Ta0Z5dsE8eCEXBumpJpV3LlRXftt1cRbn4CsiCu3DuL4ZrzzU2r45BC+cdFEhH0JdVLwst1tjVVF+LwN4VC+YKcn88oFJWDs1XLcmFzWZUbSLEuOmdiuFyiFDm6qSx5xaMGlRdWbOStd67OAjzB7AhPHh4Otxy6sTQyO7sgK91yuag8mWQ0mHWW1TIX1iwyQnfO1CafB9A4Nfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP8RR3zm30JBolX6uM1q3atIsbZB8GlS7rJmxU1FShE=;
 b=ApOvVx7pGx0OISZM3becNhkr2m0iQ44st26Ch3ogOcuhL/nYmlZ/5SrAliP0VjNfRWzZBSCnnzrbmPYusgpi2JN4+OrqxS214/qmQZ10HneDhyUWIAoGagby8M5lBTJISsJIYMum6ACaLQWtvKQ4XDdUEPmeBiAYA8iFpHaYEarNYQivbTiWDP25BPWvNm0gjxSKoWRcJjxu+zns/TNzrJkFS2zjg672gnSyffh8FMX4kDPTWGB/WWM3/PTLbfDAvqFCYS4Bod4D3so7ApzKFg9xQOx0zUjTp/c87ASQZhrDFiBCgB6++fo1MzvnUUIEv74DByn5v6qkVsxsVntMHw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 15:58:13 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::23d0:62e3:4a4a:78b5]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::23d0:62e3:4a4a:78b5%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:58:12 +0000
To: Yishai Hadas <yishaih@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over virtio
 device
Thread-Topic: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Thread-Index: AQHZ7IkOMX5QOSCSWUux5r7dl0LIwLAmnGSAgAZfpICAAAe+AIAJFnQAgACSqACABEvdAIAAJyoAgAGzmoCABkm1gIAADLUAgAADlYCAAAy8AIAABEkAgAABdACAAAf+AIAAAzDg
Date: Tue, 10 Oct 2023 15:58:12 +0000
Message-ID: <PH0PR12MB54811D2D27041A6554FC3B48DCCDA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <ZRpjClKM5mwY2NI0@infradead.org>
 <20231002151320.GA650762@nvidia.com> <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com> <ZSAG9cedvh+B0c0E@infradead.org>
 <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
In-Reply-To: <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6580:EE_
x-ms-office365-filtering-correlation-id: 965d5dc1-e7b9-4e2a-4768-08dbc9a9b4f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdreSLlcJtLcifqUioFnD6WrpJM45tf9OY5iJFdDnLnz+4ccnfQas3K0lR1FO5sCxRGzBDU8SKktrJS8HHZBLc/J90tRnJiZ79MynlHXG9AHrAJTASdWa1w1Daid6vVZJMzMnZqxPthB23rFTqW3SKKLN1O682xyjIp742iufp+/F6hrpGzTbW6rNR1GLiSvQBVHWHdqgiaFpxV+2dNEhMW4JgzZdz2/GHZVQfmOhf6IvZ8MPIw3Qfn8z14ErBuagYXv2IWgu5e/C45ljpd3rO/ZjxZTbsgxTtYiEuZBZT/mTk9vWs/I2+LL1n+01cbh3fN5P5YF/YMEUZUOSkbx3kQRdCoDUFs5Xkazet7LYXetjrGxEkQm1Rhq5qWBTX0HA9VSooOcSTEOHFAGyJK9cOMkCifxDqZhY24S4vNctEfmcOAwLCT0D5fPSC9FVq6wH4lMSvk1b5XkZsTWJyCOyf+46oz20bueU+nW0yt7gMG35nxE7STjLhGvKt3TRG31NX+BB7sp9u17weLSPcnFwzSwXfQN1Upxs8EnXdZa/kCHglK4NuxeixRCTUHrtodQ18W+L50Aevmd7hzuGULTpK+4B18Ou28FKC86yhujtIBbkLAAVegBOSV+kPSQjypy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(53546011)(107886003)(9686003)(7696005)(6506007)(478600001)(316002)(41300700001)(71200400001)(83380400001)(2906002)(66476007)(76116006)(66556008)(66446008)(110136005)(5660300002)(54906003)(52536014)(64756008)(66946007)(8676002)(4326008)(8936002)(26005)(38100700002)(38070700005)(122000001)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3l6ck01TzJUTC9ybEpCdlp6N1RnQnBPOHR2UWhPMG1BVGEwYWduYisrZXpB?=
 =?utf-8?B?WnNpV0lka1RIMUxST0tCUUVCckU1ZHlUaEJ4QlNqS3NFYUNtYWM2azYvY2Yv?=
 =?utf-8?B?aE11Q3NLRTE5aTkxc1RUSEdFK2Z2SXBxYUhGaXQyZG1QeW1pbGNSZTRtNEU2?=
 =?utf-8?B?bTRCYTd2Q1BPOStaL1VGdnlSN2d3bEhsK2U3ZE9WWEtrWXpYdzYyT1pBNHJS?=
 =?utf-8?B?TGprT0tVME1IZnNjOHkvMndUMmxPMW11MnVZVnZ6T002dDdqVnFTZnNma0ZK?=
 =?utf-8?B?aUtGRjRzYXVmMU5CMVN2NXBzeUVGY2tSNTU3ajFnamdCVzB6VzRPWXAxUVh1?=
 =?utf-8?B?WnhZOXk3S3RtQkQxeWs3R1dvazRrUithMHR5b0M2K1YrRlZHekthYUI5bnpj?=
 =?utf-8?B?Y1Q1ZTJIT0RQbC85K3JTa1dCMHhCQS8rSmpmWmNwRWEzMUJHbDRUcXpmWGli?=
 =?utf-8?B?SStWT3NhZCsyeklLY1RzMitaY3I3dFNRL2NiQjdUL2ovTzRNMmpudDN2RlFG?=
 =?utf-8?B?YTJGNmJ3c3A0Ky90UDNDa1NNUFRzcUxlVGlqajdZMHZUSXNDcC9naHNWcGUz?=
 =?utf-8?B?T21FSU5Ud20rNThMa3cvSzRtL0RwZ2ZXTG1QQ3VVM3haNitRaUtuR24vaFZB?=
 =?utf-8?B?Rm9SMHNSOTdjNXZXUllUS0VWa25yWncwWUtjKzRhRmp6NEpITUhVSTBoeTdq?=
 =?utf-8?B?bzhDVlduMFd6RmdsWTNqeDVldmpEOGpqclh1OTNKNUIwVTVWRHBoeW44WWVw?=
 =?utf-8?B?YnlEeUI5NXIrUms1VEhBcjRtL2hZem9iV2t3ZG9zdFN3azZNQXlwaExuVlU3?=
 =?utf-8?B?MldOUTcrNEc5bjFKV0sxZkQ0TjYyS29IKzl0NVFrMjZjVEZFV2ViQVhoazhE?=
 =?utf-8?B?ZFhoRk4zRkM5MVo4MTFiS2JWZnlMNGNNTm9zZ2tYaUd2cXdNdTBFcE9qNGh5?=
 =?utf-8?B?eDh5aSsvQTNxc0pzbVVPbkZja2tRejU4VTFrUjRPVUlIaCtmeGtYMlBvZm51?=
 =?utf-8?B?NWNOOHdscHJDenBBQzAyUFhiZTBwQnVnYjg0d01TN1JNZFhLTG5jZ0Jva0RG?=
 =?utf-8?B?dmJucVlRYUgxOTU2b1IzeHpCdWo5K2h3djZ0T2V1eU1zeXlXY2ozQ3pBK1NB?=
 =?utf-8?B?UVFCeVY2WlYwZHBPczBGazVodU9JcTRtamo2d1dmdkxUYnNzWDFvMGpmVUNm?=
 =?utf-8?B?aUNiWWVqZWlSNHFndWRyeldYQ3BsaGF4aFdQS3BzK3pvcmcrQStVVituM0Uv?=
 =?utf-8?B?Vlg5OEp0NkVTaWZIN2hoS1lWZFNsSVZxR3FXTWlUbU9WWVJpSS9pdlNSZnlq?=
 =?utf-8?B?eUE0MVNldlRnRFZkV0JENERtT2RsR1plNjR2cGhMS3FabHpuQlNCVHhwK0lw?=
 =?utf-8?B?VU1vTlBScXJna2dWL2E4MU5NNWtNbDdHcjdCYlFPY001SUU2V0t3bUduSThC?=
 =?utf-8?B?OFk1TFlHeHpHTEpnemRUVWlxRklWclRnL210blFqVDRhOU4yTzlOWjlyOFpP?=
 =?utf-8?B?Um1XWTJkNy9pSDlSN01LUWE2VXZURkdsZFFNUW56ajQvaVRJNGE2ejlYaWt1?=
 =?utf-8?B?bnYrTVh2OVhmU0xDY1BGNGpHTVQ4b2RUdW82Z0ovT1h1T0IxS2pLVEpkd2dw?=
 =?utf-8?B?eXovUmZsRzVjNXFJT2hOTlZySVBBNlA4aHh4UlZSdHhUd3F4Y0F2UWhrbTRK?=
 =?utf-8?B?Nlh2bXVtSmxKQVh6SklJU3hDT0gzT3hibDdwOVlsWEtSTjhjYzNNeXRxeEw4?=
 =?utf-8?B?UVpIMmRmWmx5OWpvcDNMMWovdi9LVGtLakgzRFdSWTBxYzZYeWQxRGQ2WTEx?=
 =?utf-8?B?VUlpV1RMOU9INTRCV2pLRVBUd1JDZ3FGNHlIaVJ0aUFnMnZFRzNEeUgrcjhy?=
 =?utf-8?B?RUJNVCtkNWZ1L0NEanJRMXRINy90UXptSEZjc3lGdllHWnhWb1g1MFdKR1J6?=
 =?utf-8?B?MGpqTEpqMWhKMkxOYlNyREl6WFRYaU1maE9aOFZwaG1ibDFUb2kxQXJTclZD?=
 =?utf-8?B?TStVRG1QNTdZbzVZeGFOZTk3YUNLWitIaHRTZUQxOFF0SHhQUExCNXBQSkdt?=
 =?utf-8?B?T3hDR1ZUaUpjYWExbG0zTkhrT2Y4RDdpL2R3T2d4RTdLWjA4QXlpSnJwYXR0?=
 =?utf-8?Q?xH/Y=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965d5dc1-e7b9-4e2a-4768-08dbc9a9b4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 15:58:12.5337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WiYcxqTGgb/UZ2jVMeX4LjjA0DvUyd0e7OODawJMQQvXH2yuJU+W6tlAwTLkj7VQChCFeP+2hgZxNluB+sMoYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Yishai Hadas <yishaih@nvidia.com>
> Sent: Tuesday, October 10, 2023 9:14 PM
> 
> On 10/10/2023 18:14, Michael S. Tsirkin wrote:
> > On Tue, Oct 10, 2023 at 06:09:44PM +0300, Yishai Hadas wrote:
> >> On 10/10/2023 17:54, Michael S. Tsirkin wrote:
> >>> On Tue, Oct 10, 2023 at 11:08:49AM -0300, Jason Gunthorpe wrote:
> >>>> On Tue, Oct 10, 2023 at 09:56:00AM -0400, Michael S. Tsirkin wrote:
> >>>>
> >>>>>> However - the Intel GPU VFIO driver is such a bad experiance I
> >>>>>> don't want to encourage people to make VFIO drivers, or code that
> >>>>>> is only used by VFIO drivers, that are not under drivers/vfio review.
> >>>>> So if Alex feels it makes sense to add some virtio functionality
> >>>>> to vfio and is happy to maintain or let you maintain the UAPI then
> >>>>> why would I say no? But we never expected devices to have two
> >>>>> drivers like this does, so just exposing device pointer and saying
> >>>>> "use regular virtio APIs for the rest" does not cut it, the new
> >>>>> APIs have to make sense so virtio drivers can develop normally
> >>>>> without fear of stepping on the toes of this admin driver.
> >>>> Please work with Yishai to get something that make sense to you. He
> >>>> can post a v2 with the accumulated comments addressed so far and
> >>>> then go over what the API between the drivers is.
> >>>>
> >>>> Thanks,
> >>>> Jason
> >>> /me shrugs. I pretty much posted suggestions already. Should not be hard.
> >>> Anything unclear - post on list.
> >>>
> >> Yes, this is the plan.
> >>
> >> We are working to address the comments that we got so far in both
> >> VFIO & VIRTIO, retest and send the next version.
> >>
> >> Re the API between the modules, It looks like we have the below
> >> alternatives.
> >>
> >> 1) Proceed with current approach where we exposed a generic API to
> >> execute any admin command, however, make it much more solid inside
> VIRTIO.
> >> 2) Expose extra APIs from VIRTIO for commands that we can consider
> >> future client usage of them as of LIST_QUERY/LIST_USE, however still
> >> have the generic execute admin command for others.
> >> 3) Expose API per command from VIRTIO and fully drop the generic
> >> execute admin command.
> >>
> >> Few notes:
> >> Option #1 looks the most generic one, it drops the need to expose
> >> multiple symbols / APIs per command and for now we have a single
> >> client for them (i.e. VFIO).
> >> Options #2 & #3, may still require to expose the
> >> virtio_pci_vf_get_pf_dev() API to let VFIO get the VIRTIO PF (struct
> >> virtio_device *) from its PCI device, each command will get it as its first
> argument.
> >>
> >> Michael,
> >> What do you suggest here ?
> >>
> >> Thanks,
> >> Yishai
> > I suggest 3 but call it on the VF. commands will switch to PF
> > internally as needed. For example, intel might be interested in
> > exposing admin commands through a memory BAR of VF itself.
> >
> The driver who owns the VF is VFIO, it's not a VIRTIO one.
> 
> The ability to get the VIRTIO PF is from the PCI device (i.e. struct pci_dev).
> 
> In addition,
> virtio_pci_vf_get_pf_dev() was implemented for now in virtio-pci as it worked
> on pci_dev.
> Assuming that we'll put each command inside virtio as the generic layer, we
> won't be able to call/use this API internally to get the PF as of cyclic
> dependencies between the modules, link will fail.
> 
> So in option #3 we may still need to get outside into VFIO the VIRTIO PF and
> give it as pointer to VIRTIO upon each command.
>
I think,
For #3 the virtio level API signature should be,

virtio_admin_legacy_xyz_cmd(struct virtio_device *dev, u64 group_member_id, ....);

This maintains the right abstraction needed between vfio, generic virtio and virtio transport (pci) layer.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
