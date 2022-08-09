Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489EBC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 21:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C61D560E33;
	Tue,  9 Aug 2022 21:49:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C61D560E33
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q0BDNNJq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OfNx6g1ewWzk; Tue,  9 Aug 2022 21:49:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22E3260634;
	Tue,  9 Aug 2022 21:49:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22E3260634
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8C59C0032;
	Tue,  9 Aug 2022 21:49:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 774F5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BEBE40169
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BEBE40169
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=q0BDNNJq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AucLjLhYygf3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:49:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EEF64013B
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EEF64013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 21:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDzAOD0R0aQ85W46+CeS7jRra3u4nGJQUhWs+aSAk1r9z28JbpPh/ZAbXx63YDmwkBbkR++XjJzVMQuSTeq9A4izxqARwmeBSgMagEqjZL7xOphQZW0RcwFYWZ6Cy4S/g3VpuVjniKHAxspH3jTmTI6Po+tx22LjnmfF0wFtUkKl/gA4AIJGj4sfrTbVehegTmLnCtHZgfFcKuZwtW/+U8Uo0SS4CaWGGlNhmsgC15kM7Hw5Ccw6Ro2rvpOst6q+Oe6jGE+qK1y+jj5TZLXu4cvjTQWzvfZuCbIBK7gZOi/ZaLX8UKBfts6XmCJcSSohxZkRYB0uonFFDQGbs+qc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVTo1/7e1C+ss+UT+Il/LGCHt2yKbAYD2Stbzmsoc7g=;
 b=KJTSwBN/Gj7ZOEIAlh+6wy7VWBOeYQcDVgpP9fiEaWnJf14Zxd2NwPbZINMCpVSkYjACmllZfOX5YWMtpChnvSIkMRv9a6fTLrwDt0tAWDSlcjGnbEZQXqiJ0FsDn6vlKo3meCvqwcdreiuvUX3nQGypR2tTQC1DWQMFoBmQ5NV9Jsnq6klYBLKTzV6I80neSnFGiJxYDusfKYsnKfNqNHtSbJ3KVEBJoPgDttt4KLHMaLusnux9FAl4fvkmylr8hgPuiovM+2oqL/OdQdDGJ9K4T7L/TkZv418IdS4VQalWKihD0h/dT5JZv3iedMT/vl8pJb5smM1+oXd2mLQtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVTo1/7e1C+ss+UT+Il/LGCHt2yKbAYD2Stbzmsoc7g=;
 b=q0BDNNJqWequjpLDM5F1ppHVYhKjG+D2+lslNWQ62Q7I1EUOoqFwjqvP+2JasvpY+q1SVjML+synBoZ3j0I80xLy3/63w0G6GgGLThC4VYIewGrNF+DdMCqwqTZJle8veHiLsA5MKMn555bRfBvWXrk+Fz/AyqEW6tgSocBxlWIq/8vFPpsYuy5zyqkL4HIYzfFpzFpuuGVExRC2f2B8fquM2ziFH5IFPCWw6nDhDkPPh4ZcEjT9i+dDGIk/EFknBWVo5BmqZ5cohrHMGHKisxvvf1OJ5/FrF1ig2r97xB5QVjXxJ4OH6nWPFPYzyPblNa8f2a7nq5zajX+Dx0Cgbg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SJ0PR12MB5437.namprd12.prod.outlook.com (2603:10b6:a03:302::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 21:49:04 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::957c:a0c7:9353:411e%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 21:49:03 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Topic: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Thread-Index: AQHYpirEKDhT8iEHv0Wl5fiZieJEBK2g5FqAgAPA+oCAARNOAIAAeEKAgAAKdACAALbdAIAAAJwQgAAHyoCAAACEUIAAKRiAgAAAt5A=
Date: Tue, 9 Aug 2022 21:49:03 +0000
Message-ID: <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220809173542-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab76fd04-0c1b-4422-f946-08da7a50f9e4
x-ms-traffictypediagnostic: SJ0PR12MB5437:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IM0gGIHtgTf5sIwHB7QcF05TrcKh2KSW76AmSel23sm6P7u3jCrax5aPcLMXg2t523QmKneih0Nr8YkuaZko8xri3Tn/EyOKKCAcwx7TR2CpB3fjQVkt9EdNMAAK5/mYyv4fB87dse7Bi8H5Fn1+N4Bn3SrS7+EkarWepvQjj02784BLHFcdAz4550zfH0j71PnG+M7OBSOnUcI+E1KQEPoK9ooKUsDIC7lr9IuJbXRuNWXhbVhoOYV+Be2CM/jE51sDaZ8ituoGW7jhJR2kcjg4y+XsocDdPpG+JUnv5BysQjgz27cyiRtfhUxSvlIGR/XEi8neWDNpKxrmS0sKfbt0HEOEIPnwFoefK0DFfyRYU9fia99WKsNIjzjOH01eBpvgA/8Hgx11eLUPQjDHOR5VdjEvw4AaXjkc++AqQtN+RyoBt3qZHnUMwC88SDkXdIlw3oqcRwJXcXkvyzJ2NO/SnHV2Pq1Xpb09XtN+sINVrHz0ufd/5MVN6IiEI4NswGogWiYRPG6sTTo+6tZuDZS33FSHutcrPORdfKT4+EuNO71ly2x1+VXCnesiolK+n2iIEWsVie2CvDzpYSFFVxPZp2y8FmvNXPtIyc0dhrG82CICRwRdtNxHk6PiP3vtalh2qXwebjmOb9t9XftSGKNIb4Hhn7G/qEB8mlLYkZEacptONeoSyDIA2ala5ib2OmoqE9HQdRZmx1g9rk87GLPMO2bVJsll8leIB3VVE+NPYyXvQ0x9QEo9Fcb2hn7IPIdRImNfUxqs5ZDZw2Ga1kbMnfP9Jkwq5+GCAoEdRLWsMQYesGgFk3T52ger8Xkv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(4326008)(55016003)(8676002)(5660300002)(64756008)(66476007)(66946007)(6916009)(52536014)(66556008)(66446008)(7696005)(316002)(76116006)(122000001)(2906002)(8936002)(38100700002)(7416002)(38070700005)(33656002)(6506007)(71200400001)(478600001)(86362001)(26005)(41300700001)(54906003)(107886003)(9686003)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG9NNHprZk9oeW1FeTVsS3ZhWEFaU20yaHFFN2FoYXdmMDRrQjNzaVBydUxx?=
 =?utf-8?B?MGt3WkZCT3dBTU1nQUJUcldGdzNFeFJxSXpVVkZYWUh1NCtwWkN5eEFseG9n?=
 =?utf-8?B?aFpXWnpwS0F2ci9qMHM4Vkdoai9YVnVrSFMyNWlnd01PdFNhbU1tTzc1bEJo?=
 =?utf-8?B?QnY0QnpaRzU3ZHZmcEZpQXdaRUIrTUEzZlVmKzR5YzVEcGZXaE56VHpXejdL?=
 =?utf-8?B?VmZuelpja2FMUlUxSzJSSktES3JKbWgvcnUrSFB2SGUwSjNlU3NmSXpRbUpK?=
 =?utf-8?B?QS9BZWFLWnNmS1dEc3V4bFhiSWl4VVFQTTdPR2w1akpWSUJ6MFpReDZoNGNI?=
 =?utf-8?B?SGJ5c2NnVHkwUTVhN28wTlZIRVRQS05xMU5GQ0FDL3pydXJjNlMxRGxOZGh4?=
 =?utf-8?B?bis0bXgwL1BPNXpZWjZuMm5CaVhkTVliZmk4Tmp1UjFjL3QvMHMwNWpUUFly?=
 =?utf-8?B?cjVaWGE1Tk5ZUmdrR1p4YnRpcVl4ajVoOEFOR1pZVDFtNXcxeXExSEJwMVFP?=
 =?utf-8?B?TkFXYldQZUpMWlZtUU0vdTloWTBXL3lrd0M1a3pDYkY0WEEzeGhleDJHbVRY?=
 =?utf-8?B?ZFJoYklqSHh5K0J4WnJ5cW5YN0dEV09vWmpzMVk2Z1BVQUg2T0M0SUpGZkp2?=
 =?utf-8?B?NHQ0cG1XL0kyaTM5OGpKc2tmNVpzQWtSelZtai9lS1dPb1hTNzlWQjFJUkVy?=
 =?utf-8?B?N1NOVHFPak5OTHp3d1RsYWw5T1BXU3liOUNmSC9scDZ4eStkdzVkU0pZN2RZ?=
 =?utf-8?B?VzIveHlZQTJNTVJGMEF6cWtSZ2ZJSjhrKzIvbXB5TUZBKzVJUC9Uemt5SVpP?=
 =?utf-8?B?OTVoR3c5UGRkWWQrWmI3WmNiMy9rRTN4STl3NWowQVFuc3ZubGR4MUlENytz?=
 =?utf-8?B?bnpocUdRTDlhRjU3WU1yUFlBcGZpbFNGejMwZjhLRk8vZlBaSCtkS1hHWmEw?=
 =?utf-8?B?WkR3QnNtMFlPRE03VTRyTi9JOFhJdHo1RktQYUhZOVJiZ3NXQm5CNjVOMzYz?=
 =?utf-8?B?bmJPNjI0em5NV3lLOHp2czI4c21GeSt1UDRFbXVmU0R4VnZMWVV5bk9xbWhV?=
 =?utf-8?B?eVpSYTB5c3B1TkhEbkNXd3llVGJxNXFiWlFwbkJObGZhQTc5dm5DdHUxTUl2?=
 =?utf-8?B?NHo0cVozVm9NTW53ekRFcWd5VHNaNTd5Zll2L3VmdVoweEM5Rml3MUt2ektq?=
 =?utf-8?B?eDNoTTZ2NlZ4OEUyay81bzFPYzRDVTRDZmFUNHNwNTh2bHBGQldjQ0pLSmcv?=
 =?utf-8?B?TjR4RWtQSVhDcmtzbnBWZTJrbFh0Rzk3TThkWnJvZVp5dGJZMXdyV1oxOUsz?=
 =?utf-8?B?RjY0QkEwNG02R1JZaGMyaGkrSEhZTi90S2tZV2V4OG8xZVVRMC9jWVJuWStN?=
 =?utf-8?B?cVNZYnBVdUxPTFpFSVprdm9TTkJjWmxBb0xYSWM0dXk4YjhhTGdmSENqbS9L?=
 =?utf-8?B?UlI2NW8weFdveXVKbWFuM0tpVWJNRFFHMkp2N005SUxVVTdXSGMrUnBTd2J6?=
 =?utf-8?B?ZnFrRVBNTG5tbklCOWI4R2NEVmlxWG9tbmJBa2ZNendRZ1NpY01Wc0xXWUpY?=
 =?utf-8?B?ZXZXVWl5UmJqQlNxaWYydVNaeDVRRm8vaTZEVzk4dEVRNlpKYzFLSGNCNG1z?=
 =?utf-8?B?UWRaUDNzYjA2REdFSElCWXhDbnVnak9EcUFtU1Y3dWt1S0xpS0llQ3VWQkx1?=
 =?utf-8?B?eGwyeHJoc3M4dzk5SmdBS01SSElRMlQzcnFTYmlLaVpndTVoMmF0YXl0VVds?=
 =?utf-8?B?SXNzUExNVTNOSFRnTzBWYTF2cjNrU2didm5FcjZyUjErUno1dnA0RDdiUVc0?=
 =?utf-8?B?ZGllajUzRWdQSndoeU8zTWpMNG5ON2FFbEtpVC9rcDJvN2hUUktEZHlhMnVG?=
 =?utf-8?B?d2s2Q3dQckh5cytWQzdYbWlybnpJK2E5WW81NVI0blpxS2s1Nnc5dmNvOXZS?=
 =?utf-8?B?OEo1eG11TFoySFZkZmxobGNDODNxU3BweWZOSEJEazl0QVVBaXZscDUwb2hl?=
 =?utf-8?B?NU41d3JQZVRlK1BrWSswZ0Y4NXMrSDBtcm9KbmNPRWgyVmpEbWpmWkF3SjVm?=
 =?utf-8?B?VGNQaUZVWnBla1BtOE5DNm9ITi9VNVlqaHkwRmxmQ3FmVG1LQWpia1prYzRR?=
 =?utf-8?Q?e/qk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab76fd04-0c1b-4422-f946-08da7a50f9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 21:49:03.4695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxAcKtX7jQ/AK6qUmvjZsqesh8JnbJtTCC/AEzNfXiDDx0N1qbifVvQwAPQ2wyc+DNwKyR8uCBeYYGPXfgrH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5437
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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
> Sent: Tuesday, August 9, 2022 5:38 PM

[..]
> > > I think virtio-net driver doesn't differentiate MTU and MRU, in
> > > which case the receive buffer will be reduced to fit the 1500B
> > > payload size when mtu is lowered down to 1500 from 9000.
> > How? Driver reduced the mXu to 1500, say it is improved to post buffers of
> 1500 bytes.
> >
> > Device doesn't know about it because mtu in config space is RO field.
> > Device keep dropping 9K packets because buffers posted are 1500 bytes.
> > This is because device follows the spec " The device MUST NOT pass
> received packets that exceed mtu".
> 
> 
> The "mtu" here is the device config field, which is
> 
>         /* Default maximum transmit unit advice */
> 

It is the field from struct virtio_net_config.mtu. right?
This is RO field for driver.

> there is no guarantee device will not get a bigger packet.
Right. That is what I also hinted.
Hence, allocating buffers worth upto mtu is safer.
When user overrides it, driver can be further optimized to honor such new value on rx buffer posting.

> And there is no guarantee such a packet will be dropped as opposed to
> wedging the device if userspace insists on adding smaller buffers.
>
If user space insists on small buffers, so be it. It only works when user exactly know what user is doing in the whole network.
When user prefers to override the device RO field, device is in the dark and things work on best effort basis.
This must be a reasonably advance user who has good knowledge of its network topology etc.

For such case, may be yes, driver should be further optimized.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
