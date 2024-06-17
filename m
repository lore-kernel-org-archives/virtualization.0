Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F580175AA
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641111; cv=none; b=fQNeUlPIrLm/Od7sWF29tZvCnpnAdURPnWwihcoavn5lLiFOTNnjm4sxzNPDtWitNc7zCdLHwcUl9CDKVMiV3+0JCOkw1rikxBvRq7B+8/KkhkqXUNKtxXUtZYaIq6bGVEvcU6S98Wj1M6AgW0zIZJtXgmmwVUH8zq//ZzVkcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641111; c=relaxed/simple;
	bh=Xoln7j8EbQc4V569jmXeK9Nyl281J3NJCSqkqztUsY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hnb3w9J2y5EAoFVp7bx72qmChi2sDSTDDslb9Q+xKcXCdQ+Idu5cTKZDZeiPDMn8tGrHlrJKaiGrMEI4R46p9LPQZX5f+Q2IGcHbLclO6vYFErGrUqv1rGpXEgdWSgrKw4jxix7Fi+TEhCfPVXStUBQWh5gDfEOsnI1o5d04x3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxcICBQE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxcICBQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718641109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFZFlosMMIe4sydwcE//6HkoJc4uYg5CDJdWIzZfrtE=;
	b=HxcICBQEvptmxZgup5pwvHhMStkbWMPt4w7JzJhby2mISXhOIvbp+xhhp8W6cwugyjgC2/
	0WZuS+0e3IHJrd5jwk0gUdGS961LzDNcBQnbUkTNLsDGXOjQSuIfbhHgZLRTabwcGn3wbk
	7bFEhgln9hraeFQwV9MM2vdx+hrrKSs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-h-C7CeFiNLSYAMjJtJa50Q-1; Mon, 17 Jun 2024 12:18:28 -0400
X-MC-Unique: h-C7CeFiNLSYAMjJtJa50Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1f8d48b3so2383915f8f.0
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 09:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718641107; x=1719245907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFZFlosMMIe4sydwcE//6HkoJc4uYg5CDJdWIzZfrtE=;
        b=NSbAlj8sUFe2MmNu0uVn2NjGF61hem/URwO2aQSBh2wdVmU8clVbLPcJ/j5uXblH9K
         kXS0JNCVoiL1aSBotbElcq1Mb4tHYAD8l95OHJkbHcm141XokXjuR4b4PFjEK1SirEqZ
         FrdivwVOcN3cKNIAPvrN8O8P3477sGUjRtgF0vK8d/i6j3eZ9gDaLbjlSn2JlTzxeZuI
         bHuZB9Ruqli0sy/HNfJr7DF9/G+3tu/PGMc4X4aTHQso+kZKl6FV+OV50WcOCcq8pJNu
         2JrsrUoe3pbaYhrSfzzA1HcKV6dw7sT3q2q0WgGeac3CrUGv8fNZElDCND+8N9U46Cs0
         e1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUcu/cNUMe4UKYa5QH4VuteZ9cs3zLHk7VNgdk06bxxXx30TMjrPySvqsaBkVn13U89QU32cDE6wbH21dwsweNh2L6AyN+zsl5Y3FTXg7A=
X-Gm-Message-State: AOJu0YzrC3qouZErnWjnBsRnnob0+riVzSXoMT+dmSjpxgh1Syg0Oz01
	PhsAq9Y9obk1hjlZNsRABII1M74ZyBSAlFuBD1jZxzegcqfAmJaizECYrJ/VJ12xOYdanDeyXFX
	rdFfro72l/49JbbnGBbiIECYHRggxuT03TW/K1GxJmZD19OXClWPbf3xnuZdgRoqI
X-Received: by 2002:a5d:6104:0:b0:35f:1f19:594d with SMTP id ffacd0b85a97d-3607a76b530mr6829029f8f.33.1718641106875;
        Mon, 17 Jun 2024 09:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbulzU89H9MpwhLDESOVQ9ymHNpAT6A9fGxoXOf1BjyfaorPFCdoAiLsEBxLzhvIbwN+dt3A==
X-Received: by 2002:a5d:6104:0:b0:35f:1f19:594d with SMTP id ffacd0b85a97d-3607a76b530mr6829009f8f.33.1718641106428;
        Mon, 17 Jun 2024 09:18:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:d4a1:48dc:2f16:ab1d:e55a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b74sm12124104f8f.107.2024.06.17.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:18:25 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:18:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240617121737-mutt-send-email-mst@kernel.org>
References: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
 <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion>
 <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2024 at 09:44:55AM +0800, Jason Wang wrote:
> Probably, but do we need to define a bar here? Looking at git history,
> we didn't ask a full benchmark for a lot of commits that may touch
> performance.

There's no may here and we even got a report from a real user.

-- 
MST

