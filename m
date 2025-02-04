Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FE21ADAC
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698224; cv=none; b=EWNmSZHiExvZKKZ76VEBhaBIfAb9F7x+RwDhOt+TCX7CJtwIFklccP3swxDkk6Z4FQ1UKhvXq/C/55YA/aoVu7D5Q+sg9e5X3cNPFjt0PbndFRYs5HRW9Hwaj5ZIXpx5wPbwf/oheZbjNyl09b1xQipdJulbyPRjoRTOR3bmlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698224; c=relaxed/simple;
	bh=BkVFf9SgaGewvsLziisUAPBhil8VvhgoivOQ/8WRK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apti+7Pmbar/dfMcnpBx5ctzUZrRaFh3fbyVHuPmuWhy4718hgQQ1U1skqp/E9bynYBquEGG3VJCjgkl6pxWVuotFKPvDWYf3faVUKK3sgaT6JKynUvSRZaRCvCMlMsFgpGNzqelV1fg4grQRIcSF6fxEbNe17s+Tdwwzl9svRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmhdfIRC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmhdfIRC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9da2a7004so507994a91.0
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698222; x=1739303022; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SSuTIqVwgVdgeJ08MxBmbfomDViFrnj62vGl2fObfPU=;
        b=VmhdfIRCid2waYTMTlhzXcSJjbV4NcPbKYk8hd8R7Or5+7zIW4ie4QuiG183A0wV/5
         0Px8MNyrGDftPCGQgXE3iI0hpvos8FLVyRGc5zoSf6JfBQBC7hwQ6iw+tU0TsXUircH1
         3py6oYCSh1eIzhvW0qEzzZoAZ0nGPF7z1L9to//yEA1OiFO6DHmQ59styd7NFqHn6XXu
         HEBeNUgoXmGpuWVMwQoOBB68tkHEoi7bQW68yzQmv5SCNhcNwCCdri/cdcYfpsZDmsyA
         lIn3aekGGS189BJf4gazACbyK8iqKBVFWdxbeCdg81+bTRl4EG0d6q3Kylu2gEYgyEwz
         P9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698222; x=1739303022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSuTIqVwgVdgeJ08MxBmbfomDViFrnj62vGl2fObfPU=;
        b=vQDbqJEjx64toed8h/gmzRT2b55Z5+6J2Bgi9y0ORHdTfTgqn3NFC1EKixDp+f9MBb
         zUMggqZF8FxwjwBxfx1xtbV59KVZ5CJOxBhon0Gy72h3umPwJvHKjlEl5CRNmO9lsDis
         9eQkWbKCt4fT3vZL36b2VEXO++rJmiKPsu28oKAR1jP/pUAeQ8jKk7EJyRFYpbH5YIpb
         smuR07KqekKEjRxMvuBhbADxeyg3MqAKsS4bXMG/Gi3R0lFXcVT7aoluxTREHo2EvPQI
         rtQZzcqlGiAgKhzRTK8QVS+fgGHRaLIs6Y2uD8ps/dRIxyQcrjuMNX3Ex9VdBVQH0tQv
         KUZA==
X-Forwarded-Encrypted: i=1; AJvYcCWYb6cstYKK64VcPuCx1k2uRGuysbQkBrBxlCkSrzVN7hYgRL0sTtN3stTukdNtVu1BhCubbibadgNA3lgYMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YznPiDfzeShI3aaIOht1i5NSgr9VzitzFXX7enYGeMaRLKKv61Q
	PLk5O/vRVSoaHQtd/EywcYFpI/LGe+vR+3lZKMJD1oa8wl3jKMc=
X-Gm-Gg: ASbGncsDRZ5mfgCXwz5M5XeKys7ZAmGIr33b2wktLcdOuwtELk7nX6fgN9jPVXrD2Iu
	ysnLcmZaeKXuDF/9j++Z0nMq/hXUDYyfVtjyEEo5CBmPQpyT7ymwbYpVwC/KQXwwrtpMaiYJnDK
	AVZsur/izLPGx+qCWKGPQ+zE8U5nDv11gq9H8YE0qRMxahJkjAzEJ1SSze3xu0ADnwmXkmKCFbp
	9yEpsYDy/9TQEGltHoxmWArOlxo5r6Ez9ulZSpGgHqus8MiDUNE6Ys7PYiQRrc/RLldL9Kl3Gfa
	DZIo0IF5fiUVA4U=
X-Google-Smtp-Source: AGHT+IFw5vELY1t8zeAylvcZU4/cTC1NlCspjFYLf5FztuWCZwYFDQmuC9HhKFdTaKSeggS51DEKMA==
X-Received: by 2002:a05:6a00:4644:b0:728:e27c:a9bc with SMTP id d2e1a72fcca58-7303511b7f3mr255320b3a.7.1738698221666;
        Tue, 04 Feb 2025 11:43:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe69cf147sm11179288b3a.143.2025.02.04.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:43:41 -0800 (PST)
Date: Tue, 4 Feb 2025 11:43:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
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
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <Z6Jt62bZEeHnN1JP@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
 <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch>
 <CAHS8izNXo1cQmA5GijE-UW2X1OU6irMV9FRevL5tZW3B5NQ8rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNXo1cQmA5GijE-UW2X1OU6irMV9FRevL5tZW3B5NQ8rA@mail.gmail.com>

On 02/04, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 10:06 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 02/04, Mina Almasry wrote:
> > > On Tue, Feb 4, 2025 at 4:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > >
> > > > On 2/3/25 11:39 PM, Mina Almasry wrote:
> > > > > The TX path had been dropped from the Device Memory TCP patch series
> > > > > post RFCv1 [1], to make that series slightly easier to review. This
> > > > > series rebases the implementation of the TX path on top of the
> > > > > net_iov/netmem framework agreed upon and merged. The motivation for
> > > > > the feature is thoroughly described in the docs & cover letter of the
> > > > > original proposal, so I don't repeat the lengthy descriptions here, but
> > > > > they are available in [1].
> > > > >
> > > > > Sending this series as RFC as the winder closure is immenient. I plan on
> > > > > reposting as non-RFC once the tree re-opens, addressing any feedback
> > > > > I receive in the meantime.
> > > >
> > > > I guess you should drop this paragraph.
> > > >
> > > > > Full outline on usage of the TX path is detailed in the documentation
> > > > > added in the first patch.
> > > > >
> > > > > Test example is available via the kselftest included in the series as well.
> > > > >
> > > > > The series is relatively small, as the TX path for this feature largely
> > > > > piggybacks on the existing MSG_ZEROCOPY implementation.
> > > >
> > > > It looks like no additional device level support is required. That is
> > > > IMHO so good up to suspicious level :)
> > > >
> > >
> > > It is correct no additional device level support is required. I don't
> > > have any local changes to my driver to make this work. I think Stan
> > > on-list was able to run the TX path (he commented on fixes to the test
> > > but didn't say it doesn't work :D) and one other person was able to
> > > run it offlist.
> >
> > For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aRWl-F31@mini-arch/
> > I have similar internal patch for mlx5 (will share after RX part gets
> > in). I agree that it seems like gve_unmap_packet needs some work to be more
> > careful to not unmap NIOVs (if you were testing against gve).
> 
> Hmm. I think you're right. We ran into a similar issue with the RX
> path. The RX path worked 'fine' on initial merge, but it was passing
> dmabuf dma-addrs to the dma-mapping API which Jason later called out
> to be unsafe. The dma-mapping API calls with dmabuf dma-addrs will
> boil down into no-ops for a lot of setups I think which is why I'm not
> running into any issues in testing, but upon closer look, I think yes,
> we need to make sure the driver doesn't end up passing these niov
> dma-addrs to functions like dma_unmap_*() and dma_sync_*().
> 
> Stan, do you run into issues (crashes/warnings/bugs) in your setup
> when the driver tries to unmap niovs? Or did you implement these
> changes purely for safety?

I don't run into any issues with those unmaps in place, but I'm running x86
with iommu bypass (and as you mention in the other thread, those
calls are no-ops in this case).
