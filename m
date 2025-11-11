Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27934FF6E
	for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858109; cv=none; b=FuzydNHcTeo+Ub2HGHOgjlDdIFx1rdhaDsjpO/H+8xw/r3avUZK7+jAocr9evhSBJtJsNQdK16hwGNQpaOMQHJDnSh+UPhOvLSewgR6p7s3+tE2I07z/JZrHcMCjMIOwbs/bPIK+t+6VIoLuV1964oipUNhM/9nN5l2PHQxUYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858109; c=relaxed/simple;
	bh=jPYlSKbbxPShmT/j1owIcqg9LSaWtN/iy5tvOnqbOQc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u71ZBXyN3O+O2dPP4HNphGUqy9UYQ2K1FBxYTA1eMyeJXGx5e+3DRZQONW/ZDQHomPJ7tP2Lsd5npSWJn8Ex8z+zSySS5J2DdV6RL0Xch0PfntD40jVnQNyLho2F89jpPTrvXB2GQup9M+jk5uLq+ZcFldmaNnrp8Wz4wTziBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CB0QlH66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CB0QlH66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762858106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=702tscy4MQhNVgtuEfCcAB2EHb/k9VMlM8tKTxfp3Zs=;
	b=CB0QlH66AjQvawmCycwSIbJ+SLKV9RlVpNq4OitVAIBsLgGlcjUcUlfGHPuIFLTCyg7rrs
	9TG6V8m2WZiqlvnKYfndW/ZqnQB01EgeNHRlNAKvSw33I/UTDW2hOC/3eP6mXmkfVlGRkH
	Y0bp3I9OS5BCbIpEdi6CUN78YCI4Hcc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-vKfMWTDhNs-3gqZKsGlScQ-1; Tue, 11 Nov 2025 05:48:25 -0500
X-MC-Unique: vKfMWTDhNs-3gqZKsGlScQ-1
X-Mimecast-MFC-AGG-ID: vKfMWTDhNs-3gqZKsGlScQ_1762858104
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4710d174c31so31857765e9.0
        for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 02:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858104; x=1763462904;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=702tscy4MQhNVgtuEfCcAB2EHb/k9VMlM8tKTxfp3Zs=;
        b=wxY/oQN77tR8XVBj1fwbiZy2IkDDrKiQ/3PP3WdZ4zn0RTdNuK083nSCfkRc/UCBF1
         bVmNEi3gNzqUO4pFx+gl0gMBxhud8VEbapvuY2UXuELbzXjqHSm2zKyZoLqrmdN+349r
         Fv4bMnJ1oUAL00DpkwgMvJoGgA3CQgbFORNwDU1PBnDtGglk3K8fFd3V9Dx9J0wViIAD
         4/Ms9GFIikwHzGpebc8bYx2dYOscolHPaF/CFmP1WrBp5sYkkr7duH4WjqT23Y6FGRb7
         GQuolrBRdwppBdxI7UUFVtU0nHVffJWG0hAFArOTuuHgSxiIB6H05uY/rxoxMPkub2o2
         pCVw==
X-Gm-Message-State: AOJu0YxhnR9RfFARVyh0Wv8nkk1zWWQVllNk2ZhZkaihk7diwrbpd979
	Dq/KB9MqOWTnkGshMJZ3J9gQFb+rlxVIr21lO57xlh7aUOg/b0EvwXny5rh8ZF0Ww0KAn4UBQa5
	xJxhcHDblBMrkVZC8SHwS5RM4/2N3Y+Tdy4byQHGQU33dQpNnMMnlgZJiiBv3Ps8dBeyv
X-Gm-Gg: ASbGncs7GXlhp0hW1PibUolWi9ulpCxnCHAiMLFzxxK4g4k43LLSj4OETnNP/UdRDs6
	PMl+7EpEhX8KZDsOhM0CGkQZeLg6bEXHJWdOHHHTvvqyQyOCbWRNFN+AH3ewn0FDNxAM7oYjhCT
	nK00vyc4DpAOuEesBqOzLCxe0+8Fejq4dPb1De0BSSfroWKaZUYlXOEY0A38mLvwV7iofCDR3q1
	JwzwR2RXW2+tpp9CNvP7H39qvTUU7HQKnOR/haDPnANS4TRTd5+jYfaDyWmKt1PEU0OKtK+j7b5
	CycSb+PHUdFcV6fe7OxzLUXa+AJtB1GL76kFBiLoNEba8Cb/PfJA4LYi/Egs96qAF/vEOQDlFtp
	QdQ==
X-Received: by 2002:a05:600c:474c:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-47773228b80mr83633615e9.1.1762858104215;
        Tue, 11 Nov 2025 02:48:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF+RWqDNIiIpdYlbLwd8BM3n7tt8c8GRXGm3n3mN1y4siRCVR9yYMpmg7EqPzIAyqkss0fNw==
X-Received: by 2002:a05:600c:474c:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-47773228b80mr83633445e9.1.1762858103781;
        Tue, 11 Nov 2025 02:48:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477816431f9sm16926605e9.1.2025.11.11.02.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 02:48:23 -0800 (PST)
Message-ID: <e1d7d4c1-263f-4f2e-b1c0-6672ce6d7d58@redhat.com>
Date: Tue, 11 Nov 2025 11:48:21 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 05/12] virtio_net: Query and set flow filter
 caps
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251107041523.1928-1-danielj@nvidia.com>
 <20251107041523.1928-6-danielj@nvidia.com>
 <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
In-Reply-To: <ee527a09-6e6e-4184-8a0c-46aacb11302f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pqx9vyC2_Xsp_WpsnuBcKd4RlD0YiNiYwDbJt5_GIks_1762858104
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 11:42 AM, Paolo Abeni wrote:
> On 11/7/25 5:15 AM, Daniel Jurgens wrote:
>> @@ -7121,6 +7301,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>  	}
>>  	vi->guest_offloads_capable = vi->guest_offloads;
>>  
>> +	/* Initialize flow filters. Not supported is an acceptable and common
>> +	 * return code
>> +	 */
>> +	err = virtnet_ff_init(&vi->ff, vi->vdev);
>> +	if (err && err != -EOPNOTSUPP) {
>> +		rtnl_unlock();
>> +		goto free_unregister_netdev;
> 
> I'm sorry for not noticing the following earlier, but it looks like that
> the code could error out on ENOMEM even if the feature is not really
> supported,  when `cap_id_list` allocation fails, which in turn looks a
> bit bad, as the allocated chunk is not that small (32K if I read
> correctly).
What about considering even ENOMEM not fatal here?

/P

