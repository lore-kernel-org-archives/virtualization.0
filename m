Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F1DC433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 09:24:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899BD23F34
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 09:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899BD23F34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D76EB85F8B;
	Fri, 11 Dec 2020 09:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g30eid8RpmCw; Fri, 11 Dec 2020 09:24:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BA57885F74;
	Fri, 11 Dec 2020 09:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97B21C0893;
	Fri, 11 Dec 2020 09:24:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70CFBC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5686186FA9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1LhexG2D5Lpc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:24:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4342F86FA7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 09:24:52 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id y23so7907687wmi.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 01:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Noiq8gsKgg/LmPBYtG4VjMmp/kERyYyDVQNSE22eDBs=;
 b=YJTmE9P6FWKESCHT99NVZ48X2FPzRfEvuv+TaYJap8W61ad8HrhmTIkP4DISixS4YH
 UwqC6CzRL/7k1wrePt0hA0EvJdpbQCpzFbeeAin/yNfw+d8JdaTCNbwvqkPgkXharbDz
 9YXL0Kl4jgi4VLGQEZ+/rDxK5G6k1TeQRprHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Noiq8gsKgg/LmPBYtG4VjMmp/kERyYyDVQNSE22eDBs=;
 b=FFQ068X8kt/W2GAGNfpGlJ1xaRknAQWfCLy+aDVd+FRHxcg1WMS5DXYlI35CX6qaPs
 NyV6pwfLUIJoL7M8T6E7z9dytx+/W5IfQrN5lFk3hPjN2nCvkc0QbMqziHHjxPFAZBgC
 gDU6Ojcegyw1hOsDxVEVlxv7GI9dQOdqq12IJLY8Qxpykm2/RVminwfDQU7L1E4WjNet
 51lGEArvmBpMYNwn/vpkURtZIDS7/fEhD2qgdn2uRoheiqnmWSuDrQN06Y/onEQZ8Z2m
 mp6FmvWgimlMsxdsOD+zCdDNLKv0sS1dBtgStRXYVp66zc1cbTJpA8Sjja30+plUo94g
 4V6A==
X-Gm-Message-State: AOAM533tK/QFXIX7Knx7hA1+hcogBJwNlegUDg2I5D/arRZCe5Yo3vCu
 ozBvtFAtXhlStRT3Sya4UKmy3Q==
X-Google-Smtp-Source: ABdhPJwvltxF9wGnEXSjhojgpoMzESfVQ1Ad7xV1kWlQXLVSKVgbKNI49bhVbctGtSZoQ6qoyon36w==
X-Received: by 2002:a1c:2d8a:: with SMTP id
 t132mr12747335wmt.128.1607678690518; 
 Fri, 11 Dec 2020 01:24:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id 65sm13809325wri.95.2020.12.11.01.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 01:24:49 -0800 (PST)
Date: Fri, 11 Dec 2020 10:24:47 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 3/8] dma-buf: Add vmap_local and vnumap_local operations
Message-ID: <20201211092447.GI401619@phenom.ffwll.local>
References: <20201209142527.26415-1-tzimmermann@suse.de>
 <20201209142527.26415-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209142527.26415-4-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: eric@anholt.net, airlied@linux.ie, sam@ravnborg.org,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sumit.semwal@linaro.org, linaro-mm-sig@lists.linaro.org,
 hdegoede@redhat.com, daniel@ffwll.ch,
 virtualization@lists.linux-foundation.org, sean@poorly.run,
 christian.koenig@amd.com, linux-media@vger.kernel.org
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

On Wed, Dec 09, 2020 at 03:25:22PM +0100, Thomas Zimmermann wrote:
> The existing dma-buf calls dma_buf_vmap() and dma_buf_vunmap() are
> allowed to pin the buffer or acquire the buffer's reservation object
> lock.
> 
> This is a problem for callers that only require a short-term mapping
> of the buffer without the pinning, or callers that have special locking
> requirements. These may suffer from unnecessary overhead or interfere
> with regular pin operations.
> 
> The new interfaces dma_buf_vmap_local(), dma_buf_vunmapo_local(), and
> their rsp callbacks in struct dma_buf_ops provide an alternative without
> pinning or reservation locking. Callers are responsible for these
> operations.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/dma-buf/dma-buf.c | 80 +++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 34 +++++++++++++++++
>  2 files changed, 114 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index e63684d4cd90..be9f80190a66 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1265,6 +1265,86 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_vunmap);
>  
> +/**
> + * dma_buf_vmap_local - Create virtual mapping for the buffer object into kernel
> + * address space.
> + * @dmabuf:	[in]	buffer to vmap
> + * @map:	[out]	returns the vmap pointer
> + *
> + * This call may fail due to lack of virtual mapping address space.
> + * These calls are optional in drivers. The intended use for them
> + * is for mapping objects linear in kernel space for high use objects.
> + * Please attempt to use kmap/kunmap before thinking about these interfaces.

Kmap is gone, so the entire 2 sentences here are no longer needed. Maybe
mention something like "Unlike dma_buf_vmap() this is a short term mapping
and will not pin the buffer. The struct dma_resv for the @dmabuf must be
locked until dma_buf_vunmap_local() is called."


> + *
> + * Returns:
> + * 0 on success, or a negative errno code otherwise.
> + */
> +int dma_buf_vmap_local(struct dma_buf *dmabuf, struct dma_buf_map *map)
> +{
> +	struct dma_buf_map ptr;
> +	int ret = 0;
> +
> +	dma_buf_map_clear(map);
> +
> +	if (WARN_ON(!dmabuf))
> +		return -EINVAL;
> +
> +	dma_resv_assert_held(dmabuf->resv);
> +
> +	if (!dmabuf->ops->vmap_local)
> +		return -EINVAL;
> +
> +	mutex_lock(&dmabuf->lock);
> +	if (dmabuf->vmapping_counter) {
> +		dmabuf->vmapping_counter++;
> +		BUG_ON(dma_buf_map_is_null(&dmabuf->vmap_ptr));
> +		*map = dmabuf->vmap_ptr;
> +		goto out_unlock;
> +	}
> +
> +	BUG_ON(dma_buf_map_is_set(&dmabuf->vmap_ptr));
> +
> +	ret = dmabuf->ops->vmap_local(dmabuf, &ptr);
> +	if (WARN_ON_ONCE(ret))
> +		goto out_unlock;
> +
> +	dmabuf->vmap_ptr = ptr;
> +	dmabuf->vmapping_counter = 1;
> +
> +	*map = dmabuf->vmap_ptr;
> +
> +out_unlock:
> +	mutex_unlock(&dmabuf->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_vmap_local);
> +
> +/**
> + * dma_buf_vunmap_local - Unmap a vmap obtained by dma_buf_vmap_local.
> + * @dmabuf:	[in]	buffer to vunmap
> + * @map:	[in]	vmap pointer to vunmap

Maybe for hyperlinking add "Release a mapping established with
dma_buf_vmap_local()."
> + */
> +void dma_buf_vunmap_local(struct dma_buf *dmabuf, struct dma_buf_map *map)
> +{
> +	if (WARN_ON(!dmabuf))
> +		return;
> +
> +	dma_resv_assert_held(dmabuf->resv);
> +
> +	BUG_ON(dma_buf_map_is_null(&dmabuf->vmap_ptr));
> +	BUG_ON(dmabuf->vmapping_counter == 0);
> +	BUG_ON(!dma_buf_map_is_equal(&dmabuf->vmap_ptr, map));
> +
> +	mutex_lock(&dmabuf->lock);
> +	if (--dmabuf->vmapping_counter == 0) {
> +		if (dmabuf->ops->vunmap_local)
> +			dmabuf->ops->vunmap_local(dmabuf, map);
> +		dma_buf_map_clear(&dmabuf->vmap_ptr);
> +	}
> +	mutex_unlock(&dmabuf->lock);
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_vunmap_local);
> +
>  #ifdef CONFIG_DEBUG_FS
>  static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  {
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index cf72699cb2bc..f66580d23a9b 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -269,6 +269,38 @@ struct dma_buf_ops {
>  
>  	int (*vmap)(struct dma_buf *dmabuf, struct dma_buf_map *map);
>  	void (*vunmap)(struct dma_buf *dmabuf, struct dma_buf_map *map);
> +
> +	/**
> +	 * @vmap_local:
> +	 *
> +	 * Creates a virtual mapping for the buffer into kernel address space.
> +	 *
> +	 * This callback establishes short-term mappings for situations where
> +	 * callers only use the buffer for a bounded amount of time; such as
> +	 * updates to the framebuffer or reading back contained information.
> +	 * In contrast to the regular @vmap callback, vmap_local does never pin
> +	 * the buffer to a specific domain or acquire the buffer's reservation
> +	 * lock.
> +	 *
> +	 * This is called with the dmabuf->resv object locked. Callers must hold

				^^Not the right kerneldoc, I think it
				should be &dma_buf.resv to get the
				hyperlink.

> +	 * the lock until after removing the mapping with @vunmap_local.
> +	 *
> +	 * This callback is optional.
> +	 *
> +	 * Returns:
> +	 *
> +	 * 0 on success or a negative error code on failure.
> +	 */
> +	int (*vmap_local)(struct dma_buf *dmabuf, struct dma_buf_map *map);
> +
> +	/**
> +	 * @vunmap_local:
> +	 *
> +	 * Removes a virtual mapping that wa sestablished by @vmap_local.

					     ^^established
> +	 *
> +	 * This callback is optional.
> +	 */
> +	void (*vunmap_local)(struct dma_buf *dmabuf, struct dma_buf_map *map);
>  };
>  
>  /**
> @@ -506,4 +538,6 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
>  		 unsigned long);
>  int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
>  void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
> +int dma_buf_vmap_local(struct dma_buf *dmabuf, struct dma_buf_map *map);
> +void dma_buf_vunmap_local(struct dma_buf *dmabuf, struct dma_buf_map *map);
>  #endif /* __DMA_BUF_H__ */


With the doc nits addressed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
