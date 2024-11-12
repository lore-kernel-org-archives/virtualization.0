Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF92219E58
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Nov 2024 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731445322; cv=none; b=qat4T1GKaXRztugVLpd6ssMjwBukCK5Qq3yU2zo11rfjMYEMd1a76rE+7CbGg5uSAVuJn6feAqIOPHOk/DbzirQGw5Xz+tu9X70zPwsNWuc8/J6T3K6qcVUS6tF4/1vUHlTK8G67DY0rWurqxl5UvC7mlbE6O1VBgQK1aoa9rEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731445322; c=relaxed/simple;
	bh=lE8+hKVXI3533LUYOTxuSIVIhh77vHJWphzhjamaQlk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpT08S0w63+UL7D3Kp2I7wv3Ig/LmmdiQxQuj1xZyTDq/zalMkMnxMQSUDRi/Lpxzm/Q8sC1auC/m0diKcXGTdr1qaUpJl7N9BtTohbFfryuXkIhazOhWAvT0QX+K/3feevXuIFLwMlefxksDt/tIt6mDPdQo3gzFYv8/Vd4w/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJT9L+T9; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJT9L+T9"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 198614025F
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Nov 2024 21:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPPQ5HfiAxfo for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Nov 2024 21:02:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 000C240189
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 000C240189
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gJT9L+T9
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 000C240189
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Nov 2024 21:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731445317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdtsPtEgy/GqbYpllDqET8ibZDA5+N3hhfAC0l8hEiQ=;
	b=gJT9L+T9zXEGaSye+c9sxVIAbsXAG2W0d4BUQEfQnp831T5OvZfoDjupwvGHFaT8cg0pF/
	U6tv7Kzg3rkz/spaVDy4wYilIosQWwtr30bKFH+4Ho9ZUuze449g77NejCJnM++z5Ak5l8
	1ad4PrpVE9o20OjRUF2t6Mj32FlrcK8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-ZB1R7mrsOtmwcpe1g9st-Q-1; Tue, 12 Nov 2024 16:01:56 -0500
X-MC-Unique: ZB1R7mrsOtmwcpe1g9st-Q-1
X-Mimecast-MFC-AGG-ID: ZB1R7mrsOtmwcpe1g9st-Q
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7180cdce4cbso208669a34.2
        for <virtualization@lists.linux-foundation.org>; Tue, 12 Nov 2024 13:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731445315; x=1732050115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdtsPtEgy/GqbYpllDqET8ibZDA5+N3hhfAC0l8hEiQ=;
        b=gi3jcXVB4iGXGUqeOGIxD2RQFZn8br4URUeVd5AYz64brUDGTvEt+IkKNJNHobnZw7
         JAPzjvj3MCA6L9/BfzrJlM2swtEdffSNwRkV/gWTh5xLUPQwTDcbFyDe9HXAu+GvpobH
         cx5sWbicLr2BhtTiC1i2aBHoo65FImncQqCcmVll2vwAqVFrhxq4UjuKBhEgxkkFgBkO
         6xb2WP+EwSq9gsatyptlBqIa+HhSzapTqbQ/R/TXd9A+uURszIyHrlqRKxA1LjjRiLwq
         UaY8VBTr0/jbmdBfIN3X9HJwMIBWDhc5/BQ2dF8DFaROrcvkOUbzROuG+chV9gHDjm4S
         pluA==
X-Forwarded-Encrypted: i=1; AJvYcCUcILxP5CWd2BCPV9dp4nukylAgMdlKjdnkJUWE/bvCRjY4tARxBNwTiPV8iE6QdOLSVKmXEsp3emLb5tl89g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxgQoL6RO0Q7U0VUIGbcfuo/cVK5/xGr6MK1dS3F4y5VqhqVXfC
	ra6Q6gPixkSzlLhDZ0WHfEMqcFo9EcexBPVzU/iICPYE06fCNkvoYrDeiT995GhC310yO1Bf2V6
	gSnfWUSd8zgoN09VRJrzkS1uqKft/eAI4pxJwRjc9XH5xKv+JAd3OOm8sb9/p6ChVTyspadxaJy
	TXn4I=
X-Received: by 2002:a05:6830:6dc5:b0:718:83f7:9875 with SMTP id 46e09a7af769-71a1c1c73ebmr3765381a34.1.1731445315243;
        Tue, 12 Nov 2024 13:01:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP6e69f0/gmTt/8CcCYYQyUpNYOQNiDkqnm2OdfCSY9FzVz9MST8wwnENJwdpKjXTonJjqTQ==
X-Received: by 2002:a05:6830:6dc5:b0:718:83f7:9875 with SMTP id 46e09a7af769-71a1c1c73ebmr3765370a34.1.1731445314909;
        Tue, 12 Nov 2024 13:01:54 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a5fe6381bsm69536a34.15.2024.11.12.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:01:54 -0800 (PST)
Date: Tue, 12 Nov 2024 14:01:51 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V3 vfio 5/7] vfio/virtio: Add support for the basic live
 migration functionality
Message-ID: <20241112140151.3c03ff98.alex.williamson@redhat.com>
In-Reply-To: <20241112083729.145005-6-yishaih@nvidia.com>
References: <20241112083729.145005-1-yishaih@nvidia.com>
	<20241112083729.145005-6-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _5ctKO7tdZSPOj8CJTroT-o5ZrMIs0O6UephhrFr7a4_1731445315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 10:37:27 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:
> diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
> new file mode 100644
> index 000000000000..3d5eaa1cbcdb
> --- /dev/null
> +++ b/drivers/vfio/pci/virtio/migrate.c
...
> +static int virtiovf_add_migration_pages(struct virtiovf_data_buffer *buf,
> +					unsigned int npages)
> +{
> +	unsigned int to_alloc = npages;
> +	struct page **page_list;
> +	unsigned long filled;
> +	unsigned int to_fill;
> +	int ret;
> +
> +	to_fill = min_t(unsigned int, npages, PAGE_SIZE / sizeof(*page_list));
> +	page_list = kvzalloc(to_fill * sizeof(*page_list), GFP_KERNEL_ACCOUNT);
> +	if (!page_list)
> +		return -ENOMEM;
> +
> +	do {
> +		filled = alloc_pages_bulk_array(GFP_KERNEL_ACCOUNT, to_fill,
> +						page_list);
> +		if (!filled) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +		to_alloc -= filled;
> +		ret = sg_alloc_append_table_from_pages(&buf->table, page_list,
> +			filled, 0, filled << PAGE_SHIFT, UINT_MAX,
> +			SG_MAX_SINGLE_ALLOC, GFP_KERNEL_ACCOUNT);
> +
> +		if (ret)
> +			goto err;

Cleanup here has me a bit concerned.  I see this pattern in
mlx5vf_add_migration_pages() as well.  IIUC, if we hit the previous
ENOMEM condition we simply free page_list and return error because any
pages we've already added to the sg table will be freed in the next
function below.  But what happens here?  It looks like we've allocated
a bunch of pages, failed to added them to the sg table and we drop them
on the floor.  Am I wrong?

> +		buf->allocated_length += filled * PAGE_SIZE;
> +		/* clean input for another bulk allocation */
> +		memset(page_list, 0, filled * sizeof(*page_list));
> +		to_fill = min_t(unsigned int, to_alloc,
> +				PAGE_SIZE / sizeof(*page_list));
> +	} while (to_alloc > 0);
> +
> +	kvfree(page_list);
> +	return 0;
> +
> +err:
> +	kvfree(page_list);
> +	return ret;

If ret were initialized to zero it looks like we wouldn't need
duplicate code for the success path, but that might change if we need
more unwind for the above.  Thanks,

Alex

> +}
> +
> +static void virtiovf_free_data_buffer(struct virtiovf_data_buffer *buf)
> +{
> +	struct sg_page_iter sg_iter;
> +
> +	/* Undo alloc_pages_bulk_array() */
> +	for_each_sgtable_page(&buf->table.sgt, &sg_iter, 0)
> +		__free_page(sg_page_iter_page(&sg_iter));
> +	sg_free_append_table(&buf->table);
> +	kfree(buf);
> +}

