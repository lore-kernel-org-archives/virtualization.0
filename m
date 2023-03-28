Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64295C76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 02:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE11F40103;
	Tue, 28 Mar 2023 02:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE11F40103
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=xPW62TJv;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=xPW62TJv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uE-_2br22QT4; Tue, 28 Mar 2023 02:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AFC7C400EC;
	Tue, 28 Mar 2023 02:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFC7C400EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F91FC007E;
	Tue, 28 Mar 2023 02:14:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C1E9C007C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03A2A81F50
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03A2A81F50
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org
 header.a=rsa-sha256 header.s=2 header.b=xPW62TJv; 
 dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org
 header.a=rsa-sha256 header.s=2 header.b=xPW62TJv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bv76rLFkHFs1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:13:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18D5E81F4F
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18D5E81F4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:13:57 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
 id EE4F2C01C; Tue, 28 Mar 2023 04:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
 t=1679969633; bh=wqMNk37v7ep6rr1jhz7sYBORs1dIt3NXHYcIbaQ7jIg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xPW62TJvFSHPl3Gv9JQ8HAfCEesqn8fdPlrV/CljUx8VPMf1mGBfubqVsMbbBLDP1
 k/nyIvbgcrXG1s6YDRs3CA0dcn2CAUE1rBN2WGUpmWHfJ2yUYVKV3K7GDV0camJXxY
 uJTGxrpr4i6TbwJtSv/zBV8oLhJWFv9ShJwHjSKFOHAe376n/xtBtayDrsxdKYOgv1
 RDxRmc5C8zR2V6Fj69hCPWk1hi+UFbd/7EzKdE923DKvf5XqwU0J5t40q/ie2PQR+x
 GbwSmpsScKd8D44OkV+Vo3YLetFhBfoxgMG197N335V0aiPlAWRN8JCmlS8YG97Q/d
 GvX97CEcOLOog==
Received: from odin.codewreck.org (localhost [127.0.0.1])
 by nautica.notk.org (Postfix) with ESMTPS id 7569FC009;
 Tue, 28 Mar 2023 04:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
 t=1679969633; bh=wqMNk37v7ep6rr1jhz7sYBORs1dIt3NXHYcIbaQ7jIg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xPW62TJvFSHPl3Gv9JQ8HAfCEesqn8fdPlrV/CljUx8VPMf1mGBfubqVsMbbBLDP1
 k/nyIvbgcrXG1s6YDRs3CA0dcn2CAUE1rBN2WGUpmWHfJ2yUYVKV3K7GDV0camJXxY
 uJTGxrpr4i6TbwJtSv/zBV8oLhJWFv9ShJwHjSKFOHAe376n/xtBtayDrsxdKYOgv1
 RDxRmc5C8zR2V6Fj69hCPWk1hi+UFbd/7EzKdE923DKvf5XqwU0J5t40q/ie2PQR+x
 GbwSmpsScKd8D44OkV+Vo3YLetFhBfoxgMG197N335V0aiPlAWRN8JCmlS8YG97Q/d
 GvX97CEcOLOog==
Received: from localhost (odin.codewreck.org [local])
 by odin.codewreck.org (OpenSMTPD) with ESMTPA id c6bb0979;
 Tue, 28 Mar 2023 02:13:48 +0000 (UTC)
Date: Tue, 28 Mar 2023 11:13:32 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Albert Huang <huangjie.albert@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: 9p regression (Was: [PATCH v2] virtio_ring: don't update event idx
 on get_buf)
Message-ID: <ZCJNTBQLZeyLBKKB@codewreck.org>
References: <20230325105633.58592-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230325105633.58592-1-huangjie.albert@bytedance.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Luis Chamberlain <mcgrof@kernel.org>, v9fs-developer@lists.sourceforge.net
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

Hi Michael, Albert,

Albert Huang wrote on Sat, Mar 25, 2023 at 06:56:33PM +0800:
> in virtio_net, if we disable the napi_tx, when we triger a tx interrupt,
> the vq->event_triggered will be set to true. It will no longer be set to
> false. Unless we explicitly call virtqueue_enable_cb_delayed or
> virtqueue_enable_cb_prepare.

This patch (commited as 35395770f803 ("virtio_ring: don't update event
idx on get_buf") in next-20230327 apparently breaks 9p, as reported by
Luis in https://lkml.kernel.org/r/ZCI+7Wg5OclSlE8c@bombadil.infradead.org

I've just hit had a look at recent patches[1] and reverted this to test
and I can mount again, so I'm pretty sure this is the culprit, but I
didn't look at the content at all yet so cannot advise further.
It might very well be that we need some extra handling for 9p
specifically that can be added separately if required.

[1] git log 0ec57cfa721fbd36b4c4c0d9ccc5d78a78f7fa35..HEAD drivers/virtio/


This can be reproduced with a simple mount, run qemu with some -virtfs
argument and `mount -t 9p -o debug=65535 tag mountpoint` will hang after
these messages:
9pnet: -- p9_virtio_request (83): 9p debug: virtio request
9pnet: -- p9_virtio_request (83): virtio request kicked

So I suspect we're just not getting a callback.


I'll have a closer look after work, but any advice meanwhile will be
appreciated!
(I'm sure Luis would also like a temporary drop from -next until
this is figured out, but I'll leave this up to you)


> 
> If we disable the napi_tx, it will only be called when the tx ring
> buffer is relatively small.
> 
> Because event_triggered is true. Therefore, VRING_AVAIL_F_NO_INTERRUPT or
> VRING_PACKED_EVENT_FLAG_DISABLE will not be set. So we update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> every time we call virtqueue_get_buf_ctx. This will bring more interruptions.
> 
> To summarize:
> 1) event_triggered was set to true in vring_interrupt()
> 2) after this nothing will happen for virtqueue_disable_cb() so
>    VRING_AVAIL_F_NO_INTERRUPT is not set in avail_flags_shadow
> 3) virtqueue_get_buf_ctx_split() will still think the cb is enabled
>    then it tries to publish new event
> 
> To fix, if event_triggered is set to true, do not update
> vring_used_event(&vq->split.vring) or vq->packed.vring.driver->off_wrap
> 
> Tested with iperf:
> iperf3 tcp stream:
> vm1 -----------------> vm2
> vm2 just receives tcp data stream from vm1, and sends the ack to vm1,
> there are many tx interrupts in vm2.
> but without event_triggered there are just a few tx interrupts.
> 
> Fixes: 8d622d21d248 ("virtio: fix up virtio_disable_cb")
> Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> Message-Id: <20230321085953.24949-1-huangjie.albert@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cbeeea1b0439..1c36fa477966 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -914,7 +914,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> -	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +	if (unlikely(!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
>  				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> @@ -1744,7 +1745,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call.
>  	 */
> -	if (vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC)
> +	if (unlikely(vq->packed.event_flags_shadow == VRING_PACKED_EVENT_FLAG_DESC &&
> +		     !vq->event_triggered))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vq->packed.vring.driver->off_wrap,
>  				cpu_to_le16(vq->last_used_idx));
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
