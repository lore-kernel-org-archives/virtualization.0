Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B97C433EF
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 08:48:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4765960F57
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 08:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4765960F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 127A7400F0;
	Sun, 24 Oct 2021 08:48:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RJM-BaD5wCLZ; Sun, 24 Oct 2021 08:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD4C240357;
	Sun, 24 Oct 2021 08:48:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8513DC0012;
	Sun, 24 Oct 2021 08:48:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D39D5C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C297180EB2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:48:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7fUYkBjxsyr
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:48:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68C5D80EB0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635065309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+4gAu5mtq8yjhmzCHpAItde3uglak0uKi9++yZF6x4=;
 b=NU1NhPVjznKa3hVuKbHqSxjVBaLgb/ixjh+DU5Qo2fY8HaZW+up8P2ToX7CZb+wo+f42NO
 Vw0RILSZhiLwkBanbcwrerjZd16tCsa/D3RUsHdrj4SQs8refVfAoDI7FAXywwKe4kG8vv
 7kL+nlY1xMxpNFk0comw84sm4WIEBfs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-2IR93ihcMb-jsYZpmSqBzg-1; Sun, 24 Oct 2021 04:48:28 -0400
X-MC-Unique: 2IR93ihcMb-jsYZpmSqBzg-1
Received: by mail-wr1-f69.google.com with SMTP id
 k2-20020adfc702000000b0016006b2da9bso2134739wrg.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 01:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=x+4gAu5mtq8yjhmzCHpAItde3uglak0uKi9++yZF6x4=;
 b=s9w+VsdPgdYsL9deQRAyS+tOkJjobqzqhr0FYd9joNKyN0AEVTIDyvTvuJRTER8JXc
 W7Vya117LdxqiAWwULJBYvhFxtI2KVYWytqZascXdId6iixHp1uRUvXnHrNWOBpXUkaa
 TyIKxp4Zn3b13o50B33IF2A6DYJiewwIE1P/A2ILf2C3bBZhPs8OihgCZ8PqqAKqZuje
 cWZehXKm9os4aca7/9hVfKDFRt76Kzsgrb+GuXzmGWx9Sy4uXVNeoIRBudo+ZXKlwP9h
 0vqhA9DMIPDj0h1GuxphS3gOpCqgM3Cp6s56MuOad/4KnFNr2BCCZoAYOCrkaHcbMldU
 5OYA==
X-Gm-Message-State: AOAM5329bGk4TYfbCyMjBaDvPatisgsK3dHSM1OoYMKUwNEw4QClevUb
 SwXmV2u6/NQBEZpIdzyz/wt0wlvE8FEYbuobAfUIv41vqEFqeR59IuMpjP4fAmcHfj7QZJoKWiw
 fH4dOzPNazwt55l0kpdKjIlHJSiHKjrS5+0e7OiokVw==
X-Received: by 2002:adf:b353:: with SMTP id k19mr14156392wrd.325.1635065306739; 
 Sun, 24 Oct 2021 01:48:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBXZ52beGBzMa+DgbJxq6cALSCJFAJyXJoIIqXck3s+fMgDLCqWgGSxucsWO8K8zFTKcOZdQ==
X-Received: by 2002:adf:b353:: with SMTP id k19mr14156363wrd.325.1635065306517; 
 Sun, 24 Oct 2021 01:48:26 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107e:5d4f:9dc9:1a6d:9b57:401])
 by smtp.gmail.com with ESMTPSA id a2sm12869839wru.82.2021.10.24.01.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 01:48:25 -0700 (PDT)
Date: Sun, 24 Oct 2021 04:48:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: add num_request_queues module parameter
Message-ID: <20211024044727-mutt-send-email-mst@kernel.org>
References: <20210902204622.54354-1-mgurtovoy@nvidia.com>
 <20211022052950-mutt-send-email-mst@kernel.org>
 <19cbe00a-409c-fd4b-4466-6b9fe650229f@nvidia.com>
 <93c7838d-d942-010e-e1b2-bc052365f5b1@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <93c7838d-d942-010e-e1b2-bc052365f5b1@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, stefanha@redhat.com, oren@nvidia.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Oct 24, 2021 at 11:12:26AM +0300, Max Gurtovoy wrote:
> =

> On 10/24/2021 10:19 AM, Max Gurtovoy wrote:
> > =

> > On 10/22/2021 12:30 PM, Michael S. Tsirkin wrote:
> > > On Thu, Sep 02, 2021 at 11:46:22PM +0300, Max Gurtovoy wrote:
> > > > Sometimes a user would like to control the amount of request queues=
 to
> > > > be created for a block device. For example, for limiting the memory
> > > > footprint of virtio-blk devices.
> > > > =

> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > ---
> > > > =

> > > > changes from v2:
> > > > =A0 - renamed num_io_queues to num_request_queues (from Stefan)
> > > > =A0 - added Reviewed-by signatures (from Stefan and Christoph)
> > > > =

> > > > changes from v1:
> > > > =A0 - use param_set_uint_minmax (from Christoph)
> > > > =A0 - added "Should > 0" to module description
> > > > =

> > > > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > > > =

> > > > ---
> > > > =A0 drivers/block/virtio_blk.c | 21 ++++++++++++++++++++-
> > > > =A0 1 file changed, 20 insertions(+), 1 deletion(-)
> > > > =

> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 4b49df2dfd23..aaa2833a4734 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -24,6 +24,23 @@
> > > > =A0 /* The maximum number of sg elements that fit into a virtqueue =
*/
> > > > =A0 #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> > > > =A0 +static int virtblk_queue_count_set(const char *val,
> > > > +=A0=A0=A0=A0=A0=A0=A0 const struct kernel_param *kp)
> > > > +{
> > > > +=A0=A0=A0 return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > +}
> > > > +
> =

> BTW, I've noticed in your new message you allow setting 0 so you might wa=
nt
> to change the code to
> =

> param_set_uint_minmax(val, kp, 0, nr_cpu_ids);
> =

> to a case a user will load the module with num_request_queues=3D0.

Oh. So as written the default forces 1 queue?
Send a patch please!

> > > > +static const struct kernel_param_ops queue_count_ops =3D {
> > > > +=A0=A0=A0 .set =3D virtblk_queue_count_set,
> > > > +=A0=A0=A0 .get =3D param_get_uint,
> > > > +};
> > > > +
> > > > +static unsigned int num_request_queues;
> > > > +module_param_cb(num_request_queues, &queue_count_ops,
> > > > &num_request_queues,
> > > > +=A0=A0=A0=A0=A0=A0=A0 0644);
> > > > +MODULE_PARM_DESC(num_request_queues,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0 "Number of request queues to use for blk =
device.
> > > > Should > 0");
> > > > +
> > > > =A0 static int major;
> > > > =A0 static DEFINE_IDA(vd_index_ida);
> > > I wasn't happy with the message here so I tweaked it.
> > > =

> > > Please look at it in linux-next and confirm. Thanks!
> > =

> > Looks good.
> > =

> > =

> > > =

> > > =

> > > > @@ -501,7 +518,9 @@ static int init_vq(struct virtio_blk *vblk)
> > > > =A0=A0=A0=A0=A0 if (err)
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 num_vqs =3D 1;
> > > > =A0 -=A0=A0=A0 num_vqs =3D min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > +=A0=A0=A0 num_vqs =3D min_t(unsigned int,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 min_not_zero(num_request_queues,=
 nr_cpu_ids),
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num_vqs);
> > > > =A0 =A0=A0=A0=A0=A0 vblk->vqs =3D kmalloc_array(num_vqs, sizeof(*vb=
lk->vqs),
> > > > GFP_KERNEL);
> > > > =A0=A0=A0=A0=A0 if (!vblk->vqs)
> > > > -- =

> > > > 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
