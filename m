Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9D23182B
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011837; cv=none; b=i+Czvq3xtcXr58OPtfUrnPt0mc0aHI2J4iFIwSe1Vcy1+t0Uz592+OiiP3b0OaEfjJLVCwhfWwNVRHktD0lSFCfF876O9OIX4fFWnDTNhtAGzr8cmWnz5t8zOf3N58dHFH1FtRq6dqeCA72Gz5vJrPVYuN/rgun6ijSu5OrnTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011837; c=relaxed/simple;
	bh=QS4tL4YPdYZDlMFPgDrNTqwuJlb294yaj6dINXZ6Ai0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LykDrGe6Zxuvhe5CCUI5ASeqKmmjpsw9x6IMlusQZ1ZaSJaJVZjTxnhiyW341Gw5lFPoZHSw069XQSaY+CI/eOaX1xij/PpDh5CwlJGk4C4fBM8enA2EI1DdGTH2XhlPM9NCApXvE1bh4xKhgoauZnBNIZpEW9P4xyM+wwnTlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxeBjmYq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxeBjmYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751011835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sICsXc1ofeVsypbgyq0RR1yDIuegz/49BcNvRJ0ZQE=;
	b=OxeBjmYqbgZPUNagomicpZsiAJPgWErOtkRnJzxkIEf784iSvyewu0oe4n9/EmIkvPWhtp
	+viuSWKmBv/X+r2RSoa8WhMuaY1aKjXkQp/yOlITJ1yIyLYeyH22QW7IUJTcj6/rPGnnDV
	+nVpyAHFrmL8Oyz9xXWMSkKbT+0tax8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-bfy9kITXN0exCXzutrenqQ-1; Fri, 27 Jun 2025 04:10:33 -0400
X-MC-Unique: bfy9kITXN0exCXzutrenqQ-1
X-Mimecast-MFC-AGG-ID: bfy9kITXN0exCXzutrenqQ_1751011832
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb3bb94b5cso31449676d6.2
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 01:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751011832; x=1751616632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sICsXc1ofeVsypbgyq0RR1yDIuegz/49BcNvRJ0ZQE=;
        b=eV+qk0C0nLN5SlRn1oyFpXTGnlkiu2U7YBr6+JumP8UbFTZX3G7Ud0LpzO8mf/S/PP
         h/O2aG6dIRXlgFO7ytCKtJNYk9ntbX6npmiGznOzuPx41wOZ1W/zCrQLm6283X9CgIKe
         u5EcKzHxNDV6f54CgXQ5byGiAlbw6IzaBlrlo2zl7vCqxkyDW3poZrZBdjNGEbh1npYQ
         QNgA29fsuiImG0hYhyCEPHVt/422orWCbkWpSZfsngZQyQJWv5mj22U716Hosa+xA6FL
         kbx30WzJswUWnG/D6WLcH/jOmdITZn2fYPkFsbj49wSquVkAB525yWhTg/tvUPKLeOyU
         Y99w==
X-Forwarded-Encrypted: i=1; AJvYcCWM7bXiWxMPecvnH6tt4I8Jpbs8vx0a82KHJySnSRjNfRHfvgD+3Szg2r4JkZglDs1tSNJnjYwATL6uhkqmLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoqP/dK8l7ofB0+aaQzip+9ExbmEC4S87GJLad5WOu4zD5zS1T
	59fm2pnN8fIi5uLm7leLuw8gL0Ht64vhkhEsFgocc4BuIYx7+i2PkLn8brlEHhUY/Q0w/C9KFQN
	eFXdfpjCge0Cg+q7aIOzcRh8JjlhO6LoLvTSppeV66Pn/IfYSWQSHfNltuzmKRGTHXnmp
X-Gm-Gg: ASbGncsLryj7xu50z8KGI6ZD04u2RSE988XvXMWxJC6QkP8q6SCy+tdG8FUheQfewdg
	rCd4+IlTxEseHSW4FLFEOdMenKZLRLKoUSifv0RIJLKbU7bBJ+3jXBp9lj7fyImwKodOTENX0HR
	6UXAMNCzIn5CluW5jKDZno7rD8ZdQGu26ITqwPg7dQ7Nvw02R3D7hZbXly+AeqDXkg2BZ9wW3XP
	Y599FU/TVc3+A+BT77ku8i0BTSMdzgNLWS2Qc4jP4n7mpXc49nQ9Bcv1C3czleyn56FeZ67alK6
	d3uBfC2VqBOHO/XnUubZp0YTmvU=
X-Received: by 2002:a05:6214:4348:b0:6fd:7577:cee9 with SMTP id 6a1803df08f44-70001c5337fmr39979436d6.2.1751011832547;
        Fri, 27 Jun 2025 01:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ZeT8wRwtLOWbjGTnZVZZO5DgdH1k5n++yxPhBj+AdN+0ke2A1ox3AZXiS29WEGnMIQ7rXw==
X-Received: by 2002:a05:6214:4348:b0:6fd:7577:cee9 with SMTP id 6a1803df08f44-70001c5337fmr39979196d6.2.1751011832083;
        Fri, 27 Jun 2025 01:10:32 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317195fsm91926485a.38.2025.06.27.01.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:10:31 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:10:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 3/3] vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID
 to check also `transport_local`
Message-ID: <b3fx4pma6l2zgfw7azvzliqfwu3ldjdlvbnegmzcuef5ryldux@2mbc5qsgkf45>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-3-02ebd20b1d03@rbox.co>
 <uqap2qzmvkfqxfqssxnt5anni6jhdupnarriinblznv5lfk764@qkrjq22xeygb>
 <0adde2db-3a75-4ade-a1c8-8c3bc2a0b1fd@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0adde2db-3a75-4ade-a1c8-8c3bc2a0b1fd@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lZ6ehdT4byvVXq_pGsHarclNQObI1TBxTB1M7P5Vmlw_1751011832
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 25, 2025 at 11:23:54PM +0200, Michal Luczaj wrote:
>On 6/25/25 10:54, Stefano Garzarella wrote:
>> On Fri, Jun 20, 2025 at 09:52:45PM +0200, Michal Luczaj wrote:
>>> Support returning VMADDR_CID_LOCAL in case no other vsock transport is
>>> available.
>>>
>>> Fixes: 0e12190578d0 ("vsock: add local transport support in the vsock core")
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> man vsock(7) mentions IOCTL_VM_SOCKETS_GET_LOCAL_CID vs. VMADDR_CID_LOCAL:
>>>
>>>   Ioctls
>>>       ...
>>>       IOCTL_VM_SOCKETS_GET_LOCAL_CID
>>>              ...
>>>              Consider using VMADDR_CID_ANY when binding instead of
>>>              getting the local CID with IOCTL_VM_SOCKETS_GET_LOCAL_CID.
>>>
>>>   Local communication
>>>       ....
>>>       The local CID obtained with IOCTL_VM_SOCKETS_GET_LOCAL_CID can be
>>>       used for the same purpose, but it is preferable to use
>>>       VMADDR_CID_LOCAL.
>>>
>>> I was wondering it that would need some rewriting, since we're adding
>>> VMADDR_CID_LOCAL as a possible ioctl's return value.
>>
>> IIRC the reason was, that if we have for example a G2H module loaded,
>> the ioctl returns the CID of that module (e.g. 42). So, we can use both
>> 42 and VMADDR_CID_LOCAL to do the loopback communication, but we
>> encourage to always use VMADDR_CID_LOCAL.  With this change we basically
>> don't change that, but we change the fact that if there is only the
>> loopback module loaded, before the ioctl returned VMADDR_CID_ANY, while
>> now it returns LOCAL rightly.
>>
>> So, IMO we are fine.
>
>All right, got it.
>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index a1b1073a2c89f865fcdb58b38d8e7feffcf1544f..4bdb4016bd14d790f3d217d5063be64a1553b194 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -2577,6 +2577,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>> 		cid = vsock_transport_local_cid(&transport_g2h);
>>> 		if (cid == VMADDR_CID_ANY)
>>> 			cid = vsock_transport_local_cid(&transport_h2g);
>>> +		if (cid == VMADDR_CID_ANY && transport_local)
>>> +			cid = VMADDR_CID_LOCAL;
>>
>> why not `cid = vsock_transport_local_cid(&transport_local)` like for
>> H2G?
>
>Sure, can do. I've assumed transport_local would always have a local CID of
>VMADDR_CID_LOCAL. So taking mutex and going through a callback function to
>get VMADDR_CID_LOCAL seemed superfluous. But I get it, if you want to have
>it symmetrical with the other vsock_transport_local_cid()s.

Yeah, BTW for transport_h2g is the same, they always should return 
VMADDR_CID_HOST, so I think we should be symmetrical.

Thanks,
Stefano

