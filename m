Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1F2E7F3E
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341060; cv=none; b=W3U3tuYgTHtztL2/rQauftq58sJ2efCb+Q9JdJ/BWwGIUaIPYg235cUQTYd6H8t5+8ob+yOMNn9zRYD0Aa3BAmK8OMqM2CWiSkeizTfKHr656pnhso6Z4qqj42M9kRmOESzLXO+LJ2PWRk9I146p7nCSHZz8UJoSn5fcu5LLRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341060; c=relaxed/simple;
	bh=QavRGcr5us+t7ZQ0SiFAKkIUSpfw/02p2jIBPVYNY8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyGPiX3TMGO9POLne5uXomfUJ+X4BK818Wc8sQOGjbcXexMD5IlBnp52bVOAfCgFAwJ+CzxRXH2JToD+e8izuZdUtTxxrxETlTN3v8XP4TmhGRlsImVt3TYQlfHE/UlcaunOmVeORS8ZGecKT0BiQaWD86dKhWPT7ZYkeBYFZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXip1egU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXip1egU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760341058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhV9pCLfuO4+7vfM+XZ8BJUrYFHf5xM/gGd3XHGNreI=;
	b=VXip1egUKOafzpWmQZnXhFXTRP5y+5/CLADz0U26Ch9wA9HwafSlqloQ/PyMPqpbQLMfK1
	1wAB2k3sLH6mjKF+Aju7yHGWZcBw+zrsKLkB5YwGgdmGXcFUBjVruJ1ooKXDHlYQoicceV
	vAvrs7LQuEcJsEZSFoa3ReJzufy2gYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-7vjLMd_NOsqo476yIET4bQ-1; Mon, 13 Oct 2025 03:37:36 -0400
X-MC-Unique: 7vjLMd_NOsqo476yIET4bQ-1
X-Mimecast-MFC-AGG-ID: 7vjLMd_NOsqo476yIET4bQ_1760341056
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3dcb36a1so31733155e9.2
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 00:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760341056; x=1760945856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhV9pCLfuO4+7vfM+XZ8BJUrYFHf5xM/gGd3XHGNreI=;
        b=iMQKKS4cqNHMbZ9/I8Ng0nUPCPvQowbShE1RUlGWxKvlJNNLqsxG2d+kvw6+vE2QE4
         tB9bjj6Y8l/6vlDNKDYmbmXrqHdEEO3R+tokedzRTpittHzaKcFUJ72daq78K5/XActO
         SBtWVmMZJ9KdS67ZiQCq8A+8RPBbU/eWJ4Sav/pPP3t3hmcw2CumUjv9JQ5dOMs61OVk
         3kGWmeiyQZwxImAd+Ll1EbjH6GzK4Kcqnb2MITPNdHNzPwAqgFyIts6/HXIoBRPgXfz4
         /6rac9N784MD30Rz0zYFAoCH8tDnSLnC6sE35IAjHLu0cKjUuVk5TNFKTt7O6AjcWq1k
         RHKA==
X-Forwarded-Encrypted: i=1; AJvYcCWp8HQap8rALuL9wZsd6f2lWUwdDMcCzDa/l/K5WmVZUr7Et18XNZ7g0TSSf0SWz5ZTn350rXfxtPBjpVLdig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu18uaw+f9Ww/uw2O+hmnl6ctBHojMgekabr+ORakCxoU18Tnm
	IvMck2IoAPJEV8pQDtz9yl99MwxjjxpbFd5YiN82fKKxV5pmqh9npMHuL59N4ckLkM+Ylb5aB3D
	kwkezj1lZep3/n1vaA1KsmluasOSfDgnCwD2LZeJqb7wR23OO4mz/fQU2/sxoylgJskOl
X-Gm-Gg: ASbGncvUBOWJUtnIurH9H155ImoUnLTYwcMmPVgRRKO/1BE43lH6nmp46k/CMxTwWCZ
	zY1VcmebR00Z+GX7u1nZXegBwsGTdrvxXrFB9NPyYkF9W2atiqC9R+Kv5UX9dNtJP7jjCd61aCl
	n3pVzP2yEwB0UAtmwlf2ptJLMBdtEK+wJFV6+9VE2jPlIWqNwaAYVTqNZIFKtgrUWmOvKjEhU1C
	mlgr01NGMd+Mbg/pCYoCqn5g/wbKjfyD6uaCED12EKgt7VsBaeXLZsUUjmORr5WCR/W/wB/SxW2
	FshyC/e+Jqz+DQjsIcG8H4alCtnrqhOmOs5eYQaGhR+k
X-Received: by 2002:a05:600c:5297:b0:46e:5a5b:db53 with SMTP id 5b1f17b1804b1-46fa9af30f0mr121221185e9.20.1760341055659;
        Mon, 13 Oct 2025 00:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hJl5V5jje4Mv3eVG6dVD7tglU9SGsJ2gOGFWCHIkFUforeKvUDKoupvg2eTp/qCQ7E7BCA==
X-Received: by 2002:a05:600c:5297:b0:46e:5a5b:db53 with SMTP id 5b1f17b1804b1-46fa9af30f0mr121221045e9.20.1760341055271;
        Mon, 13 Oct 2025 00:37:35 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49c3e54sm171604185e9.15.2025.10.13.00.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 00:37:34 -0700 (PDT)
Message-ID: <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>
Date: Mon, 13 Oct 2025 09:37:29 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in
 vring_map_one_sg
To: Jason Wang <jasowang@redhat.com>,
 syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
 syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
 <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ysZYO516IyF0Y03ArjdyuRULYJ4kxdVyjn6zGng2c-U_1760341056
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 9:20 AM, Jason Wang wrote:
> On Mon, Oct 13, 2025 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
>> On Sat, Oct 11, 2025 at 3:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>
>>> #syz test
>>>
>>> On Sat, Oct 11, 2025 at 4:38 AM syzbot
>>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>>
>> Paolo, it looks like the GSO tunnel features will leave uninitialized
>> vnet header field which trigger KMSAN warning.
>>
>> Please have a look at the patch (which has been tested by syzbot) or
>> propose another one.
> 
> Forget the attachment.

I have a few questions. The report mentions both UaF and uninit; the
patch addresses "just" the uninit access. It's not clear to me if and
how the UaF is addressed, and why/if it's related to the uninit access.
Do you know better?

It looks like the uninit root cause is on "the other side"? i.e. the
device not initializing properly the header. Would unconditionally
clearing the hash info implicitly disable such feature?

The syzbot dashboard mentions a (no more available) reproducer. Do you
have it cached somewhere?

Thanks,

Paolo

