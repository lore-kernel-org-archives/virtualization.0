Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F85263C7F
	for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419659; cv=none; b=WE9ogaOuDaECSRkGozb3KKlf31C9681bGu+N39n73a+0gYAKfFsIXlq58qDznrlnjttHIWb3KvIY1jYcC1BuluZVGrISg3orO0X6WXgK1nO8fDoK7DWK4o6H7wHTizyQxIWOdypJfeNHlmKj2lsIu2gLeK+t5sotu68oStYgdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419659; c=relaxed/simple;
	bh=XnnclfgnjJGNnAA52fTfntiaxNx9k5+h16ZPEYb+gJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnkrsjpBMJuMMw1b0ObZ5gaqXG8e8QOHI7QjkpRB5J0QlwgIc2Y5+jHFKeO2IYQyspbK/BFo0vNbzhLa1hQjyswKRjzDxNGkx044bIZLAMdmk/0Al9GCSqCaUYyQ8S7T91cXtIgkhkJz2CV5LFk8mMdqeIcu4OQqImo+EyZbBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhSLF1g7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhSLF1g7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ca204d04so76249715ad.0
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740419657; x=1741024457; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49hFWAS6BPi17cq0UX9zIx62B0WnB3kN7+csrm3gvss=;
        b=YhSLF1g7Q3LlGrCQPhKVlhNqtc2s7apWBcIk7yGkNM8ZDICCrq/eKFKYDR0/xDCfm0
         6i/bwMtijPUdKeWsgi3f3wJvdTSa49X18YGF/pGeHjzSY+FQXWhS4szB96zoPnr/r7pj
         geH3kgUyb3jz+1Csrbymwlmj9Pr0ED37DtfOvO29GxqZQYSC4OYPH8Ae9k8jSoHby+dg
         qhQJ35DGg+P79NkyNh7PxzoHNJtLyNVwICWdmVpUn3Gfx6M+oDMim/uOwPit92zqLEO0
         U4TFCD83FWAQS1QXSrf4Y5JR0JImNSZqE3mGmwpi7wCc2SPszhdZpxEswT/U0S+tESjw
         tKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419657; x=1741024457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49hFWAS6BPi17cq0UX9zIx62B0WnB3kN7+csrm3gvss=;
        b=e+gk7XZPqTJI/VsbGcthmQoL0Yli0UoW9VtEeGnmwtC7UNnYdwqf3vXEhuMozGgpCN
         BhLgJR7wcLJ/Fd57NiXEiPJ9Ym4i49ExLqum6YycnLe69MO6anWR1xLqJ7UM/c3MW5yl
         OfH5GreldJVE7nwGI9m9YrC3sUPoxGPpkUSZBQuSenY+ZG0XdiyzIKfSTGzTQbj58bwO
         CdOxBAMJi0Fb6CHBmgbgbC4OR4TpC0E1mOYjMkmNGRegcQ5sn48PbwmMQad53NhP9uU5
         ZN4+EXefCNjstdMr/0HRwnXI2XBJ5YCzmR4sgMeycNU49lHZsUwoD1QrOfQXb/SbwCLl
         KiZg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZU77eY8zMoMIAtF2Js8blPpMRUMzt42ypH+zEk5zu4W+b4bY0zYboWbW/JFgGUi80wUGPkZW4K/zk6wZrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzD4R0fOpiU0+sbH2ZDxJ+4a/oRNv/d4ubsk/vEJe7O8zwBYzKA
	AN+KaKlAlPBtvtZnUAys94wZKqWmciJIOq1OvaVZQzrBhg1ntZQ=
X-Gm-Gg: ASbGncun7Kc1tZoul2O8/YGrjHBQiolSImWAvNNPlxSd6Pipc3Ej+YvLyIGvXdu3PY1
	DZC/FTMarmYLOvWlsNSXEkGwa3LAvqJ/1z1viClvog0QHlpGDmw78frI89mJuWEsI0QVDgg1Zif
	0ScSAJV5WhbCa47+OJ7xm5nYFRuAuTM1FpeZx0MJjy/HQ/QifSCNKP6rjnM52l/wwqJvoOwNN4i
	seL0gauBhFJZ+r/9K/yk8iA+B++JCtgyFcuvsNwDoHnAy7czYiFTxDBTEr1dezGiTGEbVJXkXPI
	oC2QppkTOzT9maOo0EHzt8rIEg==
X-Google-Smtp-Source: AGHT+IEo+qn0GrfRoEoT6iMqO7/d+JhNhLZkzb0haVeC/Qk31b9/5jQycW3R+yfCTVCSg4EuX/UngA==
X-Received: by 2002:a17:903:2343:b0:220:fb23:48df with SMTP id d9443c01a7336-2219ffa759bmr230045575ad.36.1740419656914;
        Mon, 24 Feb 2025 09:54:16 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732581df0bbsm18607889b3a.156.2025.02.24.09.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:54:16 -0800 (PST)
Date: Mon, 24 Feb 2025 09:54:15 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v5 9/9] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z7yyR9oRhHXv9a9z@mini-arch>
References: <20250222191517.743530-1-almasrymina@google.com>
 <20250222191517.743530-10-almasrymina@google.com>
 <Z7ypMjORvm99q6L0@mini-arch>
 <CAHS8izM9xMqWnJB5Cm=DMMBV1BuUemFjKSv9So8V_xQ8ToTRqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM9xMqWnJB5Cm=DMMBV1BuUemFjKSv9So8V_xQ8ToTRqA@mail.gmail.com>

On 02/24, Mina Almasry wrote:
> On Mon, Feb 24, 2025 at 9:15 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 02/22, Mina Almasry wrote:
> > > Add support for devmem TX in ncdevmem.
> > >
> > > This is a combination of the ncdevmem from the devmem TCP series RFCv1
> > > which included the TX path, and work by Stan to include the netlink API
> > > and refactored on top of his generic memory_provider support.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > We need exit_wait=True for check_rx as well, but I'll send this change
> > separately.
> 
> Yes, I discovered the same thing, and I have that change locally along
> with some other fix ups I'm readying up for review in a separate
> series.

Perfect, then I'll wait for you to address it separately!
