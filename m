Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347CFC76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 07:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C31726143F;
	Tue, 11 Apr 2023 07:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C31726143F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=YIg1PVs4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lVp9JW0qvyWW; Tue, 11 Apr 2023 07:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55A2C60746;
	Tue, 11 Apr 2023 07:08:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55A2C60746
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DF1EC0037;
	Tue, 11 Apr 2023 07:08:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB2E5C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E4B0405BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:08:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E4B0405BC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=YIg1PVs4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oedDxLvc8Xs5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:08:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B20B4056D
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::601])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B20B4056D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 07:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXhu6efL+9PeCuiDLs1beTY+obebBeQ19HRQSA3YSGOavyG2w6s1Gn1Issj7gk5/rcfntVHYZfGKf+h+gFmOguhwQG7v+9HOosIJ+/TjRi3gn1WgpVd7BKHKqmuHkVwCInX+3in3rJxsjX/Nc3J3ziY00eUsoqBM/1gC1aieuwPtMBvEp6Zhvvx64Iq6ui9xB/BC6zvWS1JJLZ+dKM0gauAKiQusl4ylOZ8DqH+Tllh6aKWNOnNcvTAHmnn+LzXSIcGuXRpcQ7UqJ9+ILa42gnGbNGHxPGT4NkqXf3kBUuEML5d802dVnnupE+MY9RV5zqyuJfJjvAQnH/hdzyD0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDJ3d8SRK5z+jtrYGmthZP/cWhMsAXKxRxCR40smIRw=;
 b=Zph/SuayeGAj/W0nKdo4oOZ4YQJ37+rV037O8RtuhcJLXT1mQHr7qGqTjz6Ntpzz/zD/yjkxg7n+lzWpPWepvon9teweQdvjwM0BDkR/YdMTqk16EsBTzEiA4qtvsKJ1ea7FtcXmkvgb0ubee240sUmRl835Gjz5arsnBZMxdCc5k5fivNjvDcnj/CihZj9bTUPOyNd08+Gan6joCiXg0SQQ8ZtMbPVcxsEr9Wk03UBXVWgqwIAKPOL6kjIsZz4OdZHLRRdwVQdXS6N4YSXmH2h3eo7uMFE+JAhPIvztqH62C09ClT/648oVr+FDKQY+6bGx+xtow71SPUAYxmvCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDJ3d8SRK5z+jtrYGmthZP/cWhMsAXKxRxCR40smIRw=;
 b=YIg1PVs4uoIAs61jXTeITm6pkKqRy2gBBEcvcFF2livHA69jENPlelwDiTqdgFtXWH2cMfbzP8UhIKLwCXKQu7FVwsvlfrXBKovfquDaQJESWlFSO4TWnGvokiInoouVew/1t1t551b/x2Tgf+JDBphdgPNPbzwwenPPlOlhEgg=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 07:08:40 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 07:08:40 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v3 1/2] vdpa/snet: support getting and setting VQ state
Thread-Topic: [PATCH v3 1/2] vdpa/snet: support getting and setting VQ state
Thread-Index: AQHZa5OZ5E+KFfrE9Uakr8OakqZoJq8lkmiAgAAce5c=
Date: Tue, 11 Apr 2023 07:08:40 +0000
Message-ID: <AM0PR04MB47236219ECF5D8B279532B33D49A9@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230410100237.3499578-1-alvaro.karsz@solid-run.com>
 <20230410100237.3499578-2-alvaro.karsz@solid-run.com>
 <71bb8651-e0d3-8eb5-1eea-57b65e629e16@redhat.com>
In-Reply-To: <71bb8651-e0d3-8eb5-1eea-57b65e629e16@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AS8PR04MB8916:EE_
x-ms-office365-filtering-correlation-id: 2a1fc626-49d2-4297-7072-08db3a5b93f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBff1r3TJogM6oZCjbV8WWUVWawbQ9QN7+xoKqXe3RPUPxSLbd1WIUko2LGoeC1zFm+AymGszi2WYBTDCe+B+dZGAjsVXWzvtT3TMzW6PG7Bt56i658Sbh1F8y1oRnNupsFloWuh3Qi1eABkzUo1FMBM3vkRNxmDC5LCCTMrV7Og16OZmX76IIGmOZZc+dGMF6wOWEeUCTc14ft0bn+BaLXOhdjaf8kKbdCAYWENbQ0GWicBnI6ZUXz5xpWmUtaKlAObDInTiiw06imKMhjb10rxNGRDtOXY2UmQTPQGxekLB86Z0Rzh4ZN5qtMXP1uoDRLcjfGwkM+4SZgkuyaxR4rc+5rXK7fmMxfASQTVGKiY5LRqv24CQd6u4gzkGT4aPo0lKnu3M4EQ+FyZU0GNy37GDAK4Zj/vQtVPQHxw0vK+vDZf+tR71CdmB4MdcHKs7xDy8bt+O4Mp+aFQqNjqIQxq7oqFiCfcUqW2oPUG1F+BceJoUZgldCffTLbcp5booQYMGsHectploChYlaut6Fqy9ZQfimzEXJQrcDis6KNURLUesI9IWa2KiBdmxC65Ilyho5/A5IU3qAYi494WEwGblNFOEwtrPFfauTrHWnhwauKsa3isgfo77aDgoacs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(396003)(39840400004)(376002)(366004)(451199021)(44832011)(2906002)(38100700002)(5660300002)(4744005)(122000001)(52536014)(7696005)(38070700005)(71200400001)(8936002)(9686003)(6506007)(41300700001)(55016003)(4326008)(86362001)(66476007)(66946007)(76116006)(66446008)(66556008)(91956017)(8676002)(186003)(316002)(110136005)(64756008)(33656002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m3bgXliHycI9KacHiSew+zvyaGm1gMk0OYQOwEh8fxl8WTUccTTRzUusws?=
 =?iso-8859-1?Q?mo4qxZZxbgnHBdIzmqM2X2M/IAzpQKgvf1FsIlwZ+HwEeu1NOtTBfIPLKo?=
 =?iso-8859-1?Q?HmrIEWtgtNrFpNSf7D0nMz/jI1xwk5n4npz974at5v14ltuBwkidKsgOQq?=
 =?iso-8859-1?Q?uKCeitLGzPv43QGfGQ970T9JZ/04wBNZRxyJIN3KFaqwxjH8OzxmNBl0/I?=
 =?iso-8859-1?Q?ofxHLjcuzD3vNto6JiPDAVyMvL93oM4V/9cvNbeWN46siqWj8qnMMdPfK0?=
 =?iso-8859-1?Q?Xe6TV0+S67RPgXNdB5kf0FQa6ympTtqdsSleYrNs6Tz3ByJtAHZAQ9UACW?=
 =?iso-8859-1?Q?pzJSaWyrQqmLcp4V4JlX8xWI4dwDyVtSKmEvt7MMxUFctmqDoNhlOVKwfr?=
 =?iso-8859-1?Q?zz1bIzq/nf277B5x4svRXYy+fFlzZ4ODrPOAd619SYFT3JZ5qlGp/zQkvr?=
 =?iso-8859-1?Q?yxM6hgMXwSuCXvy4x2h2I8lK2d3McudEXV5Vo+LO8rdzwA9BgoAoW7r/lK?=
 =?iso-8859-1?Q?OyxDUmakFLlMm3rCdU6ASyVbHjzqs3kOq3ONd70acuakey3ouik1Pc4Ohr?=
 =?iso-8859-1?Q?HC+/iux0eaHnGX9YN4qkfmOrIl9rlik0fHB+iAOpSrDcvZ4XGeb+paOeBt?=
 =?iso-8859-1?Q?sBiE04nSY9CJSE8DaoUmpDp1Ivs8Z+xepKtZvmWMOOEOB3ZYTrzywI1WPZ?=
 =?iso-8859-1?Q?62doNirEROyaCiuuUwWS5d7pfYWKhwlyD5Deq3YNhepd08rbA14x4Ols8y?=
 =?iso-8859-1?Q?1E7UqUK3bNEwNWg7OGBhS1pZqBA5sTwfdIp23S5c7gngv3JWuJ5ggKJfDu?=
 =?iso-8859-1?Q?O8mJ8cB7cg1aYfKDzpCt5mKOghYJUh0XWD9QX/1z4lE2Vh0X4xSjvTuiLg?=
 =?iso-8859-1?Q?Q7PyX2jNCvPHOgJe6n5892agrUH4GfdRFdgy4tVM+vxS3woyeaojCkS1u1?=
 =?iso-8859-1?Q?CHgAMxoWqJS6WjnAweIpQW4LyVgFqWH6V1zOO6FgqecJ5An3swoW4ywgNr?=
 =?iso-8859-1?Q?Y6J5/37/JmNztaIM/62U6eTf3NSjdC6lPfa51H7PCk7SBvQOwFL0nyZY5F?=
 =?iso-8859-1?Q?sKxVUiEAGrkFY+rfrF7Q3pc93vrJP4tcK53Rp1VxniAWZXMpzSAvUMAqpQ?=
 =?iso-8859-1?Q?2A8c5kMpVGzkIrjDi/CqYkC5JrPs/2aNlq6u+n7sxZHuZsrCiK361u/AAv?=
 =?iso-8859-1?Q?F2ybcmfqnpGW14A3CBVPjGH73jRYdl1dLKJcbXrHfQvEDyCs4T1QWuaZKx?=
 =?iso-8859-1?Q?zN74ICytRu+1o+/1XlosJoSUnQKJZpD0Yq4uY49WiSSB/ICj8NXcmfAHHX?=
 =?iso-8859-1?Q?LSyZxW2ScsvBUOOgr4kORRYhx6LPaChgLE3dgi7o2DyrM2+fFIynl9tKBg?=
 =?iso-8859-1?Q?6MKKo8/gHKQ5eXlPu3EWArEuSnqZOyH6UiqMHOmF1w2qvAZfN3rxT7OL8n?=
 =?iso-8859-1?Q?MUmrTZOjjr6KatLpfkA/O6IheyL5rxmTLJeO57P4bq6sL6q02fMPDKg1lS?=
 =?iso-8859-1?Q?g3+6bZrnQyT/S2gtZ8BihSfPyS0/vHCwqhJ/HAZcI1Mh8YaP/kpXCogDRQ?=
 =?iso-8859-1?Q?4RkrzLOdNkgPo8+S8Eelo2/zmOSoYEJvv0d+mPIhMqsMcO2qG7jhPLmmzw?=
 =?iso-8859-1?Q?0YNGsAfyJMrYA1dllActgTAvWzsg6KY4EOmkuURrJxCrXlMRczaenk3qli?=
 =?iso-8859-1?Q?7nWbrndIFokt3r7x3/LdMf0lDtEgabFm+vCmfi/Z?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1fc626-49d2-4297-7072-08db3a5b93f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:08:40.1676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EW/ecDAv4FDEhif5lt4rOHpe+JLhONAzrat2tCtABISs1QNVkGCA1ozMMpGghnmHDC/ni7hTLgUMt2g9xO1zJPvE9R+qXL28/ny9WpYE0Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
Cc: "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> >   struct snet_vq {
> >       /* VQ callback */
> >       struct vdpa_callback cb;
> > +     /* VQ initial state */
> > +     struct vdpa_vq_state inital_state;
> 
> 
> I guess you meant "initial_state" really here.

Yes, you're right, I'll fix it.

> Btw, who is used to initialize initial_state (especially the case for
> packed ring)?
> 
> In snet_set_vq_state(), only the value that is set by bus is checked but
> not the inital_state.

initial_state is only used to store the vq state received in snet_set_vq_state from the bus, and later on pass is to the DPU in snet_write_conf.

The name initial is used because this is the state we initialize the vqs in the DPU.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
