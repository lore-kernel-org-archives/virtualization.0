Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3493EC761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 08:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C323041600;
	Tue,  4 Apr 2023 08:16:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C323041600
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=QJAxBQX7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CQCdpaVUgfW1; Tue,  4 Apr 2023 08:16:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EAD1741679;
	Tue,  4 Apr 2023 08:16:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAD1741679
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A50C0037;
	Tue,  4 Apr 2023 08:16:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40922C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 08:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2513881B53
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 08:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2513881B53
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=QJAxBQX7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVsG0X1c5-mV
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 08:16:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8252381B3E
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::602])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8252381B3E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 08:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDyXmq1Em0TRicR98e2F72jCMqXv4Jvz2bZhJCNm9V/zNRz2gb5hKApUpE0TDCSaf6QpTFJULjLhaOXY4ZMTwTum4BjwfuJOO39hWjAkIV2/hyeblzmr98R6654A5Q82MaQkef8EbbXmn4oHPmE9oOvVTUXszGIXqPgDDOCCq5fe6mhAe1SKioBZ7V/NCPzL8TrLYxeYiEXvrufHLtXoHDY4ROWLpQb4EnyQj1rI2QtIuzz8dtd8f3S9Z9FLAyQC/bpMhgPMPbhr8CPKhwHBOP8De6ypEJO0kAAcglxLvgYnDhAkZEoLAy0AONnp1iJx7DDAhwRDpmeGwCZYQNSnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scEVoak6OROzadWKxqh5NgHFkHWBfHGyFQ6HAbeHqU8=;
 b=B7Y/OcK95a5zWYmPBeyXBQx2GIgObmheu0Dyud94Od4UpLke0ahl78udaRl2g+j7LoVG8CAaTudyh33KcUtvMh3Np0Un7xQ9SSyow4DHrAIjqecxT3voqUPoDj1eBCtccTB4Zt5WFDJ4iT4OkANBA9XBZy+/dqyUeJJ0MFwcE5TNv6dCL/IzJUpne/cnGlq8L/2Xs0v6tOBFjUNe1xIGd068GXJssVAofGZXkDH4T0wI5A2DODq0Ay8rHGK5LdPSAyW16hrwpi/qdPNAjTd1Cz7wXb9c7+Q3wNaRdS+cF4cnd99cOtcUSlngZRZQOkd6KHYRoMduM5wEGbQGBUyOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scEVoak6OROzadWKxqh5NgHFkHWBfHGyFQ6HAbeHqU8=;
 b=QJAxBQX768vajaAY8zI5MQFn6/8r1oZ1H/YfLI0o5g3hQn7VydxcD/yOE0HYWU3Y7sPfQZKVLiVOGfyqUmm4VnDw7OfxamTV+LN+nRuMGbO4omtvwH1nhG1NNEqxk5UoCpnv2tO6RDGjd+3Zt+TScs/ZacunVdNjKKZbzN68icY=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 08:16:30 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 08:16:30 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Thread-Topic: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Thread-Index: AQHZZTqfsYDZLLTALE6VM1zAC7sQQq8anL6AgAAkLnSAAAz7AIAAAcZk
Date: Tue, 4 Apr 2023 08:16:30 +0000
Message-ID: <AM0PR04MB4723A62F0DBF93487A6CAF3CD4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
 <CACGkMEuQo+ojjtjH=Ne0e5wESERUPmSvCDgTXwepz=TR7fO8RQ@mail.gmail.com>
 <AM0PR04MB47231B9400D7E491D1489611D4939@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <CACGkMEseqLP2m-bNir43_AOr221Y+EMai+Ragz0588sxKCYgRg@mail.gmail.com>
In-Reply-To: <CACGkMEseqLP2m-bNir43_AOr221Y+EMai+Ragz0588sxKCYgRg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|GVXPR04MB9927:EE_
x-ms-office365-filtering-correlation-id: 2a55229d-6cc4-4a4c-575f-08db34e4e513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y1ObWJvsUSszdFFR039j8FoP5evtolaBULSqwjSzGJwUS6HXJ0D2OmN65zLDnAVPbtAWF+JfwNY2wFo3P5lp4/3djLo5vHr0jufB9qxZT5LC5Rn24EdW3l4QaUIvo+7CCOmSWhnALS17jkGk6XSUNtMxCvvl6zZSPyZ0XxJhvfcQ+O6xDUZhn1MT6wd+hrkqmtXkbqJVZUSgXCn4X+U08xxrQLCKRSDLxCK3dCeIsXYc0QB5xS/buwQ2aR1DL89pgep3LqC9/7qWoKccn1/L15mQHlYMxvfQN3PtShecnHTcIeM3APhz/OsJ/+dcVTswAHH2Drps8H/X0yQq8T2UFVBt9Gh/eFPCeN6FZMsuPaMaWlz7jvHgT6P2Wq/er8nLuo72Dz0ukggerQ+XfvVEGphGaskYQhQOeNnrRPl3orKSxrBh4z6aPjVq02bTSbN38QAZLsj/dHVbOK79sf/Zz7pEDXzVa4mSOyeUi3JFi91xrUt8fURCdD6etaSmcqNmhJSSpT0hSGD88TZoDlUaGmHlSG1URkkR2fa2YC/U3t8sjM/11B7Isug6J1SNAMSE8x1ADfbDsrcS6Jsp+7KEKl3UYK6zCx1v78d7NJUsG5n4pPdCquYC74Zc8TMWe9qn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39840400004)(376002)(346002)(136003)(366004)(451199021)(9686003)(316002)(54906003)(6506007)(26005)(478600001)(186003)(83380400001)(71200400001)(7696005)(91956017)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(8676002)(4326008)(6916009)(86362001)(122000001)(41300700001)(5660300002)(44832011)(4744005)(2906002)(38100700002)(8936002)(38070700005)(52536014)(55016003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zMc3Gq5cbxukg58fo//KZBleN6Y9hbpbMDcQ+fCiWX9u3/8EzCHdAG2tPe?=
 =?iso-8859-1?Q?EqgwpXAGH9b3TC9RZYKrOCy3Yz9hePn7R8xmzDEWRiWWbcYjTPsd90Aa9i?=
 =?iso-8859-1?Q?wfU2TDJVHtgU/Onz9UCmxq1javyp7ww2aySztNR87sqpZdPr3oMquncFVH?=
 =?iso-8859-1?Q?rmt5mDLh+sKdX5bhfAF/Q5lYi0Ge10EiaHuFfkPU8g8bURMP8N/loUsITz?=
 =?iso-8859-1?Q?qfcfU7EQQxSlMImrlb6IavC18iy7b/MhUskeNaWg7/93cwGEObqC6Y4UBY?=
 =?iso-8859-1?Q?hT4ACWTJ2yhT2yiB1tjpdprLrMjgCYFgPLNQWrzbyxgoOiUuSvzD9IaCmh?=
 =?iso-8859-1?Q?3KX3TY5xFzvAG7hPUh/wu0x+zxJZvsh2KNGejwzWakhOIA+RLniwHLCV+r?=
 =?iso-8859-1?Q?DGfTM3a5EXnuvQ2Nz2TS3m+MhJEM/HjQroym2KjSkj7paHdb8I+2qyOxZj?=
 =?iso-8859-1?Q?k409TJ9A/IRAGwwEHmb1rSxp0QibeRaoQA7ajXzHEP8je46sA3yTTWOUKA?=
 =?iso-8859-1?Q?3Y4hBSN31qRkx2anl8nUZay1dMn0xgZkg54NvuFAKBbEVG827fSWmKBtGt?=
 =?iso-8859-1?Q?JC8SLUEYMmy+z9+bKgawoyy41LFUkz0rJheaSeIBFvs2XdqB0T9d96TkMx?=
 =?iso-8859-1?Q?6/oXOrdrsIT38dMFLlsbaizlgPN8lEcSdVrR2x2zQQpVEg+O5/cgvryZRB?=
 =?iso-8859-1?Q?jnfp6sSm2WlSRF6u80uVp0uzLHJpBBPXxM1UmaizMNufU4m+EtUH5V3WOZ?=
 =?iso-8859-1?Q?zVAfhKZqlko6cxzBcVtROXCvXcSuMER6KAXdvvnYIhid40t3qHgS2VU95k?=
 =?iso-8859-1?Q?y2SOxajbP5bzSh4MeiM2gGrp9Jyc4TqkHO7KtFREeEakZ+0sj0VVaPFM5L?=
 =?iso-8859-1?Q?tQtHi2SSBh2rooahUnXve6aoEyaH0cALjohRjX9sJuWwYk3mW+eZ5F3Bmb?=
 =?iso-8859-1?Q?V0qVQDzT5JR8orA95T1Y2hkoEX4mFXTSaQMo01TBPpaKhHGv3TjWq7JyR/?=
 =?iso-8859-1?Q?o20EiE+f4r4t17NIM6uAnsMC1itFvEezj2MW0xb4C/vi7yn6PEVvbGvb86?=
 =?iso-8859-1?Q?kKPsabPQuGq7E4ILQjhSGvCOCRCsO/Il5cgXg4y7Ag/ZO1j2ncVZUsLmfM?=
 =?iso-8859-1?Q?QtkZBpZcNDHeu0T0V09axBDULRxLrod6XystX/6+nsd75X6I4xFbqpZwTW?=
 =?iso-8859-1?Q?cWoOdszzXHxiByokOcUyOc6q2IPhiO0pMS0nSHW/xlzDj0bWYwxvz/5xs0?=
 =?iso-8859-1?Q?fpGtweGwc7YS6uQDzDrzMdsEB8eXhXwxYm7o6UMPM9vGiATTQZf5cH8yjK?=
 =?iso-8859-1?Q?YYpfvmfZ4E7viX1NGaPSmNdAdTPEPvVhDy0Uc10kW1rw2JKk1FrHwR10HP?=
 =?iso-8859-1?Q?HRsNRSwR4jrQTtVGiIPr08t2gMzO0heWjMJU0v3EI86ScGnRTWQBiAmFx0?=
 =?iso-8859-1?Q?Z2p6kG6QwwZAILP1NzY79v/oH3q+wdirtw8tfipJ6KZFsiTwb7kl6PrmKZ?=
 =?iso-8859-1?Q?LntrCNqJHcX4R+RQNW5ysYumLG6lhcrAlOReDi9kmXkWgiczcsqdnkaoaB?=
 =?iso-8859-1?Q?r94BNjVgSXA4WV43m/wsyGE6WHQhu+6dOg70dIzPPvZA7YQg4KJGpJH9MG?=
 =?iso-8859-1?Q?wuyu7nBHkyFB0mRSoW4nej9FREi+0kK7qM?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a55229d-6cc4-4a4c-575f-08db34e4e513
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 08:16:30.3106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GG9fp6/4+lS18pdMqaADNFbCL2xwOvXW8X8j76lwc5dzrBMWLEJoh46JW9Xhr/i3gjsSXzpNuMn6rURsbu2nz4DmODa2UfthtnldtT6pXxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "viktor@daynix.com" <viktor@daynix.com>, "mst@redhat.com" <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> > I meant that next_wrap is for packed VQs, but I see your point, it's no clear from the comment.
> > I'll fix it in v2.
> 
> next_wrap works for split as well, spec said
> 
> "
> Without VIRTIO_F_RING_PACKED this is the most significant bit (bit 15)
> of the available index.
> "

You're right, so we can write:

 @kick_vq_with_data:		Kick the virtqueue and supply extra data
				(only if VIRTIO_F_NOTIFICATION_DATA is negotiated)
				@vdev: vdpa device
				@data for split virtqueue:
				16 bits vqn and 16 bits next available index.
				@data for packed virtqueue:
				16 bits vqn, 15 least significant bits of
				next available index and 1 bit next_wrap.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
