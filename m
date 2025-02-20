Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43424262D35
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080045; cv=none; b=h0QLKpqaeJ6FYdhoeOfmEpjWZ8KNgX7jqWfZVOJtz5hW8AOu11KaldEzmQQyOvwSaVm5RCN2AMtPVn2HDpRYhbOoBufj6oYh+zMJU10qdmXVpGIQLTciHIFvVSfQnVjbN41OrWyZ93gy89q4lV0zN6lyU8eIl52cMWbWdmdKE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080045; c=relaxed/simple;
	bh=lLvSCfGzR1G+5sP88MJmJoxG3MsULk9EywePmaCSpPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIPJPaFDprmoS4iWREqWE19JQDwSnjOiQ2TveyizJ9w84g4UWg4bf1xLk/yOJheFqWfE1nhEgcKh1XXu+qHjLdV5j3ZOaLsxINwhxVxy3ULJh9yVrLJjOKY0cm2MKdMeFxdgl96Keg6DJjsQD/1c/XktOifjxwA1Pbrkaj6iMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGAUHHJ1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGAUHHJ1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so2222357a91.2
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740080043; x=1740684843; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTiSUkoMecG9RlHxgT6mcfjx4A34996Guxh4H1K/phg=;
        b=fGAUHHJ1XjQnf9omJPzCxRYZmI6PX3nhpyO/QBxF048wehJiZYoMD/NJbPDzS8N2Ke
         NwTnQz0r6ytGXEuRhg7vTYYqhOEiOLTLEUlW5EH9ZpoKsoWQIYRzCw782n77BvxloBUy
         Jnag23FAhCVe34b4LnlGjEdexnPQrRbA52M9m8ShBZrrNhX5k+zMxlwiWuby7DgoLsv4
         LztS85gutglX2SmBkvllyIkTKNfljAt/Iht8eDF2nbKPqkUqPMytlH93aOhhUl7sLB9Y
         9D5zC8TZz/FzvY1jOPxzE4fJKuLwxBRKiNp322qiUzsuo0gPnitEAZUL6NYVWLnVWUvo
         0dSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080043; x=1740684843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTiSUkoMecG9RlHxgT6mcfjx4A34996Guxh4H1K/phg=;
        b=fRVUMdO2TQOoahz8Y221woFqoisHm0txVIyjNcTPHM9Q7/uBzXg1c5D8lsacgtr4Jm
         BqQ1laJVbbUiaocnQwxnjtQxYgt8zTAWmAzc17A18IzWsJjAJuJxfFFznuTaHrcOfqQz
         rnzkUxNJHZft+MMG7G+Q8klJSahuhOljkoJEiSdnyzyClut5EXnks37U6TUkhsFtVyeo
         dNDqYsDhsV0yJgVF7rRxyHxNtTDSLpMjAuqY0wsgDOivuNK+K44+6ypkcRe/F73d8XWr
         NrCy1cMU67O/mYf8frqkttjb66CWkXyXS+L2VAu7sgtru2nVdprfun5PJj96nwceX77P
         5gKA==
X-Forwarded-Encrypted: i=1; AJvYcCWmgydPx/WWwllMClLl7PMVpfdpRIVAemI7CPvwM9/bi7bHwSIbTwkzU+/lHp0A7QE8TPrRtrAJ3wswc+Id3A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6M2HrdmkQPBT14iWJBrbtWZwBE73X/GDKPIaA6R+iTNiyoW/q
	tryVUxjT4bT3PchdZgpnsgAO6d9EzMpLTGoQ/DBXvoO7Oehx36U=
X-Gm-Gg: ASbGnctEHT+fDG/5l76ZvqBNYsBmZ40g0TXx06px3pXE1bWhnb41n+LpXHQyJOV24oO
	IXiM/tZ7aDuoykamlzfflXLBVtAtf8J0qNQ9r9kK+fhLrbQJLQW/xlH69DCdKAk6Tg7DsV4RMTx
	LvqN33PRx96B5joXnFPJoisGo2YPWxV5ANLo4leW2qUbBQrUQlKfJHMFcKHemOsfrPSa54pmlME
	ulATHk1NuY3nXRV+TCdrbx7Qgvfb8aSGk5IrxzCGlasRPqj+nn6XyCHHe9oklpVtYc71E65DUIQ
	iVuBZqqrgFsa3Uc=
X-Google-Smtp-Source: AGHT+IHodAJTRfe1tv7kfQiCPKc2cGyPrUaPKRCuDC1rwACb5ZM8W6rjPG0qmP5bRg2hTlH0FYozsg==
X-Received: by 2002:a17:90b:35ce:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2fce78ad9ddmr594804a91.20.1740080043522;
        Thu, 20 Feb 2025 11:34:03 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53494c0sm124354095ad.6.2025.02.20.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:34:03 -0800 (PST)
Date: Thu, 20 Feb 2025 11:34:02 -0800
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
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 1/9] net: add get_netmem/put_netmem support
Message-ID: <Z7eDqnkwmpTW5963@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-2-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> Currently net_iovs support only pp ref counts, and do not support a
> page ref equivalent.
> 
> This is fine for the RX path as net_iovs are used exclusively with the
> pp and only pp refcounting is needed there. The TX path however does not
> use pp ref counts, thus, support for get_page/put_page equivalent is
> needed for netmem.
> 
> Support get_netmem/put_netmem. Check the type of the netmem before
> passing it to page or net_iov specific code to obtain a page ref
> equivalent.
> 
> For dmabuf net_iovs, we obtain a ref on the underlying binding. This
> ensures the entire binding doesn't disappear until all the net_iovs have
> been put_netmem'ed. We do not need to track the refcount of individual
> dmabuf net_iovs as we don't allocate/free them from a pool similar to
> what the buddy allocator does for pages.
> 
> This code is written to be extensible by other net_iov implementers.
> get_netmem/put_netmem will check the type of the netmem and route it to
> the correct helper:
> 
> pages -> [get|put]_page()
> dmabuf net_iovs -> net_devmem_[get|put]_net_iov()
> new net_iovs ->	new helpers
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I remember you wanted to have more fine grained refcnt, but starting
with this is good enough for me.
