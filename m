Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB01AB505
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934801; cv=none; b=BjVJ3gaaCSaagPPwJMW6CfoOHW/hDwLXWf/BhvcYID9CTB4GebKmdpazaZ/Vk17YtnkqpMhcx1HdNF58Tk+VjlYn5ZCz55VyZ+Hc+JfPfw7mCJYO+PO+wUpq1Xm+RlLCCA3qfTgxHDjQimAPnKUFpsM0Oui8ZMzZ2IctzMORGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934801; c=relaxed/simple;
	bh=EcAhnCfMYdSXlmNlommpCdA4tVwrlwjRudKqztdv2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VhNUiMagjSrTiCk5+zYUZCAJlsw3V/4kjsezjlUxfLuqxfOqHfGb7DwBvn5X1Wp3QRQ0qlY1MdSjefmRPy5YgVmINlYFDw7fbm/JFwB/kiudRvxwlu7c2T8bW2N7ac9hXPzaOnpgSApDkmWA0b4+3TgIUDODRD/mOSxNLXil/eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAw9o/mw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAw9o/mw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724934798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r8mPnSNtJ1ADg7xoeNSb8EXicSerPJ5Mj0MvPbcOgA=;
	b=KAw9o/mw903nGZiYTR/2km3QHP0HJs3RObNgsX7NPCyITuxpsMepb6j3uiKwgbO8+Dyazz
	wXUzSzcJYYbLZw1TRjpNKxP9LtjCryASkGBXj0NUekX4oyQE65yogSgGA+96nDkltAJXDt
	5DmFrt2fhpyvqZ3br2tX7BY/wP8057o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-BbRK6c8FNEmbVs1vo5HyGQ-1; Thu, 29 Aug 2024 08:33:17 -0400
X-MC-Unique: BbRK6c8FNEmbVs1vo5HyGQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7d2d414949so55020366b.0
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 05:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934796; x=1725539596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r8mPnSNtJ1ADg7xoeNSb8EXicSerPJ5Mj0MvPbcOgA=;
        b=E7mZk35lKbXcTADwq3b6Ovkfpr6eGqVgZKzKMjM1stFYuc1Tqg1pOnRdSMUCFvfeUj
         gkjvwqh4czBnWkwb3Ce+ZnNZv5mIhUIoAulfKbL3B3m5ydMWHkY5HXeaUNFuEr/U4Wj6
         5uURVIJH8tkcPwAXhQia2CNEIiTZAmjIxKOkyp3x86BPyl+wNqKPNA+H2QodlApBlaLM
         oEiCK5O3uS19yJEbY0HD6eFFXNs3Cgll/iBs0VkdSjpyhPpagCWoZMY7MDmy+gmw7I55
         4kaESby64wJfrinE92e4yk7gWaE4VKVQdDzOC9DBWLxReAVK/dZ8h/LAKATDeY3OBG7E
         wAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqvj6GhxRG6H8CiR7D2L647rf21phE0j+Wze8+WymrMNiTKwUJAuTJB2cAoUNl5GmXjgCj895MlI3zQYwVvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTFT73kd1OgNVtCMV/fEJu3CalWL4mZEHg3CrHcRYwDJgJwfZj
	I/YLnVKg5M3bTGV7Z1HqgMMy9EpMxtAT/eeNZxpMcgExhcbMwg83xk0/f5okWwWbpfxFoaP4xCO
	ddIEsgH0IKvfRpUbURru692BB/jgro1zKe7uSgU3cDXNXHMKhAevAxxevzI0pCGGd
X-Received: by 2002:a17:906:f589:b0:a86:b762:52ec with SMTP id a640c23a62f3a-a897fa77ef7mr195703666b.51.1724934796388;
        Thu, 29 Aug 2024 05:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/JxqSYvZUsly+VKW9p0GbBwk8Ss46rzovAiRElrugRH0yhB2zK0/lvCUzjRHB8flUdXeiqg==
X-Received: by 2002:a17:906:f589:b0:a86:b762:52ec with SMTP id a640c23a62f3a-a897fa77ef7mr195696066b.51.1724934795491;
        Thu, 29 Aug 2024 05:33:15 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.99.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989195e8csm74386366b.105.2024.08.29.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:33:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Luigi Leonardi <luigi.leonardi@outlook.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marco.pinn95@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <22bjrcsjxzwpr23i4i3sx6lf5kkxdz6zjie67jhykcpqn5qmgw@jec7qktcmblu>
References: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <DU2P194MB21741755B3D4CC5FE4A55F4E9A962@DU2P194MB2174.EURP194.PROD.OUTLOOK.COM>
 <20240829081906-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240829081906-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Aug 29, 2024 at 08:19:31AM GMT, Michael S. Tsirkin wrote:
>On Thu, Aug 29, 2024 at 01:00:37PM +0200, Luigi Leonardi wrote:
>> Hi All,
>>
>> It has been a while since the last email and this patch has not been merged yet.
>> This is just a gentle ping :)
>>
>> Thanks,
>> Luigi
>
>
>ok I can queue it for next. Next time pls remember to CC all
>maintainers. Thanks!

Thank for queueing it!

BTW, it looks like the virtio-vsock driver is listed in
"VIRTIO AND VHOST VSOCK DRIVER" but not listed under
"VIRTIO CORE AND NET DRIVERS", so running get_maintainer.pl I have this
list:

$ ./scripts/get_maintainer.pl -f net/vmw_vsock/virtio_transport.c
Stefan Hajnoczi <stefanha@redhat.com> (maintainer:VIRTIO AND VHOST VSOCK DRIVER)
Stefano Garzarella <sgarzare@redhat.com> (maintainer:VIRTIO AND VHOST VSOCK DRIVER)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
kvm@vger.kernel.org (open list:VIRTIO AND VHOST VSOCK DRIVER)
virtualization@lists.linux.dev (open list:VIRTIO AND VHOST VSOCK DRIVER)
netdev@vger.kernel.org (open list:VIRTIO AND VHOST VSOCK DRIVER)
linux-kernel@vger.kernel.org (open list)

Should we add net/vmw_vsock/virtio_transport.c and related files also 
under "VIRTIO CORE AND NET DRIVERS" ?

Thanks,
Stefano

>
>
>> >Hi Michael,
>> >this series is marked as "Not Applicable" for the net-next tree:
>> >https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
>>
>> >Actually this is more about the virtio-vsock driver, so can you queue
>> >this on your tree?
>>
>> >Thanks,
>> >Stefano
>

