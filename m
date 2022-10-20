Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F94C4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Oct 2022 21:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42C7B408A7;
	Thu, 20 Oct 2022 21:13:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42C7B408A7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q0+5VG2x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KGvvSddG_FAv; Thu, 20 Oct 2022 21:13:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 663A7405A1;
	Thu, 20 Oct 2022 21:13:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 663A7405A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0180DC0033;
	Thu, 20 Oct 2022 21:13:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1220C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 21:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64E7A40643
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 21:13:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64E7A40643
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TMx1soLwsyFl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 21:13:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 138B6405A1
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 138B6405A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 21:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kko+LRlqXx31WTjBIy49XXnlcW0ZJvP82xHT5CWLNh1o/QnSUd0/H0m59pxh0ib629amEPpe232zSFAVtfkgRSE/jTzhRzf9paEglSVyxpthcyRzKdkbiqBqIUhdIGdoXk7nsDjeWNAvUaRt2uYtqitS8eb3Jt2ovvkyeJ9DIpHrb/BonYYdhFHIY5KipBtGCzHHpU8AvKAsuMkzTFXjboJOQ8Rzd/OnnS212jVktSQaSAnA3p5Lm1YhukWx76/7DgAsWasGuXAEI7hjN/fZSM8RculDh7DBpvCCtVpSc79L7C8lWpMrR3n7XTddJK8DtZXtJjAy+toT+4uaEpnPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKzq3+k7/7hyvIFXqExbKj4vm3MbFW9sZPH6gIJjT5Q=;
 b=XrwO41VSSG2CBs94c46oX1p9IDNxqb/nU8EiGd4W2OtgcZDPHqo25fTYu5v2YwZObNWQ3/H3SpEmpP5B8rYxoAEjosHBAJOcbMXzLnVkXhxAH/E8DfpCBfnB2CnqRrZ6xXgdL4Dsir+Y4cdXcj9X2AhC1FW9/4891VvtnaT1oCek8ANsOPqTwafAt/WKvUzOilmqEZqwADpr3KLdiSnLn/v9aTuh3kXup11U/ntrnSKyIl74umVpY8iqNk/phYPnZnLsOb+nTnoB1AvTQxdhJZbswLnJeY5SPN+wNsDklEC5YW/5c7mdTpynSbI5aCRFGyE7/feegHFWee9/HJQoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKzq3+k7/7hyvIFXqExbKj4vm3MbFW9sZPH6gIJjT5Q=;
 b=q0+5VG2xCZM3Rcx4bDb1sd17vZH/Fpg7qpIG2+vtbPriCiGuN6mCFEUzuAcXLDH8BmkM40DjNt2P3kyQkIZjEstiZemEKNGfPQT2gRlxJLyQ6mXfBC8dTUrV3F8pa2GQdNcdbevvB62Rcu3eBGtynFFWN3JZtssVpb4ROOCSpHkwungIPeZurfDgyqNvkhoLpI6IRfoXaQg33UYFxOgQ8uJKp1iPAv77fMoxU0T65h31yPEKoi7yex9jMmqTwxd7dj6kOLb1ogMatucMlzuapamoDYBtaRTyl7jWn827ERj857GVjO7BZOnMtM7ElBF3I0Ej4me+WRA+RPhp6s0xeg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS7PR12MB5983.namprd12.prod.outlook.com (2603:10b6:8:7e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 21:13:11 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::d756:c945:3194:629e%9]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 21:13:11 +0000
To: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v2 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Thread-Topic: [PATCH v2 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Thread-Index: AQHY41WbPQEI6wXxKESCU7kV+N18k64Wwi+AgADWKICAACry0A==
Date: Thu, 20 Oct 2022 21:13:10 +0000
Message-ID: <PH0PR12MB5481094D34C15C5C442F219DDC2A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuDn+Y8OEw6uK+FC0oOOd6+kj0EXS4Fm-+54GjrqY3_Gw@mail.gmail.com>
 <86529a16-6358-ad9e-7ae3-ea1580db015c@oracle.com>
In-Reply-To: <86529a16-6358-ad9e-7ae3-ea1580db015c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB5983:EE_
x-ms-office365-filtering-correlation-id: ffa6d0fc-37d5-487e-74b2-08dab2dfe4b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzHngn4HVggYiFwpOJm80VSdg5T/Q8nEVi2ARj2TuJXYwQVq0W2i4AZXzqkxfV6PK5CbMm2UFuvm8dON1EVNskea5iZTFzI5z5VZs7UNJo9fJ4whTFOhzpdYlNJA/j/iOONAbQqkJKXlrpBqm9QFDbkdzkPRVgl4Snk6j8sa6YEr/LTui12RGmH1FGl9dCSaF88Caf8GsLdkTG56WgR+KVdTjCtI2q9wdP6gfUhUWqbkWTuWv5B+bV6XjIG79m0q2p/uB8XqlbiUNb2DNVfV8bL1HI22XpSSRqpkzAnbg4S8sY7Ww1FfwckfmNHC6gEsGFjmJRFglWnNYdUKLoHXFQmM2UE4KdW9ihPaCYEtc4TSpeWQfkimtGsAfWtsG04eaO+TEeGi1bzrtKfNwk3q9aAClD6UiGOuAfR+HID20SbMHjKCbqzI+1HZxohqKD7OBBe4e01z3eb3zLQLFZKf0JCPaenGGGEOzRZ6g4YpfTjCG5jb6cprPRMHhAW9RlcilUY07bRu+rI1XEXupTifc63p0AqKM3ffY/q3REvQe94EUSEo2BqzGRg4WJOFfnigSREBaI6LUyMKrrYNl2v8uWH06TfmmjdyYXeoGxoacZpsuTnlq8BsJXEV9+OTv7p30S7V+9s1yNi6OBtIlJOUpbXm94TFn+u0JNj2ZA4odKj5wM/aMPWv2fcq8YS2m7uWRgc+ZPFf2IA3UEA1h75c5YoKilsaL0h7FvuMDSSt2hKzjcJSEcPRT39Td26/9PvNwqd21IsLqeLtYoNH6HVqGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199015)(4326008)(8936002)(478600001)(38070700005)(76116006)(66946007)(71200400001)(9686003)(55016003)(64756008)(52536014)(66446008)(6506007)(2906002)(5660300002)(41300700001)(26005)(7696005)(53546011)(186003)(66476007)(8676002)(110136005)(86362001)(83380400001)(54906003)(122000001)(33656002)(316002)(38100700002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmZNRXdqRVdmeVFISmo1TWltWk9XN0JmZnBPUVNaMDZPcDVNRm9vcDhBQWM3?=
 =?utf-8?B?eWJiWWUxVlhaME80Q0Q0MU5ZVEdUYlFtY0pyNzhUVy9yVHB3NE5ERXN6WDRH?=
 =?utf-8?B?Skcwc2h0dUhMYVpqYTdZZDlvRlZwM2N3L2JQdk1NVGs4bVhobDdvVUxhNkY1?=
 =?utf-8?B?OUZVaVdDMGpDWmJhRE9saEU4QS9ZUTZnSDlITjBpeG00dmJoU2lPb1FHbkcr?=
 =?utf-8?B?SlpWeUNOYndFU3dIa0JRa2dyVEZWSEdjZGphcWl3ZHlXSnloSFVDUVJzRWYw?=
 =?utf-8?B?UmVhcmdYQ2t5SFFibUhzdE93Nk9kSlExYU83ZjNEN1pJcS9OQkdOOFZ3RVBZ?=
 =?utf-8?B?bDFmMzVwZEFKSlBta3FMdzMxT1hyYlQzaXJBRFdDY3QxLzFOait0azEzSXVO?=
 =?utf-8?B?L29mSG5Za2lrYmNLcUM4aFJEZjcvNGxCNVg0V2dyTkZrblR1WEVwNVpXQmZH?=
 =?utf-8?B?K2lQeXhuQjBQZ1lvYVpaL0FHVDBIN0ZxSWNUc2pwWitQdFZKTUlnRE43bHVl?=
 =?utf-8?B?aTZ0clF6N2FydkNtZW8zTnVqcFVZY1h3UzB4eWptcEJnbU1zT29ENllva1Fx?=
 =?utf-8?B?dTNUMTNiWnBDc1l5dDRZZitDWFMwcGJLZ1AybnlFdTlYci9aYk5Ib0pRMW5Q?=
 =?utf-8?B?bHpVVU5lVTg4TmFERnd2YmsrN0NBVERzUlFBc2VaekNvdFJJRWt3TlJFTnZx?=
 =?utf-8?B?em9ZTE4wRmdwem02VndxWndJOU14dy9ZV0RBa2ZEeHRLVnhSNVVqVUR1Um1l?=
 =?utf-8?B?MEFIU3VSdjZVZEhGTWFuUnB5Y3RkY3dxQ1dHTnNZcDlNUnJEa0hjYVVqL1o5?=
 =?utf-8?B?aEg3Y2JVWE9PNkR2VEJwbjF4UHVWb1RidVRRbEttcjdQdmsydHgxZjZGY05x?=
 =?utf-8?B?WUFUc0hBb1BPM3JURWZxT3RtaW9EMXpxMzd1aEFRZDVkN2l0ZkRCRUo3UDNX?=
 =?utf-8?B?cmVBMGM4TkE1SE5YM3g3UFVzMUh2ay9RbTN0THJ2L0FObUJralZpUjlIZUUv?=
 =?utf-8?B?U1hKV0dnc2xNSEYyMjZzbzhYVmtlblhlak8xSFpiSUN6VTR2cWhuOWUzNTVL?=
 =?utf-8?B?aFovbjUzM3VsS2N6T0gzcjFYL1Z4c05EcldvbnhrZE1rNzNVT3RjZ2s2cmsv?=
 =?utf-8?B?TjBXZW1UY1JlOHJuT0drUFE0Rk15OFpVaFQxdzMzM2ZwNm9VNm1qK043clNR?=
 =?utf-8?B?WmZRTUR6cmpvdnhLR08zem5WbUdZZ0JxMmZTQ05OQ25Od3JKa1BwbytvUVhS?=
 =?utf-8?B?OG04cWJheG0vb1RmTnBFQ1FneEpxNkdQbENBNlRBYWh1akJ4clgxYjEzMHB4?=
 =?utf-8?B?ZHdvSnlQZTNpZDg0NWh3Z1kzMEppQ1FHQWs1dm5lTnhLNVB0TDVUU2E4aldp?=
 =?utf-8?B?ZndNL2xGbzVpdWhBMzA0N1ZibWVhNk1maGZHcFllUVIrVHlLN0I5LzFtNmMx?=
 =?utf-8?B?aDVucUJ2V1FWQlk5c29MVXV5MGhmaWFlaElaOVRuUXlKUWVXS2JnRUpnVjYy?=
 =?utf-8?B?dWkyZXN5TDVaUm8yS0hVYnA2SkFGVTVYSDR3L2hZWFNQbkphTnBaVkpqY2J5?=
 =?utf-8?B?a2hsMEtaU3ZnMFJtY2YvdmpxcTlLZ001N1NDYzRRWmdMRGRYSWwzL1JBcFBx?=
 =?utf-8?B?ZlA2b0Q3ZkZMMXJRWTlSV2pta2Y0NDZBeDMrb1NBcFlFUDJWeUtaZnhSVlJ6?=
 =?utf-8?B?SEg4V1JxTUltSHpkVU9hZ1Jvd05aL3NBVmhKMGdDTGZ6cU5VTEc2bWFZRTdV?=
 =?utf-8?B?YjYzMEVaZVdzV1lvd3R3NG9iV1VGbnhmTDk1c1Jpb1hCcnA5SDcrUVFDSjBT?=
 =?utf-8?B?TjZiL2VWRkVhOHgxdHhkU2NUQ25JTEJMRjRGVDVBUmpjdE1MeFNLaHJvaWNH?=
 =?utf-8?B?OGh0MTBlV25MWDNUSkhRYmdtVFlpRWIvTFl2QUkwcFhFZFpqWmRXQWJzbFB5?=
 =?utf-8?B?dU1WeXJNdHltNHNWbUZMazg0ckZRNkdoVHZIQTNmN2UvTGpNc0hMK0hQZ2Jy?=
 =?utf-8?B?VGU2UTdMc0ZaZG5McVY1VDU2cmJPM25kVXNnUWdoNlZKVHdsUVJKUnIyNXlp?=
 =?utf-8?B?WkhMVDRGVzIyZVo4cUQrTWNyS3pWVVd4NHFDZ2djMFJGWHRvNXJkaU9wRnR5?=
 =?utf-8?Q?VBwE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa6d0fc-37d5-487e-74b2-08dab2dfe4b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 21:13:11.0204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06dJ5YN2rOx+m2zYSFgb/O7KVZcVgt3FWNWsKL9SR+jXtaugHgDOchflI5/N1y5/+thXoV4u6GsnMgQaownT/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5983
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

> From: Si-Wei Liu <si-wei.liu@oracle.com>
> Sent: Thursday, October 20, 2022 2:12 PM
> 
> 
> On 10/19/2022 10:25 PM, Jason Wang wrote:
> > On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com>
> wrote:
> >> Live migration of vdpa would typically require re-instate vdpa device
> >> with an idential set of configs on the destination node, same way as
> >> how source node created the device in the first place. In order to
> >> save orchestration software from memorizing and keeping track of vdpa
> >> config, it will be helpful if the vdpa tool provides the aids for
> >> exporting the initial configs from which vdpa device was created
> >> as-is. The "vdpa dev show" command seems to be the right vehicle for
> >> that. It is unlike the "vdpa dev config show" command output that
> >> usually goes with the live value in the device config space, which is
> >> not quite reliable subject to the dynamics of feature negotiation and
> >> possible change in device config space.
> >>
> >> Examples:
> >>
> >> 1) Create vDPA by default without any config attribute
> >>
> >> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 $ vdpa dev show
> >> vdpa0
> >> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs
> 9
> >> max_vq_size 256 $ vdpa dev -jp show vdpa0 {
> >>      "dev": {
> >>          "vdpa0": {
> >>              "type": "network",
> >>              "mgmtdev": "pci/0000:41:04.2",
> >>              "vendor_id": 5555,
> >>              "max_vqs": 9,
> >>              "max_vq_size": 256,
> >>          }
> >>      }
> >> }
> >>
> >> 2) Create vDPA with config attribute(s) specified
> >>
> >> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
> >>      mac e4:11:c6:d3:45:f0 max_vq_pairs 4 $ vdpa dev show
> >> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs
> 9 max_vq_size 256
> >>    virtio_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4 $ vdpa dev -jp
> >> show {
> >>      "dev": {
> >>          "vdpa0": {
> >>              "type": "network",
> >>              "mgmtdev": "pci/0000:41:04.2",
> >>              "vendor_id": 5555,
> >>              "max_vqs": 9,
> >>              "max_vq_size": 256,
> >>              "virtio_config": {
Since most config is related to virtio.
May be better to do
s/virtio_config/static_config or
s/virto_config/dev_config

This clearly indicates that this was the device static configuration.

> >>                  "mac": "e4:11:c6:d3:45:f0",
> >>                  "max_vq_pairs": 4
> >>              }
> >>          }
> >>      }
> >> }
> >>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 39 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> >> 566c1c6..91eca6d 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct
> sk_buff *skb, struct genl_info *i
> >>   }
> >>
> >>   static int
> >> +vdpa_dev_cfgattrs_fill(struct vdpa_device *vdev, struct sk_buff
> >> +*msg, u32 device_id) {
> >> +       struct vdpa_dev_set_config *cfg = &vdev->vdev_cfg;
> >> +       int err = -EMSGSIZE;
> >> +
> >> +       if (!cfg->mask)
> >> +               return 0;
> >> +
> >> +       switch (device_id) {
> >> +       case VIRTIO_ID_NET:
> >> +               if ((cfg->mask &
> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
> >> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
> >> +                           sizeof(cfg->net.mac), cfg->net.mac))
> >> +                       return err;
> >> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) !=
> 0 &&
> >> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg-
> >net.mtu))
> >> +                       return err;
> >> +               if ((cfg->mask &
> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
> >> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> >> +                               cfg->net.max_vq_pairs))
> >> +                       return err;
> >> +               break;
> > This makes me think if we can reuse the virtio_net_config structure
> > other than duplicate it slowly with a dedicated nested structure
> > inside vdpa_dev_set_config then we can reuse the
> > vdpa_dev_net_config_fill().
> Adding Parav.
> 
> I think for now the struct vdpa_dev_set_config has just a few fields, so it's
> not very obvious. But from what I understand, the vdpa_dev_set_config
> struct is designed to be built around vdpa configurables, without getting it
> limited by what's exposed by the virtio device config structure, such as
> virtio_net_config. 
Sure. Vdpa_dev_set_config can expand for fields outside of virtio_net_config structure space, but it should be close to virtio spec definition like you described below or close to Linux kernel objects.

At present it can handle another 62 more fields, which I think is good enough for midterm.

> For instance, there could be possibility for vdpa user to
> specify the size of MAC unicast or multicast address table, which is not
> defined anywhere in the virtio_net_config. I think it's important to match
> such configuration (which may not even be defined in spec) for src&dst vdpa
> devices involving the live migration.
> 
> -Siwei
> >
> > Thanks
> >
> >> +       default:
> >> +               break;
> >> +       }
> >> +
> >> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
> >> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
> >> +                             cfg->device_features, VDPA_ATTR_PAD))
> >> +               return err;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int
> >>   vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
> u32 seq,
> >>                int flags, struct netlink_ext_ack *extack)
> >>   {
> >> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct
> sk_buff *skb, struct genl_info *i
> >>          if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
> >>                  goto msg_err;
> >>
> >> +       err = vdpa_dev_cfgattrs_fill(vdev, msg, device_id);
> >> +       if (err)
> >> +               goto msg_err;
> >> +
> >>          genlmsg_end(msg, hdr);
> >>          return 0;
> >>
> >> --
> >> 1.8.3.1
> >>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
