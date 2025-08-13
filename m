Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E852D46D4
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755117699; cv=none; b=RfObuaCpoZ8jcCkYE/PtahyccqgtbbENb2WhtGwUGd5I6U9NIXIyjLNMeMxJ46EwGiKOo7aSYwdvJ95BFs6NXYGJde0SA3/o7x4yPjigkBnck6Pu6tuFt2gTr0XSCo2xAmZpMfUdYQK6u1YF/eAyIcoHv7IFH7GRdoeWD235FzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755117699; c=relaxed/simple;
	bh=lUr3Coe7jMJZI85cbFPiW7/f1hQpbTVBVSQph01AmxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JADAZlHQr7paoYsfY7m/iZ7a+91GWDiXyigUxNFVcmbiV0VaVMfbm1oY5Obzc4lTKPVd/rG2WypQGWu/CshOZlnFWajnKBCzS+0aPejoT/sHidMnANF1/vVuGObqzeofZ59iyYlX/n4e7IHTYjb/nZxDmi1gPvdyaSVEUhecPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFZwkKP4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFZwkKP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755117695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBleD+055ltSM9SLVyMdhGo/eyX/NfyNWllMpqcy3W8=;
	b=KFZwkKP4Mr3UW9k2IOI90s2JHEu+EHTJF0dvif7vuvPi4S6Uy3l6BIAZo413J2IXfNpxvU
	rr39K1HXnEkwY0xG2whlJN2SZwUSVGb41kCwttK5+bunhU0TCKpMhsSL69cpWUusqWKG5q
	7qjYzVmKyNjHgkPPRv0oDCwfzzWunSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-e6AXoANKPUeUYsz1MwTIHw-1; Wed, 13 Aug 2025 16:41:33 -0400
X-MC-Unique: e6AXoANKPUeUYsz1MwTIHw-1
X-Mimecast-MFC-AGG-ID: e6AXoANKPUeUYsz1MwTIHw_1755117692
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0b2b5cso798055e9.2
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 13:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755117692; x=1755722492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBleD+055ltSM9SLVyMdhGo/eyX/NfyNWllMpqcy3W8=;
        b=MkhjFiBPU9+yUwSSnBkhiiXp4s926nF8y2bVIn4PWwP/9fCybK0foggJ/rTnNNUc0u
         cP6/iaghq4dC6xNxF/izxoIVYXyyZoQ5cRHklddIHf6+zKd8PV2gmMfQ3hCP172L4ZkG
         PIUI2XjD6y72d3caocBiOa2lQZ0VisZZQIi0mrN+Io1bbWXrtl2eCaMXBNmFeRnoRtGA
         w9K8jl5qZsvsOtDI7sM8PnpS8wR+mOgPgeVyGiqvmx+phaP7z1LP+KUygOlV5hzBQepT
         g+CGTE9CYpE8VtJkdz2L7Q9Z1yXjvbLAy75xoCj35qh12Qe5ODCmIonEnYKHTjR+u4Kf
         6E+A==
X-Gm-Message-State: AOJu0YwlFk6FDT9ZE9a16nPrfOwBE0jN+xHncVFFOqm62dr3UcEyXJ1O
	SG38q04a04fP3trQWhmEEhV7YCDMSiLh8z5RZgcZuvfkGsynO5vQcglQX9Je+ttPEXxU+PTB1c+
	/ArrOZNZ+9kdHdQAbHGab4TJuIhYtYcv3R4hKh9OqMq6jMPZ4bkIL7qk0BfIj+HYrMRj0
X-Gm-Gg: ASbGncsbfGMVfmjk5hBqE64vlnG61YzEqhZzWeW9gH98wWOzqueWvAZr4QLIrXfmkjl
	o7gea7lyc7a93n8rzu6xOMhD/iMg6tqhTb+xyGGPsULiTw2ToPn3qQbaHkvB/tUqE47xizlsIuW
	qOnlj4JTI6M3k9EztOm8OIc4Je/72tq8DzUggZsT6LHDAEZ1JFvA1vQalDQwo/TB/iPrwiEAOlJ
	NHpaybwgLGmYKt0ymLjeHTMZ/DNwyBck1w+7+aWs4+XiKywLgzy+B5UQHyaRDg1z+TQX9xr+Isu
	AK4S4x5h2kdhee3MRggRPXc5YLNq6vYPEXhHURZbHw==
X-Received: by 2002:a05:600c:19d1:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45a1b6614bamr1774405e9.16.1755117691540;
        Wed, 13 Aug 2025 13:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZUnYwIAOPn7DHgmGP8oaqqq7HJdTWwhYbAqJhLDNgROKech4NZKaObKqud71WSCyJ04rPfg==
X-Received: by 2002:a05:600c:19d1:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45a1b6614bamr1774235e9.16.1755117691090;
        Wed, 13 Aug 2025 13:41:31 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm26709722f8f.69.2025.08.13.13.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 13:41:30 -0700 (PDT)
Message-ID: <146fd5f7-c694-4606-afa5-522c5c05d9ff@redhat.com>
Date: Wed, 13 Aug 2025 22:41:28 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Virtio networking issues on v6.17-rc1
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <aJycJvs3xztfD5Rm@pluto> <aJzU1JsV5we-QqgQ@pluto>
 <aa46dd09-a450-4633-a647-b04781599c87@redhat.com> <aJz1_HzPsEyvY6HN@pluto>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aJz1_HzPsEyvY6HN@pluto>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _2iqmVydkp3kiblv9paQh9Re1QvVf8p338MluHUg3zk_1755117692
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 10:31 PM, Cristian Marussi wrote:
> On Wed, Aug 13, 2025 at 09:51:30PM +0200, Paolo Abeni wrote:
>> On 8/13/25 8:09 PM, Cristian Marussi wrote:
>>> On Wed, Aug 13, 2025 at 03:07:34PM +0100, Cristian Marussi wrote:
>>>> Not sure if it has been already reported but in a kvmtool/guest setup moving
>>>> the guest kernel from v6.16 to v6.17-rc1 I completely lost host-guest network
>>>> functionality....in a very funny way, though, I'd say...
>>>>
>>>> In fact NO error is apparently reported in the guest kernel log and the
>>>> interfaces seems perfectly up an running both sides, but looking at the
>>>> host/guest interfaces you can see that ALL received frames are indeed dropped:
>>>>
>>>>
>>>> enp0s1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>>>> ....
>>>>         ether 02:15:15:15:15:15  txqueuelen 1000  (Ethernet)           <<<<<<<<<<<<<<<<
>>>>         RX packets 125  bytes 17948 (17.5 KiB)
>>>>         RX errors 0  dropped 125 overruns 0  frame 0
>>>>         TX packets 1207  bytes 51182 (49.9 KiB)
>>>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>>>
>>>>
>>>> ...on the host same..(taken later on...)
>>>>
>>>> tap0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>>>>         inet 192.168.33.1  netmask 255.255.255.0  broadcast 192.168.33.255
>>>>         ether 8a:10:f6:df:a1:70  txqueuelen 1000  (Ethernet)
>>>>         RX packets 804  bytes 43904 (42.8 KiB)
>>>>         RX errors 0  dropped 804  overruns 0  frame 0
>>>>         TX packets 101  bytes 14408 (14.0 KiB)
>>>>         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>>>
>>>> ....and for a good reason, apparently, since sniffing around on the Host TAP
>>>> interface I can see a never ending stream of:
>>>>
>>>> $ sudo tcpdump -i tap0
>>>> listening on tap0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
>>>> 22:40:42.309158 00:00:00:00:00:00 (oui Ethernet) > 00:00:00:00:00:00 (oui Ethernet), ethertype Unknown (0xffff), length 54:
>>>> 	0x0000:  ffff ffff 0215 1515 1515 0806 0001 0800  ................       <<<<<<<<<<<<<
>>>> 	0x0010:  0604 0001 0215 1515 1515 c0a8 2102 0000  ............!...
>>>> 	0x0020:  0000 0000 c0a8 2101                      ......!.
>>>>
>>>> ... DST/SRC Macs are just all zeros WHILE in the payload you can spot my guest
>>>> SRC mac address 0215 1515 1515  :P
>>>>
>>>
>>> I bisected this regression to:
>>>
>>> 56a06bd40fab64448aa6b84aa06b3dc470c1254a is the first bad commit
>>>
>>> commit 56a06bd40fab64448aa6b84aa06b3dc470c1254a
>>> Author: Paolo Abeni <pabeni@redhat.com>
>>> Date:   Tue Jul 8 17:55:02 2025 +0200
>>>
>>>     virtio_net: enable gso over UDP tunnel support.
>>>     
>>>     If the related virtio feature is set, enable transmission and reception
>>>     of gso over UDP tunnel packets.
>>>     
>>>     Most of the work is done by the previously introduced helper, just need
>>>     to determine the UDP tunnel features inside the virtio_net_hdr and
>>>     update accordingly the virtio net hdr size.
>>>     
>>>     Acked-by: Jason Wang <jasowang@redhat.com>
>>>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>
>>>  drivers/net/virtio_net.c | 85 ++++++++++++++++++++++++++++++++++++------------
>>>
>>> Reverting this commit on top of v6.17-rc1 solves for me and network works fine again.
>>
>> Thanks for reporting, I was not aware yet of this regression.
>>
> 
> Hi Paolo,
> 
> I spotted this issue on my setup this morning.
> 
>> Apparently there is mismatch between the negotiated features (that
>> determinate the virtio net header size) and the actually virtio header
>> used by both the guest and the host, which is totally unexpected.
>>
> 
> Have the UAPI headers been updated ? ... I could not see any change...
> (not that I am very familiar with virtio core :D)

The virtio feature space has been extended from 64 bits to 128 and the
blamed commit is the first using the 'extended' virtio features
negotiation.

But, modulo bugs, the extended space should be used only if the
hypervisors exposes the relevant capabilities. kvmtool does not do that.

>> Could you please share the host kernel version, the arch and the kvmtool
>> version? Also I understand you only upgraded the guest kernel, without
>> any other setup changes, am I correct?
>>
> 
> The arch is arm64, I could reproduce on a Raspberry Pi5 with host v6.6 and on
> an Apple M1 (running Linux natively) with a v6.12.
> 
> Both host kernels are from the original distros unchanged (Debian and Fedora)
> 
> In both cases I compiled from scratch (make clean && make) kvmtool on the
> respective arm64 Host using the current top of tree from origin/master at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git/log/
> 
> 	commit 	ba6830eec0f5 ("vfio: include libgen.h (for musl compatibility)")
> 
> Run kvmtoool baer simple with
> 	
> 	lkvm run -c 4 -m 4G -k $IMAGE_DEF --network virtio -d $ROOTFS_DEF -p "earlycon loglevel=8"
> 
> All was fine till v6.16, and it is my usual setup and update procedure that never failed really
> as long as I update kvmtool in sync.
> Not sure if something is still missing from kvmtool master repo for v6.17 but it seems reasonably
> updated (July25).
> 
> I wonder if no one else had this issue on arm64/kvmtool....that would made my 'regression'
> suspiciously tied tomy setup..

Thanks for the detailed reproduction steps.

I agree it should be some bad iteration with the arm arch and/or
kvmtool. I hope an arm system is not required to reproduce the issue,
because I don't have any of them handy.

I should be able to dig into this tomorrow afternoon my time.

Cheers,

Paolo

