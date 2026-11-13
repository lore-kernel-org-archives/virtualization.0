Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577798;
	b=5maFwXB+A+fT6ZGHH+k/kP4SWu/PdUXCyeN+/qcHukfcXOs6e7lEw1uII/SPnKEG4qrX
	 nBmw8EXXtvdVFevdEFUto0b8xoRWN/6gIKzy3RCCya2KcFdfTH9V3P99E/j9LL2FMtyVi
	 eUbibGXBimCWovvJi+gm5iItCcwmw2IV2mix+PsswKtBMgFgk/xcSD28Ie+4+EKCJv/kb
	 Yv3q9Z20gIhPcPUxUujCVPdq5bEsTYly92HNn0bob9TJL8JqcLbAEzJHfPK8AnMYRRmfP
	 rTJi2/X6hDArgyClkuwAtDromPdrgPpDVeZovDnGXIBsr1BWfIr9gUmms36u0INnu4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577798;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=xgN0V5rhUcAFlCTG0qPtfQg5kIU46HXy61qnWP0q4wtxH80/fVenGKSCviRM5BYatBNv
	 CT+gNcC9EEPcnMOLPX0q4BvB15g/5ThwrsSrhyvVL0bVqieXW/YcXOMv78tvjPQV7FfJF
	 mhgJz1PfEYCHdrRur5npyPzLrHmf5pZHUktxBSqkF1zu1LGFxGWcLWvqD2jfw7eaeInsq
	 +DsZ3xj9E3CNBrsJUb5B5tm7R/f30r9sE8qeEcmPMfgCJ0gRzxAX/zoaEMKDsTmmeMajg
	 550eljdoCIwKA4nbR49oeTsTJK9H02xOwbdaeHlrGo1bFjSR4SOe6mDDQDaaqkPZntQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nm9HVLhB;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23860A5BCA
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 13:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD23860A5BCA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nm9HVLhB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794577797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
	b=Nm9HVLhBrW0HSVFeHhTPubE+0UbsXOp7EDM1au3I/98FgvOCdlu3s+I8G8YN2ZzUkBUwG+
	HvYivZ+rLAPur8pAfldB2TLJ/xBivTIw+dt9zlWkZ+SCVtB1UTFBX4JnYLMGQOswae0MEw
	jM8EFoG9w1RrvK/9E6pvGti8XVF9Des=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-oEnRg9ywM-uAzitSD4WH7A-1; Fri, 13 Nov 2026 08:49:53 -0500
X-MC-Unique: oEnRg9ywM-uAzitSD4WH7A-1
X-Mimecast-MFC-AGG-ID: oEnRg9ywM-uAzitSD4WH7A_1794577793
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91eb0610cb9so12621056d6.3
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 05:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577793; x=1795182593;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8e2MXnw38pYzH1XVs1yXJtejPbQN6bZltGajv/NaWc0=;
        b=FYC4zBdPXI3kfaMiKyOkiKqOe33JTc6djhJlEmnlnLbfu92KdOyTEJKzKspU3gA3aW
         0hFLNPFU2EoKhyi9Ldf9qcfYD1/hLNP+60zmfYD/uGesZZLAZWJrwGyUWnVyf2VuVEcB
         RvTucaIwpIUS27hySkODRsQXVG6uweaFTPi4i/jdzkSC4yaF3H7AoHu/sqwQEiBJV/rX
         jEh2TBKN+DhxlTLz4suH7QZnhUuy7Qde3NoPj9mj0XG/DQqTx2jKc3L3+XymR1T8oOhv
         B6l+jUBVsftCfUOl5+eWofCCwjlwaieWN8XhvaVev9S+G3ObVEmA3vMQu4oU8RjdBu7V
         rdXg==
X-Forwarded-Encrypted: i=1; AL+hErHwwJVEyLYZ55B2Kz36tQvdhHWId9zwv0izr+Gs5m04TMWFNWZE9nw661wIdNXobODYRO9JC0sKfRC5viCo+g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/O6VsFPLA+auev4nKTMORDT4Gz6di9Xs0XVkdn2inIlJcmURbl
	sHRJ70WHVkekbFydoQmSMCoPnG2cUFcbX1xhqkTV0di0j5X3QZgUC+POju53lRExlQYaSHW7avx
	L5L6Y97Fa0qH8D3hSS4FxRcserMYxsZFqVX61OlTuiBaq6fIdPqj0JImMeHTFEdzHpqdIrjSZtM
	f3P1UzaXe44N+NrFVDx76PsL8eRT8wQPxP1FCmLZ6pDRA=
X-Gm-Gg: AYBFou3twRsBAUTPq/Yc5KTcSQzdLBaQcVB8P+yfenukfFdH9eQ9e6khl5Dx3Gq5tPC
	7F/qnjUwj8dZupN5JJZQOq6y2+6UWSsW7OMvwVd8/YjuGl7elCUxGon5/YrKR4Hh+dWZZPWA7Ar
	fl9yVwA2dpGdq6F4wTdBRRNERlSjpqNdhgFllXgaOrneexnB1L9A2pDHc=
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id 6a1803df08f44-91f241f6d2bmr27649396d6.25.1794577793152;
        Fri, 13 Nov 2026 05:49:53 -0800 (PST)
X-Received: by 2002:a05:6214:85cd:20b0:91e:89d8:a330 with SMTP id
 6a1803df08f44-91f241f6d2bmr27648836d6.25.1794577792581; Fri, 13 Nov 2026
 05:49:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Nov 2026 07:49:50 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20261113080506-mutt-send-email-mst@kernel.org>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com> <20261113080506-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 07:49:50 -0600
X-Gm-Features: AclHuK9yYj2AE7jCL2Q7aluEqsTHouql9M7zvOo0Tu9GOsA54iFCZqauW8Q06G4
Message-ID: <CAAiTLFXvuHY=r8FPM7TFNTAO1oyco-brcc6YAc=YN432h87RSw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/8] vsock: add datagram support to virtio and vhost
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ME02J_eYDAeQ6bvEFrZHUX8lcks_H2wk-ZBbKal5dlM_1794577793
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Nov 13, 2026 at 01:47:33PM +0100, Sergio Lopez wrote:
>> This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
>> the existing AF_VSOCK API. It is intended for guest and host services
>> that exchange independent requests, responses, or events and need message
>> boundaries and sender addresses without a stream connection or application
>> framing.
>>
>> VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
>> send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
>> packet. On the RX virtqueue, the device may split a datagram across
>> page-sized guest buffers.
>> START and EOM delimit the message; the guest reassembles at most 64
>> fragments and 64 KiB before delivering it to a socket.
>
> where do these limits come from? how does peer know not to send more?
>

The 64 KiB limit comes from VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. The number of
fragments is a reasonable number to prevent the driver from putting too
much strain on the device.

Both limits should be part of the spec. This is the relevant part from
the draft I have put together so far:

+When VIRTIO_VSOCK_F_DGRAM is negotiated, each rx virtqueue buffer supplied
+by the driver MUST have room for the header and at least 1024 payload bytes.
+The driver MUST discard a received datagram packet whose \field{dst_cid}
+differs from the current \field{guest_cid} configuration value.
+The driver MUST reassemble consecutive fragments with matching address
+fields and MUST NOT deliver a partial datagram. It MUST discard an orphaned
+fragment, a fragment with an unsupported flag or operation, and any
+incomplete datagram interrupted by a new START or an unrelated packet. It
+MUST discard a datagram if its total length exceeds 65536 bytes or it has
+more than 64 fragments.

Thanks!
Sergio.

