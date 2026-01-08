Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7613D1CD0
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871819; cv=none; b=tx0svUV/QiZBJUbUJuAgGfx4nCCNA166nBCRv8LCsgEYxddw1PYUFWeRtEYdys4I8t2yWJAjvoD6YUti76nhjM61tTnpiSpOHJq+wjiLd7ymEqn9rkLX9iRKCGuaDY1mtxD3tZPSTcQKoFd7ohmji6qFIDTnNK7/snD0+7tTCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871819; c=relaxed/simple;
	bh=Pa9x4JglsrY6GFCnO9O1vnPBicor/gXV2BFxa9ZW0QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AddjqZChGMYNlwC2EsGNKj7uRqMUk5yym47b1a9t8+h/V7QmIxVbaD2p1duxvQHty6qJFHvqah3ZW24W6qN7gU8kz4iy/bfVf55b68zsM2CoxJTxlWT3+C5m7beHEyg6EKDrgyXvrLj9i5ED0SKeqN8cXeUyuj3cRR8Ai90fSAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPCTZvdo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPCTZvdo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767871813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pa9x4JglsrY6GFCnO9O1vnPBicor/gXV2BFxa9ZW0QM=;
	b=DPCTZvdov3DqYirgNUUY3VESECkPjIALLG3eKSxGPr70RDzc3dmSEYpGnQ5Qat763in9AA
	nMHOu9QR4ZLPXbZCSNPXd0V7ZFvKeqAA5fsiG7uxYn9J05LcfZKFzNoZ9meBh2O39eh5LC
	vUpQlhKeWnE2RRQmiEBkwWqjFLPKrIA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Ui1v3VweObqRLct-sin90Q-1; Thu, 08 Jan 2026 06:30:12 -0500
X-MC-Unique: Ui1v3VweObqRLct-sin90Q-1
X-Mimecast-MFC-AGG-ID: Ui1v3VweObqRLct-sin90Q_1767871811
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d4029340aso29955025e9.3
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 03:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767871811; x=1768476611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa9x4JglsrY6GFCnO9O1vnPBicor/gXV2BFxa9ZW0QM=;
        b=IjLTzBQI7Zy91sSceiuZxkxGRPaXSVfTjCbDXONNNqqd3eeJUV+zPy8dGNHnT7jitK
         sVKIBjTnzq8hrbZ/XzWMilKM3mOSzK83RVy6sffI2cyj99QfvqLZq+AOoNgv8NT4mC/p
         iEaoPSC4/+ikkwLEgr85waOCee+V3vVFS3jvpeIQgXjWGFUJynaZCxbVa8ikamuc0flk
         9KPKS+fcKUZbjPAA75XLG6/dAGxRPqz78Abr0JYTEAsT6lZ+vs5yi7IT+KWoY+iewx09
         aLSHMn+kX7qP+Kk8sm4kM/tAL9+O4WICKVA1yjZR62XQA3msYqGHTM67PDM/ICIiv4Zh
         FqVw==
X-Forwarded-Encrypted: i=1; AJvYcCVg8uOSRh8hjyZ9rnBh/6D/42gEXBOnLfDJ4lY/nBnES/OEts+/BHtzAQVs4j4xZprdQDO4bjx07UeJ7LZBEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUiu7U81lfp76ldQ7bT7XHiq0wUjiHUoZMHPjZa7QdC9VOuxb6
	Re5vY4sVPpxMfBL0hXvY3Pxjn86v//ttwwOm+Zyakvf+fxZX8IkWOMU1uxLC/2p3nsS2kf9Am07
	IUYO66CqCeJkd8eyq9k2LybRe4iiObrTCLx35ocwsft/gjJ5eBG07g4pCxqTpKXUBvegL
X-Gm-Gg: AY/fxX6H1mDoJ80tL8jjDA+gttBlddVl11XYbMi5KoDazbtbGDGHxobInyeR16Gs9Px
	my8YZ3e4eiDegReP6PKs3CiJTfuFVCLKgC6bGTrNSA9LEjs4yNqLVODfytdBoQJAfAyUrV5NQ5c
	zz4dmPahGILhjtzkZrFEBxlEbzjtmfQvaCxdOZcv7cLylAGvEBJLNqAmKQaDO/pwIBfVttYg/XG
	+ODZm/Taz7bi2tOAugFebue6EzZDSECTq7ICGzonaOrAANOxjiVW+6g/mDZP+xRah4Or7CasZhv
	ZxSQ0eJh9z2ej0ibLmlwQwIVt7+5AxRiNMclGB1W8fRpvLDRb87gvgpeK28RoZop8+sziXcfnlY
	lJJPlvYYBJTH/4xX9
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr68555235e9.21.1767871811245;
        Thu, 08 Jan 2026 03:30:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8+bmvV/WNN6KWlnzqQVw+P6bUXizWXcjIaBg1pO0qOtQk1LqtVJ34EAenyZ8H+/3EN9Zvfw==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr68554925e9.21.1767871810799;
        Thu, 08 Jan 2026 03:30:10 -0800 (PST)
Received: from sgarzare-redhat ([193.207.178.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff1e9sm16625689f8f.41.2026.01.08.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:30:10 -0800 (PST)
Date: Thu, 8 Jan 2026 12:29:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: add a final full barrier after run
 all tests
Message-ID: <aV-VIKJiHeT6t_df@sgarzare-redhat>
References: <20251223162210.43976-1-sgarzare@redhat.com>
 <9bde9e8e-3ae2-4199-b416-ae3fdaf090f5@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9bde9e8e-3ae2-4199-b416-ae3fdaf090f5@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gvcw1kAma1AUlgDvd-j39OGFxaNRZ8RYAmtM0g8Piqs_1767871811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Dec 30, 2025 at 12:08:44PM +0100, Paolo Abeni wrote:
>On 12/23/25 5:22 PM, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> If the last test fails, the other side still completes correctly,
>> which could lead to false positives.
>>
>> Let's add a final barrier that ensures that the last test has finished
>> correctly on both sides, but also that the two sides agree on the
>> number of tests to be performed.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Net-next is currently closed; still this looks material suitable for
>'net', with a proper Fixes tag.
>
>Please repost for net if you agree.

Sure, I'll repost for `net`.

Thanks,
Stefano

