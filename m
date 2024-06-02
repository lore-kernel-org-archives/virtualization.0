Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318B5FDA7
	for <virtualization@lists.linux.dev>; Sun,  2 Jun 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717357854; cv=none; b=i62wv7kF+8F2BG4kHKhuej/FHaBNECgJv7rDZQUY02ME9GRGtUDaQOlkyzzbAcDTfxpIsWP6XKxuDJjy0ubzHb+yL5/aORYiSkrUBf6D6lwfQQ0ZiF+o28Y9nTW8hihCiQeBVtb8SBGBapyAzRYcRhb7JDV39L0ExnayJN512gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717357854; c=relaxed/simple;
	bh=gPFTxi1ykAQRIrBq4wXHZNf/fKBP3xSqjBeWh75o0T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mKq0w63PScLMK/VHxmw9RsQ4au2QvXnssO6JMoHiBu1yAYzJGdEZWy8G6qyLeXWdvHSLUse5eTpJx2LAf4zmAwFejOxcXLtjOSc6H/zkTaCoUIJr0YM7tAnLOjyCi6avuEzG7+n94moBQi3ji9kQnNRDCdAcef3UtIXXRvsxX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FbJy1tI2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbJy1tI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717357852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ7dcJrZdfShxTmy5eRD0xFRdj/3JG84Ancyo6SGE5Q=;
	b=FbJy1tI25i5I1byssos/ARNtvEBlCjxVdgXeZv5OxA2EvWnUUULcQGL8yaIbHcfo2pGfbm
	g9Hq7bHXhgZHlpRKzNNgyjlf09rPNNKecS5xbPM8etqaHhZthDZVAhgqOIoZ6buBucLZ70
	Gh9q0Ae+0vXPJsQaMET1CbIVw/GzG4U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-fqYovLJbMrinqZnDau7kwA-1; Sun, 02 Jun 2024 15:50:49 -0400
X-MC-Unique: fqYovLJbMrinqZnDau7kwA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4210cd005b3so22029635e9.2
        for <virtualization@lists.linux.dev>; Sun, 02 Jun 2024 12:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717357848; x=1717962648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ7dcJrZdfShxTmy5eRD0xFRdj/3JG84Ancyo6SGE5Q=;
        b=B48IXDvGy9CNcdwgVJpgeApGtmLOtTZOhr/6lFeAU+lf7tEKDnywTIQN7kaAdRf7Jc
         Isx49pVaT196bkFFgxyE8A1pC4gQSob5Lsc6XDHKpAXBwhvOPHP72iWQPgxnn5D1+cB0
         QOIY5JWl7q5pqo0ImDuf6kdzwEAahQZXr7veN82hXrpv78/WABJ5ZYUdauHw7q82GSOP
         b+WQcf3A8hnkPp8Ao7ZrUN923Hv/SU7y0yjI0q3ynHiCKf/4RxmAnvmTUHEkUi2n56i+
         QyUiL01oldxNm9lGIVN9GS/QdT2/AIwdjXQApkCdDmszsNMZeb9+C3X/JjG/9ifzA1qN
         xm/w==
X-Forwarded-Encrypted: i=1; AJvYcCXoKjzTATQ24DJy1kmsw7VEfqaHlA5SKTlqFWCoaYTW1fLvXjEpqTl2zv859k39kXDgPuCs83rov09MrpzZpCMVzUadTNpb94ntUQ6CHNs=
X-Gm-Message-State: AOJu0YwtQtcC/QLJa7Q230WgPo+jLXqSoirBjPyFGXgXfmyEWnOVbUlc
	/eOJRjBN7cV0vsVlM2J+PYGqhDcdP4GsOZz1PrxEK6rs7jVmtLoRyd6pBFbSMYkTiQ0p8tkAIDM
	n2jmJqHacDNZHt63tXvQ4SxRY2j7fBSQhWM0kcAsVEoVuj7Bo31Rrjam+otHzE9UT
X-Received: by 2002:a05:600c:3b8d:b0:420:29dd:84db with SMTP id 5b1f17b1804b1-4212e0ae51dmr48109615e9.35.1717357848062;
        Sun, 02 Jun 2024 12:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYqsXbQOYD23JV0Nxts22Ok3ofm37UBzuKMoSngQUM7XRrHtQ+KzJlWwXOOHAHTXv0enXVpQ==
X-Received: by 2002:a05:600c:3b8d:b0:420:29dd:84db with SMTP id 5b1f17b1804b1-4212e0ae51dmr48109505e9.35.1717357847536;
        Sun, 02 Jun 2024 12:50:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d98sm6838419f8f.24.2024.06.02.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:50:46 -0700 (PDT)
Date: Sun, 2 Jun 2024 15:50:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/12] virtio_net: refactor the xmit type
Message-ID: <20240602154943-mutt-send-email-mst@kernel.org>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530112406.94452-13-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240530112406.94452-13-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 07:24:06PM +0800, Xuan Zhuo wrote:
> +enum virtnet_xmit_type {
> +	VIRTNET_XMIT_TYPE_SKB,
> +	VIRTNET_XMIT_TYPE_XDP,
> +};
> +
> +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)

No idea how this has any chance to work.
Was this tested, even?

-- 
MST

