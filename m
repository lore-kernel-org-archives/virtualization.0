Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A013B6BE8
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094416; cv=none; b=ekc4RqsGhdOnXElxQmzl78nF2Rf3XmKFXQPLK0Nx3EB0dNrarulMo0OwO2x5HfJzs6Kga49D1HjfgwJL395gmuR4O+NkSlEWWRZmO/bcydjE4OAHCV9KGfwc75yB2pTPo83p8oX8kU5CqAWsjFKIthHoeoi+ideYmH6D4Axp9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094416; c=relaxed/simple;
	bh=i+8MDvG7D9pwY3mzJiXZPpJfA8cRZ6oZF263yocc6Z4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=p+PgkqDAj7KbjpEAJ9VhYu+jRmAgjuwy3+iQaw5Vylf7IQbAKwcIzBWKs2eWPUlZcBnlUY0rf1gcMGQ3Jlt1Gh1qQ2gyu2Kxtvsig9vLC050IfwtIYRPD4pNO+mO0gAsfjoo3mZqIicLvgxKgzBfoV5GuTUxzjfPYVPox+R0RH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8562B80A76;
	Wed, 10 Jun 2026 14:26:52 +0200 (CEST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net] virtio_net: do not allow tunnel csum offload for
 non GSO packets
From: Gabriel Goller <g.goller@proxmox.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
 Willem de Bruijn <willemb@google.com>
In-Reply-To: <178109396600.129329.5073003425673349392.b4-review@b4>
References: <38d33d63ce5d1aee486bd6c7c47345040d526e35.1781016169.git.pabeni@redhat.com>
 <178109396600.129329.5073003425673349392.b4-review@b4>
Date: Wed, 10 Jun 2026 14:26:46 +0200
Message-Id: <178109440698.133190.10746182935909823140.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1781094365047

On 2026-06-10 14:19:26+02:00, Gabriel Goller wrote:
> On Tue, 09 Jun 2026 16:44:26 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > [...]
> > 
> > Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> > Closes: https://bugzilla.proxmox.com/show_bug.cgi?id=7627
> > Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Gave it a spin and it works alright, so consider:

Tested-by: Gabriel Goller <g.goller@proxmox.com>
Missed this :(

> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..07b8710639f9 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6222,6 +6222,18 @@ static void virtnet_free_irq_moder(struct virtnet_info *vi)
> >  	rtnl_unlock();
> >  }
> >  
> > +static netdev_features_t virtnet_features_check(struct sk_buff *skb,
> > +						struct net_device *dev,
> > +						netdev_features_t features)
> > +{
> > +	/* Inner csum offload is only available for GSO packets. */
> > +	if (skb->encapsulation && !skb_is_gso(skb))
> 
> A small question -- should we maybe check for skb_gso_ok here as well?
> So add:
> 
> 	(!skb_is_gso(skb) || !skb_gso_ok(skb, features)))
> 
> Because skb_is_gso alone doesn't guarantee that the packets leaving virtio will
> be gso'd, they could be software gso'd at validate_xmit_skb, which is called
> after ndo_feature_check.
> leaving the virtio device.

This is supposed to say:

So packet is a GSO packet but will be segmented by validate_xmit_skb before
leaving the virtio device.

b4 thought "So:" is a git trailer :(

> Not sure if this can happen though.
> 
> > @@ -6235,7 +6247,7 @@ static const struct net_device_ops virtnet_netdev = {
> >  	.ndo_bpf		= virtnet_xdp,
> >  	.ndo_xdp_xmit		= virtnet_xdp_xmit,
> >  	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
> > -	.ndo_features_check	= passthru_features_check,
> > +	.ndo_features_check	= virtnet_features_check,
> >  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
> >  	.ndo_set_features	= virtnet_set_features,
> >  	.ndo_tx_timeout		= virtnet_tx_timeout,
> 
> Thanks,
> Gabriel

Sorry for the noise.


