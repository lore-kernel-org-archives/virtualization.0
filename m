Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88766C7EE29
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 16:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 002C24070F;
	Fri,  2 Jun 2023 16:05:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 002C24070F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Yd8vvz+/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyZ1Ix6l7mzC; Fri,  2 Jun 2023 16:05:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65E19400FE;
	Fri,  2 Jun 2023 16:05:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65E19400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39899C0037;
	Fri,  2 Jun 2023 16:05:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EFF4C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 16:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 137654273B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 16:05:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 137654273B
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=Yd8vvz+/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V39_V_n5HZhp
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 16:05:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81A8C42708
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81A8C42708
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 16:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHeckv9OMrc0197pSfsvCVBoFGb2PO31B3ufW81KfZ5MdyYtjjFCs8MwbDnbA5yl2ZmLCYNzG340R+i/PkwaJGZ6J6x/Mg6vjBO++Jq3HEQYkZs6oSON0Ym3Rka0WgJbydHHcS5jxoNYkDCPwW2PpkjfnwOnkv+hMVlM6rbpVHqU6Qbml9KbY3kaJC7vpJjkxgP2YaXDSOExOTTvGmfxx9tGDQzQHsdt63S7tDKYhPy4T7HwnuSS6cZpZqjxZOEWkRuRv+BIu6RE1rum1AtNZMbWR2bykwpHywn6XBheIkKdetBOYjbzgluI0aYVLeAQ7nAXpSZ0f4S71jdfc2n0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HMRuzHbzUjmRh8kasWVSP+VpxLWerSXCynswSOHol0=;
 b=es9qBEP0cnyhDbf5KgQcPvQI8lB4uQ7/VzDN8n4dxoANV5dXphF2sCj6dqPnjgzzdaVuYvp4Oy40CNN+WZFmoKiViwFNb0/Uvq9/nqfylyrm+oLXjs8E2n06ec6xpB/+1kTSEu2yzyeXIqUFo86YqXrpzStJzEgV3tdkbkJh10Sz+ONyCj44A15E4XUw/9bP8XLjcLY8gFgHnMfkGS+XxAGgHlrSQRmi+pQSnoay4gvYn2TqknABnieob+CnuE37c8muUxHY8la5YOwVLGcczJtVuWt/bukmFfte330SiG2CfFYMBtl9kXSQmBVKg7QNaS1+Z/K0Q3ObEAAJJ4Wv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HMRuzHbzUjmRh8kasWVSP+VpxLWerSXCynswSOHol0=;
 b=Yd8vvz+/IV8KLGTMQDJaosnTI9JTN0erti9NVeENYU+LVWrasJNEfZ7p0dyRwe8JU13jOK/PFkigXIwzPTNo5CyjdYK4RVSAx64QHk2Wrj5iGSPFQSFNNiffYRVRE0nFIZj3aqLv/+erfqVvjNLFndsxxClTl7IQFhTD/U4ubK30xWGaFjOlsME03MIS2NnmInBjbsxwMsRgG+22OmGQhO5BkNSFSuRqMo5cyVGui/aq59YeOx0mT9NLnH8ydtQ2QRaRj7gBygfcgvyamMqulkoCwAFRRUGe094TSbWRckvFaEHIiVXjsL6xRiTtrf4vcsc0yVN8eOdSAHiclu/8cA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 16:05:31 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9b62:9b1b:3d21:16b6]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9b62:9b1b:3d21:16b6%4]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 16:05:31 +0000
To: "mst@redhat.com" <mst@redhat.com>
Subject: Re: vhost stable branch
Thread-Topic: vhost stable branch
Thread-Index: AQHZjUaQ6njl1MGLGE2KPtgjGhYoLK9ng98AgAAFjQCAADQugIAK6DqAgATZUoCAAD5nAA==
Date: Fri, 2 Jun 2023 16:05:31 +0000
Message-ID: <72bdd322f342f70dd037ba32a2b0e14234e5057c.camel@nvidia.com>
References: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
 <20230523041714-mutt-send-email-mst@kernel.org>
 <32fcc93a6c41abb17cabcf44add12fcabad34366.camel@nvidia.com>
 <20230523074357-mutt-send-email-mst@kernel.org>
 <b8172a255a7a48524c3454676e11d2e8e1386634.camel@nvidia.com>
 <20230602082154-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230602082154-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|PH7PR12MB7426:EE_
x-ms-office365-filtering-correlation-id: a75923b5-813b-41e2-25d9-08db638330d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYzIUYoZY+dEqBTEnsR5GjcGHXL9ScJ+sVxBZwp+YNsljQebyMoQpZ8NMVH2E6IYo3OMFC2FHdDHwHGHJgMsB4EbRGa4EOmrRvbmEcrkuohUulU8XZ4gMYfJz14xmu/NsbScrUO3enaKvlCar6TKROtR1Q0UeqnlmjY+/7jfWNPcLZDSoCLJH90zoV/+40AlZp/eGJazmfYqBtBMKVqro7evy6TAeqI/bMhg2RKE+mCQYSKCkYYdm4gRwOzfo3L8HmSSCDn9sxy7ekI/p5pbOe627t2uGrSpYeAWgL0Y+0XSWrdlV4Lo1M8wRfm0DXbxWy2YGEStrdZmbcpfG8BEsgeXKGD3qPsSqz942E2LJUioGRarGom6GNtLdRTqBVfo2OLNVdB3kFq5FpU+H06DCd71vZYGSmw/9Hvde2Yd0EOmEPUHhLQD3kaUw8PJANfq9Ic74MDblfgRyTU1zxMqn5LSpPel0Qnjf2VrYnc3TF8ssMuD67YRwS0XBipDKhXRJ7sKpKOG0ScwAw9owVmBh+8NP1alxQ2qafJpfNNpdC/BOE9u6zWMSjVnfT0Rw2as17bQbSK2el7D2Ksx3lhBKpE1kEcta9FlzgbkKY6Ab64=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(64756008)(8676002)(2616005)(186003)(3480700007)(6916009)(2906002)(4326008)(66556008)(66476007)(316002)(71200400001)(91956017)(66446008)(478600001)(66946007)(76116006)(5660300002)(7116003)(6506007)(41300700001)(8936002)(6512007)(966005)(6486002)(122000001)(38100700002)(36756003)(38070700005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWJuZUpjQVhBM3dmUHRoekFZTGp1a1dzWk00cGFUSzFXOXpoc3hmMFFWSEdV?=
 =?utf-8?B?ZzR4dGRBbTRVVXoycTdCb2dkeUk5aVZpdXlRazhGZXBoWmQyNGozRkJxMTVh?=
 =?utf-8?B?R0tXK25XY3dyMXVOemF0bi9tdWwxanBBZjhEQmhwMnJnWnJtZGtpVDg3UC9L?=
 =?utf-8?B?S2ZBa3NBeWdYNU52ZGl5YUhiYVZlNkgrK01EWllHL3JkTUVHaE1TQ3V3Slgr?=
 =?utf-8?B?NEtWWG9kek1ZU2MzT05vREZuZ0YxSG5ZZUpSaVpkMTlWdXRPSURvbU92amYy?=
 =?utf-8?B?TW8zN1pXdWM2Q084ZGJ6Z0lWMkRYNTJxem9ZejQrTFk3U3M3aENKZHNLQVVr?=
 =?utf-8?B?dE1VUmtnQmh2MEd4U2dMSWZSSDVsWFBIZU5UaEJBNkhIcWNuZml6MFBtRURI?=
 =?utf-8?B?M1NvbngxWm9qSS95eWxYajdxQUg5S0lURkhlcGhmRWx0T21DbGJKL1JCdVpJ?=
 =?utf-8?B?Z3doQ0RsT2xCOEZ5WHYyNzExNUtkWDZVZWRFK3VFa2NzdzZtWTl6cjlKamZr?=
 =?utf-8?B?c0pJalhaZUpocUovL1cwNkVkaFVWRk93M3VGNEtWNVd3a0JRSWpZZTV4VFY0?=
 =?utf-8?B?am1NZEN3UEQxZDg3NThKTkxNZHllZS9yUXA3WXh5c2JvQmZYK1RQbzcxRzEz?=
 =?utf-8?B?MHZOcmcyV0sxdzRlUERhaEJIMWpjVTVrVUVsVHZwK2V2bzU4TnRsbVZQVy9R?=
 =?utf-8?B?R1VxaXVPdUczeDdROVhVbFlyTTZjNHdrMGpjRGdINWthM0VsV3cwdFFPYWVo?=
 =?utf-8?B?ZU5zSVpEVXNpWXl4aEh5VGo4bVFheC9yRTZBVTFoMGdZV3pobUFIdCtWTks3?=
 =?utf-8?B?TGJTbnpxaDg0bXJtcmtrUEd2Q3N1b1pZTjdjZmNsTkFFODhnZDNKQ3VHQXV4?=
 =?utf-8?B?U0ZBaExObFIrR0wxMFY4Y21FbU5mbHE5OGR1d1dOUVBWY2hiUlhTNWNUMHUv?=
 =?utf-8?B?R09qVElBUDZWSkdibjhlYzR4U25EWHkybUxKWEdUVXJYV2ZDOGtodzdCOGsx?=
 =?utf-8?B?UDRyY20xMStaaGgzMXdsY0NVcTdiZk9vSkJBLzhyUzRoTEdnRHF4VGh0YnBn?=
 =?utf-8?B?MVhSdzZXL3BDZzMveU1peGloSGhUZzhhcjRVNEpNYURFSXBZd2l4ZFFGTFlF?=
 =?utf-8?B?czdmNGJHaHg1WUsrMlR1RnJ3SDI4QTNTVlpuUG9pL2JMT25FR2phNmY4UUJ2?=
 =?utf-8?B?QXl4djlxdEs3ZEtyK0JJdStxaTZGMm50eGorbkJmeXIzZkVBTHZPMXNDeVNq?=
 =?utf-8?B?VGRGb1M2SDlnVEVDQ1NGZ2xackNFYkNja0FsZ2ZzenQwTVZQVTN6NlI0dkFj?=
 =?utf-8?B?ZFROd1h6c0tkZ1RTTXVhdGZkK05VK3hZN1VqUCswRlZJTkd0UkQzSHpDZHFK?=
 =?utf-8?B?d281d0dDSGFRN2h2Sk44aktkaFV5Um9DbzB3Tnlpby9HUGljS1dOcmZrbS9q?=
 =?utf-8?B?ZTRnVkpLVlJaTFBqOVVMS0JqYkdRTE1oQ0x5djVkR0tDbTdSQkc0UVZRQi90?=
 =?utf-8?B?T0hxdENtYnpVQ2lYUnpxbnNqQTZ4eE5SMnNPRlNYMXVnZVlBZWJ5VmlHUjdk?=
 =?utf-8?B?b2MzQk14enVFcjJiMWNqeUtQeWdRZlVtN3d0ZjljcXFaUnNJaDVQN2Uyd1NB?=
 =?utf-8?B?RlNGRk42SjhWZDNCOElSTCtycE9HT0JzRk1GOW5LajRoNkhyL2xJcVRGbGt4?=
 =?utf-8?B?S0RLaGVqcE9oWk9DNTM3UGdwV2trNzVRMDRBcGdsMFpNSE9zbVErWExrQTJa?=
 =?utf-8?B?T0lHb3ZnTVJ3M045cURwSVliM3hrWVplL1MxOUIzMldDL2tBMlBGT2E3WlR1?=
 =?utf-8?B?MGNxWmJ0blpEVFNzbFRRbThkQXI5UkZKUG9mQXVqTWtLUXJuQXRuc254ZnVi?=
 =?utf-8?B?Nnk1VzlHcEdySS91UGNvWHlndk5LYnhTZWRYdjVCRUdnWkh1eWpLTXpaaWNY?=
 =?utf-8?B?a1MyTU44UmEvTC9YUlRGSVdodWtSTi9IVitrNnhlRjVmaUhaL2VLaTIyVjQ0?=
 =?utf-8?B?bmowLzEyMFdtTmwzeHJESEhKZGExVWw1czJWRDF1MFQwSkV1RHVkeDVsZmRm?=
 =?utf-8?B?dFRuN0I1YUdHK3ZtVHZvRFhuc1BCbitYdHJkcEF5dU51aTd5ZXZKL3VHOE1H?=
 =?utf-8?B?cEFENmdPUFFwTkdidVNZcXM1eEZyVWI3SlBkYjgzOGMzMzQ2WC9nVEVVZmwv?=
 =?utf-8?Q?+nsKo5MnM7v19kmIWPibI7Y9vLvEWfXdJ/uBRSs9XX8P?=
Content-ID: <ED8DD379E581F34F80682FAF9B9B4765@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75923b5-813b-41e2-25d9-08db638330d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 16:05:31.3851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/pCIvnU5TKa3bSKNR/FlF4rWE/bT+zjRfZ7fvm8mHnxTMsUJFbKJiazziYdjOFaLZumgYSBCJdFv1/o6nar9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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

On Fri, 2023-06-02 at 08:22 -0400, Michael S. Tsirkin wrote:
> On Tue, May 30, 2023 at 10:19:18AM +0000, Dragos Tatulea wrote:
> > On Tue, 2023-05-23 at 07:45 -0400, Michael S. Tsirkin wrote:
> > > On Tue, May 23, 2023 at 08:38:47AM +0000, Dragos Tatulea wrote:
> > > > On Tue, 2023-05-23 at 04:18 -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, May 23, 2023 at 07:16:58AM +0000, Dragos Tatulea wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > I am looking for the stable branch for vdpa fixes in the vhost tree
> > > > > > [1].
> > > > > > There
> > > > > > are 3 branches that seem identical: linux-next, test and vhost.
> > > > > > linux-
> > > > > > next
> > > > > > seems
> > > > > > to be -next branch. Which one would be the stable branch?
> > > > > > 
> > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> > > > > > 
> > > > > > Thanks,
> > > > > > Dragos
> > > > > 
> > > > > I don't publish one until I am ready to send patches to Linus.
> > > > > Which should be today or tomorrow.
> > > > > 
> > > > Understood. Is it the same with patches for -next? Are they published
> > > > only
> > > > once
> > > > the patches are sent to Linus?
> > > > 
> > > > Thanks,
> > > > Dragos
> > > > 
> > > 
> > > A bit different. I start worrying about next when I'm done with stable.
> > > Also my next branch rebases frequently, I also drop and squash patches,
> > > rewrite commit log etc.
> > > 
> > Is the linux-next branch in the referenced tree [1] the next branch or is it
> > hosted somewhere else? I am asking because I haven't seen any rebases in the
> > last 4+ weeks in the referenced location. I want to make sure that I'm
> > looking
> > in the right location.
> > 
> > Thanks,
> > Dragos
> > 
> 
> pushed to next now.
> 
Thanks for the note.

Thanks,
Dragos
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
