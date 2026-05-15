Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB53BB100;
	Fri, 15 May 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857878; cv=none; b=GwTkmEO1uItUjjDbchXpq0LozEb3dCtABV9h17PNpaH8daWLUvJVbZPYcb3Qy0L7EfpZPw0EFH5P8+TP4rTpI0HasSCMn7YEK6M55ctwOUFs8f1bdHy5kg8PogfZ5mpEaZbdihOaoYjeWItvvq8pc3Zgpl+j8zMSCw0hPy1YKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857878; c=relaxed/simple;
	bh=VIeZz7x/Rpw37P5bIVXe7Z5asqrGaJc2C3+bHXa89Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAml+4ntWDHCtUVcvOStktCcqE8t/RUnq8icWdKaY/HciibbAL5r55suiM7crMwylLpRgJsrn7m2PNgFE4mC1bZ31DkUfGoFMkx+icBYl898jsyH8vFT96eaXh/W3wxk13IIExex9z+JUWFcfn76illeJJ/4q0HlPUMyozr+pRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JoyidbmW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JoyidbmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA016C2BCFC;
	Fri, 15 May 2026 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778857878;
	bh=VIeZz7x/Rpw37P5bIVXe7Z5asqrGaJc2C3+bHXa89Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JoyidbmW94c0hQ8rAeyP7wSF4T8Ix3m79+2MxKQfBq+bs6S5qvE6TuasrOXKfEHUW
	 sMAdC4rne+JkYsxncEWVcyRy67M3T1meCfyFiB9p8ju/zZmkIboEhqThkYqOtA5MoO
	 MSnAac2tygjNSybbwQ5I0hF7eDwj7mOihXQzvsS8=
Date: Fri, 15 May 2026 17:11:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] vsock/virtio: fix potential unbounded skb queue
Message-ID: <2026051502-bootleg-retouch-f96f@gregkh>
References: <20260515-dumazet-v1-1-73468c902889@redhat.com>
 <agcsQ4LlG9ZsvBGR@leonardi-redhat>
 <2026051519-shale-scallion-aab7@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026051519-shale-scallion-aab7@gregkh>

On Fri, May 15, 2026 at 05:10:39PM +0200, Greg KH wrote:
> On Fri, May 15, 2026 at 04:23:53PM +0200, Luigi Leonardi wrote:
> > On Fri, May 15, 2026 at 04:22:12PM +0200, Luigi Leonardi wrote:
> > > From: Eric Dumazet <edumazet@google.com>
> > > 
> > > Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5
> > > 
> > > virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > 
> > > virtio_transport_recv_enqueue() skips coalescing for packets
> > > with VIRTIO_VSOCK_SEQ_EOM.
> > > 
> > > If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > a very large number of packets can be queued
> > > because vvs->rx_bytes stays at 0.
> > > 
> > > Fix this by estimating the skb metadata size:
> > > 
> > > 	(Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > 
> > > Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Cc: Eugenio Pérez <eperezma@redhat.com>
> > > Cc: virtualization@lists.linux.dev
> > > Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > [LL: Fixed conflict since this tree does not use buf_used added by commit
> > > 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
> > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> > > ---
> > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 4c374c36c29d..86e3051d000e 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > 					u32 len)
> > > {
> > > -	if (vvs->rx_bytes + len > vvs->buf_alloc)
> > > +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > +
> > > +	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
> > > 		return false;
> > > 
> > > 	vvs->rx_bytes += len;
> > > 
> > > ---
> > > base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
> > > change-id: 20260515-dumazet-07c0c855a9e2
> > > 
> > > Best regards,
> > > --
> > > Luigi Leonardi <leonardi@redhat.com>
> > > 
> > 
> > Forgot to add this is material for 6.6.y stable tree.
> 
> What about all of the newer stable trees?  You can't just apply a patch
> to an old branch :(

Ah, is this due to your other email?  that makes more sense, sorry for
the noise.

greg "drowning in email" k-h
