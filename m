Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414941A84
	for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718235898; cv=none; b=Nn8ydvvCAGeOyJdUZumEQmV4EQfkfU4Av3RdS/W1+mmBGhsN1/ILjE+0RBpW8QfrJAZ6anV9ZsU5AAsO79L30AGqZvnhzOgDHGNGe/NM+yK6G286R9JlRPK/63QfRRTx2aQ838GQfoWWMjQO5Q53c4+DOl3ESAci2eBYoYupfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718235898; c=relaxed/simple;
	bh=LQb3o2/CP5JSK8KAyQba5WkdaHhdXZYvdSrm+JnIPLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dF7uwRm/ppRwCWMwSkF74Mn2G2h18Mjg9owmvYXabClNeh8NuGG46l89vsGimYBP0g2DU0cYGdAMj3HYQdJB09QLJCC56Np7TynvFrW1mRLnzgWSDwyJgNFJ5jFdPkivfcPO6SrqNoK4RD9G+6JVbdukiofnjtm3iu9EtzOBm1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEiE+I4S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEiE+I4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718235896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1VosMQ3bFESuAWLh6SDqxXuOvd8Mst+9B84qG9NSYg=;
	b=UEiE+I4S5dTG/60ccYhYnXlW5G2Tcs4WWzMPgQaiRrAy8O23QgfZOSHKcagsgDsy8vhWWW
	aXKmj4oawijR/eEzjI2qWMPjsZK9Wi46eYocxbY3PRulHCMJhcEs+DcjhKw1TSub3X6D8W
	4EG1QUgLOP0YsG9h1kKDTOrU3MeZ+8E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694--TEegrMaO3WSbB1vsL0B9w-1; Wed, 12 Jun 2024 19:44:49 -0400
X-MC-Unique: -TEegrMaO3WSbB1vsL0B9w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f29246a35so403492f8f.3
        for <virtualization@lists.linux.dev>; Wed, 12 Jun 2024 16:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718235888; x=1718840688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1VosMQ3bFESuAWLh6SDqxXuOvd8Mst+9B84qG9NSYg=;
        b=qJ6W7kiz+onx1ofNDmojEaRwIG/9rOMBnMWZWR/5bBhSgjxxnS66U/G20kxzdFG3QK
         eUCYe/+GtpDVCkwDcuy9N9F1eTbwz4fpLaGbwS0IWkALU4hvhJDKJBHyaaqka7I5mHrJ
         XL+jfzx3mfXkxyIVbXIAA3dwcoJFATFOfgRylY2bdv5wOP7CP+hbQvSiK+PQ+9addhje
         QslpaemENNzTS5JRlBIY1T9EzHDjETeEx/8AsJ6zMqsYVCEK+aNim8ixE4Zq1x7vskXa
         6CckNv4Y7hfSkDC3X+5OYcWWTC+yZJN+8tN9i91OZ7exnBK9W4VDsNwv5HEYasa9zs6I
         ckyg==
X-Forwarded-Encrypted: i=1; AJvYcCXVZjKaBEXWzrIpDBOJfnohQRbdXARJtreN1TPIaS3GwXgT35zPRU4BQu7zL+EAq08HJmZnmf8HWPw3uh/oIAeSMNB7g4ZG1CpASfho4dQ=
X-Gm-Message-State: AOJu0YxqsVVJ3Ss+lhGET2vpn7llWdpskJVdNUptXm/mRPxGAJeTg8Fa
	h9Ck7JjQwQbG3MjugnBgrx4+oMBpR25ay48bO93rQC5pBeIfWJW6HF0ltwiWmSTGP/qrielmuBs
	eS08xNtaM/ELmkS/PNTXQafUzka/UJAv6OVk14sm/znLPxnsdvrdX4te4Gg0EbTW4
X-Received: by 2002:a05:6000:2c4:b0:35f:1f3c:b632 with SMTP id ffacd0b85a97d-35fdf779b4dmr3084394f8f.12.1718235888521;
        Wed, 12 Jun 2024 16:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzTM0DuELFcd6K5W5zmF+NgyZEAXmKiPtBN7iRmrfadHH+oMGDf2fEtoNYfG4eSc3SnCV0pw==
X-Received: by 2002:a05:6000:2c4:b0:35f:1f3c:b632 with SMTP id ffacd0b85a97d-35fdf779b4dmr3084379f8f.12.1718235888065;
        Wed, 12 Jun 2024 16:44:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8c2sm119131f8f.31.2024.06.12.16.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 16:44:47 -0700 (PDT)
Date: Wed, 12 Jun 2024 19:44:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 11/15] virtio_net: xsk: tx: support xmit xsk
 buffer
Message-ID: <20240612194425-mutt-send-email-mst@kernel.org>
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-12-xuanzhuo@linux.alibaba.com>
 <20240612162505.2fa3e645@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240612162505.2fa3e645@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jun 12, 2024 at 04:25:05PM -0700, Jakub Kicinski wrote:
> On Tue, 11 Jun 2024 19:41:43 +0800 Xuan Zhuo wrote:
> > @@ -534,10 +534,13 @@ enum virtnet_xmit_type {
> >  	VIRTNET_XMIT_TYPE_SKB,
> >  	VIRTNET_XMIT_TYPE_XDP,
> >  	VIRTNET_XMIT_TYPE_DMA,
> > +	VIRTNET_XMIT_TYPE_XSK,
> 
> Again, would be great to avoid the transient warning (if it can be done
> cleanly):
> 
> drivers/net/virtio_net.c:5806:9: warning: enumeration value ‘VIRTNET_XMIT_TYPE_XSK’ not handled in switch [-Wswitch]
>  5806 |         switch (virtnet_xmit_ptr_strip(&buf)) {
>       |         ^~~~~~


yea just squashing is usually enough.

-- 
MST

