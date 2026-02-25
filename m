Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB72F9DB5
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011860; cv=none; b=iinUIINt4+xUaB0Tt1q9U0NSMxI1sMopTya7s7bUqH8nqmtyMAjkTGHukcLNzDeAhUciFiHTC8CifTwFG+uRb+T2ul9YL44xQDrnkfyrbYkgDTjl7ftQI7wmyy7SNIEi2M2/so5q4IxRgK706PCqMXeL9b5IIbJ698fxhzgNfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011860; c=relaxed/simple;
	bh=CHBqn97VcBBUxsnUo1U/Qb8m4li5OZxXTDQy4F7pUjQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=fuvoBqZNDqDwH8dUWzqZuXLMn2mlFdkLxPoZwzeIu44vFHHkUVBp4QopSZUG07/h1Fq0GTc2fqxfaM3o5yIkZzDgWXiUvW1KDYCCNnI/xNXdQxa3u+OwDh0MizPLL0RR1zH9nDji18MO+IQ+PzIKUdjathPssyDXOBteXAGvLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PqB+nIcj; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PqB+nIcj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772011855; h=Message-ID:Subject:Date:From:To;
	bh=GxQYjVLQB0nTHOWpQ17UZEBT3XLyqCWVg8QZsJrTc+Q=;
	b=PqB+nIcjvV/Wl0FdhskP0RSx0xa9Xow4tBT0Zt1ZhUKJrvfy77O4TRyPd6MScD93L3XKxC/7bD+jspP7Q53Wr5+PnpAc2vamR5KU3SU2xL5+ftUYCbjfO+6DHb2ZsgQE5SyJVGYwTMngnDqAR19Oi05SXrvgAg6ejblRpNxbDa0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wzm3QU1_1772011854 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 17:30:55 +0800
Message-ID: <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Wed, 25 Feb 2026 17:30:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
 pabeni@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 ndabilpuram@marvell.com,
 kshankar@marvell.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260224065850.962826-2-schalla@marvell.com>
 <1772010702.3747633-2-xuanzhuo@linux.alibaba.com>
 <20260225042302-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225042302-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > redundant runtime max check.
> > >
> > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > ---
> > >  drivers/net/virtio_net.c | 8 +-------
> > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index eeefe8abc122..768ad5523dfa 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > >  		}
> > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > -			dev_warn(&vdev->dev,
> > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > -		}
> > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> >
> > Do we really need this check?
> >
> > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > key_sz is of type u8, its maximum value is inherently 255, making this check
> > redundant. This is not only limited by this kernel code, the virtio-net spec
> > defines this.
>
> That's why it's BUILD_BUG_ON. It checks it has the right type.
>
> We never *need* BUILD_BUG_ON by definition, what this does is
> document the assumption.
>
>
> > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > the future, this check would no longer enforce the intended limit correctly.
>
> then it would fail build.

So, does this mean we don't need to account for the case where
NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?

Thanks.


>
> >
> > Moreover, you should add a cover letter.
> >
> > Thanks.
> >
> >
> >
> >
> >
> > >  	}
> > >
> > >  	return 0;
> > > --
> > > 2.25.1
> > >
>
