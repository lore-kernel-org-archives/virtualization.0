Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A774CE01
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQoIPNSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703581512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve1uqTx9MMoZ3Gc+pAWDljbgIT4AroaD+W2YAl66BV4=;
	b=hQoIPNSym1esmDzn4+UXlQfyk+4S76/Fq+cUoCbl4A2Hymwk+kUAd3b/S7yRK38VWV2rYz
	3J21YioKHd67ECnkHPR+4Qf+8t7Ly5KYLJ8KMR+y+B1YVjGeJcceyW7pUAmJrtV2PoKB/r
	ZqMmhheJZRv76Z7tgObavilyZcx5KFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-kk8n_37fNXOCYNUEeSWkkQ-1; Tue, 26 Dec 2023 04:05:11 -0500
X-MC-Unique: kk8n_37fNXOCYNUEeSWkkQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3367b16449bso2789382f8f.3
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 01:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703581509; x=1704186309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve1uqTx9MMoZ3Gc+pAWDljbgIT4AroaD+W2YAl66BV4=;
        b=GfBytE8SFKbpkR91Yq3BwHpEW8pH5UGyJpj4gsbX61UWgVZ5u+VbY4ua90xPQ5kW/+
         DYHZSNBOhrNU/0zl7YdIvMUi3BcAilzY+F3EfVW5V5NVNX9GY5i9cZYNNFwN6YyxMvdv
         ucSI+kgM40aC50/DkzP9tNA0g48GCCWLP8ayG7GXTG4GqhSvexC8CdjVREAvo4zMWcSa
         kiuVf9bNFfvfCYZtuIyZQRfAML4gkCLCyd2RvTIX3MeBsI2vxdxfsA/1no2iFV47C9Jf
         zN4ntf124XDuBRteAuzknOeLsnG9anztnkTn2E0um9VKqqN8jHlj6adh4jnsr3C3mtBD
         d79Q==
X-Gm-Message-State: AOJu0YwmoSTpA9Rp9/tDqjdFLBeu8eVBMC4jzenq48iaBs21ilCyQX8w
	wFzmCffRQ/YRVRA7eq4VztwXBBxIuelxR9ARbF1tfZs/c+6VW0FLWx9qPN+hEn5roxlj2kjSQPd
	libS/qolRgr4XxJCN8zLz5KHE5XB43qcse7Fv588+qCc=
X-Received: by 2002:a5d:4590:0:b0:336:6895:f5fb with SMTP id p16-20020a5d4590000000b003366895f5fbmr3586470wrq.75.1703581509056;
        Tue, 26 Dec 2023 01:05:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLiMWpmfAgwDwhbbW5uVJ8j6cbfhcNo+n6TStySwWGpppm3cK94RSMZ4VKjncgbKZYFbBFBA==
X-Received: by 2002:a5d:4590:0:b0:336:6895:f5fb with SMTP id p16-20020a5d4590000000b003366895f5fbmr3586459wrq.75.1703581508742;
        Tue, 26 Dec 2023 01:05:08 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id df15-20020a5d5b8f000000b00336c43b366fsm3580935wrb.12.2023.12.26.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 01:05:08 -0800 (PST)
Date: Tue, 26 Dec 2023 04:05:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231226040342-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> Hi MST and paolo,
> 
> mq-deadline is good for slow media, and none is good for high-speed media. 
> It depends on how the community views this issue. When virtio-blk adopts
> multi-queue,it automatically changes from deadline to none, which is not
> uniform here.

It's not virtio-blk changing though, it's linux doing that, right?
Is virtio-blk special somehow?

> I don't have ideas right now to answer Christoph/Paolo's question.
> 
> Thanks,
> Li

-- 
MST

