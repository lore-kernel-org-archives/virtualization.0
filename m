Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CB5A103
	for <virtualization@lists.linux.dev>; Tue, 16 Jan 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437975; cv=none; b=H7pttJKmtGp0hRTRxTqra7yBqlGcZmTNKRlwSdFZf/Jl7T4K+sA+b+8/noxjUcGI4QJtkobrUoOP3TF4VdgE/QXrGaDZ2sn3LhSpk4jaDinVbb/rljD+6TIWvZpIXtcMMHsPYFyjMmEXTusMU+xYlkF0PFXKQSladrGVDILSniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437975; c=relaxed/simple;
	bh=8R04pV7NenTmY//Xvc4y+OGOzxSJ8Fvcj0st4h/W1DQ=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-Originator:Content-Type:
	 Content-Disposition; b=dR3zd0BSI6xEUjW4uCzd09ZOJXf74Ho/ND5oFhhssk3eRR+VWLcz0C4w05g/BgpZWk410kamQODbyIRg+oPrpwmQkjqBhD+75IA4mwjU7Srlo/1tAIRLmTZnU+sv8Iuzu9Opbi7tJMzRHdHSoy6iSHiI4gNMqWiOqW4MaTItfT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/n/FoNX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/n/FoNX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705437973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bY992iAsJxysfraXAvAsx9+n1cX0TFNO2wFD5XkN5qw=;
	b=h/n/FoNXfE7A0DjVuw8BKD3X027QaZdKK/bYy9PReExgYOZLPujkgtsbNsJIdEtKDgNEVE
	vMRli8NLnF3Xig8d0zYHkbLxLGIOxgZ5CWxLOriyqVaQsqobOXLfVN5IeBmV2kIjzpcaIv
	ki6ojgVXnN4nthQiR7IvQaKjB8XV37s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-GcnM010dOImcl9zWagNgTQ-1; Tue, 16 Jan 2024 15:46:06 -0500
X-MC-Unique: GcnM010dOImcl9zWagNgTQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-337c031820fso174960f8f.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jan 2024 12:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705437965; x=1706042765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY992iAsJxysfraXAvAsx9+n1cX0TFNO2wFD5XkN5qw=;
        b=SEb/B6y4m9HtLdQZISoaZagk8TOP8ABoIpSH8aKCVmZxLsLAnnQQf07QhAYu9h6w7S
         jAdI2Q/9+AHSznhqGQIZDRlyMy7ZXMUPeD34iGUfjhCbLIoXQfolVnGZj2nD47oc6bBV
         0ccZJknlayW+28ZnvevyhdugV0eokMRxUtNJstZ0NTib3eDOFFqHiFyFLAMMa26U5E8q
         3uWkYiEhh26ik+bqKoZCmbYiS1TmHYFSuqjUjCgugnxqo8GJ/5+1XI9FAQk93x19uYQd
         /AgceMZEwQ5NWiepjiXa2V+SC5NqPXU5YWwOf/QDgTGlgVdmiZjP8zYBFsTKaBswgv/7
         AXMg==
X-Gm-Message-State: AOJu0Yz/JQAt3QQNyj2bLB6cnwXgSgld8XHs2oMu+LDQtoSYTvruJfaZ
	xa+USmMHliRWvlUGK+LzBg/v1TJVYsdktysI6yGejiYRn/w47PMw2ElB9aOSRCngZAWLWWykxbR
	OkBu7HLIIfWgT2WbjYCT6P5ekXwIV0nk6S7w=
X-Received: by 2002:a05:6000:1e91:b0:336:7758:c6f0 with SMTP id dd17-20020a0560001e9100b003367758c6f0mr4037114wrb.70.1705437965539;
        Tue, 16 Jan 2024 12:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBEgVRcQZRbRtvwBMA0vTrZAaj3oTq/d687Or3SKsa4+VHQJTpU40PB+JsEyt6A8/iN0r5Ow==
X-Received: by 2002:a05:6000:1e91:b0:336:7758:c6f0 with SMTP id dd17-20020a0560001e9100b003367758c6f0mr4037099wrb.70.1705437965213;
        Tue, 16 Jan 2024 12:46:05 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id g17-20020a056000119100b003365951cef9sm18433wrx.55.2024.01.16.12.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 12:46:04 -0800 (PST)
Date: Tue, 16 Jan 2024 15:46:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
Message-ID: <20240116154405-mutt-send-email-mst@kernel.org>
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
 <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
 <20240116070705.1cbfc042@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240116070705.1cbfc042@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2024 at 07:07:05AM -0800, Jakub Kicinski wrote:
> On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> > For future submission it would be better if you split this series in
> > smaller chunks: the maximum size allowed is 15 patches.
> 
> Which does not mean you can split it up and post them all at the same
> time, FWIW.


Really it's just 17 I don't think it matters. Some patches could be
squashed easily but I think that would be artificial.

