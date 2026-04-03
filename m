Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFE3254B2
	for <virtualization@lists.linux.dev>; Fri,  3 Apr 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218221; cv=none; b=hJ/B6wzQB8GctRd7GXBAaKoQ/dLHJf3vVxcI+sJsXb/UkrlmFA4P7GAvX3P41Xvl2KF5/sge/7NYyyRzzAY3msQ9qTOMZUjX1ujwMRqe2mE9WDkv2mmUvjleT8NZpZP60ZYzDOtuNbatYIL/b1nB0YbzuNhbOipoBdY9U3bjh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218221; c=relaxed/simple;
	bh=gKuPZPZjAF2bu9KQLK5KUDtBDxAA9ZaVqW9WeXW5oAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TGaFXK7AnQOhFsjR2AJTf76irnaJOmbd6O0LVgQ3n8lQ8jVXZOzNif5WRhByToDj0ToZx0orrwwkdPRHTMsKWYqcJjl7LztaYupAeRq95GDlm9H9yHtTakARtlNvt79cPR5znVgft09PgMRVRcOAVTL6BBJKxbGxvUuI5p5jSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aAHcwrc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAHcwrc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775218218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XT4Axufy1UQO5/IB2/wh8iVy7omBnkBDck5yhzPJ1BM=;
	b=aAHcwrc735IwvBAApWmu/Z34yP3sChN4MEQ+fSBlQwleL+psIQ+9o/0DJf4hyGbG0idhaC
	it5Jde+IkFdAeZw2lUPlO3OPMypsMMV/Rpe9Wz62HRevy7ZcbuvVtCh87RNI2yzBIYU+lw
	VGwReW2gbbFAuOl9tNg44ah/ccssESg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-MBimRL1iOBeaqGDKg9hHpQ-1; Fri, 03 Apr 2026 08:10:17 -0400
X-MC-Unique: MBimRL1iOBeaqGDKg9hHpQ-1
X-Mimecast-MFC-AGG-ID: MBimRL1iOBeaqGDKg9hHpQ_1775218216
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so21679615e9.3
        for <virtualization@lists.linux.dev>; Fri, 03 Apr 2026 05:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218216; x=1775823016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT4Axufy1UQO5/IB2/wh8iVy7omBnkBDck5yhzPJ1BM=;
        b=d7SXw5VjoJEoH1XrocXUZdbvYjdWGLs63fyBR3v5kCBgXOk7h/U4wcZgft8943uyx6
         bsJjdSo5DtWzl+bPrBMpZdJqOBvgIiPPK6vyzpXpqv6Bm73cRLowZkD80BYJ++GobDEq
         j2Xtn03Qt0JTi7H0TlDgSVJisbqIx4Mu0Cc1chObGHEg9mSD/YPffp+IvZ7RpGSPhMDM
         hSmuDlbcza76bkY7G+wCCEp0J55dTAIBel8ZJryidAchEn4boDuEMLD/Ch3665cCP2yF
         SwRaEzV0ri8MB8vDmPQdyfnVJxD72+HjmXtsQvK9aCOHz5dbux0K84IV+vNOobxWkgUt
         2WmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9vPQzb4vPIebrc5aU+xcyG9E7TVhyasICmGB28F786pOhTVeDOO1gBpFJ80OWBXg0y8uryk7wzO6a8A+zmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YypsjQmSHLyBeouD2IEjxLGl3bhS+CgG2sgs7IIIYfE+JKJ6/yc
	apzf/FaatF0jkdlR4HornW1kh/as1wbjXrPjMDJ8tOnmBSu8Rlaj4UAoRf5Rk/ZJZSaJoqJ6L61
	ccohc2gl9wnB3+uE6RjXDVdvXTi76a/tsf8fAce1oU0m+sTQEYoA2+dCSKGhuGkSRfMhk
X-Gm-Gg: ATEYQzxpJz3gmJ3bGcz2N253R/Zrkc9jxXtcrhWR/Rd6IxVpkXYT/TDW5uOl4wNXdHj
	BnNh1wO3Oneocm0sV2MKHzWQcvkhML3Xxmw72DkhYCkFfpDvnsxJ1eKypmIhg3SqBp3laNTL9AP
	/6I29uRiBuwvXEuzNWhK5j8+us9dTd/nuazdY6nTm6FlGezRvHviUMzDeG6Mc8zKS077fta5lV5
	q9g1z81lCLUcwA/wfKmxtHta/wGltZU3MljjirBPyA0EfCXf29CJX3dwUznR7CDgjgEaMt4+uFl
	HxKd2xy1LkKDYDW6125NjzQkA7ggp4DicLHYUIaMqbbX/sk7jFuuuLdfpOFMmmkl+c23kbp+0Hr
	Nx5HbbwjTsl5Wa/0RUItyZcirMHo=
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr39169255e9.13.1775218216473;
        Fri, 03 Apr 2026 05:10:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr39168825e9.13.1775218216048;
        Fri, 03 Apr 2026 05:10:16 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm22557565e9.12.2026.04.03.05.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:10:15 -0700 (PDT)
Date: Fri, 3 Apr 2026 14:10:13 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/test: fix send_buf()/recv_buf() EINTR handling
Message-ID: <ac-uFMz-tFFQIOAE@leonardi-redhat>
References: <20260403093251.30662-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260403093251.30662-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: No0a7kP4ENlwp4vVTT5YVqqPD8cJNi-AultBpEvwU3o_1775218216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Apr 03, 2026 at 11:32:51AM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>When send() or recv() returns -1 with errno == EINTR, the code skips
>the break but still adds the return value to nwritten/nread, making it
>decrease by 1. This leads to wrong buffer offsets and wrong bytes count.
>
>Fix it by explicitly continuing the loop on EINTR, so the return value
>is only added when it is positive.
>
>Fixes: a8ed71a27ef5 ("vsock/test: add recv_buf() utility function")
>Fixes: 12329bd51fdc ("vsock/test: add send_buf() utility function")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> tools/testing/vsock/util.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 9430ef5b8bc3..1fe1338c79cd 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -344,7 +344,9 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
> 		ret = send(fd, buf + nwritten, len - nwritten, flags);
> 		timeout_check("send");
>
>-		if (ret == 0 || (ret < 0 && errno != EINTR))
>+		if (ret < 0 && errno == EINTR)
>+			continue;
>+		if (ret <= 0)
> 			break;
>
> 		nwritten += ret;
>@@ -396,7 +398,9 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
> 		ret = recv(fd, buf + nread, len - nread, flags);
> 		timeout_check("recv");
>
>-		if (ret == 0 || (ret < 0 && errno != EINTR))
>+		if (ret < 0 && errno == EINTR)
>+			continue;
>+		if (ret <= 0)
> 			break;
>
> 		nread += ret;
>-- 
>2.53.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

