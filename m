Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632617C235
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871329; cv=none; b=OS8/h7uTVOtF9PDH36N3BNLKHKYBj9B/q0j47sir1lEQ+7D2swI/K2hRSIwZTLwMw8EYuFmPFbpWCh0J85nrfPAUC4H5CU9j3g7oiuh5fKhEUsi3NmHs3/JmVlfs/iKdRDEpWR8q64HH7kZEfmEp/Ui4NKXKth/mOwRliKKiyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871329; c=relaxed/simple;
	bh=QQN5MWcgFvej1lFWyiOc0hlQXuyKb17sEjfAfzK8yE4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=uqu3nXXIDF7J38ruI20Ub6ZJqm/AJ4uQ8T9WWz/1queCeD6OlNVr+JC41VUa2WS5h84mKh7rnHjYx3btwOOC06KFag+DJLISm2rZrlbbNDTLEkq3xCHqj0LPskudxHakdEoyjWDbG4lz+FFHessspGMgOsmESBDQHRTT96QIrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YdVvjg1R; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YdVvjg1R"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718871322; h=Message-ID:Subject:Date:From:To;
	bh=IWsqLolJNxTdvFPMcucDRzIAOF+b9AvIwc4qt2sjbVw=;
	b=YdVvjg1RkOLjfSUj5+P5RBVeENQFnufHv4TNuLAEgGhxXa7gMhXAOryR3z1hcbqtgkVfOsur2EEDY6xWSluQ3GiHReB6yGaSC+kD/1qIfJi/DHnB8Mc5ydrV1BraY+t69YTZHYN5117GJ08fPRIZiU/zmAV7MNFhbbljKuDDIcU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W8qgb1u_1718871320;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8qgb1u_1718871320)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 16:15:20 +0800
Message-ID: <1718871314.1931674-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] net: virtio: unify code to init stats
Date: Thu, 20 Jun 2024 16:15:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>,
 linux-kernel@vger.kernel.org
References: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
In-Reply-To: <fb91a4ec2224c36adda854314940304d708d59ef.1718869408.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 03:44:53 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Moving initialization of stats structure into
> __free_old_xmit reduces the code size slightly.
> It also makes it clearer that this function shouldn't
> be called multiple times on the same stats struct.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


> ---
>
> Especially important now that Jiri's patch for BQL has been merged.
> Lightly tested.
>
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 283b34d50296..c2ce8de340f7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>  	unsigned int len;
>  	void *ptr;
>
> +	stats->bytes = stats->packets = 0;
> +
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>  		++stats->packets;
>
> @@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>
>  static void free_old_xmit(struct send_queue *sq, bool in_napi)
>  {
> -	struct virtnet_sq_free_stats stats = {0};
> +	struct virtnet_sq_free_stats stats;
>
>  	__free_old_xmit(sq, in_napi, &stats);
>
> @@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  			    int n, struct xdp_frame **frames, u32 flags)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	struct virtnet_sq_free_stats stats = {0};
> +	struct virtnet_sq_free_stats stats;
>  	struct receive_queue *rq = vi->rq;
>  	struct bpf_prog *xdp_prog;
>  	struct send_queue *sq;
> --
> MST
>
