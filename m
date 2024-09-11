Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39D14B940
	for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073749; cv=none; b=FNaBaRtoaqxA6pwD4puTEPxquCegNdZhd4zSTzQJc41Vov+1XqHh1+a6Kgs/hfPq7Z2owegSVPOKk39RP/ZIxz0FuJ4kV92zoxNT5NCeiI5tOHTCn2DH0IrHmCfTq5alrAFQrUP/qy63UjQ9a6Gxg04VupHQSCIVUAeQ+b1tSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073749; c=relaxed/simple;
	bh=upjVQvBHFLKvH6/nR76ihRbNNYVq/nTkGK5Go2fEf0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruZ0Kk5Wqmemjik1PFgiuyelODwl9hHL0Q7j4ytQJyEhmyxV0CddGMVxY8QGnOFXj+mBRnHHoOX5G90IBk7p3FhjtDgPtHyK14/UXzMktJ26JjL44mPeCbxF2TL/sDDrxN2uWEspgiZlU/kQbPsM5p2LC3BAOfIumNuptGQBMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=VLTFsRE5; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="VLTFsRE5"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710e1a47b40so1349338a34.2
        for <virtualization@lists.linux.dev>; Wed, 11 Sep 2024 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1726073747; x=1726678547; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71kMJfnqMi6GcSxoRHCfWVH1SbLPDeS4BbpEwTiguGY=;
        b=VLTFsRE51ofsKLDwc9ZE0x2/xJ+I+hV/vTw0En3kuPfm/JAq7JSky5uCiZFxTDasiW
         rDbvUgtuRH/lVIH97HP6hCtQh0SGdCxWRLAOEZDTdvKvnpdEPwPX18F4MMK5tu30kQSU
         horTJJvwh9LlAN4Ruzx6Vl8xaF3i9ECybnlWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726073747; x=1726678547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71kMJfnqMi6GcSxoRHCfWVH1SbLPDeS4BbpEwTiguGY=;
        b=mH0pnXDdCPbWV3fVcaHxVVIVbxbE/xsPqUBo9WCZyeNPf6aLUVKHv0GNgcwSyUaN0R
         dHrLs/lPjSmzQeCRdxuFSQ2HOf9ML2EHlqmjZ3FK4k3XDWR7LZwe45peJBtVZdy9mxAB
         zzO1CRyc1oMFnigGzgGHS9HZsOW9nPKR9Sa74OwJCd8PtOgQu/V3NlRYl4pRqx7ySx2X
         u39rXjqz6aMHwLGmEQIPRg178oIEjCtUXQFMYwvy5EuWLDEIY2JCyFdntflc+HLC5mz2
         tKyULaO1le5UPtI1ADJITsOWx2Q3U2o2R1K3RcAgNbcOdGqki4utHk+Aooq2ImeGAjlT
         ou5A==
X-Forwarded-Encrypted: i=1; AJvYcCUMJNoAjCIWfmxpRLIHq8TUkNORFqjAL5QyAn0o2h0PLUb+jh0YQ9MVtd4zZSZa2j4IOXo8CdgOLky9lWb3fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfeIqk1bQEGksYZuK0rVHLoHv5gpSu5nX1xlw891Hq/ekvMnH8
	vxzKF0cpRmnhFZFDxd7jLilR1MhMAy7714KhXNyooSnAQimFQP4EY9wToqmSfLo=
X-Google-Smtp-Source: AGHT+IGbyMLLP31vLuaB4sqWmb1kSxOxuK7mSa0lgQKxNiArEKoQm8OVlmJBkqsDSeFjMCa3+PJTAQ==
X-Received: by 2002:a05:6830:270e:b0:711:3ed:88d0 with SMTP id 46e09a7af769-7110957144emr157996a34.30.1726073746602;
        Wed, 11 Sep 2024 09:55:46 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:9198:79cc:8e64:e479? ([2603:8080:7400:36da:9198:79cc:8e64:e479])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9d5deb5sm2351506a34.38.2024.09.11.09.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:55:46 -0700 (PDT)
Message-ID: <4f6db868-d1e8-42b5-92ad-ae22331f5bd1@digitalocean.com>
Date: Wed, 11 Sep 2024 11:55:44 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA
 config updates
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com,
 shannon.nelson@amd.com, sashal@kernel.org, alvaro.karsz@solid-run.com,
 christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com, bilbao@vt.edu,
 xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com, eperezma@redhat.com,
 cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240910022843-mutt-send-email-mst@kernel.org>
 <CACGkMEscQWywn67yN7fAaRdWkOZV80RryCvyf_02RDWjrKZMwA@mail.gmail.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <CACGkMEscQWywn67yN7fAaRdWkOZV80RryCvyf_02RDWjrKZMwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 9/10/24 10:42 PM, Jason Wang wrote:
> On Tue, Sep 10, 2024 at 2:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Wed, Sep 04, 2024 at 10:11:13AM -0500, Carlos Bilbao wrote:
>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>
>>> Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
>>> vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remove
>>> ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supported;
>>> see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
>>>
>>> Carlos:
>>>   vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
>>>   vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
>> This will need a rebase. Will apply once you post one.
>> Thanks!
> Note that I think patch 2 is probably not right as we indeed allow
> config write for some device.


I'll rebase patch 1 and drop patch 2.


>
> Thanks
>

Thanks, Carlos

