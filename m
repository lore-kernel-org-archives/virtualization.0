Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843F1EB37
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLfroUip"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 410CA831DE
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 08:43:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 410CA831DE
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PLfroUip
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9YR5EHgYnpqX
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 08:43:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 50B44831A9
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 08:43:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 50B44831A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702457020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ypvU2CFpvjA4GuEgMA1XFzF02HXPcVncJHhzWckfAo=;
	b=PLfroUipTS2suUMv1kE+11kz/ddaz1vL4/IxVBK4dxA7GhC5BpioE73i4qeLwhA+yHYnJL
	zPX74g/QYzPCtCZrDw4P+fnwAbuGIKFmShz5uaeSJIXbAiTuMu2UioNZxcGmuISE2x0xPW
	4PuXrCouG03+6BsCmK1VYmQ1/nVBBBg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-zl8jBc4ZMSK2iG2fIBs8FQ-1; Wed, 13 Dec 2023 03:43:37 -0500
X-MC-Unique: zl8jBc4ZMSK2iG2fIBs8FQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b554730c5so46464295e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 00:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457016; x=1703061816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ypvU2CFpvjA4GuEgMA1XFzF02HXPcVncJHhzWckfAo=;
        b=dA9EhzL3toBRUvm91Fp3K68qyh2mA3r4VA1XRUyNlzAVzns2ROTzGxDVTJQ5X1llYz
         rXQeF0rL2CU6VC3VaO6CNbiFZ2YNpNcXYHlJadDhlye0zYZhXpQpCHiSKTj7mM3hRoiz
         feuM8vhe4T487QCaJd8HzJEg+y+S0Lg46rL15zA+zj2JDkVhRsrrO+8+K+EmuBJAE67g
         y15pk1hhVGxhcEdZ/WO59OIUlKR8iaR4HmHU/RZ//fL5Wf00SDVCtF5ji3Cv4zVDZuEH
         FBuYiz0nKxu1PsdYqaUwCg2r9rPV5N7ZbGHE9ZlFomzIGS9vta8HB9VLhr0Y3WV5HAI+
         W07w==
X-Gm-Message-State: AOJu0YwmXRbKbKM09TGxyRgBgjLr8LwQSduyi4PApxq0XAXnJHPLxrRX
	duwYlHfm59kRXJSep9zAODTyhEmH25yc501OXqPEe/1Gg6fdGpkjck+cvCB/6rB+tybib6zV+Io
	PJ9wcK62sBfQhunoKvEw1HgLnMq7TCgKeW8R652Zl8A==
X-Received: by 2002:a05:600c:401:b0:40c:26ef:b24b with SMTP id q1-20020a05600c040100b0040c26efb24bmr3913394wmb.188.1702457015952;
        Wed, 13 Dec 2023 00:43:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1lQ4+EUeiLIk83v4dqAAgqvxh6iPVGvNgRE5vCofRk3mqgAvKUjUC7mCTX0q96Nl9r/GPpQ==
X-Received: by 2002:a05:600c:401:b0:40c:26ef:b24b with SMTP id q1-20020a05600c040100b0040c26efb24bmr3913382wmb.188.1702457015584;
        Wed, 13 Dec 2023 00:43:35 -0800 (PST)
Received: from sgarzare-redhat ([5.179.184.12])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040b48690c49sm19575443wms.6.2023.12.13.00.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 00:43:35 -0800 (PST)
Date: Wed, 13 Dec 2023 09:43:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 0/4] send credit update during setting
 SO_RCVLOWAT
Message-ID: <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
>
>
>On 12.12.2023 19:12, Michael S. Tsirkin wrote:
>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
>>>>> Hello,
>>>>>
>>>>>                                DESCRIPTION
>>>>>
>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
>>>>
>>>>
>>>> Patchset:
>>>>
>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> Thanks!
>>>
>>>>
>>>>
>>>> But I worry whether we actually need 3/8 in net not in net-next.
>>>
>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
>>> have strong opinion. I guess @Stefano knows better.
>>>
>>> Thanks, Arseniy
>>
>> Fixes means "if you have that other commit then you need this commit
>> too". I think as a minimum you need to rearrange patches to make the
>> fix go in first. We don't want a regression followed by a fix.
>
>I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, 
>because this
>patch fixes problem that is not related with the new patches from this patchset.

I agree, patch 3 is for sure net material (I'm fine with both 
rearrangement or send it separately), but IMHO also patch 2 could be.
I think with the same fixes tag, since before commit b89d882dc9fc 
("vsock/virtio: reduce credit update messages") we sent a credit update
for every bytes we read, so we should not have this problem, right?

So, maybe all the series could be "net".

Thanks,
Stefano

