Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1971AC77B7C
	for <virtualization@archiver.kernel.org>; Sun, 30 Apr 2023 18:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FFC2404FC;
	Sun, 30 Apr 2023 18:18:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FFC2404FC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=rlKgwVP7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qnqS-qql3GLa; Sun, 30 Apr 2023 18:18:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A2D8404D1;
	Sun, 30 Apr 2023 18:18:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A2D8404D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03BE4C0036;
	Sun, 30 Apr 2023 18:18:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D723CC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 18:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E85480EA4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 18:18:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E85480EA4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=rlKgwVP7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OeDPYLw4j8WO
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 18:18:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA32580E41
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA32580E41
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 18:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCWaxPnUmioPZiYZI/YYFk0YWZ5onqx7VBxF9/DgU0ieqB8MUPGyTkMFAWfiWCyf7m5K8UzLvKrIBcH4FOVia1dHghYo4Ft78t1rj92jBs67EvpfwvuwT+d4N13C9KSCCU+YeNPR+sP+qz014aVgjObdxIe17QdDjpk6mCnnG1k8Urg2x8sbuBLEa+T+8cCQsXgqSnJnIyRIN0RTehQWuBoaFNuvT5c5fM256qWpHHQYIwMtAt215E4cR7rWtNw7pi8fgIsPWc0QokPVcwLCPBgJhfSIv9capDjwI2obdK6FniUIoxpr9h7VmamIANmVDsfGsJTF+Fbn2CmZaWoXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxOhW3pYZI74m933wIIwuNIHyEmdorE9jVAM1F6UWdY=;
 b=U22/CbubJYtjViNt4xaoVjQmn3ZGPYaDVrJp3BDhAXzMrZVzr7KjrFVBePWGSHQsK058WgN+gKJak4+mf7/66ODKNXrAwYRlFz3frOaJEv17cmCjp3IosYlFrXU2Wo2ODrisd5RVsSzYIzm5hnBPjzcAEcQdRRlTsWn43LDxTAruvOpIpkAFgdnN3RwEb9CTh64AQ5u4MVqGE2eX29aTvaZj5lfxXYLkibEAg1mXr43RI23uOONCdpY+9F9mCs5YX7+Av1zT6Qbm5rMXOcno7/xLG6DwuSDaLzuU+ID5/kQH6KWN0TT86aOtXM3rL93sfpNWCc7YNCg8vx6mx6e91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxOhW3pYZI74m933wIIwuNIHyEmdorE9jVAM1F6UWdY=;
 b=rlKgwVP78c6LWpGi6sHCHLfLEb/oVqfjcTZX7Ff1c0efHDB5uID7Of/cjiUDXxb7gPfQmGYo209ny6kXxlm366OSBUfhxvvEukMuTFboFUywK7qbfv1v/Z5h/1wsMInXz+jzvlUtK7xxnqFyGbcmN1IFBxCFgSoYua2Noyv5S+8=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Sun, 30 Apr
 2023 18:18:25 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::a5ea:bc1c:6fa6:8106%5]) with mapi id 15.20.6340.026; Sun, 30 Apr 2023
 18:18:25 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net 1/3] virtio: re-negotiate features if probe fails
 and features are blocked
Thread-Topic: [RFC PATCH net 1/3] virtio: re-negotiate features if probe fails
 and features are blocked
Thread-Index: AQHZe2XWXCxBWFWtXE6IKtn3GaLogq9D2DEAgABQpw0=
Date: Sun, 30 Apr 2023 18:18:25 +0000
Message-ID: <AM0PR04MB4723E4FB8898BF5464822C02D4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
 <20230430131518.2708471-2-alvaro.karsz@solid-run.com>
 <20230430092142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230430092142-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|PAXPR04MB8797:EE_
x-ms-office365-filtering-correlation-id: 4fed4089-9de2-4685-abdf-08db49a74a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D190/A+4n/ngP2X5prPaW0F0WkfLy2JjiX3fiyRfzCHuXXhV/XyGBeTcBDk9WCJ+4gQ1XvUT8qsfKjRAiZKYsKSXOIOkeLegKGwEecVIm8BCxBBBmDwRoA5VsuthS/vF6hJseo1O+kIv6asWFXZOHGDQsSE0ILXNLyX7neEt7S3iDOCsD1tNedyuNhcCKoVwBH5ZWon6qMmwUMQvsVCwJ8VxRUDB+PKE4WfemYZGF/4M4x9X3kPAIQY3+mJbdTXyifSAQGfvb6pheTAOM1zwQ4J8Ia4oyFCY811/PNOdhh6uPlrl+DwvHWX6mEJ8YAO7sG7aaplGUNbm9qYG44jZCc4hkU18zSoM2k8eaeZeIDCzLiVXW73a5wjXcPp9vAHVND42DLIHordiM4fssAPoKRUt8JiYy5KCNCgzCysv3XHg5SsHe3uj0PHFrWiOp3VKIwde9oOI/cO1hZlQqShZTDftO107N3wAz0YXtrF506l+Xzt35hEwQXzwprPwWpmM7dnC00evdrAtbS09V/Cg6DgIjr/rnvTzDvKmbhvBciFfc7rjPPjFAU2uA9s5FYJ9zh6xWfqRETM1Uyj9keKxsBAK7m59rZwwhY/XrvrvaO05ttJDnjbSQmffYh5+nLBN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39840400004)(366004)(346002)(136003)(376002)(396003)(451199021)(2906002)(478600001)(41300700001)(316002)(4326008)(6916009)(66476007)(66556008)(66946007)(76116006)(66446008)(64756008)(91956017)(55016003)(15650500001)(5660300002)(44832011)(52536014)(54906003)(8676002)(8936002)(7416002)(38070700005)(38100700002)(122000001)(9686003)(6506007)(83380400001)(71200400001)(86362001)(7696005)(186003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TlyJx4KcM8g0f4flm+E8AToqXDj7+Zpu1KruiaRGMuBNBrwUpmT0Bn7HG+?=
 =?iso-8859-1?Q?DjJjb9QShToMrFWbMyWkHXP+2U36aReSJjKEWpi6o66m5sYS4E9ddzMEXC?=
 =?iso-8859-1?Q?I4kfd3C0dRf268AEaxbdA9Zct000DBr0wVmeCxmLdjKpALbPN0r2BzuXJY?=
 =?iso-8859-1?Q?wfSWyWlTt6n1DsY5C0J63gaO5aTdaZWc0qFkRItf1rTQvWzMz8W2PeCBYd?=
 =?iso-8859-1?Q?CZcIj5EOP35OrbYDuYJ0ThRgX2sdhIlwHJJ1VEiqf3KPnDenBhLwciB22X?=
 =?iso-8859-1?Q?Um5e5lYaE550VuexPEvK888//jgrqT9mLTAo72M+T+pX0uQbc/72TJLRoz?=
 =?iso-8859-1?Q?RTiNfAZOEbJihUOaopZJcDrQJE9YRMocSm3x5yXJRQpQbGpgw83iHwvX+B?=
 =?iso-8859-1?Q?Rc0I45ApgMmedyMMH0kgcF6ZkbfcZDr/Ev9bQDAUbTki9cLGCxan2p52At?=
 =?iso-8859-1?Q?55YERa/X0unKN5obg8ZT5dagYzr/Ne8f2GtXaIlpL5Tlmhuh9DOcyiiXkM?=
 =?iso-8859-1?Q?aavn4LTE1YKxoTTCeSx/jwALgZo8+RbxiMrqwtrKuC3DM9rrOpaCfX9BK4?=
 =?iso-8859-1?Q?Qc8Wtb8ffhoUy8LvYdTPppIIGeinYwq+vNMw5YmeqBBpzP9UoXuod6W5AV?=
 =?iso-8859-1?Q?JUfRqU/dlIPWy7z2FRMjjECnmBVnfSckPvngeZ1BSM4P69i8YX2uNdYsIi?=
 =?iso-8859-1?Q?sGtgJ1h2UeiI2WmrUeZA3Axu1FUKH5tNrmWvJWYMZhvKwLb2DoA4I2JPXC?=
 =?iso-8859-1?Q?IKOBcvfCH1pp22CbTZd9xeiOgGK1pj6xei6SyAbAO+EQEcI45KECYkvpXV?=
 =?iso-8859-1?Q?uFteIXlOcutCtvdAzViSENhgYTKsuNkT24J+YKwJQbsWXLBws3XiF7/4EH?=
 =?iso-8859-1?Q?EHdGRNGI99eOv9RHlvqHLdpetVYO25l/uQNIO8LZCDgSMTen4ageQS2sb/?=
 =?iso-8859-1?Q?E32C/9mtQ44LytRHM4xewZfkY/bL98rrEYiGzDaspL8f3ZSizPjMs3O3df?=
 =?iso-8859-1?Q?61r3X2WeiBPxTYX3RJafp3x9E+TuVijlxWIbZeIN0FHQ1evSF1g6BQlUrd?=
 =?iso-8859-1?Q?JtJRZEp2YFBzv5iqnDoJrlQP9yQrlacN0spD7P6T0ErrASDIKX4kLnhnKA?=
 =?iso-8859-1?Q?9urNqTSpM4hQEFA5Xc0B+RyTXXPeO2jZX10hs2SdCQwUwp2EBjybLDvnAT?=
 =?iso-8859-1?Q?Qt/dYxUn3VZ/C5nJnQSiLFRQCqwe51HuOvyYgkTAmpa+ZePifp5OURwcE+?=
 =?iso-8859-1?Q?PApTfckF8zv3wOco9cLyFfxGkKsKNh3KN5qr66CjGEZ0LWX1FM+TmXXT1e?=
 =?iso-8859-1?Q?NDGfiPL8GY4GXSH3jPbEchrdb1r270IOx3MNEiW++q+F5ICdt/badvHMfo?=
 =?iso-8859-1?Q?GaR7tJ3JhiGVaiwyY52f4Bq32sdWBqpYJ1hIeM11AAEZDtfKDT3BoK27wk?=
 =?iso-8859-1?Q?af0MjHaOprOnDHh16VicqdUxPH6x9J+/6+Bkd+BQKDAv+pwisKt6qfSrjO?=
 =?iso-8859-1?Q?92IeJyJA3MTBJQRImkpI21BmTTio5WwlG83bo1ohzXhJ9u8FdTeI9sqpx9?=
 =?iso-8859-1?Q?MS8MTgJwmaWrLjbtpHxosoWJuCJz1oC/4OWSnPktLqS2akgCF86T/vUB0n?=
 =?iso-8859-1?Q?a3xNhXJtAxN3B9oTIZacugcgQ0rcLkYAD0RFIxBR5Kzo3LhyZg2XPygXkG?=
 =?iso-8859-1?Q?p6JvO195e4ryXR27YSkJTkIlyKMhVgoAvlWBVw3hpLc7+YAEjv7GEPu91K?=
 =?iso-8859-1?Q?HQMg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fed4089-9de2-4685-abdf-08db49a74a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2023 18:18:25.4748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaSOswya2QIAwt4yhFRpWK1G60Nd8gQJX3iADK1XxvNigGY/qlfFZ3ZHsobANUBSg4ZtbEbzwduGuBRdF0lBTdGpypj0pVu4lmQik6LA1Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

> > +void virtio_block_feature(struct virtio_device *dev, unsigned int f)
> > +{
> > +     BUG_ON(f >= 64);
> > +     dev->blocked_features |= (1ULL << f);
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_block_feature);
> > +
> 
> Let's add documentation please. Also pls call it __virtio_block_feature
> since it has to be used in a special way - specifically only during
> probe.
> 

Ok.

> > +     /* Store blocked features and attempt to negotiate features & probe.
> > +      * If the probe fails, we check if the driver has blocked any new features.
> > +      * If it has, we reset the device and try again with the new features.
> > +      */
> > +     while (renegotiate) {
> > +             blocked_features = dev->blocked_features;
> > +             err = virtio_negotiate_features(dev);
> > +             if (err)
> > +                     break;
> > +
> > +             err = drv->probe(dev);
> 
> 
> there's no way to driver to clear blocked features, but
> just in case, I'd add BUG_ON to check.
> 

Ok.

> >   * @features: the features supported by both driver and device.
> > + * @blocked_features: the features blocked by the driver that can't be negotiated.
> >   * @priv: private pointer for the driver's use.
> >   */
> >  struct virtio_device {
> > @@ -124,6 +125,7 @@ struct virtio_device {
> >       const struct vringh_config_ops *vringh_config;
> >       struct list_head vqs;
> >       u64 features;
> > +     u64 blocked_features;
> 
> add comment here too, explain purpose and rules of use
> 

Ok.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
