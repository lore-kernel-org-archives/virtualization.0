Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627208;
	b=0cBmMRvOD6Dnmwy6qjCOEeHTknDKAk+/GP3erjwUtIcJAiaXC/keNQx4UU5PeoL6lTod
	 kW44g3+NfCXkZ9J/UUbDAKH4kDt7yKWrOk68Ow5JJZCQ5uGiuVBITFEW+ELU1nubfYfN2
	 c8uCFLI6RdfcgBwVGjIMU05lA6/hOOqRF3yiC1YjROK82hvemUzWUL/QMxYCaDMmFtSGL
	 oGNApSPOUALq9LC7ha0tWOWW6v3nJoAJexEldY8pm/l1yIuWvebOagNhqgYYE4hd7Hz2i
	 Qe9zIZoO4rFdPES4wjkkAAGWPdgSUt7NjFUXOFnuGATZSVYWQSAKSBv18CbkVOMzNYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627208;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=r00PHjeOPM8EiYAJ4n7o98k3BqG6YD5J3SM4dyyR34k=;
	b=KsQzuXACmae7YjYEWxKOpUfjCw80M5h0OU5i9swledeVv31DqkXbYVnU5H6ooMRIX6UM
	 V6guzqyJbWwQnn5cKNRHJHLBrmGe/vwA/+9KnaPytpnqVbh6jvh1oYqkZSjxuVmy5ObVp
	 p/qcUI78tIn3lTcQHYTEQQ80/9Py5qb68d5IM7eR2+xzDfNUlHRIwqVWQI3TdkpV4aQNO
	 s6mhujJyTV6Ki2NcYn8XfGBlnnvRf7lj3ZA+ULw5KOTbT5hzEVk6jS5M8nR/ZwhTt9DzR
	 YdQJI7iW4tIg8XQNIATjigH9rO30znSqxFBghAwA8SMnvN1+HVnOTbBwhMts5hHfZXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eRRkp8vt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B485606A333
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 13:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B485606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eRRkp8vt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793627207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r00PHjeOPM8EiYAJ4n7o98k3BqG6YD5J3SM4dyyR34k=;
	b=eRRkp8vt79iXwwQiwfLE9putdYqc7l3KrnzQ2Fv9T7oM3NK9JLPficdN/b/iL6DHAyI4Al
	OzC7VelxOtd5aNe+0kuJDQW4evbygg7+z+oZ3ZIJG4dbseKA1EHOFh54cAKyYnvJ+USgKo
	lHjUKs9G//M+PhpSXCgjDeH5po89Ow8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-p0KpgCHeO7aizVmFSVLSBg-1; Mon, 02 Nov 2026 08:46:44 -0500
X-MC-Unique: p0KpgCHeO7aizVmFSVLSBg-1
X-Mimecast-MFC-AGG-ID: p0KpgCHeO7aizVmFSVLSBg_1793627203
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so2555914f8f.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 05:46:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627203; x=1794232003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r00PHjeOPM8EiYAJ4n7o98k3BqG6YD5J3SM4dyyR34k=;
        b=lkvai7tCkPe8b5oZLTAy9VMcRhUi4oM1Dnq9uDR3lRulQzPOoXi8QGuMAXFtll+HIQ
         erpIgqP4R2rVEUBAKWef+r2wDz5BwjyN0RUH4+DXcPwn+z8Hbj1s4o0my2fjxOMhtbq0
         5bqZd3NCXkGASlxn3w3996UPaKeMNNhrh2ed3ksoCbXWZk1Y/rnYfrMHQBq+gjxIz4pV
         iHxMPqkJRHgnstUBC8vDIlrhUKEbCxLPQOLKtYGKQoKBmF42m4Du77wjaB6/SlUS+8MX
         5wUFcasbiGYOj2S3boCTUVUhlHqcPzxtcAeEugoltxqx8R0O2Gw4nnRewVO1/uXEy3ps
         mJgA==
X-Forwarded-Encrypted: i=1; AKwUvBw2iCpiIjN+6tZjr1xlVK9ktGfRAqGpUBg8fTBGiwR9ICsCqotMyncWHOMtoIMx8exV9ZmjnJwrqXDxmCEThQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Ph22+H4M5tshmUBFqQyqDLAmXmgY/PWEoSxvYSvPhEXcB3IEU
	NWIdCLK90I1hN9+9lovuSxqcOmPe/krCrVLV5NkuaKd3oy6pJabL5BQ5Mg1UAX1aoPLecKsv9/e
	/zYsrrysP+goJsZm7oohQ5ytCKVVUOlrnmkNBX3M9OLcCglQsUiQP9A2EuyeuChnoeJm5
X-Gm-Gg: AYBFou0+KVpmWUjzWDOgN+3wR6ZVnL//1LIfTGQK2hOSrq+l4YrNR9ruUxHAU32sbhI
	/98rRrGtccZULKsworQsw/e9fdAKlSeyoZYEvTK0JpqutlfowZsKNSeFh9t/2Q3Pc0u9K5TQ/Kn
	moCX1b9G/hFfcXebTcst+odLFlrjbMfKfEGYF8ANDbBQ9vsfkNUIBSd+y7u5u85Jc2B53nLr71U
	7MiQmmNXNYfezcfIpQd4TVPQe8Qj1PVBn6BzjQ9YkpWvjgy6fooWTtAr/yGPDOqZehG4bhqq8Td
	gaYP4C1VFnS7nb+gkA7nza05iuLIdZbumqsI97+2D5DOxTsAvx2y6k4vjF0Mzvy9n0lC/yN4fJZ
	6R72F7IWHmU5f+Q4jQWDG5LjDifUSMMW3FmSlxN5gnw==
X-Received: by 2002:a05:6000:24c5:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-48e6e4f5798mr24880376f8f.14.1793627202785;
        Mon, 02 Nov 2026 05:46:42 -0800 (PST)
X-Received: by 2002:a05:6000:24c5:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-48e6e4f5798mr24880306f8f.14.1793627202211;
        Mon, 02 Nov 2026 05:46:42 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80333sm21533707f8f.32.2026.11.02.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:46:41 -0800 (PST)
Date: Mon, 2 Nov 2026 08:46:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jianlin Shi <shijianlin11@foxmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, talgi@nvidia.com, hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: Re: [PATCH 2/2] virtio-net: unwind VQs when irq moderation init fails
Message-ID: <20261102084624-mutt-send-email-mst@kernel.org>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <4e21386a0840526578eac3dd10443758bf3b84e2.1790751008.git.shijianlin11@foxmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <4e21386a0840526578eac3dd10443758bf3b84e2.1790751008.git.shijianlin11@foxmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3lJ2oEKVdG1RavTlOd2LYGTv2uGmJPmBi0BSYKlfHMk_1793627203
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2026 at 04:19:52PM +0800, Jianlin Shi wrote:
> virtnet_probe() calls init_vqs() before virtnet_init_irq_moder().
> The failure path used "goto free", which only calls free_netdev() and
> skips virtio_reset_device() and virtnet_del_vqs().  The virtqueues and
> their DMA mappings leak.
> 
> Use the existing free_irq_moder label, as virtnet_create_page_pools()
> already does.  This is safe only after net_dim_init_irq_moder() clears
> dev->irq_moder on failure; otherwise virtnet_free_irq_moder() would
> free the dangling pointer.
> 
> Fixes: dcb67f6a9ead6 ("virtio-net: support dim profile fine-tuning")
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>


I expect v2 of this.


> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d3..ef61097c4404 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6996,7 +6996,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  		err = virtnet_init_irq_moder(vi);
>  		if (err)
> -			goto free;
> +			goto free_irq_moder;
>  	}
>  
>  	/* Create page pools for receive queues.
> -- 
> 2.43.0

