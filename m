Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F92E36AB7C
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279880; cv=none; b=N3viSLe3lxOcpS4lIWZh5iM3nDoSdjNwOv2L7NiAeUfalsqdf4eYo0x4OdC1SntHGT+SuYfUEDDUkPOBgcG5bj/L/fdzRxFrJdYjCrLHVYE/UvbTgVO9YwmQqaYn+o+0hawFnXij5i59+XYO4rsgKbhmMXlmeh+ZMrOQxIq0KkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279880; c=relaxed/simple;
	bh=opKalTvfBSXyILj0RJsThfYwW8d3Q9Qy1589DrgLROI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hM0mnHgMfNxKrRZeKlxu7YWQe9Ml46EU6aH3GOaIuCLHBM+S1U/Os2S47mJWoDBPkTZjamKPRSDp/QL64gcSU56itqTqUxg26LA4RWtxbQOyONfjMdGe32REY8VX9qiy+Fag29STg0WnQ21j/8AOPuYln+YHASGk9dbjDdOzUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q90GTFhQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q90GTFhQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784279870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3388yjdx5mxv0Xwh51fsD72bz8HgdGVi3PgcMelqQI=;
	b=Q90GTFhQiQvgd059GZi8Dx/e8G7Or0Ue4s5se7j5AphKXjhzV7D90ck40rOlTOaejWzT0R
	JVAqVhnSxqpKAyGHZ7Yynpr7tw6Fl8f8+oEj6ySgt4xYOXK4EcuJ3+/A1qNHOAoF5nXFLA
	Iih/Zq9vYWEeTUIyw6f+5ru9Zr11gCc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-xzmiFebBNz6ElJn7uZlOYQ-1; Fri, 17 Jul 2026 05:17:48 -0400
X-MC-Unique: xzmiFebBNz6ElJn7uZlOYQ-1
X-Mimecast-MFC-AGG-ID: xzmiFebBNz6ElJn7uZlOYQ_1784279867
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4729d2a64efso798703f8f.0
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 02:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784279867; x=1784884667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3388yjdx5mxv0Xwh51fsD72bz8HgdGVi3PgcMelqQI=;
        b=TralFa5ex9jf6ZmaJYQJ1L1fr9znKUOVo4gOSq+wj+dMIE7PpzsNrceFTxd3gutz/D
         6fp+SctHs6jUrbAodmvB7/qCnfp6LqcrmWKusYO3Ui34yELA1d6TiQsQ0c0iD0A65EW8
         GmvqbUinR8+JYn921OAQVYmJ5ZIl2BdAzBl+NM0+LiXpCUjDEZgqF1nuyR3jvxti2XOA
         iuvFUAyPd7PgAsizcHIxlzTUjaY0WcDZqCNfF1ZwIXAykeMS7JGlrMAIYEW3wv9uPSDE
         Xj2amSXsKK7uq93jx3Jk+zD+dcNQzifwiF/FB2OpR3Mod43Pchl9AFYxlJNTHurElNm8
         DaMA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8WX7uSJtni60eooklIS+IGKCI9XMdnDyePF3hqJpVC1pi/sKA41P2zexINaTrn0Bslz0nAQHD5kQoludXGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+vLCZb3vRqfC/2HYuNWqyin2nh4A6Gp7YcR3p7IDi4e1p6Yzg
	/mQtkZnCDplChAKh5nK6rWIKadp5T6V7XGon7CBtUejiBozRVvVF5dKLqN+hCJEhillojONLOKk
	EXrhw4TvKTk0tq33WnIW64BaWfBpkcQe/Yl6u0+BjewkL7Aqiey5YwnVWGCP73ZN8yS0i
X-Gm-Gg: AfdE7cmVJoa34K6RdAsB8JuK2cMNVDKUc9dbOyzTuJWdbZkjIPXqz2PW9bDZYc3UDKt
	VRw0wWObAGyrXRchLTJkG0qUrITqDzLR3aNBlSenRUuco03993kGVLUekW0h5/bK1YsTI4TQMBL
	RnQ5xV83mMcqoVnrJoqdlT92+3v+V1pS5qnqtPU6x5tZL0jwsT5DsRZod9cnxZuYvS3D6h/M68j
	VhsxtigY3nc3YZXxl2fnO+KhNUbf5fTd7Z29/JabCpNRnmUTUsMdmXFh9b90+U8LrpVI5yE3Xlh
	83IoeUXhSjhvNNKizJOnBJL6G7xhcSq2Ad1ZuKy8EqeYDYTkkB7RKTZKT6mMBq0DuAUj62Cpve1
	zVMfyztaHsdbtNprvcjutfBrC
X-Received: by 2002:a05:600c:a210:b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-4954a341bcdmr11164555e9.18.1784279867108;
        Fri, 17 Jul 2026 02:17:47 -0700 (PDT)
X-Received: by 2002:a05:600c:a210:b0:493:c566:7bd6 with SMTP id 5b1f17b1804b1-4954a341bcdmr11164265e9.18.1784279866477;
        Fri, 17 Jul 2026 02:17:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm30866345e9.0.2026.07.17.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:17:46 -0700 (PDT)
Date: Fri, 17 Jul 2026 05:17:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Link Lin <linkl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, prasin@google.com,
	rientjes@google.com, duenwen@google.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, Ammar Faizi <ammarfaizi2@openresty.com>,
	jiaqiyan@google.com, ahwilkins@google.com,
	Greg Thelen <gthelen@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com,
	stable@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/2] mm/page_reporting: use system_freezable_wq to fix
 UAF during suspend
Message-ID: <20260717051734-mutt-send-email-mst@kernel.org>
References: <20260717002311.681748-1-linkl@google.com>
 <20260717002311.681748-2-linkl@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260717002311.681748-2-linkl@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -EJIh8trR5YcxB1fpZgSt_H3Fd15T8AexzjWjOVPgzQ_1784279867
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2026 at 12:22:20AM +0000, Link Lin wrote:
> During PM freeze (e.g. S3 suspend or S4 hibernation), device drivers like
> virtio_balloon reset their underlying virtio devices and delete their
> virtqueues via vdev->config->del_vqs().
> 
> However, page reporting work (page_reporting_process) was scheduled on
> the global system_wq. Because system_wq lacks the WQ_FREEZABLE flag, the
> PM freezer skips it, leaving page_reporting_process active during
> suspend. If pages are freed into the buddy allocator while suspending,
> page reporting invokes virtballoon_free_page_report() on deleted
> virtqueues:
> 
>     [  196.795226] general protection fault, probably for non-canonical address 0xaa1436fe70dae6df: 0000 [#1] SMP NOPTI
>     [  196.825967] Workqueue: events page_reporting_process
>     [  196.831038] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
>     [  196.927073] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
>     [  196.946943] page_reporting_process+0x370/0x4f0
> 
> Fix this by switching page reporting work to system_freezable_wq. This
> ensures that the PM freezer pauses page_reporting_process before device
> drivers destroy their reporting virtqueues.
> 
> This aligns with the driver's existing design. The comment in
> virtballoon_freeze() states:
>     /*
>      * The workqueue is already frozen by the PM core before this
>      * function is called.
>      */
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Link Lin <linkl@google.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  mm/page_reporting.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 7418f2e500..4dc6f4b852 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -80,7 +80,8 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
>  	 * now we are limiting this to running no more than once every
>  	 * couple of seconds.
>  	 */
> -	schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> +	queue_delayed_work(system_freezable_wq, &prdev->work,
> +			   PAGE_REPORTING_DELAY);
>  }
>  
>  /* notify prdev of free page reporting request */
> @@ -343,7 +344,8 @@ static void page_reporting_process(struct work_struct *work)
>  	 */
>  	state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
>  	if (state == PAGE_REPORTING_REQUESTED)
> -		schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> +		queue_delayed_work(system_freezable_wq, &prdev->work,
> +				   PAGE_REPORTING_DELAY);
>  }
>  
>  static DEFINE_MUTEX(page_reporting_mutex);
> -- 
> 2.55.0.229.g6434b31f56-goog

