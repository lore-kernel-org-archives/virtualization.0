Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860D38F24F
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012308; cv=none; b=MVRqFo3fBXONBpecqrfGr7RDm9zxhyJ1cFdf7zKeUfC5O43/3J76m5CTmbu+dB3fNZRn17O5Laz6+8GUTt05rXqPw/qHSHuURuouMj1Y3PZvM2Qb5fQvuf3q3H5CC1CL5fxXgUfz2kROx7hivwxIOs3OALIH2CV5vXwBWASDxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012308; c=relaxed/simple;
	bh=1dLLMH5GIoxKJEBTV/utfHr/NfjFSZ5psEIajw3MuOI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=mKmdZ1lPJuTkIS957CgFti8Iwgr6onWb3hA+BgnQR816Z25QRGyqE+MZHR333dyIYj35Cr6NNwegOMA3xnlCNACo2dhp1O8nkjAiEFProzdUcuWDYORkCwMwrTnLLHVxGoNXIUqY3Twa/RQQtD+MlVMYXgK6sbrtqv0PaRrSrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SX+Dcbqx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SX+Dcbqx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772012298; h=Message-ID:Subject:Date:From:To;
	bh=TFcqJpM92n7IwSmqYDILwf+RYMnPdukEY+exes7lVbI=;
	b=SX+Dcbqxe+mX/fkV8XWw57lDLjyFPAPM7VlIVu3bagT/j3eDnmQSUw9VcpUPiF4NaJCup0PO0UgV3jlydwk2rRjJMRZmv1D9m4GCwjlZbyNYC/6clHMgBHs51moy3vskLjaHdV1EAyldfAXGr0TnIPfTzNRkAzusXGvKqXz3pNk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wzm3Usy_1772012297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 17:38:17 +0800
Message-ID: <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check with BUILD_BUG_ON
Date: Wed, 25 Feb 2026 17:36:06 +0800
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
In-Reply-To: <20260225043249-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 25 Feb 2026 04:33:57 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Feb 25, 2026 at 05:30:33PM +0800, Xuan Zhuo wrote:
> > On Wed, 25 Feb 2026 04:24:14 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Feb 25, 2026 at 05:11:42PM +0800, Xuan Zhuo wrote:
> > > > On Tue, 24 Feb 2026 12:28:50 +0530, Srujana Challa <schalla@marvell.com> wrote:
> > > > > Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> > > > > BUILD_BUG_ON to enforce the limit at compile time and remove the
> > > > > redundant runtime max check.
> > > > >
> > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 8 +-------
> > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index eeefe8abc122..768ad5523dfa 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
> > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > >  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > >  		}
> > > > > -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> > > > > -			dev_warn(&vdev->dev,
> > > > > -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> > > > > -				 key_sz, NETDEV_RSS_KEY_LEN);
> > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> > > > > -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> > > > > -		}
> > > > > +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);
> > > >
> > > > Do we really need this check?
> > > >
> > > > If I understand correctly, the intention is to cap key_sz at 256. However, since
> > > > key_sz is of type u8, its maximum value is inherently 255, making this check
> > > > redundant. This is not only limited by this kernel code, the virtio-net spec
> > > > defines this.
> > >
> > > That's why it's BUILD_BUG_ON. It checks it has the right type.
> > >
> > > We never *need* BUILD_BUG_ON by definition, what this does is
> > > document the assumption.
> > >
> > >
> > > > Moreover, if NETDEV_RSS_KEY_LEN is ever reduced to a value smaller than 256 in
> > > > the future, this check would no longer enforce the intended limit correctly.
> > >
> > > then it would fail build.
> >
> > So, does this mean we don't need to account for the case where
> > NETDEV_RSS_KEY_LEN is 128, but the key_sz reported by the device is 64?
> >
> > Thanks.
> >
>
> yes.

Why?

If NETDEV_RSS_KEY_LEN is 128 but the device reports a key_sz of 64, does this
violate the spec?

> the code makes assumptions but it documents them and not
> just documents them, build will fail if they are violated.

About this, I am ok.

Thanks.


>
>
> > >
> > > >
> > > > Moreover, you should add a cover letter.
> > > >
> > > > Thanks.
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > >  	}
> > > > >
> > > > >  	return 0;
> > > > > --
> > > > > 2.25.1
> > > > >
> > >
>
