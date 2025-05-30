Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4195122B8C0
	for <virtualization@lists.linux.dev>; Fri, 30 May 2025 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597412; cv=none; b=kfObENjSi6H3PpskADGfHGJMzL/TrCrWIb+rrRPeLD+E9eKeYpvlEwD9FdDAl7NaqcmY0mxm6If7URHOctKAbQoAIyOd3JZa68l2bbhaAAWGchmIVltTr2JQHoXhaCu1ROAnX0R1yRWXAacukZZhGmmIXdMHQBo1fdtPG0uIOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597412; c=relaxed/simple;
	bh=nMA6BOKNQortAfZjTY+8NXKVM4Z8Hukb0WuDxYV4S0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhNI/KiI5oav3X+vzmY5mqozRx2R5iJuO7sMlmW1UTj7H4aaVXXENZR9MM7G8E5/yj/sx1VDjoVMlo0KRD0JEYbuo5ZG9JVMx382PyCQZPBU9+567AOjlulR6REQV7fvu3qEI+pfbNPBRnhjU6y3LGpurBNvnwztUp6Ou/ZFMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3OEBkIb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3OEBkIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748597408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0RNzhwsqUku1xsJElyNHLGqFPxx7/6+2t/Rn5eNr9pY=;
	b=L3OEBkIbVlM/qinu0CvWlKb4eKT2iycTEiGBmVVVsscYWTx/AVC36IBzQOzSDwjfRv/KEY
	IVXRTDHswsvRzjs+eQB7T1LilDKFCu0xT/f2ijsmyd0nhQ6Pv1rx9v/xLw4iUwjqbdXlpV
	7KDk2ZiYxYsHmRX8P8CNpNJpTsUWvcc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-hMx0dDqkPU-uwd1wzCuucA-1; Fri, 30 May 2025 05:30:07 -0400
X-MC-Unique: hMx0dDqkPU-uwd1wzCuucA-1
X-Mimecast-MFC-AGG-ID: hMx0dDqkPU-uwd1wzCuucA_1748597406
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d9f96f61so3020295e9.1
        for <virtualization@lists.linux.dev>; Fri, 30 May 2025 02:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597406; x=1749202206;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0RNzhwsqUku1xsJElyNHLGqFPxx7/6+2t/Rn5eNr9pY=;
        b=OCzINnQOozJ0LZDTXbeJduVySjhj8g8G9q1M2D96jPexB0LlXdhJYZl6WQlrxNM/oQ
         wm+0Ad463dR3K8KjH2nKk++Xw2iYkfPC7Dvy6gpn7GkRXctFUKMjxijkkEw9nbsjN5K+
         xVeUzgynWVWsM9BX7/FZjGb8LV0yAzTNM/KKYbFXdLXuh1p4miKmrN0HA4SLrw/YjMSV
         jltXV0Yxw4BGCIuvbRJThlisWHIQo419d9jqkK9l/N48jaYPE3K0ycDOMsmwdOoC1qHy
         A+jQzdxFN+h5N2NJ3Jw7YDnDuy62+lLgZm2qnlvYXc2NxAbsUzEl/xfDbY/wCJhTVK4W
         nh9w==
X-Forwarded-Encrypted: i=1; AJvYcCVh5QsCsiOVvGmGheyFcR1idRWX566/C1kRpbmev4RKPUFuEOUbrryarYFaGeSeJFuvfRTZMWFvmKM4D9PXBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGrUi+mowG8pwzcJtNpw+I7ajIrbKXqtCO2dmp9kQGfhguFXPG
	Dkb24DrMareDwe8uf9bQZyuu3GH0/cCpnCf03Y3DzF/EnAsRKsNPdk+mtmdeGNWpovggBLFQnJx
	RtNv8Ar8sRG4z/sl2FFBq7hiXp4hD7dlZNrlyFrTKlaGWNOnVSPSKHLDhJrHO8IpkL3cZ
X-Gm-Gg: ASbGncsgrj/0ulJUwg3FBR9GpIfDpSog9R3wq7IlDNsNSb7yHCngSBFpAw/O40oAJI+
	+Ma6gSHpZ73YZ1hd/p9qAF+GoF5s0Ir6MKpp9x8FXskp0WEI/TKufZeDNTwMjX+2LDwi5yWmoUd
	YjPUPWszsiDzpgxOxdSX+vXzQLD3/Lb0ylzgkL75xphDoPyxR+z0nbOQyKoTqqAGqq7CXRClpFm
	CkdMitIY37KDw+qWjnM8bHzZcguiiFHbvwmRvmcLqhl+9494jxQj8sBc7Vi+6BvQAJXk8Y7ti6W
	uWEHATTdc0WeeaasdrUIXeB1QltDh44qGbgqXJwBft1TNGRX0nlTvD+UdSd0IxU79yfX3xlJOH/
	9U6Yjt1VWxH41a0/Dn9HajCzyUzJ7Lsrnmxtx1og=
X-Received: by 2002:a05:600c:a088:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-450d6547524mr26073875e9.18.1748597405844;
        Fri, 30 May 2025 02:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2BOtiydMOfq1UD1dFaTSdbt9kgs6g/FvHe0NUDZiW/Mb+ZwIUaJljI/hl7D5dUDFLJdO/0w==
X-Received: by 2002:a05:600c:a088:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-450d6547524mr26073605e9.18.1748597405404;
        Fri, 30 May 2025 02:30:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f03:5b00:f549:a879:b2d3:73ee? (p200300d82f035b00f549a879b2d373ee.dip0.t-ipconnect.de. [2003:d8:2f03:5b00:f549:a879:b2d3:73ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c525sm4319304f8f.23.2025.05.30.02.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 02:30:04 -0700 (PDT)
Message-ID: <40c773a3-e1d7-4c8c-a6e4-793f8aa7f983@redhat.com>
Date: Fri, 30 May 2025 11:30:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] virtio-mem: fix multiple typos in struct comments
 and function docs
To: Alok Tiwari <alok.a.tiwari@oracle.com>, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250529084350.3145699-1-alok.a.tiwari@oracle.com>
 <20250529084350.3145699-2-alok.a.tiwari@oracle.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250529084350.3145699-2-alok.a.tiwari@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RoCPoT99QpfPLjmMGwMyjWq9ylHAg78xYhzDbmsFdls_1748597406
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.05.25 10:42, Alok Tiwari wrote:
> Corrected several spelling mistakes in code comments, including:
> - "bock" -> "block"
> - "valued" -> "value"
> - "actipn" -> "action"
> - "accidentially" -> "accidentally"
> - Improved grammar in a few places for clarity.
> 
> These changes are purely cosmetic and do not affect functionality.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

