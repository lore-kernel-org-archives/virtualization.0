Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8201621FF29
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830374; cv=none; b=bH5l4fnXfPg5R5mHEjaFVWdYeOB1SnkvrjO0F3tDufcNTSLO8SnwvE/ifZVGG9Ut4W05Z4RXsz5mVWG0AZJG15TyRCCNvlvak+C0awiwNbAJdD0y8pHowg6NSu4AV1a/suB4Qix5cBsRBfEOu+etoKEaaw+ybIVdDX2TPDlqRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830374; c=relaxed/simple;
	bh=9OGXC+HPAx7wjOFmvBxnXdWUJNWtIqbDCCH7mHqqr6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/uqsmHv/upSacZFYjtRjWV6sX4qG7z3MyuoAdo9zNi65vvqTgLDAQzdNxbOMEfJk3t0/HZSiV9eZ1aw3wExpFR9io0GzYmw67g95ellgX315eD0ErB/UP5jl1Hm3gMwJC7qfQm5co0rRJTUjHi0S/YBD2JOwpUzOL81A4na2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CbMJwHnl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbMJwHnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz7VEdzguNgZR75iuoM9tSMqqnHJY/Hj/MLHh0vHLZM=;
	b=CbMJwHnlkstLQpf5jyc/1JXPdwrjWhd7Jesbu8p1dseqEZ+ga49ps3iZja5hNVQ+N2pcRD
	3VSaQuT41QPkmkxi2kB2bDEmFZQfkc4zH1JuuNxxt+sac3SIi6VmKFGvTW/ZWcYauWMh+A
	mV3uq+21LPx44mpNLbBYreKXn+aZ0uI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-W8UEK8TcP8WaEtvSolaXjA-1; Fri, 18 Jul 2025 05:19:30 -0400
X-MC-Unique: W8UEK8TcP8WaEtvSolaXjA-1
X-Mimecast-MFC-AGG-ID: W8UEK8TcP8WaEtvSolaXjA_1752830369
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f3796779so995585f8f.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830369; x=1753435169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz7VEdzguNgZR75iuoM9tSMqqnHJY/Hj/MLHh0vHLZM=;
        b=HI8j2AVYRHSK160fHMSWd5nVSxuYCKNMsw6M4W3u5P7KV70dsyAKsRqb8bgTR/a5wn
         haRog5Z2rxcU/u+Uj+qH5QBpqYEcErtc+c4/27vleb5JmSIwYyX0bj9Cet29MPMEH0Nr
         qitJMhyWiVfxnQlksBdoAwZ/B2sFSnaWGQEu18bZDXk1HRctG3SfpfKOS5wXJdNxX4ZU
         UNsmqE9cIRGZfDojtAoj49GfokAoVFdGCW6/FRaOs1bbxdv0swoZ/vq8idFj7iNp8vUY
         zqbAegixVm1ryuFqA3hSC71ozbUykirZyYqU2V3aCe0YKZNtCtCghXULCGw0VDIEUyyj
         mUOg==
X-Forwarded-Encrypted: i=1; AJvYcCXyAiLG3Bc9LwUu80jM3L/uzs+090WunquQG7K41Ocz+GId0MW+Hp/mTAgwQJtadthjnF5AnhaLHjr2dF1Wkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YweottuQ7ZlTr7U1kW3JnKj4IYBOw6946/DhtVfXHELLYK7HkHr
	94WHtT1YMMG1r9UVh9goES3HVlcWTxz0y6ZmqgefVlVCiOpitSvGsWEDtPIbuEhdEGZTAm/gTm2
	I+jRjseVHw9dWeYVQcZsnC1wdRO9P7BBX+f4eaD9MyR+Sy1ydPuhHSJwiWkh4VbG57rxt
X-Gm-Gg: ASbGncuzjiKTHWBnRFuWBEIEJJL1XZYScquD6Uzd8QxeXVYK9aZyTaYLcU9nmYPqWJQ
	YnLIfRc655pbaQ+RoWWOfRjSsrPfpO5VavOyFusfe9FPBfo63uAMpJZ1+L39ZKBty2gxaXDDpP9
	V7E6ex0uHOQK85yqXgmSxzXV8268ps8aDN2sZrtvZueHTN2bEsd6XrIbnEW+1ErELMQNmafyzKq
	UCi3XJKxaB90M47uiZiaCmZeaxERR/fDkHW8mtkGpp28k09KWSXUo9wRrLgPyd3QaX5rmb0AXBQ
	8r0Gry0CtvwbsD2tRl/UQKnIJRTHDgzXQ2Z0nthRNQbCyt9sa17oTV6tKOqx+5sShoAxjqZiONU
	5BbBSJnPrkRg=
X-Received: by 2002:a05:6000:440e:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b60dd7b02dmr5390083f8f.38.1752830368952;
        Fri, 18 Jul 2025 02:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTjhEq8p44r045oEYKw5E0umkCtE+yHNEk65pXbCxLQ3y2DbvrtoknVhu/Al+Bpx9xmKqa4Q==
X-Received: by 2002:a05:6000:440e:b0:3a5:1222:ac64 with SMTP id ffacd0b85a97d-3b60dd7b02dmr5390060f8f.38.1752830368389;
        Fri, 18 Jul 2025 02:19:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2dfe0sm1288433f8f.36.2025.07.18.02.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:19:27 -0700 (PDT)
Message-ID: <7aeff791-f26c-4ae3-adaa-c25f3b98ba56@redhat.com>
Date: Fri, 18 Jul 2025 11:19:26 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
References: <20250714084755.11921-1-jasowang@redhat.com>
 <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org>
 <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
 <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
 <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rQHxv1YeucEZI8FSongxlUyhYfTQimogPBuiWTYlaag_1752830369
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/25 4:04 AM, Jason Wang wrote:
> On Thu, Jul 17, 2025 at 9:52 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/17/25 8:01 AM, Jason Wang wrote:
>>> On Thu, Jul 17, 2025 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
>>>>> On Thu, Jul 17, 2025 at 8:04 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
>>>>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. This
>>>>>>> feature is designed to improve the performance of the virtio ring by
>>>>>>> optimizing descriptor processing.
>>>>>>>
>>>>>>> Benchmarks show a notable improvement. Please see patch 3 for details.
>>>>>>
>>>>>> You tagged these as net-next but just to be clear -- these don't apply
>>>>>> for us in the current form.
>>>>>>
>>>>>
>>>>> Will rebase and send a new version.
>>>>>
>>>>> Thanks
>>>>
>>>> Indeed these look as if they are for my tree (so I put them in
>>>> linux-next, without noticing the tag).
>>>
>>> I think that's also fine.
>>>
>>> Do you prefer all vhost/vhost-net patches to go via your tree in the future?
>>>
>>> (Note that the reason for the conflict is because net-next gets UDP
>>> GSO feature merged).
>>
>> FTR, I thought that such patches should have been pulled into the vhost
>> tree, too. Did I miss something?
> 
> See: https://www.spinics.net/lists/netdev/msg1108896.html

I'm sorry I likely was not clear in my previous message. My question is:
any special reason to not pull the UDP tunnel GSO series into the vhost
tree, too?

Thanks,

Paolo

