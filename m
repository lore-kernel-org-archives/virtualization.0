Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715239;
	b=g3F1ioJhtMomv9r6uTcAL1diDfrOMNuvms5JjMJsPem9ETEbvw1yGjiwgfL/kYJvtKBm
	 k0n4ywy5HedtKq6kXkBGU2DJYouNxYUjqHGdY9gZRpiDUp8Jz+zKt+eBc0wdAFf46PjUJ
	 LZayXlFhcpKruaR7YxQzN9w6ZEMFauJGSEgi8XTmcSbEnH7cNR+1ZTNkTDmGk2FpMz32E
	 PdZ3Io1odHF5pHPy+KOcm/mCeZmqMy8WmqIBEUtEUHprIifoFEMbk0jo//Cw+EzSWEN6Z
	 Q/yrd/MbaoWvs9zQop25CjRNC+s5YHKNue8BW6CrSWKYDVlqsTf1Y7girMXoGTGaONA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715239;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=XVx1I1BAZHH28iV5zivj82AtwmqyL72xeO8t00SbIII=;
	b=FoCgDkOqmaw75T8mrl/01IimmXcC6QvgWGHOuW4uE4a1RXrHZu+AkEG9/uhwtT8J8Q1k
	 AxcyBVWSoU474CTmJIGTA6H3lAH9li3AnU7nZOh2l2yIH3akNClmCLdLDIzpwurNt6SFn
	 Z0DbxjOHFNIU1eSChlGF98fD5u/ibJMCjRPNscfJ4o2fE9ukFMOoML8STXsLjGUkXvwkt
	 niD2ZKinpDotakfRktEyGQKoRCHRLzSxg7XInmhv8L0e52w/4CQ6JVDFiUQvlY+6sItTq
	 +a6qNni6J4v6TCJIAVaN/Fe3kCWVQazw1+se4P0spa5CWZryoWZaEzdddZpfSNRd0ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EA606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 14:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 342EA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793715230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVx1I1BAZHH28iV5zivj82AtwmqyL72xeO8t00SbIII=;
	b=TtqHjydbmamDVjJ1zrJuz99NaZtZkIBTnf+TLS5dwN1ZVqQCN3iUiq+2jYgSt82kZC214e
	xrvI7XnR3Jc/wb6lSWrSYGjNGwH5F8YuGNf+Rij7jmpW0PzMEsV3X3nSlKt9C15auluPSw
	2AJlM2NZkpurOqM6hVyKNQug4zA2tRs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-XQ-Zrv6bNPWFtQekxb_hnw-1; Tue, 03 Nov 2026 09:13:49 -0500
X-MC-Unique: XQ-Zrv6bNPWFtQekxb_hnw-1
X-Mimecast-MFC-AGG-ID: XQ-Zrv6bNPWFtQekxb_hnw_1793715228
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so3752556f8f.0
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 06:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793715228; x=1794320028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVx1I1BAZHH28iV5zivj82AtwmqyL72xeO8t00SbIII=;
        b=2lt0G/rF7RLOK74bUG41OxHTAN9QTrwBofrjK63oWHljxwjhFp95eT83bIOn+2Jokj
         V7OHm3t6xAiPb8x/jQCLskQNZDM80D7u8mGN6OAudtuDCbNCQvPuy/qND+kuKuBRM0aP
         HOp7pAMb9DwFgnNMtlVWoZZxCFx0L2fcz/uiTMLs/vQtzqNlbGCsiQ3FN51PWW49iX9D
         +2D3AUlwnbetxJmQZ9FXzIUphGSWTPkLPzcXokFqfQ14yVUA2Igv3vW1QQW9SNWjFPdc
         43EeLioGc7SfxJRFosbjQIXaXqmQdAaqlukjvjIqAuPLf+sdnbv32a4Cop+j+RAonfkJ
         4AwA==
X-Forwarded-Encrypted: i=1; AKwUvBzMCaytK4nkWdVSocqGPao0PKICnd6h9lW7Jw/pUTgPbZ4OQE+lMlb4eJg76tZxsgmNfGoqeIUZ1wozVHWjZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/v65nEkmtVH2DUzNc5dlmirbOg50OJwd/b0rnuklomj7AlScu6
	hl+OFAYjFK/h3eu/z79Vk1e+4pslLWarAxKH8caE5ypLy3tPVMlD4X51yBwl9pem1XGdTzGN2Sl
	qqQRYuDqR59R23o4n375JvBaMfSNsbeiul8Iwuxm2lR7StWfIbwgcJb96QtPvDpF7d+rn
X-Gm-Gg: AYBFou1M412Bo6/KXFd0dsc2D4ie4UvrZzvOXIUvhyR4hq96/zyAKG3Q9ryxk/tynol
	kiQ7arJHLu9EOWrCSF+Q03Q+tXnbYyZcatj4V6xIDTDluG0WCFEOktycypNTSJm7yzPNwXgOUbL
	SL7d8uqHcmAt26uYwQLaxVtSGl8XAwvJChq4RAsi5DX/mXoq4Tj+NKYCC2wwkCBBBED0rfEyyYL
	XoWCerbAIVdIywl0Lbc87aurYbXPL4a4VRZg3BnUcdpV51BobGnBRM4lrma4f09YFINfmBDZ6ys
	hyVjrjQsEVTyCJ+bsbeAXqjUG5QnfGKaJIavxznz2gKSJ//KDIxoreI2bYPrakLMsoIkCTd0/Qs
	O/T6l9ycr7AQQoK12BRTleYacC4p6PIKlNR2vNqeNpAp6wJKqKzzlQf0cRW/EHW/vJg61QdY8wl
	ccod7LEdqOZRWbAdFVssRC3SYyjHkFssEdUwn2J1VKhYI=
X-Received: by 2002:a05:6000:40c7:b0:48d:f1b3:c02e with SMTP id ffacd0b85a97d-48e6e5016f1mr30505635f8f.25.1793715227727;
        Tue, 03 Nov 2026 06:13:47 -0800 (PST)
X-Received: by 2002:a05:6000:40c7:b0:48d:f1b3:c02e with SMTP id ffacd0b85a97d-48e6e5016f1mr30505585f8f.25.1793715227337;
        Tue, 03 Nov 2026 06:13:47 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9a3b1sm27222574f8f.44.2026.11.03.06.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 06:13:46 -0800 (PST)
Message-ID: <d0b6c2ba-34f2-4750-92c3-fb65c82cbc9e@redhat.com>
Date: Tue, 3 Nov 2026 15:13:45 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock: reject negative tv_usec in
 SO_VM_SOCKETS_CONNECT_TIMEOUT
To: Stefano Garzarella <sgarzare@redhat.com>, phind.uet@gmail.com
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030064428.73930-1-phind.uet@gmail.com>
 <auSIGIZctLp1oOhf@sgarzare-redhat>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <auSIGIZctLp1oOhf@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BLYs412XAxsok4qdcu5QtELU9DRO_E7Il6sQ4Bh00m4_1793715228
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 13:09, Stefano Garzarella wrote:
> On Fri, Oct 30, 2026 at 02:43:50PM +0800, phind.uet@gmail.com wrote:
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> The timeval validation checks tv_usec < USEC_PER_SEC but not
>> tv_usec >= 0, so a negative tv_usec makes the timeout computation
>> wrap into a bogus value, later tripping "schedule_timeout: wrong
>> timeout value" instead of being rejected.
>>
>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>>
> 
> This blank line shouldn't be there, maybe it can be fixed when the net
 > maintainers apply this patch, so please wait their comments before sending a v2.

No need to repost: I fixed it while applying the patch.

/P

