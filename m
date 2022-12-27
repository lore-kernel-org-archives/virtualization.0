Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24834C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D3EE404BF;
	Tue, 27 Dec 2022 07:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D3EE404BF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tly+4QEY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MXOxYV0Lbdqp; Tue, 27 Dec 2022 07:39:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D969840305;
	Tue, 27 Dec 2022 07:39:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D969840305
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CA18C0035;
	Tue, 27 Dec 2022 07:39:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DCECC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:39:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53C944031E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53C944031E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QnllJ_UiIBcs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:39:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 655B440305
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 655B440305
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672126768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ijp4/KDE7JPbV8flU95Sfl+xTfRImiWtlUkFnWEg/0E=;
 b=Tly+4QEYezBzxCbP3BVXS6aCeZiKpOKvFizhTDgYnqe5mB60RAYI4A7CqMbxoj/VwWphxN
 X6+2DV7pTYi/Y5LafFqKEm1AnFH9n0+T2EbV6Ba0lHt7uDWdpQ8DUvk5B1Sk6qC6Ppvzk3
 JKh1hay+9owFGvFS0qeLS9YxvWS+8+s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-f__Pahg_MxOHlI615D7zkA-1; Tue, 27 Dec 2022 02:39:26 -0500
X-MC-Unique: f__Pahg_MxOHlI615D7zkA-1
Received: by mail-ej1-f71.google.com with SMTP id
 xc12-20020a170907074c00b007416699ea14so8600714ejb.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijp4/KDE7JPbV8flU95Sfl+xTfRImiWtlUkFnWEg/0E=;
 b=lcnTypG5r/Hz4xIv9EN2xJVkh+BqWlQYOWWkZ50yUvhOSb16XFgq2Z6+dSXnLvpBk2
 2zOv81Isy1d5x6ZhfmsQdnG7LdyoAo9Z+R2g2utNjCLkiUXHY70Jj0kl5pT/hSd79eu9
 CiJx/Bn1dc07i2dSBe6eY+bux9QOlQ6Ci+rwj3KGOQaTaTOuxP5fwb81qyn1vWkL3cn/
 eLn60lrlRflVZhFQJly1+FkkYLhJQHrS4J7ffK2gQRccRsAkOlFfpk7KGpdK9JGCHZSt
 cG33zpKGm3dkCsqMO7lrHPgl4e4G74kDC1ayJVyYsj/koJXrTJfQ0Zc5HgM2mKWwTgAU
 5ZGw==
X-Gm-Message-State: AFqh2kqlYSqkNGF6h/uDRrsNZUxm6LOs5GZMdqMzwEMaqnTWsd8YebYY
 jQYt55o1/Kekz368ISr8iVZR0tGKjx/DVtsxUUu3c7MYvgXWsdCStWL5beP/OSDx4s35xRJo0lh
 IvJgodo5KfZ09vuZsgdyeEaFtTqOlutr+V0ucavRUeg==
X-Received: by 2002:a17:906:5012:b0:7c1:2e19:ba3f with SMTP id
 s18-20020a170906501200b007c12e19ba3fmr20934652ejj.57.1672126765788; 
 Mon, 26 Dec 2022 23:39:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvEK74H/0mvVg5+sIWI5S05sZ4NLeTRvhDcGPRtrHczfjDKJoNMKT3etQeIE3+qjfimvG37zg==
X-Received: by 2002:a17:906:5012:b0:7c1:2e19:ba3f with SMTP id
 s18-20020a170906501200b007c12e19ba3fmr20934639ejj.57.1672126765571; 
 Mon, 26 Dec 2022 23:39:25 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 ta13-20020a1709078c0d00b0077a201f6d1esm5705579ejc.87.2022.12.26.23.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:39:25 -0800 (PST)
Date: Tue, 27 Dec 2022 02:39:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/4] virtio-net: convert rx mode setting to use workqueue
Message-ID: <20221227023447-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221226074908.8154-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

On Mon, Dec 26, 2022 at 03:49:05PM +0800, Jason Wang wrote:
> @@ -2227,9 +2267,21 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>  				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
>  		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
>  
> +	rtnl_unlock();
> +
>  	kfree(buf);
>  }
>  
> +static void virtnet_set_rx_mode(struct net_device *dev)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +
> +	spin_lock(&vi->rx_mode_lock);
> +	if (vi->rx_mode_work_enabled)
> +		schedule_work(&vi->rx_mode_work);
> +	spin_unlock(&vi->rx_mode_lock);
> +}
> +
>  static int virtnet_vlan_rx_add_vid(struct net_device *dev,
>  				   __be16 proto, u16 vid)
>  {

Hmm so user tells us to e.g enable promisc. We report completion
but card is still dropping packets. I think this
has a chance to break some setups.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
