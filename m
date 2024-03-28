Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D281E89C
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636640; cv=none; b=mvU+YoGrHIOWfQ8l6OU+dESgCB1DOZM17YKxUK9DGXbyNoaAtsjfDpQWwM1QeTGIvfLn4ALOlXH6Uxmt0kyZgpZSJLUY9CIehitVTFqgnBBUe9iU8fkBT2fu+lzZH0E1DUMMhXndVoovnG0eW2BwTf2kLiKX8xkeLGtUSGcPbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636640; c=relaxed/simple;
	bh=i7jFpT3SlY+C5YpRF/nwGu5Tl5UvMVM0Giak+wc/aEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWbXX70ieinYFz1UCCts9f53mNcoLuEP846t+sf7jCwnwjH6LHNjcDA9IW4I+10pSrqcmyOTVgC3inFR4Tg0peV8BX7PyeQLnhAAUYTN03k+lW0Y8tDocFkUVlK9XPdvasLqu4mBSWYR/FbDUz+25LnLsuJy2Cn/0V37UfNOF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso133480066b.1
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 07:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636637; x=1712241437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRMMyiWkeqTEpdcUJkKviRGWqg83eHB0joKkjU2QhOQ=;
        b=Dhwe8dJ55JQwvH6ixtE2Z6OnOdRiA5tV9EcobGpbnjMC7/5QbZB1/urilSB77HNhkj
         uZyGH26BHKX1KiaPG/aqUlVCdta+yNEaSmmffUI+PnqO0o8JPR7U0MnXaYzOxOxktVUh
         VdVJyAtHyY6bnocy0hVYSsYLpzSK1OvQhiSgUDLYz3vMITnshh5KBiuXB1WNgQRLFeNF
         MBzc8TMUVc8G/HdVZdhRx2aXG9AWKfpPRCBE3yxRmoPfYxnTCzbRkkh7zatJsljnuNET
         UTlg0nFC7POlZ/usAcEe1BDgye9BzVSYP8+zogiGFOvKlggJox8oEr3ugSH6dqMN9ZAz
         wlAA==
X-Forwarded-Encrypted: i=1; AJvYcCWDCciek+94aiOm2SMV0LR+4Nt5Y1Wy+ZVT6dijD/hqBoIGHBzQD+WwSMT6boTwxGxfko3qIqYQR3X8uAQ4/ynMtglgP7aYsul7mlXwzp8=
X-Gm-Message-State: AOJu0Ywro60Jj+uK2qrClDEoX1TElOtcYf+3TA8dkLC2f/FFNnunf0Z2
	lXhKbrR9tTD/gkQMEu5Er53Me0bw/jNMYfYQucmAcvCrsHSgqvei
X-Google-Smtp-Source: AGHT+IHF+TMUaDmJ1lsrsQ8KYkot3eOluabfodUPxJ/mwfrIC03qj8U9JnQ3QW/z96AbIL35qUEHfQ==
X-Received: by 2002:a17:906:d156:b0:a46:954a:aa14 with SMTP id br22-20020a170906d15600b00a46954aaa14mr2152846ejb.67.1711636637084;
        Thu, 28 Mar 2024 07:37:17 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id z4-20020a170906714400b00a469e55767dsm816421ejj.214.2024.03.28.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:37:16 -0700 (PDT)
Date: Thu, 28 Mar 2024 07:37:14 -0700
From: Breno Leitao <leitao@debian.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: rbc@meta.com, riel@surriel.com,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, hengqi@linux.alibaba.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 1/2] virtio_net: Do not set rss_indir if RSS is
 not supported
Message-ID: <ZgWAmsB4vTXE66uJ@gmail.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <1711503463.632461-1-xuanzhuo@linux.alibaba.com>
 <ZgQkXfMd6GIEndXm@gmail.com>
 <1711589335.4973893-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711589335.4973893-1-xuanzhuo@linux.alibaba.com>

> > On Wed, Mar 27, 2024 at 09:37:43AM +0800, Xuan Zhuo wrote:
> > > On Tue, 26 Mar 2024 08:19:08 -0700, Breno Leitao <leitao@debian.org> wrote:
> > > > Do not set virtnet_info->rss_indir_table_size if RSS is not available
> > > > for the device.
> > > >
> > > > Currently, rss_indir_table_size is set if either has_rss or
> > > > has_rss_hash_report is available, but, it should only be set if has_rss
> > > > is set.
> > > >
> > > > On the virtnet_set_rxfh(), return an invalid command if the request has
> > > > indirection table set, but virtnet does not support RSS.
> > > >
> > > > Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > ---
> > > >  drivers/net/virtio_net.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index c22d1118a133..c640fdf28fc5 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> > > >  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
> > > >  		return -EOPNOTSUPP;
> > > >
> > > > +	if (rxfh->indir && !vi->has_rss)
> > > > +		return -EINVAL;
> > > > +
> > > >  	if (rxfh->indir) {
> > >
> > > Put !vi->has_rss here?
> >
> > I am not sure I understand the suggestion. Where do you suggest we have
> > !vi->has_rss?
> >
> > If we got this far, we either have:
> >
> > a) rxfh->indir set and vi->has_rss is also set
> > b) rxfh->indir not set. (vi->has_rss could be set or not).
> 
> 
> This function does two tasks.
> 1. update indir table
> 2. update rss key
> 
> #1 only for has_rss
> #2 for has_rss or has_rss_hash_report
> 
> 
> So I would code:
> 
> 	bool update = false
> 
> 	if (rxfh->indir) {
> 		if (!vi->has_rss)
> 			return -EINVAL;
> 
> 		for (i = 0; i < vi->rss_indir_table_size; ++i)
> 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
> 
> 		update = true
> 	}
> 
> 	if (rxfh->key) {
> 		if (!vi->has_rss && !vi->has_rss_hash_report)
> 			return -EINVAL;
> 
> 		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
> 		update = true
> 	}
> 
> 
> 	if (update)
> 		virtnet_commit_rss_command(vi);
> 
> Thanks.

This is a bit different from the previous proposal, but, I like this one
approach better. It makes the code easier to read.

How does the full patch looks like?


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..180f342f1898 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3807,20 +3807,35 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
+	if (!vi->has_rss && !vi->has_rss_hash_report)
+		return -EOPNOTSUPP;
+
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
 	if (rxfh->indir) {
+		if (!vi->has_rss)
+			return -EINVAL;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+		update = true;
 	}
-	if (rxfh->key)
+
+	if (rxfh->key) {
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EINVAL;
+
 		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		update = true;
+	}
 
-	virtnet_commit_rss_command(vi);
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -4729,13 +4744,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
-	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+	}
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 
