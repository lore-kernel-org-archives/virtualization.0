Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CADC761A6
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 09:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AB6B81E1A;
	Mon,  3 Apr 2023 09:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AB6B81E1A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=BwxUPWAB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LX9wdg2hF5_P; Mon,  3 Apr 2023 09:37:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD90981BA8;
	Mon,  3 Apr 2023 09:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD90981BA8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACF1AC0037;
	Mon,  3 Apr 2023 09:37:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ADC5C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 09:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EBEF81BFA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 09:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EBEF81BFA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hx6nJDdWXZ5N
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 09:37:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 666F881BA8
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 666F881BA8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 09:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY9FEaxP/Wc94iQI+/T6vexu/h1SxXohFoLSl/+8/CefmobITqZotTbJwdixTkgBYWAKH2CguygJ66lFCLdZlOgeI+397eLyXcsOMjELaRj3Jzw6obqRcpOJyHi5fxL6C+y256DDKVM8RkunEtSDiG+6A/xyL/g0KED0nRjeY6N8Gg1BJXD8+14VJR+HTQR5+RRWNeO8G0oBA8m7JmVxcJ1dZVwQiOlcw/eb63ce4NysugkzJfpgl4ghGro7RSkvD/4O+mL0HZnO3570QDMNJdj43d76tC6UYW13+jP6nq+aRkMG/j1+IPrdLIEZ/6g50xJZ+apWlGVsW3cKU6TQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86MFi/bZiO0nmfobWZr2o2t9qlfNbc1wkwepT6DVWl4=;
 b=MsQItVrMkL3mxjn6S+aQ0dTGByKcgFNGmfUMqA5UC3VbPnotyFe2OzcZueX3eCtArj4DV9wM9Idg7k6tplUmkRaTPexF0VMFm4qVj2ra0inCSpsczixiNgNTo8tD4U2LjKcZE3YJxzNpD8x0PsBRmhy5Q4v5ceJdjJyZf455GgIk2qy0daaXG2JucU+Uj4q2EbY7t1Y0ojGt7mRFTsGQ7bD9cEcNW4pdvV2BEbCsq+9SJsoEJc8H582YbIzDhQ5KJO81jV1beq6bN5OYfVrgCkXFxUAgP/o13fY3YOYhHu4N+16/Oz7FZaAOxM+JUU8EqXh6J3Qxo04XSKueIHmhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86MFi/bZiO0nmfobWZr2o2t9qlfNbc1wkwepT6DVWl4=;
 b=BwxUPWAB/efbmDqjVTyPiY0B29jLeao+9kPMUXVk26mRUhB5x19utUcm4QJodevHwKEUAB7xccXIuajnl6D//pFfIv3nFyHPb6AMSn3p8M9M+9a73kO51vYIkFcp8kbO9XXqkeHYuFCafUnFLVs7mMOTniC9kzaFrg37CVO1C14=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:37:19 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:37:18 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ state
Thread-Topic: [PATCH resend 1/2] vdpa/snet: support getting and setting VQ
 state
Thread-Index: AQHZZWIBe5Qp6TTWaUKs4Mm16+1eFq8ZDo8AgAA8M1GAAAn/lw==
Date: Mon, 3 Apr 2023 09:37:18 +0000
Message-ID: <AM0PR04MB4723039083134AE736694F9FD4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230402125219.1084754-1-alvaro.karsz@solid-run.com>
 <20230402125219.1084754-2-alvaro.karsz@solid-run.com>
 <CACGkMEuQpJyQNuYTs2TwCc8SmvynbVwqtcZnF2EEzPEBQnpo5w@mail.gmail.com>
 <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB47239379BDB27553EB5D1E30D4929@AM0PR04MB4723.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|PAXPR04MB8608:EE_
x-ms-office365-filtering-correlation-id: 63f60482-1f7b-406a-6cfa-08db34270495
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgtV1rQZFpyXyIcVf5TndkfOj841JyVRdal3sHkAPr9f1Q0T6V2GCWtt/+PrE7NomwtlDXoCEjjUJODkg5SnTsPMGVSaztbySpc1Mh3vFsyYkHKN40DTJEp7ByBTIHz3LFBnemdKh9PcqzVDTN35DdbkbDxzTaFKvJLL74G6j7hrn+ZKO7l7yC2HL5EhErunbFY3fUGZMu+l1NByC5bFrox0FRu50SjOBZhbynjJKpOGnF7F3zyYt4lillISEAbiPBQXAcRu7BVQjerZMZRN5GCBQR0wUPkG0NlS8QjEgU1v56jdVCuIY+j1UP18TjrUDZ6enJWdmWfTSYNRcR2d3o2eyS9pfOBVTRlGLDyRFcEdY3wNXc+kRXLRlYXNzcMUSlGSL37OCnydsl0+f+2bnaqsQLgC+JniBXcHOZjpZVTF2YLlYpZ6zGcfbZ0lH7/ICJOrxo451rlywOvRSbyPYZCQ/JnD1+6qbEtnhqi8BTuA2lARMS16NbYy8CTVpOViRip7AtJIwMm5h1RSuk+br502n6SX3Uf8WZkUxRWHWQlM9eAZLkFB6nj5yrTCrfA6A/hKnaY/V1lpQ6dPHjhN5Orc7uJnt+zAEeTi+Ih0HCB/y5WggTXe6/QJ4Hn0EBFl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(396003)(39840400004)(346002)(366004)(451199021)(55016003)(91956017)(8676002)(4326008)(6916009)(66556008)(66446008)(76116006)(66476007)(64756008)(66946007)(54906003)(316002)(478600001)(52536014)(8936002)(44832011)(5660300002)(122000001)(41300700001)(38100700002)(2940100002)(186003)(83380400001)(7696005)(71200400001)(9686003)(6506007)(26005)(86362001)(33656002)(558084003)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PNtutbv011mIA4V4PYmSXWEaWJy2zBWGSPmCP93QE2Thqwp1YrCOa/7j9M?=
 =?iso-8859-1?Q?/G59F+RON2xxIT3jl55GouIosGqdhAVSYlUbHNFU60PGmdv/d1irR/c1L3?=
 =?iso-8859-1?Q?8r+gjMDW6rHaXzCikqwdWfCVQ/4ki/yf+UtG3YFAmHjNtJAW4SqBMoLdzh?=
 =?iso-8859-1?Q?fYblI/nQwja4ps4NTjV+Skt6VxHbMm8hGjitdo+kGh6brMjU8SAl/5v02z?=
 =?iso-8859-1?Q?oUSqKXl6dR3NECBn9ZO2sD6myGUgeNttPKoD9vcL7U1w4UNojeeNpjE0DE?=
 =?iso-8859-1?Q?OsDQTWzX9/VoKZJ6S96k3XHCDyJ+ZQ1UMwnVyDDM5/Jf2ph0bqsYcm0gei?=
 =?iso-8859-1?Q?WvK47BQifUPr9/khtcl9GnDQQyWTf2EwtftIXsNqGysFD8jKAAUPdSBKoc?=
 =?iso-8859-1?Q?ybWyPBELBuTB91qBsMMG5Rqm15nKMzoeAeSJ8GIIU7xFU3SJk95da0TzHk?=
 =?iso-8859-1?Q?Xd2mM3oB8+Xg41A5KYgmEs8Cim0DcraFqrzOeV14Uqs5fuzFHJzIoXOT98?=
 =?iso-8859-1?Q?/hxzU70PP3QpzCGPeDF8lIZQgWieNH/PU0fGiJnTVRHp2iC0QZD7U6GaCz?=
 =?iso-8859-1?Q?jA5lfvpxzzkbFxxYS14H4WM5AJztXH6tdMKaptGwbJuqlgf1gPHc8iaAE1?=
 =?iso-8859-1?Q?noiDT88azk4oftcr0GaFzl4lNDFQPKtcNKe5ZjCnHeDa5NuDSD+wRBt7hs?=
 =?iso-8859-1?Q?DiDlYH5jDD26HDyQjxxjd1wcPWi5bhaNd7rXInu0jXKwpqGSXMc2g98D60?=
 =?iso-8859-1?Q?+mKd9dgT2f+YaDiwqJ3ICnqP5upLfmkyPs6UeR3JBduQYTIx/zRWiV3mBa?=
 =?iso-8859-1?Q?Gb/uRKD9tnQENkIAy2ZTnKl+GgTNLvmiOOQeoH6grJbOAZYG6OhgLlo03u?=
 =?iso-8859-1?Q?It7/IZFnSU41LbFKoxwXfB5xPR2rcPJ80BV5WY0unHBoQ5ef672atMsxzK?=
 =?iso-8859-1?Q?yOPSRXX9Pa/NKir/FgNQI+kSLFMHEJqLJKcx7nqBKzkM6IpI9EGIbijaCT?=
 =?iso-8859-1?Q?4Z6BsHcvFef0IWAjulhUSsZZYQ1Hs59vWrou4J9SOjUvqt7Tw8qR6h5g+W?=
 =?iso-8859-1?Q?rAs6wKWEliUDRI6IdXtvJq1SqXMm7CEXsR3lO6dBeuD/oF5fQiDXWQolob?=
 =?iso-8859-1?Q?2Fq2dpkpUD5P081orv/msYqlojQeuyrpXho9TDAkfuZi5YiGUY/ZDb7zpf?=
 =?iso-8859-1?Q?oMySLoLxY8yJhhTpHftqyRmblCFIpStAVDrdO3FehjO4ubb+mQI6WzrhyD?=
 =?iso-8859-1?Q?TawSj9EphxCXXQSpCFaRv0pkbx7NUhjabLvFwGclzhsEuruwAWBG8v0T8V?=
 =?iso-8859-1?Q?2rC+zfjuaEGB9zkhQrQtKyy+6JkFM4J5AncaJB2baV9B7gYigJEnAsOkb4?=
 =?iso-8859-1?Q?+CQrcKH3p49OFDquvg9wT1U7k1/NCI9/oWiaJ/PNVbCqWxsyq4YyOd838a?=
 =?iso-8859-1?Q?g3O74Hlt123w6MJY/1IwKIxUSsfjhjkZgDqInUsmb20M/Tm6ii8N2VoDoi?=
 =?iso-8859-1?Q?Jid6wr2eIkIBvre+Z2tfaKbBSB/dQKRYkQqgVwrm+J3Fms1cm/alkGcMbe?=
 =?iso-8859-1?Q?ykeeqAgo+LaUA5ZU5E2ZtQYw8jeBt21rp9DCYcsPjHgxbZHh/n3Ei0IVwk?=
 =?iso-8859-1?Q?DQJd+IoPMHZs/+vWtpmPuzEBCnqdNE2ZAN?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f60482-1f7b-406a-6cfa-08db34270495
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:37:18.8221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVgWpmenAN4Y8lT9M1et7JDTqmH5OFlNWdfxnAU2eCwWR52k1xRfZYIkhR+YHAoMmR1SeJUhHtUOggVN5l06WLBbFMjCTWLm08nCGH1FoRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608
Cc: "mst@redhat.com" <mst@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

> I'm not sure how a spinlock can help in this case.
> The entire control mechanism is protected by the spinlock snet->ctrl_lock, so multiple CPUs won't use it simultaneously.

Sorry, snet->ctrl_lock is a mutex, not a spinlock.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
