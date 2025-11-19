Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DF350D41
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550263; cv=none; b=XSzp4i9IvNfKAWP9dgXoJ/QOIdyDCRQT5cJLPZKD4Kd+ehHgkUr4aa2KGeXw+E0skPD1Jpb/cYpGrHlDSyPffyk+99O1iznG/iX46hU6Roy5Uq3EK2OlzTtpg/p4UliyFc5i1zTq802jQVD0DNCZdXiBxrdID/2jAi+itTtGFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550263; c=relaxed/simple;
	bh=Or/iFwMt+BMeSO1coYhZawNSolBDuL6LbxtDXCET8WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+bS35lg4OQaGzOYPlP6bEk796dbiqun1u1v/jmzOUvUHWWuHkLy5TR5pN0SC8o0403G1ppXrqtOPFWG38sw/w7NLNR7A23JZtCWXTNbO0jZR4bKqkp+L4h6pI2FEL4v6EecLmQeDQ6xhm0kO1Iok0sHtycc/cHMp6TsvyKlkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSK8lr9n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSK8lr9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763550259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKuBd2HW8nRsL/d/yhqkB0zqQvQiI6NwLHvu1csy0yA=;
	b=dSK8lr9npSaTa/Na3198J8n4N4hUGJMPo5aLQV0wloGuXRDh3oSnnRIBxCASQb4xTngw3e
	MvUIgTB2hz08VdO60N2wI9nN8NzUgNXH9K5fFFOP5crE8ertvju0VF0wnMau8D+3LrVKdu
	tZGkYd8KepZ87RU2v8AXvNWpGY1DliY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Bnk4mPjWMKGI_oFa5Yo6tQ-1; Wed, 19 Nov 2025 06:04:16 -0500
X-MC-Unique: Bnk4mPjWMKGI_oFa5Yo6tQ-1
X-Mimecast-MFC-AGG-ID: Bnk4mPjWMKGI_oFa5Yo6tQ_1763550255
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso3612484f8f.2
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 03:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763550255; x=1764155055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKuBd2HW8nRsL/d/yhqkB0zqQvQiI6NwLHvu1csy0yA=;
        b=jiRmoz+Y0YFhqML8lLceXt4OTeqxbHM2TV1kRwwcnYXnuVzrZUehR1x25odKcJ/mfe
         53XWP5+Ax2iOFJu0k4ySKQwPZWkcjXBL5SMEodBx3YKtQQ7zQrtH4ajgtVYtzR+P5knR
         UwUEj9MZnu1cM9E31eJUYjqgiabFvn/9KJfC/Xj6MI/tBKJkCN3dFMz+n9iUdNMzVLNp
         1VYMYxAUzEH2cpUYQz+2Oy59HGR1XVTFvVm+78OdOXY0pKCDHCUP+GZeyr9ohHgNktY+
         h3aCjsY33pV2x0OWefgT7s6GThtEi7PIrMjw91iD6L3Mk9zfY41jJM2ZTl1UL4iOUqZG
         hqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK0BHOs5laWAJjyqH1IGqZbWMLMUpXsko/kjMNog2XSg+g+2kQ4TxaHJeDz5zsE3PngdMm1N+6EtPmiT9EGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxpnVyb8uW2+EAXKcn+ae+xy69dg4P0UP7h25+6+NM1KED/T+k
	1K4zVRG25QZQzpFyzNYbr6+PidNNYDMSyVm3IcTPjgHvaYTsdgjd3XOYke9lE14bnZ97wogd+SR
	WLmWX9lytSRxRh5QKujd0+b2nF0sqbbZs2VznHw8/1CFo3BiawXO49VIBMRtNT7Q538YX
X-Gm-Gg: ASbGncstElQ/6HcWNC67r1AdzdKLfa2H3+ibyunEnZIF+TuJmFNPRgi80dMyKoqvuyp
	h9sSF+E3JpTrfItF1SJL0SXzGWE/GDUeVhH2IwgTjyBSOAFWt8iG6Nb3ZsXGnuGGkVd2anfpjDE
	FBEfZ6gM7v1H7I+WyLokbgngrx4x5np0BUM9O1wgOvLh/y8vmpOrZvmUPC6OKAT34iR6yRgidc0
	5wUgUI7iudtOqhYI2Ltw6IuXXDKZCjrnfFfHYRrLreFiSMxRmRQ/KPBfyJILvcU/aQ5/jlYDhNQ
	3nDj0W8HNwNfvOHlQp8vBzPwCtT3lK7Fh09j5/PUkDLxlivH55oj/C1cKFQ8sTiigbAYQOa1hIV
	10RiVdRyp49lS
X-Received: by 2002:a05:6000:1ac9:b0:42b:2e65:655e with SMTP id ffacd0b85a97d-42b5935a880mr17671094f8f.27.1763550255278;
        Wed, 19 Nov 2025 03:04:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnOndlVgs3mj8Ki0CtCTtbt0/DkKKE/b2cx4wA0ZToqoDYX1G7zSXdvoOnOMWxyBTwFXC8VQ==
X-Received: by 2002:a05:6000:1ac9:b0:42b:2e65:655e with SMTP id ffacd0b85a97d-42b5935a880mr17671049f8f.27.1763550254851;
        Wed, 19 Nov 2025 03:04:14 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84a4fsm37236036f8f.11.2025.11.19.03.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 03:04:14 -0800 (PST)
Message-ID: <4204ed4b-0da1-407f-84e0-e23e2ce65fc7@redhat.com>
Date: Wed, 19 Nov 2025 12:04:12 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] vhost: switch to arrays of feature bits
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Mike Christie <michael.christie@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <cover.1763535083.git.mst@redhat.com>
 <fbf51913a243558ddfee96d129d37d570fa23946.1763535083.git.mst@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <fbf51913a243558ddfee96d129d37d570fa23946.1763535083.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dDwjQbzynQWvBlXQU2PBfkp2FqBPjKg7NmNTfxsWAGI_1763550255
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 7:55 AM, Michael S. Tsirkin wrote:
> @@ -1720,6 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
>  static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>  			    unsigned long arg)
>  {
> +	const DEFINE_VHOST_FEATURES_ARRAY(features_array, vhost_net_features);

I'm sorry for the late feedback, I was drowning in other stuff.

I have just a couple of non blocking suggestions, feel free to ignore.

I think that if you rename `vhost_net_features` as
`vhost_net_features_bits` and `features_array` as `vhost_net_features`
the diffstat could be smaller and possibly clearer.

>  	u64 all_features[VIRTIO_FEATURES_U64S];
>  	struct vhost_net *n = f->private_data;
>  	void __user *argp = (void __user *)arg;
> @@ -1734,14 +1735,14 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
>  			return -EFAULT;
>  		return vhost_net_set_backend(n, backend.index, backend.fd);
>  	case VHOST_GET_FEATURES:
> -		features = vhost_net_features[0];
> +		features = VHOST_FEATURES_U64(vhost_net_features, 0);

Here and below you could use directly:

		features = features_array[0];

if you apply the rename mentioned above, this chunk and the following 3
should not be needed.

[...]> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index 42c955a5b211..af727fccfe40 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -308,6 +308,12 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
>  	return r;
>  }
>  
> +static const int vhost_test_features[] = {
> +	VHOST_FEATURES
> +};
> +
> +#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)

If you rename `VHOST_FEATURES` to `VHOST_FEATURES_BITS` and
`VHOST_TEST_FEATURES` to `VHOST_FEATURES`, the following two chunks
should not be needed.

Thanks,

Paolo

