Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10E47B425
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628657; cv=none; b=dOFWTh5fQG1C+DsrGKztTxLsCGRINEKQ7b7FilsQZotPKaV25SzdCM4e6V4ryIDEmOO0+ICY6I6FfplYj7y9gVoWKm9zVpDo3xpL0X+gouvohcCZ7mNvVQ2VlGbmmn2Ts8S0qPSM51bA3T4XTgkLtPPdLRcvrIfe+/QezEGtpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628657; c=relaxed/simple;
	bh=udnHtGFPyz7hbUEOMNqTB0aEs+NZ+BXBJ7nkeUP+vq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJfVcJRMiZXcGuV8K1PDSzY3O9GUo/MQfdzoL5RH+UAxt/dnfgZLyArewtn0gJCoriFiS4LYeUAGXPFPdTzCbL0LU8J8qzyVW+DaKLD7snV5v5iRZP+mQB1fVJGJcgsdJADArusYdkrssk9uu/5cWdKhpiEM7Ka3DiXnPb9ewgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPIhmaxv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPIhmaxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784628649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JIme4w5kHzDPPwLxsVuz+NEgaFpd3AeI3j9Me/sme3c=;
	b=BPIhmaxvzL2I2dLpiYliZUi4Vl3ZZ4XlkVerlgwPOZPkJWi2Y1ISJd0cWs0YAnebMUBHLs
	AswKT4SnUMMdZgdYH/G1aRIo3lrEiBGsh/jpaKC4OAwGV8QtszB8pErhOTs5TBMLnzlSFF
	aIrhryRhmtKfKchb37pLzkWcxAxuFK0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-s1G_9oaZM8-zFEiltlg_Fw-1; Tue, 21 Jul 2026 06:10:48 -0400
X-MC-Unique: s1G_9oaZM8-zFEiltlg_Fw-1
X-Mimecast-MFC-AGG-ID: s1G_9oaZM8-zFEiltlg_Fw_1784628647
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955d314945so13359815e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 03:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628647; x=1785233447;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIme4w5kHzDPPwLxsVuz+NEgaFpd3AeI3j9Me/sme3c=;
        b=ajJ50JugNNJJaV8CSl8f6I19iZHDYlxn06SS/Iq7zSgQWCJ/xxxp8Imn+imzNMv6VT
         47OdbpJW5ityUVsi/1qN455ge9QfesZTd1FuNlk9ziX78LgSWI7o0SP6bhzaKwQ5xiYd
         S1qsEZSzax0EP9ADeUTkXzlD2b5Jlaakv23ucNuZCAcPWy1KRVHZ8WPEHmvZH1vBkvgN
         gSvygnjqiHll9eyrJDO14oPCPM9tLBPBfZi7/3MolIU7mczN3j0Md1wJohJXxextg3wU
         iKktEBMrNkcOdFZ68mJ1OkAIuVGAHKkVjN5gwQ+N/TA1ESCYMKdBaj6OxFs5qNq14zQF
         Ei4A==
X-Forwarded-Encrypted: i=1; AHgh+RqZbtqNqzbxreSDMCETHDOdeReeuF3wctMvv3KfuwUVmQxATjImojBCIuck2FRRWD70cnOV0nx8Ii6YVRVU7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZcGycRUhReMSix92XOeP0ct1UPWpcVNRVMQK+tVgyD8TdXqvO
	D9QwmHxSawxJKB43dZpYBUUEdAGw3YnmzkpN6xC411PKYy6VH5O/hXKSnJra+qQwbTrwK66a8Nr
	skJRw3rDCWqMg4cGOUNi4hj5FqQmV7JE4U0d9abS25CjeQpl7ADzzOrbB7jptLxD3U5ko
X-Gm-Gg: AfdE7ckGf74sC6d78qxgVaLfemnlQBx4jklOg6hzu2Ib0zl9t0sj+ERoiRV54xGAnDX
	pR2dJuRFapZS4GRlkghXnfmkOltVH3fGTbTtCYaFlCtAnqQt7JLwy+yILrm35BTxEA1v+3kyfN5
	ndKX7JMepHBSb9iviu0jDKQceFcp926ZGeRE9cYAsIIsVUXoSJwdhm0i/nUYlcfkd+6Eb3JppLm
	ZjThLavwJBd007nrj9ebSkw6ZXKD0KxM0X9YZ6Jy3fPyJwD/kuogcL/vFRGUzubdSLuw983ZLBz
	b/yZX7lk+QrbsgPB7gT5TaVakNPyYnUGQWfnrHXQHWmdgKi2yeY6YbuVE9iWj2dxaOee++8zEOJ
	Y9qoi3ec3iLsJ7rO4kV4lHm/TO3BN6TZosJve+d7fE81XCL9ANOGnjhVxOQagFwzDnXh0HQb/hd
	btUQ==
X-Received: by 2002:a05:600c:b96:b0:495:4b00:1bab with SMTP id 5b1f17b1804b1-4954b001c39mr194096985e9.21.1784628646806;
        Tue, 21 Jul 2026 03:10:46 -0700 (PDT)
X-Received: by 2002:a05:600c:b96:b0:495:4b00:1bab with SMTP id 5b1f17b1804b1-4954b001c39mr194096515e9.21.1784628646245;
        Tue, 21 Jul 2026 03:10:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eea8afsm39599963f8f.33.2026.07.21.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 03:10:45 -0700 (PDT)
Message-ID: <68b5a2f9-53c7-4b28-ac8e-e61a39dde118@redhat.com>
Date: Tue, 21 Jul 2026 12:10:44 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
 <20260708065853-mutt-send-email-mst@kernel.org>
 <ak9h1kWcLmpP74PI@sgarzare-redhat>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ak9h1kWcLmpP74PI@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ONJ57FxjZ6kvw79oQ-ucvZuQljQE5CgR6vdCZB_C6Vk_1784628647
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 11:17 AM, Stefano Garzarella wrote:
> On Wed, Jul 08, 2026 at 06:59:41AM -0400, Michael S. Tsirkin wrote:
>> On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
>>> From: Stefano Garzarella <sgarzare@redhat.com>
>>>
>>> Add a test that sends 2 MB of data using randomly sized small packets
>>> (129-512 bytes) over a SOCK_STREAM connection. Packets above
>>> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
>>> forcing each one into its own skb.
>>>
>>> Without receive queue collapsing, the per-skb overhead eventually
>>> exceeds buf_alloc and the connection is reset. The test verifies
>>> that all data arrives and that content integrity is preserved.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
>> trigger?
> 
> Currently, with the default value, the trigger is practically immediate 
> for packets between 129 and 512 bytes, but yes, a smaller buffer size 
> certainly makes this effect even more pronounced.
Given that PW is quite in a sorrow status, I think a (net-next)
follow-up is the better option here.

/P

