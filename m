Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F89C001DF
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 11:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 942CA60F3D;
	Mon, 24 Jul 2023 11:42:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 942CA60F3D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sX8l5DyR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qq79b0w4Q2E3; Mon, 24 Jul 2023 11:42:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 05B4E60C19;
	Mon, 24 Jul 2023 11:42:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05B4E60C19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB4CAC0072;
	Mon, 24 Jul 2023 11:42:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 245E2C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 11:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D97A281E27
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 11:42:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D97A281E27
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=sX8l5DyR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hVoYX88NeGEP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 11:42:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7048D813D9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 11:42:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7048D813D9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLn8z5ZqnQaXvNftfZTfy/oQtWHvq+n3IUjaCkObetPIN7eIRoTKuaemu/e0yZC92CyB0E93QBLtnM7R82wcJ9l+BbSV3drFvyiufwpEMpL5DejPb6Xql60H/USICBOkdxJJ0jlICKi4jGn+UBMQzxKL3FobTbR6rLQFwnpF/c6TjFwQLFDX4AkXXe+YYU9O9YnJrocQW6kwScnDgslPOeJgNfHJfA7tg8D0BiRlg17elX1fx0LZ5TcMu7mn8aWeNn7L9AnVmUvMu/3Z95bAxLLJx+dpR6wwDuKC2TnFOY/4KGuZ8IoU11z5ijhWUykPKsn6HB5Hx5guN/Ffa8Eajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFSZ6lKMr23ip/iZ1qfUvgO4iF9Z1X2ZVgk+4TU+esw=;
 b=lnHzUG1zzsjDNm+y+bZYOEnNyYfUSgWlOfEsJt3Y0uO1uDm+KV79TvUv+iNAqjXU7NnDxT9UEyE4+ElFgSuPl/kTJTwwGR1k6G1iOsXfKeb2uUT0UC3h1lPTOvAKaaAC4e+c2Y3EGE6L8E8VCxa9QdPuorUWg1o/JW96n1l9L0XIqmBJ4UYB+pBxVnUtr8uRJ4bj37VHiH0XrDCo3PiMayu9GjIWUpjTIZ4fpHe0X/pAnnUW1NfqI+oyc60n5NsjKModmVtfMU7ONcsSLb5yr1HvHs/kd5fFPq6d5D37qrTehgbj+Q4y2yOsxKy8t/TMRwRpjSMMwcWgaNMcvV/z9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFSZ6lKMr23ip/iZ1qfUvgO4iF9Z1X2ZVgk+4TU+esw=;
 b=sX8l5DyRZt/xwC3Tf3AFMq2IOtQOJCBvq1QwvfF8A8U1IPt8l8ErkxyGP6OWD2e4fr3zE+cgj2ADpu+S7RF3U2udgzdayPslot26bhDT6oM6EwrfnxCM/YSR5fZwe5OvShFx0KJ8iPxEjnVX6Z0eIBEu3PCYjO9KsxqgwTOMm8r4iIM/rvKbrX5aLOaGCLL06GnsOxnwTUZ7XAdS7uWNIGEWBBRcg8BRX10k3IKLFfv9sjatqKPSpbjPc00TMk2wF1GEmafJ6n6Pm0KxAk0BvbqMB9cJHkN01ZSuBJXFDU4bMyIIljrS9v64a5GPTlMYF/3xp5SQYcjx/aO01sfncQ==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:42:42 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 11:42:42 +0000
To: "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length check
Thread-Topic: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Thread-Index: AQHZvUcvqaqP85S+UEe1bNGo0diH2q/HHwrXgAFiqICAABgRgIAACriAgAAo3oA=
Date: Mon, 24 Jul 2023 11:42:42 +0000
Message-ID: <280068e9c684f0ae644d195d3a4d3f5a1351c366.camel@nvidia.com>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
 <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
 <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
 <20230724050005-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230724050005-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|BL3PR12MB6593:EE_
x-ms-office365-filtering-correlation-id: 64aaba9f-7713-4c75-efc8-08db8c3b171f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aqKXhZGsFqkRlPDpWCtLNTf4ArEY5kSM8rLVdTAltswXehSP3bHtiSmS6B3qMks3pMQ9yJbFsT5a502VpE4QauuGT0clNJgTBT5P2bt1zH6IunzzDsejonq0uDTZSw8ksMkeRMhhSD0/xkpnCxEfLqpiV+YNdwPxLFo185I+eqUn0hoALdi6ojkiA4ncBQqRSXu4Uk1BYNDCZmeMZldnXYOWExOLaiRG1gBBDTD7ilxxdOTj4Jj/e6E7KPU+eJ2VRVjK+IU7M/IOztnotWbNs6gK7f9jW+IoIxImTKLkfJsQYAgANQh0mLX3cX+IynHtyI2qjGAS3d9eEcz39IYDRgnKOrv656zF+fJEY7iWPf0ca5ZPHW6P3ImrX1qbUR3/4op8LKlh6EvgJTJqBqg+joybb/ZKxFZzTa4hJIx1oWWp80LoDuvo6wumzTZ4eXZGU95G2uWcPurfB6YATUwkkJr+83MX6Pc042IqRg2cgt7l7KtCBmPF0QwpC6Wc4gvtH5BJH28P5jFYSn1Rg2YUbCLAbaWXngRGWCP6g8277DLAN9+IuAFvxNW1JtKCqafogVx99PseEj3smJkaR4mA4B/PFK8rscGW5yrtsI5Y0KEnFdfr+qBEzg7SnZQepIpB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(2616005)(36756003)(8936002)(8676002)(6486002)(38070700005)(6512007)(76116006)(66946007)(66556008)(64756008)(66446008)(91956017)(66476007)(316002)(83380400001)(478600001)(54906003)(6916009)(4326008)(2906002)(71200400001)(41300700001)(186003)(38100700002)(86362001)(5660300002)(6506007)(107886003)(122000001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXR5eHdwa0R2YlUxYll0WG1tSkNvQlJXdFlCdzh0QXQ4QXJWUlBQZlUweTVj?=
 =?utf-8?B?YUIxSERLNE9ZWFJiakcybHM0QVpPYVV5ejd1b3FWekZsaGp5VDFZVkVoNnlW?=
 =?utf-8?B?dnBXeFg2aTlpTkpac0ljT05hMDF1NjNjWEtROElkQ0l0M1FjQTEyZkVkdE5N?=
 =?utf-8?B?bWdkNU5VZVEwc1hZc1hSR2RzdVVMS21QcTEyUm9Kb2V0c2tGa2ZLRnZvRk5h?=
 =?utf-8?B?SWFIa2VUWklpcmJBMFMwL3BuYzRsUTBmZmxVM1lCWjBobnFwenhXMCt5RHR2?=
 =?utf-8?B?UUZ3c1lsTVNrN1hGT0xwRmR6cDlZRG9PcmdOZnpyNkI3MUtVSCtvZ3lBTm5p?=
 =?utf-8?B?VDJOZWpEZkRzZmlYNGVwaGFwejVXMzMwbDAwWmtrbEVmcTA2RS9LdFlHalNa?=
 =?utf-8?B?dnZQOEtOMG84MzEvUjNpTlozMUswZDZXM0todloxNHE4VXRmanZkbFVRb3hm?=
 =?utf-8?B?K1NBYUhQWWdZbU5HaWFOZXUxUnhLK1RScTBBd0FVM01xRi9TelVsYVJUUGV2?=
 =?utf-8?B?dkdtbTk5akRwTzZCdjZzZTEwcGhqdm0rbi9zY0FNL0Nsazdza1hEdUVleVB2?=
 =?utf-8?B?R041dU1ZdlZHaDYvRC9rRWg2QjdhWmtXc2gzNUVzR1V2aG83L3FpRStyZXNj?=
 =?utf-8?B?T01XTVZXT0tGeGJ1OWsyZXVTZCtEdHlKVytVdkVqWU1SS1BaendnbFlHeWhy?=
 =?utf-8?B?R1FBMVBSeVVGc1JrTmxkMm5QZWNWcGk4aWd6ODRuSWdsL1lRd0ZQUmh3K3gy?=
 =?utf-8?B?TTBHS1BkVXd4KzRDdVRuVlQyVnVuV2QrbDFxMTNGa2YrZUJmanRHU3FUQmVo?=
 =?utf-8?B?UWVuY2VGSmhCaWNSTnFaUVdSUWMvcUhaWkpIa2xtQTFrWHZkZDVXWXRaTzZ4?=
 =?utf-8?B?MXN4eHNGODgwZjRxUjBlcXdFVzI1em1CSGRKNWRDMTdjVlhmOWU5amY3ZmNK?=
 =?utf-8?B?eFV3WWszUUdBa3lkaFJVVEVpQmRFSFNXeVBRVlhUTnZLQzl3OXo1Vk80dGhH?=
 =?utf-8?B?TTVlVS9IUjNwWUdpMGMzZDlOMVRuOExKWGNBMU54R2tDYWhTczN0bW9BU2dw?=
 =?utf-8?B?Q1Vkb3FmdmYvUmpON3prQTRzR09lRkxrYStMdkpNZTJYM05OMlI3WUNaMWdL?=
 =?utf-8?B?RmRkeEtzL3A2QTgrblF1QTlDL2NTUlQwKzRXWkpYSXJJU3h3K2I4Mkh3WDJu?=
 =?utf-8?B?c01NMm0wbXFPaXBTRVhMNzBNc2c1UHNQVDZlY0UwNVJIMUZ2K2YrcXBJVTI2?=
 =?utf-8?B?ZjJzSU9GYVNMcU9UVEpuREM3TlNvbGF1WEVWN3h0WFNKRExCUUV5aFV2alcv?=
 =?utf-8?B?Y0VNSWRpdVNKNXZEK2p3YmNoNXBDODZvV2JVU0tPM3lxaGsvM2JHNTZWRk02?=
 =?utf-8?B?dkxweDY2d0VpMENoc29Kd3BDbDByU25sdlJ5YlJmZy9xVTk2SkZpQUZmV0c3?=
 =?utf-8?B?elRFZTFpd3BLeXlGRXRsMnQxQy8rRmVLOHpVRU00cDU0U3BRcGZOK2tiUS9u?=
 =?utf-8?B?TWxNMjhZV2ZYNzJtV2pxZjZPQkxEdkRmUjB2ZzdMTlpLdXh3a0dVS2xGZUZR?=
 =?utf-8?B?QXlUcFhTaERnZStweFludTAvUDRJd1djbmNmNXZkVUtBd1A1eDZ6Zm42Y3d4?=
 =?utf-8?B?VzlTSGdiWThCZjdkaDd3U0dBMDd0OTY1cjR3d2xiaE5KWHN4N1ArRE80SXVz?=
 =?utf-8?B?N0hFOCs0T3lGZ3Bxd2J6U21IVGZPY2RKTFVxemoxc0tMTm85NVBSQ090ZTdB?=
 =?utf-8?B?S2VRdGErdG83RVFraFBHN1UvVURINXRjL2NyTTBKeDF4eWV5eHdhRmg1aVEr?=
 =?utf-8?B?dWVzbm5QcC9ZeGdWT0pIY1RuTFJZYnhvSmwvaUttWUZWVWJ2Rk5NdGxnemtE?=
 =?utf-8?B?d09GcVFDaFM2Yi9wMW5EVmozRmpRekx4d2ptVE9vNTBJdjZwUnU4emFTOU5W?=
 =?utf-8?B?TTg3RWR5dExPQ3RzRmN3RzV5Ky9LWWVNMTl2N3VvWXJVOEc5RllVbytXdk5Q?=
 =?utf-8?B?MXV4akw2d1l0SXdON0pWY2tIdUZ4Q3VBUjBqZzlBak9Fb2gwSzhZYnRDQUJU?=
 =?utf-8?B?ekttclVQRUhKZU5jNnNyWHBwNmJ0NUVBUXNNbTVLNWRTZmVPbFJvTkF1WFRE?=
 =?utf-8?B?YzFMUHo1QXA4V3ZWVitNaDF5L1JCZzBPSEZjQzZkaUtJRFhuMnJlSEJ6bjV6?=
 =?utf-8?Q?6AoQsRHd5P62CpFH6szVcJVmZLkxZJ4VADcH0AVhm3DT?=
Content-ID: <8A0400A327677F42AAE0C5096D6F2E6B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64aaba9f-7713-4c75-efc8-08db8c3b171f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 11:42:42.1835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nBvYOmA041Vh528zAwcXHzyGIR8ocbbSkPByj6JK73lwjeiyVtKaE38UEmhqSkvnfrK1FsHkpegunCdi8UvxbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <elic@nvidia.com>,
 "linma@zju.edu.cn" <linma@zju.edu.cn>
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

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDA1OjE2IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIE1vbiwgSnVsIDI0LCAyMDIzIGF0IDA4OjM4OjA0QU0gKzAwMDAsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMy0wNy0yNCBhdCAxNToxMSArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZToNCj4gPiA+IE9uIFN1biwgSnVsIDIzLCAyMDIzIGF0IDY6MDLi
gK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+ID4g
DQo+ID4gPiA+IE9uIFN1biwgSnVsIDIzLCAyMDIzIGF0IDA1OjQ4OjQ2UE0gKzA4MDAsIExpbiBN
YSB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFN1cmUsIHRoYXQgaXMgYW5vdGhlciB1
bmRlcmdvaW5nIHRhc2sgSSdtIHdvcmtpbmcgb24uIElmIHRoZSBubGF0dHINCj4gPiA+ID4gPiA+
IGlzDQo+ID4gPiA+ID4gPiBwYXJzZWQgd2l0aA0KPiA+ID4gPiA+ID4gTkxfVkFMSURBVEVfVU5T
UEVDLCBhbnkgZm9yZ290dGVuIG5sYXR0ciB3aWxsIGJlIHJlamVjdGVkLCB0aGVyZWZvcmUNCj4g
PiA+ID4gPiA+ICh3aGljaCBpcyB0aGUgZGVmYXVsdA0KPiA+ID4gPiA+ID4gZm9yIG1vZGVybiBu
bGFfcGFyc2UpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZvciB0aGUgZ2VuZXJhbCBuZXRsaW5r
IGludGVyZmFjZSwgdGhlIGRlY2lkaW5nIGZsYWcgc2hvdWxkIGJlDQo+ID4gPiA+ID4gZ2VubF9v
cHMudmFsaWRhdGUgZGVmaW5lZCBpbg0KPiA+ID4gPiA+IGVhY2ggb3BzLiBUaGUgZGVmYXVsdCB2
YWxpZGF0ZSBmbGFnIGlzIHN0cmljdCwgd2hpbGUgdGhlIGRldmVsb3BlciBjYW4NCj4gPiA+ID4g
PiBvdmVyd3JpdGUgdGhlIGZsYWcNCj4gPiA+ID4gPiB3aXRoIEdFTkxfRE9OVF9WQUxJREFURV9T
VFJJQ1QgdG8gZWFzZSB0aGUgdmFsaWRhdGlvbi4gVGhhdCBpcyB0byBzYXksDQo+ID4gPiA+ID4g
c2FmZXIgY29kZSBzaG91bGQNCj4gPiA+ID4gPiBlbmZvcmNlIE5MX1ZBTElEQVRFX1NUUklDVCBi
eSBub3Qgb3ZlcndyaXRpbmcgdGhlIHZhbGlkYXRlIGZsYWcuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gUmVncmFkcw0KPiA+ID4gPiA+IExpbg0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE9o
IEkgc2VlLg0KPiA+ID4gPiANCj4gPiA+ID4gSXQgc3RhcnRlZCBoZXJlOg0KPiA+ID4gPiANCj4g
PiA+ID4gY29tbWl0IDMzYjM0NzUwM2YwMTRlYmY3NjI1NzMyN2NiYzcwMDFjNmI3MjE5NTYNCj4g
PiA+ID4gQXV0aG9yOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQo+ID4gPiA+IERh
dGU6wqDCoCBUdWUgSmFuIDUgMTI6MzI6MDAgMjAyMSArMDIwMA0KPiA+ID4gPiANCj4gPiA+ID4g
wqDCoMKgIHZkcGE6IERlZmluZSB2ZHBhIG1nbXQgZGV2aWNlLCBvcHMgYW5kIGEgbmV0bGluayBp
bnRlcmZhY2UNCj4gPiA+ID4gDQo+ID4gPiA+IHdoaWNoIGRpZDoNCj4gPiA+ID4gDQo+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC52YWxpZGF0ZSA9IEdFTkxfRE9OVF9WQUxJ
REFURV9TVFJJQ1QgfA0KPiA+ID4gPiBHRU5MX0RPTlRfVkFMSURBVEVfRFVNUCwNCj4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiB3aGljaCB3YXMgbW9zdCBsaWtlbHkganVzdCBhIGNvcHkgcGFz
dGUgZnJvbSBzb21ld2hlcmUsIHJpZ2h0IFBhcmF2Pw0KPiA+ID4gPiANCj4gPiA+ID4gYW5kIHRo
ZW4gZXZlcnlvbmUga2VwdCBjb3B5aW5nIHRoaXMgYXJvdW5kLg0KPiA+ID4gPiANCj4gPiA+ID4g
UGFyYXYsIEVsaSBjYW4gd2UgZHJvcCB0aGVzZT8gVGhlcmUncyBhIHRpbnkgY2hhbmNlIG9mIGJy
ZWFraW5nDQo+ID4gPiA+IHNvbWV0aGluZw0KPiA+ID4gPiBidXQgSSBmZWVsIHRoZXJlIGFyZW4n
dCB0aGF0IG1hbnkgdXNlcnMgb3V0c2lkZSBtbHg1IHlldCwgc28gaWYgeW91DQo+ID4gPiA+IGd1
eXMgY2FuIHRlc3Qgb24gbWx4NSBhbmQgY29uZmlybSBubyBicmVha2FnZSwgSSB0aGluayB3ZSBh
cmUgZ29vZC4NCj4gPiA+IA0KPiA+ID4gQWRkaW5nIERyYWdvcy4NCj4gPiA+IA0KPiA+IEkgd2ls
bCBjaGVjay4gSnVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIGNvcnJlY3RseTogeW91IHdh
bnQgbWUgdG8gZHJvcA0KPiA+IHRoZQ0KPiA+IC52YWxpZGF0ZSBmbGFncyBhbGwgdG9nZXRoZXIg
aW4gYWxsIHZkcGEgb3BzIGFuZCBjaGVjaywgcmlnaHQ/DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+
IERyYWdvcw0KPiANCj4geWVzIC0gSSBzdXNwZWN0IHlvdSB3aWxsIHRoZW4gbmVlZCB0aGlzIHBh
dGNoIHRvIG1ha2UgdGhpbmdzIHdvcmsuDQo+IA0KWWVwLiBBZGRpbmcgdGhlIHBhdGNoIGFuZCBy
ZW1vdmluZyB0aGUgLnZhbGlkYXRlIGNvbmZpZyBvbiB0aGUgdmRwYV9ubF9vcHMNCnNlZW1zIHRv
IHdvcmsganVzdCBmaW5lLg0KDQpUaGFua3MsDQpEcmFnb3MNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
