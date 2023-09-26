Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660A5E7D243
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 07:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D54B34179F;
	Tue, 26 Sep 2023 07:21:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D54B34179F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=D7O98zmy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vIqSvbsxDXwT; Tue, 26 Sep 2023 07:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E856405FD;
	Tue, 26 Sep 2023 07:21:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E856405FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BFD5C0071;
	Tue, 26 Sep 2023 07:21:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B517AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 07:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 902E161405
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 07:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 902E161405
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=D7O98zmy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZPcF-kUpsUSb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 07:21:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::627])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 578196080A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 07:21:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 578196080A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCt7WL0FS/b/W7UCbp+uy11XnPbsvJuR0zk+9Sc9GD5DxygF+n+yAtHNzieSbIhXBD5/AlO1PjtzRsGLscPM2lDDqTfRxrGw8kvPIqipnCH6TTKKWx4KnIy1LR1oLlRbEDQbWKeb1y0VjKraScAtOW17BofE2zlbRDKbegKvuv65mSTkWq1EpXHQGpcJg9QfhQkaUHeCMjv9t/6mVNaV1LMRrIRFZ0Yh5NHytoUaZrznCojDnNz7dkbiQ4lRfjwKGBkZPo0dCwHKY+QZfmDd8cyCA/7Vn5wVD7K+bsM8NIuXrbP59HAokRJayv/iLYHUgFb/GUmEf3maQgOZaCtXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoQDVJcrfIc5tR693N/HJNPNjLgZOmUZj+tIWQafAaM=;
 b=OxSaDZzbmlDrMVM1pQG05Xr0HrZ+RWQyrJFCJer87DRAj53kJd+lm6qnyyFFMUEE0YpSsWhX91TaQq1QKk9ncpRkCQuaJEytX6cjcasqn6yypFiFVOoD4rvOViTZ3+1DOingyMibOyatlqaySKYtFBx0/gh9VLBd0u6Ff3gEjvJsC8qhi+aHu7TqUuzZJSU/Fz+/CviMfY+7zj6PYFY/1ARu4muZcQn28jSeVZQXrtJNjQWBb3MdIvkdKi1uMEBant3dOzT9c2kzP+3S/G4uGD5dWCsOvXSFFBDoNGrghjMUpdEJTOPnkWayjjBxzznpfjOdjTqilnjRmGNRxdm41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoQDVJcrfIc5tR693N/HJNPNjLgZOmUZj+tIWQafAaM=;
 b=D7O98zmyHVrlo0tmS0GoBnrge707wMr6FMnZFaO3PafqAyd5wdAwrl2me+HtWT5il4DYm62orsaK3R0n35nnnhXAl48+Yp7jK+t+qrE2f8JNHp4ZiMxYefPgjbv5zOUpWinA9e75F6vx9MSYFTHGiFjswsqtqwwHYrtz3u3vstDVSGPULslwzIyIYDxah52RNjVprfzRjd1/IVigS8MZTtYey1Ooyum7uNrDgr8KJUOuV2iDPIERj5A7pqavuBCCMXt2UqQCLL2oN/fdjLa/ebZKMAQNflV8ZpzgmIyzf3qzP5L/yv89ICE0aUM1rBcdaxbyrRHR8V35YCjKZWal0w==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 07:21:43 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fddf:d4b8:44d9:d378]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fddf:d4b8:44d9:d378%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 07:21:43 +0000
To: "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH 09/16] vdpa/mlx5: Allow creation/deletion of any given mr
 struct
Thread-Topic: [PATCH 09/16] vdpa/mlx5: Allow creation/deletion of any given mr
 struct
Thread-Index: AQHZ5Xlk30nZFuaBXUOyCVsOMD7qbrAsnWKAgAAr3QA=
Date: Tue, 26 Sep 2023 07:21:43 +0000
Message-ID: <c42db8942523afe8bbf54815f672acd9e47cfa67.camel@nvidia.com>
References: <20230912130132.561193-1-dtatulea@nvidia.com>
 <20230912130132.561193-10-dtatulea@nvidia.com>
 <CACGkMEsC_rgnKyG3stFbc-Mz2yiKGwNUYYqG64jQbNpZBtnVvg@mail.gmail.com>
In-Reply-To: <CACGkMEsC_rgnKyG3stFbc-Mz2yiKGwNUYYqG64jQbNpZBtnVvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|LV8PR12MB9359:EE_
x-ms-office365-filtering-correlation-id: 877342d6-9793-4499-d199-08dbbe613c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ip+j8oCPXnwakUbQyb5o5TwN0DKCr6ckIaq7RfQgJqTDw+ANLWFnkg0T0WeemdQrPIzSaFEDn24bfmjkKe0TSXgp5Qdez4Gyld1Dw7k4ObFfvJyMwrmhi7F0vy9Ggj2+EUGwH/RUAwC412tKZpHWNyLInJAcxlBzz98ztJ5HxQqxHQ2Igl6i9MHRyFhTbBx0FuQO5yg3Dtbj6gLTA3RxczYrEPNlO/Dwn7eUIWww24ApdYmsFfHJnD4BxCPVJFIWAyZxxIeTUKkHosevViAX49/h3V31rdLLk3+vRTskjZBvoE1nK/6j5Hs2PLO6V/N6bFua9uDD5TogwKrHNSwoncKoncbS8aF4MvnGMrkmCutG1tAcxv2F0X0IkKcBpdZU6Wim0yQF306eqkI8N/LkM8VAgtB/F/bKlx/zrwQQbKEGyqfzZPnsewfig3o/opEQkYwgOcHrtnyO2K38o+H+y+NmGy1IIEdmNqbrqVRoHH78Q8X0tdF9IWUpyO5hU9zfCj6IgYwul8IYQat6BNnTMsJnK07svkXEgRsn0fQNbj9nEFMSeCgl/l/+S6YJIdnGr1zVg1QzasQ2acQLZyVjwnYOMmUWoCVeJUfeB6VUG2R1GDdBwBQlMShubSUt2WeR7Rp+CCrcAhbcQebDAqneyOzkAxpPOo3O9mlFsCuzhD8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(71200400001)(53546011)(2616005)(38100700002)(41300700001)(478600001)(122000001)(2906002)(36756003)(86362001)(107886003)(6506007)(6486002)(66446008)(66946007)(6512007)(76116006)(38070700005)(66556008)(6916009)(83380400001)(316002)(66476007)(64756008)(54906003)(91956017)(8676002)(8936002)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGdBa080L2V5TmhweWQxQWFuZXBad0h5UzMyRDRYSFN4YzBScVlHZ2t1bkpm?=
 =?utf-8?B?YVFFSklOWFJERGM5UUt4R0J3MzFmSVlKUVhQQVpmSEE5MEdSd01XM1RZei9F?=
 =?utf-8?B?NEkrdnJnL3czaDhPWjNjaUZHQmlXRDBKK2pBeWQrSTVCWGk4cjFwdDB1aUpt?=
 =?utf-8?B?dDhOUjRqNUZMMGdMWjR0a0N0bGVaeW9aSzVGT2RveTZqL2o3enJCV2JiU2xx?=
 =?utf-8?B?R2VvZGRpRG52cWhCYnBmU09rME5xbld5Mkk4d2hSZ3Q0d0FwbDBpekpsY2pN?=
 =?utf-8?B?R1UrenUxTUVWOVpXdHdOczBJSkhwRFNFSGg2bDJTLzVqcXRUWUVEK25oY3pL?=
 =?utf-8?B?Y1BRbDNtbzVud0hHT3RocnpnRVRud2d3YWkyVHJqdWtlVUt1cFQxYW5vMGlE?=
 =?utf-8?B?NEk3TmFWdmJkZkNxVFVYSm8yamlhR3ZIZTF1NFV1Z3puZFN1dEJjR0JUcTZU?=
 =?utf-8?B?RWJGNjdFa2s0WXlFRzloTHkwK29tSWx1ZzE3TmYrY3N5SHU4clFDTDgvMkxU?=
 =?utf-8?B?bHpNNnRWM3lYVjlOOFFURE5wRHJUd0krNHBjdVA2Z09vd1ZpZkZDU0ZXWEZj?=
 =?utf-8?B?VnRLcmdTaG9TYkc5WUVkQjIzSkNoNHdHcWdUTmdnMjhzSEtuNnRNNUU2ZXZI?=
 =?utf-8?B?ZzdueVVIOGE4eFVXaFIvMW9TQ0FaWVROQTBXTjlhams4eU1mVGZ6YXdBVTMr?=
 =?utf-8?B?b0xkeFprRW5Ob1dSM1hkZk43ZXhId09YL2Z6VmRrUWc3Q1RWeTZwcktpd2s0?=
 =?utf-8?B?RDhOZlBlN0RuQW1NTnVOUFYwcDJrdlNFakRtdWk2YVhLOVkzSUZzRmtFcDhp?=
 =?utf-8?B?eXFZMGY0RWRaWEtBL2pTRHNNUEd6NFpmenIrR2szZVgxVlN1Ung2Q0FrWTFM?=
 =?utf-8?B?NVBGT0ZZVURVMnlpaE9Pb2hoMWw4REtSVXBUdWlOdTlKc3dUa0Y1SnFXek95?=
 =?utf-8?B?ZUYrWmk5dXBERGRlbFpVRllwdm5sQ0xkbGF1T1g4SFhybnJoN24zcXZoNnVP?=
 =?utf-8?B?S3EzMHRXWmgxK0czYm51bTlqZm5lQXRqSkRxcU8wcGZaLzRxUjM2WVZucXZX?=
 =?utf-8?B?YVZoMXg2blR5b2FRcFlkUWwxajgxMDZ4Uk9WeXoxQmRYdEdPd0k3OTZqY3ll?=
 =?utf-8?B?T3VKUy95THZhWmgyVGpOM3c5TjlTQmg1Y3BKVEY4SVdtSnVGZVZCWjVTN2VH?=
 =?utf-8?B?UGZJZDVhWGQ2aTBpK0RGTGhybXFOOWdSZlJUOWxIeVJKZjNMeDJQQTFaaHBz?=
 =?utf-8?B?YjhlQXlIeVR3RDIzRXF3R1NtWFlYT0ZTRW5CazdncGI1WVIvVkZYOTB5SnpM?=
 =?utf-8?B?a1FOb0ZuSHB3dVdwcDFqb1hHeFNUY0hpdnpEeDgzTkJJMHVLVys4Y1g3U2ZP?=
 =?utf-8?B?WUlqdzhieXB6Qll3VzlweGxKVkZuVlhYOUlTYWtzTUtGa3NKUkJJOUMzUGxo?=
 =?utf-8?B?aU9qWTBrUnc4Z3V0anRFcTBxd0lyUlYyVjdTcEdDTTMzeDQwNlpsdlJnNVZh?=
 =?utf-8?B?Yjhac05WRjBWRi9wa2k2TlEyRGdRM1o0WEx2eXdPVzMxWitqMld6K3hUc0tZ?=
 =?utf-8?B?SXhXVk5yNUJ4dHYrUEQrNTZhdHM0U3JCc2RYazFoZUtnV1VPL3EwTmdDUDFk?=
 =?utf-8?B?eklzK2thMERHYVBMMFM0MlJpS1dMY2dZUkR2dXk5SkNPdE1SNlVlcC83cDl6?=
 =?utf-8?B?SlhDT3BrOHp0U1VQb1djdHhubk1mTkUxemd2clFGYTlENWZaQ3JUYlNPbVh2?=
 =?utf-8?B?OENjSzI1WEtNWG1paWVjREljL1RUcnAwLzZNRkk1SFptQkFNbVJsSEJDeWFG?=
 =?utf-8?B?eDdHZk5hTW0rVUFXNGZQQ3Zwc3dYTEorTWdrdlcwakdGQkdISkFnOW8vMDBm?=
 =?utf-8?B?eWZUa1NFWG9IN2Y5eFluOVVvVy9Nam5xREZoZ1ZmOTBnUE9nQU4zMjJldEc5?=
 =?utf-8?B?U2JERzN1YWJ2WEJPQUp3NGE1WG5DcC9HWlRzaEZ4WDgxRjg4RVlJSDV6TG1o?=
 =?utf-8?B?czNHb1BEeTZpR0Y2VVRhanU3QVg1NnQzN1dqY0M2WDh2UWZsZldwOGZuNGIw?=
 =?utf-8?B?Nnc3RXBJNU5naEhyY2JQOTM4c1EyRDdlSStMME9hWE9jTVFpWkRhdEQ4eDZv?=
 =?utf-8?B?R0hsaUJLM28vMGpSZTNMNGozc1NvNXBXcmhvQlh3RmFHUkdySW5yNUN5Qzh6?=
 =?utf-8?Q?jOSkck8X9zbzyjywVBe9G4GkGab7Qmptj6JYNTlYE6xc?=
Content-ID: <F623DB14450CE646802A603918C5C51C@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877342d6-9793-4499-d199-08dbbe613c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 07:21:43.2718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fY+bES3w9KCjDJ5WYfwbnFgZ0VnW4JGdGAQI8sHVQ7C6VmX8btgNY4wskekd3bwWX7jiVYgP/86rQs7YBYLvRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCAyMDIzLTA5LTI2IGF0IDEyOjQ0ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBP
biBUdWUsIFNlcCAxMiwgMjAyMyBhdCA5OjAy4oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggYWRhcHRzIHRoZSBtciBj
cmVhdGlvbi9kZWxldGlvbiBjb2RlIHRvIGJlIGFibGUgdG8gd29yayB3aXRoDQo+ID4gYW55IGdp
dmVuIG1yIHN0cnVjdCBwb2ludGVyLiBBbGwgdGhlIEFQSXMgYXJlIGFkYXB0ZWQgdG8gdGFrZSBh
biBleHRyYQ0KPiA+IHBhcmFtZXRlciBmb3IgdGhlIG1yLg0KPiA+IA0KPiA+IG1seDVfdmRwYV9j
cmVhdGUvZGVsZXRlX21yIGRvZXNuJ3QgbmVlZCBhIEFTSUQgcGFyYW1ldGVyIGFueW1vcmUuIFRo
ZQ0KPiA+IGNoZWNrIGlzIGRvbmUgaW4gdGhlIGNhbGxlciBpbnN0ZWFkIChtbHg1X3NldF9tYXAp
Lg0KPiA+IA0KPiA+IFRoaXMgY2hhbmdlIGlzIG5lZWRlZCBmb3IgYSBmb2xsb3d1cCBwYXRjaCB3
aGljaCB3aWxsIGludHJvZHVjZSBhbg0KPiA+IGFkZGl0aW9uYWwgbXIgZm9yIHRoZSB2cSBkZXNj
cmlwdG9yIGRhdGEuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0
YXR1bGVhQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+IA0KPiBUaGlua2luZyBvZiB0aGlzIGRlY291
cGxpbmcgSSB0aGluayBJIGhhdmUgYSBxdWVzdGlvbi4NCj4gDQo+IFdlIGFkdmVydGlzZSAyIGFk
ZHJlc3Mgc3BhY2VzIGFuZCAyIGdyb3Vwcy4gU28gd2UgYWN0dWFsbHkgZG9uJ3Qga25vdw0KPiBm
b3IgZXhhbXBsZSB3aGljaCBhZGRyZXNzIHNwYWNlcyB3aWxsIGJlIHVzZWQgYnkgZHZxLg0KPiAN
Cj4gQW5kIGFjdHVhbGx5IHdlIGFsbG93IHRoZSB1c2VyIHNwYWNlIHRvIGRvIHNvbWV0aGluZyBs
aWtlDQo+IA0KPiBzZXRfZ3JvdXBfYXNpZChkdnFfZ3JvdXAsIDApDQo+IHNldF9tYXAoMCkNCj4g
c2V0X2dyb3VwX2FzaWQoZHZxX2dyb3VwLCAxKQ0KPiBzZXRfbWFwKDEpDQo+IA0KPiBJIHdvbmRl
ciBpZiB0aGUgZGVjb3VwbGluZyBsaWtlIHRoaXMgcGF0Y2ggY2FuIHdvcmsgYW5kIHdoeS4NCj4g
DQpUaGlzIHNjZW5hcmlvIGNvdWxkIGluZGVlZCB3b3JrLiBFc3BlY2lhbGx5IGlmIHlvdSBsb29r
IGF0IHRoZSAxMyd0aCBwYXRjaCBbMF0NCndoZXJlIGh3IHN1cHBvcnQgaXMgYWRkZWQuIEFyZSB5
b3Ugd29uZGVyaW5nIGlmIHRoaXMgc2hvdWxkIHdvcmsgYXQgYWxsIG9yIGlmIGl0DQpzaG91bGQg
YmUgYmxvY2tlZD8NCg0KPiBJdCBsb29rcyB0byBtZSB0aGUgbW9zdCBlYXN5IHdheSBpcyB0byBs
ZXQgZWFjaCBBUyBiZSBiYWNrZWQgYnkgYW4gTVIuDQo+IFRoZW4gd2UgZG9uJ3QgZXZlbiBuZWVk
IHRvIGNhcmUgYWJvdXQgdGhlIGR2cSwgY3ZxLg0KVGhhdCdzIHdoYXQgdGhpcyBwYXRjaCBzZXJp
ZXMgZG93ZXMuDQoNClRoYW5rcywNCkRyYWdvcw0KDQpbMF1odHRwczovL2xvcmUua2VybmVsLm9y
Zy92aXJ0dWFsaXphdGlvbi8yMDIzMDkxMjEzMDEzMi41NjExOTMtMTQtZHRhdHVsZWFAbnZpZGlh
LmNvbS9ULyN1DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
