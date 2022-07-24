Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBADBC43334
	for <virtualization@archiver.kernel.org>; Sun, 24 Jul 2022 15:21:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 799BB40C4C;
	Sun, 24 Jul 2022 15:21:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 799BB40C4C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kLaurm5B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gt6NcQI1qj1y; Sun, 24 Jul 2022 15:21:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AAEDF400B9;
	Sun, 24 Jul 2022 15:21:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAEDF400B9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C4AC0035;
	Sun, 24 Jul 2022 15:21:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB3BC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jul 2022 15:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 035CB424E2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jul 2022 15:21:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 035CB424E2
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=kLaurm5B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7mWkwMefoFe1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jul 2022 15:21:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBDE9424DC
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBDE9424DC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Jul 2022 15:21:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8wJaeUcronGlJAuWZ2Pvy0Hbu7xd60cWnx8cYp1bBFGilhnw2guMGOSAzs3FQ5BjwIyzziNsGpLI3sWgtEiSQbSorU+ypnZSa6GddC4ukVTsRtwkpnIDwzKgmUFS55QIOaNtdATQPIF6htrIG9dPviqB5twK04tR7sAaSQHdJ4uNJ7tgEPnqcjKcMrdazkp45UyxBwWcbMXsLICAapdfzOYXeKKdpPtCaKobfK2G2zlT6lDYpsenGw0RSj0UxTpJvqtbFYUN8O6A1KfWlhjoSWGYmD2xv19BNcEbR79LTJB2LBDAfL1OkHTWTH6xixas+PIQ9O3h311YrCmZMaBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7uTgfQiTBuCu4zbOWms2i94DCu6g5IlaoP30tgoPuw=;
 b=bdG+7QgXuYg5p5AouVGPpUOTmLz8int6N+EpYiblrLLnOUnk21EvI35k0arn9v3miaOWoTYAn/PRjFqaNXYKOXKhOLZ+AdzuJcb1uriznh3Zv7Q/TlzbWqogtgg8eerA6GzbPAfck/30455oOh7lbf16XOquRUbvZrBmzvC6gHCauXqOPpEF1L4j1J7pJdyyfd7V4lV3Qsh3s+4AEwuGPENB0G4ZEA1qPkMvyJImrnfhBNyWiu94Rpl2FBqKRUhv0eLPrnYavuiXNxaInfaHqUgELxdo+qJKXq1whbVJBbBvUX0zb1UBBu9m8GNRA3PkEKQLarZA5slE5FFFPatHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7uTgfQiTBuCu4zbOWms2i94DCu6g5IlaoP30tgoPuw=;
 b=kLaurm5BwwDROjhQt/MtVgKKBLMdwyvjFBgtso/4u3YrktYJ+d7kXVBddNVTGl+272ImeUOBCVkTFfjVGKmmJIshYxgRD0rxV5RDJzrbjVgLiflRueOOTO4VS5BieYemL0bDww+j5Xw4dqMOdT3gUKHkpdhy3H3MYrFgSxptf+bh3cwClvjPFV+/KE8Q+kRpai9kwrPnWrAaJpFimOkICBNXHzLjYr+/yTQ7TTUJ6aOow9BuPpS1HYa+7hbDY3DG5XUzYCQay5dD10YsoCo8LsWssem7mrP4VfCU44m04Yi5Z3Q6wB6ZDdEwJwJfASOCtDzIov/9oA/2SYzeJxS6tw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BY5PR12MB4804.namprd12.prod.outlook.com (2603:10b6:a03:1b6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sun, 24 Jul
 2022 15:21:32 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::544b:6e21:453e:d3d6%9]) with mapi id 15.20.5458.023; Sun, 24 Jul 2022
 15:21:32 +0000
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH V4 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Topic: [PATCH V4 3/6] vDPA: allow userspace to query features of a vDPA
 device
Thread-Index: AQHYncLBTkGC7Q3QJk+hIdvX3SqZ2q2KXRuQgAF0rYCAAdS1UA==
Date: Sun, 24 Jul 2022 15:21:32 +0000
Message-ID: <PH0PR12MB5481D9BBC9C249840E4CDF7EDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220722115309.82746-1-lingshan.zhu@intel.com>
 <20220722115309.82746-4-lingshan.zhu@intel.com>
 <PH0PR12MB548193156AFCA04F58B01A3CDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <6dc2229c-f2f3-017f-16fa-4611e53c774e@intel.com>
In-Reply-To: <6dc2229c-f2f3-017f-16fa-4611e53c774e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6bf8bf8-0fc8-4ea5-9ddf-08da6d8830a7
x-ms-traffictypediagnostic: BY5PR12MB4804:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42OqS3H0/lkvDNIULOChVweH1a8s1zI+j0xMonBXmhYUeIseyn1J4k9jJwXHo+i80yMWFuGRoKQ3vjNQdjxyV5amlL0u9buWlnD6+sAOTEQs+MnJweCjN6HdICDz0+5bexPLwFq2NHQleF+J3qYU7OSeUGpswVbY4XiqWZ9tim7wWUEzLa1nW97RlSayRPJvMKyYCXaIu5DjeUmm+0sZOFG4dvpdV7XA3wtPzSjgW0WyqPQLi47uC2FZDcD7PRnXku9jOnUmyGGG2WpD4wCI7cIJO1mTBmzNnLR9yKT2hHQgqwSWFnM4F2bLMRA1xroCA+Jq0BQMceV3zU+XF94UJb+ibTjhqehB2OUdwFPigaJbiEBPQxV3hqfbiuvmomn2vxckTRcz/gHDAsDzJW9eVdskY1pAkez+KLv9HzHJD+J5fnp/03TEfQxuCc5NBY4t8z19QUdEfXZt+tHmUFmDJ2aw8Hms5bhbSFMSAOwY2GnbBfZ3ZIcraI7sc9gz0Mo0GMXiRuM3qAoPBAD4g0pawfRfzoYlnaka8D2RQWodR1siIdKZQztabBy3uicMGw5Sj+ZPBzLuiEYCjyweqW+yJy/Gq1ERApe/Y7I3uIEnNOvKUNqA27mXwwgBouXXAg55ph/xbMGutiRp+fn8i2E0pogCawmczumWhDz/fbhu2oP2t69eFKGjwYDBw0qV2fTrx6yI7iHYrY11lOYmCaBITPBjiLzml03XdYL/WwJxbzo3bFAGaluBlymgdPPgHMfQE6nOVwZ7lJliH1uAKCxDRdTPitHb8gGxDki7zYn5EeH1ybeNShotLOClNQC/nXDi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(38070700005)(86362001)(33656002)(52536014)(122000001)(26005)(6506007)(186003)(53546011)(83380400001)(9686003)(38100700002)(7696005)(41300700001)(71200400001)(110136005)(54906003)(478600001)(316002)(4326008)(66946007)(8936002)(66446008)(64756008)(66476007)(8676002)(76116006)(55016003)(2906002)(66556008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFV6R3YxMTczdXd6dFkwMXRQUkNOS3g2NE9rRy9nczE3Nk1tZkhENzQySHcx?=
 =?utf-8?B?Mys4amZKZFU0UmQ3azFva3pVTWMwNytIK21jaFAvVUNIbWFnTjV2RU1CQ3d6?=
 =?utf-8?B?ajRyUERkWVhIRXR6amFmcDc0UzV6MGlaakRKTlg2LzF0dkxNaGZZY3pjc3RC?=
 =?utf-8?B?YktBUnZNVndLaUpYdk9pNWlpNDhpUjVMam9QOXBNMnoycTdZVlE1T0JTdzQx?=
 =?utf-8?B?WWI0RVcvY3YvcWpKVy9GaE1WRXFjVXhBbVl4Qmc3NloydU5GWFY5dEZENEF2?=
 =?utf-8?B?VFp5THA1V280TWlFUFlkVnQwOUVYTjVoMThzMlg5bXE1ZXBYNndJcUhTV1Ra?=
 =?utf-8?B?dWtKRWNlVjVjRFFLNHFucFlycVE5U1V1dHJ6eGxUcEgyQVMvcUliWnJwbGFk?=
 =?utf-8?B?TUZQREZQemZMaVNhUER5WFo1T2lrREZ6cWc3MVRaUFNnSmRqdHlSZSsrRG4w?=
 =?utf-8?B?b1RPVDZJVmFkZTJrbHdGTUZKYmJ4a1FXcklMSDNPSXh6bGdmY1NkTFpZaUhH?=
 =?utf-8?B?YUtXR1ExWW5GR0hxMmVZNDNvQ1laeW5rWDlvUUJTdjZ5NmlKRWo0ZllEbURE?=
 =?utf-8?B?MTVFcTRMd0lEcStJQzA0VkdGbmNUSkpZRFdPREp4bkpsZERqUytDcVF5aFJY?=
 =?utf-8?B?UXByaU84aEtwSjJWWXBPUVVvNG5SUy9hVjdlT0srWE1FSEMva21xWDlFMktx?=
 =?utf-8?B?M2dHNHgzOUxlNUNxOGdaSWg0ZTBYTVJUUlpTQWlWdjlSdmI1SHJqMzBFcDdI?=
 =?utf-8?B?NmxPZHA2TUZJaldPZU1GdTFlalk3WG1RTXBHTGp5ampzSHRjMkJOd1BPcFN1?=
 =?utf-8?B?S0haUFBjNk1xN2dwOGRRNUt1SDFWN25hUzB0RGpJd2FOTXBVdHdpbXFYUFA5?=
 =?utf-8?B?bkJOZjg4RzZWNUVVZjFtQXBoTTdQOGFyMk1vNVBvMzl4OWsreVJCSFRmWUlX?=
 =?utf-8?B?RTN1VHlxMStNeGw0LzJxRld5Wk5FelI1cE5FWmlvQjdxcnV0VUllV1BpNmd1?=
 =?utf-8?B?ZzVQeGpackRWV0tNdHM2NVNxOTFwZ2lKalBxN1lZWDk0bGJTWEd0RW1WRDdv?=
 =?utf-8?B?VGEwOXlSd0t3STBvd1FPOEJMaDdiN3VnSkhCL25ZS2kwbnIwVEdtcDg5Y0hj?=
 =?utf-8?B?em9tUGNzUW5UTnpYSnVadWZMSHZIWE1VR0FDem41c1dXR0ZsbzZtczYzN2xO?=
 =?utf-8?B?Z3RuL0JNNmNXQVYwUGtyOGdwa2o4a0R1S24wcmhGbGxaN0Y5aFNYeHpwcnFy?=
 =?utf-8?B?VVU5dWlLRXpOVjBjYjZza1lxdkprSXovMnp2VklTenRDSzNVM2ZGaVRUbmxj?=
 =?utf-8?B?SWd3SHNOU2p3a0dPTno2ZTgySzV6Wnlad3h3UVVLamgrbHg5M2NvbkttdTNq?=
 =?utf-8?B?eU0xYzN6TVkyMEphQ3RZd2crWEk3bjhZUUJmaEpRRDFjYXlib28vRUVOUkNC?=
 =?utf-8?B?RlI4ZjRkb2o5QzI5UFRVNWpmOFhJQmZZbjdROUgvV3ZWTDR3RENZTm9OS1lq?=
 =?utf-8?B?bFJ0Z1JXUW1pYzZuOFJmdTg5NnpSTE42cHJ0Y2lpOEtEbHRJOTdZQkE0RUFX?=
 =?utf-8?B?UENac2lVVlErR011VnU1RkRHMGNwd3BtUGd2TzlVaXQ1QnlqaVZia0ZmOXZp?=
 =?utf-8?B?NEFVMGNKcnhyeHlCemFpRTlQNzFBL1oyem1LTkdCS3BSeUdGSlpHRndlbWJl?=
 =?utf-8?B?RUxEK05VeVdKUWkxU0JSWVh4QkxseXdWMFhWZnpyQ3BoaWR3L3FtazQvQTM0?=
 =?utf-8?B?QW1EQkp2NGs2NTdObEtoNytyYXNhdHFLRTFFQ2NiaEdQeTFRQWwxZ3huaFVh?=
 =?utf-8?B?SWdaemtDWFg0bnQwV1VRcTRzVmtaOGR4Qk04OG1EYkRqWXpkWHBKUkVicTlC?=
 =?utf-8?B?MXpKOFlQdHZjeFFlWnVOQVl0Nm91Skc1WklpRDVGZk5xcDlJVjRjL0o0ZXlN?=
 =?utf-8?B?cGk4Si9oWjltTC8vOEZkZm1lM2c4ckovV1hYSThXcFpCREtjRDBtOWtXM2ty?=
 =?utf-8?B?ajRtQlkwOWxUV2JkSU03WmgrWG9wRDg2d25QbUtDZktla0J2YzdqUndPRTgx?=
 =?utf-8?B?aiszaVFhRmdUUld6OHRnZ2hHZ0tPdGE4ZXNMYXJSR3FVUTZVbGMyWG55R0lk?=
 =?utf-8?Q?6rtw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bf8bf8-0fc8-4ea5-9ddf-08da6d8830a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 15:21:32.5305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpnVyEzOWaqec8EeSJhwku1Y8qmU0OzO0gRsZr1M0sHUcblEkheiFO7P5wXXJkL3xjXPcoCpP6cu1JJeTuDkHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4804
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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



> From: Zhu, Lingshan <lingshan.zhu@intel.com>
> Sent: Saturday, July 23, 2022 7:24 AM
> 
> 
> On 7/22/2022 9:12 PM, Parav Pandit wrote:
> >> From: Zhu Lingshan <lingshan.zhu@intel.com>
> >> Sent: Friday, July 22, 2022 7:53 AM
> >>
> >> This commit adds a new vDPA netlink attribution
> >> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> features
> >> of vDPA devices through this new attr.
> >>
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   drivers/vdpa/vdpa.c       | 13 +++++++++----
> >>   include/uapi/linux/vdpa.h |  1 +
> >>   2 files changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> >> ebf2f363fbe7..9b0e39b2f022 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -815,7 +815,7 @@ static int vdpa_dev_net_mq_config_fill(struct
> >> vdpa_device *vdev,  static int vdpa_dev_net_config_fill(struct
> >> vdpa_device *vdev, struct sk_buff *msg)  {
> >>   	struct virtio_net_config config = {};
> >> -	u64 features;
> >> +	u64 features_device, features_driver;
> >>   	u16 val_u16;
> >>
> >>   	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config)); @@ -
> >> 832,12 +832,17 @@ static int vdpa_dev_net_config_fill(struct
> >> vdpa_device *vdev, struct sk_buff *ms
> >>   	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> >>   		return -EMSGSIZE;
> >>
> >> -	features = vdev->config->get_driver_features(vdev);
> >> -	if (nla_put_u64_64bit(msg,
> >> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> >> +	features_driver = vdev->config->get_driver_features(vdev);
> >> +	if (nla_put_u64_64bit(msg,
> >> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> >> +			      VDPA_ATTR_PAD))
> >> +		return -EMSGSIZE;
> >> +
> >> +	features_device = vdev->config->get_device_features(vdev);
> >> +	if (nla_put_u64_64bit(msg,
> >> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,
> >> +features_device,
> >>   			      VDPA_ATTR_PAD))
> >>   		return -EMSGSIZE;
> >>
> >> -	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> >> +	return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver,
> >> +&config);
> >>   }
> >>
> >>   static int
> >> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> >> index
> >> 25c55cab3d7c..39f1c3d7c112 100644
> >> --- a/include/uapi/linux/vdpa.h
> >> +++ b/include/uapi/linux/vdpa.h
> >> @@ -47,6 +47,7 @@ enum vdpa_attr {
> >>   	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
> >>   	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
> >>   	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> >> +	VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,	/* u64 */
> >>
> > I have answered in previous emails.
> > I disagree with the change.
> > Please reuse VDPA_ATTR_DEV_SUPPORTED_FEATURES.
> I believe we have already discussed this before in the V3 thread.
> I have told you that reusing this attr will lead to a new race condition.
>
Returning attribute cannot lead to any race condition.

 
> Pleas refer to the previous thread, and you did not answer my questions in
> that thread.
> 
> Thanks,
> Zhu Lingshan
> >
> > MST,
> > I nack this patch.
> > As mentioned in the previous versions, also it is missing the example
> output in the commit log.
> > Please include example output.
> >
> >>   	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
> >>   	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> >> --
> >> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
