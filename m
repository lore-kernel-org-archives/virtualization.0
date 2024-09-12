Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAFA2F3E
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124361; cv=none; b=VzJ6P5TwRhrnW7N+zOFDJuBxR5LaCYTgSnISddrisnuHQmpOOpGBw8gc5ucx9yZA+AyaMXBujXZ7UQPtw/yaSWUPmzpND1cxDvhxnDu36xg7CcVwNWER8Ax4DPy+gxjqSZoYi1h3tQzM8VdZBgFLPkjmaRqOv9Q7htPJfekkzic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124361; c=relaxed/simple;
	bh=HMFQhaRKWf3M06P+NAxtvpnIs0fqmLoXoOpedcofAHE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jnxr4NElHejDAk5XKvhtXYh8k/1iLLysQJCWbGRWmdBq/MYJElFVZ6VZJwI5VYIR6YusfTbxpgTLs/s3IMi/f3EhybW0xw4q3/qvQvxp5h+v7LrVZw+9VnUdNFytWxj70xwoKGTBOXfw2rmNbUqiMZpJKGWi0JkPCZLR3PISYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PAir1QrD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PAir1QrD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726124355; h=Message-ID:Subject:Date:From:To;
	bh=8Rd84PhzS3DkamHaCwUiblImCqBAZoINA2ynPV/ZxTg=;
	b=PAir1QrDUQ6/1vqTRqhn4d8AGhzDa3QNlvf7BxUy/xGPA/2SrG+Zr1HeLqkdFFCmvzD+4QbVVj2ZQJCanX7uOgM31fgHa4Mdlydl2Y+SqXsxPOKCA9IHiFCX4vuy+AZur27MTY3ZwdTrImIAYVL7IU9iUW63/amR8EBAWkXWGVU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEqO.lV_1726124353)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 14:59:14 +0800
Message-ID: <1726124138.2346847-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 03/13] virtio_ring: packed: harden dma unmap for indirect
Date: Thu, 12 Sep 2024 14:55:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-4-xuanzhuo@linux.alibaba.com>
 <20240911072537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240911072537-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 11 Sep 2024 07:28:36 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> As gcc luckily noted:
>
> On Tue, Aug 20, 2024 at 03:33:20PM +0800, Xuan Zhuo wrote:
> > @@ -1617,23 +1617,24 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
> >  	}
> >
> >  	if (vq->indirect) {
> > +		struct vring_desc_extra *extra;
> >  		u32 len;
> >
> >  		/* Free the indirect table, if any, now that it's unmapped. */
> > -		desc = state->indir_desc;
> > -		if (!desc)
>
> desc is no longer initialized here


Will fix.


>
> > +		extra = state->indir;
> > +		if (!extra)
> >  			return;
> >
> >  		if (vring_need_unmap_buffer(vq)) {
> >  			len = vq->packed.desc_extra[id].len;
> >  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
> >  					i++)
> > -				vring_unmap_desc_packed(vq, &desc[i]);
> > +				vring_unmap_extra_packed(vq, &extra[i]);
> >  		}
> >  		kfree(desc);
>
>
> but freed here
>
> > -		state->indir_desc = NULL;
> > +		state->indir = NULL;
> >  	} else if (ctx) {
> > -		*ctx = state->indir_desc;
> > +		*ctx = state->indir;
> >  	}
> >  }
>
>
> It seems unlikely this was always 0 on all paths with even
> a small amount of stress, so now I question how this was tested.
> Besides, do not ignore compiler warnings, and do not tweak code
> to just make compiler shut up - they are your friend.

I agree.

Normally I do this by make W=12, but we have too many message,
so I missed this.

	make W=12 drivers/net/virtio_net.o drivers/virtio/virtio_ring.o

If not W=12, then I did not get any warning message.
How do you get the message quickly?

Thanks.

>
> >
> > --
> > 2.32.0.3.g01195cf9f
>
