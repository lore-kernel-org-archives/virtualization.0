Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27F22EF4
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlZoOgmC"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93FD0813D2
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 08:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93FD0813D2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QlZoOgmC
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePZNZsOXt0YJ
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 08:45:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55609813A0
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 08:45:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55609813A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702543541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uecrAR2SvWDsLJrH3uSpDFiFSpzellwPNoFaP7Q0oHU=;
	b=QlZoOgmCrZmBFJs1x86L/yJ+EQUdnf6QIyRTtV4t94XoAP1Abopi3teYt3UD0JW2oFYGA3
	q0qZcKovP1+BxmuuXhVz6pjCVIlj6akneYJQ8RpX4tLpfc9NqmCUnDZ4GwgFzM0BpBEEVs
	rm6S+T26HI+IIjxcdk3Y40UVCxJhKPg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-eOxW9f-zMump5N8_cuNBUw-1; Thu, 14 Dec 2023 03:45:39 -0500
X-MC-Unique: eOxW9f-zMump5N8_cuNBUw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c2dd83bc4so48812935e9.1
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 00:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543538; x=1703148338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uecrAR2SvWDsLJrH3uSpDFiFSpzellwPNoFaP7Q0oHU=;
        b=qYGRJsSs2SnjdXf7xIPiXhWslGt0pZqOhozptlsrp/LiEa6pF0O4ju5fIB80lihf/u
         JcRIuJ/JHZ/toMv1LjkJos+e2FR+pqlngsuVhpmdysGfhzz26ergIGcWsLp8TtCbhm3X
         uveRtjRGdDvH0WUD1N2twpK9KM+U897/KgSfz1H5DespGRWuWcMv47MJXqUP3Z10s57d
         6QTL3LBrmuDHM/NrKgiDdYX9oulXQTmaRfy5A3yzNPWT1STTpsx2Ug1IqSahtypEl6Xj
         9/i15ngJJGdUxnvAiAxSmCgssXNqth1j3ZqIiRRXEuFJc21aRXdWVrppbukj2tQKlOnT
         aaHw==
X-Gm-Message-State: AOJu0YxB/IXIUQOFCqcmHGetcE+zCOAtfpbCURQMB64x/Ap55BKB2g5M
	9ab28xxOBBpobYe6h/izY43aPm+ItaDfIY5QbwZIL2QvEK/DoxvGWWgmD1l3KoqgCL3YEZNgXo1
	+q1+pHp1CCsS8vRUEotkFf6VHkVhdpxPi0ZE/s20ZZg==
X-Received: by 2002:a05:600c:246:b0:409:637b:890d with SMTP id 6-20020a05600c024600b00409637b890dmr4662202wmj.2.1702543538710;
        Thu, 14 Dec 2023 00:45:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd9LpPd9LlR4EdQvDKYuR630GgNDCt0NG+pjD6dcylIDtVJwCEubGxS9oHa85KaPw5yjKlKA==
X-Received: by 2002:a05:600c:246:b0:409:637b:890d with SMTP id 6-20020a05600c024600b00409637b890dmr4662193wmj.2.1702543538360;
        Thu, 14 Dec 2023 00:45:38 -0800 (PST)
Received: from sgarzare-redhat ([5.11.101.217])
        by smtp.gmail.com with ESMTPSA id dd14-20020a0560001e8e00b003364277e714sm2802139wrb.89.2023.12.14.00.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:45:37 -0800 (PST)
Date: Thu, 14 Dec 2023 09:45:33 +0100
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
Message-ID: <gu2yvaqqgrfnffnh67fodsoob4cdpcw4zaifncku3qvadtuq5j@6unpf5ifdmtd>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
 <20231213100518-mutt-send-email-mst@kernel.org>
 <20231213100957-mutt-send-email-mst@kernel.org>
 <8e6b06a5-eeb3-84c8-c6df-a8b81b596295@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8e6b06a5-eeb3-84c8-c6df-a8b81b596295@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 13, 2023 at 08:11:57PM +0300, Arseniy Krasnov wrote:
>
>
>On 13.12.2023 18:13, Michael S. Tsirkin wrote:
>> On Wed, Dec 13, 2023 at 10:05:44AM -0500, Michael S. Tsirkin wrote:
>>> On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
>>>>
>>>>
>>>> On 13.12.2023 11:43, Stefano Garzarella wrote:
>>>>> On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
>>>>>>
>>>>>>
>>>>>> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
>>>>>>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>>                                DESCRIPTION
>>>>>>>>>>
>>>>>>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
>>>>>>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
>>>>>>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
>>>>>>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Patchset:
>>>>>>>>>
>>>>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> But I worry whether we actually need 3/8 in net not in net-next.
>>>>>>>>
>>>>>>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
>>>>>>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
>>>>>>>> have strong opinion. I guess @Stefano knows better.
>>>>>>>>
>>>>>>>> Thanks, Arseniy
>>>>>>>
>>>>>>> Fixes means "if you have that other commit then you need this commit
>>>>>>> too". I think as a minimum you need to rearrange patches to make the
>>>>>>> fix go in first. We don't want a regression followed by a fix.
>>>>>>
>>>>>> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
>>>>>> patch fixes problem that is not related with the new patches from this patchset.
>>>>>
>>>>> I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
>>>>> I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
>>>>> for every bytes we read, so we should not have this problem, right?
>>>>
>>>> Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?
>>>>
>>>> Thanks, Arseniy
>>>
>>>
>>> hmm why not net-next?
>>
>> Oh I missed your previous discussion. I think everything in net-next is
>> safer.  Having said that, I won't nack it net, either.
>
>So, summarizing all above:
>1) This patchset entirely goes to net-next as v9
>2) I reorder patches like 3 - 2 - 1 - 4, e.g. two fixes goes first with Fixes tag
>3) Add Acked-by: Michael S. Tsirkin <mst@redhat.com> to each patch
>
>@Michael, @Stefano ?

Okay, let's do that ;-)

Stefano

