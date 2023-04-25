Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6E9C77B76
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 11:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CF3440978;
	Tue, 25 Apr 2023 11:12:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CF3440978
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=M72Vb8YW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5WgyCmUeCwaH; Tue, 25 Apr 2023 11:12:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5CF3940969;
	Tue, 25 Apr 2023 11:12:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CF3940969
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E33A8C0036;
	Tue, 25 Apr 2023 11:12:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38516C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 11:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F060F40977
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 11:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F060F40977
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wt8iB43_whGw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 11:11:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FEB64099A
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6FEB64099A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 11:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMwU23U+Ac5q0yU6Ip3fz4OWVt9ITIRPkhidtJpqk6U4PFKegkS/a/qCTCQNPN3JNxS9DgmB9wDkxty7NeLvi6AFYtr29qiS6tww2SWwKZudGER6vs4H59aJBGs7mezV0Gr/66FxzNQ3bGoyLTXagdfrlmQtd/tdj0kxcBPrZsV+7PwDL6Kd7hu5CwP+pRpr89XmtgZH4TD+LoHBVIJD8ngYpzYJ2x5FIlYwdHHzqxZEczJaWYpV6raHjj540+LirooGAmriipXBLQDHBrRtJAXMEmWN6yGD4gL5i2GwVu7khB+PqqWYbyIQLcq3Rq9gTQvTw+5XWjg/Q/XhPW+0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvpXJgXt7/B1OcWycpfx9lGzVaIBhC+J71iYLvxnySw=;
 b=HyPWeDHsxalIucl03KBplq/JcWS8TTqWW8iCqaTH6ij4ssVh/iAvH87To00EhB291tR9qdTeAIHcoyaAtkNbGwETU9Ao4yCLfl7DQ/3c6C3fge/s15F3U6nG6TrBaiBNLDhOVz+wHzYmJmbYVmcS+L/3YIHnFMFW7UEfc6Kr3JRxsGVZqNUaFRHK5ZbLZzuNsapb/ieQwxTJbfFUQmb2OAjLG3kQIw04sS0g9+eQwQryv1C9Lq0bWv+TO/ijYMjcdzuxuTEX7LpRVAgbNUeKsT8nJ1JIalv7t+wVrqLRsjLfBsrlSoh7UmqF8suaacGjZzAYjs9DOw0P5THR8EsVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvpXJgXt7/B1OcWycpfx9lGzVaIBhC+J71iYLvxnySw=;
 b=M72Vb8YW/RcNBamf+Z8AsZDTOXswlGg5Ybtj+JHYd6SGfdhcAEVXqxVpy//+PYL0J89B390Pwvw8M6OOuARdRuaSjBolQd5tZz42nBUBZVDa858oEj7voCl2h7e6+yJf1gWlp6IyMfywWGud13SLisKZcTLex53zUuLSRc1jlWQ=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AS8PR04MB8038.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 11:11:54 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a%5]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 11:11:54 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uIjT9gABGFgCAAG90AIAAMSwAgAABjzCAAARBAIAABATIgAAENICAAAM4M4AAIQOAgAALfyGAABuqgIAAAQKHgAADxACACRVQMYAACvaAgAAGduWAADkhgIAADWLzgALs2ACAAATeH4AAJfiP
Date: Tue, 25 Apr 2023 11:11:54 +0000
Message-ID: <AM0PR04MB4723E09C948B92912C796BEAD4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
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
 <AM0PR04MB4723CE2A9B8BFA7963A66A98D4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4723CE2A9B8BFA7963A66A98D4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AS8PR04MB8038:EE_
x-ms-office365-filtering-correlation-id: a263e7c6-3e9c-4178-8307-08db457de09f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3aIV6v5eCEMPU8/b1WVsuL2gNNBul8vnkIyg8LFq0ffHjN3YtFIazeYCXUq2uJEwmQYPANTDDEjNpYab+VUsEU3zXtpBj+T4J3A3ivBJmW1Ya54avipHGwpOVjbXhsbSl5VjL0bJPTDioMkx6SHRXdCZ3fRWnfn53Xp6JRvs/az0QNIJLxTUBG758qMdFytTdSZh+E3h7b+qP6cUA4Hcix9swA+7bima1xcF8ImEf5Glkf8ujVINW4Z2ZHmWJEjw7i5IISTkttwm+ytMXucgZ3wVjfd8LYUM7osbM3B3GNChb3Sz32pI5Cg6po7rtDuc/FgKVGtFnSIc9m9CY/mBu8WgUKqCGou1C+8T46h3uYV8R2sa+aO1tQNKSLOWw/n6s9QRPqkhoE5ch2X+Ft/b6fauRrQrbJT7o5+kRn4811/c6HbpE6NPScw4job0mb+3asJNPkXIJ5mqVeWWo1nwESOtAUDIF4yPvqo5Gu47SePq2sRTCh/olmUAtpOOPxXzeOy+hRfN0HuoZBqTGM4iTzdH7k0a4IJqWBOe3yAUo2qM70EJx+CTvw/p17YJie+5Ma49HDew/kSLuNOXbvkY63Jg2coroRcEeGi1/yOgJNZ9OGElqRHyjpXdzcQ4upQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(366004)(39840400004)(376002)(396003)(346002)(451199021)(316002)(66899021)(44832011)(66446008)(64756008)(6916009)(4326008)(38100700002)(41300700001)(122000001)(5660300002)(52536014)(8936002)(8676002)(33656002)(86362001)(38070700005)(2906002)(66476007)(55016003)(66556008)(7696005)(71200400001)(6506007)(9686003)(478600001)(83380400001)(186003)(2940100002)(54906003)(76116006)(91956017)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zrFfbi13KL5SmXqqQBLsSEj+u1/o2sQtxa5kjiiJm/KBD4p1JT8N3ul4U5?=
 =?iso-8859-1?Q?Lgt0s5rgPUGQ/XG2bxThupzmtzIVp8G/1xF+3f+l5p4i9g12XbUzF6hMP9?=
 =?iso-8859-1?Q?Z+pzipaYhLPEgHuBbg+0C9HN4n4rfpkED2yjfJHZs8bpQV/8sHbwI78lfv?=
 =?iso-8859-1?Q?PH3rk4StwnD2jJYEHDtIDr6bU/c5UXzApIqBWyJLAKZYtB7Vb22ejUU2w8?=
 =?iso-8859-1?Q?V2PF/mRhfbkZbDs2RgYcyNcjzegxC5faSMzBpEjTGDSjSbmSKHLXrm1Pb/?=
 =?iso-8859-1?Q?ZJjBwHvAkPeMKu4HEaMWyXT4Jh3SYpBBnJsUhU15wZFwocKsGCWtIjkh7S?=
 =?iso-8859-1?Q?1GEMLsS4gtiQ1DQfSpZuOxTQiBKGLhFE2leZFiUlvHrDT6GSonP+0eVQLQ?=
 =?iso-8859-1?Q?8+XZXvpyK2F67X0F7cNBirF56uIB7OAJOqQk6asUdLrpChYZ33lu26e8Xs?=
 =?iso-8859-1?Q?rRHjTLdbDOGeonA5/htWxp212b+rak+nBPv4lWY+i2Bz1Q5c5G5rj1x2Fi?=
 =?iso-8859-1?Q?gWqu/5fkoRQ7SDkQ/u/msC5MfT50IRGdYGnoGEVr6UUs3VMAvOG7vYkJl9?=
 =?iso-8859-1?Q?voJtJD7oVRRjf+Z4nREw7LRJGBj3jmIgkFabFEhz48gMKsBl8ZQdrydmaF?=
 =?iso-8859-1?Q?PeTk72ZTCGkKMdxxv6WDT+lag1oJvTREhsM3yQiRxkVOf0yp12IdkVxLzS?=
 =?iso-8859-1?Q?a/MWdjaIvRnDjHfy16sQS+5phwAA73jSf14z4hZaPW+q0b2g82LrAAgSvB?=
 =?iso-8859-1?Q?KC+UICHIyX0orCw4NbeIX4RKmC9d2tduylkfIFtWvoJFv3U2+FW1lHzPkK?=
 =?iso-8859-1?Q?U85/oxsNN3DKyKMqZMPO5+ndz9xKcllTTtVLdWGefZq/v19TWUn14pKypT?=
 =?iso-8859-1?Q?59NLaWzYGx4UEHXinGIwqlK2cPzkCGKy8lfA0KO5FU/z3CSTNdOMfoRMyd?=
 =?iso-8859-1?Q?Le3+1bMWEBvdaDxtyqQZQ65pvJK1YySnFwcwgrdQkeoE+Ro6k6f/kpRED/?=
 =?iso-8859-1?Q?LjG8mtdcfkhY+RkPzwwgNqOvUPTC6HFlETnumu86vyoLx63Ed7vsiVhi5F?=
 =?iso-8859-1?Q?EDMe8wsjOg8B8loxrTXZXni1ge+bJ70nUu1Y7vd1X1LvtkkygcodoVu5VR?=
 =?iso-8859-1?Q?k2eEzVNCqa5TLJCXMV6Hx1FQr4DNDDuLbaj2rMtu5lWNGbmWbMjdewux3J?=
 =?iso-8859-1?Q?+n3Jjoi/NzsvqhUrH3hsULRaMJNbqbHMTVohppYAmgIuOj6bmxdR5RbyMR?=
 =?iso-8859-1?Q?TMykZSiEDG1LtR0PgWH5l2Z3CzHMeuINxQeYFGQeN8j457NKyZDUudRcuW?=
 =?iso-8859-1?Q?UH0JyVQcdsSD/liCUY2VUWjihn28D9thp7JdFmrkNYYK/Smg0QxVxdGsE8?=
 =?iso-8859-1?Q?PcA2vLKvHwUHWbxfuoQXAUKSVygNzliRdQF5j59BOW9fkdjc4Nk5lgbGGb?=
 =?iso-8859-1?Q?nBa7X78li9tr3k/Rq3Mr0aHi21cDPde7mhYLkgSxVs3OUEINRrrKtLK8Qx?=
 =?iso-8859-1?Q?9Cad47Ho1DaotWSNcuePbzVFZci/yN118TWF8oS9hO6ruu6M26sShRSx+1?=
 =?iso-8859-1?Q?KE067b2EOFW7oChEgmzJgB841CbDYZO+4Wp4CnY1xKtwBOaJpWlPx74s0L?=
 =?iso-8859-1?Q?ZuB0ux1LQObWJVpmn/w0HDkuBtxlKQRZeS0OWwmEdkDlipjzxrOZ4zYQgl?=
 =?iso-8859-1?Q?T0FE8vE8cYAGfA3SxT69Qm5j2lLdjrn8DsIF7k3uQjrNBjuccfN2ggrs3P?=
 =?iso-8859-1?Q?rB+w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a263e7c6-3e9c-4178-8307-08db457de09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 11:11:54.4401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InB9FGpMlJCGNRjFim+XMqve708b/F20YNlWIbx6hQeskdFnKwwM2E6tBMv4MFxlG4lefBGNMxqiociZQPTj8h9dJZp8cXLZV38gYufHaHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8038
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

> > So, let's add some funky flags in virtio device to block out
> > features, have core compare these before and after,
> > detect change, reset and retry?
> 
> In the virtnet case, we'll decide which features to block based on the ring size.
> 2 < ring < MAX_FRAGS + 2  -> BLOCK GRO + MRG_RXBUF
> ring < 2  -> BLOCK GRO + MRG_RXBUF + CTRL_VQ
> 
> So we'll need a new virtio callback instead of flags.
> 
> Furthermore, other virtio drivers may decide which features to block based on parameters different than ring size (I don't have a good example at the moment).
> So maybe we should leave it to the driver to handle (during probe), > and offer a virtio core function to re-negotiate the features?
> 
> In the solution I'm working on, I expose a new virtio core function that resets the device and renegotiates the received features.
> + A new virtio_config_ops callback peek_vqs_len to peek at the VQ lengths before calling find_vqs. (The callback must be called after the features negotiation)
> 
> So, the flow is something like:
> 
> * Super early in virtnet probe, we peek at the VQ lengths and decide if we are
>    using small vrings, if so, we reset and renegotiate the features.
> * We continue normally and create the VQs.
> * We check if the created rings are small.
>    If they are and some blocked features were negotiated anyway (may occur if
>    the re-negotiation fails, or if the transport has no implementation for
>    peek_vqs_len), we fail probe.

Small fix: if the re-negotiation fails, we fail probe immediately.
The only way to negotiate blocked features with a small vring is if the transport has no implementation for peek_vqs_len.

>    If the ring is small and the features are ok, we mark the virtnet device as
>    vring_small and fixup some variables.
> 
> 
> peek_vqs_len is needed because we must know the VQ length before calling init_vqs.
> 
> During virtnet_find_vqs we check the following:
> vi->has_cvq
> vi->big_packets
> vi->mergeable_rx_bufs
> 
> But these will change if the ring is small..
> 
> (Of course, another solution will be to re-negotiate features after init_vqs, but this will make a big mess, tons of things to clean and reconfigure)
> 
> 
> The 2 < ring < MAX_FRAGS + 2 part is ready, I have tested a few cases and it is working.
> 
> I'm considering splitting the effort into 2 series.
> A 2 < ring < MAX_FRAGS + 2  series, and a follow up series with the ring < 2 case.
> 
> I'm also thinking about sending the first series as an RFC soon, so it will be more broadly tested.
> 
> What do you think?
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
