Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC91547F3
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728729760; cv=none; b=LuKhxnc3pcku15OdggWpX3ur5ZwGRKAWyxYbJ7V7fX0J/aPk1/L9vqzFYQDCZz9sS8XaXclF1uqSgb+qB9YJ9Of4I5030tvKywJIYAmKE1Dos5yx6B9zzUQvxBA9Jejs0IDE1uaBOXmMfj5imjDE2YZAb7+bms1GLYRXotPnj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728729760; c=relaxed/simple;
	bh=F2Sp1fzcw8Uf/QMINhGhDYWS9F5dWa9nb4/qh8r/ALY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HqVOzHup3PNZRtSAm2CA9qUeVQcx6ynKXPOi8i6y+PNQpL+Dgs0t9sJdIgOKphjRDsBlwt6p8Q+XVcQe64mFwzijWYFAbtu9wLsJXjDNWuYNswQZ/Z5CA4dNh/qlYL4ehmWg+rOBFmX8Jn0ynIhHOhlzgNdTKfIRsO8Bs8cVaVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=xXG7ikeh; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="xXG7ikeh"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C268140186
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eMQsd7ZQXgLm for <virtualization@lists.linux-foundation.org>;
 Sat, 12 Oct 2024 10:42:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E4420400F6
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4420400F6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=xXG7ikeh
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4420400F6
	for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 10:42:37 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-20b93887decso25742685ad.3
        for <virtualization@lists.linux-foundation.org>; Sat, 12 Oct 2024 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728729757; x=1729334557; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnVDkA3/NaAKhKgMUHvmItPchk02Cn37cnkYPg5p2Qw=;
        b=xXG7ikeh8sqW60Snu3irHgHWscsGfLyg8XeTni06G8RSANU0qR5zvkBdHjRemuWYON
         J8d35rBRbZuipQBo6LKcgBy0bAukx4Z0+Yp5r0mrH2IUSQmViexKKGf7aW2scR5fCItL
         NsXebid9JLcjGB988ZS3pWpcDZxDkYYMBf4uQ8TQxvpVhHmTO6sZomZUPxwH9Ht5t5/9
         KNL3tYdZDvmCZg0NSwlq7eCcjNQLbVWQWALHXB/nJFjjLQqZC0HpL6EkB8CO/BrAWReN
         gyVRqw0XWWQORiG/q2L/SBBRYdiGZDlP/wh0VfXl0rcd/N87qIDxElRWP2QxIpLIZoHk
         PZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728729757; x=1729334557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnVDkA3/NaAKhKgMUHvmItPchk02Cn37cnkYPg5p2Qw=;
        b=eLjAcuU9anI1AvH2hSv78dy1dKVb8AQwEjYooGg2l9whB40QKqSuMsfbIJFidsCTU8
         WDddRNm77ERabBBnFNTnGHmSp9pVMG2RJ+pcW/jN/uhKLyR7RID/Esh8JLfDSGnmie9b
         jg328LmsR81pXEKEzzZSfYJ9M1Eby6ISjGZ1tzpsDwp0P87MY03Qd7e8LvXGfBx1TJCD
         YlwiYGtdUiBvmV6Wky75xoJivpfS2cbiuSfKac9GdN2CE9BETDG4w6BL+OqIVSQ2LgKz
         fSvLC1e6IjcfO5yW3jNrnDCtEZTvFHMIWLiwy55DnSCb/Owjh5e+1r0p3NJZdm4ccEUu
         jkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSKOhHADJJyrAQMj0gzyc5V2W3H/5MmrGaW/WA1kmsB/8cTyzfXlacC7lx/xsKhXfFnKM+cZZQadbJEsHrnQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxcqitNvcGpYQlhQ6J1Oof0YdKdv5qFD/S6TENASX3etxKYGwDP
	tjHPq1/j+3lT/e0EGhM0YMJI5SE0zIIY49kQoKHBdDUZZ4jtCb1Zt+WNHj3qG4I=
X-Google-Smtp-Source: AGHT+IHAAJSka16NZVOG9ERRGT0s8XZNSpBXGOA3FY01waa9+ItcfG5gf6PTH3meZ9nN0csYqZ692Q==
X-Received: by 2002:a17:902:e5d2:b0:20c:ce9c:bbb0 with SMTP id d9443c01a7336-20cce9cbddfmr6671465ad.0.1728729757238;
        Sat, 12 Oct 2024 03:42:37 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33ffadsm35367635ad.266.2024.10.12.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 03:42:36 -0700 (PDT)
Message-ID: <30bbebd8-1692-4b62-9a1f-070f6152061c@daynix.com>
Date: Sat, 12 Oct 2024 19:42:31 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 01/10] virtio_net: Add functions for hashing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-1-f3cf68df005d@daynix.com>
 <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/09 22:51, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> They are useful to implement VIRTIO_NET_F_RSS and
>> VIRTIO_NET_F_HASH_REPORT.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
> 
> No need for these to be in header files

I naively followed prior examples in this file. Do you have an 
alternative idea?
