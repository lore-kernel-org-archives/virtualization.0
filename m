Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F13EB816
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836014; cv=none; b=THRrLMfZFekj4nDSxMPRpEdB17RzccCKhnCPBa9GMfhbZHh5CHyvCOXA26AWhFMOnGdvLpleZyACVJGftwmZAiQF4/zy/E/sS8nxmd/BIeU26HvSov8fuGl4fRa0aLcqNLllI08CBRprMncCABi4d9C7jSFvkNBTAMRpuzGR3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836014; c=relaxed/simple;
	bh=rop/GLyLw5UwLPV1c6LCd9Vt3hvwFis3vSiP6iHIntI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JspLAgPI1a54NwuQvS1zOk76gR4wY+hLRG2jgNMB6SldrNp5KY7uhI/bCqG8SrPCYnLgKBDSIdgVbY9RHItGLhTTHN/K/3uzKFr50YO8vMjAymgTDQ1BRUtvY+Nm6mLNhAc+DUN4YcdC0DP8v70Xq7J3snmV+ns2kCBYN7VFljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuFYrECO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuFYrECO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=An9ccbacNYLYIGlZzu/euJIQhtjW0DZq6UWVHWSx2oI=;
	b=ZuFYrECOpBzDbeoEAm67Bi7/QnWvD0+V2rr2B55saCGZRBHtJeF+iwKhsuxYxMTg8fo2nx
	eCqpkNJ+NuQaV0htiGIpiwWc69ESZEELJi8nP3oN3RB7FunWwjRXGR+4WTL4DqxnfKTDZD
	/E1//GPiHh107gDJc0FIS5wn68dFGRg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Q0i-X_SZNzqW6UASlRL19w-1; Fri, 15 May 2026 05:06:50 -0400
X-MC-Unique: Q0i-X_SZNzqW6UASlRL19w-1
X-Mimecast-MFC-AGG-ID: Q0i-X_SZNzqW6UASlRL19w_1778836010
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48feb0298d7so3738345e9.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 02:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778836009; x=1779440809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An9ccbacNYLYIGlZzu/euJIQhtjW0DZq6UWVHWSx2oI=;
        b=SBr1JPbsy4YyDGaV0EJFwyXtEtSjrARH/XeCJ+FIXTfhHhFGRz2+7ixt2Cnus/xFBW
         1lt5e/zfjZQoy1ZL5qDhOSyaqNVhpeCOGPWOckZqsAjenTmc3SCqENLrLAarZK9WKcoc
         X98Y5Afb2JKB+6CejGHAZdzJm6CZCFXvIs3LOX++gud4+KzzQa0oEq4E/FCLZgT9IDc0
         KBqETK9rwpdje0LtroD/n1gPMEYI5V/vb8tCOoMSwYMoRLntvVuZTEUx+k5BNLIC9ZRI
         wHFJ7zQzDqDmkwzI9UCSQ1Iq+pevaFmmYyVU48s4wvEaxH5l0HtLhdD/lwc2ykGkFy1Z
         c/PA==
X-Forwarded-Encrypted: i=1; AFNElJ8oppTAVM4SUnJakSBQN4SJf8gog3M0vq3BklTnsIr145A4kQBDGlzqcQheyxW5kO0pFJnZXvqSYvKTXYvtjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQ3+ECxAb8UD40goxwE3LuxCordvwNppBBkE1P8QesZKeBMWLC
	p0RhYFh1cndz44qslaZfV3dWPKeF8viYRO/5ZyGxrEY8q/NFT5A+B00mTN2DtnEbPH7smkleLFZ
	OObJjHN18tBVtriNtASHsO0vc6rsBglZSjyKu+ZUblGrXkAFDmdDmIAMyUAICaigML8im
X-Gm-Gg: Acq92OEr0UItf3FPiwzNIv2q1+TvIwnMx3aLcCz4wurJ0k2VzCKZiiDdt8teiNhGQKv
	CRkjDCcxNreNuQeb8wfMeexxffNA5eL0wv4b+eYA5MYaQBYSjAH4kaU7xEEobWNvqQLoIJY7EuJ
	DhkI7+Oxisoc/1jj0MLnGszo0LPUraEO/NV4d4VcDRoCGufZf51jiBdZNM6sR5v2iOqyYofqwny
	iQYo8yONEofgdTt1Q0yATkKArT/qTyNecFyK7+a4LTnBjokmTCdkT1NWWaEwFQ/wX8zU5vbPHAf
	swuxM81//q1sSfQydHCYt0ECLQ5w9KFmfFf5izDQQ64tKsTUlBDU5TJr5ya6xFkvtgXF2F8M/1v
	L8yg0GP8TGAwBmtUmvSTvx4d34BPuXv7JXHmOe15bZ3PXv3qCPOue5n/GaR0GQjoDjd4hKOeEIg
	==
X-Received: by 2002:a05:600c:848c:b0:48f:d0f1:ed28 with SMTP id 5b1f17b1804b1-48fe60e4e32mr37803895e9.1.1778836009471;
        Fri, 15 May 2026 02:06:49 -0700 (PDT)
X-Received: by 2002:a05:600c:848c:b0:48f:d0f1:ed28 with SMTP id 5b1f17b1804b1-48fe60e4e32mr37803145e9.1.1778836008891;
        Fri, 15 May 2026 02:06:48 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab52a6sm45218425e9.10.2026.05.15.02.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:06:48 -0700 (PDT)
Date: Fri, 15 May 2026 11:06:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <agbg-pUhBRB89aEX@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
 <agbWNqhzvEHVBvC2@sgarzare-redhat>
 <20260515043940-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260515043940-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pi933C88duIoy5ZCe2ceO1lFVoL8aYpW2SsyZzoTTDY_1778836010
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, May 15, 2026 at 04:57:41AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 15, 2026 at 10:29:55AM +0200, Stefano Garzarella wrote:
>> On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
>> > On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
>> > > On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:

[...]

>> > > >
>> > > >
>> > > > And so the bag of hacks grows. I feel this is energy not well spent.
>> > > > Please, let us fix this properly *first*. And then worry about how to
>> > > > backport.  Maybe it will not be so terrible to backport after all.
>> > > >
>> > >
>> > > TBH I don't think this is an hack, but an issue we should fix in any case.
>> > > Regarding the second patch, I see your point, but it's a big change
>> > > that worries me. I'd like some more time to fix it properly without
>> > > rushing. Staying calm without realizing that userspace is broken like
>> > > we are now without this series :-(
>> > >
>> > > That said, evaluating further, I think we have a similar issue also
>> > > with STREAM on the host side where the skb usually doesn't free space,
>> > > so we need a merge strategy also there.
>> > >
>> > > So, I'd like to have time to fix both definitely. If you have time and
>> > > want to go ahead, please do.
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > Well my patch was a start, we just need a strategy how to avoid copying
>> > everything, right?
>>
>> Yep, and then there's the question of how to handle EOM without a payload,
>> but I think that's a special case. In theory, we don't support sending it,
>> but I'm not sure if POSIX allows it or not.
>
>It seems to, but given we didn't allow it in the past, we probably
>should not start now without a good solution.

Agree.

>Really we should add a feature bit for EOM to steal a byte from
>buf_alloc. Or several bytes)

Yes, I agree. At this point, though, could we define a new protocol that 
also takes overhead into account, or would it be too complicated to 
synchronize both?

>
>> That said, is it okay if I send a v4 of this series?
>>
>> (I'm not sure if I'll be able to work on the merging next week)
>>
>> Stefano
>
>
>I do worry we are piling up hacks and we'll end up with races
>for all our troubles. That said, up to you.
>

I see it differently; Patch 1 should have been there from the start.
Patch 2, unless we completely remove the overhead, we should keep it, or 
use it to trigger merging (e.g., when the overhead reaches a threshold 
that depends on `buf_alloc`).

I prefer to send a v4.

Thanks,
Stefano

