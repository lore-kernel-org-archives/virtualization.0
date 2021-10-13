Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED1C433FE
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 09:57:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2715C60F94
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 09:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2715C60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E50BC40758;
	Wed, 13 Oct 2021 09:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yOkT8g3aSwPl; Wed, 13 Oct 2021 09:57:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95E9740745;
	Wed, 13 Oct 2021 09:57:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A656C0011;
	Wed, 13 Oct 2021 09:57:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 171CBC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06A8140753
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wr_INGLM4HGK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:57:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6587F40745
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634119052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lr3epdSoyD9tsHtOQNYbPUXEeZwWL7vVg7MIPONlWnE=;
 b=MBaSUZUIjN3+ff0F39FvLuZ9JPuKsZtOth5AwkMghc0m02Xng1Lcp5Wp56Eh4GleqHI7SN
 othlpBim3vy2Gtikt2p7jaAWTe9nZzs7joymkFzvNKh1PT+6LSqtWgYxM1IUXFUQQl02xV
 YbXDZgasjpis4MPa+FvUilp7zNhGYfU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-PmMTES6-PCCHlxaya_Z_zg-1; Wed, 13 Oct 2021 05:57:31 -0400
X-MC-Unique: PmMTES6-PCCHlxaya_Z_zg-1
Received: by mail-wr1-f70.google.com with SMTP id
 y12-20020a056000168c00b00160da4de2c7so1554998wrd.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 02:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Lr3epdSoyD9tsHtOQNYbPUXEeZwWL7vVg7MIPONlWnE=;
 b=QPjc3QaeqdSKfTepuPohjOW4Xp561NSCq/eeK5WDIej06bNkMKqFe6yhIzF/ZBoQDc
 Az0PIplohawKM0z1NwumtKD9NalirUA811TADwc/kzJiKBni3ZwHMgL2gmQC2PnGghr2
 DKH+VvwWnoy5es4T2dlaN5qL5VkN1aJNGsxafnKh53a3MWSJG0nF/0vgiHZwHZ8rABSe
 SLMh1jemdQdnYP3tOmG88AG9TibbH0mvhI03VttJgh85wct+aCMiBj7S7Kc3D/gUlM8l
 JwP97FMJrufCg5j3l5W3CdTrQnEn6kQaKKGB+aXvC3TMmf5kHTV8eEdjJgdlLkZo1nWQ
 nQPw==
X-Gm-Message-State: AOAM5337vsWcOJxae7qvqYTVNfSy6EaZ9iYWl78rKfOSQp0nk0mAqPTa
 /YvUUETUsUH392PQ6opIolsBEnraBWBQHtnEK564s4AchG2LoeNhI96u7U7zfwRgpo/CoKAPRFB
 qADxOdyd8e1P+NAIMDQwz4B5vRTsEM7wWf1JPBbXxXA==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr11843766wmg.38.1634119049814; 
 Wed, 13 Oct 2021 02:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/2iWFNAXXDAi19/czXJ1HhQNIQP5oBQDFC8kUKve2d6ed2R9dgQg4rxtao35XZvCFS4LfIA==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr11843745wmg.38.1634119049587; 
 Wed, 13 Oct 2021 02:57:29 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id c77sm4830641wme.48.2021.10.13.02.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 02:57:29 -0700 (PDT)
Date: Wed, 13 Oct 2021 05:57:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 05/12] virtio_config: introduce a new ready method
Message-ID: <20211013055401-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-6-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211012065227.9953-6-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Oct 12, 2021 at 02:52:20PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/virtio_config.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 8519b3ae5d52..f2891c6221a1 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -23,6 +23,8 @@ struct virtio_shm_region {
>   *       any of @get/@set, @get_status/@set_status, or @get_features/
>   *       @finalize_features are NOT safe to be called from an atomic
>   *       context.
> + * @ready: make the device ready
> + *      vdev: the virtio_device
>   * @get: read the value of a configuration field
>   *	vdev: the virtio_device
>   *	offset: the offset of the configuration field

I think it's too vague. device_ready makes device ready to receive
kicks. What does this one do? I don't like calling things by where
they are called from, I prefer calling them by what they do.
It actually enables callbacks, right?
So enable_cbs?


> @@ -75,6 +77,7 @@ struct virtio_shm_region {
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> +	void (*ready)(struct virtio_device *vdev);
>  	void (*get)(struct virtio_device *vdev, unsigned offset,
>  		    void *buf, unsigned len);
>  	void (*set)(struct virtio_device *vdev, unsigned offset,
> @@ -229,6 +232,9 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>  	unsigned status = dev->config->get_status(dev);
>  
> +	if (dev->config->ready)
> +                  dev->config->ready(dev);
> +
>  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
