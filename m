Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549224B5C1
	for <virtualization@lists.linux.dev>; Mon,  2 Dec 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154904; cv=none; b=faeyuefi4K1ALraj58jCMz6KcIRsgXlnITfzE1iRuWYADuI0PqEctqmLmChZgCPoHE0RERSdHo0+7UVR2CJaE4NUHktVcYK5lDrn36v7Bq7c6w+X8D7Fh2I2DMFEVRMCGwnptj1DiQ3wcJNlOu2CW7cRCQ6JbJq4WC8XeV19Q9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154904; c=relaxed/simple;
	bh=adL+2LkQ/+XNO8hCMwqPkqXMk3kCQCPZ/eITVwvvJb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Z1/21IZ0DlFGnUnzJOcVxTMkJg/wEWDB3AXLqSHxmfYTCNjWEQCxEHfpeRz1wbc3Z0zKthc1M9bpAHJGEDnFULT4XBl1w7+mfgL5S45oW/p9jIWmYrFMQ2lqWG/42OM6JGNV5NKzSh+joEo6v5A1G5z6V6DYk+oLAYPezd+kP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDIPDATL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDIPDATL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733154901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMGz26Pd93vereCLJasLGT8lvdI6LqnhcQp8tpVjo7A=;
	b=eDIPDATLly/sn2wCjq7JcEXjFcUvLXMWc+Gdrbr1uzWOmmO4nI0B/ifsXiTwlUQYv3eLly
	+KbfcvJHLgBhWyco3JZQIIGvqOSSQPk0/VxRH1yfgMtZW6ttFAPRT5GDTvhTXLaA5imusm
	REHuzEdS7DLqpLhM/yrM3qLAqjxk7Y4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-eSulTpRaNKyQO7jlmFfxNg-1; Mon, 02 Dec 2024 10:55:00 -0500
X-MC-Unique: eSulTpRaNKyQO7jlmFfxNg-1
X-Mimecast-MFC-AGG-ID: eSulTpRaNKyQO7jlmFfxNg
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8897ea603so47886306d6.1
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 07:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154899; x=1733759699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMGz26Pd93vereCLJasLGT8lvdI6LqnhcQp8tpVjo7A=;
        b=oZvOeCKSiLHuztNCxykOcYyZVsV6n7aJJPO99YRalsM6n8BbDffLZ9KMsJjcx4Tzhf
         vO407mwfJRSYXPGjYkiR4tHs9bQJBAXkEsrtemdg0eTZC86rIQ5gf9CAqtRo1zK3Vkpe
         +7LKkrF3LAdM1+ydAZ/nW92k+E6+AqZT94MV7sNYy4Tmhnks1fHiKO4T/4VDfE/tm770
         3+UsHC9hFvXvdRzC3xT2u6ciz454JrrsqznfrQ2ox7wZcFxdoyI1mPH8xaAVIZWZFxFd
         QLtLD9R90rvckfclv0exTuYIAGvMjHzoSDHthWt4tQIxbDEZ0JMJy25KgWZY4WlKKLoc
         pIew==
X-Gm-Message-State: AOJu0YwbngLLO9E7mjIX7DwicwAXYgDpahd3PemFisURc8j3TXoyKgTi
	5FYb7mtv38kOMStwV8QQRaAehTbxG1jl2Of8f5ky/GtpaAc3vwPA0CUBTYICKGeiuaQ5zsgD1Ex
	tCIZOqfDv0yz0tZhdET/gpoBlZTi7Y8iywkVU/27bpLIvC3oYQi/GZ/h7tcRCsnv9
X-Gm-Gg: ASbGncsZ1TiMVykmTwhFds4TDyxpAW6gnCDEpBunTY/xK9OFh2WeMMWiT+p9c+IRdrm
	CuBdVESMZchgRxkU1nxlbIaS/DMUGnl80xD8FdT+pfHh5qjcCBxXpoHcDRregKusNDh9bF6ao1I
	C7MAPCdfL8x5lJFZfssPkoUPrDxpxPpuhKSSvOgMOp+CLP3PMHQLQEHwXDfz309p2SPrUphBOMH
	qLqqxr3w37NzvNRHshA8Ln6QHxCvU0hkY+sjCFUUbtVWfZlsZZIkOKXX0HAOkmUbS7fixssY8Yb
	32A1TZ6ebQHWcAUL4WNLfZ/Bvg==
X-Received: by 2002:a05:6214:dc7:b0:6d8:88c2:af5f with SMTP id 6a1803df08f44-6d888c2b26amr293838746d6.1.1733154899438;
        Mon, 02 Dec 2024 07:54:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoviEDi9BXOJucZNgaChi7PR0dT2tjGFWFCa8hO2q8Ph+R9/XOCu9E7Ze6AFBWJMiaAnRaBQ==
X-Received: by 2002:a05:6214:dc7:b0:6d8:88c2:af5f with SMTP id 6a1803df08f44-6d888c2b26amr293837866d6.1.1733154898907;
        Mon, 02 Dec 2024 07:54:58 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d88b9e6a69sm35208006d6.60.2024.12.02.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:54:58 -0800 (PST)
Date: Mon, 2 Dec 2024 16:54:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v6 0/3] vsock/test: fix wrong setsockopt() parameters
Message-ID: <cskeunqjcpywlrkldqw44jpwrrkear46symgk2kucpljsx243h@m7pb7cwvu3yz>
References: <20241113143557.1000843-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241113143557.1000843-1-kshk@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0Xmo9WbDRU06rPmnW0rCAptGxt0lX08v8ycB8lByps4_1733154899
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 13, 2024 at 08:35:54AM -0600, Konstantin Shkolnyy wrote:
>Parameters were created using wrong C types, which caused them to be of
>wrong size on some architectures, causing problems.
>
>The problem with SO_RCVLOWAT was found on s390 (big endian), while x86-64
>didn't show it. After the fix, all tests pass on s390.
>Then Stefano Garzarella pointed out that SO_VM_SOCKETS_* calls might have
>a similar problem, which turned out to be true, hence, the second patch.
>
>Changes for v6:
>- rework the patch #3 to avoid creating a new file for new functions,
>and exclude vsock_perf from calling the new functions.
>- add "Reviewed-by:" to the patch #2.
>Changes for v5:
>- in the patch #2 replace the introduced uint64_t with unsigned long long
>to match documentation
>- add a patch #3 that verifies every setsockopt() call.
>Changes for v4:
>- add "Reviewed-by:" to the first patch, and add a second patch fixing
>SO_VM_SOCKETS_* calls, which depends on the first one (hence, it's now
>a patch series.)
>Changes for v3:
>- fix the same problem in vsock_perf and update commit message
>Changes for v2:
>- add "Fixes:" lines to the commit message
>
>Konstantin Shkolnyy (3):
>  vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
>  vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
>  vsock/test: verify socket options after setting them

Sorry, this series is marked as "Not applicable" [1] since we forgot to 
target a netdev tree (net/net-next) that we usually use for vsock tests.

Please can you send a v7 (carrying my R-b) targeting the net tree?

You need to rebase on top of net tree and use the "net" tag (e.g.  
[PATCH net]), more details here:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
Let me know if you need more help with that.

Thanks,
Stefano

[1] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=909319&archive=both&state=*

