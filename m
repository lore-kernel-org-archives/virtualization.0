Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7006016DEA9
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197131; cv=none; b=t//eA9r5wIOhQZQVtpWpFLx0c7rV9odljVrzSFr4mM0t3urj5aw3fKCz0nSloWweCYDWujjwE5Eh5aVBkeNoFMlSB3vMEsWTFYd8ydVRCbBksdJNBVeaeN1itCSMNJVH3B1A6N1GQXkdFJN7IH320eRy+/Ys5MvGLGPc6VfOncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197131; c=relaxed/simple;
	bh=mQUjFYSbPJsdugtRaygePCyZNxgYO6OLr9YujVLTnyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEgBtCSw/0sxIvqNZ4OpQ3R+mtaUnNNX0HmyLVulwdCx7rEBYBvZkOSUXaAeH44Ou+drWAXvnYcKnga6Uwgki+vEq28gojMlRlo1qCF0bDc/3dyNnK+noSMcpeweNNM3Ew15xwf0QAT6jrZBnRrj2lq/fSj2+u3fZANGkdgTukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fg8Yjn4F; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fg8Yjn4F"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B4BE33FB94
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 03:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733197119;
	bh=/1ELr/m1Bv2OGPjuOpiHnm1IVXq/mNpBWKXRMAF+/cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=fg8Yjn4FVVeMtIc8CMM6G6RGiYEKTKJTvFOuc1qe2AF1lnk3U9pgnnfiqL52Ls9bA
	 SHdOv9qDkWvtYEZEKJT35DRqW/z9kABp2brjF0kVMaxYxrAE9hm9LN+NdiXfzmYLN+
	 bEasJUjz/zTWk0q8wWRBE+CTPQ9srHrxi9tiugtkkjsY+s4JP2SkvQQ0dGC0W7OyWO
	 QB6pEwKOnDxCFs8x77h7UOYaDJN/OhIHFDaRP9TesqRWZvETOqQtSnW/PlV1xXOpsA
	 ky8uDOP84eks07nVigURv9B1cCwVMJJOn+g+GT/wRsT8cf6yVAQ71U5ZryaDwCyDoK
	 vYRvq3MYruQYw==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2156fcd6eddso33252575ad.1
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 19:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733197118; x=1733801918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1ELr/m1Bv2OGPjuOpiHnm1IVXq/mNpBWKXRMAF+/cA=;
        b=YebvSg5nrzcb013b6zFHH6yD0i5bRNsA8ESgNSYo60RNj18B82+2oeHQZyc1a+koRE
         vT2N3kMvpwiGTOYyxQE2yuWDc6l/Mczxw3EbbiMZZnCp5T5BzCMRb09SMEnjSb53ltmw
         9/NW3cbP5Fm8/rI3nbJlViRytLDjp62NVe4Jj1RfzX38eb0r6WOxyuytIche70sHe+AS
         i11KJ2+oZ6T8Zd1jdnoZDt7Jj0+WfDZyqiLRdumd/BLCPtz7ifYkPbmKqU06UioH0YRD
         ZC9WQ73a3foTGhEjyRAGAY03QUVgKkz6gnE263Xdswd9l2ZQRx9+U1XhJh9O/Olcu29E
         YpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOBuraxYEZwAjIV2BEH1Z6cidCntjC3xGKYAwLYveKRGQZStbaBglJk6RA4r16AIknRVHRYXqj3SCQSSeVxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUTSNYiiWlmddHppzWgA47UCrqbkeRSWFQPD7lcoNWYUIppLfB
	Z8vAlrcm/hI0NyXwtEC4YUnmyKbywscqfxqYQ4ZpU3qOyjb5ANSthJCOqTVIWTdlKhaTzN+68vL
	nY2l1YoRBLfWOwClcwI/n8ju19nMCzt1RkEemmSqlpzJ/XYIoYM+xVhSpybZR8g47QjkmxAZePg
	97XBzT
X-Gm-Gg: ASbGncusVlTuvmiVOmc6ZAYh1heUANbxJJewu9NeGJolGyVcGhbXoUrYwBZ6TEkBpIf
	pi5ffYPANKmPnZRfrB2ucEGXNCaarcnVrcy/vVq/Hj22AbuK7dQXa1rlocQQnzYzIRFVfL+jRag
	uStQOKlPnXRawijERUHcWkRJW1J6i+kllUsuQj0BiDwTKSSi6zXJ2E/5V8drY3cGATFsZf7cYSZ
	SPd7KmI9sT9tkgkbOdtdnY/FwkJ9dOsWRTV8DTaAH0a2oJN/SVS
X-Received: by 2002:a17:903:32c2:b0:215:5625:885b with SMTP id d9443c01a7336-215bd189d7cmr13412635ad.52.1733197118008;
        Mon, 02 Dec 2024 19:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiFXT/72acbiqUjNfZWjEnzEbxLtA1LUbxYQXxJZ1ukuWif4gI7XdthBZMTKX4TOQDY+6P+Q==
X-Received: by 2002:a17:903:32c2:b0:215:5625:885b with SMTP id d9443c01a7336-215bd189d7cmr13412525ad.52.1733197117737;
        Mon, 02 Dec 2024 19:38:37 -0800 (PST)
Received: from localhost ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905f4dsm84768005ad.78.2024.12.02.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:38:37 -0800 (PST)
Date: Tue, 3 Dec 2024 12:38:35 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: drop netdev_tx_reset_queue() from
 virtnet_enable_queue_pair()
Message-ID: <mwfore2i4ozfdue5ojq54o6bsjtr5y55eiemtwcl7ca6rb3hvi@k3kbcvrxw25l>
References: <20241130181744.3772632-1-koichiro.den@canonical.com>
 <CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com>
 <20241202181445.0da50076@kernel.org>
 <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>

On Tue, Dec 03, 2024 at 10:25:14AM +0800, Jason Wang wrote:
> On Tue, Dec 3, 2024 at 10:14 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 2 Dec 2024 12:22:53 +0800 Jason Wang wrote:
> > > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > I see Tx skb flush in:
> >
> > virtnet_freeze() -> remove_vq_common() -> free_unused_bufs() -> virtnet_sq_free_unused_buf()
> >
> > do we need to reset the BQL state in that case?
> 
> Yes, I think so. And I spot another path which is:
> 
> virtnet_tx_resize() -> virtqueue_resize() -> virtnet_sq_free_unused_buf().
> 
> > Rule of thumb is netdev_tx_reset_queue() should follow any flush
> > (IOW skb freeing not followed by netdev_tx_completed_queue()).
> >
> 
> Right.
> 
> Koichiro, I think this fixes the problem of open/stop but may break
> freeze/restore(). Let's fix that.
> 
> For resizing, it's a path that has been buggy since the introduction of BQL.
> 
> Thanks
> 

It makes sense, I'll send v2 soon. Thanks for the review.
-Koichiro Den
