Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56ACC77B76
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 07:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 594C4408F1;
	Sun, 23 Apr 2023 07:52:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 594C4408F1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=gPsQzAYz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISPcwR-mqt3x; Sun, 23 Apr 2023 07:52:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BE81B40423;
	Sun, 23 Apr 2023 07:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE81B40423
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82422C0037;
	Sun, 23 Apr 2023 07:52:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4809C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7629741704
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:52:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7629741704
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=gPsQzAYz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KvOteqkZIXgu
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:52:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74E9D416D0
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74E9D416D0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+0P6iAgWbr0oRgiQ4bejXX2wJ1gL4dxbw+pJCJb3WFkzQZ1j2cJnVWb3NcLxmZHZHEx3Qn2QSu4m8RN9VlHimERq0kf/gcGtE+qhfqLQYEV4WxWK8H2SThiiaFKm3aKa6I8KeCv3Bp3cUuc1nCBLTrQ/vZXGR9JThNyi9SwqVJXEFzzL3wkysrlTouhgpT1686OY26O6fZ5Yi7H9V1iOpXu186Cg+IxhNBu9KQOf1cJXkx7NYqKrV4CQErfuVsBmErVjzyx4Fq37V/EDIJfZnVMjEvvRMg1K0Qv3BpvllI609zuhZA1o3DPgnXg/pHel84dful15jK02ElyaECpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQZhrbnw7bQwmCYnszzgXTOf3bt/bWcGOXbXD87AosA=;
 b=C466GFyY1yz0smKG62c/NMl5kQ5tLiXThP5th5mkeu0rfzp4VwVka6hlAulyd2EfgVPWvDK4KQbiXAScUWc9Sn96LfTGtube+M/WOFVcTetCeSr/L8TN784VRAjb/Yr/PqhvvA5ZiFDE3eUdxdRwCEw1R7Z/aMtFxoVR3m+ZpUbo9bPXsnZdYsXRCrTX7SW4fsGWfloOsA2poPGyr4Qi1Hj00ZLwOZNgVhz9IDCUlVL07jaJOVCsEB2+K3PkV7ij+jvPQj1wXOrAp/7vAUs0hQoYShWZmuOnimV58DduiYrePHZRR4/OzBBS31x7UpGBMRh5cRBRw/8J+6QnznHkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQZhrbnw7bQwmCYnszzgXTOf3bt/bWcGOXbXD87AosA=;
 b=gPsQzAYzTEhnjFhN7bjDIB7wg9yEKzV2vKqt+aUkVJz6AQjk0q3An91e5ehVpp0cUnO9iiuqjaRR8QAj7bFuD/S5eciCWl7T+6SSGRuAl1yTOnN7e5bt933QIeSgAowRVI0U7LwifbjmbfErPnLkEHUpSZ1nvcCfAYDT5kXkgwc=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AS8PR04MB8435.eurprd04.prod.outlook.com (2603:10a6:20b:346::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Sun, 23 Apr
 2023 07:52:10 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::d2fd:ad65:a6e0:a30a%5]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 07:52:10 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Thread-Topic: [PATCH net] virtio-net: reject small vring sizes
Thread-Index: AQHZcDeGnH5xR2OGlkuo4s6jvhNMC68uIjT9gABGFgCAAG90AIAAMSwAgAABjzCAAARBAIAABATIgAAENICAAAM4M4AAIQOAgAALfyGAABuqgIAAAQKHgAADxACACRVQMYAACvaAgAAGduU=
Date: Sun, 23 Apr 2023 07:52:10 +0000
Message-ID: <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230423031308-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AS8PR04MB8435:EE_
x-ms-office365-filtering-correlation-id: dd6799c0-a723-4d2c-fdee-08db43cfa4a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EGZ64EhSbtX/rfkESCi3eLsFrZ8Cch35ZzqfPHplw1EJtIpqgTZbpFgCOw+IB7hWRc9oZn9qlNhBk5WiglojACMVkMMA7ocjX46Gz7LFkn1UhG6SmUUU9Ep243DIt64UnvxLWnt30lYAoG5z8f/YpHg4ffr2BFypQC1tZDVEvZ3BAygWrEwUd0vRDgSTgBn3MCO5WWAAUGF0YXNII4DhRSeRDNT5fOI2oiPMI4F4060rCrTxlXI+04PmCKkhboNBFYiNDca4VvwmP5+uUIwCvzffPhEbmW4ckIzIH54QQBfp+Qrts6WqZKNLfu7qLTRozub5bbqKH2LP78D1cXZFifRhkrRJwcGZTnm9qT6tKkQ02xC607Lj348GIyh+oyYizt0125M4HaRl3ULd8fh01oK6Ow4p6FUahM+SuA6u5IznX23AxaAgDXtijuTWbLMj6rzBMYXMY2PO+z/etlF8cFHiLpGBm8gmz6Q7AiUabRqVH9dvXO283img3kLKihjCF6zRcfqSTR7OLC/RjiLtOyGiEjNtotrp19EzvxLK71RPfxAuZYQuDCo7t4c2cLpjqn4CLjN/zUN493cnNSZkdH57xPdRPtIDWqMyTvC5A8N+rWGqfEwsFoKz7TiYHhJo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(39830400003)(396003)(346002)(136003)(451199021)(41300700001)(122000001)(83380400001)(55016003)(66476007)(66556008)(66946007)(66446008)(4326008)(64756008)(91956017)(76116006)(86362001)(316002)(38100700002)(6916009)(33656002)(52536014)(54906003)(2906002)(71200400001)(478600001)(6506007)(44832011)(8676002)(186003)(8936002)(26005)(38070700005)(5660300002)(9686003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?uGNt4ivoIdBuSmkENNh7KiELX7CCmvidOX4PGXdW9Wj5rpOv1Qe05i5K?=
 =?Windows-1252?Q?s8rGu+vRGI2VLIOe0BmiXLYISwe851GaECNtKM4LUkWn5N7L3CdE5fNX?=
 =?Windows-1252?Q?sk3YxBWs5ypQM4inUAe+8/2wn82buC18xP85Kx1LI/qab1jzfVZf10m1?=
 =?Windows-1252?Q?VR66WENLFU7yyrnTYgdmouv3IPXMsMxXVXYUD+CpvJBmoj2UEB83pJ6S?=
 =?Windows-1252?Q?91AHxM3s3oYDbKeWutRpewNfq78TJytAMZSQa5WCrGyLQf4K0q1EfJLW?=
 =?Windows-1252?Q?r7vs22mZipfCv8kfPjMWDNiqGfaJuufkuV8Ja37K65Q/UxLmdbwSVRSV?=
 =?Windows-1252?Q?7a3/oP4DL7FZFngkg0mfxwbd8MK/fmY0jyXJ1ltWhoVhZtrtz63NWZV8?=
 =?Windows-1252?Q?gG39puYYRfLsOl24BHXJbYO4nmIeLqiANiYzAzCtV5XJh9y1NydXDoGZ?=
 =?Windows-1252?Q?bcNRjHM3PDRnxDNPVCTRVP5Pmj39B321itAhpuYRs5NAOqyayY9ekpLN?=
 =?Windows-1252?Q?vN46+p38aZDmJojcU378edwQHXakEgubY5ky7GB/448UlmVUM8YmjoEQ?=
 =?Windows-1252?Q?LLGfBUm8EVBN1q/x62QUxvEZQVq6w+VJyh36iF6RKCjS+KK3SSkMaPWx?=
 =?Windows-1252?Q?KqG3nhmYaaoNDbja7KpoXD7/gO+gvVVQk9JAZTULHSGRTSAV5FSs9QfT?=
 =?Windows-1252?Q?+iE4v0Prn4mzj0JYURnB4UD3BTTyJc95PxIHtp6BVLb8MFBWGH7mgcIQ?=
 =?Windows-1252?Q?BB0RK+eje3KlkrnUdpOsxaSqzfyAKbZNwBzRN4EaGeeuP0wnzkH4n/9A?=
 =?Windows-1252?Q?rTQjNOeY7D1oH/spOfArX9lioAo3lTDxRFkg4xeM1rM00uNw2NzfOzag?=
 =?Windows-1252?Q?P7R2z49ZgFNg2LvEC1IDxAeSvIoBPjdE4PyFIDf/nynpJf9ln5sQW1Tl?=
 =?Windows-1252?Q?UdwNFtm0ssrxAixyaUXamKFSMlS9KgDizfcq38y6x8EiUj4bieOznaU9?=
 =?Windows-1252?Q?3JnSJ/RW/K7J1jinF/yjAeaTrhMxzRmZbtdz6/kEzlT4Irf5PDnM59qD?=
 =?Windows-1252?Q?ealv3tDfTZNBokltrXDvGO15zyp4dtJVOA2tSKqeOnQs/ti+ZDVPBj5/?=
 =?Windows-1252?Q?xT08+X9zVdb6CekABkU4HKIEJdxTOue/7P9yyCMYnFskXoLtMCwHgUSE?=
 =?Windows-1252?Q?Pa0fFDwJsflY6JxuBpTX/evLDQ690trfsJHbbci0DKs1izvh+1nJyWUs?=
 =?Windows-1252?Q?N5tA3J53sWl2i+CaAfLwQOPcgGX67GSRBvy15kooJ7LQj53u3g90Nngx?=
 =?Windows-1252?Q?iQvRVWjd5L9uyDMIFKsZ0MciNNNeuT47OIXWogkSEvP1Vx6BjmUuIA/r?=
 =?Windows-1252?Q?K1yQgvP7ctnlmgsi9j36Z8NmUTb9HzjnRWwPfyafUbnuCkENKDXC0qo8?=
 =?Windows-1252?Q?EIc+FN3wTxFYDk7GN/iIpzGop5q8cB6KFrmyrlXoOskd1zwndL7GlDVj?=
 =?Windows-1252?Q?cJ51cMScYpvbwxBnb+3A2rJYSxZtRohzgCb5gXYsAUWY+2AesnatR65n?=
 =?Windows-1252?Q?Zl5sWJdordLRAw205RSpaw40y9vQKyzJEf7QeA/kLSKXloXPo3oTvJJV?=
 =?Windows-1252?Q?DKYYrfJY8FHLhAviPSYzoOH7QFUNbe2zfdpIkrtz1aPZwSEc5Ci+3tvk?=
 =?Windows-1252?Q?A1cDYoT/PxRRBRnXcNszfWITJoxfIt5V?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6799c0-a723-4d2c-fdee-08db43cfa4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2023 07:52:10.2379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFfRiMHHR9/OOv+Eximi+/LoxYMGmDu+4xNTSHwPGYIci9aD5muvmG46w7l9sPouXLePzh1Sr7jX3Mf57g4Mbm+f5yl2yHOLv8BWUpvHoUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8435
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> Hmm. I was wrong. There is no way to disable CVQ feature bit.
> =

> 1. Reset the device.
> 2. Set the ACKNOWLEDGE status bit: the guest OS has notice the device.
> 3. Set the DRIVER status bit: the guest OS knows how to drive the device.
> 4. Read device feature bits, and write the subset of feature bits underst=
ood by the OS and driver to the
> device. During this step the driver MAY read (but MUST NOT write) the dev=
ice-specific configuration
> fields to check that it can support the device before accepting it.
> 5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature=
 bits after this step.
> 6. Re-read device status to ensure the FEATURES_OK bit is still set: othe=
rwise, the device does not
> support our subset of features and the device is unusable.
> 7. Perform device-specific setup, including discovery of virtqueues for t=
he device, optional per-> bus setup,
> reading and possibly writing the device=92s virtio configuration space, a=
nd population of virtqueues.
> 8. Set the DRIVER_OK status bit. At this point the device is =93live=94.
> =

> =

> So features are confirmed before find vqs.
> =

> The rest of stuff can probably just be moved to after find_vqs without
> much pain.
> =

Actually, I think that with a little bit of pain :)
If we use small vrings and a GRO feature bit is set, Linux will need to all=
ocate 64KB of continuous memory for every receive descriptor..

Instead of failing probe if GRO/CVQ are set, can we just reset the device i=
f we discover small vrings and start over?
Can we remember that this device uses small vrings, and then just avoid neg=
otiating the features that we cannot support?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
