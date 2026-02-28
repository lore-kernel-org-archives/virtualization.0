Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D1317141
	for <virtualization@lists.linux.dev>; Sat, 28 Feb 2026 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305772; cv=none; b=rl3T1bibfD2h/96dfhEuTKL+caiA+TvrO+5UNIKG2jKAsZKNVs8wV8+bmu6zXjWEXXIQVA29q+ghl59VD66IVnBZYJj7xgoxFRqq3NA87N9XcD2lh6nAX7WN4lAm4Ex0JVYTXE39DzqIqwW3qOO4sMvEmanpw+5f7kZvkZvZxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305772; c=relaxed/simple;
	bh=cgrra4B/i/V8Hiz0UZkBK1PpLGhkkR9xkKlji3DaXus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hC1KSEkh/hTsl3TL37pDzPwoY+ypnTKZPvQxj5Y4UODVHznmbeIpV6OSBw4I+qyEGFFpVSDxol7o9dc7iPvHNzY/GRgXaiOL3tzfijME9tK7sGoi7KOBQctfbPcxRIUPKh9+wZ7VHHOCqlOFkEGKPeeG+2uD/5viGkpPfgq69IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqVmo4BE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqVmo4BE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772305769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mthzCRUAS99QEZz/4n5tzjUOyKpLiDJe/rzSMKQArA=;
	b=iqVmo4BELeGVfWBe3jLuhM43SaSH2q3HflyT0TaMUIFoWCkHKklM3hq2wJhnj2CyHBjTw1
	uBlYUpXnxm+1V7/8phSgsIkHzBK5p8wzb8CIMqnlxuP0JUIqEmZyqz4pd4PPPZA5HuqF5F
	8HCq02pwUZpUBsxpDjD+N5b/ti6CIug=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-HtHNeYLpPUeuAozB2CW2nw-1; Sat, 28 Feb 2026 14:09:28 -0500
X-MC-Unique: HtHNeYLpPUeuAozB2CW2nw-1
X-Mimecast-MFC-AGG-ID: HtHNeYLpPUeuAozB2CW2nw_1772305767
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439887ab171so2946103f8f.0
        for <virtualization@lists.linux.dev>; Sat, 28 Feb 2026 11:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305767; x=1772910567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mthzCRUAS99QEZz/4n5tzjUOyKpLiDJe/rzSMKQArA=;
        b=ppKk7ENGdCi1DI8+iyF0F3nb1SN2YlT0jp9VFFyo9c9E0QtJpXx1BEHLyjL2FDAFsY
         ACTfqBeGmhvrytvIVwaw38z8Bow2Z5pCflQWmFdb5+mJiNYGblJ182MoR3gHZUxxNV07
         2AWdV68+Mxz1i8Ej3Qay4ANCppPOT08doAEwJxsGI4+KUyaSV2oQgX/CwbdFM533DW0h
         JVn2sKgMpg9PXp2f8uZK0MBhgPAREOAQVPKYzSQYANRLRrlkrt/OzaI5hsYBOFi8rKHa
         JvXVD2e3fKASBUh4gT04NcS7F1LvpOM3unyHWjmk3CJg2fdxxbISDLGvTtEs6eFqhioM
         zAhA==
X-Forwarded-Encrypted: i=1; AJvYcCWZsDOLanDCxOC7OV2dLEKYUP5T4fWljqe4vajh+NpZ/Z5KjKaKIyf430ON/DeSGIcPKHFws/IVAQhROBbTIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQZ9bgdhLHt2hgmGZTuI+apqXIUJsgf5LaOXHxzivwUqChCS/u
	pZdlxLNvmYpTMiohNehutgqqu4qshHx/RiACL/XhShYtK5/RuY2ultIn6J+DrlreUvxO7TkT2d2
	Qp47+8TBDUY+01mCj0sjlqcD+8KKN/Gkbrv5GK0C+IMgTEdYmHlgeEMPbcKqt7rf/mdJ5
X-Gm-Gg: ATEYQzyjeLtZXh9jOuMgbpEpQtq2denlKdhSW+e88O4f5SGkd15NM30LolLldmtRiIC
	L3HddFHutzHtvXl/VgaNMmlU6DYLj5hzHQUrrSyXGs/m3gQiY1RiWAVNiOI/Dfav4fyl0w2tJkR
	tlsIOJePWXkHOD+L53ZrYLQBTvRKxm2VzxcS10fABMFAjoNUF5pSYYh1fhzRsb/7v2aX0oB5W8J
	VNXtzSv7J+KipI33TqDAEi45WvE3fAAJocfgyWxcqaSPVNmVPDrFyEmauSswGLVSZUh60JRh/1F
	e9iI7tIDVS8AnNfegrkNtcxkPuXtH3C9Q7Jic6hy/Lr9X/4Gyp7jZWGKi1rznwwPgVntHHHvXK8
	V+2dpCjhaCOVqsRtlkA==
X-Received: by 2002:a05:600c:3e86:b0:483:47ae:7c00 with SMTP id 5b1f17b1804b1-483c9c02502mr102212525e9.20.1772305766771;
        Sat, 28 Feb 2026 11:09:26 -0800 (PST)
X-Received: by 2002:a05:600c:3e86:b0:483:47ae:7c00 with SMTP id 5b1f17b1804b1-483c9c02502mr102212275e9.20.1772305766268;
        Sat, 28 Feb 2026 11:09:26 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm166673485e9.1.2026.02.28.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:09:25 -0800 (PST)
Date: Sat, 28 Feb 2026 14:09:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v8] virtio_net: add page_pool support for buffer
 allocation
Message-ID: <20260228135423-mutt-send-email-mst@kernel.org>
References: <20260228134122.631580-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260228134122.631580-1-vishs@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YldTLplaHTs4tbrJm1qGmDrb5kmr_R9O0DWDbog3d_4_1772305767
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 28, 2026 at 05:41:22AM -0800, Vishwanath Seshagiri wrote:
> @@ -2446,7 +2349,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
>  
>  	offset = buf - page_address(page);
>  	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
> -		put_page(page);
> +		page_pool_put_page(rq->page_pool, page, -1, true);
>  		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
>  				     len, truesize);
>  	} else {

This part seems wrong to me: can this not be called from
xsk_append_merge_buffer?  Because that one seems to still allocate with
napi_alloc_frag.




-- 
MST

