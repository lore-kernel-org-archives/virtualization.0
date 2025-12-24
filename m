Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E991C3BF7
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540104; cv=none; b=Htc7vQaphcItYTCvzm0Gj2QHlW5ZqapdUmT2jPrXmz3UaRQZYZNtiHj17wbWm0li+dqUuCiGvmTLvF4nG3BU5k3xRYDdpS8nh/LifcHYOjZxo1HMhaP7kGOPD5o+o7RIxflFmpm7y5K3qrMMv4RNG7kfmEI6OWImPxCFuUhoNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540104; c=relaxed/simple;
	bh=VxgwS571p6d9ltRCxPlktCpRXiNoc5EoA/Yuj4mRh0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GKzteT8yUuWfKsm52n32io9ldtCTQSRkZN7SDYyGSKdQFWeXH8AxlsZ1RUyAlWK15nPF7cIX+u9C6eJuze1X6gKn02yDWoC4JcQxMlOKlXJEBh830xPji5NfyXuvg4x7bvleDG6PM2TT8WZ7NB29LRaRXZ2TmyyBq8VoRv5LEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LnD4lynF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnD4lynF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ul5RYtwKuLzb4fmUt0dahcK3wJyHyhIWdXTPSkMhGA8=;
	b=LnD4lynFVA18TaQFxOZLvB8c0AwBEioBbt/O5U4JuSSf5si5Qr37VnB3Pjso3A616vsysW
	eKMgrG8ciDoky6wrMXw+/9pXKEiQHRCDSa9IByP6CH0y1U+VVF6id98YIFnPoScg0AkfNZ
	kS4RafI2k42i9dkouj0pSN30SwSf0OM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-QTIEgF98PO6iCFA7UWiwag-1; Tue, 23 Dec 2025 20:34:59 -0500
X-MC-Unique: QTIEgF98PO6iCFA7UWiwag-1
X-Mimecast-MFC-AGG-ID: QTIEgF98PO6iCFA7UWiwag_1766540098
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so37906245e9.0
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 17:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540098; x=1767144898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ul5RYtwKuLzb4fmUt0dahcK3wJyHyhIWdXTPSkMhGA8=;
        b=oWNydmO7lbrl7JIqwXzhK9LKHqnVSRDJ/TtJVMyNNjovg10w2wSfH8OBJr9nrC3JLB
         rZTcdXLVthz/nV/ZPjra3yLPH+NAVJQc4KoBYONWQu8cI8EWt6glUFh/5U5dmQh0FmtI
         NcwCOVlQGA6eQxkTfb91SQEmj0Gi66JjWSMtbGNZRPukLUTm25KMb/ArcOHoSap9r0pc
         y+PcX4znm0pJsGarHR0ktgGDExw+AS7JQNOqsvLZtAUADERWb2Avuol7uy3vWjN8Iz4b
         fEy0HwxLWFjFcqt0hwtnt9O4PfHGb9P+NWQqTLLrqtNaALv5VPly7JFZsqSstjOybhI/
         TuQA==
X-Forwarded-Encrypted: i=1; AJvYcCVTTsp+bdLmzIZPSLNL/2DCz8X6JNxPcSmE4CGsOHLU3EkRYRXwUuMm2HFyRJVJ0v1RPDqntXsZ+hhEtvkWzg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3dgdwFW/AUIRtS1YtpXPLLV9bZMMyjL9wfsFY+CKl62+7I6R7
	yqGogbHKzV8Nja6JFZ0pcFQioFY68iJ6kVkOFWt1BtljMaRWPpo3mdSlK61X2q5Z7Gabo1OuWch
	XwvOlfrkvIQbmeU6RZnjYQpXFHBOE+8R0sruFDlinLpjMhQruq32jY5e7Qu+cajWgmMo+
X-Gm-Gg: AY/fxX68SCKGCgc7IEPybHXeNTg6lnBLSzYvKwk5Q9C5DG0qG58V0O5/8wL8ZWwn4mG
	+wgfOW0yksTxydqPQJzIcT6fiXANUYzw8Me04V87EUjFjGAmzOBhICHu1alOV87gSKe/PdWDzZe
	AHsucXBzhR/I7Eg7cdgQRbYQCy0GG+Xn2UkOlxYDVZRalvrUNHMoQXEWNJXcWQ2MV+q8YiPlVmZ
	32roOoWyk7DQgzGVzQZt/8o9Dq03Q51f4eeAyk+MMGP8Bd/XNQmr0MyhnWuMqTQt/Xw/g1vMsAk
	2QWtctyI7NWdCp4rB7WTvM4wHUS3ikKHtwXr6UutC7lWaC1zRAqLnddXR2qDMykYyx48mcj/9qZ
	o
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr174135095e9.13.1766540098377;
        Tue, 23 Dec 2025 17:34:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS9I2SQh5r2tYHnvHjQVonS3jrba9soPU92JGUQFF6MGUaVBWeHJ/5ROPtwija6HgeR+BPrA==
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr174134935e9.13.1766540097822;
        Tue, 23 Dec 2025 17:34:57 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279d6d8sm319276165e9.10.2025.12.23.17.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:34:57 -0800 (PST)
Date: Tue, 23 Dec 2025 20:34:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251223203310-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223152533.24364-2-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D8LuPJ1UOusksfXyhhDgvGk8_8iU_C1TYnjLKWwIOSM_1766540098
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> @@ -3463,8 +3444,8 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	 * Make sure refill_work does not run concurrently to
>  	 * avoid napi_disable race which leads to deadlock.
>  	 */
> -	disable_delayed_refill(vi);
> -	cancel_delayed_work_sync(&vi->refill);
> +	disable_delayed_refill(rq);
> +	cancel_delayed_work_sync(&rq->refill);
>  	__virtnet_rx_pause(vi, rq);
>  }
>  

disable_delayed_refill is always followed by cancel_delayed_work_sync.
Just put cancel into disable, and reduce code duplication.

-- 
MST

