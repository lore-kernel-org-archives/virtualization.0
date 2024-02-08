Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CF6BFC1
	for <virtualization@lists.linux-foundation.org>; Thu,  8 Feb 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382983; cv=none; b=bn3Xp2t9S7XrUg5O6yrOoyKjCzbNYlJ5jUJ9vJpf8F8a2jLCClQiMzaYi4YfQx960cB0L8qHfMC39gPSbwE2qqo4R+xlnX7dfUo3KNmYiUZESE4FmgK0mDtsgiGn72vOd7IwGXfUpS3FF4/4WqP8MupV1Ty90Hq4Q3q1PaqjoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382983; c=relaxed/simple;
	bh=zLpZpsLNQEvYaAF+kQ5AZa9kkVgTiY2crC+gZ8/1q9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9Q4uOtlF8TZ7seFJcgZ59BHWULWHf60W8i93OQrBRduD/iqAkOYux1YAF6Er5ZbXm+nGZxzrDWOoZolbwKRX0VO2Vp01zwX9cW8xc4HBaR7lnkXv+VHD3GVTocY5yMz1RAe1kNxIQyXzflxCMmGffydnpBTDjyJIUpQ7Xwi5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNzZe7oH; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNzZe7oH"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3BC442F83
	for <virtualization@lists.linux-foundation.org>; Thu,  8 Feb 2024 09:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rGcgBUEjoZbp
	for <virtualization@lists.linux-foundation.org>;
	Thu,  8 Feb 2024 09:03:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C856942F7D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C856942F7D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cNzZe7oH
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C856942F7D
	for <virtualization@lists.linux-foundation.org>; Thu,  8 Feb 2024 09:03:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 73DF261BCD;
	Thu,  8 Feb 2024 09:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CE2C433F1;
	Thu,  8 Feb 2024 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707382979;
	bh=zLpZpsLNQEvYaAF+kQ5AZa9kkVgTiY2crC+gZ8/1q9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNzZe7oHDWzkcGidOFjY7sae2sK44ms00jR2FldQtLWYcHwcmhLyax8ehHm34HRer
	 q6B3t8PBMtIqP3pNJqvS0gtvmcRnmWZrr1LP1/XPUyNCMf7RtX+Z9hdXBG3sSIXmnn
	 x1A2BoRVGgnFdpKYJ43/YFruNjt8N23sRWaBuedIOMvnDjKLJmgh/mQhKgVZgpCZvv
	 EZvnM+1KVgnHS/xnNJEtLUJ20dfUR6d7k+cgOgMXG8QsjdqDetkvP2HkyJ5DRjYRLi
	 YYR5+Ma3bCv7vrHGN2uoGsssmGVFbEIlfVBzDo3gzeOXxk38X6ho+mf3gSVwF37UGF
	 wCuzWKK4T+TEQ==
Date: Thu, 8 Feb 2024 10:02:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Jan Kara <jack@suse.cz>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, Oded Gabbay <ogabbay@kernel.org>, Wu Hao <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Vineeth Vijayan <vneethv@linux.ibm.com>, 
	Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, 
	Harald Freudenberger <freude@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Diana Craciun <diana.craciun@oss.nxp.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Eric Auger <eric.auger@redhat.com>, Fei Li <fei1.li@intel.com>, Benjamin LaHaise <bcrl@kvack.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fpga@vger.kernel.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-aio@kvack.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Subject: Re: [PATCH v2 2/4] eventfd: simplify eventfd_signal()
Message-ID: <20240208-stemmen-wohlauf-ed1b4571e9a8@brauner>
References: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org>
 <20231122-vfs-eventfd-signal-v2-2-bd549b14ce0c@kernel.org>
 <CABgObfaSVv=TFmwh+bxjaw3fpWAnemnf1Z5Us5kJtNN=oeGrag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaSVv=TFmwh+bxjaw3fpWAnemnf1Z5Us5kJtNN=oeGrag@mail.gmail.com>

On Wed, Feb 07, 2024 at 03:34:59PM +0100, Paolo Bonzini wrote:
> On Wed, Nov 22, 2023 at 1:49 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Ever since the evenfd type was introduced back in 2007 in commit
> > e1ad7468c77d ("signal/timer/event: eventfd core") the eventfd_signal()
> > function only ever passed 1 as a value for @n. There's no point in
> > keeping that additional argument.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  arch/x86/kvm/hyperv.c                     |  2 +-
> >  arch/x86/kvm/xen.c                        |  2 +-
> >  virt/kvm/eventfd.c                        |  4 ++--
> >  30 files changed, 60 insertions(+), 63 deletions(-)
> 
> For KVM:
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I really appreciate all of the ACKs but just fyi that this was merged
for v6.8-rc1. Just so that there's no confusion!
