Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FD157A68
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886293; cv=none; b=Kc4K3uJs3hBmpOBsCQLZEZeceZzhsFKqjuq56YOLzWYSHJjzu7XgBSxgrHJAo0YaRHXgMb+W2eQpywdkgOIn1XnZyAQYKsPK5WY+vEp8fbyaSLRdkU2VvNrOmrFVrm/05cuEclu60QmtxfdLD9qR7nS5k9/0kJ4VVljauVIxIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886293; c=relaxed/simple;
	bh=ELtnt8hMvirmxWy694FQQpOITSRYaHdbDyo7UvSyHWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S+rrMRcmRJrzABH86d1UWB7bD7+YlBY1Z6fk8hW/qWuL10zj+QNEbM4O2TRT66JebL5q4fEFhz9sywgPtJgtwdVIl4GUSmrnDPeadfW8biWQVjjz68IGSxoTnvNK6eJYFES2FDO7z3+iydz8T1Wky3jsFVNDaWq6BrjGpDJW/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va3qPJQz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va3qPJQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715886291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jz7L9c2ybtagPzZAI/HiPe7jF+CkWPwh/QudsghM+Bo=;
	b=Va3qPJQzWryAgj2XpP9RwW9DRCxBD7+9Sl5bry8tWsl1EBLPtXPxzkGBGl5NSHIJ6/SBMp
	WFHeSupM+GlDS9njmWVkaIzGFCRZWy39Ry0uHf4Q0vvR8pIBl+6llj8CAzAQnCuyTDFgVQ
	/eTpswBmbHTiX5UWOeJwC3zvLNngWYk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-rAI-1W88PciTFo40GV5mLg-1; Thu, 16 May 2024 15:04:50 -0400
X-MC-Unique: rAI-1W88PciTFo40GV5mLg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51fd9c7cdd9so6862435e87.2
        for <virtualization@lists.linux.dev>; Thu, 16 May 2024 12:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886288; x=1716491088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz7L9c2ybtagPzZAI/HiPe7jF+CkWPwh/QudsghM+Bo=;
        b=RoyFNOW9vkq45lOP8tinj14j30AtEFp0RRUaGQPzMY4DZkke1lzAkHcopuK6/ROpg1
         VrN6MNn3nW9mEjM8Z3k6b1Bu4KaZmIGPDdZ3fL0EsndMuWtQJ2R7kPVlQbKe4UyUFc3h
         cv4JFj0fHJKAGWhge3eA3Vsw2dYFlp2RZrOR1esTF8GdQ6yMx35ANJ24EM1ExGE/Xx7C
         ozgrKNbcJVOfsogC/JjfZieB1kIt9jEhHhVvwWjw49jWuPqbcs+nuNe6pzqZR+RXtxFD
         jMhXZzBFb1K7f4qzOjWPzaOtLr0IXfFuqkn/s9yx8WBzBSd60/AIOUg6xv/vfFEgL2af
         QFDA==
X-Forwarded-Encrypted: i=1; AJvYcCXfgulzgIzZi/uKv60915g22ptT7BQAwKEPzRvZJX/NViQed0kjVgu7lFdeaMRRSV658SHevDkzODnWJWb/ye15l4xdViClMk5VXUoRe5I=
X-Gm-Message-State: AOJu0YzrVxotPqWZKla/GNbFZmqcmqc7ZdEUJPXcmNWHoOR10WRl5/KO
	DQGzE3Vou+29GJtbuYl7V+d1f8J/cTsnykYGYSKDiYjOMp7KU+0ccV9CQDZezvVLvkWac1G9xQu
	YAT90pFaByREYV80nC3TlB5Pj4sYBYvD0atz+Jq+9mSq2wMCuz3T3VXbwLoA8sCz/
X-Received: by 2002:a05:6512:b8e:b0:523:d1ba:6431 with SMTP id 2adb3069b0e04-523d1ba660fmr1095652e87.66.1715886288412;
        Thu, 16 May 2024 12:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG666LZBWPCUr/LqwIyFBHcLAp4WehVEl1G2GF4vgzI3Hc5z6LWccyOB1hMi+IOAyNcwR1fA==
X-Received: by 2002:a05:6512:b8e:b0:523:d1ba:6431 with SMTP id 2adb3069b0e04-523d1ba660fmr1095636e87.66.1715886287775;
        Thu, 16 May 2024 12:04:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:ab88:14c2:fc9:18f8:19ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d2df8449sm3266124f8f.12.2024.05.16.12.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:04:47 -0700 (PDT)
Date: Thu, 16 May 2024 15:04:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240516150101-mutt-send-email-mst@kernel.org>
References: <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion>
 <ZkSwbaA74z1QwwJz@nanopsycho.orion>
 <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
 <ZkXmAjlm-A50m4dx@nanopsycho.orion>
 <20240516083100-mutt-send-email-mst@kernel.org>
 <ZkYlYLFthXVmHOaQ@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZkYlYLFthXVmHOaQ@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2024 at 05:25:20PM +0200, Jiri Pirko wrote:
> 
> >I'd expect a regression if any to be in a streaming benchmark.
> 
> Can you elaborate?

BQL does two things that can hurt throughput:
- limits amount of data in the queue - can limit bandwidth
  if we now get queue underruns
- adds CPU overhead - can limit bandwidth if CPU bound

So checking result of a streaming benchmark seems important.


-- 
MST

