Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703478;
	b=k1XUf7hyJsxyK/xIa4loqB5zA7B5fbOx+qFP3Gz6J3YoIzWuizoMieGGRMLgnjuGVcyd
	 njSaCBN909tiKih/famqp3Fk4R5UUfE5pMRl4LAmFv+VyJN6Lk3WTLOM/Ds1QAojtn6Li
	 UnenP1k5NpASBXXtGLPCTYuqfNwAwpmUcCQUJFWYqB1OfG4ckX1aegq/SmxDsDKdJ3Rag
	 tgCZ2wiyh/ez9FjS2rOeOPRbrO0OCt6NyhsZZfAq0TJlIOszPcwi/81tXNddcHIuu/XqE
	 340CHu907/q2dUgnh1rKDtzVWVlAMWk9tYKcThB0c0DRYGn3PNVsrk//DQbvTAb7IJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703478;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
	b=eUGn8zAY7ka3V0Jw6mrCUpr/wP4yEyyX+n9JG9vOc/yutwx01fd+/kbsJ0Aw2XuqWarP
	 S9ujj6aP5yS8YS5SrkdNVCHDKJGi8s8+qvhEn00UcHBWBbStyn/WwaVJS6Zw+tiUotEMm
	 ckwKJjJqJrgbqaTGzPSHH+InpI9HiqELvwfTOZOyQLY/MaTAAhxgJCthP6LbULmtelSJ5
	 mSV7S5meRkefDcS9olS1nDc1B795i4A0+vY/6FbJFpnD/3Jf4GKXimHXc3Ryyt+FQm2fQ
	 +Z8Xk3pwaSOjcvUfPCxk3+hM32Dhe75fgDjZDEtEtkS6hMWKb/MIKD+4CGz8iYvBJWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBa7T2lO;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49276606C5B5
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 10:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49276606C5B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBa7T2lO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793703477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
	b=bBa7T2lOJ+4pF2WLhuJ0Y1S/bo5D48zOxrbNpkeP0iS0LOi67rlAAT3sznN229mI9G3Cy/
	kMYmP/+nP8amZ7BywKn3sLSxA80NwooEqQggcMYv7ZUw/iT1mPr2fOtMRvjlPCJX6AHSyq
	apDQurP5hOTmEwx7YKaWSiT0Kzlockc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-MHMw55lTPxeiolchl_K-PQ-1; Tue, 03 Nov 2026 05:57:56 -0500
X-MC-Unique: MHMw55lTPxeiolchl_K-PQ-1
X-Mimecast-MFC-AGG-ID: MHMw55lTPxeiolchl_K-PQ_1793703475
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b00febba3so2752211f8f.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 02:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703475; x=1794308275;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
        b=ofjD4r6MPmSfYcICC1MpmAkgp4txDyob5MWAUZOkqOS4rqPgUKqv4cy14F9rUUTZ31
         GtfDAx09dvDhbNswtRl+NSYhhEJ0kM1BzYFK0SFHwAeoIJOFzrf0V1GRy422x3EtD5Ub
         KzP08aNIVzOEAgk1DDLGsCTIJH7jpw3IRdC2cbpxwjQ68ivZWzpB4GThPB9uat8Tq/j1
         B9ZEbdajlqPvKWeFbW+z6l+xKuFSIesQ5RWxt4S5HhPN57+0Hev5keN+N0TRCLxDX3tG
         +HAxliRz5vL7K9D/TxXqid28Fwsc4cydau60C/rEQ2KrW2Ctn27jZyq0zQ8X0jdRYeA6
         fhsA==
X-Forwarded-Encrypted: i=1; AKwUvBzbM4IV20BYiHgro+AGTwUgiP1XdYDKFT8kxHIz4wVmuwxBKJqk2dLQXomQnnfkadLgayvD4iwGD+Hgduo6gA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8GELegocUZmUNsrpSLBWPExrih1SDNueeXmigNplbYbQ+RGbzv
	tO4bw2A44TeqPNchCr7jhUts3XykKLE6cm2fUzf/4hyeX2nZC6fwYdpUUtPIUbgeFTFL1G6QkTS
	YUjh32VCddmGU2jMnJ3U74tLdZA1XvTjJ9JEtkhmyYlqwmPGUbz00tCPHEIOqAuat4gd2
X-Gm-Gg: AYBFou1qeIInGd5JhSwnD0t4toiwG/axOwWOxyAi7BvnycFh8X/sngadU5xNeOuGGSB
	TS/n+AhDrCFUyEFSfZGq27WSQLUI/j5Jf2JacZ7WXRSAsf+BHMmfHgNruAu05m8tXBipBJ25530
	SCCl6OudPxfzreR0BPQ4AYWDX46fMZ/5iRBB4QrqhH66YvPQjd7BXQAq6chIIiAIUqiGUDoExNk
	xBWwHy75BAbw6aTPbwvYuOaIDee0j6Xt+SF8/RGopWagQgf66JtS45piKdIkkeAaLIbKJZItsLQ
	6LX2E+1bRtQolxFQulH89kiymEXeSvv8OD6PnSgdIDVQtFUiCcJ+GEqgRunmmJX4IgrZYjQ21tF
	Ct5Ptqrkt3DzOuG996liss5uR52Bxkgj4WIaIfcKs5Q==
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id ffacd0b85a97d-48e6e2f6620mr27753775f8f.19.1793703474656;
        Tue, 03 Nov 2026 02:57:54 -0800 (PST)
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id ffacd0b85a97d-48e6e2f6620mr27753733f8f.19.1793703474133;
        Tue, 03 Nov 2026 02:57:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm24257782f8f.43.2026.11.03.02.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:57:53 -0800 (PST)
Date: Tue, 3 Nov 2026 05:57:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Message-ID: <20261103055650-mutt-send-email-mst@kernel.org>
References: <20261102122942-mutt-send-email-mst@kernel.org>
 <20261103032935.58823-1-fangxy@xiaopeng.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261103032935.58823-1-fangxy@xiaopeng.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rcQT-_-eh_7B_6v-ZtiHnezyA0FPFAJIOcRQ1j4WyeU_1793703475
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2026 at 11:29:35AM +0800, Fang Xieyan wrote:
> Hi Michael,
> 
> Yes, same fix - sorry. The October 21 posting is a duplicate
> of the v2 I posted on September 26:
> 
> https://lore.kernel.org/virtualization/20260926160755.21485-1-fangxy@xiaopeng.com/
> 
> I resent it as a new patch instead of a v3.
> 
> The !len form is equivalent to v2's len < sizeof(struct
> vring_desc) check when combined with the modulo check -
> zero is the only length below one descriptor that is also
> a multiple of the descriptor size.
> 
> The diagnostic change is to pass the byte-order converted
> len instead of the raw desc->len, so the reported length is
> correct when the vring byte order differs from the CPU byte
> order.
> 
> Would you prefer that I send a v3 on the original v2 thread
> with this diagnostic correction, or should I drop the
> October 21 posting and leave v2 as is?
> 
> Thanks,
> Fang

pls take a look at my tree, vhost branch. if you want any
changes made wrt that, pls let me know.

-- 
MST

