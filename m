Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27924C07A
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758789; cv=none; b=NCmzfsfl9o5LFsTA/V30b9cza3CRzK2jJX1aeTy+sWOiuBhODzFwVEW3lm03rscZYAe2PS5GCEtrcp/O2G6X1CAdaPusMWkp5n/OyfBwCB9tjfOzXwlwH0ZjfdADz25VTRWr6ySi/oRT7064OQ6DMfmeiXLdpDA09VmRfa/Q3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758789; c=relaxed/simple;
	bh=9iywa8LxDBmIJmnFA0mWiRWkOXXa499m0kRd7LsL7ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CILZL6uRGkoJQtJgmsgEQzFq8uqcaPSht9m6viTBcuer1/7wKxtbG9qYZg5sjfcPv7KOZNNZouApUF1gHtoh0IqSOETMhelZq9L8fcaX4rM/7R7P5DA6Qil7KUKf7G8cdwFMuJLX0n+DuK0vC/rnsJyQ/fwae2OvCaCBONnbxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9oeBoHp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9oeBoHp"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7398d65476eso4604278b3a.1
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758787; x=1748363587; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4J9GjT2DkNx9RKMdFilKV2qV6BHNi7N4nhhnVWjxkM=;
        b=h9oeBoHpPj2+p5wbRu0jgbYcTW++T6CltDolqngfYwZbUTe619hDJW2S9/tX/zFBFA
         QchfhpiNjageUG19jkkszlhHADD1/Ail+eY3WRCt+ccWQ76GfFzw5oOY8y0Ieo/kGakR
         3AY8CLlTTuss0IOQol2pA1iz9ZOKmv6qbAPVlgrhb2QklZAhWhM/Ea7pczaGKIN/wpSZ
         D0UoCNCMsx7w14xj7CQ0VqPhDyOOX+3GgfV95jveYLoGDnm7/4zCRXQFexwW/ilssecH
         sZ+Z39LIIGgy8XeKE/AqLaoO+If/R4QrMjgu9FZJq76jfAqPyAtpVWXV2XBNPQEV6lPY
         hB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758787; x=1748363587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4J9GjT2DkNx9RKMdFilKV2qV6BHNi7N4nhhnVWjxkM=;
        b=eXIaINqTX3C1TeiF8cqhGWJCHwmLgslLkmGR6E87H9AhKNRkYjbrKLN3r769GLnLC2
         HZgQKa/93TDICNZRwB4bMsjsFi3UV4dJbChcapiNiA9uXJ7TUf3v8eLsdXBPmUZ92C5G
         XJHR3bBbD3sxjQUOjWWnSY8bxQfkbY0poc7n0bueeVhkjd4Xmyqd/reNDVNd+CmdztLD
         dwULPEqnp89k7g6FlP1cjrKt4bSSz7+dPfY8tZcd0YiEHN1bHyyoJ3eIB5AWIu0X7H/v
         QTdOVqidvsBsVmmC1omvf15HeCxKfAXYDfLWzRomgKKx6Gbl8SYZ22Jt/LdkxkrCJKxZ
         1EYA==
X-Forwarded-Encrypted: i=1; AJvYcCX0vb63gYIVdao2lGdEc9oUuLli4a3zEmQT9YDWQCwQzhPk7yRFiRvn/HSbWgNDIJne8zEAbO5AiQ2CzQMfFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRXhX/ko8JnTRg632uKz5sr8B8haeWsRMCd5b0+UzT4Aaq41ig
	4Ko3MzDpbCUEEYruC6OAG7WOeX9Nq8Mq2ZtXAtqNGExBaN/MoQzvaM8S
X-Gm-Gg: ASbGncvD4cd9OL1JE3E0JP8jkj6cXgYmRgZ+gjKq6bVoPPx5XHKSJqNJZTk3AhaLBK2
	9IKeyjCKT/Gt+W4R26muHuYpA571upFMAQp3AN3Xra3rlqpFdfRNLrjgAshBG+kkk6tnR8B7bon
	GocJ6P6ILnhWD3BA+6H413Egwwi8OWR2gtowV/xIKMKpGyvtG9tQGduRCdmsKOTzUwUbmgcMmlD
	iEzj8CIYLJW0zQzQjlQ92dOIslZLWNgheao/7cNQXW7na+C7ZE49L8VZQ7CF1nNsZSM7OjmMpcR
	8ZmkbjKzuSR1FITLgnMJJFp02WcCK0cTThOjoJHGVlpALXx3hoOqN41eZ6n5aGa0WNl/GTY=
X-Google-Smtp-Source: AGHT+IFFEtELJ7CNY/gj67X7KGAeNhJCZbOLnPiYWwQ92Z9dI1v88DKGl6Pdba0V9ObimC+EYXJnbQ==
X-Received: by 2002:a05:6a20:12c3:b0:1f3:3547:f21b with SMTP id adf61e73a8af0-2165f641cf3mr29465576637.5.1747758787474;
        Tue, 20 May 2025 09:33:07 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb081aa2sm8256782a12.48.2025.05.20.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:33:06 -0700 (PDT)
Date: Tue, 20 May 2025 09:33:05 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aCyuwa8x9ClTOM+Z@devbig793.prn5.facebook.com>
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <f7dpfvsdupcf4iucmmit2xzgwk53ial6mcl445uxocizw6iow5@rhmh6m2qd3zu>
 <73a4740e-755e-4ba8-8130-df09bd25197a@redhat.com>
 <w6aizeb2i5m52e2ifqcikgwdbrkkbc46sf4hx5b6jsm7o4drio@n3dzlatb426s>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6aizeb2i5m52e2ifqcikgwdbrkkbc46sf4hx5b6jsm7o4drio@n3dzlatb426s>

On Tue, May 20, 2025 at 01:09:25PM +0200, Stefano Garzarella wrote:
> On Tue, May 20, 2025 at 12:58:18PM +0200, Paolo Abeni wrote:
> > On 5/20/25 10:24 AM, Stefano Garzarella wrote:
> > 
> > Still it could be worthy to re-introduce (behind a command line option)
> > the ability to build the kernel as per Stefano request, to fit his
> > existing workflow (sorry for the partial back and forth).
> 
> If that's possible, I'd appreciate it (not a strong opinion). Otherwise if
> we don't, I'd say take the use of the direct script out of the commit
> messaging, because to me it's confusing if we don't plan to use it without
> the selftest infrastructure.
> 
> Thanks,
> Stefano
> 

No problem at all to add it back in. It's a nice feature to have for dev
workflows too.

Best,
Bobby
