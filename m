Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C30A54908
	for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631123; cv=none; b=X1lKMkoE2V3Km06H8w1HQf8HScSg/yucwp5SVBwVI9sWwQ4F3UJDKxsirzFnV5IlZr6309dwwYJNZ5sOEK/aLxW/SIkO7n0l4k5ZhbnhJ4zSo3HCgUgUuToAVUh0hqfds00Ux5v1Cf5NW+QrLbjP7Vn/is98+RK3wu1GE2OS828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631123; c=relaxed/simple;
	bh=oLWpUQzEDg1YWW4cOetAqNAPnhZ9oahsEaWv5ozR+LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nxU2+MfBxk0c/W864tX3WuBhoUg0WFvRxQcGiEAB34CPrVnp6gAVqJ4/ShEC9g+1Frld5bAZg+fPYaG1og71Fw8BGIu3qXIP1Ra53At0/Xb22nDx0uODqObtxWvHiF+TosI9sjGb5avbPOiHaFHhnuLPZQaGSeE8iXcCa3q2qeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hc+lo3YP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc+lo3YP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708631121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HtS3rO3/k4CHxBCems7dZZwyABPFlcoiWlBHvKoMPuE=;
	b=hc+lo3YPYXQCgIoFqv1hLE99FItqhLJWJ4drt2G7RsdVflHGNqv8ti7D99OHZO+y6EtyFH
	RNYZ1N79Hobart6eZfT231hSHlttoKMdGZgG+g41K9ABC/OOD8FVtZFXyg4ZjihPmMAANO
	DQNe+Hx92qBgBd9kA97y2y3kvRIqYME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-TyBIinW7NfqRs2FFVW5pXg-1; Thu, 22 Feb 2024 14:45:18 -0500
X-MC-Unique: TyBIinW7NfqRs2FFVW5pXg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4121c06be80so992755e9.1
        for <virtualization@lists.linux.dev>; Thu, 22 Feb 2024 11:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708631117; x=1709235917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtS3rO3/k4CHxBCems7dZZwyABPFlcoiWlBHvKoMPuE=;
        b=g3d0CVNdc8BOzAYPl4Tnn4DjKfWY6uK0SlbjkLONt++h2Qj4uqFSt/s/NKHyvnJEFf
         DZd3UtalnnQcDdM2RQmNAs05ABSXPaeZqkeijIQTUQ1IoRPn8iuVkO5bAwAh+PL9hw2R
         bmuL3Am+Dg7L7wtbMi3oOgMjuWEOR46197nIhQf3eHZQ6cFqrve2oNtqJCqMqW7IEGyF
         YCjEa2mfoqZS/9iD8OV5YtJ0jVLc8W9E8CDsTyc+TCQouihflLl0Ul62QO+6GGU36Eg4
         MliVIX8iuQ9pASjjJCxHLH7mly+qbcghTLusFiTWbBsP2XgEhtSdjMN3fu56W8axpmNb
         Tm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8QhEOBD25tZajPGsLRYsGom4n7qOIwTmVws+CSVbX/QHXa2oUMYWLqhpxKchM8QUu/fz4nKdQKY5ExllgQR7HZkeOYSpIwsVIKxTOZII=
X-Gm-Message-State: AOJu0YzLBlA5P1nP6jSz1rK/czqO7fSlNVXx6f0INhPX6wuCxlnQhYGd
	Q/DPiwBDgR69VxA+7HitJTxZ69QX9tz3nl2BDCX9LWSmoXwbxAZCFxZodzVn5hCgkCuDE4e1sQd
	Omj+9keZaqKII2sAkHwpoSuJuycRu3MxoQc74wHdJPpwuFt7++mU1SLoHACKsbRN8
X-Received: by 2002:a05:600c:502b:b0:412:9064:fd12 with SMTP id n43-20020a05600c502b00b004129064fd12mr133437wmr.26.1708631117015;
        Thu, 22 Feb 2024 11:45:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIRLu3qZVKJ5FnK2wvIF3qslAVzVoLbk3KPH5Qa9qhUzWeKOnysKrycrAsYRbxrz39i8PjAQ==
X-Received: by 2002:a05:600c:502b:b0:412:9064:fd12 with SMTP id n43-20020a05600c502b00b004129064fd12mr133422wmr.26.1708631116744;
        Thu, 22 Feb 2024 11:45:16 -0800 (PST)
Received: from redhat.com ([172.93.237.99])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b0041290cd9483sm137666wmf.28.2024.02.22.11.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:45:16 -0800 (PST)
Date: Thu, 22 Feb 2024 14:45:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
Message-ID: <20240222144420-mutt-send-email-mst@kernel.org>
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2024 at 03:59:19PM +0800, Xuan Zhuo wrote:
> This is the second part of virtio-net support AF_XDP zero copy.

My understanding is, there's going to be another version of all
this work?

-- 
MST

