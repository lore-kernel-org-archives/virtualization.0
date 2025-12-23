Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFCC1A9FBD
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766495772; cv=none; b=ayyOskX2aDX0SB+w15ygt2XYEdR5kM8YSFij95KXlqsBblmiS4LZ//MHthq9p+53fuEvhjIQpIwXB19C90eXGHncxPD+HLqBioS4rrUW8OC/4VX0CCG6mSXFEOnfSiF9Dlpww6gqgJGa7fi9GwlUfeCExIGmZmNf07dIWenImlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766495772; c=relaxed/simple;
	bh=WqBQ/hpNjZN9Cxv1HaJmF+GqXlLZwRqHc1QOTIoDszc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RwkfSQHWhZ23o3nqAfxibUVH2LoCWL8C2mozpxB1gucLLSCUl27uGWm4wWYVuTG82JI2k142/UoCXR/OMq7+W8oQBA/09xk/CqYfSCN+IN/lr3ko7wOZ1lVuIONqMk9nMKBrcu3ONXKcTl+5oWUXWEx+KWtRgMLObT+sSSqp9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hI1zT9mh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI1zT9mh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766495769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y97rc5GcE3Yd5eT+dtSrmA8PUrYxFCSHrbekggpdJo4=;
	b=hI1zT9mhXIwFdpCYOCF3c5Swlxiscv9PIB7Ymsd7gH3TTeGSTG1d22oli8ZBgN/hUGqKBx
	viC0V47nb654aG3QjIgH6/KvHzJc2mGEIvXbLJy0b2CjgdFI+uuJLGtvcl5T2r0KSZfpDM
	mTpRTLZJGT9Q7g3s3llRnsGcxchuGYc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-fbofMqNHNGaQVGOsaoSQlQ-1; Tue, 23 Dec 2025 08:16:08 -0500
X-MC-Unique: fbofMqNHNGaQVGOsaoSQlQ-1
X-Mimecast-MFC-AGG-ID: fbofMqNHNGaQVGOsaoSQlQ_1766495767
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7a29e6f9a0so564004766b.1
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 05:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766495767; x=1767100567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y97rc5GcE3Yd5eT+dtSrmA8PUrYxFCSHrbekggpdJo4=;
        b=NBTdjesZLmBs7JY6wJTKsPKRLBOhYh6zTUZiPwTmWT4Sg1CYTPyl1hyT6FJH2ifkXn
         I7ay4zNU1Di4WNsxg+3Zf1PrdrdbH1uyKK1dUAYOD/sMWpLqwX4gR8D5t8rhOW11trR5
         TE2grPkOCPClLZv7tEIhcn7LkV1SgLXmoNf4P6nR1pfNUYTjU3a3nK5EPlCF0Zl15dbQ
         lO/MJhy/RnLiHDoOtx/fFDX5TQMEnWxx6Cp6QqstNRG8hMipdeIFg+MElsXOIWdIHyk8
         Pu26Cm9KIpZxVMWiHmwcU7PFXQaXjgaGUqzk4zdzhOZT63D0wH1+DSIMn8WggQZPbqQv
         XjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs4/6bwfwAyjlc3JGjHYzyrQ0UlO/ceuA8eBpcZexbT69Rc2IZUfbIRnfoQk28vsGhrQojGdvU8NyAlfsAyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzye8215wG0RDbgS7eZpwpQdtFr4a146s6bqpljdMj3vKb6yvbM
	enVmB3llCYztlU4n0QdVG4q1Y1xTix/5x7H+wbVH/E4aPf/sj4cIw6orochyxvwdOlHht+GNT9S
	4cYMd/+ryd7F0PDb/9E3aaj41u8vV377xngkxNaXuOALLmPNvUcqD19kqF2RoXSuDFB1O
X-Gm-Gg: AY/fxX7h8lKhK9gR1fXGZRvF5V8KRJ4Rf/t95a/aOBys56kH7Rne38e+j/7XeS+RBlV
	yT6H9Wyq8Cp6uCugaPyy8rxAN0+P7HDXCEHL9fWTZ17w5nZt38vRg55iY0UxN/vMXe6FTMizmTr
	4PWqki5BuIcyvXvfqNt7viGvoGSLk+ggYqgyRStRCDDydpgVzu7A93K+uQ8S/DGJXLbgkFlg1zS
	CJMpPkROjcx+VbSaxkx7tpwXdlPW2IktyhkHkVeYfnWt8kSq0pYD0H3z94T48oEn/PsW9rOnhWH
	FBx0wvMrA3ZesPrC4FgXS/7wNEsdKPR7cXuL9LoPotwx+HH4roG38LDha17bYuhYWyprjvbb5Am
	gKY90MpHIdGXSSQ==
X-Received: by 2002:a17:907:97d6:b0:b73:70db:49ab with SMTP id a640c23a62f3a-b803719f96emr1420033666b.35.1766495766670;
        Tue, 23 Dec 2025 05:16:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjxAAVvYrg5+y4kU7bqUbucP8T0bUOR5ViNdKkpg22IJis92cWk3F0dDEC5WBtVcJs+vFO1A==
X-Received: by 2002:a17:907:97d6:b0:b73:70db:49ab with SMTP id a640c23a62f3a-b803719f96emr1420029366b.35.1766495766138;
        Tue, 23 Dec 2025 05:16:06 -0800 (PST)
Received: from sgarzare-redhat ([193.207.125.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8045a086fasm1219177166b.70.2025.12.23.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:16:05 -0800 (PST)
Date: Tue, 23 Dec 2025 14:15:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
Message-ID: <aUqI_qW3SZ-WBXk3@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
 <aUptJ2ECAPbLEZNp@sgarzare-redhat>
 <ff469a0f-091b-4260-8a54-e620024e0ec9@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ff469a0f-091b-4260-8a54-e620024e0ec9@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Hii-K3pZ8pA435R-PM_CnpuBE0wrn1pAqQc3E8xdZ0_1766495767
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 23, 2025 at 12:09:51PM +0100, Michal Luczaj wrote:
>On 12/23/25 11:26, Stefano Garzarella wrote:
>> On Tue, Dec 23, 2025 at 10:15:28AM +0100, Michal Luczaj wrote:
>...
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index adcba1b7bf74..c093db8fec2d 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1787,6 +1787,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>>> 		} else {
>>> 			newsock->state = SS_CONNECTED;
>>> 			sock_graft(connected, newsock);
>>> +			set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
>>
>> I was a bit confused about next lines calling set_bit on
>> `connected->sk_socket->flags`, but after `sock_graft(connected,
>> newsock)` they are equivalent.
>>
>> So, maybe I would move the new line before the sock_graft() call or use
>> `connected->sk_socket->flags` if you want to keep it after it.
>...
>>> 			if (vsock_msgzerocopy_allow(vconnected->transport))
>>> 				set_bit(SOCK_SUPPORT_ZC,
>>> 					&connected->sk_socket->flags);
>
>Hmm, isn't using both `connected->sk_socket->flags` and `newsock->flags` a
>bit confusing?

Yep, for that reason I suggested to use `connected->sk_socket->flags`.

>`connected->sk_socket->flags` feels unnecessary long to me.
>So how about a not-so-minimal-patch to have
>
>	newsock->state = SS_CONNECTED;
>	set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
>	if (vsock_msgzerocopy_allow(vconnected->transport))
>		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
>	sock_graft(connected, newsock);

No, please, this is a fix, so let's touch less as possible.

As I mentioned before, we have 2 options IMO:
1. use `set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);` but move it
    before `sock_graft()`
2. use `connected->sk_socket->flags` and set it after `sock_graft()` if
    we want to be a bit more consistent

I'd go with option 2, because I like to be consistent and it's less
confusing IMHO, but I'm fine also with option 1.

Thanks,
Stefano

