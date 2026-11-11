Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395182;
	b=yoqJPtQFFFmA5LQ4MuFd/u+EjNffqZe7W25gcJSsaWIAoNqJWFWxkfcjNj5/HcQPH4rc
	 1+Y+1ptuBv2BlzIpLZ7O+Anu+wKdCjG1nXJDxzn3l3ngrx88hxN04EGaz0yNoW6Swc+5z
	 tbq42i/qg84IJARQzmqYdYrnyt71RtZd8FBYR1JmHwzVxgCxlatHkWiO5OZAw3D8nGTr5
	 C+D3XD6YEfuO9Wg4E6pMOGXTjjAN6wKDYWKvas+17JQ8JR0z55nUDy1ex4UAuJNPRJixM
	 2gBcl2LKlF33X+gX4ATIqIuojsrI62UCodda76x0zFN43CnDHaqFqFdkxhLj2QGlNXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395182;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NzHMhcU+vPiMdliqp2dflnrsyBQs8fZSDxc9nDiFNAU=;
	b=qGZj+K2dRX/FnVE503kkN+UBOtDWv2ihgZRRTw/n1RfJyLCBvhCFSjihFzr/B75TAFHE
	 P3zwsFkqRdKir8GBjVrnobXujcAmAEE4TSiwei6ZnFWZAQuF6jK4Qsbaxt4PDdKjTqw2E
	 6B3SGUBkzt1QRwv3y4yjdm9qzxFFANUxnAZLemEUchEDIvKqAHDtwe6PzXF4cgVIY7yFg
	 57vXywNh+gcXMbSxEu1ur9q2ihfqdFmG3qzkemZDfpnGHIUf42j5UX4y1lJ7u66MFAiy/
	 E+ALN0A7cfz0frW2w5T8ugIfd4db9PA7obY91ktk5/SYqooDYgXjuEdH6mjpn60Qj3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0A+0ObF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD5606A334;
	Wed, 11 Nov 2026 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0A+0ObF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55B01F00A05;
	Wed, 11 Nov 2026 11:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794395181;
	bh=NzHMhcU+vPiMdliqp2dflnrsyBQs8fZSDxc9nDiFNAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f0A+0ObFzxtqt5RTDymvHQ0Jgz3VPVvid9hhX0m4CKnMG1ey1riT3j4cfns0YlQbW
	 /fpWhX2EwvzhDHWSm0r8z9Am+FM6DXMrYUVK7TN04Z7WTtW4YJNKEeOdzBx8PJ6WGA
	 t3+GwtMKtR0FyHZ2I+ZJJJvWsY34hiefVKerffEkrM1pG7kprb3YZLwraFwi+LM60r
	 TQhv1XENZwY7v5QhP7Hpd9bFJcLmtceg6ygYkou6jI5FYm9Y4ahtIkorF7zvfaSB5G
	 0Cng8EjDiFtX2I7MTbNehaDLud9ByNW+awhQmJ7WpzZKy0PKctQbHbx9bdSYbS00E4
	 P/2wSixuXZzBA==
Date: Wed, 11 Nov 2026 12:06:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/4] splice: remove pipe buffer stealing
Message-ID: <20261111-betrachen-schindel-gefroren-4c01e5f9ca1d@brauner>
References: <20261110145241.536019-1-kas@kernel.org>
 <CAHk-=wgPq1g-kt_n4-crr0qs3rBNkat5OgLxLLeMjKirevRuSA@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPq1g-kt_n4-crr0qs3rBNkat5OgLxLLeMjKirevRuSA@mail.gmail.com>

On Tue, Nov 10, 2026 at 07:59:47AM -0800, Linus Torvalds wrote:
> On Tue, 10 Nov 2026 at 06:52, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
> >
> >  11 files changed, 26 insertions(+), 360 deletions(-)
> 
> Ack. Lovely. I'm considering just taking this as-is now, rather than
> delaying it. Comments?

I'll pull it into vfs.fixes and send you a pull request today.
I have more stuff anyway.
