Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8EAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 16:27:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61E260F5B
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 16:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E61E260F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9C896077A;
	Tue, 28 Sep 2021 16:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c6ZB5dmG9gA7; Tue, 28 Sep 2021 16:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EB348606FF;
	Tue, 28 Sep 2021 16:27:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE474C0011;
	Tue, 28 Sep 2021 16:27:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F566C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 16:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B0A140105
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 16:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cW6kKx6xtoHH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 16:27:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99156400C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 16:27:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 636A360EE9;
 Tue, 28 Sep 2021 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632846466;
 bh=pxmRZz6UdCKyo/pIVTPGaxM9qJvC87Qcki0mcSQG0Gc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QOZ1Eyxws/1pmJeQ1d8Rz+AAw2zaFbTsRdmGXgZ0EuuCNMAnvjr0hvhZkhJZYEjfj
 uW8aT2SBMEBI6njSafdsdsdK2Np+fmUeCOChkM6Tp/gt5QnJTmiUg0/vjJE+k6yUIE
 VNiZh45LgC+8EhnSmzhPQzliLswMH2tgkFYLGahoPXXexWTnU6J7KKKL8jC82GzVRR
 57UETot+3TQaJmhd1ITCbcBIcMkDwZAjD1hX0uVIIA+GVmMh9e+GKb1nuSBOtvX76c
 0ZuADBIy+RtZmPDHKonWSA3KftxSaj8l94/qhoO58dfGzRDH1m2Dx0TA+IDh/jt3GK
 QjdJG113AplqA==
Date: Tue, 28 Sep 2021 19:27:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/2] virtio-blk: set NUMA affinity for a tagset
Message-ID: <YVNCflMxWh4m7ewU@unreal>
References: <20210926145518.64164-1-mgurtovoy@nvidia.com>
 <20210926145518.64164-2-mgurtovoy@nvidia.com>
 <YVGsMsIjD2+aS3eC@unreal>
 <0c155679-e1db-3d1e-2b4e-a0f12ce5950c@nvidia.com>
 <YVIMIFxjRcfDDub4@unreal>
 <f8de7c19-9f04-a458-6c1d-8133a83aa93f@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8de7c19-9f04-a458-6c1d-8133a83aa93f@nvidia.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org, mst@redhat.com,
 israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, stefanha@redhat.com, oren@nvidia.com,
 Yaron Gepstein <yarong@nvidia.com>
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

On Tue, Sep 28, 2021 at 06:59:15PM +0300, Max Gurtovoy wrote:
> 
> On 9/27/2021 9:23 PM, Leon Romanovsky wrote:
> > On Mon, Sep 27, 2021 at 08:25:09PM +0300, Max Gurtovoy wrote:
> > > On 9/27/2021 2:34 PM, Leon Romanovsky wrote:
> > > > On Sun, Sep 26, 2021 at 05:55:18PM +0300, Max Gurtovoy wrote:
> > > > > To optimize performance, set the affinity of the block device tagset
> > > > > according to the virtio device affinity.
> > > > > 
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > ---
> > > > >    drivers/block/virtio_blk.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > index 9b3bd083b411..1c68c3e0ebf9 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -774,7 +774,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > > >    	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
> > > > >    	vblk->tag_set.ops = &virtio_mq_ops;
> > > > >    	vblk->tag_set.queue_depth = queue_depth;
> > > > > -	vblk->tag_set.numa_node = NUMA_NO_NODE;
> > > > > +	vblk->tag_set.numa_node = virtio_dev_to_node(vdev);
> > > > I afraid that by doing it, you will increase chances to see OOM, because
> > > > in NUMA_NO_NODE, MM will try allocate memory in whole system, while in
> > > > the latter mode only on specific NUMA which can be depleted.
> > > This is a common methodology we use in the block layer and in NVMe subsystem
> > > and we don't afraid of the OOM issue you raised.
> > There are many reasons for that, but we are talking about virtio here
> > and not about NVMe.
> 
> Ok. what reasons ?

For example, NVMe are physical devices that rely on DMA operations,
PCI connectivity e.t.c to operate. Such systems indeed can benefit from
NUMA locality hints. At the end, these devices are physically connected
to that NUMA node.

In our case, virtio-blk is a software interface that doesn't have all
these limitations. On the contrary, the virtio-blk can be created on one
CPU and moved later to be close to the QEMU which can run on another NUMA
node.

Also this patch increases chances to get OOM by factor of NUMA nodes.
Before your patch, the virtio_blk can allocate from X memory, after your
patch it will be X/NUMB_NUMA_NODES.

In addition, it has all chances to even hurt performance.

So yes, post v2, but as Stefan and I asked, please provide supportive
performance results, because what was done for another subsystem doesn't
mean that it will be applicable here.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
