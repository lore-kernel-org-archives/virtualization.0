Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE52F5A34
	for <virtualization@lists.linux.dev>; Tue,  9 Dec 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765293819; cv=none; b=bo8fS0K7oyZ/rnlS8dFHKEiUtCzvRBmMmFKGOKIhQzWhvZimJJvspMKJFJ0bv8gvV8F/XETFQo2Hewd8yP0g/zjlg+r5Z21x8n2cayvdI75ujPY+bcvdYOZtxB+7ZFr8m0+mTR0znF8mwdQl/QR+CfcXlopxQ31loNIZkkSii6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765293819; c=relaxed/simple;
	bh=JD5hyBpJAaNJ7sYgl/UrQWHJjtabTdl0L4UaYY83N+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+I9nxuU8ebC/Epk6mh92XvBJJAIiOIsVIhSKDWSAnDwlOCnclkO/rk44Nf1+rbTLE57HhyG9z6uOfu7pNIWgcd+gT8HEYJIjiaoHrb0mcS+QbSAtoasxQ2WWmleOVLlkAsFZ319l3CaHSTCoDTbF93RGkn4igGSzlTK8T9m5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJLdCd8d; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJLdCd8d"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso4837377b3a.3
        for <virtualization@lists.linux.dev>; Tue, 09 Dec 2025 07:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765293817; x=1765898617; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7DbZ+8N23FwouofrnDLigkDHoe3CUpkkU2pOJ+ToVI=;
        b=jJLdCd8d79JXAMZQppUskwh2TYLdmLZ3+cODMoPN7nLXLNIJY5QRcu8DSt+TpFwwZz
         /+Yyud1X89L0+KRQhS4cPAnUhsGCF4eD1cqra2naykTYPrUm5nNKu5otOXXykQaxkYd+
         jMHgy1w4GPFsYmWI4uroBPBnY23z7CKgLZJqwp6fpsORQakYPU+K7WSCALe9iIOEkxyo
         WlnuURXWx+az575AWztHRlAPcIIR9v3GxCEvMAGY1hIE49UVRoTeUEuphu1y6luFfvSB
         CERV16hHCDcv1XSzJNvtBfSzbIjzcWJsymK9KLssTsMjG64TfTHZGQGJZ5dBb4X67oQA
         KDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765293817; x=1765898617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7DbZ+8N23FwouofrnDLigkDHoe3CUpkkU2pOJ+ToVI=;
        b=M6pmhLE3OKPUFvcLXNagUp5v5Y0QiOUyfCH9IbHmRC4FGXp4f3JuZHq2Kp5knwCQ6a
         YZiOhu2tHJxKQd3yqut1dw2KQ/bZSFRDTTnVIdO/MI/rmfC2rvgMNvd5K/6KdjnK2cSU
         kx8qUJjM8jijD+V0Fl57PG60k4ikWq5nHwXKqbH4DDBgdAJ504mRGibUkDUSkw1cTLOb
         oZ2AnRJmzXrk2N3I3Yits/JGH2c56d7iXZ8MbYL3vbhHGvseQOjb1wpi4GnizmhwTYEx
         HPna/qQQrO+asTvuUYKHdDwE3i3SevIlc4veRPyWwecV34zujOvXAfYGxkjvYxSb3/F0
         2C+A==
X-Forwarded-Encrypted: i=1; AJvYcCW8gdbtnvCBSLabpwc1kHxT2o5S6RrRKf9C7TSMr1vhv3INH64LIvdbDWh0yUR4gI8SYPbI7N0/gcELyxo/GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnB0E+rNonLJwJaoWny0ZPXOoHrEdLWhuG8tBRmczgTOP/yHhU
	ibdk/IFfCk1Z8FZE+omgwcZSNWeNoL82ZXNVme2pAwyb8sHS+WLRDf5Y
X-Gm-Gg: ASbGncukwdqVQVimBWv3Ir85rMD40PbNuFUAlRY+HubfZUFgtbkK8E8Qs9Oqyq8tQ0i
	UEyTOMFk+/kOePnMf2RtW6OMMCIAV2pkg+wKL2oxZB8quy354oE0UZ0Bc/XbGiypeUnUeIt7Y+9
	qtgSUdjSTlNadVPlUaIR3xlPM77K5UdpFHg8MyedM5iVk5BqonOFnefsw6zHT4EI4bhCgCcaqrL
	VD6g0RH5sjvc66JziXPGN6eqTakGM35htsJD9XB5b651Ye0PtbM4cf4JojOdWjkryoboCHEfgW6
	sJ03kw3TSVVAwScCRmrR2B5HrVQZ/ttmKOBBknFFyYt5GyAaQXjlpjbpJh2F7q7YIrI7pkOXman
	t9mLM+rI7MP2rR6jPcx1cZUi3IXJItAIkYZK8Hhy1y6q5gHIPfBN3k1HIk+OQf/z1eROgyEYJWD
	xc/6eg5br/oYObCbPKeQi592PltBm3yhZq/uMeHyl98Y+HQGbZXBGlRLt3sTM2
X-Google-Smtp-Source: AGHT+IFN5sdylXJLxCHNNsv6xbK8xt8uPVU4i306NX8HPuK5V8M26O/oWPXK67LxkxgltqZUNhCZqw==
X-Received: by 2002:a05:6a00:1703:b0:7e8:4471:8d1 with SMTP id d2e1a72fcca58-7e8c786662bmr9491026b3a.50.1765293817283;
        Tue, 09 Dec 2025 07:23:37 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:e7d6:7fa4:50a3:fa14? ([2001:ee0:4f4c:210:e7d6:7fa4:50a3:fa14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ed2cd65ad1sm6229403b3a.56.2025.12.09.07.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 07:23:36 -0800 (PST)
Message-ID: <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
Date: Tue, 9 Dec 2025 22:23:30 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill
 work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/9/25 11:30, Jason Wang wrote:
> On Mon, Dec 8, 2025 at 11:35 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Calling napi_disable() on an already disabled napi can cause the
>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>> work too early before enabling all the receive queue napis.
>>
>> The deadlock can be reproduced by running
>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>> device and inserting a cond_resched() inside the for loop in
>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>> processing the delayed refilled work runs on the same CPU as
>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>> In real scenario, the contention on netdev_lock can cause the
>> reschedule.
>>
>> This fixes the deadlock by ensuring all receive queue's napis are
>> enabled before we enable the delayed refill work in
>> virtnet_rx_resume_all() and virtnet_open().
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>>   1 file changed, 28 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 8e04adb57f52..f2b1ea65767d 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>          return err != -ENOMEM;
>>   }
>>
>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>> +{
>> +       bool schedule_refill = false;
>> +       int i;
>> +
>> +       enable_delayed_refill(vi);
> This seems to be still racy?
>
> For example, in virtnet_open() we had:
>
> static int virtnet_open(struct net_device *dev)
> {
>          struct virtnet_info *vi = netdev_priv(dev);
>          int i, err;
>
>          for (i = 0; i < vi->max_queue_pairs; i++) {
>                  err = virtnet_enable_queue_pair(vi, i);
>                  if (err < 0)
>                          goto err_enable_qp;
>          }
>
>          virtnet_rx_refill_all(vi);
>
> So NAPI and refill work is enabled in this case, so the refill work
> could be scheduled and run at the same time?

Yes, that's what we expect. We must ensure that refill work is scheduled 
only when all NAPIs are enabled. The deadlock happens when refill work 
is scheduled but there are still disabled RX NAPIs.

Thanks,
Quang Minh.

