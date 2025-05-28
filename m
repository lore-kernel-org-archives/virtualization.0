Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99644C94
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392148; cv=none; b=X8QM0tUwkhvt7/xICzyRBcS4J/VFaNBrAsfQJpjaQv4snqwpXNNeOBbT4iShX+cqCNGO+0WxVI2QCZi+B7ZFLQ1NY2gqnTBJ4OKpLfDUdDXYq1yfPgGhbVgHqfvh5KLlPw9lwWCx/9raJQ/XLLrMhVyzBUykcTjns0+XWWkGJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392148; c=relaxed/simple;
	bh=nMSI5ZivnZZiPS/FxHmijcxahzyz2FLO5lWtTyhEHmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogaq70If2Yi2maalB8LGGy/TQ/zG2Po7n+qJdQD1Wd22q9CWOBwECxPHOD5LA6fBoHlGM41f2+vTE1OBsPu6f9FlgZjPiRS4Kxaluf8OWWLImuPcaqSroi8w+dRy0iwvzddccGPc+1ouABRLgkvns2a6kJE1IqjnLu58HPHZMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKmjjuN4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKmjjuN4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23278ce78efso27773265ad.2
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 17:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748392146; x=1748996946; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdHZEyPpnejSK4kS7CITMiqXsuO0ubtElhjRk0W2zlc=;
        b=IKmjjuN4b5grjdDZ47ndfIsmLHvx/2IjaFr5pYzq1AFKCOd3ZLQ2yHQD+awYuodPyr
         UTgFT1MtfHcJ+84c3SwCtbaJXUD7zRaWiRPGGky8rZr95RYsDCuFvvozGTd97k2FMnj8
         MTZaO/hgGV5dcscIvH321iwwDMEd4hP9gyrDTP9udWumQQM4C3DVnKz0BXuk9E+iL00Y
         zfp7PbTJI9iLqJlDae8JfOn6WjB2dVOAjt+qE32pq6Mjlbwi3hFs2Tswjq5cXes8wQmx
         kgweLFJPheSCQTmE2EesG6GUUdSoRWv1ifpoF8Uc5IggqwvFvRURlffMrJ78bsMzXZjK
         Hhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748392146; x=1748996946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdHZEyPpnejSK4kS7CITMiqXsuO0ubtElhjRk0W2zlc=;
        b=Wh2+Arl7dwIfHVSHzHCOSVTruOKTytwF+YG2UT3qqp/ptxkZ2LU5DQIUMcYtlryCMa
         xlrO+5gdbRG17U+AtRIXtFLgXWQSdR9SSWqsTOFDWY1VS/KSHL2zkeaevJeMqk0uiR9w
         FoAclHGaqbSgan2Dad1YYoDlXSzMZ4a1iTUKZ8RjW/rdHXNfxKadwhX2FOIJrev4RAb4
         PD+nObgkL1uKAMCQWzMmmBtmUcROySG5Ido285Rr296d4z3iOFTXQEnpxJYxnMivbnOa
         qQh7oMW+z7C1ZLkofvtH22arp04zWwG8E+fMyNEcN+XuSZf0Rx0xdr1UXpmnd3nBt/yZ
         WChg==
X-Forwarded-Encrypted: i=1; AJvYcCUUP5qzYR1BtcSeHLRp4bWI40QE7P5uea2mGvLZDuNOWz+V+VKP1f9WKnOfOkm3B+arT7xG2On6jLMubsw2WQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YymMeTPoa9lBnmGTr7RKJ8jJnJkRkAsFBy0igNTIfl+KP7wi2Wm
	QLmRvDkk6pB6f2NXR6OlQZxAnzTu3QfAsWR3pSWFDn2xbjtcsBt35YD3
X-Gm-Gg: ASbGncv068G0RaL+0AEEL9L0a2VpeY62ytNtVr7c0VGWd7eGX0RoEsjxmXS3aOjU3j+
	3iQOnfmaWQ81OqfHfQifQjMbLN42Kz96Va4M7ras7aDAc6fwgYSqXOR74sopVlR91YYresCdQ9M
	LdkCnD9/L00e2pt6fAq3JpSiOnGGaSsz5LjXuSq/LRVjIni1wI/j6SZyaVIBxMUOKK37yKfmOOj
	mRPPjzOwjllYwgPS+7AloocyJCRaTAL1P+hjFL7exIyTi8FhNzgAox81xnsbjHjbF9ddbTkGvgC
	P6Sxz7dAyWmh6I7bqJd56Fqpjhx7HxrDWGBekj2EOWArhGfhbIaMI4u5E/RwzcuWl4K1qGk=
X-Google-Smtp-Source: AGHT+IEXiNShvrkwb0WLAlppJy482Bihy90a51Ds7tKinQx6TREEDLNScb5DULzgA/mguTbEfCZWog==
X-Received: by 2002:a17:903:1a06:b0:234:c22:c65b with SMTP id d9443c01a7336-23414f5b33amr235147555ad.14.1748392146386;
        Tue, 27 May 2025 17:29:06 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35bce89sm63895ad.217.2025.05.27.17.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:29:05 -0700 (PDT)
Date: Tue, 27 May 2025 17:29:03 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aDZYzxEOKKY5kKcD@devbig793.prn5.facebook.com>
References: <20250522-vsock-vmtest-v8-1-367619bef134@gmail.com>
 <ta2ub5v7txhobccgvpnwsz7cyzcnx6aw74cjlcviosjetuwfhh@7gdahptdpbnd>
 <aDXMhbqhhUAMe0Oz@devbig793.prn5.facebook.com>
 <tabqpll3r76jhx2ujayry25a7ujfsikm7tejv5sviayyojlmwz@amcchbc5xiqp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tabqpll3r76jhx2ujayry25a7ujfsikm7tejv5sviayyojlmwz@amcchbc5xiqp>

On Tue, May 27, 2025 at 05:55:13PM +0200, Stefano Garzarella wrote:
> On Tue, May 27, 2025 at 07:30:29AM -0700, Bobby Eshleman wrote:
> > On Mon, May 26, 2025 at 01:18:18PM +0200, Stefano Garzarella wrote:
> > > On Thu, May 22, 2025 at 09:59:07PM -0700, Bobby Eshleman wrote:
> 
> Yes, that would be great, but anyway for now I would say let's go with this
> since we're supposed to support these current versions I guess, and this
> hack at the end I think is doable.
> 

sgtm!

> BTW, thanks again for this useful work!
> Stefano
> 

No problem, happy to help!

Best,
Bobby
