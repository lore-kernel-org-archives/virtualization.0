Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781E2031B
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAAq0JUl"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BB8181D21
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 09:42:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BB8181D21
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EAAq0JUl
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0-S4SCeHVJA
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 09:42:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2132881B72
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 09:41:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2132881B72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702460518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMjiM4LhWNswCgPTt5l6t+VxQtdI2J7qu3AHHUQiHmI=;
	b=EAAq0JUlKUfVWvPLenjn2li3RJHfT822xN7HFRCB+LuPc55382fXypRrFLG3BYGmmRTnGG
	EL49PlqBpcEQsDJ6+LnhEUb8fx4MPdw0xYdOw6dULuD2HeKMv80a4Ho3T3Sm7HZ6dXRm9f
	gADLgPvoaxby8Hid16UYzjVd243ssmE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-QHay_BHFPEyK1s2KeLW9hw-1; Wed, 13 Dec 2023 04:41:57 -0500
X-MC-Unique: QHay_BHFPEyK1s2KeLW9hw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bf6201648so5262270e87.2
        for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 01:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702460516; x=1703065316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMjiM4LhWNswCgPTt5l6t+VxQtdI2J7qu3AHHUQiHmI=;
        b=pXxWUp/KSJWFz47vGhjO5q3UjzohB8Jc5I2EOiFab85U+mpkplkLMEadJ9f/n7W6Nb
         6ZbN8O0eitl7TExjkqKselNmq6JuS2/wmn+WGrecBnojZJjUftlsvhld6N/mj8Xmj8xl
         QcjcUR8PahDy90x4DPv3NrZJmj3oU2plxPKEWr4WNWmD6iJZbSz/yfY/yvDRwfkFL8Q1
         KXV336EeBtSUbchDR6VMCFbXUpKIDQMnOC04DwUiYCRmcd/z+83ibsATXhAXJRmsRMoh
         zph2wRsyORJXfMQPWRqeouInQ6XUjhNjB0n8XeZ9SQ5DIJMfpFDVpBQrSjmnrFOlTvuc
         FrmQ==
X-Gm-Message-State: AOJu0YwMgGCtFxUbmHQsT8ZbZg5ZK5A/6pupjXR6XrtU0Ecb/XEOo9cO
	ouycgq5jvkTTFUWjB+IdUueCFEFsr27JuIU4quu35iGL/Wrwnny+XHe+tyol+16EsSXqS4jkj92
	b6wKeiH8j6VQQAA/qQVhpuZT0NDQelEuYvxsaCNX5Zw==
X-Received: by 2002:a05:6512:3eb:b0:50b:e5bf:cd08 with SMTP id n11-20020a05651203eb00b0050be5bfcd08mr2969680lfq.0.1702460515798;
        Wed, 13 Dec 2023 01:41:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWUHETsBer3EAOA0gPfl7B0VS0WtqWT/aW1HbYvhGOGQYIsmV3HSuvb3hi939lrTpgrAbrSA==
X-Received: by 2002:a05:6512:3eb:b0:50b:e5bf:cd08 with SMTP id n11-20020a05651203eb00b0050be5bfcd08mr2969675lfq.0.1702460515420;
        Wed, 13 Dec 2023 01:41:55 -0800 (PST)
Received: from sgarzare-redhat ([5.179.184.12])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003333ed23356sm12977633wrw.4.2023.12.13.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:41:54 -0800 (PST)
Date: Wed, 13 Dec 2023 10:41:47 +0100
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
Message-ID: <msexilrot3dmvzrsn25zfwmcnbxpsmiuuvktzbnirq34udk6as@pdz6yt4rrjvo>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
 <20231212111131-mutt-send-email-mst@kernel.org>
 <7b362aef-6774-0e08-81e9-0a6f7f616290@salutedevices.com>
 <ucmekzurgt3zcaezzdkk6277ukjmwaoy6kdq6tzivbtqd4d32b@izqbcsixgngk>
 <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <402ea723-d154-45c9-1efe-b0022d9ea95a@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 13, 2023 at 12:08:27PM +0300, Arseniy Krasnov wrote:
>
>
>On 13.12.2023 11:43, Stefano Garzarella wrote:
>> On Tue, Dec 12, 2023 at 08:43:07PM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 12.12.2023 19:12, Michael S. Tsirkin wrote:
>>>> On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
>>>>>
>>>>>
>>>>> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
>>>>>> On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>>                                DESCRIPTION
>>>>>>>
>>>>>>> This patchset fixes old problem with hungup of both rx/tx sides and adds
>>>>>>> test for it. This happens due to non-default SO_RCVLOWAT value and
>>>>>>> deferred credit update in virtio/vsock. Link to previous old patchset:
>>>>>>> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
>>>>>>
>>>>>>
>>>>>> Patchset:
>>>>>>
>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>
>>>>> Thanks!
>>>>>
>>>>>>
>>>>>>
>>>>>> But I worry whether we actually need 3/8 in net not in net-next.
>>>>>
>>>>> Because of "Fixes" tag ? I think this problem is not critical and reproducible
>>>>> only in special cases, but i'm not familiar with netdev process so good, so I don't
>>>>> have strong opinion. I guess @Stefano knows better.
>>>>>
>>>>> Thanks, Arseniy
>>>>
>>>> Fixes means "if you have that other commit then you need this commit
>>>> too". I think as a minimum you need to rearrange patches to make the
>>>> fix go in first. We don't want a regression followed by a fix.
>>>
>>> I see, ok, @Stefano WDYT? I think rearrange doesn't break anything, because this
>>> patch fixes problem that is not related with the new patches from this patchset.
>>
>> I agree, patch 3 is for sure net material (I'm fine with both rearrangement or send it separately), but IMHO also patch 2 could be.
>> I think with the same fixes tag, since before commit b89d882dc9fc ("vsock/virtio: reduce credit update messages") we sent a credit update
>> for every bytes we read, so we should not have this problem, right?
>
>Agree for 2, so I think I can rearrange: two fixes go first, then current 0001, and then tests. And send it as V9 for 'net' only ?

Maybe you can add this to patch 1 if we want it on net:

Fixes: e38f22c860ed ("vsock: SO_RCVLOWAT transport set callback")

Then I think that patch should go before patch 2, so we don't need to
touch that code multiple times.

so, IMHO the order should be the actual order or 3 - 1 - 2 - 4.

Another option is to send just 2 & 3 to net, and the rest (1 & 4) to 
net-next. IMHO should be fine to send the entire series to net with the 
fixes tag also in patch 1.

Net maintainers and Michael might have a different advice.

Thanks,
Stefano

