Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7721C12002
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 05:26:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE0A61175
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 05:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE0A61175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07DD96062B;
	Mon, 19 Jul 2021 05:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 94QU98umfoHz; Mon, 19 Jul 2021 05:26:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8351260643;
	Mon, 19 Jul 2021 05:26:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D118C0010;
	Mon, 19 Jul 2021 05:26:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D37BC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BCD583673
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xdpg0hWdMU_6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:26:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D40178366E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX03hk0oYLfcdh9e7PkSpmqLR37Lrq5QYrfEYgrxEFUfCQcZCm8yoI62+ruBRVEeaKQs67vdqAuLTxfIHxENYXVZsxFUyWUvBWPzWp9MPxLt8c9HzOSPo/hD6HftyKx30lwyK6CZ1uoRLpjH6zO7L32dumdY8uSc4a1lYsFmZxmI5+SwHa67+erE2oe1L+ESIypgXsQSJ2FsF8JNm5hkfuNkYPVDkzy1vgrIJN8jqzGVcl1p+WTBPNfZDi47khbZdlr/KYSm9fwkaYgT2jtW/wpVxffLv8/dJaaUcoxWCR/8uDpoy/1cesry0qYefmjj0+t5FDosv2GinqWQAWN3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUEvYYkCp/f5GuA8XAu70PLCv93+qDH2fxizbzI/5Xs=;
 b=LC8qObDRcTudjBPyf0Wkdx41B8YJlNc8YXb4/g1nvsw9odafoQUCWotSJkbnIK2B0L47XTPUq/VWKP79lPgSsBKLiFqSh167orhlx9LK3RP3WZYYEQ1M5fhDUAH3M/q7hw1gk1Cluzauqo8li4pXER0qlbOKZCg1hSnFx34f+0WnEdBqthSLkQwvb2MsCQFTtTkV80qK6m5vjJRL30H9YeLDagwcoQ63UTWn4rawjPesT/Y9lnVUqkzoRJzng3uDTsH61LIGXW5P7QG3YKEIEbSE9eXOGCK4xZxcGNe2aoH9KlnphOofXbAFQxI1l4XeqpJHkip3afksVJKxp8HBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUEvYYkCp/f5GuA8XAu70PLCv93+qDH2fxizbzI/5Xs=;
 b=TILjh3PZndcwCsh335QdeTe7xIdGE6Kmh3/QatN1H6+y287dKmPUtqp85q8OgfDEWu38sDt6NSMoC0nYHw/4fDAD7MvHu0U+k6GWEnamOdpvbzFh6msPTOaES4C4R3Gz9iikgrIEZLZSYK/WRweTQ+ExLF2N7bGqSFsRyknbMkauz0b7dfLMqK2CPLLgS348t/QVIZfLpxnqfvqitO0BKgjZVhskElR56cDFRvsYORlO1CUyoC+hK7epZRjUlV/Y2XtluWqkR5WMGBaAZTFNrbD8wgzQLEdwHPzTlggD1VKZLNc1okQ5Lvf8cpluZ0r2pMPrgEHY8U1dA5PH/fz98w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 05:26:22 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::ace1:9322:ab32:7293%3]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 05:26:22 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH 1/4] virtio: Improve vq->broken access to avoid any
 compiler optimization
Thread-Topic: [PATCH 1/4] virtio: Improve vq->broken access to avoid any
 compiler optimization
Thread-Index: AQHXet9oIEipiPbuTECOdqhlwyb4batHobWAgAIi27A=
Date: Mon, 19 Jul 2021 05:26:22 +0000
Message-ID: <PH0PR12MB5481EBA531451478010F926DDCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-2-parav@nvidia.com>
 <20210717163319-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210717163319-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a46e1f6-ab96-45e5-5fc6-08d94a75bef8
x-ms-traffictypediagnostic: PH0PR12MB5481:
x-microsoft-antispam-prvs: <PH0PR12MB54816A2351B2C13B7298562DDCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jX9db6C7bXhr1xV9gsbkPKjfmbGgzq3UFdB7J0oEpZnhMs90Osc4VicjO/C2Ky50VXghXON9Nb0hbelqwRI5/C3e6bYwXbJo6vXXX52bkzMc+gH5hnW8XzGreWuX8MGFfLErX7upc644gWirHx3QbJxcVBj5PTqHpp7/LYxj/o4a2F8dnJUmbZbH0RDGle83hmRkgEHLR5pUMvvHkR9gkRacoJZHL0RCH6lRauyJ8h44OLA+WnbanQQsh8i1T0QUzrNta7ahivLkfbT3dpJVuCTAQB41tLzLByq8AMb+HKM4cuLDAJi3k6sOSRsO0rmJWdh9CY7lmFH0JN91g19uan4/ewAN+jUJuTzHV4PWpHMVNH0zMqPN0haKwNhKiqomaK5S0c82Nl2Vsfp7Y+McWTTo1WcfvrMJ8BXvGjNzXhM69QQpEqFh9D8yeJeQjtbHAL/7Ss6g7MnaFjRM4DM/G+klaE014dHv+yqRc5tAQRHX91RQZVfVGfRUKVnPkAaWQ+HKAAisYMpW2EJE+NtecRJvvCHU/QTsHq1BrjtTY6lrcvsukasASYbJ5/CGF++qIIKCFiNIdsFTLuDJHWpFVs3Ntgo1dbUOF7KRS//4Ymqwo0ROl9uUVLttdYuOOK+08yrFIYQs/9Abrez0ckrmhpWWu9XSpQwXQRpx8OkOqlK1nbIsQ3BmbuXZbFsVDYXP2jJk8ehRunBRSBQiEdPmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(86362001)(186003)(7696005)(6506007)(9686003)(8936002)(71200400001)(83380400001)(4326008)(6916009)(26005)(2906002)(55236004)(55016002)(5660300002)(66556008)(64756008)(66476007)(316002)(8676002)(122000001)(66446008)(76116006)(66946007)(38100700002)(52536014)(33656002)(478600001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUjGB4ji2w8wYL0UrMjg4Nu9RashHFrq6RykyP2XF4fE50hhXRdE74WcbQZ3?=
 =?us-ascii?Q?73eTSHmkkU9mbMLvw2ZA1PAOF3K/27PLZzwWVTwGPwDNGzFelJ6VVb67sIUn?=
 =?us-ascii?Q?+koyZxCxm0GSGypNcaKYZnxjLsMo7yE7Xs6cqDkEPYC6QKIU6i1K0K0MOseq?=
 =?us-ascii?Q?Pa5Q2ahkCXll3U6WCxkfbgOK3j8mt3SoyBf/yN8JwlwC0q/b5ww1e4j+OEyR?=
 =?us-ascii?Q?CHHH2WM6Wr+pVc10bMMs1Az88AeSJk9Q8DyQZEbxwPF3hUu9ETOBHQCc77f0?=
 =?us-ascii?Q?zqgyDVMT8uSgI7QEWui9Vgcdt+U3N5tw56EDBHDW/97ALz0ePQKTVNvQyElV?=
 =?us-ascii?Q?DupH0RjnIT/uVgNSOcI7VrqOh5OIWj2CrxZUiUxGa6heaunzyVuswZ1OApSQ?=
 =?us-ascii?Q?Vya96BLALgQNGF+HfIjbnCZv58cUnL8Lpoj/exMpwz8NM6Szf4EeauQCQ8p0?=
 =?us-ascii?Q?MNN6od9b/g+r+/mHC4SjdQRUPrYRU6W8wFLALf9Vow4pwKaTAdCF7rw+ohZY?=
 =?us-ascii?Q?5i3WoA2o6DJhxzhVGJEYyJUSqzJ8xL5CqRv7H6QpL9g6N8vg/iBsjqpMOEtZ?=
 =?us-ascii?Q?qmeVMcU/TLuFYXmKzCcGo1KVrPcNUv5Vhqj22N5pNfhG+9cP1C2gb6Peghdo?=
 =?us-ascii?Q?oSMkJfRpJoCDsH9uyXkjTVZaD5RqphokVIz2RImRPORgYJxm+qlcdL4wmk0A?=
 =?us-ascii?Q?ilVMLBpVJWz/qUXpHFA58T9Wd5VDDKQUmnFtkwhhGx13BbVIZwRIJjRCSHBS?=
 =?us-ascii?Q?909i5yerKhq2I7rpzHqHlcyCwd7fg5ppwPWdo2aScYJWK47n/dLTGUy/jfUh?=
 =?us-ascii?Q?2lfHR+SX99HbKi69fDqftKAokFE5tKgJiPx08C7aR+KB0p+u4lYsiRNR/1cB?=
 =?us-ascii?Q?YlKJoMHvfBlDSzS1mqOZGzrqWzQ7P8TpQN9VrmqOvlDRjyHgisaz4jgTD3XM?=
 =?us-ascii?Q?fCA8YJu4190YAy3uhpjn7BXOTTituegxyJLwrQvvJQzRGRtVvueLuZuKZrpQ?=
 =?us-ascii?Q?skRS8fUtc70BeNLskK9w7QAgP9MzzAoo/x7ch/mF+7tllSkM7gLivc2kl/Jc?=
 =?us-ascii?Q?rfRbBW65o/dUVTGlL0ndkZSBOwbzNf5w5Tx9NpiBjgXCdiz4LUEjYNf6X4Pz?=
 =?us-ascii?Q?en1PuY82SFrX8xWwxHTMBxv98PHf5XbX4SN1uWO3oJLdm2OEAjMBR+StT19t?=
 =?us-ascii?Q?lBdOMwCWrdWN1q61iLXsdiMoufp2wktq1HpMCMPlbbZ1O8sk3xgYLuoxMFHx?=
 =?us-ascii?Q?gRAhmwcD0jxe2xonsXWr8nDHFfECEo2BS/F/CpQE9FRMmzXb3r1XfqsT2Sxx?=
 =?us-ascii?Q?+/TNEDiXggnFwp771MbDmjwe?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a46e1f6-ab96-45e5-5fc6-08d94a75bef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 05:26:22.4337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNa53Bmn6IJ8h2XENeqIJEqKLxXa8GSJ4gopmwRwJoBazE+IhASFkY5ScaQ74seSBVVGinCE7Q5GwC0P9sa3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5481
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, July 18, 2021 2:09 AM
> 
> On Sat, Jul 17, 2021 at 10:42:55AM +0300, Parav Pandit wrote:
> > Currently vq->broken field is read by virtqueue_is_broken() in busy
> > loop in one context by virtnet_send_command().
> >
> > vq->broken is set to true in other process context by
> > virtio_break_device(). Reader and writer are accessing it without any
> > synchronization. This may lead to a compiler optimization which may
> > result to optimize reading vq->broken only once.
> >
> > Hence, force reading vq->broken on each invocation of
> > virtqueue_is_broken() and ensure that its update is visible.
> >
> > Fixes: e2dcdfe95c0b ("virtio: virtio_break_device() to mark all
> > virtqueues broken.")
> 
> This is all theoretical right?
> virtqueue_get_buf is not inlined so compiler generally assumes any vq field
> can change.
Broken bit checking cannot rely on some other kernel API for correctness.
So it possibly not hitting this case now, but we shouldn't depend other APIs usage to ensure correctness.

> 
> I'm inclined to not include a Fixes
> tag then. And please do change subject to say "theoretical"
> to make that clear to people.
> 
I do not have any strong opinion on fixes tag. But virtio_broken_queue() API should be self-contained; for that I am not sure if this just theoretical.
Do you mean theoretical, because we haven't hit this bug?

> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c
> > b/drivers/virtio/virtio_ring.c index 89bfe46a8a7f..7f379fe7d78d 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2373,7 +2373,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
> > {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > -	return vq->broken;
> > +	return READ_ONCE(vq->broken);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> >
> > @@ -2387,7 +2387,9 @@ void virtio_break_device(struct virtio_device
> > *dev)
> >
> >  	list_for_each_entry(_vq, &dev->vqs, list) {
> >  		struct vring_virtqueue *vq = to_vvq(_vq);
> > -		vq->broken = true;
> > +
> > +		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > +		smp_store_release(&vq->broken, true);
> 
> A bit puzzled here. Why do we need release semantics here?
> IUC store_release does not generally pair with READ_ONCE - does it?
> 
It does; paired at few places, such as,

(a) in uverbs_main.c, default_async_file
(b) in netlink.c, cb_table
(c) fs/dcache.c i_dir_seq,

However, in this scenario, WRITE_ONCE() is enough. So I will simplify and use that in v1.


> The commit log does not describe this either.
In commit log I mentioned that "ensure that update is visible".
I think a better commit log is, to say: "ensure that broken bit is written".
I will send v2 with 
(a) updated comment
(b) replacing smp.. with WRITE_ONCE()
(c) dropping the fixes tag.

> 
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_break_device);
> > --
> > 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
