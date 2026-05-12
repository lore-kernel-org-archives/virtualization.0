Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB53AE187
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580232; cv=none; b=XY+GAlwDV5458BGgQBz0WuXE2o04gF6etHhrrodVnM1yJxj6jxV71c7MP/eMxJRpbDn8tQFay330Y6YqmjwYL7ti1jARzyBBVYOgQIINT+advJ+saD0R1OILX+1H0U6cnYeqO92a+KEs8FHoUAtpr2QCWJF0tUHaXm6NrHqo/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580232; c=relaxed/simple;
	bh=Xwy+EHHbHLCBc2qgYzK4qONDiarEocrGw7v3cd+QUR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Si/2lREaG3vkIP4z0IevdRsG6DZJ8KXTmfUNryWehCG4xHGGlP+56lnMyDF2ebWeFnDL4UcmQhNwoYG1OQ61Y1U1lymZ7humYsLdOXjHcQyBN2xGZgghHkj/ghfayq2J4B05vhwIefQeVJd783Su1VKVCxyACCXVGQTjiI2toNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqGqx1VP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqGqx1VP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778580230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa2P4JPNOFyNf5isDuaZw+nHOeelyWmJLKnc0gO81Is=;
	b=OqGqx1VPJIKyB2jw+yZDXMWi6DcPm26g4pQDzBB5YhDmdjvU6YnpGtjWPY6QbV8ZUU+Isz
	QeqJZCSVZDzeDqAZYJTSjxoMo2z09wfPsCXITmYAa72xCPKhO9pHPwqDf9QVAGTkyU9eRd
	A299wcfrJTQOtFISGPfAgAHGw7PzeYI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-RDjSXKB1MeuDKlyBakr-qw-1; Tue, 12 May 2026 06:03:48 -0400
X-MC-Unique: RDjSXKB1MeuDKlyBakr-qw-1
X-Mimecast-MFC-AGG-ID: RDjSXKB1MeuDKlyBakr-qw_1778580228
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8ece46c4ba9so959944585a.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 03:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580228; x=1779185028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa2P4JPNOFyNf5isDuaZw+nHOeelyWmJLKnc0gO81Is=;
        b=BjsgcHsGQc2GpJGwC7K1Pwry3nMZ+ixXJE9/z+T18KaSAsRtasuC7R56jOosghKF4b
         MOmjz1666CrgFj8iFcqn76DZph+Xmuid1yn9H8bsngtDn/S6I9WBOXsFlStkpvSrwxph
         IbeAOmSjjBfBTvAYd3LGjZv88NvGrGC7xw+Nri43MkbXrDDaOds8VTmBvoft24Kh46BY
         ov9bLMFGnfsYbsMfpstZhkCjoVrPFPWSi56RxZ7PfHqHlWLR1bDPRGtDfw5hzrbWg0h0
         fTvgwXJCv00chcK8zuRzSHZFIO537+cD/mDX35Kx58ZaFclJLqeQZVffwxMpf0nbdYfD
         5nWA==
X-Forwarded-Encrypted: i=1; AFNElJ/n2OtpsFFgXFm1VF5TEekNfLveCeooGQY4CBrrEO38ANvTbgHKkyf5FN66/oZ4SJ+1RyUfLRXgeR64hYNy3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt+JzedcgRHhgRPNXut4hvn2FjFzZGWjvSvcPeCAercS90rfMU
	bikk5dnbx0FWEUxjyoplwRkvka+FCJ527q4YgYFiqFS+zN9dCpuYxq3864DB3lkCKDC5f/Xz6xK
	2sCq9myN0Hnzz+VVtIodArKpBxncRbaExILXQpFwRFiM+vJK9g6W/9PTosmRFduUqX281
X-Gm-Gg: Acq92OFyw/7TgH7GgKEDQSWaUelrQ7Hw+9EBTaOF4px359zAxwMeLBEAO5PN7gF8e1T
	acdOAy1YetjkuZuTT5dw9bq9lCqeDVqyfKh67CC0ufDNorrrtCIv9D/uv8IamNB0/tdJtfO8CFI
	//Pce4c5nxtAjm6vumXUBg0on8N9njRBJnWur96fp0dv/nZs5f1ZjqPVfS8hacw7Qy4wAb/G+ja
	I6AQmCijaQ5e1Bz9r2H+THuUwQplEfC/AcP/Y1ZcwL6oO1dSnUoi5jQYm86zM6S71oasX9YWjGo
	hH/o91irMSHQZhm3XcAOLewxHg7aFYx7bgqgrVEqHNyLH/WVhFtCESsljk5BCibp8xWP3xeNvtv
	vuVpp4bzLCC6ATEha8FNYV28ry0GWB4lacyoYpiWeZ0a4bCex2KzFMGtLbuUkOmZ6U8OWXcZECP
	7dOdLeRVek
X-Received: by 2002:a05:620a:710b:b0:8cd:a3ab:352d with SMTP id af79cd13be357-90910c0e948mr1965595085a.61.1778580227663;
        Tue, 12 May 2026 03:03:47 -0700 (PDT)
X-Received: by 2002:a05:620a:710b:b0:8cd:a3ab:352d with SMTP id af79cd13be357-90910c0e948mr1965587785a.61.1778580227008;
        Tue, 12 May 2026 03:03:47 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm3644793085a.36.2026.05.12.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:03:46 -0700 (PDT)
Date: Tue, 12 May 2026 12:03:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agL0ewq9R-Br9mUh@sgarzare-redhat>
References: <20260512080737.36787-1-sgarzare@redhat.com>
 <20260512044008-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260512044008-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7SFy197kvDEKfxZuAt_3rmhiMAHobs08sEqLxDEgRaI_1778580228
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 12, 2026 at 04:54:34AM -0400, Michael S. Tsirkin wrote:
>On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>> buf_alloc when checking whether a new packet fits. This reduces the
>> effective receive buffer below what the user configured via
>> SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>> silently dropped and applications that rely on the full buffer size
>> to deadlock.
>>
>> Also, the reduced space is not communicated to the remote peer, so
>> its credit calculation accounts more credit than the receiver will
>> actually accept, causing data loss (there is no retransmission).
>>
>> With this approach we currently have failures in
>> tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
>> test 22 always fails in this way:
>>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>>
>>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>>     Resource temporarily unavailable
>>
>> Fix this by using `buf_alloc * 2` as the total budget for payload plus
>> skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
>> is doubled to reserve space for sk_buff metadata. This preserves the
>> full buf_alloc for payload under normal operation, while still bounding
>> the skb queue growth.
>>
>> When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
>> flooding where overhead dominates), the connection is reset and local
>> socket error set to ENOBUFS, so both peers are explicitly notified of
>> the failure rather than silently losing data.
>>
>> With this patch, all tests in tools/testing/vsock/vsock_test.c are
>> now passing again.
>>
>> A solution to handle small-packet overhead efficiently also for
>> SEQPACKET (we already do that for STREAM) is planned as follow-up work.
>> This patch is needed in any case to prevent silent data loss, because
>> even if we reduce the overhead, we can't eliminate it entirely.
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Thanks for the patch!  I'd like to split this:
>1. buf alloc boost
>2. reset when out of credits

Good point, also the reset maybe should have an other fixes tag (i.e.  
when we introduced that check)

>
>this way we can revert 2 easier later.

I'm not sure if we should revert them at some point, even though we'll 
be able to handle the overhead better, but I agree that we should split 
them.

I'll wait for a few more comments and then send v3 with the split.

Thanks,
Stefano

