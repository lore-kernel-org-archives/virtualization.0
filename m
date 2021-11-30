Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAD9C433F5
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 04:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8568E81002;
	Tue, 30 Nov 2021 04:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lowaxh1qbAAq; Tue, 30 Nov 2021 04:09:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1112B80F85;
	Tue, 30 Nov 2021 04:09:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE660C001C;
	Tue, 30 Nov 2021 04:09:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 903D6C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 04:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7769F4015E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 04:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2EPh5lKgiDZg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 04:09:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C23C940155
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 04:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwTGV4S6gbdZEK0vpc/6qbOsyaLUQ7EnRZrn1JPgyKNdopbrenr2iP2rckT7HrW+yL2QfVvUisYZWcdMKS3CK8CNlpFAZIWUb020SBjsQixBzjhU5XDQ+/6RchcTmOE8PMhg4EvK1YOmoN/ti0Yhq1NOYJ34KlpgZm6LOpzK5TQMt2mgs93IZC/v7ipdwsx/TnslDVIsMAHgXyG5i8VYaw+Z3SOpKE+4vRylzIU+xDtPDpZnYp9OfSOvzHBECAIOYWWcykKzAb2IgCpk0q/6r0PaCKaiM7MjPbNwwLmpjnlsQ086REFXAMDhpy+OL3SKk3EXWkltCwUgy5b9iIJ1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrbwBwjqFuAt+lhhFwv87eOxeNaLYDMuvCm2+wShOp0=;
 b=Iafn5aapLah14xNPuVqcfeYZMEmfJg6kC8Cre/4zbGvY5OF62+5C16w/+FqqkqjsKnW3F57OVVnHrTWdES5nQnvFt4uJ/m2oR0yDFFt1fWXFeeimaeOQLrQHjMHiYnqW7GvKT4bxwzXauD5sSIA8cUZaleitsoKlG3PE0ROQEHsnqwKocHyMD5EQoBE6ckp0m3xprkOl2DyrXi2Jvr+otKYyJUoDuuFgxWygFURNaLUUxaS/VartcFp6/JvEDeD25G+uHKlYF2i0mjZ5OW0Zh23WoMBtmpr4UNVU2D2vIoDq3VW6FNNAnY1sfHGeIB65wqP6b1qJTB9RFtZFtoHNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrbwBwjqFuAt+lhhFwv87eOxeNaLYDMuvCm2+wShOp0=;
 b=PvCKgCUmhZcP1PhoMSE+NktLS9Csg1XqQmiAsgvYzKqu18W7SeqCD6mhilNsMh3QKKW5wwoDCF1sVLLXOI0USTctNfIgVxp0bA0QIhgznxRxJoMjhTKPP/Cn/pLlI+Pxju79+qjSAjgvH7HxYWYy2eT0yqDI4Ets7EYCvm7PJK9nLu+b4K3VX8o/boZw0QAjuzmKBM9iLzSMxmS1k8Fn6ldvkUPciwLjIXaI2xvsH6RsIjNbzGih7knxTQcBpRDoegMoFZJHCkQeDP5KcDvYqNJ6RV0dhAJalq+ELfPs9+uBbiNcrNVsr00CMJ+rw8LmbEYsCZpdzAShlzeAKHKtWA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Tue, 30 Nov
 2021 04:09:41 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%7]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 04:09:41 +0000
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: RE: [PATH v1 1/2] vdpa: Add support for querying vendor statistics
Thread-Topic: [PATH v1 1/2] vdpa: Add support for querying vendor statistics
Thread-Index: AQHX4VQrJsRhfsS90kGFJYDRg8aaW6wTrVaAgAfM6IA=
Date: Tue, 30 Nov 2021 04:09:41 +0000
Message-ID: <PH0PR12MB54811993007B4CFF01A991F0DC679@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211124165531.42624-1-elic@nvidia.com>
 <20211124165531.42624-2-elic@nvidia.com>
 <CACGkMEt3W9OOoC0iF2_HLHRFNq20QxSD=s1H3hJhMFQPGiZ-kw@mail.gmail.com>
In-Reply-To: <CACGkMEt3W9OOoC0iF2_HLHRFNq20QxSD=s1H3hJhMFQPGiZ-kw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebf66aa9-a541-4511-9bdc-08d9b3b73bfa
x-ms-traffictypediagnostic: PH0PR12MB5466:
x-microsoft-antispam-prvs: <PH0PR12MB54664BBD381A3D70B4258309DC679@PH0PR12MB5466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZQECKNr8/o8ZcBV81uuQM63Q6E5kJe8mF9GktMN4ss/hwf4DCdnpvNRA5Z97zePuw+ben69B+g+ntkgY67b+Hs7K/8NLG/hSlnDJjyxDEQBn13BTIOUvkxQRfRyROBFwyhGglBHdA0G1PDoEmSEjm33/HhPkNMjhdsTGmUSC+hmX/0xy2bjlxXuSlIILmxEzuN63U5CzYohZlwJpRpfl2zqPd1nQ0S9554AvhdlYe56zb06NmM29otErJM5mRifJUlbMZkEv1DJJJalP94Fp+jOsfT2hSO3pC2r3eZnP58obsBOrn4oWPiFgrHodr0DxFnv9CQlGECIWb95QDESp3CvoisI6DGmEN84QWQ5kZk+9G5Xd1OftKuAAW9WynkncamizlInDlOcjyUiEeo+XfDgPDQIempvqh6S5ShkcpV0/V76eNRpxeKaBl/rdgYuCGHP18JwDMjdFk8k1sXPoRaUo+0n0GtuzLz0KkAjRu7WI+O1L4Rq7bN7pTsjQPfhAJ84fyW+6O+7ovxTiBWTS4By+upDXU3BBY8GoeqPJGr8CT7rCyRn3k8JWTxE3WepzT+sOKRaT1vaTnd+1PEdp3GZQFUyvlC8B/ErrBh2sQ3a+AcUcL+2phTX/cIx4Jw6FDnjCmtrmadIdB9VyEtVvRfDZjUmoSRuWUUSaw/cddH+qsqq/yVVSiLDR6j+GCv4uzuFrc2Oy3PtA1wXAXWcFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(55016003)(66946007)(110136005)(122000001)(9686003)(7696005)(4326008)(38100700002)(83380400001)(316002)(33656002)(53546011)(6506007)(52536014)(8936002)(38070700005)(186003)(66446008)(64756008)(66556008)(66476007)(6636002)(508600001)(26005)(5660300002)(54906003)(2906002)(86362001)(8676002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzRHOTRtRlBuRnU3czVJeFdLMGtEb0s2NEU4Z2lWbzF1RDU0S2Qrem9zcFZ6?=
 =?utf-8?B?VWkyc1NjOGtBV0oyOU8rUVBJNkhuOC85dktVWEg1aGl5QjRPSEdKaGdPR01W?=
 =?utf-8?B?N3NzdS85NkZkRDc0Sm1NcDFiemd6cnBWU2xvZDNMWVUza2xrZzRWNEtGS3pa?=
 =?utf-8?B?TnNSVDFFQjdyS0FUNlRERkxKcHZFbytwa1J5S3lqdTY1ZWJBRlJFR0M1ZmpT?=
 =?utf-8?B?RUg3K1V1NVNvSUpjcGFEVHJoMWpFMHl0aGs2YzFvdGUwL0RLV3M1YWNqQUph?=
 =?utf-8?B?SnRTdk9PNzNLSm05bkc4Z0NWQnptMW5EWEhwRXVmdHQ3VjYrYXZmWTc4Y3N4?=
 =?utf-8?B?eU8rcklhSU8vRGhsTzMrSW5GemtaMXEvcUJKSUpQT0lINXoreVdGc1RUYnZt?=
 =?utf-8?B?UHJ2QS9oZVBxZS8zQW9sOU1JODVGQmNqVUVJWktDRHV2NjBmTFQyV1BlU3Z4?=
 =?utf-8?B?dldJOVd5UGgveTA2cklVR3h0NU1iOEZQK0d1a1dyZll4M05CeVlaRldJNjdv?=
 =?utf-8?B?U0ZGN28rZVFWMzREMmFsa2FpM0d6RXNsclVqcmJMeCtjWEMvODVhd1dOc1J4?=
 =?utf-8?B?ZDNkanZldFUxYUZUdkFPNEFscHB1K05jc1VEWmJMQ01xdjAvOHpWclA5b1Z4?=
 =?utf-8?B?eUJ6MnVoMHp0UDQzOXpDK2pBby9Kbm9IWVVHajlFQ2MzRzRsU09xVDhDNmwy?=
 =?utf-8?B?T2VXWWFoQ1hWNGpJaUdTL3NJSTcwRy9TZi92Sm9oRkk4NXF6MXV5Z1o2MkVB?=
 =?utf-8?B?TXNDczJkNThvanBWV01kcklLMmRjUkpQVjR0OXRmeklpNFZ2V2FQL0VJRWtn?=
 =?utf-8?B?eVhFb1pIL0oyaXZGMmVadzJjVXVzUGFIVUV2bGE5S0dqRlJ3elAyUkpBNmVX?=
 =?utf-8?B?aUVMWWdzR1hQanNjcWc5cGlTNTVjMWcxZWQ5eFA1TlpXUWpub3BwOENJVWVV?=
 =?utf-8?B?eEllcGZaVXdRMzl1ZHFHakJrNkRvV3BiUWpCU2hzYURqQzF0V2VpS3JWMzNp?=
 =?utf-8?B?KytSY1ZQdkNQaUtYejZBVEpnVlpxVDVab1JQOFZPaERkYUhTTzdnbWJnTDJl?=
 =?utf-8?B?VmZReDFydFdWZU5VQUVwYnlyNFRyMzlMNmpVa3NLY2ZmT2pwK2ZZaUxpakdB?=
 =?utf-8?B?MnYvTzI1MytFQ2xSMkhSSForS3BqWHBvRUlacEVPd2tnSkprdU5pVElURnJr?=
 =?utf-8?B?UE81c0Z3UW9LTXoxSDd5S3hZbGxGYzFUK00wNDZkQkU1dzRiSUwvNUlRZW9q?=
 =?utf-8?B?Mi94R0hDWUE1WFF2aWhnMEMrSUJFcDUwUG9jMzlmOE9zQmdVNWx1Ri90VExq?=
 =?utf-8?B?YUNuc3J6WXF3alc4RkViUG55cGRGR1k0NVpRSWl1UUpRRUI5MG9meWN4R0NY?=
 =?utf-8?B?V2tJczdmZlEydUw0MmhVZDhTKzlmQkpTMVJUMG1PbUFjUHYwSjBTazZoekdv?=
 =?utf-8?B?azZvMGJRaERtM1BoODA5VFFSMWJ1SnRSdnR6eHZZU3JINlRzaWpRckRzYWJi?=
 =?utf-8?B?Tlphb09xaGJwdVdJNFpVc3diZzgyb2FLVGlYSjgzWi9RakdhY1BNeSs2U0Vk?=
 =?utf-8?B?SThia2R4YVRlQXY4VGl6cXdBTmFxQmN6ZTdDcGFRckFNQnVNRFg4WVlTTjFx?=
 =?utf-8?B?U1UrLzBWNkFmbFN6ekhLV3VZbDBMWFQyeWgwMjFCVmZvR0xuRlIzaHk3VzBk?=
 =?utf-8?B?ZmxiOUZMMGsrNzdua1M1Wk1UT3dmd3FYWmRRN0RWcS9DYlBEMzBKKzZ4dnpV?=
 =?utf-8?B?cjZXQ3Rpb1RnZUo3U203UWpKM1dncVBPV2RxU09XN1FRelVJcG1KQk5TT3ZK?=
 =?utf-8?B?K2lCaFFWc0d2SEcyLzFZQkZhOFhNMWFXY1JDcGxOY25rOGk2Y1R0bTJMNnhG?=
 =?utf-8?B?YzVIWTlzSlgxcWl0TmcxaE5QazA4K2xmb3NHQStTSDladGNxbUNyUzlKSVZM?=
 =?utf-8?B?a3VGakRjZ21xc0Y4RGQ0SlRPY3crQnhIWE5ENUJsb1Z2U3RLaUlNRmRMT2Fx?=
 =?utf-8?B?WnpSN1gxK1lHYzcvMDcyQXFSdWt2YmIvMWpjUnloeHpqNHhlZ1dmblhFZExr?=
 =?utf-8?B?cGJ2Syt1TWdIR085d3dUN3M2b0llOEQ3bjJWMjdnNGczUUNwMzNXbVY1bnVk?=
 =?utf-8?B?dkVCRDJtWjBOVWVIek9wUkV0NVNSMmVGZjZxcHpERXptRFlJckNQUWFyOVM1?=
 =?utf-8?B?WVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf66aa9-a541-4511-9bdc-08d9b3b73bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 04:09:41.4600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pX4s9f9fKOiL0C5IWfjfZszt7A+NVEROUlJyS9Dr4K3KFf1FEa/VJ3TrpYog/v3xKbLox0zedS7ck9Cid2mjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
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


> From: Jason Wang <jasowang@redhat.com>
> Sent: Thursday, November 25, 2021 10:21 AM
> 
> On Thu, Nov 25, 2021 at 12:56 AM Eli Cohen <elic@nvidia.com> wrote:
> >
> > Add support for querying virtqueue statistics. Supported statistics are:
> >
> > received_desc - number of descriptors received for the virtqueue
> > completed_desc - number of descriptors completed for the virtqueue
> >
> > A descriptors using indirect buffers is still counted as 1. In
> > addition, N chained descriptors are counted correctly N times as one would
> expect.
> >
> > A new callback was added to vdpa_config_ops which provides the means
> > for the vdpa driver to return statistics results.
> >
> > The interface allows for reading all the supported virtqueues,
> > including the control virtqueue if it exists, by returning the next
> > queue index to query.
> >
> > Examples:
> > 1. Read statisitics for the virtqueue at index 1 $ vdpa dev vstats
> > show vdpa-a qidx 0
> > vdpa-a:
> > qidx 0 rx received_desc 256 completed_desc 9
> >
> > 2. Read statisitics for all the virtqueues $ vdpa dev vstats show
> > vdpa-a
> > vdpa-a:
> > qidx 0 rx received_desc 256 completed_desc 9 qidx 1 tx received_desc
> > 21 completed_desc 21 qidx 2 ctrl received_desc 0 completed_desc 0
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v0 -> v1:
> > Emphasize that we're dealing with vendor specific counters.
> > Terminate query loop on error
> >
> >  drivers/vdpa/vdpa.c       | 144 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/vdpa.h      |  10 +++
> >  include/uapi/linux/vdpa.h |   9 +++
> >  3 files changed, 163 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > 7332a74a4b00..da658c80ff2a 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -781,6 +781,90 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
> struct sk_buff *msg, u32 portid,
> >         return err;
> >  }
> >
> > +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct
> > +sk_buff *msg, u16 *index) {
> > +       struct vdpa_vq_stats stats;
> > +       u16 idx = *index;
> > +       int err;
> > +
> > +       err = vdev->config->get_vq_stats(vdev, index, &stats);
> > +       if (err)
> > +               return err;
> 
> I wonder what happens if some other vendor adds their specific stats.
> Can we then have very large stats but only few of them is necessary for a
> specific vendor? If this is ture, is this better to simply pass the msg to the
> parent instead of a structure like stats?
>
It is better to have vdpa defined vendor stats structure, so that this subsystem has well defined statistics.
If vdpa enables every vendor driver to put the messages of its choice stats will become a assorted items bag.
While it may seem great for one vendor to put whatever they want there, 
it is inconvenient  for end user to understand/parse those stats differently, if they are not defined by vdpa subsystem.
Additionally integrating it to monitoring tools such as prometheous becomes another pain point.

It also requires moving VDPA_ATTR_DEV_VENDOR_COMPLETED_DESC out of UAPI and defining vendor defined string which can easily go out of sync.
So I am inclined towards vendor specific stats to be well defined by vdpa subsystem like how its down in this patch.
This still allows different stats among multiple vendors or multiple generation of single vendor.
 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
