Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09C35CBD5
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226893; cv=none; b=qnkybSXw/42i/FzaLY/TIY+aHE8M03xbYTFh/OMDQfemh+2Q9E9HrEEKVFwhlqdSGFdpkNBpfc6d1oMzmbe1dWuIaf1X7cjHs/nl8+KWc2yKqNjW+KZ2+gnUs/h/UUouI4ZlQ0UYGtDTL+cVF83DqGxaRL068uWyV9UpgwdowOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226893; c=relaxed/simple;
	bh=GKvx/1ooBKBcUVjPLmQrzQL3r3xI5Pp++pamyt5l+xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nj1XLaBUq++IVdaZlOFdCvfEDOpfu1tfoCFyUYA4HD+uuM/bCPwNtztw1j2h9HS0FEIh2Imcs8X3w3E85qKFakvJ4TndeoIj9WLwEgUUHXYxNbHP/64CVuR0vLG7O5fyUOYC6hZrJqE12rFAUvHC2fI/AfzUkfebikMF7Tf8aU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAICmjoH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAICmjoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768226891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5E7sq9k7DMQGsacG+F/JxI7pmnfHnE90xymu2cg9dU=;
	b=NAICmjoHMeQNm+opLTYEk0mteq+0GDrQCSdJ3Z78YmiNP/0nxhCkTeHw6tBs4EbUzeknib
	u+Dfo82UjDPxc8HHjj4sDea8uHqEdDnhfxSHe41SiL5ic2UaAu7ZUBoH7GRm71o5ntqU6x
	3r87dBYRQK/CR3P+jZ9ORI/O14eLxZg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-5W2k_4szPP-NybQareKhlA-1; Mon, 12 Jan 2026 09:08:10 -0500
X-MC-Unique: 5W2k_4szPP-NybQareKhlA-1
X-Mimecast-MFC-AGG-ID: 5W2k_4szPP-NybQareKhlA_1768226889
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47a97b719ccso40707765e9.2
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 06:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768226889; x=1768831689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5E7sq9k7DMQGsacG+F/JxI7pmnfHnE90xymu2cg9dU=;
        b=cr1Xk2CyP8MNMq3pfBFhtoM4NUGygk3fVXgi+fpmoWzaDbMngq26E9a94XPP0MOm01
         fAaEbl4/e7M2QtB0NNw2E2VHDAa+X30JsTcHlvhcLe7jNxOx5bOUnen/ptatXX3zK6zu
         knADyokEPxDlin8DyOOKHIKTZvQu1V4p7p4gnWMGI4zgkPFXUV3vQp5qBjhcSxvGdelJ
         5i8MlvHb7ThWARkSmJZgJYMIo3gAwoNwdEoWdpdT/pWwVtQXw8sxoniwNyP9w8BzYHqx
         r5KIDLcYL37E3y/E1NVyncjty7NJvM5FJ5GpHtD0cJrbA2A2f7BMiv+5m8ljF1ff1APl
         Qs4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbMkkMXpmflasfMrBv5md0PbzPudvjc+0YGWhieFVto+niTbzgitQp1VlwnbiLLkPyFMHDLJN0Wq+9Z+6Pfw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/X98y0VZ3w9P3mexO8U5ginVieD5UU3kafHPcGfbrP1Lhmkmu
	ue+mCj1ooCXkTAoDJVUSfZZmSPS3UNirKf4vbXJW5fk9PPlEaxcGd9bAh3AOo5Fce89MydX7nCv
	1LGEbNO52fObvMB5ylK2cwnfk6I5HIt4e8y1vm1Pi4DuiFEdqT8bKeOCmyWuSfYdrFSmL
X-Gm-Gg: AY/fxX6Jv75GNwrcE8L8PLjjuzq8PTOgmWuCdVn9DzYWfZGskFNAzp8pckMP+ypG+tz
	QB8gjCaboLOrqDYssDsECXMkCl4555J6vtPv463s5jTzg2jBEeioaWTQERTSnR33nKbq1LLmMh6
	x1K/IO8AqcgkRbSfcMG5RBUzwbRx1w5Kz1TvU3i20HbzFFYkPKtSoB4jqurpjs8R20MvSSYIk5M
	2iAxC/0XqyV6fRxtV/6FM194W6/9DB0xFujWvoad+lwG19td5WvFyyvnWl11JajiOS5AMujUO41
	2xdakv0Ry/kZCN0XJW+z/2Q1/WKv11MtWk91CHoSnHlUdtNbuEWFtI8wVYUGorOm7ocUiAZkFWD
	r2KksBaaHeoMvfBDO0oXhy9hDOt6MLDK+iewqx8NDwHMEJwOPLax7y8TrcMiBPQ==
X-Received: by 2002:a05:600c:a10a:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-47d92bb28a9mr88376405e9.3.1768226888786;
        Mon, 12 Jan 2026 06:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSA8MeLEwBc5V/8h9ZTRtoroYd4ri8KOUDoLboqzGTL/mHH9z1of/NksaN4ZE17gxAdWjfFQ==
X-Received: by 2002:a05:600c:a10a:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-47d92bb28a9mr88375885e9.3.1768226888223;
        Mon, 12 Jan 2026 06:08:08 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm38203341f8f.4.2026.01.12.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:08:07 -0800 (PST)
Date: Mon, 12 Jan 2026 15:07:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vsock/virtio: Coalesce only linear skb
Message-ID: <aWT-IkOVbrq1Bhse@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-1-26f97bb9a99b@rbox.co>
 <aWEnYm6ePitdHPQe@sgarzare-redhat>
 <ae564ab4-2dd2-4a12-a92c-b613fa430829@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ae564ab4-2dd2-4a12-a92c-b613fa430829@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3RYyqlSdP7Uvz5cLDax_QIuIauJfa_YPmV0TXlhaTt4_1768226889
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jan 11, 2026 at 11:59:44AM +0100, Michal Luczaj wrote:
>On 1/9/26 17:18, Stefano Garzarella wrote:
>> On Thu, Jan 08, 2026 at 10:54:54AM +0100, Michal Luczaj wrote:
>...
>>> @@ -1375,7 +1375,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>>> 		 * of a new message.
>>> 		 */
>>> 		if (skb->len < skb_tailroom(last_skb) &&
>>> -		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)) {
>>> +		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) &&
>>> +		    !skb_is_nonlinear(skb)) {
>>
>> Why here? I mean we can do the check even early, something like this:
>>
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1361,7 +1361,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>>           * to avoid wasting memory queueing the entire buffer with a small
>>           * payload.
>>           */
>> -       if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue)) {
>> +       if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue) &&
>> +           !skb_is_nonlinear(skb)) {
>>                  struct virtio_vsock_hdr *last_hdr;
>>                  struct sk_buff *last_skb;
>
>Right, can do. I've assumed skb being non-linear is the least likely in
>this context.

Yeah, but it's a very simple check, so IMHO the code is more readable if 
we put it in the first conditions, where we check if the current packet 
has the requisites, rather than in the nested conditions, where we check 
that the packet already queued can receive the new payload.

>
>> I would also add the reason in the comment before that to make it clear.
>
>OK, sure.
>

Thanks,
Stefano

