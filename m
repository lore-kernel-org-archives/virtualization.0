Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423236;
	b=Kr0CFiqR3Q0A38oKr1Jd2/SxoocXEWvhAor6d2zhmflXTmMJSsI8ofwzGlvR7zXViesk
	 3zBBw8DXMAWBi507YlUjQkUygYWbPr7w8hivY6vFqmmB00t/2k1ZIYmNneT9C0VGlGSr6
	 roujWTu8pucBHkIgzeRM34VtZkm93b+wKzt8q3TS6GN7fXwhUcxNkSplriuZ6No/5SvaE
	 fvUjY4gKMxi6UW/IGVtO7S9rbhaLo2K55YKEkA30NAzwbRAqwp27Gn3vCGw0+cmdaN68V
	 881Ccp/rzXUqTADMvRQpdFaNx294XScTsbmwjlXX6M9nnefs8lsPNlSEHLHwkNIJhIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423236;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+5n1VoXqaGtyr2AYAd3HrKxaDIwkNj4GWqnIam41N0U=;
	b=r6c4HgTl0isrwHCZztRrEWPF8AshkwL2Sm5b0MLponYR9F6T4wArLUq2x7ElRolwDFOS
	 jtkaQlf72HYWhvLATPm1HdcGWdAnTFLh+i7WNvHwneqsrosTv8fXLFMyEprg7LIS7nedZ
	 VqI0sXxbpUDU8hjhfNQZOPrjXnoVJwCSA0n4Ctuw981MzBGx/t10J4BqETHmICprBp1Wh
	 UC26Va8q9MsYS3zek8d3sAwD/mbRsuSbH6Fs1cVyTe1JXLDHlry7Pjm8pU6MnRlIn+fZB
	 ykcDlN4j4GyZGIia10yNSNzgADDiZYnwoIJEP0ksHK8DEAQIhtBl3dUVxM2Ke58XjkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0vd4Ds2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7843606A889;
	Wed, 11 Nov 2026 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0vd4Ds2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9700B1F00A06;
	Wed, 11 Nov 2026 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423235;
	bh=+5n1VoXqaGtyr2AYAd3HrKxaDIwkNj4GWqnIam41N0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X0vd4Ds2ttFc1KZuSjD/KbzjkMEx7L2o6Kd1wX5ida9swtkXa0xSt666pNbbQeM8Z
	 xQIW1QRIiqrsFABQxrUFj1k2xiGwV7gqqYc57CANRAxCrBuQTst6+aWo5TTQhzwZNt
	 at3dNhbfeDgocuOCIMvoNJLEKUNeIGVmhT04Gr5E+uppy2SWXEDmThX1j+Cxq45MuR
	 SbdA8xtTxyjKpum9y4AhIPNvIJy+TvuMQqTS3D4HVw5dYfCXsqqIcR+wZUaZw2UUPq
	 ZIU9/IihDSQEQdcY+/Nl/VPc+sLsLpFVJO+tm/sFwzJcbovN8eRM4qVtbx7y7mFCGZ
	 wCA9RGzWsZbVQ==
Date: Wed, 11 Nov 2026 19:53:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Message-ID: <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org>
 <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
 <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
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
In-Reply-To: <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>

On Wed, Nov 11, 2026 at 08:43:53AM -0800, Linus Torvalds wrote:
> On Wed, 11 Nov 2026 at 05:42, Christian Brauner <brauner@kernel.org> wrote:
> >
> > So the fix below is what we've done before for pipes and I think it's
> > the right thing to do here too. I put the following on vfs.fixes:
> 
> Please no.
> 
> > -       src = kmap_local_page(buf->page);
> > -       memcpy(page_address(page) + offset, src + buf->offset, len);
> > -       kunmap_local(src);
> 
> This boils down to one memcpy.
> 
> HIGHMEM is dead. Nobody sane uses it. It *will* go away. It's already
> effectively never ever used.
> 
> There are some broken 32-bit arm setups that use it, and legacy museum
> 32-bit x86.
> 
> Don't make one memcpy() that can be inlined become this garbage:
> 
> > +       /* The buffer can span several pages of a compound page. */
> > +       kv.iov_base = page_address(page) + offset;
> > +       kv.iov_len = len;
> > +       iov_iter_kvec(&to, ITER_DEST, &kv, 1, len);
> > +       if (copy_page_to_iter(buf->page, buf->offset, len, &to) != len) {
> > +               __free_page(page);
> > +               return -EFAULT;
> > +       }
> 
> just because of broken shit that nobody has ever complained about or ever hit.

If that's the official new stance than I'm very happy.

I went by what we have historically done and very recent history still
has us fixing HIGHMEM shit.

So if this is an official thing that we can now say: "Fuck it, we don't
care about HIGHMEM and will ignore bugs because". Then why can't we just
completely kill it for say v7.5?
