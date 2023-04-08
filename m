Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87649C7619A
	for <virtualization@archiver.kernel.org>; Sat,  8 Apr 2023 07:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D20B66166A;
	Sat,  8 Apr 2023 07:33:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D20B66166A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=gPEr2If4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UuYZotp0-chw; Sat,  8 Apr 2023 07:33:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3582261414;
	Sat,  8 Apr 2023 07:32:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3582261414
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1111CC0036;
	Sat,  8 Apr 2023 07:32:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 165F3C002A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 07:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5B33845D8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 07:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5B33845D8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=gPEr2If4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VnRls5fBZeHB
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 07:32:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAF6F845D7
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::604])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAF6F845D7
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 07:32:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUXsz/+Wch60rAcPvJCAboAgBTvLYJSGms8NUb8v1InrwDzi7pM8iraN76gR8ElRDAmnUaT5Tj7ZHchpADjCor23TI3bgfoSat4NRNfRuzq/bGppWlxGjeoTIQBqu2OdXE3qUG45XV9HxN8lwIgk8A/uOxZF9eqcHBQRXvlmQX37z2JqOIBHEducym+dQinwmlPwN8AmsPvmsG84CPILnIKau7QjVBfXimGLZMd01QCuL9h2PdvjUWdv6Uyq2KwxtdbwXh+Ky2tCSztSzE7QUlz/e6hFUmv7eqQRZ1vzpqRl7QNe13iLYfr3sihKMw+KIziHQitIYZiMG6CQWun+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBY1PqxhUVmlHfSOrIal07oL9yfFllFiFyj0LVH5OMg=;
 b=RNIGLyy2HMC5ghgOcZrjtPRHJuw9DUTFYpxhxn8U6cZSWc8w/5dTmLGcJ22ibs0stC7LIEFNVBhw0racaeKI5izHZgDjYMQXkl8xRt6WjG1B2tHLDUKFq98waR26sAcS7Z1RSX2reyktmsff3plKdfE7QXmB5q0l6K7mETuKr/RHXkmcBXH/CDgLG/DN+0Cv8ZmKp9+tuLAQ7eLFgPMFUznhAPk1ohscWreV6phhJrKSYaAzvQsoXO+cEzCBrRIe0wWz3DiSM02Ru1x9U9YXT8bdgMO0k7/U0ttzJgPv5LNt1CxBiQu4boKeXKK+m3yERMvzuppgIUvCIGunZNjoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBY1PqxhUVmlHfSOrIal07oL9yfFllFiFyj0LVH5OMg=;
 b=gPEr2If4+2z+CoqGG5PUMy74KCXpHhB6Dz0eF2Bl7D0g6l2Xu6IvMqhGvqfK8oopn7U97oKTuCeWWhwFpo63eCSrORFqowPQihgJnPDZyTA4irmxbIf/1VQ+8XDq2wLDMXKyKAKMbEYW1py/WUM214LqHFX2u5b6cjAx1vIDBQ4=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by DBBPR04MB7866.eurprd04.prod.outlook.com (2603:10a6:10:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Sat, 8 Apr
 2023 07:32:53 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::54c9:6706:9dc6:d977%5]) with mapi id 15.20.6277.035; Sat, 8 Apr 2023
 07:32:52 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Thread-Topic: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Thread-Index: AQHZZTqfsYDZLLTALE6VM1zAC7sQQq8g/sKAgAANXGI=
Date: Sat, 8 Apr 2023 07:32:52 +0000
Message-ID: <AM0PR04MB4723451039675B61F723B1C6D4979@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
 <20230408023544-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230408023544-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|DBBPR04MB7866:EE_
x-ms-office365-filtering-correlation-id: 83e4cb28-b621-439e-bac8-08db38037674
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K7jkzaaxgJg1GYWtAPzaplXT/oGBRdhmXKCYKVzM1o8Std2wC9zOo0imnEkSUwWVJLlJYl7rIukwM8HAP1OWWzxqCjIiN5qMarN3NERYzi8GkVfjZNgKBb3hlk24ZqsIR7nntf7Qv90Q6oi4ukO2F+z1DdQ1ErXpmO1bcg0ENvsGSexrP0Du/F9J/7MMD5WUGQyg9tvOaqD/yK4uNgdrN77DbeiWjOCe8Yqn2jjsgLFQkLx24q/lE9zv2mMiVVH5ovdfWasKu5emT6oZM2LGBAWMahtIvSJIHa7OdRUVKgBQGhBCJn3EfKBOm+6BwVE6gZWaJQZwRg+xJu0ib5JICipc6I06Em5oFn77RJrHvcapBhc/vzHaf1hb7bToN3R/r+t54ekUZ6um5KDUg7/4+j8fMZSvz0Hs6CQMPPeFYxW7RUT704NJ7MI12gUfR0iuG3Pu5jSp3oDEY0EjhFpB32b754SHTsjJXwZVw4xyzLlQWxFsMxhLtZAGlVaUBqKBteD2em5KZwSzBoO3wSvKOGHHeLZG3G5LSRTUDgTT5tCWZUgK7mV3baP9MUnt77udbzwn87ypqduKba+jLCJWA4KS590y/1GG/JZEYZTMFb66gmSNEZfZpg+NW12+y5kU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(396003)(136003)(366004)(39830400003)(451199021)(66899021)(7696005)(71200400001)(478600001)(86362001)(33656002)(55016003)(83380400001)(38070700005)(122000001)(38100700002)(4744005)(91956017)(2906002)(44832011)(54906003)(316002)(186003)(9686003)(6506007)(66446008)(64756008)(8676002)(6916009)(41300700001)(8936002)(66476007)(52536014)(66556008)(5660300002)(4326008)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JnT1GzRJfqXAxd1t2fKA3r3ZyGAoIQdFVBbw5FhZpAiD7apc8fgQYlvTC1?=
 =?iso-8859-1?Q?22Hire7brVJ7+ePoZ4UIWiErJrNLhhfOXrvW5WHJU7xuurK5Psw2J3Me4B?=
 =?iso-8859-1?Q?p6D+ziCj8JYiZVNyCcR6+YsX4crxq34wFqPWvc8bA5qsYi6mhqRrhKN4At?=
 =?iso-8859-1?Q?nAl+ZAnc1FJLuCadXeNnpUVgBpPqYqD7vUHW8VSyzFpt0b2Hudskddp/YC?=
 =?iso-8859-1?Q?uDQmFYkm2jewc6JG8lWZFbaVTrPXpslHAXS/OJuQEFUAdD4aSad+2nXCZl?=
 =?iso-8859-1?Q?by8fP4ZUeTcLDBa6mwc7y7VxR3IzqJ2wDT3m9KdHOuls+fTTNs02s7DvpC?=
 =?iso-8859-1?Q?wYEZqU6p6ouqoYNTy7Ar5lzo4Dy76LYBI9RH/54dLjR59dlFJfDPoBdbMb?=
 =?iso-8859-1?Q?mBCvl0VRnvm4txZDoFp6Cr0eH4xb6Ai1fHeGZRHm987+qcBFOLMsCDJLb+?=
 =?iso-8859-1?Q?cx1V21v7gv7O7CSLZo6q0rBVuktSCkGOqmFMhoE6soW+kvJ47vPLsNcmZZ?=
 =?iso-8859-1?Q?CXivU0Nzsahm6eDEoMnPgg/XjOBusU783d7NjLohPvIWRBLaxy59zU+FiP?=
 =?iso-8859-1?Q?NodYM6VTj5vIUlZCYoWBQft+yRN3yL7907cFB68HU72ERz0zOFMnSZ7YEg?=
 =?iso-8859-1?Q?XoFAfkBavIfnyCygZZ0btMHihkBZccRlnt59SCPq9ySv7e6DivJZxAbgAa?=
 =?iso-8859-1?Q?LZqjm7XM7eg5gcdBsnWlBGBxtS2JzZiMDPcpuW5SkE46+tDs95Q1Iu8+Hn?=
 =?iso-8859-1?Q?O2ZbIaVm3EGJCKTxjTWd9p441OxwSTnKLu3N0kSXxSp25kGaPJUtc5Rpjy?=
 =?iso-8859-1?Q?6tVmsem6ddIJ3j9IqUSTl9jSSS2r9m41egILcqnSyxqa/uRXz6K9L35Azz?=
 =?iso-8859-1?Q?9Ifxl4e4ixd7Z3/qbOszsAKna+iqEhDjycDkqPSW/F4s7vT1E1m/fkcvMd?=
 =?iso-8859-1?Q?5YukVRsn8rAWch8g9XlCizEHQnWrxcmlgaHvcr+en8+QP7pSGO8GKni/H2?=
 =?iso-8859-1?Q?G8NymTd398j1el8o4OlbocrjH22fj5EgxKGzChkklk64EtEdNK4ZdGAwex?=
 =?iso-8859-1?Q?hbBxlXJ8sh1NrS0aH52VlQW614aPIUW3JH/NTnrkCbJaKTITuy1JCOllca?=
 =?iso-8859-1?Q?S5tAdXf4tDUgp7w6fuGZzieAdQ9UUS+0bpWrDOPuh1/TIQiP0b3XHh4Biy?=
 =?iso-8859-1?Q?a46xgWqMb9MmSKsdRL4cNVm5AyZxa0ZOrIKCgKCK9bX+qFN1ILAN4EhjU4?=
 =?iso-8859-1?Q?6lVptqgU7W2SZTKjijR5rj3QeqHXVpX0oHwZCqS4h/GSAUyMkdm1EDjYoX?=
 =?iso-8859-1?Q?bbGJKT77BcWmkx1IWlB2rJNdw2agsX8LNHCo8bQNdpV5FG85tS0i0tSzjz?=
 =?iso-8859-1?Q?graHg3H3AekeZwYWcsHC1JGUyRc5mpgPxD4mjo22ksgZ5XCOs74BotbLQF?=
 =?iso-8859-1?Q?UP3y0UKZHc8rw+c+sMFPADvN+iNQ1jhHqbG3rmcBqg4CO4lzuKjrmbKDGm?=
 =?iso-8859-1?Q?/uLKG4i3TJSM23/q4RNPtSYlmJIkdpAzJ7+peTpj45bkNVf8EQb6GFkUIO?=
 =?iso-8859-1?Q?XF9xEgC+GEC1uwPpXmkIe3xP+azEPZ+ydZRA/kaFLhzqCMZP31cPjVZLPd?=
 =?iso-8859-1?Q?AtnCq4hPz4ypfro2Bv+EULeYqCYoixje9vdWz5R6GpEkhphsTczJSc8R9I?=
 =?iso-8859-1?Q?0faz/guCyQRJuredep6nG4AsYbDn0HBhX1nobeNd?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e4cb28-b621-439e-bac8-08db38037674
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 07:32:52.6331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JV0gFx0ktaur9lVab06yqbZucilr39ORJtZfk29XavcoT8HE2HptQn4KG+C9iFpzUf23qh1ax+mWDLk0nd79N0T+gq+CwLQP6xf3uWC12aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7866
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "viktor@daynix.com" <viktor@daynix.com>,
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

> Hmm so I conclude that drivers without kick_vq_with_data
> should not accept VIRTIO_F_NOTIFICATION_DATA then?

Yes, vDPA drivers without kick_vq_with_data should not offer VIRTIO_F_NOTIFICATION_DATA  in the first place.

We can be more forgiving in such cases and clear the feature bit + print a warning.
It may be easier to debug when creating a new vDPA driver.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
