Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B31714A1
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050665; cv=none; b=sJrf+7YYRTLSV693mvOdP0O9YaYLHQLidGDp18JAVnryXzVNWdEPpX5YZVp1f591KaHsbsWBoMKsyr80s2AFGqaHbRz6j5SFpAGjKACXeN09nEyCCw97bw4K8mv/2YQaGqCXNeCPiQs56CQ1+y0GHw1K0FFa0+ET80/3FIMcNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050665; c=relaxed/simple;
	bh=dyYYWaUkW7Qj38yfF+lT8+G1k5MTqJErF4gqgbsWBm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VnbK6RzezDv7r5Q4xPRJi3QMcryoYu4rqf0Tt58LwJIrpXo4YV6KG+xvY0ZZSDpY/ncGvCu86aq3oCS/kSuX3KrjYAICl1EJkq7TUXejASg5o31czZoeVryCz2+KGcpB84UJTBIliGtpNzOWGpFnFLv+820KfLrxLGSqfOQE/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGI6B3gP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGI6B3gP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726050662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caUs0yOnF97biFjcb48s5HolFUOhjWq58ujl243U++E=;
	b=FGI6B3gPnuOrL1RcjepiNJOfWdDGdp0V2wjxL1TclvCU2A4bUNrS3/7O/WmOF1eWGB05tE
	zBEriYtrPZf/4e8gwXxYg+sM9ZVFcUeymAVcV+wTh4yxe4mRGwmHol3oRuIYiEVFlIz6be
	2H5P+aZ47WctQNSWUWiA2f+BdeC2UGo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-ODnYxQFiOsGbMEPnw3INuw-1; Wed, 11 Sep 2024 06:30:59 -0400
X-MC-Unique: ODnYxQFiOsGbMEPnw3INuw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c90d24e3so4500276f8f.0
        for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 03:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050658; x=1726655458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=caUs0yOnF97biFjcb48s5HolFUOhjWq58ujl243U++E=;
        b=G2n7Nf19KFfxlflQTGTDd5tnbmNmWYI+HRFQQXBTTYu35dvZ1B+OfhyLDsGTL3EA7I
         lLTYTTEpW3UE9NBCQgrlgGJn2c/EMsqoFaajlVALbAUqAIqzFDrjP5h6g1MGVKTnEe4i
         Fd7FgeEa0soA6SkIuJFyqNHxmVa7jZTo5yIpCMjsv7qtg+laLFUp8v2Eq4jxdqM/1/ra
         HGLFzX6ogzVyZl7pRCmQ3KCcaQ/ZHATodD7Xg4PCrefh5wNWC/wut8BLVxXMx4WWin2k
         Vf7G/pHW3nRJ9vUTzl2I6s4rdcKIiKeHPqaoSbzjUBL4cJ1IDx75FZ+jBTAhvub59c98
         7yNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWsO8xdxLbqvxgSVJEY4DA2Ud1CM1VwDuB/OJ62aN8sZyKNqNtO6BRaV+sgux2zgBYI7YfvCkeiKBbjxjqCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYnKOXHE/1P9ccHLxDufcRm+R/7O2WBCGzp6eGk9dq1X848lMD
	RX+gdaXDmklgAIg0aHZBgHgTn99C/+LehYaEyKeLL+r/k1UTwOgRB16N3B72FxNSYJH96AHsy68
	PFbpGWUCEDiq2INhCZfJLBsNW0G3H3M5wzNl1H4rjVyP/4VrtrdkWWseu7Af6ALQG
X-Received: by 2002:adf:ea0e:0:b0:374:c05f:2313 with SMTP id ffacd0b85a97d-3789243fa0bmr11907020f8f.45.1726050658426;
        Wed, 11 Sep 2024 03:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtMggxMO/7B9PE3GYbAP3s7BqOmc7zlfd6FQ4MDGJx7VJlGmCoycy6iOpEGQqoU+TO08lKlg==
X-Received: by 2002:adf:ea0e:0:b0:374:c05f:2313 with SMTP id ffacd0b85a97d-3789243fa0bmr11906984f8f.45.1726050657807;
        Wed, 11 Sep 2024 03:30:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ec:a3d1:80b4:b3a2:70bf:9d18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced201sm593139666b.168.2024.09.11.03.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:30:57 -0700 (PDT)
Date: Wed, 11 Sep 2024 06:30:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 02/13] virtio_ring: split: harden dma unmap for
 indirect
Message-ID: <20240911063024-mutt-send-email-mst@kernel.org>
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 11, 2024 at 11:46:30AM +0800, Jason Wang wrote:
> On Tue, Aug 20, 2024 at 3:33 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > 1. this commit hardens dma unmap for indirect
> 
> I think we need to explain why we need such hardening.


yes pls be more specific. Recording same state in two
places is just a source of bugs, not hardening.

