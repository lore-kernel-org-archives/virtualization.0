Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F3420E8C
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982577; cv=none; b=hTaRa9+l1WY5XKnjsa8fXxoH/wygeUXbbBSCge027TbREMiMjO85zjWaIIE0hQRk7LwT4nkIqu/ZJl7jPSaikr8dSiUuWmoZ2Osr4YlzYiMnu+9rc6EJLxeDwnVKSmOxHOEXdEIJaXMyzywDMwdTjqQMejGejSDqBhudVdpuDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982577; c=relaxed/simple;
	bh=IqR1f/AEimWy9td6sTkb7Jq/+F4NeD8zy8Z1IlmH0fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WNIjqJGsT8bRWJ+j+5i2mXvablrG56ee9vYoybjcnVywNjH2xULMgK711IHnyb+Hdtcnh8fCqvgUttDD2kssRut0cdQlbtvH6GLBEtp/yU2Oa0DeNy5S8QrRL6Giv/fXMTQpS0Ymhe1duNb0mnN4i4L8YJJDy2hOiIQLbC+JPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIAkYwu7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIAkYwu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782982573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzu6+yi+0UPBChb/E9Oct0h9dnkvsRVovpFSB+irYu0=;
	b=NIAkYwu7JBsTy1fzH/eXQQ6PmDA9VEozqbBtoL8sGuh5QQxT7BqKYp4nZEUXNwLkbZEIzS
	yAFAvIxcqrjAZCAGxPsbe8zK0LZdnacQ3WKjwr64yMCwNP9QoiN05gySUJEPYuzTHcfWrE
	9aT5a+V6UdHZSFXo004LgEFVJY4xyX0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-ivxXOmQSMxuogeWGyTdAWw-1; Thu, 02 Jul 2026 04:56:12 -0400
X-MC-Unique: ivxXOmQSMxuogeWGyTdAWw-1
X-Mimecast-MFC-AGG-ID: ivxXOmQSMxuogeWGyTdAWw_1782982571
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926d371224so12318335e9.1
        for <virtualization@lists.linux.dev>; Thu, 02 Jul 2026 01:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782982571; x=1783587371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzu6+yi+0UPBChb/E9Oct0h9dnkvsRVovpFSB+irYu0=;
        b=ganTF/i+iwzwCzNnLhuseOezQhwfiRpTv3z05zJiTm3b+DMyGGigpJHnaAfByOnwt4
         Qch6DcfdYaPZpmqtgHEfugbHJvXrGI0FJ6KC+sMa6ZNC0u4fQKqAMhN/QpVjIOqfd47r
         k4LgR0BPdPca8IW6mqZ44t4vJNOhHfFrVSnGSChrX+zEov4vUnFshgHlbxAaOV8P5qQV
         QIEExITxbTS54zK2jcOA2EcD98pKjUELH6vVTEVGKstrGI6I1QYWOrYW4W/GHfS+/3mf
         U/h8BLROc2m6YZrykTWcXVCS9JWOFPcCVni91mvwLdDEvkZLSAPbUr/i5VMnksx3qlnh
         aGGA==
X-Forwarded-Encrypted: i=1; AFNElJ9N2I3oqzZVk9JjzWGSdj/qjWG7aa7FrKCFj3jMkwcF99//hlzb7vd7tgCQ7m9HIWdA6KC5jtpFbfZDhCRY1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy20bzZl4GsdIHWEoR6w6hn9E9dpYTbFtOp/Kry5nqUF1khAwzt
	fyQJw7PYjjHfe45mZ6H/GTSDVPuxMkbalM06ZrwRrjzPXB42fUBcUzKme2Dap0BJ/KU3SIWXd23
	vXSzobL1KwyZZyBMhtu5BkKxGe0ZOB/pA0jP3MJb4laMwq385q6Pl0ioLscMy5q29enOs
X-Gm-Gg: AfdE7cldW8x+1QWaU/Kfq0P/4TirQ+D+yYwjEv6DM+Yxq6s8CmpsH73B4ZiIx9hycPw
	3/bXGyuAGPlU8o400FO3NNN7BBWtUlM4kRZQYfEGLMK4r0++wvXb+pEJAXmm7mIrEIWoG0a3hAv
	IL65bp4ykrMYeBB8j7a+XP6x3/KaGG7v21/y1HV1w6Z8KX8fedlXTgY/REj0oR8DY/hfrY+zajg
	vMhN8wdw2ckgPqaZLWYwc/jwqokGHRzBQloO8M7lQqQZ9iT805WjhwqT0lxvuE0998nwegq+dSC
	HHJ8nXKOqpg+taWzulfbjn+KVgpKG3pEhOhMsI3xlQFGA3+R80P2fEia62CfBMG9r2Vlh72dbEY
	DulTluKMGeP9oteB6oNDms9VwufAw6UtQvIDftBbHkordDR2Me3iPck+67CWu
X-Received: by 2002:a05:600c:5391:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-493c3df2b42mr53317695e9.33.1782982570896;
        Thu, 02 Jul 2026 01:56:10 -0700 (PDT)
X-Received: by 2002:a05:600c:5391:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-493c3df2b42mr53317205e9.33.1782982570427;
        Thu, 02 Jul 2026 01:56:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f27bsm6829505f8f.30.2026.07.02.01.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:56:09 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:56:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akYl38_9Y4ydXuqE@sgarzare-redhat>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: he1S3D47La0R289_9av3092f7BP4pAkgiybchQlcPTY_1782982571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
>On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:

[...]

>> +out:
>> +	if (new_skb)
>> +		__skb_queue_tail(&new_queue, new_skb);
>> +
>> +	skb_queue_splice(&new_queue, &vvs->rx_queue);
>
>I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
>when adding to rx_queue?

IIRC we added it in the rx path, mainily for loopback to pass the 
ownership from the tx socket to the rx socket, but here we are already 
in the rx path, so the skb will never leave this socket.

Maybe it's necessary for the eBPF path?

In any case, I can add it, but if you can help me better understand what 
it prevents, that will also help me add a comment above it.

Thanks,
Stefano

