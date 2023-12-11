Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96B4D58C
	for <virtualization@lists.linux.dev>; Mon, 11 Dec 2023 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfaxTEJ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702313644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0TaQIjCMRtqoHv9s+WpKU6yUC9m6qOxRLwTnSkQyVwE=;
	b=LfaxTEJ16gvPHD+pz79i90X5WCWqnsU665CRuj0Q0FeaYQU4nOak+2xtsd801JQvdWtXHj
	+ynZDvasZNX6piN2+ygXD72ywsbwHxFP0zVTgauXMNIQngH+W1aZKKvpuIir8qVNSPj5Dq
	N04jTbFkri7tZ+yUFECvqGNBWL5wKaQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-expL8A_-PLm36dME5ohAaw-1; Mon, 11 Dec 2023 11:54:01 -0500
X-MC-Unique: expL8A_-PLm36dME5ohAaw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332ee20a3f0so4162196f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 Dec 2023 08:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702313640; x=1702918440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TaQIjCMRtqoHv9s+WpKU6yUC9m6qOxRLwTnSkQyVwE=;
        b=i1eGEXq2G56hYJ8RI/crijAOCky/lf3NIr+Emcl6fdHzzqLfWKZXu3U/VkuPcSEGMm
         WccIn7XnUCcVWjyr/QE171gx0Ilp2PcM4vuur7s5aEN2sgmeOlfk9Ac9+g9TX+ACe/90
         jgYee02czQ33N8wvnOeRC1L0OeqhLJUdEV0EsRLUkEtkXfk8wuALrb88dAm+45lqiOnK
         t4xj9Q90tyl9sUS7rYUS9X6GY1ApXfefkEz9wQn1QOeTVxAvMVwA1Baxu0NtGlotrjEr
         sEGAI6pfQTKdnLK3HfTm5TDUsW4zqx/YtWEUj23nGs1Heg+H/ggdm6QU4GwB7Mvtcpo/
         Wz2g==
X-Gm-Message-State: AOJu0YyEfa6wqqmawakmYfF2ZDTDAtbDgF0/WEYtkTLxVHecSs2Qx8Ok
	tB+wcfUd0TWaCEzjsZ8r0xOHGDMtxytUUqJBTK3djx4MZT9uGtwJ9kXfBo6Gf4gMNujmEKshsvD
	JWUkR/CBT1DCkIw5NmKh5w9KmUwY=
X-Received: by 2002:a05:600c:450e:b0:40b:5f03:b3c8 with SMTP id t14-20020a05600c450e00b0040b5f03b3c8mr1125889wmo.234.1702313640094;
        Mon, 11 Dec 2023 08:54:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtiBxrV84vG/3P94lY/VLzXMvM+oAghyKtAHVVBITjmPRXIgn0MXg5y1PSG2jZcwLid9jfxg==
X-Received: by 2002:a05:600c:450e:b0:40b:5f03:b3c8 with SMTP id t14-20020a05600c450e00b0040b5f03b3c8mr1125883wmo.234.1702313639719;
        Mon, 11 Dec 2023 08:53:59 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id k17-20020adfe8d1000000b00332fa6cc8acsm8943445wrn.87.2023.12.11.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:53:58 -0800 (PST)
Date: Mon, 11 Dec 2023 11:53:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Tobias Huschle <huschle@linux.ibm.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20231211115329-mutt-send-email-mst@kernel.org>
References: <20231122100016.GO8262@noisy.programming.kicks-ass.net>
 <6564a012.c80a0220.adb78.f0e4SMTPIN_ADDED_BROKEN@mx.google.com>
 <d4110c79-d64f-49bd-9f69-0a94369b5e86@bytedance.com>
 <07513.123120701265800278@us-mta-474.us.mimecast.lan>
 <20231207014626-mutt-send-email-mst@kernel.org>
 <56082.123120804242300177@us-mta-137.us.mimecast.lan>
 <20231208052150-mutt-send-email-mst@kernel.org>
 <53044.123120806415900549@us-mta-342.us.mimecast.lan>
 <20231209053443-mutt-send-email-mst@kernel.org>
 <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 03:26:46PM +0800, Jason Wang wrote:
> > Try reducing the VHOST_NET_WEIGHT limit and see if that improves things any?
> 
> Or a dirty hack like cond_resched() in translate_desc().

what do you mean, exactly?

-- 
MST

