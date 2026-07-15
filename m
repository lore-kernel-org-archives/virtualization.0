Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8452EEE80
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130650; cv=none; b=ecCgvK8gh13qdIs5rJzCWAwpSBpZedQR+yRa+i8KOJRSJu8m8wTCCp1JqDV6PqgP9ZPp7KRyiG4lBYBD3U+jh5ctP6MJyCjxB93BRp2648/4xezHcYQJJ62sd37RiRy7CrXRSiX1WiDPTq7iSoGceIx3lKvFZ84Wq8o7xw0ahag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130650; c=relaxed/simple;
	bh=LHK/h0jlYYgt64s5qvS++l4vkfvf6EbWr3VKP/sRdxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j3pA7JbP1hwEAoO3WAweVIdrIncR/R8R+VX5+PkR+OxUTnbuK0C5mT7Gitn8Zoo1NsjgutOKE7qjJEgQskaexxqSGj21Pf8c6MIO1yKqbQBysHQvOlqRR1bF4P/kdBeU/T0tM3CEyv2FeFY2mmBR4WkBH+CI1G34GkRYtzS0Wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JX3D3Zxi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX3D3Zxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784130647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mni4VjY2tUXuoqxcvmSaYl6Cq9LKNjDkA1J/Ott64Og=;
	b=JX3D3Zxier56aR/NKlZRE989MhizMfVvvRSCCin16hPbdN8Ejoa0I4o96VCMT+MMPYc/hV
	J/AT5f1rCavISg9RoHOv2eDB0EYSP1KnSp3YxvzueATapVe/48Rg2pkn9a3aCDfj9Okrtp
	RAalXuknDKby9jwkgc098+/vr0hEmCw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-fW2nhV9oPji3_OLQf0NxHA-1; Wed, 15 Jul 2026 11:50:46 -0400
X-MC-Unique: fW2nhV9oPji3_OLQf0NxHA-1
X-Mimecast-MFC-AGG-ID: fW2nhV9oPji3_OLQf0NxHA_1784130645
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47dfc23ac71so4508407f8f.1
        for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784130645; x=1784735445;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mni4VjY2tUXuoqxcvmSaYl6Cq9LKNjDkA1J/Ott64Og=;
        b=tOin3C2CKMdqMtIbnqelqZOwnJO5GbrRi9JSV3btm+bI+AdTrCbC1VRy7hV23Wthdc
         M1dE7KklOw6m8eo7JpjGYXoMwUnGUVqaFEKFaldPhr3Oy+DdlK9OgkHGucrkAjv6XmxY
         tihnWqGuerEpPAQsFRG18uMUH4kt32QhzCfrzG43UKL3JbwASoc6c3s4nE4a0to6FOHY
         N9Mq8ldocKdQvJ4fnkMc6/TdWS0naq5mhSZhoysJvB47xPRdkloo7yDVJUqpnmj9Tre3
         pECveVmcA/HGk5WWeVVsZqY83C5vN7Cv6rnufAl+ZQwbJXxtc3dDZ5tXa8kEr39eXG0B
         D8aw==
X-Forwarded-Encrypted: i=1; AHgh+RrIDNy+9CfdqlDOnWnMWyIwTMpQnlpArse3LI/+2qcwIk3/NCuBkZ2hIp8j2Ke/zMaVrpJFMojj/T3eE7s1kA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywd/q7LZOjG2TfIUt8atfCIEv/oOnvkiizn/+9w/GPlJ1n32+Gc
	5RkH2+3Vxo8Te9tYERF022zZ2AhP26OJaZJx2DofBlvF9LtK1FOxeNatHZ4XPDIDKEeGCZF4OBy
	GoQmPMEB0Qo5TqmDq1gwdV5Pzmk8CNVz15lI4Iv3AcgBk9BxopcHC3xPsfeyHCyubXe2C
X-Gm-Gg: AfdE7cmfR8vKOaRNWwDSiSK8r5Sjcz24I10rmpyoaC3ffemqzuWQmR7ff5OoLqnmR/x
	pYrAK4IRAqRTzgUn253LkN8MTZyYj9aSne2e0lCDHVbLelBNvT/CBHk1BZVCX7endNSHRQwau1/
	DZNWBqtr54rAoefJjPVqePhUH0C6yoS58zGayuxWp2cogI3MaZsjsDlqztuYP79/D3tSLU/o0MR
	mxryFsuaWhwiNEWNXXK/tDUZPFLEkJ3JKb5qfj9D7dtS68a1JT5C/6Vg80NAp9T28fggc3U+ddm
	YdnjOIbD5HEg+MGVyvY/nENnSLuHsZrJrnJwKnGv/ozkzltxhQAZ6DeqBfCDgWZKHs7KIGVfwGC
	gfMUgvo+/kezHkwKXQQP8kzKmquHi4Lt3728=
X-Received: by 2002:a05:600c:46ce:b0:493:b811:e549 with SMTP id 5b1f17b1804b1-4951830a532mr99082305e9.29.1784130644838;
        Wed, 15 Jul 2026 08:50:44 -0700 (PDT)
X-Received: by 2002:a05:600c:46ce:b0:493:b811:e549 with SMTP id 5b1f17b1804b1-4951830a532mr99081795e9.29.1784130644279;
        Wed, 15 Jul 2026 08:50:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a33a926sm147346705e9.15.2026.07.15.08.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:50:43 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:50:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hari Mishal <harimishal1@gmail.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 2/4] virtio_input: validate device-reported multitouch
 slot count
Message-ID: <20260715115018-mutt-send-email-mst@kernel.org>
References: <20260715142337.22811-1-harimishal1@gmail.com>
 <20260715142337.22811-3-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260715142337.22811-3-harimishal1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2aEyZZ5SCoeERimOwJl-DnCh1oaNsc9QKlc6xrcrJDE_1784130645
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 04:22:41PM +0200, Hari Mishal wrote:
> nslots is derived from the ABS_MT_SLOT maximum reported by the
> virtio device. A device could report a bogus maximum (e.g. -1)
> making nslots = 0, which input_mt_init_slots() does not reject;
> it returns success without allocating any slot storage, silently
> leaving the device registered as multitouch capable with no
> backing state.

So let's disable multitouch instead?

> Reject non-positive slot counts before calling
> input_mt_init_slots().
> 
> Assisted-by: gkh_clanker:t1000
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> ---
>  drivers/virtio/virtio_input.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
> index deec24e8e682..2cc19782cdd3 100644
> --- a/drivers/virtio/virtio_input.c
> +++ b/drivers/virtio/virtio_input.c
> @@ -312,6 +312,10 @@ static int virtinput_probe(struct virtio_device *vdev)
>  
>  		if (test_bit(ABS_MT_SLOT, vi->idev->absbit)) {
>  			nslots = input_abs_get_max(vi->idev, ABS_MT_SLOT) + 1;
> +			if (nslots <= 0) {
> +				err = -EINVAL;
> +				goto err_mt_init_slots;
> +			}
>  			err = input_mt_init_slots(vi->idev, nslots, 0);
>  			if (err)
>  				goto err_mt_init_slots;
> -- 
> 2.43.0

