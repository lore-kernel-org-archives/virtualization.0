Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C849AA24
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591486; cv=none; b=UQq5Gskh/LUyGdrgBVCNPl17YbTgAAz568x4+3F4+Iwagzdo7btVcuA29gAYH4MhhJ8Je03vZE1BEcO+jBnPF8v3O3tMMB3RLyDTvnIy/qnyOvQe1pnzG9xgyVjQGN8XqTHihCl41kZBR1yb8UeovkYSUybmtELSvtyV6/JnFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591486; c=relaxed/simple;
	bh=ZcL7dYl+t7tDUahafwYFHtczoNBxBHDjjQvSaDt7MN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oieEO+SH3iGTQMYUuyOWBJIJRL/BI/QeibManOUgdjyvD7rPmvS49YuFNqs4tw1DHAEXhmigP10m7FPuc/QQNFN5PBx9jjyAJBAYnE5ZF75lssf2HTIqwJkq84cwO5ocg/Jda3l32sCRbCvLXCdyziHRlu3lXv7EQeiVzPUEMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KU3X4Fv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KU3X4Fv5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790591484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncJygWXyDwSDtfOrrDTJhD8n3lBQBywOBBfJbF/rpYs=;
	b=KU3X4Fv50FNHhS+tFuSop/PEPrZ/Q0e3qNolHG88bpZ35DWZnn7Vq0UX+FG4mnbIyX3tf0
	EBYMDaAt5kk6vX5SMZDizeCNHdelHA7FFPmaN1E8ib5WGWT3klvoBstSTFgT3qsGzxNz+W
	cQcPrvrflULB3CgvKn7f43MsdsqO/4A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-uofl4OGUOkOzrCPerDuiGg-1; Mon, 28 Sep 2026 06:31:20 -0400
X-MC-Unique: uofl4OGUOkOzrCPerDuiGg-1
X-Mimecast-MFC-AGG-ID: uofl4OGUOkOzrCPerDuiGg_1790591479
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4887e5afd67so2509492f8f.3
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 03:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790591479; x=1791196279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncJygWXyDwSDtfOrrDTJhD8n3lBQBywOBBfJbF/rpYs=;
        b=oSnFsVGihZylfNGnYCfMX3bUA5ys8ihYCG3OQO63WUnUhZTDiooadLt5UJCvmvNiAm
         h7l9/MZOtbrp25sKTY//eboXda7oTYet2QCwL2YA8XEuHuxouSsSf92f63DE1SI0auKQ
         EnTpUkVfcPyVpvtqNa9/x3l8eYJcvpEBO6e2IkBIAprGK4rtxL1XtSyfXUfgXdcDNTC2
         eo/OCIzBZxy3UUs892natIgx2mxD8FqXqRFFSrPJMey5Xz0jrgzuFh0+8gMh1Uq0VZZG
         bbsfcBxPJz6HWYMrkRsfrCm/2M8nmA//YfFdMBlQsiqaQ901JsRuo+vf0h/WpEV44p8N
         tJEg==
X-Forwarded-Encrypted: i=1; AKwUvByK9RIsEyqS4c59t5+fDP1exj1vPxkhiSRsQjiwSAklx/J3faCdlZmv6S5IT7CIrwgH7a7Aa38QqwGW6zWw0A==@lists.linux.dev
X-Gm-Message-State: AFuF++n4onFF0tQQnyZDriUDuHBBGqdtsK+kvHoteWKbwv7dZotyu32Y
	RlqtHIw8EtPgta+jW40X+k4knuCdnA1uXhzkHjZEq64LdXflh1uEkgOqpJgS7a9VdqHasthlv34
	8sTbPd2grg2USIMioiP96bIb/Nmq1wK1a+y1ajWNcRgPCP71riq5k5uEAwD5qGxSLMiUf
X-Gm-Gg: AYBFou14n8dxniQIgkcLyTJbVDix9QDormHY2GspdhA7fyeLCWj58wbsptrF9/l0saj
	iuy+nHKEzIptolCOht2FUuBRf39LKMUZa50Mw13l2mVei59u94QrXkw4wOoQ3wStyA/mkHScC6W
	2yLlaaUOe1s/DN5SPSV9m5V2cY01LIH2uICx7+1TIF+k3hqYIMIIb765YfnT6LL0PeYr0/Cx3nQ
	EA+6cGAUbXrrGcODB+iyJHjNpfjv3EKW2Lzbig4Ji4Y/UlbbIaSeXTLSFPT+aJU/3vC5au1Oixp
	4jPAC4+5WshCgFjU8B8K1mE5W5B7IIzQSXVGTOSGHJLGBRt9DTqvwgRXA6thlwTOOKDnwgJaCy7
	TD8uD
X-Received: by 2002:a05:600c:a10d:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-49fe8bf91bbmr166404265e9.4.1790591479274;
        Mon, 28 Sep 2026 03:31:19 -0700 (PDT)
X-Received: by 2002:a05:600c:a10d:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-49fe8bf91bbmr166403775e9.4.1790591478661;
        Mon, 28 Sep 2026 03:31:18 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.134.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64ed6esm29113119f8f.29.2026.09.28.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:31:18 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:31:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
Message-ID: <arpBYXWb9pohx-8v@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
 <aqp7CV9DnfsG1GJc@sgarzare-redhat>
 <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>
 <arT3jXoS7OaU6Tsc@sgarzare-redhat>
 <6c1516ca-4699-4d9b-af6e-c7762759d495@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6c1516ca-4699-4d9b-af6e-c7762759d495@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IzZftftZTdCBt0m4XzfYwizlTu_xpHL7Ce1xmCDrDS8_1790591479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2026 at 11:26:47PM +0200, Michal Luczaj wrote:
> On 9/24/26 12:17, Stefano Garzarella wrote:
> > On Tue, Sep 22, 2026 at 03:18:13PM +0200, Michal Luczaj wrote:
> >> ...
> >> I've addressed all your other comments for v2 and went through Ashiko's
> >> reports (side effects of lockless peer_shutdown write, imperfect
> >> no-transport TCP_LISTENER enforcement). I've decided to try the
> >> eager-unassign approach. I think/hope this way we sidestep the lockless
> >> writes and enforce the invariant without breaking the API, while fixing the
> >> bugs.
> >>
> >> This should probably be RFC, but I'm posting as v3[1] so netdev's LLM can
> >> have a go (too). Hope I'm not breaking any workflow. Let me know what you
> >> think.
> > 
> > I think you can add RFC also on a v3 patch, just to make it clear you 
> > are not sure it's ready to be merged.
> > 
> > That said, thanks for that :-) I'll take a look today or next week 
> > because I'm off tomorrow.
> > 
> > I'm just worried it's becoming too big for net. Anyway, I'll comment 
> > there.
> 
> Yeah, I get it. Would you rather have a single net.git patch[1] for the
> original report + keep all the rest for net-next, or do the whole series as
> is, but slowly at net-next?

I'd go with the first option. Let's try to get the fix into net first, 
and then move the rest to net-next at a reasonable pace. WDYT?

> 
> [1]: Basically
> https://lore.kernel.org/netdev/20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co/
> + your comments addressed + addressing one of Sashiko's comments, and
> ignoring the transport-reset-surprise one
> 

Yeah, that!

Thanks,
Stefano

