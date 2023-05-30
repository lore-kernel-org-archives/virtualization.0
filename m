Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63492C77B73
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 10:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B83DE418FE;
	Tue, 30 May 2023 10:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B83DE418FE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XS135A8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18JPTwKrhyW2; Tue, 30 May 2023 10:19:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A434E41779;
	Tue, 30 May 2023 10:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A434E41779
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 839ACC0037;
	Tue, 30 May 2023 10:19:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4684CC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 10:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1330660FE3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 10:19:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1330660FE3
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=XS135A8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oL_8jaEK66t2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 10:19:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2FCC60F9D
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2FCC60F9D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 10:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiZZhJDIBheSgssijKfBsgAQ1/QIEqGsYqwYtFftv6F2bIlRS6W5ySjCZ9c8zs1vGJ+Y7YPXvYbcQfXe918r2cG59ZIhZOIY5REaVNvar0sUg+y1aMEprarwwYkReJ7imwN0gcAf4VlGsRbugaF42BS1ieCr6WzRy1FY8vgpZTGdlUytpUHw794vL+lU38khlz0nkkJjYosFhBTFhtJWvPG40BWN7WPeXVng43pb9+MulpE2SS+Cwv39MH0hAazyos/M/j2k7fxvU1ZfSArSeEH4puOBwZygQNeDitGqGSXMUQBTnxVwXnr6z09G7ha1D/ez2CR4J/mS1iF+ry/G9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3WGZNXAEts9pfntzLr8nSKsEPNeGyiWH+etv7LR7ug=;
 b=aIyjTf34vhHkti9p1IpkYkU8sSIqf1J6doympR8WIKGvLi1C1d9PjDfyeEB77mahmtsRHB8/yMID8KB5dv1XZqTucVrLm/aoqK6TPesUrTjGzpZu1T0/YTqkilryx6h1Z9U+LQNmgOJA4hQGd4de/Ggkos7+TyQ2aEpBszdkNm9ZLKTl91X4KbdLV+0Q1PEBqNAjulLzX/wHrz4FshVJJxyAkbmhvfqJh4pWdc2S+J4ZVsJgBMSL9OQhGRBczT7P7ZGAv8TxeBFEYsoHewBk636lKK46Nz0Zi7bbDFf+rnEwDWCUN7htxFpThNK9TuFCPrO4GTBrE5wcZwAagS7KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3WGZNXAEts9pfntzLr8nSKsEPNeGyiWH+etv7LR7ug=;
 b=XS135A8nL4K63mEeLmVj9UKabrkBCn4wdiKyiuufeRMwlY9shM04HfRKsPrLwcu09kJLnSGIAe5iyd2YDm0QLLKlMN97u0yD4U2WWuxleoLhK1HOrSQ2d4SwB2s4lS5E+vM+wMtAQ/NgN8LCIPRqus7BbYemg+pazw8y6nzrXEgb6cmgH2GVrhv7d1a3XhAJ902htTQkPRYyVw9Etft7ZaRnpspJJXwCf57B4q34PyOHRheJgb0hZdDTj7vFawMd0D3jN+hlTjhISPowUd9YAogOKQ9oJ55AaPkIzC/+gxRzluRkvZm9sSV0t9ZtIbeV+D+IGjc7xOB9/PIaPNgjwg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 10:19:18 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fba6:42b5:9f4:f075]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::fba6:42b5:9f4:f075%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 10:19:18 +0000
To: "mst@redhat.com" <mst@redhat.com>
Subject: Re: vhost stable branch
Thread-Topic: vhost stable branch
Thread-Index: AQHZjUaQ6njl1MGLGE2KPtgjGhYoLK9ng98AgAAFjQCAADQugIAK6DqA
Date: Tue, 30 May 2023 10:19:18 +0000
Message-ID: <b8172a255a7a48524c3454676e11d2e8e1386634.camel@nvidia.com>
References: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
 <20230523041714-mutt-send-email-mst@kernel.org>
 <32fcc93a6c41abb17cabcf44add12fcabad34366.camel@nvidia.com>
 <20230523074357-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230523074357-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|PH7PR12MB7140:EE_
x-ms-office365-filtering-correlation-id: 5d413055-38cd-43c0-e1d7-08db60f753b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +LJAwTeWZr1dZFQpSDGaOewYyG9ZtR7AiOUpHRbceFy8pVGd2fx6+3/gIcGO5mkiTtYSwQaR/TTa8N3sOPs24fyP/t0Msg04SDclVqILXtHuHeHFsxrX/eIsEAyauv6qT1STk2C7/GLTFuCR0WchU0u4Td/LGW9hqWgbtlXESHX5JnFOXbaJsl9K2+37focNqXgrP91dEM6D9eMLQEcjUnx7KOytmpA3XtIF6o/ZWqydY9zn8YVV9sHetn9lCfpSLeCyFfPpCYdCRyBfctQN/g004QT0izcyL7T5+QSsskv1otJ34z3rYRr2hxHQVhKHBpX+le1GgEoqqPm4hhPkXyCzFSVKxMYIrOvVy/kASfod71d//qneXUazIKw7j8x7/5719tZdXq+m4OsolzlNJxz9RJTcKBXS5cTMyfewE5VwRnRNpxgeQ8OQLIHJOd1K/jA9YkNgzomFm2exq6B7I04CMd+0TfHnEBuJurG65qx07NiVmx9UielH1f7yPU5cZFX8sWibCxjH65WYTj2hj3sCGbmdhecPfiBpEyTs1o14xTY5cBV82xmwF3o06I6t9q+Kd9KBFVv6lCOjMJd/CTcTb5wkmBBRyDJT3AEitoA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(478600001)(38100700002)(122000001)(66556008)(966005)(71200400001)(91956017)(76116006)(64756008)(66446008)(66476007)(66946007)(6486002)(41300700001)(8676002)(5660300002)(7116003)(86362001)(8936002)(2906002)(186003)(6506007)(6512007)(38070700005)(6916009)(4326008)(316002)(2616005)(36756003)(3480700007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1lQYkt1Tmk4YS90SnZuZXRPUFloc05iT1k0a0xtZytMK1pGSmFYcnJuWVFT?=
 =?utf-8?B?V1ZaMUZqVkd1cVd4MjdUN2Y2cThQWFdxNndQbDE0amtrNWxxMEU2WktqVVFs?=
 =?utf-8?B?N1F0S1lTSG10c3gzOVJQeGRtVm9TZ3ZTQU9nbFBzWjAxZkxCcWpaQVdyR21m?=
 =?utf-8?B?cyszS1pydnBZNEVFUnZQeWtBRWpqSi94bFVROWFZQWJsMmt6ZXg2eDRmenFn?=
 =?utf-8?B?bitCeHpQK0dqclorNE9LU1F3SDRMOExFbnREYnJpTDdRK2RmWHFtcFFiUlBh?=
 =?utf-8?B?L0d6cjlwWTdxWEM1ZlRCZVpRcUhaMGtRSzJJemJRb2Y0Z0g3WDk4R2lkUXEr?=
 =?utf-8?B?RGlJQzJVa21tN0FpdloxV2JwdnM2OGJuTVI5WlUzdjFFWDNaQVhVamQ4dG1Q?=
 =?utf-8?B?YlN1Q2dOQVlzbHZUU2FNdjFRK2UvNEZnN0RyenNpM0ZIUTQ5elVzWHlFcys1?=
 =?utf-8?B?NnRidk5XYkZWQ1owQkFLbWhsZzFrSjJWUURSb0FrclBWV3pSWTJPL0FCZnJI?=
 =?utf-8?B?TDhibFdwM2sxbmJaNkg2Um5CL3NzRjVJUXMvVTdQaVptMTVHTU1DTE1Yd1dT?=
 =?utf-8?B?UlZ6MzMxRnkvWEhXNVplQmJYeE9VanlZeUliS0xFSlJFNWowL3ZPVkkxZ3ZC?=
 =?utf-8?B?RXRVcGUwWmplcC94bkxYTzFnQ1liQkxQTGYyMUFhbW1lOXlNWFpzcXpiSzFn?=
 =?utf-8?B?Z3BVSGQyWnJYM0E5dkcyL0Nub3BsU3RrYzBhMVUvOU5BMThXem1EdWJHQTJ4?=
 =?utf-8?B?R0lCaFJ1U1ZiYlgzRmtFTVZGQ2RoMFEweVZveGV2V2JndGgvTFZzakd0amh0?=
 =?utf-8?B?Rkxlelc3b3lvQXp4MU5nYVp5RzVnQ2VUYjBQWlBWeEJ6cGo0Y3NJWVdPYnJv?=
 =?utf-8?B?Z3UwTjF1UFVyaVczZzNDUWhzQUVVQU0yZ1RlZjdSaFJNTmFxWk5WYW0wclB0?=
 =?utf-8?B?UDMxeXptQXhKakJiZXhZK2IzWEI4K1hVOFFLL2s2ZHhPZ3Z1aHZncnY1Ri9I?=
 =?utf-8?B?L3R2UGdpZ29EazR6M0J1UDFoVEd0OGMrWmd0My9FcUpMR2VGL1FGaCtkcHdM?=
 =?utf-8?B?dWliZjlCdEZENko0RysxekRUOXpLOENqV0RNWGhHM0dqV2JSTWFTeUIyVXAv?=
 =?utf-8?B?SjExNEd3M2VGVkdnR3hkcWRhWFROeDRGaDN1RTlqblhDYVltaVhwak1VRGlW?=
 =?utf-8?B?ZFovQnh6MVhHa0kyZ0ZrVTROb0V2SkZZNVIvOEpQT1BJVXBuZlJXRXlFbm9u?=
 =?utf-8?B?b3FpTGUzT1o0WXJWRE9COFBocVprQzE0NzdsWEh2aWFhQm95V3hUTEFtcE01?=
 =?utf-8?B?eEdEdVBlbjdoUGVkcVRVWlMrcTFnUkJETllHVHc0clBlMlU2WGI2bkRqOTJE?=
 =?utf-8?B?SFozZWZnN0F0a0JVS2trNFlIdjZaYlVEekI5SklIaDN2dDdaSU9IbjRyWHJn?=
 =?utf-8?B?QSs4MFQwU2FRVmRORHJ6VkVBYklqeisram5wblhnbm9wSEdFV0dBWVJXTnE4?=
 =?utf-8?B?b1U3ZStZMUdKd2xmNkhKR0xJdU94TjlpRmpidnovdURXNG9Hb2lTYXRyVWlI?=
 =?utf-8?B?OXQva0l2S3VYbzZEK2RwRjk4RHFDZWVhNmxJV1VOVzRDZi9KRFpGeS80N1ND?=
 =?utf-8?B?WE9Ka3JRVmNoVDZuN1Q2NENTU0RIOUxqbi9yRWJ5Vmc3Q0lINzMyQjVIY0l0?=
 =?utf-8?B?Um9ZU3VBRzVQeU40UCtydklUWDJzR0xINVFVU3hWYkYvSGkvVmtza3JmbklM?=
 =?utf-8?B?QXI0MDNiNmZPWDRLTG9YelpXTDhWTzJ5bCtyaEdKYmc2WU91UHRHeEx1dFhp?=
 =?utf-8?B?Q20wanlYOHBURnphZFRNa1R6emhBY04yY21LNk43ZnNldWRmcHhlRDZHSHFz?=
 =?utf-8?B?Vm9LQWVFMTFsZUczQ1k2ZXRNYzdnWjkxaTRrWmRBRzJISStpNnZjanozVG5v?=
 =?utf-8?B?bkNQdmpTSy9iWjdlTzh0UGFScDA4WWVyK2xmMDZKS3AxdktibFI5SURKTHhr?=
 =?utf-8?B?MDk5OStydDNZZkQya0ZncUhqTzBPaFlrTDAyQVI2Rlh1aWlBRS84MWJhanpr?=
 =?utf-8?B?aC9kM0xoRCsyVTR4aEtNSHRWRis2ak9VdExoMml5MjNKOGhBdDNPZTNUMDdD?=
 =?utf-8?B?N0h5K0ZwM25tYzRMMjhaTmdoaE5uazE1MC9adGxKaStRYTcxT1lpK1RWaFg3?=
 =?utf-8?Q?ep3krQXnIL85Z56WC6jMJNnx8fVOtq1z8Pf0s0JlfEu+?=
Content-ID: <424A0FD260410A459E4CC958EB98E8E0@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d413055-38cd-43c0-e1d7-08db60f753b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 10:19:18.0443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +IAInE7lkCT4WliX/idVqBpsJwY/F9coBl9AV47m0anYO4Btr0AAqVo/2TdyQuchWnHIsL1Oy/I1EsPSTumM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 2023-05-23 at 07:45 -0400, Michael S. Tsirkin wrote:
> On Tue, May 23, 2023 at 08:38:47AM +0000, Dragos Tatulea wrote:
> > On Tue, 2023-05-23 at 04:18 -0400, Michael S. Tsirkin wrote:
> > > On Tue, May 23, 2023 at 07:16:58AM +0000, Dragos Tatulea wrote:
> > > > Hi,
> > > > 
> > > > I am looking for the stable branch for vdpa fixes in the vhost tree [1].
> > > > There
> > > > are 3 branches that seem identical: linux-next, test and vhost. linux-
> > > > next
> > > > seems
> > > > to be -next branch. Which one would be the stable branch?
> > > > 
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> > > > 
> > > > Thanks,
> > > > Dragos
> > > 
> > > I don't publish one until I am ready to send patches to Linus.
> > > Which should be today or tomorrow.
> > > 
> > Understood. Is it the same with patches for -next? Are they published only
> > once
> > the patches are sent to Linus?
> > 
> > Thanks,
> > Dragos
> > 
> 
> A bit different. I start worrying about next when I'm done with stable.
> Also my next branch rebases frequently, I also drop and squash patches,
> rewrite commit log etc.
> 
Is the linux-next branch in the referenced tree [1] the next branch or is it
hosted somewhere else? I am asking because I haven't seen any rebases in the
last 4+ weeks in the referenced location. I want to make sure that I'm looking
in the right location.

Thanks,
Dragos

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
