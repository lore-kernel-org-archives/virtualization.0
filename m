Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38DC156F4C
	for <virtualization@lists.linux.dev>; Tue,  2 Jul 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914026; cv=none; b=qBGhdSEXFwG+vBkD9AGuV25HRCaXp/0xBHHHEyaSSre0YJSwLX5gGhiVtzlkFp9KU9BD5yLYq2c2D7MqGQLKn6b6IF8a+mp/x1JwCpwOUIKdPdOoNcjdA3jgTpSGvB8fA2LBUPEmigJb253ec+zy50gd6ygE96jkC715lsZEBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914026; c=relaxed/simple;
	bh=MGSzto/cq3LB0E4ecOkYu6NC/5l/m8jXuofARCe6LEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uFM3T7Mfwc5SMYyO5oPj/O2kK0/VzCPKysMUVh/wiA1oQOisyY7+6Do8/KYB4kO3o8g+Vr/0b/obAjrrd0BlCAB4lRwts0j6w4gKDAYzt4FPaOQzqQSYwQ9l/VPqbMFvXtrpogOS7U+f5t6UjlvGRMrQHbeklrQGhzjHpbkCvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6f/Ifp7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6f/Ifp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719914023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7gbuCbmqaQOZCH0Y2TLfMh3O6y0nrrvSpYLO6jxz61g=;
	b=e6f/Ifp7jlzzh41vq7u3vObNxyu/9SP7bzKi5vQ9ZHvnrwv2YsStcK3bedVWD53Snahimp
	gqz8mxEg9L49fI1YgE2c/KckNRctwuzNfpSsX6NuL108SSEKIsLK/PeUf/M6ZzV8PwzXcQ
	NLTTbPcJHDSeZK1EF+X3UrbjqWVg5xo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-r_uoj33tM3Ov2b2DWl5YeQ-1; Tue, 02 Jul 2024 05:53:40 -0400
X-MC-Unique: r_uoj33tM3Ov2b2DWl5YeQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4464caaa6f2so56518911cf.3
        for <virtualization@lists.linux.dev>; Tue, 02 Jul 2024 02:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914020; x=1720518820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gbuCbmqaQOZCH0Y2TLfMh3O6y0nrrvSpYLO6jxz61g=;
        b=itR9eiwOOKlv9GxwzzEuhqjFHKiUoU0old3JLw1p0SVPNWN/2MK3xWf4tZAK5mJeOi
         Vj4tVxyoyih0w4Og7ub2wrqZYscMI87zl8/oB+qOOsxJPHMtVRckvgPikoLCmNqQFEg+
         VA61togrtb8CmQOQ+PjA4Fpyic6k0spFY8TNJNUYfe07q/iNs5JTRVKl2GQxtFniDyC2
         UUlG0Lr0liqb69Ul4xXqUYA60uzXEqveyw2fP4kImM1N6asq2USnpzwezNP/sgHzRWJ8
         y891+viuyIGfMOv+uwS857CSlj0+S82XXC8C2a9fUNXDE/SUfthpxzMFHy+EW65ufTpk
         cGBg==
X-Forwarded-Encrypted: i=1; AJvYcCXhbvoDl08GY6a7Mk5JE4F8saERh5yPo7qm0XO4HzPOfMNxP161zG1DX5GUUknYe/c93PtGeoO7k19CR/8FNYOFVntPVkVp9liB7Vk3DKE=
X-Gm-Message-State: AOJu0Ywace+TxaTjSOKnt0XI4q1VyqxJd/P+OP0vMUalwpfqeObs2qEa
	2najownH2utNhWtUbrQIHeuM07AeIuygNngLNsi4DuUcw1+XQYiIVHf7fcA69+pvsKakzDDd+1k
	hxrMqcdVgkFcolvmupQrRhj74zUUFx+SU1qth6m1Pc/beTQ2LPZm49bgbyaFcA2FN
X-Received: by 2002:a05:622a:1a9b:b0:43a:ac99:4bb5 with SMTP id d75a77b69052e-44662e9743cmr109715731cf.51.1719914020146;
        Tue, 02 Jul 2024 02:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCcQNmIPoKc5Qmxn92R19gzUW4REeysnZ+oNphjyAhLmalfFvXnVJlo/R+c80Iq9xcgNw8ug==
X-Received: by 2002:a05:622a:1a9b:b0:43a:ac99:4bb5 with SMTP id d75a77b69052e-44662e9743cmr109715461cf.51.1719914019651;
        Tue, 02 Jul 2024 02:53:39 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.133.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514b2484sm39462531cf.81.2024.07.02.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:53:39 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:53:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: devnull+luigi.leonardi.outlook.com@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marco.pinn95@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH PATCH net-next v2 2/2] vsock/virtio: avoid enqueue
 packets when work queue is empty
Message-ID: <e52cj2hjqmx5egtvnkqua3fvgiggfwcmkcsw3zswbey5s4bc4p@qp3togqfwgol>
References: <20240701-pinna-v2-2-ac396d181f59@outlook.com>
 <AS2P194MB21701DDDFD9714671737D0E39AD32@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <AS2P194MB21701DDDFD9714671737D0E39AD32@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 01, 2024 at 04:49:41PM GMT, Luigi Leonardi wrote:
>Hi all,
>
>> +		/* Inside RCU, can't sleep! */
>> +		ret = mutex_trylock(&vsock->tx_lock);
>> +		if (unlikely(ret == 0))
>> +			goto out_worker;
>
>I just realized that here I don't release the tx_lock and
>that the email subject is "PATCH PATCH".
>I will fix this in the next version.

What about adding a function to handle all these steps?
So we can handle better the error path in this block code.

IMHO to simplify the code, you can just return true or false if you 
queued it. Then if the driver is disappearing and we are still queuing 
it, it will be the release that will clean up all the queues, so we 
might not worry about this edge case.

Thanks,
Stefano

>Any feedback is welcome!
>
>Thanks,
>Luigi
>

