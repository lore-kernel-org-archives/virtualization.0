Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028B33EC
	for <virtualization@lists.linux.dev>; Sun, 20 Jul 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753028004; cv=none; b=ZryaWlUyBgHoObwUwZoGENRuEtByXFzuVVwgdszZxr+QY5XNERQoEpohmfpiPfHCff8D1FPFx1ZqcjAp3YLAXXiatqzjoHoeM8dqQiyuTeve5I5i+X4IPlJqa36sQGSeaKjnCQP4d+4LQ+smaXrT+blXr+HaMJB9yotG7Ruy50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753028004; c=relaxed/simple;
	bh=waHBK/dHOhY61lgCppPc1hC3CKS8KkMfCExvaN3qBfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MrwS+yURbLA0g78DeJwaSv8gIa1gayfbcfX6en+qVDHzTfB88g9+Ine6rPUy6SHTbkuYnR+krgiiQ9Aaw2QIRNiCXWRkdXM55G+QPe9QL5nIW1rAoIY7JW0+3lPGdGsJ5lL06TS+9XRmYCKPQR8IGVPAeQz4fFW6ApYY/q7C2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnDhFWoF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnDhFWoF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753028000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Jj3apqxe+kr9fcNoPVcjrR+Gq4Oua7cDA/qKij4XC8=;
	b=JnDhFWoFpB1LQgegSDbzQB4oQThem0qd6xOU3ROiKfJBaXd/7t2IWvJbU5DVr064cDbatg
	DjPCHyHSjzrSn/hUAWChnI7Ejk7WAZIR9oPx3+w13qI/s+Cig71k41a8fgoSe7gPTB/sb7
	QBZ6a8qNb90XvDPUyKIm+2LSOhPUNHE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-A4Vnky_jM6OhC-oGWkcYBA-1; Sun, 20 Jul 2025 12:13:18 -0400
X-MC-Unique: A4Vnky_jM6OhC-oGWkcYBA-1
X-Mimecast-MFC-AGG-ID: A4Vnky_jM6OhC-oGWkcYBA_1753027998
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fd3aeb2825so120046126d6.3
        for <virtualization@lists.linux.dev>; Sun, 20 Jul 2025 09:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753027998; x=1753632798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Jj3apqxe+kr9fcNoPVcjrR+Gq4Oua7cDA/qKij4XC8=;
        b=VUonHUDAuapZBEWdz9gLz0U6hO+dgCLIi4+GTLgW4mooYeKgmwFkc0v1zOHRc9dm7B
         H8ICuBcC1nLoA/s7Y2oOmeL/0/Nrp/6bHYnHNKVrByhxe6iEV67VjMDWK3Ns651BEB5L
         ZemRH284ximIwcEmGBDFAbTp+zNkhtjvZOvjhw5+uqZsc9GmrKpgpXsI5JyFGyecuDQz
         dBS4wCpmPaytLtfGZEBJztDCs2s1KFOvtbwZLEgemFOws/CQmY5lTExD9uPVBCaKn1Vr
         HvfSrY6L0dcp7b3HVx3cNQ3CEBPt9dWFOIg9bYznof9uuv9gkGTxafLun1m3YwLPLp3x
         9Qgg==
X-Forwarded-Encrypted: i=1; AJvYcCU0E2wAHgQfO4sfRdoKapBqDyYFTpm1H6fU3Asj4tfHlFf054gFh8eYQdPIB5xGqryrmcooPHK0w30C5nRFvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGCE8YLXDElwDaRCRfH049+tPEe2BDcHvfeiPQAISj5Y9uw+PJ
	vO9H/0YW5YDhCSvz8TJ5ZEtIo4sbwJNw04Cad54QnBQGkoSmlHjt5k0wrElW4qKFcHwhoEcMZyt
	DSwfpae0hTUaQ53ciAfe0duTa/tuzBU/rlSKEkhUrH9OheZ9tOYYr0l97qybaNCmxb/um
X-Gm-Gg: ASbGncsCEyjo6hAfRHZSLxxj0plbr+uAEOGhiLlbPLskiQbU9AxU3cVc07ZE4grmcsL
	mhenwV/XzY/Tws3/AQ8fXrhxKsy/LEjJ6JZzcpOL+qc8vAXdIiE8i4ZCqJB0/ylvL4A+2cZw+td
	WcbDZRNv2BjnyC7lD7uciiM/Kibx6oOyFZL0D3KI82eG1tAVpMwFIAngH2t7Q9UZbZUpVtHmNGv
	BqLiY/2ehEYYdvV1Nwt+zVPAhuc5hqmK0xYbXgTPM9N/j3wNVn+zKE0R12tr49AWipbNmDf0aWo
	C78i+uZtWii+1RsO0tLNDw37TDH2gQE=
X-Received: by 2002:a05:6214:5195:b0:704:7dbd:5d90 with SMTP id 6a1803df08f44-70519fc9cf4mr124408926d6.9.1753027998113;
        Sun, 20 Jul 2025 09:13:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6LiE8pkS62bIaBTVjt45PmxaYTrc0y1TsJte7EO3rbVHjyeTl3+MgHQg0Hafie3fbwQjvdw==
X-Received: by 2002:a05:6214:5195:b0:704:7dbd:5d90 with SMTP id 6a1803df08f44-70519fc9cf4mr124408646d6.9.1753027997715;
        Sun, 20 Jul 2025 09:13:17 -0700 (PDT)
Received: from redhat.com ([185.187.243.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90616asm29643326d6.35.2025.07.20.09.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 09:13:17 -0700 (PDT)
Date: Sun, 20 Jul 2025 12:13:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Nikolay Kuratov <kniv@yandex-team.ru>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>, Lei Yang <leiyang@redhat.com>,
	Andrey Ryabinin <arbn@yandex-team.com>,
	Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH v2] vhost/net: Replace wait_queue with completion in
 ubufs reference
Message-ID: <20250720121256-mutt-send-email-mst@kernel.org>
References: <20250718110355.1550454-1-kniv@yandex-team.ru>
 <20250718230356.2459-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250718230356.2459-1-hdanton@sina.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ax8v06DZxT9B9dRCG-dVD3xMO05c2ut8kAo6DtLwEzE_1753027998
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 19, 2025 at 07:03:23AM +0800, Hillf Danton wrote:
> On Fri, 18 Jul 2025 14:03:55 +0300 Nikolay Kuratov wrote:
> > When operating on struct vhost_net_ubuf_ref, the following execution
> > sequence is theoretically possible:
> > CPU0 is finalizing DMA operation                   CPU1 is doing VHOST_NET_SET_BACKEND
> >                              // &ubufs->refcount == 2
> > vhost_net_ubuf_put()                               vhost_net_ubuf_put_wait_and_free(oldubufs)
> >                                                      vhost_net_ubuf_put_and_wait()
> >                                                        vhost_net_ubuf_put()
> >                                                          int r = atomic_sub_return(1, &ubufs->refcount);
> >                                                          // r = 1
> > int r = atomic_sub_return(1, &ubufs->refcount);
> > // r = 0
> >                                                       wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> >                                                       // no wait occurs here because condition is already true
> >                                                     kfree(ubufs);
> > if (unlikely(!r))
> >   wake_up(&ubufs->wait);  // use-after-free
> > 
> > This leads to use-after-free on ubufs access. This happens because CPU1
> > skips waiting for wake_up() when refcount is already zero.
> > 
> > To prevent that use a completion instead of wait_queue as the ubufs
> > notification mechanism. wait_for_completion() guarantees that there will
> > be complete() call prior to its return.
> > 
> Alternatively rcu helps.
> 
> --- x/drivers/vhost/net.c
> +++ y/drivers/vhost/net.c
> @@ -96,6 +96,7 @@ struct vhost_net_ubuf_ref {
>  	atomic_t refcount;
>  	wait_queue_head_t wait;
>  	struct vhost_virtqueue *vq;
> +	struct rcu_head rcu;
>  };
>  
>  #define VHOST_NET_BATCH 64
> @@ -247,9 +248,13 @@ vhost_net_ubuf_alloc(struct vhost_virtqu
>  
>  static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
>  {
> -	int r = atomic_sub_return(1, &ubufs->refcount);
> +	int r;
> +
> +	rcu_read_lock();
> +	r = atomic_sub_return(1, &ubufs->refcount);
>  	if (unlikely(!r))
>  		wake_up(&ubufs->wait);
> +	rcu_read_unlock();
>  	return r;
>  }
>  
> @@ -262,7 +267,7 @@ static void vhost_net_ubuf_put_and_wait(
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	vhost_net_ubuf_put_and_wait(ubufs);
> -	kfree(ubufs);
> +	kfree_rcu(ubufs, rcu);
>  }
>  
>  static void vhost_net_clear_ubuf_info(struct vhost_net *n)

I like that.

-- 
MST

