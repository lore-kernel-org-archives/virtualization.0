Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F547C4332F
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 18:23:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EAF60F11
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 18:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40EAF60F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06C8A4014E;
	Mon, 27 Sep 2021 18:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYck42ubjRxT; Mon, 27 Sep 2021 18:23:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65B3140104;
	Mon, 27 Sep 2021 18:23:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B417C001C;
	Mon, 27 Sep 2021 18:23:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FE98C000F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 18:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EE45402B8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 18:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l6FWiG9UaCpk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 18:23:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC7E040261
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 18:23:32 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B08FD60F11;
 Mon, 27 Sep 2021 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632767012;
 bh=PEfnJvnMLX3HzCxJvQOSm8TUcP24eAq+3o46ij/lCio=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QLX7Zbm4eAjOypOxP3TA0hEiGTi5+UE4LoaR/+AApBexUvYyohRYQVbI6jMzxjzjT
 x7C7XuRfXr6R9vbREJgTXejWww6Lx5aCMT2aHSOGCp0SOLNXpE+mYwjX4WLlXSMT/v
 ZQS+g0wnvpq2ujW9XJK1OJLZHddrXuJyi1DYhLxcyxKjd12eTHHdCDmnTrUleN96Fl
 c0eXtldARexqmfxnp8zVCcFkE7CuqzWmIfQixgEC/+FST13Chzurawv41c4mZmdM3l
 o92h+WUxGNbEEr32hKNpIE6ePp5Mommzze6dEOXkqbDFXVaeu5/hQN3ae0lE+I/uXl
 B+LQXXK7y6xLA==
Date: Mon, 27 Sep 2021 21:23:28 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-blk: set NUMA affinity for a tagset
Message-ID: <YVIMIFxjRcfDDub4@unreal>
References: <20210926145518.64164-1-mgurtovoy@nvidia.com>
 <20210926145518.64164-2-mgurtovoy@nvidia.com>
 <YVGsMsIjD2+aS3eC@unreal>
 <0c155679-e1db-3d1e-2b4e-a0f12ce5950c@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c155679-e1db-3d1e-2b4e-a0f12ce5950c@nvidia.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 mst@redhat.com, israelr@nvidia.com, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Sep 27, 2021 at 08:25:09PM +0300, Max Gurtovoy wrote:
> 
> On 9/27/2021 2:34 PM, Leon Romanovsky wrote:
> > On Sun, Sep 26, 2021 at 05:55:18PM +0300, Max Gurtovoy wrote:
> > > To optimize performance, set the affinity of the block device tagset
> > > according to the virtio device affinity.
> > > 
> > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 9b3bd083b411..1c68c3e0ebf9 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -774,7 +774,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >   	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> > >   	vblk->tag_set.ops = &virtio_mq_ops;
> > >   	vblk->tag_set.queue_depth = queue_depth;
> > > -	vblk->tag_set.numa_node = NUMA_NO_NODE;
> > > +	vblk->tag_set.numa_node = virtio_dev_to_node(vdev);
> > I afraid that by doing it, you will increase chances to see OOM, because
> > in NUMA_NO_NODE, MM will try allocate memory in whole system, while in
> > the latter mode only on specific NUMA which can be depleted.
> 
> This is a common methodology we use in the block layer and in NVMe subsystem
> and we don't afraid of the OOM issue you raised.

There are many reasons for that, but we are talking about virtio here
and not about NVMe.

> 
> This is not new and I guess that the kernel MM will (or should) be handling
> the fallback you raised.

I afraid that it is not. Can you point me to the place where such
fallback is implemented?

> 
> Anyway, if we're doing this in NVMe I don't see a reason to afraid doing it
> in virtio-blk.

Still, it is nice to have some empirical data to support this copy/paste.

There are too many myths related to optimizations, so finally it will be
good to get some supportive data.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
