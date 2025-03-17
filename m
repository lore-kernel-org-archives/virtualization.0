Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10A621E098
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200498; cv=none; b=ZZFOKVNl9eGBJCPhhlImUdRcY1253R1LPVR7ab3XENkBaaltc5XAl57q2AIJxD2zq5pgl9SHnuK6sOfG8uMyfa9jgoDG8v7s6m55FJPnFKB745h0aK2E5/dcgyOcmzxuLMP4F6wK7wCDFh/Upbi8jRAg2CbbF5hbuA3jd65qPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200498; c=relaxed/simple;
	bh=c2n1Fx835UhBJSllbwffn7zGDt95tdAKPpRn0ntoO54=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M9YLpttB7bvjMB+FRUp+GNLs8tK+stvyMcrySOgEZ2zkXwXi5t8yUiUUqTQJPEhhqTbL4rupWwlvnB8Z827cS+qms7jSGY6jAASadCR6p8wuw5BhnCmOhWH7cBnkmt0D55C8jDqEDxV+aQ0H9dte+zY6qAaF8CR4+Pzc4mEEoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBOqkmy2; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBOqkmy2"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 250B081462
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 08:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S3n8c9WiPxqi for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 08:34:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 522D28145C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 522D28145C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iBOqkmy2
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 522D28145C
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742200494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8fFsxESP3H629nCG6gkvjmwLt+3pqm+G1ABejpl59E=;
	b=iBOqkmy2I/u7fAfoNmOWXE3uliKmm9hazTauei1cA0TGSUlUxo0qHWmweoaLzNb4gxtkFL
	6Mj5X45ASBtIhAal1j3MCqf5IRurD+HpN8C+6WthC331/rHss2Pe9YbR0wuuyJZrPAA0fk
	J6Bmbi7eDS2x1H83V1xT97dj/HzO2Ik=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-vqKAELqCPPiPOcGnr1TD6g-1; Mon, 17 Mar 2025 04:34:53 -0400
X-MC-Unique: vqKAELqCPPiPOcGnr1TD6g-1
X-Mimecast-MFC-AGG-ID: vqKAELqCPPiPOcGnr1TD6g_1742200492
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso2404175f8f.3
        for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 01:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742200492; x=1742805292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8fFsxESP3H629nCG6gkvjmwLt+3pqm+G1ABejpl59E=;
        b=vFzetkl6DhwaCoaqKadaeipC134sICA7yKKKLS26iKV8hFn5HXWEkkQH8RWD80OkyR
         /KtXd9qzYmFIsteALIt+Io+IPIlrgKR/KeKduJue1bgads+qvp9QFbfaLePlhOtwmBoW
         tJj7/tUNp14EBJme4+6biv5vgcGV5CXhNFSd+VXLhfmQEFq3lHipGPXFJ+zeb/wTVv56
         cIG2HcNaU01RI9UguHibjf7ldoP6ddhH12NVdC59bDDcwLNEoGW5+s0uehO0qEZFWQYX
         x2gU6XUstRgjycBf+587uFPHCepWzAr96fbwLaFDhzi9qToIKXKi6gP9g2awegVWfrxh
         8mcg==
X-Forwarded-Encrypted: i=1; AJvYcCUktoPoIkI+C1eEpcWmd0RhccKxfJvlI5d9USteeeDrhZ7w6DR8AnpD2lCJWP5khWSKQ5HeNLqE924N3rdkrQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxvGZvXbtE37rIkh5+AXoV56lDhPyc7VAsw9Rl1use1ndKhKhsG
	FCFcSKymJRNzg89VU4b5YiDi20pozRWmXhCzmpcfJFXbNjnPCq2AQw2yT7Zw/NAXsTH269I1xTu
	Kt9vXyA/81QKpp07Pt3m8TuLPB01GvBNRJ05Vj0bPpbuzlqtyxKY9FFZYTLkWDm6t8aiMP22T2v
	fivJg=
X-Gm-Gg: ASbGncsyVfmkbUdP8kGNBj46jO4kdm4l49frBSK2deB1InzTDA0pI72BFk6FXxGsDbk
	yhGqV5Y93xU8cr4ZmwH4pmIvPPlNnMKvSsjn+3bGq/2iuVD9iRhvSWdauv8pcCtUnPp8YkOmVlI
	rWK4t8tNlQQO3tM3U5lzXMZtdTZ1Y9ISt94aiVUDLBIi9h28Sc/pGZtZzjwsDL2DSx3Y/PO58H6
	BHarx5xVcOsyoR5nJ9Yvz99vv599Iimd78E0VTCuNJkMCwTsfQ8MfD8JdD2Hh7xc5HE1UhWyuh3
	PGYJvVZLZR45yUybbp6m6gKoQNvqy5KyNpt2OxT1mttEDA==
X-Received: by 2002:a5d:6c6c:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3971d23508dmr10794770f8f.9.1742200492284;
        Mon, 17 Mar 2025 01:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV3AlBDqXOJvZL9/HUdYQCvelee3VTZFcDu+UlzkczKdH898voG07Nf0T2P5NkPsevzif4lw==
X-Received: by 2002:a5d:6c6c:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3971d23508dmr10794744f8f.9.1742200491924;
        Mon, 17 Mar 2025 01:34:51 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fae4asm98193875e9.27.2025.03.17.01.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:34:51 -0700 (PDT)
Message-ID: <5b9d622e-7404-490a-a13c-1181d196d7c6@redhat.com>
Date: Mon, 17 Mar 2025 09:34:49 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 06/10] tap: Introduce virtio-net hash feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet
 <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
 <20250313-rss-v10-6-3185d73a9af0@daynix.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250313-rss-v10-6-3185d73a9af0@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tIP8eeSEazLE0mNL_pID1e-wpICLBK6Z61t-yd7OfjE_1742200492
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 8:01 AM, Akihiko Odaki wrote:
> @@ -998,6 +1044,16 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>  		rtnl_unlock();
>  		return ret;
>  
> +	case TUNGETVNETHASHCAP:
> +		return tun_vnet_ioctl_gethashcap(argp);
> +
> +	case TUNSETVNETHASH:
> +		rtnl_lock();
> +		tap = rtnl_dereference(q->tap);
> +		ret = tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, argp) : -EBADFD;


Not really a review, but apparently this is causing intermittent memory
leak in self tests:

xx__-> echo scan > /sys/kernel/debug/kmemleak && cat
/sys/kernel/debug/kmemleak
unreferenced object 0xffff88800c6ec248 (size 8):
  comm "tap", pid 21124, jiffies 4299141559
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    __kmalloc_cache_noprof+0x2df/0x390
    tun_vnet_ioctl_sethash+0xbf/0x3a0
    tap_ioctl+0x6f2/0xc10
    __x64_sys_ioctl+0x11f/0x180
    do_syscall_64+0xc1/0x1d0
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Could you please have a look?

Thanks!

Paolo

