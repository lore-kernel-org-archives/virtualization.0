Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED31211711
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148741; cv=none; b=hPJ2ZA9La6ETXMGC5nx3ZUclFHhxUeYsf6MNZZblSkbOljYMvenEcNbL8EcOyAXhnfLVsgMGS2VZ9qFe+4e0G6NERBjktHdlNKl9ro8cnQIUaopkQ5pCjJvNnWANQK8mWwnIJ3/736oBJKt++c+8kbr3F5y0kGSihRn6razNIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148741; c=relaxed/simple;
	bh=2L5aR0c2GcBaUNPGmIPtfmh8S5kkoZdASScGp1O5Jmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sqX7I1jFo4QRaoGE10xxtw/CUg3URY5z4gxxfeONdBO/gJDldx5khCu2INCh3jT6Mz25XUenv8FHsOSLbheSce9sGn/5AvlccnQvCwLN3GVRDAqYvuNSaiPjcirjVRzszKtDcGsLCxxvOKUpJ0/SzPAmyzINIxDTrFO2yuB1zbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBE7qqyV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBE7qqyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750148738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bm5aTFTS9Qh17d2Pxd5wPdYdMyLTNdjwRqtuRVZzJA8=;
	b=cBE7qqyVQ6kNtz7Kn6jn/eIH7AuKPwwcJKIa8CKBU5Y3YdySm2APEF8m1OuN0tDBkftf+v
	2sgjSZr56JDN8g3hW79zmSyn0IYE/ngAdOkFH5kfPowH8Xjlnm3qAi5Nxta4GvCNdRjT0x
	BJJviWABa38EzHxGS5iaHpGqpmxlobA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-uNxrtYBQOsuaorA9j0ZQEA-1; Tue, 17 Jun 2025 04:25:36 -0400
X-MC-Unique: uNxrtYBQOsuaorA9j0ZQEA-1
X-Mimecast-MFC-AGG-ID: uNxrtYBQOsuaorA9j0ZQEA_1750148736
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb4eed1914so51951786d6.0
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 01:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750148736; x=1750753536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm5aTFTS9Qh17d2Pxd5wPdYdMyLTNdjwRqtuRVZzJA8=;
        b=i39/P21K7vH+cA7JDEqAXkbrbEb4PfBZQb4j3RZIO5t3vPjblqOE4LA78Y+ncOTA3Y
         ILFp3re0ahN64QjfIpPeCRohh/LrkkmktKhmjCO6P2fe5DEwgOmqVSTFfLa7+KXCQ2Wi
         U2O5+QAD8JBn8FY4edB5BIKSbtNp7RJdg/8VV2bFVT6jtDrMBmaVynCii2eB1E1Ji1AC
         vIdVWnrzROkUFakH58q4XwEnkvTIWh2UUx/mDegPyfxlWFbwpH6YAmLMQvYGyJG3+GFb
         W3P2Wh55Awedqgg0k8+Xf1yslio5ju94AAd2D7qD5i3Ol+ysKHPsyaLHNHa8vnRt87/1
         Pd5A==
X-Forwarded-Encrypted: i=1; AJvYcCXxZcaIBtEHqi5dvgnd92FV8gQobwzR5hYwQs7Q9nVLc5ex0ECBD4JUV4o9KATUDuTk5DciW96VuKUDJxf2nQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBSPC+klIvjCJSNTw78FZbS3NCza3S9p+LjpetYs1kfYf8vRIO
	9DAhmnQJoVdaoHTvdfEfU99WoXvpns6XU3nxTV6lqNvs15Ng8BmnNvgcOdxVaalI0aqSsOEyYpM
	gfEqtw1IC5RYAMD5Ddki1KrnhclHQvtqV6UDpj9YcyIvtV+YyWq9wIraoZW8CAK6Cziqp
X-Gm-Gg: ASbGncstflw/bHGPaRcvCRgXsGicJguMtgAvPhGufBmEqRYvJzbkkSE+41RNpTm8t/J
	pCSGQuxZGZSGB5qgETs4KGfRsQe2wkpY0Rt/i3dMX5jStQ6VxRayrbnbdGwEe9z/UrTbTMxFn/A
	LJeGPdDGEuZfPgozvGb+QjBnJP1kqaIUtMU9VXaLxw41niDUZ/ErmZNFbA0mCbcKReZoq7R+lJ1
	JRR/zOm5wLxGPjsSBud3XWdBbvp50m3y5LSSXLCDv9/csobJPknpzL95OEkN9PXOOyrOGEO6+aY
	Xz5sG7wUoHU7+yqpMqc6S2GJ5fk=
X-Received: by 2002:a05:6214:3d9c:b0:6fb:3e3e:89da with SMTP id 6a1803df08f44-6fb4776e0e4mr194710696d6.25.1750148736376;
        Tue, 17 Jun 2025 01:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLRf4zLAmzAVq4IjIYsGrQ8BUWjxhlo96YjZ+1KTdj83hkddJi7LyOWjuyU1fI+YDVS19qGQ==
X-Received: by 2002:a05:6214:3d9c:b0:6fb:3e3e:89da with SMTP id 6a1803df08f44-6fb4776e0e4mr194710466d6.25.1750148736042;
        Tue, 17 Jun 2025 01:25:36 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb58e7687dsm12877366d6.115.2025.06.17.01.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:25:35 -0700 (PDT)
Date: Tue, 17 Jun 2025 10:25:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] vsock/test: Improve transport_uaf test
Message-ID: <fy5xo2kzx36ukxxutwzrqslvic7jdv5yaj3247hbzsza3ae4pd@hr5ijeldvcam>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
 <20250616145729.1a16afdc@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250616145729.1a16afdc@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9bhX0ZM1LNsjjAviYzwykTERh_kS_tzOwmXEVPpqwFo_1750148736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 16, 2025 at 02:57:29PM -0700, Jakub Kicinski wrote:
>On Wed, 11 Jun 2025 21:56:49 +0200 Michal Luczaj wrote:
>> Increase the coverage of a test implemented in commit 301a62dfb0d0
>> ("vsock/test: Add test for UAF due to socket unbinding"). Take this
>> opportunity to factor out some utility code, drop a redundant sync between
>> client and server, and introduce a /proc/kallsyms harvesting logic for
>> auto-detecting registered vsock transports.
>
>Hi Stefano! Sorry to ping, are these on your radar?
>I'm wondering if the delay is because of devconf.cz or you consider
>the Suggested-by tags a strong enough indication of support :)
>

Yeah, it's because devconf.cz. I'm going to review today, thanks for the 
reminder :-)

Stefano

