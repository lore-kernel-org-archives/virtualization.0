Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281DEC6FD18
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 09:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8889081AF5;
	Tue, 25 Apr 2023 09:41:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8889081AF5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=DIjnxbeT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIwTatnExCQf; Tue, 25 Apr 2023 09:41:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 94AC481AA7;
	Tue, 25 Apr 2023 09:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94AC481AA7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7613AC0037;
	Tue, 25 Apr 2023 09:41:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC91DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 09:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0BE160B0F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 09:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0BE160B0F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=DIjnxbeT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6MyJq-equrg7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 09:41:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E3D260B10
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::620])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E3D260B10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 09:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS11Tv5gwZPhjRlcrriVUrgNXHfiefCPgcFwV/Q8o8avARWeDfzFlUuYr5ZlKqO0iqN6P9eXpcC6W8qmZPo/mBvh6xvRKRlRNhWqq7f2CPBg+EXr2yGnRymF8lR8n7SVYHy2XBvm3G/rUGNTTUlkgR3BgckMpZT5/2DKVpmL1yfwSX0o0Ok9BIYYBxulqoZMvAlVlYft9HgfE9bpy8v+tIMkY3aGC3oJWRLobHDSSIxd0xGL3y/FcQq/+F/Yew1YP5bMlfHsVojolHZuTion0xVNZS0OL24C/51rUMa1zOA+Ocy/9Jaw8rxCedb/IMm3SguXeW6ib62PeGWvW+QCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDkQt016FTqrQSIez6V8jDy1MM+i2Y7Y9rG6T6QCYY0=;
 b=d2FYcY87kqlRFspm8b7x2wwtWC3H/bqBfK4wInom8DBkOvSh+PQERSBwgKIx5gKxilEx9OVmzTaP9kwafQgZQmC00M1ZZYXhrXLsv/fv8oJIc6TkZNjoRkE0n4p74OLHB/pnQSZgc2So3DvoCUZVexigDEzUF5ZWjvlVCXH1ALcgnmyTdxrM6DMBlMjVi9ZoyvHIbZsyxSUfMGCRk0o8/WjB6kjuxVFsqEa6wTl0Pu3NSBCyGQ6BeOYDC2A2dDPafr23kkroGk1Z3YIXO5Gw8xnfWSsOBij3LakQNq0Pp0kPN3CkC34mXfOkZ8UQMrQR0Lfk06yY41B/UkLuX/EayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDkQt016FTqrQSIez6V8jDy1MM+i2Y7Y9rG6T6QCYY0=;
 b=DIjnxbeThC/xJDTzSd0RciOUjXBDeql18PdW7f0XDc95xr1vm3K+jolLy31RGYu+t4zTfmXnPE3hOTWvrn1SprwAbe6JYjyxqzhH1tiDg9DlBukBqdyE+GXUqgOhgp0RL+C82qwvYOamjNnvWf9hDHrVdOlY8L0AKamzUcB+tEI=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AS8PR04MB7927.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 09:41:35 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a%5]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 09:41:35 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uIjT9gABGFgCAAG90AIAAMSwAgAABjzCAAARBAIAABATIgAAENICAAAM4M4AAIQOAgAALfyGAABuqgIAAAQKHgAADxACACRVQMYAACvaAgAAGduWAADkhgIAADWLzgALs2ACAAATeHw==
Date: Tue, 25 Apr 2023 09:41:35 +0000
Message-ID: <AM0PR04MB4723CE2A9B8BFA7963A66A98D4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230425041352-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230425041352-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AS8PR04MB7927:EE_
x-ms-office365-filtering-correlation-id: 4a1fb844-fdff-470e-86ba-08db457142ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEbiyUWf5JBwf4gPGjZ4Dh7A7R1FQ4qIyXnFQA6lDBfz7TwVXPeJOl66p/jSgjcmECzbxwVIs/4FHRh/kNg67PcwaCwoMROeODJ288eDT7LJtsbsVMWxP6pzYh5E/HJd1kl5IbmYz8MV1wrofR/ST/GfXV7GRR6g8gD3aM7E8aY3J1okNUkVaVnQ8DWpZ+uIJLhB50gKk43igK1t19arqXJ23qNBygaWb1nI+2ZG53IuXAq2Phvpu4h+KFEpU0rhSxBqSvAVnvZl2flKvsW3+HZyyzOlRyyytVGtPPDfXkyUx2bcVWGHi/Lgk01OLLNmHkGNOnx8SWG6pOT3o4BSO/RnBwXEvvwG22K5VmKCpt1nnSVLYg4ZvtfPKWUkHLbbyHOwCInvbMermroIHP9Xqgdk5qITC9cWNmZX5VpprWpcwCLV8zIlSKYXowKnjXPpJmW+9RFCpFaXLdl/S/gQRfaH9LksN0O6RJRig9tPkZEoAP0CnzNY6kErN8u6RsURrKx+A7xoSjWH+u7kZ9tvXtiMNEXrk/9lbI4vcYGEJULflXT4HfQVpbOm94lx0NjUoAemL/CQ7Gf2o6NF9OffqiofqvSRGI7538BB/cZlsG7N/33igtEXf84TGwlI+1f6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(39840400004)(366004)(346002)(396003)(451199021)(54906003)(38070700005)(66899021)(33656002)(86362001)(478600001)(38100700002)(41300700001)(122000001)(8936002)(8676002)(44832011)(2906002)(6916009)(4326008)(64756008)(66446008)(66476007)(55016003)(66556008)(316002)(52536014)(76116006)(66946007)(91956017)(5660300002)(186003)(6506007)(9686003)(83380400001)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/Y0DbCiEat7IXQK7Hi0zmTpQrifi0v9FhZ+iHSS7ngE/QSniNDoTnwnBRY?=
 =?iso-8859-1?Q?33UezvJbM4foAFdSrcLB/dq4rqb8Jlx/U0MOGrsxpZvgSF7Chr7c75dvMv?=
 =?iso-8859-1?Q?l0VVgJVohw1OAgCeiRXTYIUuIcKdA7nVJL2MQdRt+EhlAcdlZ+HjqHv4dM?=
 =?iso-8859-1?Q?2vkVisS7oTjcAzbeM4QSrAmhSnbxU917zstaZfZ4q05dwjrps3MMQjORN9?=
 =?iso-8859-1?Q?u6xQ0n4cH1uvFHq1Z+Ta/c1LiE9c2rzLX8Q3+SsdA4KOBuyDUAnmiHRN3t?=
 =?iso-8859-1?Q?i77tyQGBq3Uuh0oez94X9I2abLSh5Tkm/bNLyy1l3Nu0O5hTY3dc64brfu?=
 =?iso-8859-1?Q?/Eecxcgnk+Ocn8wnDuYvQ1tniYLNB1GA2eLX5BGgaQXgkkaAsTLH4eOKwb?=
 =?iso-8859-1?Q?wPxj1XRu2W+mzqCgwiJ3CHpc6gdlTh4aUmveQVnpYlDwUx1h65hL+8GROV?=
 =?iso-8859-1?Q?KKMAR4pzyFtQpH9cXgsIiCPTAAMjK3jYigEFWqsd6uuobHcwjJ/d2UyGCX?=
 =?iso-8859-1?Q?RFWlAO80M1r4jwZMaoNkTpNQBlyG08+yTfLVUHVrVhvASBkhdT2mkm9kV7?=
 =?iso-8859-1?Q?dFl5mVu8mRXJeMnMREMKL8MW7v84H2RcvQ8Nh2np8lZqkzvvu8aj0gxqW8?=
 =?iso-8859-1?Q?FrF+oxKOGSEi9xgSeiDknBiwP432brgzt5ZGpjx6lE9LL+Tgq9oTya588f?=
 =?iso-8859-1?Q?ajSNGyLnCyYUq6egSfFIh9Fpp215uFdEBqzqXshLN5TrEi+LZKvpwG3pPY?=
 =?iso-8859-1?Q?Mk82vJLrz+geuAZ21BgmImRabvzWXv7LnQ+8W75d3HNx9AHy/w91y8mpQc?=
 =?iso-8859-1?Q?t61gDUjTj9/0vN2kI2Vg7THsIZaJup4OrtcKcJe83W4zDX3Z1DhgB7A1HS?=
 =?iso-8859-1?Q?QhVkcPJ3sB36mAPvYtSsrUh8PM2dsaKXM8Y9EHnX4b9Km06CYI2r26C0js?=
 =?iso-8859-1?Q?xFqC9TRkodn54ogGhU0dS32fPdwxaxnwZSQIICOjhv4neeS+zXTilKYKFF?=
 =?iso-8859-1?Q?SPL2yaWE+NWo5gMu9U5Hw6bI3KxOOJOW8DaKhwGIFJpiSUNOP3pMNB2J9g?=
 =?iso-8859-1?Q?mBvXmp1YNTlq+0cSSpDjRZjZ41o3rH5UTJF5bKOHgpWGVd659blQTaOfAg?=
 =?iso-8859-1?Q?yGlt1KD+LdkwEilT2oi+Qd/adVJlvxE9SpflOoah90Ghlt1rWgA//isgqG?=
 =?iso-8859-1?Q?ZGBTK63X+qpscV4SlNsOp0gUzkiI/bpTkSiZcZe98vbPr8ToynRMpAA7/3?=
 =?iso-8859-1?Q?OqfobASJ6uBukUKAnrzJuw31iJaujsNxC9r2w8VxuNxMo6+In9Q4P3U9E0?=
 =?iso-8859-1?Q?e48hm0upybWkFauDeBlcEkj7Nq6r9rVYjQbNUiAY5JSmP6oRu0s/bIAYFJ?=
 =?iso-8859-1?Q?fjD4wjBTfc+7LSY0Ovh3wpQuwHQY1y+IXxH5YTJv1A49ITJ8ZUAQF1URXx?=
 =?iso-8859-1?Q?MznCkNQrAo1xp9tjhDFdOOn4yUzIfJzjdAgYTNp3cGMfIJWErPnv6+s3Kx?=
 =?iso-8859-1?Q?Fz1LZHnG0PV9KH4C092J1KCd/h3lVZs0e5SkyDviY5zQo9M7Wt6whTpoaP?=
 =?iso-8859-1?Q?gQE+nT1qnDYDXy1la3kOAtFflnkZ3Mm5rZgHZIkCtTGE0vPVOrgqpjhM3f?=
 =?iso-8859-1?Q?b7rhCxqypSq/bi3Nbk6+jxDjyTxkITSKrW5Hsb4mcLHIjHFignRzeydjG9?=
 =?iso-8859-1?Q?M2XIJ5cbIb/m52gw9DMYST5K37Ujcf7oglT7oXZM?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1fb844-fdff-470e-86ba-08db457142ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 09:41:35.4779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyErfIzz4RRcHXrZfapHK13jCYDRT9JOVxKLx/3BNSlvnOH8D31mJDZK6AO2JtOjWXYohWlb/xOdS+jYsqG5dbrjOk4UpvwwdqhnBtjo7W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7927
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

> So, let's add some funky flags in virtio device to block out
> features, have core compare these before and after,
> detect change, reset and retry?

In the virtnet case, we'll decide which features to block based on the ring size.
2 < ring < MAX_FRAGS + 2  -> BLOCK GRO + MRG_RXBUF
ring < 2  -> BLOCK GRO + MRG_RXBUF + CTRL_VQ

So we'll need a new virtio callback instead of flags.

Furthermore, other virtio drivers may decide which features to block based on parameters different than ring size (I don't have a good example at the moment).
So maybe we should leave it to the driver to handle (during probe), and offer a virtio core function to re-negotiate the features?

In the solution I'm working on, I expose a new virtio core function that resets the device and renegotiates the received features.
+ A new virtio_config_ops callback peek_vqs_len to peek at the VQ lengths before calling find_vqs. (The callback must be called after the features negotiation)

So, the flow is something like:

* Super early in virtnet probe, we peek at the VQ lengths and decide if we are 
   using small vrings, if so, we reset and renegotiate the features.
* We continue normally and create the VQs.
* We check if the created rings are small.
   If they are and some blocked features were negotiated anyway (may occur if 
   the re-negotiation fails, or if the transport has no implementation for 
   peek_vqs_len), we fail probe.
   If the ring is small and the features are ok, we mark the virtnet device as 
   vring_small and fixup some variables.
 

peek_vqs_len is needed because we must know the VQ length before calling init_vqs.

During virtnet_find_vqs we check the following:
vi->has_cvq
vi->big_packets
vi->mergeable_rx_bufs

But these will change if the ring is small..

(Of course, another solution will be to re-negotiate features after init_vqs, but this will make a big mess, tons of things to clean and reconfigure)


The 2 < ring < MAX_FRAGS + 2 part is ready, I have tested a few cases and it is working.

I'm considering splitting the effort into 2 series.
A 2 < ring < MAX_FRAGS + 2  series, and a follow up series with the ring < 2 case.

I'm also thinking about sending the first series as an RFC soon, so it will be more broadly tested.

What do you think?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
