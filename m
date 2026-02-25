Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619C329E44
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022922; cv=none; b=GyjnKJaNUMyB8AV8UcK4tgLC86L6kSUu4Hd9m6GvXywN/mH2kQNMQATLaNVefqyH2fcBJ3aT04zBpR9Jk2mA0hEkOTcF53zYmZoYjQEhBqrtJD9D/KaQotb/HVDoxGkKhn7wk5VugPznMAAjfz3N8ecju83kj3mYU9kSH7vAjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022922; c=relaxed/simple;
	bh=CH3LHHiMdtoONBad0iIbbz4lf6piNKIo8bQmtLOKVxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Blsa6xPr7wuFP5C7Vbgs1gDwM5kQNDy7Os9q/4C1M3v+E3VIvXedgqRoxgRbpWwScq20exzJmYJizV96fhHioSH+M58MSUqUIkz14cbIlw07y0HAOqjo7XGnjczKgWf8fTH+9xmEmBtlzkn8ALgar5BtFegVSyBqgSRq+HU6coQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqqsxai9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqqsxai9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772022919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7nRjofDA7RJDcj+NFBdh2tr4w28Tk9uEGBjPh6ATJ4=;
	b=dqqsxai9L7s9khvdOLud0RfsZ/BNhv9yRDbkJCg1e9KEVTSx9/Y3WzQEpSWTDKDa7z6cN/
	uwbwTKqMVNieT0WlHcQ1X+41o3G0glKM/5RNPdzVboTzb+0ASX2JgUUMdYD0XVRqHfpmJM
	dZVwGCkSqHH1Mw358OAvEE+73haY7DU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-vqCpPAnwMHWqwMMwtKoUVA-1; Wed, 25 Feb 2026 07:35:17 -0500
X-MC-Unique: vqCpPAnwMHWqwMMwtKoUVA-1
X-Mimecast-MFC-AGG-ID: vqCpPAnwMHWqwMMwtKoUVA_1772022917
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837f288194so54051285e9.2
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 04:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022916; x=1772627716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7nRjofDA7RJDcj+NFBdh2tr4w28Tk9uEGBjPh6ATJ4=;
        b=dFgfAGj5UeVf675O2bWzX7IG7BL/YafOD2ljRVw9JcJJPQeVFmrvbTtRq6LAr2enCw
         5zn+rdfgacn5aUQZObFlah7f2RIZgLpe7OH9GrNN5BsxHUq9HZPO2LHyK4lzv3vzu8HM
         tLy7tR0yNIq2gkkLrugDajrhkKxXIWjlnb8O5M97C5YydkQSoc2TEHTPHgIE5Qz1RWkG
         rdOpVa+mqmdi0tdL+p5HUc38HuGWGOkjkUQH0Xa2aQPtXByzrxvsX2FHw6Uox/xcIMRu
         TliGBaZsrxp2dQf/9EoNzPZlidc1acqpY3+LBVzPlRluH/IS0afehWHJhTp0Bz+MnFuN
         g/zg==
X-Forwarded-Encrypted: i=1; AJvYcCVC/sDNRdl+Hq/Ov+ROK3cWpwT6RgjvkGGVl0Y43MOVFw0uKT44A0DOwntmTnr3Kft/Wd7cbm8QkYZzTcNZQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywe1eRuX5KMluirr5T8MvZ9uBH4/M8t0LAUXtgQpi+vbGOoisGt
	gjt4moFVFgzLOW18ZHFsAIt7sydt5Merq2rvIYj5I3gnIK0iDbUOvhwhBYKXJ1HVKpEVCrh31cY
	kZrM+yzjZRSSzAyCkSPsjPpe2l4kbiMrwgaoVqmcRDD7gGIyXvcITz/bAnVpNyrmhMMia
X-Gm-Gg: ATEYQzx183HsDpfjE3NIEL0amvq4fNBq/Ic9e/Viyx3eyb5Leiilt1pv4mBZ8j7GLXk
	Ldj1L0DVkqeiw1uq7yaqeSFEBvmsoxUZuBAbMtY4OB6URnTAvGbMkY7IrL2M0c2/oW4WUT2QXFQ
	7Y9TlZ016wJjviGAenT1XVgbeeLKy6xA3sMC/nr9AbtP6S2NlxKAZuawpCjCjosCyVtJ3+vopEM
	IoUfsL8iJ0HWdaXvjxAvcDsdKuqlnkuDocXTVGgLgCfLuVxA0dAV5u3TvgCIEaghvb3cY9wiNo3
	V162w50bwwK1dI656Wwc8+r378UYomEwY+CJPQmOGWsZBUYk7GYBxgDjL+qWaAZY1qqPKLcyWSA
	J1M0y4eggI6U8ZPACMo/HNYOgpGSEOG0eXeCf50J0aXUVLg==
X-Received: by 2002:a05:600c:4751:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483a963df99mr245469855e9.34.1772022916534;
        Wed, 25 Feb 2026 04:35:16 -0800 (PST)
X-Received: by 2002:a05:600c:4751:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483a963df99mr245469355e9.34.1772022916050;
        Wed, 25 Feb 2026 04:35:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm74365755e9.11.2026.02.25.04.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:35:15 -0800 (PST)
Date: Wed, 25 Feb 2026 07:35:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [EXTERNAL] Re: [PATCH net-next,2/2] virtio_net: replace RSS key
 size max check with BUILD_BUG_ON
Message-ID: <20260225073338-mutt-send-email-mst@kernel.org>
References: <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
 <20260225050441-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63742AD7C6599EC81A858427A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225071659-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63746E0AE4CEEB32F708F1D5A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BY1PR18MB63746E0AE4CEEB32F708F1D5A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ESC3daMUl4OaqYBqf27T8B4x1PoV9-czUNCnERxxtvc_1772022917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 25, 2026 at 12:29:41PM +0000, Srujana Challa wrote:
> > > > patch 1 is unreasonable i think.
> > >
> > > Patch 1 is targeted for net, addressing an issue where
> > > VIRTIO_NET_RSS_MAX_KEY_SIZE is fixed at 40, which is only the minimum
> > > required by the spec. This led to virtio‑net probe failures when
> > > devices reported an RSS key size greater than 40. However, the driver
> > > also cannot handle keys larger than NETDEV_RSS_KEY_LEN (previously 52)
> > > due to the BUG_ON(len > sizeof(netdev_rss_key)) in netdev_rss_key_fill. To
> > resolve both issues, VIRTIO_NET_RSS_MAX_KEY_SIZE has been replaced with
> > NETDEV_RSS_KEY_LEN.
> > 
> > but where would driver *get* keys larger than sizeof(netdev_rss_key), even if
> > device supports more.
> In virtio‑net, we rely on netdev_rss_key_fill() during virtnet_init_default_rss() to populate the RSS hash key,
> which uses device supported length.
> The code path is:
> static void virtnet_init_default_rss(struct virtnet_info *vi)
> {
>         vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_supported);
>         vi->rss_hash_types_saved = vi->rss_hash_types_supported;
>         vi->rss_hdr->indirection_table_mask = vi->rss_indir_table_size
>                                                 ? cpu_to_le16(vi->rss_indir_table_size - 1) : 0;
>         vi->rss_hdr->unclassified_queue = 0;
> 
>         virtnet_rss_update_by_qpairs(vi, vi->curr_queue_pairs);
> 
>         vi->rss_trailer.hash_key_length = vi->rss_key_size;
> 
>         netdev_rss_key_fill(vi->rss_hash_key_data, vi->rss_key_size);
> }


Is there a point you are trying to make? disabling features because user
bought a stronger device is counter intuitive. Make it work
in a sane way pls.

-- 
MST

