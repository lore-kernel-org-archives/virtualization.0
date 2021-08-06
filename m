Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D1AC4338F
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 08:56:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671F460EBC
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 08:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 671F460EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24C4D40453;
	Fri,  6 Aug 2021 08:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m5ROms7maiDX; Fri,  6 Aug 2021 08:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B171240403;
	Fri,  6 Aug 2021 08:56:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89EE5C001A;
	Fri,  6 Aug 2021 08:56:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13FE3C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E519382C8F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iuqcQYDuLxkP
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:55:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01A6E82AF8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 08:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzdwLtT3cK89bI38FMp81IOZz0453I+CJZyUP2Th55e9W18Y04Re3Yg+3AGoE01tzaLihkWOYn+kLfEGnBqheQ0RO+Mcil7YJ5G/1WQbjQZ5M9Cqsgf7jk4F43Vq8591yJslJk+lQTBIp/J4Cc+FIXNEqYEFVjtwEpcrKX3EhKNNrWxPCCaP6QkWpc5kJX2cydMAMAs+pPF85P5yD+q1qRunvYYtmxFBft4/+k7bdXNKcszdobpQv+LMtK+NRbkMfm7y9vmdJHiA5+hJnuFSIZbs/f2fHd3WxT29f4Vy+UlzZ/BGnaQ80VV/llzplx+tl+tAw11hrjWwTjkUlRPTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNQbl8mxvqF3RhtKxthlGO7urmIikr8/7R3S/Y77DUc=;
 b=LAumTLCrjqdG7BBa5OozD9ceLKVL0hHprwRXfVE6Iw500znqM3kYeHi1+T3lMaOgLUYvF2jfTIftixTTPgfdoT0YT2oM7HTO8sNcgrTyGHH5G+zmlWS1JhAiG6X96K3MgEjk6SDdSHqTdZAFcRCtO26WfXEwnYyDwOdgN7WbvKr/GjiS8TgxXRurRIwQ/+H/pq2zmBsW0401+t2tCRCjR3FMkteVCdNV9VA3tHdbtPBUJoiGx87nJS6lY0Fz8Sqscuot0lhHhi+RssVdjPVMHHHq1Z8PIYY6wGt6AKw4guG5HW7/T6vHO0WdGptMd1rUckIY76gFu78bANTT6MtByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNQbl8mxvqF3RhtKxthlGO7urmIikr8/7R3S/Y77DUc=;
 b=eBwR1is0rJZM6a5KQNoHkdOLtjuInWRnxtwEWWqtwrK0RVoWarzFzQhjhZb98IFAdr3W0alMx1jM2kTyp993EsXDYjVGKocy6JrnoURrKLW+WtLqjJo21EGSDvjhqNw0+58D3rVFw1hafSe5VA0PhryeeYw7hj6ujmDP6ns5bSpA4MJ3OWqo1KGXJAZpwj8/P8WUHzq2Hyl63Mth6HgBtuo/+xzgiOVGyif9Q7U1hhwuBleEnf8uYvqgkiFKRWnP9JSKfkCnsPxSnMHpcPKR/+Brn7DRLWuHPCOxn0yrMhjqW0oitHicrBpGlDkGOspNjFDQDsr1UMQMN+RzxEAsmA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 08:55:57 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 08:55:57 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAg
Date: Fri, 6 Aug 2021 08:55:56 +0000
Message-ID: <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210806034817-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2025534-bed5-4a8a-cfbd-08d958b80177
x-ms-traffictypediagnostic: PH0PR12MB5420:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB542000BBEBD1500E99875F18DCF39@PH0PR12MB5420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RYxHyTB3vo/pe/EfiipLOE0qaAjcKjYV41jQY0C60Ecvho/fIcQBnFO5noC1OG+FOz3MW7+2L6c+cO4aShqN+ZqW328i0yDRcxGIrbaOeIZ36PqjhO+xPX6poanfwC+gBtzehTrxauFDMjwYZAH4XiCkxgmf85ni5SlLF4bxiB3NEOVCskoxHTVtN30SMhPV9scuQpFDf2kwMSiixF8udoXcNIYGxKVfa/J4ZU9O/Kh78tOeZKNKNYft2ClA7YCzSnKgQBlawLo8naPgLRHT7Mc0Wgik2K00MVKuaWGBElsibk6i3io8IGdXRcn+i+arTcdOz0SKUoj7V5/6dc1KLvSbdd6VhQAvv76FzVSXWVnrspwqWIQ2eiym/qyjOUB6GUIt1FNlHMzy5tWfSE/934ZSm3/iCDl+TLrpLDnfvFNFW/CznYD4ryNi1IUvkjjslrTVxg5vKCMaS0z4xNV21IfWg5uMGz5TnYkdj2HCxm19U4ZX/MzZdkjthtITeuQOTbWT5CVcaa2zFBPG2IqfaVRqOmUGcB9MV4BvdPypAXFKoodCjhCt6A9qjSU+0SejrIRt7TdGTB/ZC1znJLBQtKsCZEkTD4xeniJYnUsOYUiejJmgi4EmyU2tcHrDDC8Dk+vVBAvzM7i5DQ5YAlC8J+ZYv3eNitW7koqX+WVc2ncsQ/no5C5yYBgansSvNO3qOlsSeqGoVMVQXROZROf6oQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(6506007)(8936002)(66446008)(316002)(55236004)(66476007)(54906003)(66556008)(86362001)(26005)(83380400001)(71200400001)(64756008)(4326008)(107886003)(76116006)(66946007)(110136005)(38100700002)(122000001)(38070700005)(7696005)(8676002)(33656002)(5660300002)(186003)(55016002)(2906002)(9686003)(52536014)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjNMOFhZbURlbFBjRkpiRXZSTFRjRThqOVNudGhHYWRUNDJhODhpUnprcXc0?=
 =?utf-8?B?aEtpNTlaK2ZvNldKdmZ1MURYak5sM1lRaW1ZanRybUlhUHMyenV3M09iSDJh?=
 =?utf-8?B?M21kdVU3MkRPVzFTejI1T0tNcGU2bGluSmF2WSszbHoxKzR4SG5SeDZEcW4x?=
 =?utf-8?B?aHBhNjE2QWMzbzkzenBCUkhnbVphQ2hPY1luY2MwY29HallWSGtZNlhSSnJ3?=
 =?utf-8?B?RUJiamc1Tlg4Q3RyelNNMlFaVUppRDhlYllkblVKeEVWcUE0bExNY2FwMkhi?=
 =?utf-8?B?ZXhWcWFHd05mLzJyZ3NZV3V6eDYwS2d6ZTVES2IxM2ZlWTFkREJkWTlXTEhL?=
 =?utf-8?B?TDZrY2tvN05lL3lMcFZkWk9NbXhFTHhyVkpzci8yempabndhVkUyQkNCSE1S?=
 =?utf-8?B?NnNSNlQzclZIeVlYK1NFVCtxSlYrTEEwOXlUeS82ekRYZnBCVXYzVm92eEUz?=
 =?utf-8?B?cTBuUHJZWHdvQ2pBNkZRNHpDRTYwS0JaSHl0dHR0ak9qZ09WeXhUVUlIaVA3?=
 =?utf-8?B?STJCb0tacDVuSVB1YmE2UzBBaHQ1TzV1S01MVWZpUEZOZmhNUTVScU5WaDZl?=
 =?utf-8?B?bUF1aTB2SndMRXZsaWk1UjhOOE5zanVVQkVxYlBQUDg3NWQvUzVDeXRCWE1l?=
 =?utf-8?B?VHBnRnYySUJMVjhRMzlid3l4U2RIMmIvZzFzdU1YTHl5VDdpR1gxVFBxdG9R?=
 =?utf-8?B?aE1MaFQwQ1VaTDRRKzg4cjV2MTFyTUJFMGdZRjd2ZU01RCtDTHE4UFhCZWxS?=
 =?utf-8?B?NUdTMVQvTlNmeTNaWWtlR09yWExYQVpJY0taTDFWRnpWeExBWWlPQzFXa2w5?=
 =?utf-8?B?cExyRXhPd1hDRi9UN2Z5a1Vac2hsajdLNE5tVnZYZkNuRlJjd1RUOW51bnpr?=
 =?utf-8?B?RWRSMDFWTG9DNzB5dnFCREtNbGprV0JTdmlnTzhuWVp0aUdKeXRjclo1R0ZT?=
 =?utf-8?B?TmVlZk5xckt1MjRGbXBsMVNHTXhRa08rL2dqR2VGUG9ROWxUYWtuT0N3a0FO?=
 =?utf-8?B?LzZSR2QzU0tJVDVIOSt4QVVWR0ZnQ2tYRmIyOFBVS2sxTmp2dk8rQVhsVE5N?=
 =?utf-8?B?UWs0YnJ5clhtNk9USDNVcm8rMVBxTlNNeEdvd2VYbTBwNldmVDdiMlR2ZXpS?=
 =?utf-8?B?MWtMemJ4NjFqTHpCb24xbHZseTl6MjFGNGZTSHB0eS80UGl3bndGTnFlWXd1?=
 =?utf-8?B?U0RTRVFBcklEV2pMbW0rYTZwT1A4WjRnQnY4S3ZmNkZQcUErKzg2QlZ4RDJJ?=
 =?utf-8?B?dndVSDFFRjBKblI1SlhQdjdoRkloYzZjbEZDK0wwaFN1OUFGaFd6RDQzdFBE?=
 =?utf-8?B?NVRJdnQxWTltVTBpMnBhMnU5Ky9jTis4V0dITkM4UGNmM0J0KzlYVUFuTU1E?=
 =?utf-8?B?SFp3U0VGUUUzcWNJSE15U2FoNWEvVkNSQmtIR1lPQTdhTW9zRHhQTmFGWDBi?=
 =?utf-8?B?WGtBZjBCY0FRejdTWDlGZ1VGeFhUZkhORGVIaHVCdmg2bGxKZDQyMzc3V3Y1?=
 =?utf-8?B?WG5QYldqdWhOMlNSWWxpWEdjK2lMb09VeXdkODJsUDk3cDI2YTBtY0p1ZENN?=
 =?utf-8?B?eHlFakN4ZmhWakdZc1lmS2hKUDJ0em9GUHNnc0s2V1dWR1ZHamxqRXQ4Sm5O?=
 =?utf-8?B?VzBlcVpiQjRUNHRQMHRTWHpkSU5pOGc5VXVHRkZiU0tHQjdlV0tEYU51YlR0?=
 =?utf-8?B?WFFjak5wTWtyT2gxakMyYko1dFJNNHVrNFpVZzBrRThldkR5STBIUEM4eTVz?=
 =?utf-8?Q?tZxEEC9seDry0jrErff6jZoR79lshHx9QfBTDRX?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2025534-bed5-4a8a-cfbd-08d958b80177
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 08:55:56.9868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJzbNm5c0aWcuV5o2mirv/X365Ce9F7l9ea6iwBUGJSBrxuAg3bnSKe6WnG4SJCsTJrOZ+M8DJn7KxysV2J5vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
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



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, August 6, 2021 2:12 PM


> >  enum vdpa_attr {
> > @@ -33,6 +34,16 @@ enum vdpa_attr {
> >  	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
> >  	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
> > +	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
> > +	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,	/* u8 */
> > +	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN,	/* u16 */
> > +	VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,	/* u32 */
> > +
> >  	/* new attributes must be added above here */
> >  	VDPA_ATTR_MAX,
> >  };
> 
> The point is to try and not reinvent a dedicated vpda interface where a
> generic one exits.
> E.g. for phy things such as mac speed etc, I think most people are using
> ethtool things right?

As you know vdpa is the backend device for the front-end netdevice accessed by the ethtool.
vdpa management tool here is composing the vdpa device.

For example creator (hypervisor) of the vdpa devices knows that a guest VM is given 4 vcpus,
So hypervisor creates a vdpa devices with config space layout as,
max_virtqueue_pairs = 4.
And the MAC address chosen by hypervisor in mac[6].

Guest VM ethtool can still chose to use less number of channels.

Typically,
ethtool is for guest VM.
vdpa device is in hypevisor.

How can hypervisor compose a vdpa device without any tool?
How can it tell ethtool, what is supported and what are the defaults?

I must be misunderstanding your comment about ethtool.
Can you please explain?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
