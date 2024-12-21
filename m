Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921FE127E18
	for <virtualization@lists.linux.dev>; Sat, 21 Dec 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734756815; cv=none; b=tO6a5do4u0zpwCNOstwbqmQAF2aCnD9h3LLIa5Y3RPY4sMEXEaqeoit17KK+KdzWPVkbw/ADZMVP4HMVMG9LlwktpTlaiKGUCojpLJAfavIp2GOFdGNTsYelqtX6p5UJYqhtyfTUPApwBfcjZcL/PgHYsy+mee9mvxqnd9ersCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734756815; c=relaxed/simple;
	bh=a6ZvjQA4/kqmDuCOMFGSi2a2T8rwtspvFrFjZAv2Blc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyuDwiJWaqblz/kcHoscRoWQo3D0imIIShCpn7BwC8Uvz/lc0KZylzoE8UqYEG8NzwFRiyw7jLTkAK1DwpDQ2ACBiywOuaXpFI0lMtSu8xogp8cUb1aLqFjCK6SwdBBKywVhjiRgFTrMWoebzJtOUy+CvHEDsRBV16PScJ5amuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc9n2ONN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc9n2ONN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2162c0f6a39so33425675ad.0
        for <virtualization@lists.linux.dev>; Fri, 20 Dec 2024 20:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734756814; x=1735361614; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/akANvp7VhtOPKaDZibMQ+5IWRJH6Tag+KqsgXaV/k=;
        b=gc9n2ONNdgpjO55llN88mIL12M9f8Fp0oPjgfaw7UXs8lKjlvE4rNXv9N+seaVklSS
         8qoCWOOXJSyS/J9c4ngFTqHJgHZ7dvmDuxn21lLmlzFch0Ejx+bmCqKRYqQsxuEFa+Dx
         V4rau9i2g0LRRu24Hee+OuD29at0zxg2T3574dmD3Y3P87IXntN/4dXzZpHc0/ZPGY36
         JrapZOqjnjpg0BZggL5SKYfYHpQeQ3NdzCGZx2EsZjZ2KgYwb9SP9SsF4KepcJdd/B56
         aIIl8owJux5C4lkhFQ6BdvNmTTAC0JxB+AQGuh7nXgmC0Cq/uc7F7RDdYshjltjIEHaI
         xuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734756814; x=1735361614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/akANvp7VhtOPKaDZibMQ+5IWRJH6Tag+KqsgXaV/k=;
        b=O6Fk8dIcs1utK5ULDQs4rZObTiezQBiLSelgkl/R+j6XJMcg8XDheSab3ttSuSxnhm
         BLvDkcAgZCnBQNnLMOha/zFs2o1E0sAcZXlhdZybjrbth1/vEuXCRSkSj4adNMnz6HBW
         I3Yb/VgoX/pNfGfWpvskq0vwy/9ShC5zV3QTek31dSYT2Adm5eI8CqsFfL7aPu7IIAjl
         8iGgTlcWNY/LxOo1pa3cl1BmrmTLNnz/3ev3Sj0lCo/0BHOJ4FidPP7wdCCHbhuPS+qx
         Zyrn6Yjr88SGXYxTS0DKCAKi7d+yThksZz38dwwUfkXy2ldK86mwAUv2g5mhYXxwEBsU
         hV3g==
X-Forwarded-Encrypted: i=1; AJvYcCWtcMTri7h5yEBjwjMcbbHv0mZSwHJdKLcxie664AbzZxcvGasyzOJLusWou28A6q8iRdgIRnb1ewjE2YQNlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI3a1GUniyjd8deqr/WS2aTLJRyLgq5ekfzItEMl8cSgnXmhtK
	VRbNOj9l+HJpTCUbCPv6uTxcvw35lKu+HzIy/rW2FeB1UJnlH08=
X-Gm-Gg: ASbGncudUYtDUtaDC99C1GooOhtbQC3DKB+772kFmAVh10IXXEFhDqDiGVGxr+uJEzp
	aAkipeyjBS6daX3MM1GcvWde2laapzPIr1SQli2FPj4e6CkSnLl5vNmVkbV/AYTuiQCKFMdVBaj
	ULu+NoHQ/jmBZpVuRozrhhhaOaPobwcoHYPGH5tcqJnHydKpIxhuIgmix10ldAu1Pg5WSPke8QI
	a+T/n90lbg/rvGE429v2m24YghaGSoB6PTJjDdYsf/2XEhgts62kE3u
X-Google-Smtp-Source: AGHT+IGefqGwlNhgS844VD5QltPfx06Q1qkLbqdGPbeGj27JsIktfQiNrqJssTxBch8qAGNI9J6jqA==
X-Received: by 2002:a17:903:1c4:b0:215:58be:3349 with SMTP id d9443c01a7336-219e6cf87fbmr80420885ad.14.1734756813706;
        Fri, 20 Dec 2024 20:53:33 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02888sm37069405ad.261.2024.12.20.20.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 20:53:33 -0800 (PST)
Date: Fri, 20 Dec 2024 20:53:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Subject: Re: [PATCH RFC net-next v1 0/5] Device memory TCP TX
Message-ID: <Z2ZJzAqS7ZrnREuI@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221004236.2629280-1-almasrymina@google.com>

On 12/21, Mina Almasry wrote:
> The TX path had been dropped from the Device Memory TCP patch series
> post RFCv1 [1], to make that series slightly easier to review. This
> series rebases the implementation of the TX path on top of the
> net_iov/netmem framework agreed upon and merged. The motivation for
> the feature is thoroughly described in the docs & cover letter of the
> original proposal, so I don't repeat the lengthy descriptions here, but
> they are available in [1].
> 
> Sending this series as RFC as the winder closure is immenient. I plan on
> reposting as non-RFC once the tree re-opens, addressing any feedback
> I receive in the meantime.

Thank you for squeezing it in before the window closure. I will be off
on Monday-Wednesday, but I'll try to test it on Thursday-Friday.
