Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38705C678D4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 07:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8A16812FC;
	Mon,  6 Mar 2023 07:49:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8A16812FC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-solidrn-onmicrosoft-com header.b=jhTptzzG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iYGI-cUA0KM1; Mon,  6 Mar 2023 07:49:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 38EBB81327;
	Mon,  6 Mar 2023 07:49:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38EBB81327
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1211EC0071;
	Mon,  6 Mar 2023 07:49:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 205E7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 07:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF1AF40354
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 07:49:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF1AF40354
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com
 header.i=@solidrn.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-solidrn-onmicrosoft-com header.b=jhTptzzG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U5UIHD0uXzPZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 07:48:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F21C40352
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::626])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F21C40352
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 07:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg5zBvepkGsmh0B3A8qsZ8x8BesnNVcSD8OLs1pImti+SXq0FyRWAlpqgYFh3mUue9ERk4MrPOXmTj07mzlybqLmWFZBpuojsBFXx+LgUjqYtlJpirv1CkwAGph2s8iMamixR6n7bzxDGIRTDfgEm97N8zOsBAv0pfMBz0DHGDto/aV9OnSLyUbuT4a7FPOm3NpFFyoxWpGjnrVTp7rQyW6lXqHzno41SWyFoc5YV/nDrDmxozeNZaMGr7vMley81yhRwFbX7L0hfvV9GrFud1SWHFM2hxK1k92b4TykaGdj0OG0kzk+IEvKkHV+7cYPrvnvKt3I6gF+ujvolyA0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41RWR3kp0azA7UdocINh4kEiWtlufSoladcLIEf/KnI=;
 b=H7eYUtFsQm3hppfy1vaIAJRQPWeDVbqxnXkfLkZHjgoYAUdXok1Bcmaq+riAZAzfpa1pCFNddeaFfDMIceDzfO2ycr2618LQ2VnfJL9Z9LIDkiDupw4p99c2mHAuAU6u+EjHxoKEhBVEV+ZDiYELUej+3oHkpOVCrK49k2EY3WpTVO8rMl6fOrHFzKnAAefU+n0f9MvALDjDIzqjyr/9dvvJ77nKQGUpRomPrURz3ZjaLI2+TmC5bfQNUfQi530ZzqMznT15uMjrGZEa0xkDmamrzrFI5iYT9c+IVtjun16JwWLaisv9y+Bmy3H0I7Rx+Gf19B7UgnPYss8CBxBYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41RWR3kp0azA7UdocINh4kEiWtlufSoladcLIEf/KnI=;
 b=jhTptzzG/N4DPF1PkUTGG1q7P5Z0+sNU/vPbP/LN9zvt6zqbNRxF3XWKGn+FegYYTKLFoLssUTj3O2Drsfwqx6iiYEhK28XyjVr9XCRK8/oEiSEcbNVVQY7rh3/T8gAN4PedhCKQtfEE17oGMl+ZK4G3FSUdjvSydka8Uje/pQM=
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com (2603:10a6:208:c0::20)
 by AM7PR04MB6951.eurprd04.prod.outlook.com (2603:10a6:20b:10f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 07:48:52 +0000
Received: from AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d]) by AM0PR04MB4723.eurprd04.prod.outlook.com
 ([fe80::b28a:f4f1:8415:221d%4]) with mapi id 15.20.6156.022; Mon, 6 Mar 2023
 07:48:52 +0000
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] virtio-net: unify notifications coalescing structs
Thread-Topic: [PATCH net] virtio-net: unify notifications coalescing structs
Thread-Index: AQHZT3okq/4zOsyz3kGfXdQdK8+naq7tG6AAgABFKlI=
Date: Mon, 6 Mar 2023 07:48:51 +0000
Message-ID: <AM0PR04MB4723D2274F037EDD814007A7D4B69@AM0PR04MB4723.eurprd04.prod.outlook.com>
References: <20230305154942.1770925-1-alvaro.karsz@solid-run.com>
 <CACGkMEuc_MtVpM2bJH20dmXC30Po8Fbd2Y-xv-Q=O13=pLSLpA@mail.gmail.com>
In-Reply-To: <CACGkMEuc_MtVpM2bJH20dmXC30Po8Fbd2Y-xv-Q=O13=pLSLpA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4723:EE_|AM7PR04MB6951:EE_
x-ms-office365-filtering-correlation-id: baf9857f-3af1-4945-b60f-08db1e173a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tv+e9vOA58xLmGyoOHgsDqjikG1GbCYOfpORWOc2sIXUmcUkGDaT/+Y9QzJfBivHOtmojqWU1OF+uRdrfIpg4BSsejWavoOqYUoFAaATKD//MNilxMJWJTrzEwDGot99OoHBpbJfNtmotyL23doL/9jbme8qJqtBJlciZxdjta6d7buVfsVQhZwU4d/it70kEMmgxXe3O48OwrtnbDkOukQREY9I9dszWRiSkP5ZcshHfoHguosOdIHqDjY8Tz+2xoMn+nSYlHVsNXfeLGTguVwqHJGr8SmobUz/e3SKd2YnNspplvFBgaaXHXNzG/Nmuy0svBq6HZ6JHNe1TeuHpijqM1VSJRh7w/tRKmBRsWyABbAApMyQxcKom4Ms1STsEAr3akFKT3ZcBgpEJHYARzt6Rhjw8TO3hLciZAXcYW92YXdATIWoeC3cX6uEPEsnO1CrFn+t/2nCwo1VpDwX/o7K4T5n49y5xBxPD0H5Pd2vtQrYI9Mv7hUcsubMZH2Uf5pnV/6JuLqjUgWPRvxZed1KtMVudLeepD/N1iH4Zzl9ScuGGVylaw3fx47upEK1sU7+BU01N6q2LNJx4nxAEBGTumJTyWsidiP794UWbf/6hbeWSIIMq3sY0166pJEbtyoKf965qKLftFiUUFGB6/06yvVTiU8w0KPMY5C5BMt3kv3ocz9+K02vSGO64zyp0cDSPuaUzBEWLGQ+NXkPvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4723.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(136003)(346002)(39830400003)(396003)(366004)(451199018)(33656002)(4326008)(76116006)(66556008)(41300700001)(66946007)(66476007)(66446008)(64756008)(8676002)(6916009)(8936002)(44832011)(2906002)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(558084003)(7696005)(71200400001)(478600001)(55016003)(54906003)(316002)(91956017)(52536014)(6506007)(9686003)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zCwW/S44gO+IuRpcvT9cpSzOCubf2si9fculWwhz+0l6IpXVALjsF6lkeg?=
 =?iso-8859-1?Q?w3BECcMNdhoeiumj2lfx+9Oy9kItdEmJ3ITjGtq6zulgWXlzTnGxwtaQ6H?=
 =?iso-8859-1?Q?ZJaS+4+eqB4lrbLm8ELUc4ufH/njFFeAgKeYP/zaHyLm87MB0SzyaKmkPJ?=
 =?iso-8859-1?Q?mppndoVv97q+vFE49XAlqGXAIes8WWp+NJ5hqOkHhQg3Us4Ed8OcOuVmiX?=
 =?iso-8859-1?Q?07i/xkcCsIJr/Pju9yVFrUEMCYUsF62z/7WI/BrwaUAadE6H0BOzDdwvCg?=
 =?iso-8859-1?Q?iO4a3dBl34/hRpsjuAeIQLZNFqcnosn+7YleNB1qT1k0MUcIBnPfdCsopn?=
 =?iso-8859-1?Q?lv9ZuR3m98YYKeDLkwl4tmnUV5XgGzOziWXZPuF/Btxqu9g3yK1coOjbYs?=
 =?iso-8859-1?Q?S2wQXB/3iHc63VDjWbxNdDstGvIV5hoKNaZLUEnU5JDm3I5AeVPER6/UAk?=
 =?iso-8859-1?Q?NTeDyNpMtJ+KMYckvsx02yCECuyl8XYhns1CECHWhj/to1p0WVDLCya4Xl?=
 =?iso-8859-1?Q?2xylP4llclqIgCZCuPvk/0QqQzvwfNW+zsePO92QS4kRqiEcWnrU548tvf?=
 =?iso-8859-1?Q?38Req3ChUsx54GB2CxumFzMRKrxkU2MwCKY5i2+HEAPUKgyGZZYU2d27F9?=
 =?iso-8859-1?Q?lHGlkojOmYGYnhlatmb/sLP8ZUJRF6BxEZb/yCJN0mh1Cu1G4eQsER68p2?=
 =?iso-8859-1?Q?JtcHYbN32LJDfgWQjhUXf8yqMDj6CDNT1rKDMBiTq2oKAQaoReyvNSt3xy?=
 =?iso-8859-1?Q?tbYh6FE1Hy8QsKLjrllL9cvmpdaYaOSCu1/6MzCHifuBcShUwfqeXNVoal?=
 =?iso-8859-1?Q?wdWtw5H4JT+YYa7eVxIFn+UCP2QT+fuZvX+NJdAtbZqKo6iIQoBd5qVUy7?=
 =?iso-8859-1?Q?B0lUsGhvAg7K9CGUpd5kF/QdmdycAjsTRj0i4dAFnogqDgPF7OsdhrqxUR?=
 =?iso-8859-1?Q?UI83ZMKsU2vY6445+VS4icpjaTb2MwhOfSik9VfJ7jJBxcyGNVU2tufPPG?=
 =?iso-8859-1?Q?qgcYlOVkwXaBTt0EmhFENFr8MhCXB40dwNkj8fjENFIqpCMIbqej0v23nx?=
 =?iso-8859-1?Q?7wMANJplQO5LWGBVWAkGGDwGyVhabQjdbMF0gr+5eX4z5yctDuSF7UuUr6?=
 =?iso-8859-1?Q?b3A29qqrJe2yuHDArwegDAfYTdfhR/Lub+RBlZTsWZd2aZZ0IYcNYC7QPI?=
 =?iso-8859-1?Q?889ZtN15PrzfXSkWv5HtUEU8dFZhKO2cMLbMa8RbcqOPWPSnEbwgwjfW1u?=
 =?iso-8859-1?Q?CjQJ/AsVIR/ckj+Sw/WQ2KeTdXX0ehb/93mjALyebxBlC5l9+0jGvdPHeA?=
 =?iso-8859-1?Q?scB9U/kHfBWnFdmoWOiZ3vxnhBea+Uw8oxdiCyTO7xCSDL43FVD0AmwFGn?=
 =?iso-8859-1?Q?P7TDqdl2lsT5//pFpp5kExJ9HYqld2YEvBlNn7sFUjh7meIQdzgl6ZzJHP?=
 =?iso-8859-1?Q?dZM/GSqUBK9qAqGipLyG+w8B/KamMmKTWwIIDnz2gSQzeTRKyEAt1fVuKi?=
 =?iso-8859-1?Q?/0Tt0/z661tD+HmM5RxBDS37VhnI/4cMEGTCogG/cGH4EqsrCL/xflyNgK?=
 =?iso-8859-1?Q?yC6WGur77OyMIFzIILz6zN+piy7vniTVr5SGcNUDj3jVZx+rToFeXxvGHE?=
 =?iso-8859-1?Q?/XA9agQa3Cybg+k0YkHYfzsARKo/RQWeuPM921VCXotfEkXyVHFB535g?=
 =?iso-8859-1?Q?=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4723.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf9857f-3af1-4945-b60f-08db1e173a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 07:48:51.9527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Bg8Q4C5K5zMr0GjBISbAfT4fATTctolKq1YLE/69GHw/DG6+y4436YVpSkzyZXMAHzNo9dbKtvCFyc5HPSYH6Tfa8YJTpqbpBuykC5f79A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6951
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

> Is this too late to be changed?
> 
> Thanks

You're right.
What do you suggest, dropping the patch or adding the unified struct without deleting the existing ones?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
