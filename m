Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478313EDE7A;
	Mon,  6 Jul 2026 07:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322939; cv=none; b=aY08DfFbBC4sDYFhukbWkNbIbaI6AOW7HCCpI1NnyjQ0xqv84IAMJMNk759BZ0TIUY38eP3zKihs1M4MhxRYmfm+rimAL/QK84vNH3Qsv+h+9hkqJfsWXkhQ985jEB9tlsJFWWpGMFalX0DNmk7tWYmb3+b4Mg2ebI8dJwTExo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322939; c=relaxed/simple;
	bh=2xPZLCyu6U8/zbE8Zx5Ha8xuBUEk3fl2YhDFeyYX9AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+PRDFMWMMk0BFl96CsATD/3xYZ5Yy+sFt7E+F/SzRTyqw5pyap1dirGUNJvQXOZ/cvWmbfnHJ3kkm5ydWpdH1HP+Wrz3e49WwMryB0PHHBsLE7AEuohIl33RtO4TFXu78ASfZUk9/aQ9ay6LFjp6KV2J9EF59s8f1Id1auWpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlPLbPc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlPLbPc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1851F000E9;
	Mon,  6 Jul 2026 07:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783322934;
	bh=HkDczeYQYsOmrsz59HCm+BoyWNh+mF0I2Z4wZmf+oWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AlPLbPc8Yfr2j/WCNcgTwHSHw/i7+X0DXty0U49Tq72Lc0AdLcqqFJ7Rok1WYRYEt
	 wZP7ebXK3WT0r/Q6ee9ax6gZTpI7P89CbjqaU1V/kNthYVxWGZE3SmdHPTBvPIifa6
	 avYbw768X3XCK3u2XGvtaI4Cnncjnya3KAUg3KNpSFzp0WAzWRF9hu24RiUrnP+JeL
	 qBwFSWy+SgYEjPl7OJ9DZZ7qH7rZVy2Zbs34BUi12yIKNIOjJQ+03vaJc4WS4jzPpC
	 /vopDOanG3puM7wXBbrow1Xw3Hi15h8l2nwJyFRHMYvi8rXWJXVjgpdaB1loG6FKlp
	 I6gwFmozL6dSQ==
Message-ID: <13794c5e-375a-4fc5-84b4-a637d077f8a0@kernel.org>
Date: Mon, 6 Jul 2026 09:28:50 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_balloon: prime stats vq after
 virtio_device_ready()
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Adam Litke <agl@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>,
 virtualization@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
References: <2f0d0de033f3005d3b985883be3e5cf37b3f6c42.1783278596.git.mst@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <2f0d0de033f3005d3b985883be3e5cf37b3f6c42.1783278596.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/26 21:12, Michael S. Tsirkin wrote:
> The virtio spec requires the driver not to kick the device before
> DRIVER_OK is set.  init_vqs() primes the stats virtqueue with a buffer
> and kicks the device before virtio_device_ready() is called in
> virtballoon_probe(), violating this requirement.
> 
> Further, if the device responds to the early kick by processing the
> buffer before DRIVER_OK, stats_request() fires and queues
> update_balloon_stats_work.  Should probe then fail and free vb, the work
> runs against freed memory.
> 
> To fix, move buffer setup to after DRIVER_OK. Be careful to
> disable update_balloon_stats_work while this is going on,
> to make sure it does not race with the setup.
> 
> setup_vqs() warns but does not fail probe or restore if
> virtqueue_add_outbuf() fails; the call never actually fails in these
> contexts since the queue is freshly initialized and empty.
> 
> Testing: tested that stats still work after the change.
> 
> Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
> Reported-by: Sashiko:gemini-3.1-pro-preview
> Cc: David Hildenbrand <david@kernel.org>
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> changes from v1:
> 	check that work enable/disable is balanced
> 	explain how add buf never fails in probe/restore
> 
>  drivers/virtio/virtio_balloon.c | 50 +++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 088b3a0e6ce6..bc0a2b19ca7d 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -611,25 +611,8 @@ static int init_vqs(struct virtio_balloon *vb)
>  	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
>  	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> -		struct scatterlist sg;
> -		unsigned int num_stats;
>  		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
> -
> -		/*
> -		 * Prime this virtqueue with one buffer so the hypervisor can
> -		 * use it to signal us later (it can't be broken yet!).
> -		 */
> -		num_stats = update_balloon_stats(vb);
> -
> -		sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
> -		err = virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
> -					   GFP_KERNEL);
> -		if (err) {
> -			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
> -				 __func__);
> -			return err;
> -		}
> -		virtqueue_kick(vb->stats_vq);
> +		disable_work(&vb->update_balloon_stats_work);

That's to stop the stats queue triggering stats_request() I assume? Is that
valid before we actually added+kicked ourselves?

Also, can't we simply handle that in stats_request(), just ignoring it there?
Then  we wouldn't have to go through the siable + enable.

>  	}
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> @@ -916,6 +899,33 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>  	return 0;
>  }
>  
> +static void setup_vqs(struct virtio_balloon *vb)
> +{
> +	struct scatterlist sg;
> +	unsigned int num_stats;
> +	bool ret;
> +
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ))
> +		return;
> +
> +	/*
> +	 * Prime this virtqueue with one buffer so the hypervisor can
> +	 * use it to signal us later (it can't be broken yet!).
> +	 */
> +	num_stats = update_balloon_stats(vb);
> +	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
> +	if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)) {
> +		dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n", __func__);
> +		return;
> +	}
> +	virtqueue_kick(vb->stats_vq);
> +
> +	ret = enable_and_queue_work(system_freezable_wq,
> +				    &vb->update_balloon_stats_work);
> +	/* Make sure we balanced enable/disable, or we won't report stats. */
> +	BUG_ON(!ret);

A WARN_ON_ONCE() should be good enough here, no need to crash the kernel (no new
BUG_ON's).

-- 
Cheers,

David
