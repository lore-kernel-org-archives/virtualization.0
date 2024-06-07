Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2073468
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755827; cv=none; b=UHS/Anzy9Xc+joqxycNvvSAOGASRg5y7/8T9iozkuKDjzKyCsRogadv9ewaPJZBHFHqdj9tN+lAZFihczekxZ3hqmsJs8ngByI14qrHP8xVJemtXfFCFSLYLwgXv8GuiSXi/2MvtaEQxQn14UM6+Fc9EMK6ka9g3ujHDEgWv+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755827; c=relaxed/simple;
	bh=RFXgRMs6kjSAsxH4kS1kJxemVJFnLMpc0AeHIN3UL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Wp68ChDW58v73O96KDCg/g6z0A37nxy9JyVFDEoNAO9p+BnZa47ldtWPOcQsKFd56YWY7Vaga+L5yWPrHo8CG3jbadrBrW7D3AlB0/wlmo4al+dBtSZemRnYjJeCUmJYSu0rqVyoC08czS+JgRR5SKSZ81sJGk4FQg6pxEB34Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlDohmvh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlDohmvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717755824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fzxDjjhBVYQ4MozMAdX0bvSJ+E1P8nTRPna61lMIjY0=;
	b=DlDohmvhjWmqyCLh8BrEqu2/BHPkoAW0uxFTm9NJw0qM0fosmqPCQKiiPLC0UFbeZMnFcE
	YLZ7sPc7lNZtMTd+HLtCrS/q9vmfEsH1bXATkeSi0eeAloM2BEVuBGfryheAn6iGYqgGwr
	LOYlzFh7Ved4y3Pycyv4fgTQ9YStav8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-8O91xlp6PUCDg91VuHZeXw-1; Fri, 07 Jun 2024 06:23:43 -0400
X-MC-Unique: 8O91xlp6PUCDg91VuHZeXw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6ec06ed579so13862466b.2
        for <virtualization@lists.linux.dev>; Fri, 07 Jun 2024 03:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755822; x=1718360622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzxDjjhBVYQ4MozMAdX0bvSJ+E1P8nTRPna61lMIjY0=;
        b=XOj8mwF/VZ/J9GlG4hs7xTp+mbEBIBHkwme4Egg8/wFYrTrGC/yw/kjqWDhDu0pTkW
         0vzZXovrLUtkmZaxkKnn/D+301BHK/OKEYcUAbKFjAMh9t7RI8Ky0Tj3jIWG+h4bcBnk
         +CzjFWCVZPEiGTy3zjIfenSJHvjebgjatHopyo5/PRrSErDYWMGL4j1RXnvpdWlnfBzX
         o5Wy1lkiJJ3bw0Kr8EIzTcv9y4GtijzMv9HQDo8qA3UnyqVzyugVWuKtIVw2a9PmXNmQ
         WRJuSbAl7oZd80XxHRjdcnOLXmecafzlJyjT5fGpi2LdXFFxn4VF6g7axwh35jDtoGbM
         mzoA==
X-Forwarded-Encrypted: i=1; AJvYcCWr/Oajhrv3oXYym1rKOYD89RI2BGp9oIGgPWz+/cxYQ4vZaGt4zrFsd160dr/Sy/fC1AfM3Pkbnj9a9mEsyd5TFj0ZC1RKRjsN5iLhSJI=
X-Gm-Message-State: AOJu0YzYC0PyKyCiHPayr16LNtX7nsSmJ1iQxfl9WoafXDhSij+BffGN
	pmSQ8vChiAh8eCyx/DbSK3asBPGp9UC6XklfCDL2CwlDfMfxAdTXvV7qsHxk1zSY1IHOOuKIyDN
	F2024rjOvgKy/19nGd99xGlME6LKScA0VyZi4rQonPaV2TMJ7lXykaIuKhg4ZPknV
X-Received: by 2002:a17:906:26c9:b0:a6e:f645:f595 with SMTP id a640c23a62f3a-a6ef645f710mr2692366b.32.1717755822391;
        Fri, 07 Jun 2024 03:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGADNV9wQQ+4jRf7MncAYwuQX/VA9lntFBPZPcUQ9lGezI97j/mnqv/QeJxOh0+G43mXA4LkA==
X-Received: by 2002:a17:906:26c9:b0:a6e:f645:f595 with SMTP id a640c23a62f3a-a6ef645f710mr2691066b.32.1717755821842;
        Fri, 07 Jun 2024 03:23:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070f9b4sm225979266b.187.2024.06.07.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:23:41 -0700 (PDT)
Date: Fri, 7 Jun 2024 06:23:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240607062231-mutt-send-email-mst@kernel.org>
References: <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> >True. Personally, I would like to just drop orphan mode. But I'm not
> >sure others are happy with this.
> 
> How about to do it other way around. I will take a stab at sending patch
> removing it. If anyone is against and has solid data to prove orphan
> mode is needed, let them provide those.

Break it with no warning and see if anyone complains?
No, this is not how we handle userspace compatibility, normally.

-- 
MST

