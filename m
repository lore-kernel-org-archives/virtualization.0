Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4E1F1906
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539836; cv=none; b=iUgrw56Q2lNtRP9datnymaBJI7jAaBHFDAqmX6UJXJumK5VrBgJp6ehWgMqMctlqiTV7zAhKDxZRDKFYlpO4GNA7J0dWUg2HsAWcvSDU97+ud309Xz6XRWQthzBKTLV930aw37VtwtPlqlXd6DC+jw6m3A5V6TSN9JwRha0KRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539836; c=relaxed/simple;
	bh=hq2wU4Thxvj9W5q0QQZu8ghuyXx+360IX+pAXabRItI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TMXKk2woYzoacJXtupDsGuvvnL2GEkPfqBp3BCNhcFNdGXThUBCwxu/ohP5vJ+7YLDratmetFxkLWo8+kwoxljqPhrbFZpZjRafDc+C86LKMQ9Gg6JrayMCL5WJ9UafGusKYevy7x0qKO0TzwgSMnKJw7hCpOW6Q/FBOvIXMlNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtEzED7h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtEzED7h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751539833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hq2wU4Thxvj9W5q0QQZu8ghuyXx+360IX+pAXabRItI=;
	b=XtEzED7hY0MYhstpM5HMP7Y+LMnV1q0ieKB+NauZUMgROZuWaDOF/IbQhT4ZoPCnkB/gUd
	Nsn8L3Tnx+8qUe79sbyeNC4NoH8SufwKXLltR3BdTm3JPT/PD1NFzdpxvGTWtUisHXyQS3
	K1+TQY/AEmxT+t7N0gIAH/557y0J+jI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-wvwYIPYoNVG8lTapJi1bqg-1; Thu, 03 Jul 2025 06:50:32 -0400
X-MC-Unique: wvwYIPYoNVG8lTapJi1bqg-1
X-Mimecast-MFC-AGG-ID: wvwYIPYoNVG8lTapJi1bqg_1751539831
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so38850095e9.2
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 03:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751539831; x=1752144631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq2wU4Thxvj9W5q0QQZu8ghuyXx+360IX+pAXabRItI=;
        b=hhTfvKcktUe234ZZFLxw26J0f30GG1S2Y+PEefugCvFVS/Arxsrr9NqKopSCZgMbs1
         dOu5rEebDxS1WURUfrCr14gr0IgXNP8BwEebpFFGZige/puMeHzf/1iafWaFCllnCeX1
         8JhqWBPwS6dGq0gBJnMzRa2xX+64RI7nbYCA97vR99oG7YvjRKHAhOscdaxqV7mp1/uI
         zTdzBy7ydliNv+ZWpccnggq14FneFtiDQvikpedOHfQc2n1/4rSWcIarueHtWuxv5dgc
         B7L8Dx3hu1EgNZR30N2jgd6jFxqiC0CjlCsIaN6TgOPew85upalaivMrywGa7JN0mvZp
         Dghg==
X-Forwarded-Encrypted: i=1; AJvYcCVkzTEfogtjd2DnsD5kS9RvbYuqx/0uy27Hmavguy7xECSX5XhBeC9YAOsY1ZvrB6LyrKl+WganqrhRZ/BlFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyijhxAr90mL0v6A8FXMOY0Qtn0Px8eOsXDkMrCI0keIC9UeZiV
	dQILV5b1xXWYLyPU/qP/ByXfJ+udKK+j0PpYyZrMyTUc5Yhbx2Z9A0cdTG8Fg0blc0u1jg1I5Fd
	hG3HHh717gPV5ycqL/r9m0TPiL1gfQ7OgbvzvdHd+FrPSo67jUZdtHynjbTSkPRj+L4ae
X-Gm-Gg: ASbGnctxG4xxdFUvTOCEsUDLFweimPyXuk702b0NtOpPEQDBMtPUMbsinHl2Ag0oiK3
	sNKnc4kk+kTILH2AET1gicD0kUh5/eMmwRI3FdAPFrcQX9AaCt4V4YUktcseX26rYauHF8dmpew
	wdlSX3WoJ0LHgGoNRJ4UZM5kIW0G0wtLpdAS4OUMYvAjHJ3sr7gVJC3M+Zpu0ILxqd1Iywf7O6e
	7Pib+WR9jHLr7mAxn0gxUAOVakX6gYqJHA6ogzrtaFjlMfMMfgGjU3APLijyWfOBdRaMZscEtUe
	I5krf/CEL8kE3t1MwVgMrDq5oM+a
X-Received: by 2002:a05:600c:8b77:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-454a9c8b237mr29470885e9.5.1751539831098;
        Thu, 03 Jul 2025 03:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzDX+vbYuYqXz4dknV8AbAZbalPiUFcm+rHJ2WbwReCp9n7u2EYHmOh5K438umgtQEGSI9Og==
X-Received: by 2002:a05:600c:8b77:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-454a9c8b237mr29470635e9.5.1751539830522;
        Thu, 03 Jul 2025 03:50:30 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997e24bsm23279805e9.16.2025.07.03.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:50:29 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:50:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock/vmci: Clear the vmci transport packet properly
 when initializing it
Message-ID: <756ms3h6ayqohczk3426xnzoby65luxzrbxblqvgl4ezlcqgph@xjz5m5qf5jew>
References: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
 <37t6cnaqt2g7dyl6lauf7tccm5yzpv3dvxbngv7f7omiah35rr@nl35itdnhuda>
 <2025070144-brussels-revisit-9aa3@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2025070144-brussels-revisit-9aa3@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 73v79alJaTn3AVq3o_CdP5KVROKOVtnItxELkVmZ05I_1751539831
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 01, 2025 at 02:56:14PM +0200, Greg Kroah-Hartman wrote:
>On Tue, Jul 01, 2025 at 02:42:10PM +0200, Stefano Garzarella wrote:
>> On Tue, Jul 01, 2025 at 02:22:54PM +0200, Greg Kroah-Hartman wrote:
>> > From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>> >
>> > In vmci_transport_packet_init memset the vmci_transport_packet before
>> > populating the fields to avoid any uninitialised data being left in the
>> > structure.
>>
>> Usually I would suggest inserting a Fixes tag, but if you didn't put it,
>> there's probably a reason :-)
>>
>> If we are going to add it, I think it should be:
>>
>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>
>Yeah, I didn't think it was needed as this is obviously a "ever since
>this file has been there" type of thing, so it will be backported
>everywhere once it hits Linus's tree.

I see, thanks!
Stefano

