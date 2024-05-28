Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16FA170851
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911628; cv=none; b=jamLzlGOhiYdWuPnh2WtPA6OYUBO0QoMDGQICHHQTjJuK2DgW7eM1PhtoXK4lq+H7E1xWPSHUTXDbOtwXDcAoC6wI5Za4WIoqkJ8TfAA+Y4pAvcEwLOsIdmFnDNLt0Fz9sifTO0rFqHRO+MbvJo9k6ltt0C0Cxqye/cPZ6G3wwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911628; c=relaxed/simple;
	bh=y7YuDtQgxRfSbBa7toShtRIm2E6Bv+dnsZdEb3xdJ0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=APLsQnqMugNG6/+EEOki46/HDtbYq+/fB9dqu8x9GEJAFDt0yjrmuqvVik9jaFuuu8MhZo3uT9Qu99JdBVU3uPehtyIW7jz40yCDlHGfEzCctuhHyi9H0C9YjoeDM262r2QTf/uJWvgaGONGIrPGoxkh7UD58RGaU6g6q3kRT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOVpozl+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOVpozl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716911625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qccAi5B1VCjUOrYtnT1efzRA281Zhfs1D8aQKp+YfOw=;
	b=AOVpozl+ay2ZsdSfpd3lQ4b+hI7fQS41tPBR8TkbMxwpAChAJuhCSproDsLMViX2bq6Vy0
	aEbl4qUDAsMLeDDmzEO+vKI1B5APWKDQm1GSjwkoQLNph9/WNh9Zm3dnESsFqCHMbRTbnA
	e17t9EwN6tUvaQpOxdZ3PDvbSGPCrMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-zrjHnsyTOEe_rnAT668m2Q-1; Tue, 28 May 2024 11:53:43 -0400
X-MC-Unique: zrjHnsyTOEe_rnAT668m2Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42108747903so5814175e9.0
        for <virtualization@lists.linux.dev>; Tue, 28 May 2024 08:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911622; x=1717516422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qccAi5B1VCjUOrYtnT1efzRA281Zhfs1D8aQKp+YfOw=;
        b=fFXmIxWA92JMGuCa7MV1HscR5irVxpTKKAmt4hV7pp8ObCctVl4hoMLmjRe17qHZ7F
         RtAEQWUedpxQOnVO8LXA8JtgCRhffuJaoiJ3CeDssEKrxFHlZ2WIDFG96HJ0LlZXC3s4
         LEEfrSVRvJhFL6g0Y1aDTJDbSFQKTfxPh+kIcCorinCZ4hBTXDrbRmcdKdQ0etyV8F+W
         R3kkFoEhAJ0+M8mdEPnjVXFshbned9/V/4G7y3YLm97EPcuOCl2/dC99COWl52KALxWr
         euLKv57ikPxQ+YFmWWJ8Qzn003G1ftvn0yNn5GAgnIAKhC6k3Bwi7PHL/s3BuN8Lv+FY
         OVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcKZdz0s6/39qpqPSCcJ6K00raOwuUSDSp63jay78668MrkYeSbBHkMxVRrKdL0ifvPbrI/5jM5j/i3SqpdGhjbbQ6VgJPoFPpRyK+YjQ=
X-Gm-Message-State: AOJu0Yzx30eytYhEVZBAPPPBPFvVx9iTDZV62kxbhyB24j/mr7jZ44bt
	b7ISycRJL76SEMa/WInGLaa3awjI4aIEdpLJvTe/dazu7veTBHKs7rj2ASwdGbwAs2G1OcANzpt
	dY3tDlG+OiSyVn38JUE1DsGPxByaMjSkj3C+6DbRkVeNArCKgLXt0yyK3HqxbsjX/
X-Received: by 2002:a7b:c055:0:b0:41b:f788:8ca6 with SMTP id 5b1f17b1804b1-421089d3a7emr107474725e9.8.1716911622387;
        Tue, 28 May 2024 08:53:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD2OMInNWq6yQaRzZXCjnFU9/PXI/Wa4TGh9Ezt3bZ+WCEaHgbotbyfhcZckLkeDqOCUPskw==
X-Received: by 2002:a7b:c055:0:b0:41b:f788:8ca6 with SMTP id 5b1f17b1804b1-421089d3a7emr107474455e9.8.1716911621934;
        Tue, 28 May 2024 08:53:41 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896f442sm146076325e9.11.2024.05.28.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:53:41 -0700 (PDT)
Date: Tue, 28 May 2024 17:53:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Alexander Graf <agraf@csgraf.de>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, stefanha@redhat.com
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
Message-ID: <sejux5gvpakaopre6mk3fyudi2f56hiuxuevfzay3oohg773kd@5odm3x3fryuq>
References: <CAFfO_h7xsn7Gsy7tFZU2UKcg_LCHY3M26iTuSyhFG-k-24h6_g@mail.gmail.com>
 <4i525r6irzjgibqqtrs3qzofqfifws2k3fmzotg37pyurs5wkd@js54ugamyyin>
 <CAFfO_h7iNYc3jrDvnAxTyaGWMxM9YK29DAGYux9s1ve32tuEBw@mail.gmail.com>
 <3a62a9d1-5864-4f00-bcf0-2c64552ee90c@csgraf.de>
 <6wn6ikteeanqmds2i7ar4wvhgj42pxpo2ejwbzz5t2i5cw3kov@omiadvu6dv6n>
 <5b3b1b08-1dc2-4110-98d4-c3bb5f090437@amazon.com>
 <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
 <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com>
 <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
 <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, May 28, 2024 at 05:49:32PM GMT, Paolo Bonzini wrote:
>On Tue, May 28, 2024 at 5:41 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >I think it's either that or implementing virtio-vsock in userspace
>> >(https://lore.kernel.org/qemu-devel/30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com/,
>> >search for "To connect host<->guest").
>>
>> For in this case AF_VSOCK can't be used in the host, right?
>> So it's similar to vhost-user-vsock.
>
>Not sure if I understand but in this case QEMU knows which CIDs are
>forwarded to the host (either listen on vsock and connect to the host,
>or vice versa), so there is no kernel and no VMADDR_FLAG_TO_HOST
>involved.
>

I meant that the application in the host that wants to connect to the 
guest cannot use AF_VSOCK in the host, but must use the one where QEMU 
is listening (e.g. AF_INET, AF_UNIX), right?

I think one of Alex's requirements was that the application in the host 
continue to use AF_VSOCK as in their environment.

Stefano

