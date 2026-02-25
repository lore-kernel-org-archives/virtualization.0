Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE252329C6D
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013191; cv=none; b=APwxICbwDBLnJShxWOupv4i8ZopA4+V//kfZFiP7Jw3a1P4VslXNzxnKo0ouM1EV2pCjt3zH9ES5G1fA8HKBvmcDJAuxv9m6YmWvg8GPoAp8wT79g+si4XOT4QWUJQ9b9wcuFeZeKyl0u+2XNENOvXfb09fI7FrRfy8O8E7BxwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013191; c=relaxed/simple;
	bh=rE9DyE9PsTHuMCxDFN5nbZzUyeiy5TfnOuIRspSsthY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=YzyS0vyYOuAwLupsRx6RnbKX35u8loCB38kRXBisEuu+RbCv8RKvlWxSahl2awmrOC9oPm+AjqZVhAZarHlk1whGEne11xvKK6PB7bO/rYGqMtW3IVmBgX7yEN+ZeZWqvnLJa3VawxQrHPBWu67hc9dHbME52iIvlVwgZG5rNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iRiwSMe2; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iRiwSMe2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772013185; h=Message-ID:Subject:Date:From:To;
	bh=OaIxsJYzBsv9YB5DX1bJNSVl0rX7sZyKSgOfBP3V+4k=;
	b=iRiwSMe2wROPOPepwIMnlQzfRNunYl+Vn1bW15ZyqcF2yf4xMiD6p+sXwf9GjKQmUW7z6ZZnB4nkwmd0Uh+Nin2GqVuNH5GedkTaJtBjaAyctifuOLLCYAJL7psyhXrwYBremq7CVkFtskEwuy0aoIwtc7mkGxCF80K8wwztn3w=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wzm3cER_1772013183 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 17:53:04 +0800
Message-ID: <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Wed, 25 Feb 2026 17:52:29 +0800
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
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225044528-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 25 Feb 2026 04:47:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Feb 25, 2026 at 05:36:06PM +0800, Xuan Zhuo wrote:
> > On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > > > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > > > redundant runtime max check.
> > > > > > >
> > > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > >  		}
> > > > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > > > -			dev_warn(&vdev->dev,
> > > > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > > > -		}
> > > > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > > > >
> > > > > > Do we really need this check?
> > > > > >
> > > > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > > > defines this.
> > > > >
> > > > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > > > >
> > > > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > > > document the assumption.
> > > > >
> > > > >
> > > > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > > > the future, this check would no longer enforce the intended limit correctly.
> > > > >
> > > > > then it would fail build.
> > > >
> > > > So, does this mean we don't need to account for the case where
> > > > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> > > >
> > > > Thanks.
> > > >
> > >
> > > yes.
> >
> > Why?
> >
> > If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
> > violate the spec?
>
> not the value of key_sz. If type of key_sz
>
>
> i actually do not understand the question. this is not what BUILD_BUG_ON
> checks.

So this is the issue. Originally, the code checked whether the value of key_sz
was less than NETDEV_RSS_KEY_LEN. However, switching to a type_max check means
it no longer covers the scenario I described. Therefore, I think this is
unreasonable.

Thanks

>
> > > the code makes assumptions but it documents them and not
> > > just documents them, build will fail if they are violated.
> >
> > About this, I am ok.
> >
> > Thanks.
> >
> >
> > >
> > >
> > > > >
> > > > > >
> > > > > > Moreover, you should add a cover letter.
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > >  	}
> > > > > > >
> > > > > > >  	return 0;
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > >
> > >
>
