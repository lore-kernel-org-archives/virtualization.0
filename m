Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD93F104E
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244411; cv=none; b=ZN9Ogsugywgly3feBPm5TlXnjRrjHLb9zMakwCMwlpgUqokTYQ/shvsA91T5aGaXm8CwKNj5X8w7GKM+OC4GUjVS+ssRqz9o9KBBz2rXqqeBtiNJZ6K6WJV4N7ci97E++3x8zXM4qE4TX53xbnbYPCS0nmzH1u9qdRR20QJvjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244411; c=relaxed/simple;
	bh=GFNtRpwPhMu+eKoRMyqSl+twdGE03Nm5JynpYuuyiKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AHqtO/YExjXDh1/kwaLbJ+5haUmIxUrVbDTGXF8W8FAygScmUJnJB8VZ27BsJaWqWM+WbRXPVTkUVnFobX0gYA1AwkxBDUvg8oe7JcctBUqt3DOHKVZiOg4ysznjjVvhLMAGiC4kaw8Fw0BJWeUGqqVuP0yXdmP7XzhaqANgiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUxElnsw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUxElnsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790244397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1Visdhzs5DmNU4T37TUFkaK4VZvm9Ag2DOzaMeHKOM=;
	b=XUxElnswCdpXfgtBDEhkIkS/NaODd5XannVh+QvFq2XuIr/kLb2t5qLqEkgKpT2hlanesH
	9wo9/X5r4jQCAMuXGzUBJKDlJ63WQ0zjqjO9IX24yrhc7lNpb8w82wZirPnnqb2ZWy5Lka
	rmTkbvoCpDF3x5p0E41bCz5oS1NFxl0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-FlmO7gnINzyTUdL_ahrjsA-1; Thu, 24 Sep 2026 06:06:35 -0400
X-MC-Unique: FlmO7gnINzyTUdL_ahrjsA-1
X-Mimecast-MFC-AGG-ID: FlmO7gnINzyTUdL_ahrjsA_1790244394
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so15026665e9.2
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 03:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244394; x=1790849194;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1Visdhzs5DmNU4T37TUFkaK4VZvm9Ag2DOzaMeHKOM=;
        b=o9BofcsWTeY3mlyR5JI6+7E/0sH9rXbjJF0HO4uOWpMv16a9hio7cKpLHI6Td+TZsV
         f2OIy/I708k1J0ryLDX0qiTOOZiVVfvUn4InpXhCgnr/rX7Vgd90XeJcvp0Gw5MZE5ds
         JczhfA8fnJZKgJ5g1N4f7AT9DQrfRTLCwMlwF/QGnHWqRb6rahXOP9q/irT+RgWgagGE
         ZUg40mn3ylKrZaXVkyH6nbITrvCsSIRCSN1VHXI2qCHhNM0kU437/QMVrMx59s1jIc4A
         BcjaqquEbJpPRPZMCn/jIh0pfTAMJ15AvjCbb+8EfC8N9AlV69/weLQnb7q+vg+IIFRJ
         gY5A==
X-Forwarded-Encrypted: i=1; AKwUvBw1gy6oWtq+DwiT58KeMD1bh9wh9xYToEZkGvchqWXMKXA43gzOnkJ1DdmHO61fRIrke8D/GBaXONYGqoKAcQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kkXQydgCmBensAJKZd9Iy+wVs5rhQGIcjZUzdcfTskhnzbt0HO
	R8uPAgT18rhS5ErP+W9XEZsrGyKBq1CngxtXPPLrSCm3HVv8kQr1cRJAWoD2marBJKj4GqA6XLi
	Qmesuk1BmJ6fN6uiauOl+3h9YSHEHa8Qt/0GnBKfOrveHs+4Eke/lttAA1vsIYEWGLLLZ
X-Gm-Gg: AYBFou0xdU6rsEVljoTRNWQh+heqZ0HuuY2pirxUAa5XYfgDCbHgad4bKeZwWWXcwOx
	xeHsrgeHocchX+XLYNZEZ9TilICCoAfUojwgUgPcieKVEsWKKdbgCbcy4HtKh5IBZ7lVHpBhy3K
	nQqUzJR71s81geyqqdgElvK+zS9UL/GAvcFP/UNow1CBg2TU/nqCcJ9jxpsNIq0GLGBupHczBJf
	nmYbano7zYP2ZVmun87T54sKfdJdexs21bypWu55vy4QFKOPlNdiW274ZwsvNtAh0O2mZiAZs0y
	5N5Md6gblLas5Q732pmUB0/pcx757aeZXiR10chnu9gW2sPOFETnDwd1SGe12SoHxpp7T7KaAZe
	2108qbCkDmiEjf1iMZ+JwfGZDJvlv+f5QLGP+L+cZw852Nx6u0zY=
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fe66841f8mr32855065e9.0.1790244394274;
        Thu, 24 Sep 2026 03:06:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fe66841f8mr32854435e9.0.1790244393834;
        Thu, 24 Sep 2026 03:06:33 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48867b49661sm13003456f8f.0.2026.09.24.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:06:33 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:06:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
Message-ID: <arTwyyLVU3jM5fTA@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
 <aqp3Po7OcubJboM_@sgarzare-redhat>
 <3cbeb82a-60ff-4129-b630-5404df1f689e@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3cbeb82a-60ff-4129-b630-5404df1f689e@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jJWRZGnGLuZ0oidBWM-Q12GZt5VhaEjk9NP-p3nTiyI_1790244394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 22, 2026 at 03:17:30PM +0200, Michal Luczaj wrote:
>On 9/16/26 14:30, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 03:15:13PM +0200, Michal Luczaj wrote:
>>> Follow vhost's vhost_vsock_reset_orphans() and VMCI's
>>> vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
>>> later in the series.
>>
>> IMO it would be better to include the reason here as well. Every commit
>> should explain why doing a change.
>
>Sure, will do.
>
>>> static void virtio_vsock_reset_sock(struct sock *sk)
>>> {
>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>> +
>>> 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>>> 	 * under vsock_table_lock so the sock cannot disappear while we're
>>> 	 * executing.
>>> 	 */
>>>
>>> +	vsk->peer_shutdown = SHUTDOWN_MASK;
>>
>> In all other places we use WRITE_ONCE/READ_ONCE on vsk->peer_shutdown,
>> should we do the same here?
>
>Right, we should. Isn't this also the case for sk_state and sk_err?

Are those read without the sk_lock?

Thanks,
Stefano

