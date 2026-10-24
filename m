Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858819;
	b=XSlhOw45ypDNLVo5YFX48j7ocnaW3k8hVGYWrii3nkqM3AVmEWOPOy7rZ/4xQFI78zbY
	 C67O5kHWeXq2/KRlNXu0a3xoyhRIaMGKFoCL1WC06L+lMlVWJggF5J7gB+fIA10rfbKXf
	 yCrFIp63wS8rBmF3Doc9Pr2ug637aT7nxixofewFSfL8zI5dpJjMmM9SorCB0kkWieD03
	 qnGMV3CI7K0ntqFHTMws4z/qBdtBr4ohhjWMxXqeJ8DmJHEcHb/WNCVKCeyl/LOLtUxhZ
	 RzrsCJDRYAPw/j++2VaCyJ98nIrQkROLoG1iExXLhaixVgElJySGVslwgkJWmpAZmGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858819;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=JnidHUsBQArt33vLjV0kqnv/bWxmzPm4EkJn55+rvF0=;
	b=zrtiAeO1HRa7RJqqYMFeew9O0rqnnTRegeYp24+qwd++vWr92iLdRpldJbSbaPJdxLrm
	 wU3o/DSNuzqXZlsrJI6x5nKad0NE1AnFclhVLdDPjZKo1j102lcqxwftidFwxq4ytcl+t
	 mc+CWHYYvmvtq1DrrYBjcZF8LSNHLP2x8V428BA6kDre8S/skFrxpIVYKM/xXLczC5c9N
	 cRps/WTA1Yw9KHmMjq73R7b4rdF2oK3jV+QgIDCGRzzheXO1/xR770DwU8GLnbVHNBXM3
	 g3NW783K2nLgVtBYh+9h2W+Tcc7g2xZIph5MUBOAlVL83lDRTNpsZJfjy3OB/Q/mEkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYjbY+Ni;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592D606A31D
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 16:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8592D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LYjbY+Ni
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792858817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JnidHUsBQArt33vLjV0kqnv/bWxmzPm4EkJn55+rvF0=;
	b=LYjbY+NiuAzlv1S0TktrcP/XaFUeM7qeCFX6aOm0YNJMr00LCp7a8SxFM9dLxDs4XOc4lI
	4DuvNn0Gp+0vKZkIadnmEtlUNXRXPkdNbb4spTumNa1dsCL8QcOeN+FfyEiTX5jSGVepSy
	npmCeYTjczzO0S2TagjkCbN4SvT5IbA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-2Bc0Y7mbM6mojK5WU69q9g-1; Sat, 24 Oct 2026 12:20:16 -0400
X-MC-Unique: 2Bc0Y7mbM6mojK5WU69q9g-1
X-Mimecast-MFC-AGG-ID: 2Bc0Y7mbM6mojK5WU69q9g_1792858815
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so1534458f8f.3
        for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 09:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858815; x=1793463615;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnidHUsBQArt33vLjV0kqnv/bWxmzPm4EkJn55+rvF0=;
        b=TymtKqXybpN1Pc8/AMfqeDi9MY6bl8NDlcjrqzLot56aD1W0yI1GQgZlSPSiAEGStQ
         9HWMEAAvCD8nL8W2R+jVZqsqH/8M+Wf0mnU/776VgyBoW4nIJd6o2tHJ77NiX1MoarG1
         VtsUM3HDUp69Am50IHs6rAtjhN6A4rpD9mcdJH0WosDZnoWXIP8j/Pw6W47fWnI/v4fa
         eGfKrxo7qX/IxDsgY9V23Pt1+h2Wxt/ICjLqko1AW8KAK6kYvwkjreyZpnqpZsXToMoX
         8C8WQ7okpEuaxAWmG5tBeMaC6dVJK6Rf8apQks0JPqFwlGFYC1jzoz0/S7dZ33mlMzOO
         o/Cg==
X-Forwarded-Encrypted: i=1; AKwUvBzSQmDWUXTiB0T30IH53nWi1zBchIuyYfGnZCtBT/KYbnlTVG5lkTcgJvDTwnLDxAU5AbORBg07e9/MJBLCJQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJAnrgAjSrOFW+nbc+pGyJ2vzhCWWPs1DMhatu/qyAqhELRvTp/
	HSS6dwR9u9UeRRS2x/TTqqqxl5n/ka/W1PSelklC1WXWWz3dxkYi2SwPwqFYhzjk2xssKwoDo5e
	ApJNu+9Q/PLT9E3vPXJsEEwLK9xQhSoAoFxjWYRYuRcXJ6EEGDL4AEers0U3OZosSrRZn
X-Gm-Gg: AYBFou3RJrHd6uN/YGBe4smMuztWWWIDij2ZKWPebZ765gXhzjbRoI7tfysDPQqO0oM
	Ekqx3pqZlwvpjUCIqChzFLM4B0OXm3S6PFfhVSDYQG1E8nxvqwf0pg6chUKYDuDju0zdvTm2CzK
	dSktRdDoH7iOgrwRdCoc98PD4eSHSlB0hCW/Awan/KZiAntNl1nP+l1k670LLCIxQGXhICYWCVB
	R/yO7Hg6u/lKbNw0d5dhEsqx7Ec3sefxYAhdIC02P6mAoIVoFZaM1e6KLyIO0OP3X+aXOxXBOSh
	B5YKKbh+xKklX8JhRRQ3FBl4p9b+VYahqCg71FmQ5A/5TKUriAe/mfci4JJrUSrJvKI9YwM=
X-Received: by 2002:a05:6000:4b1e:b0:48d:df08:307c with SMTP id ffacd0b85a97d-48e3eb94526mr3420686f8f.44.1792858814508;
        Sat, 24 Oct 2026 09:20:14 -0700 (PDT)
X-Received: by 2002:a05:6000:4b1e:b0:48d:df08:307c with SMTP id ffacd0b85a97d-48e3eb94526mr3420647f8f.44.1792858813925;
        Sat, 24 Oct 2026 09:20:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm4812439f8f.59.2026.10.24.09.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:20:12 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:20:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net v6 0/5] more virtio-net csum hardening
Message-ID: <20261024121852-mutt-send-email-mst@kernel.org>
References: <cover.1792768096.git.mst@redhat.com>
 <20261024113809-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.288f04be304a@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.288f04be304a@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l-fmylGMLv61gJJkJVmcD7sYmFMER62FBBgUr4UZhfo_1792858815
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 24, 2026 at 12:08:55PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Fri, Oct 23, 2026 at 11:09:17AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > Okay this seems to be converging.... But sashiko did find some issues I
> > > thought are best fixed. Specifically I thought of a better way to handle
> > > short gso in a tunnel - just clear tunnel gso! As a side effect we now
> > > fix up the checksum for these dodgy packets like we did before, instead
> > > of a drop. Good. And more false positives that prompted me to write a
> > > bit more comments. So here goes.
> > > 
> > > Apologies for reposting so frequently, I know netdev bot will be unhappy
> > > with that.  But Paulos's report made a lot of publicity, there is a lot
> > > of people looking into this, so I feel there's value in defending
> > > against all this class of issues sooner rather than later.
> > > 
> > > The issues were mostly found by code inspection, but all reproduced by
> > > me in a VM.
> > 
> > Ugh. I found another wrinkle( Firewalls that shape the payload.
> > They are currently seem to simply be hoping most traffic is CHECKSUM_PARTIAL and
> > only looking at that, and that will break.
> > 
> > I am not sure what to do yet. Extending the sysctl knob to control what
> > happens if validation fails: pass/drop/complete - is the best I could
> > come up with. Or ignore the issue. Or just forget the complete at input hack
> > and drop if we can't figure it out.
> 
> Sounds like such users will just have to disable the sysctl for now: pass.
> 
> And update their firewall, then reenable the sysctl?
> 
> Does adding a third drop option help in any way? The sysctl is the safety
> valve to go back to old behavior.

Yes, maybe that's enough. I was just hopeful there's no known broken
valid setup, now not only we found it, is is actually unfixable (
Still trying to decide what to do.

-- 
MST

