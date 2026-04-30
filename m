Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02150342CB0;
	Thu, 30 Apr 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567795; cv=none; b=Rpjy1mAOA2VFnY2M1waKOEyWtn8Ba0KrDdv2PBRp5DRrWET3vfo/fkDwfWpAjtX9qrN0Pznsb5nT2KNo4b9ZI4pDRxezKHKLSaYNWRSaVTaLOYhGX5qe3y8N8UkokewsAuTBm5kjER/dVlhAm9I++yrCC0C81KddHoGpgrqNj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567795; c=relaxed/simple;
	bh=AZrYJpsI5IZysmnS1mIgID7zFnntH31nIKO+gMHOww8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJSowX2ULIT0jwVucjbl2n34GMwogv6GCd/J4gykA6s0Y4LeeqvTWrZgJzQZtohRfzt7g9zf7qSOPd6hOXBsYvpirv8dcnkGMWfGvN+4ZTs8WgzU9vFZFz6tnSsFhW9+7TlO95Lk66moJihtT2+pj6TjGhOf9IbrtVYVlzdIJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/pXgYit; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/pXgYit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFACC2BCB3;
	Thu, 30 Apr 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777567794;
	bh=AZrYJpsI5IZysmnS1mIgID7zFnntH31nIKO+gMHOww8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/pXgYitdltpWHo2Y6XpPts4ou8LFVR4GVW2kOySZR+ZFQDztF1a01j4ns4bzwsua
	 g0lKvdQUoWLBzl0gg0zVzX4UfVqw2O3bVRq//unKcveDudJyQO46a9MGtG8/eRLkkW
	 DtPctyXWF39eaUAoN3j8WspR6MfOCllCHZWyPAhQ=
Date: Thu, 30 Apr 2026 18:49:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jann Horn <jannh@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcov: refactor common handle ID into
 kcov_common_handle_id
Message-ID: <2026043033-crop-reforest-59f5@gregkh>
References: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>

On Thu, Apr 30, 2026 at 04:15:33PM +0200, Jann Horn wrote:
> Store common handle IDs in "struct kcov_common_handle_id", which consumes
> no space in non-KCOV builds.
> This cleanup removes #ifdef boilerplate code from subsystems that
> integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
> diffstat).
> This should also make it easier to add KCOV remote coverage to more
> subsystems in the future.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  drivers/usb/usbip/usbip_common.h | 29 +----------------------------
>  drivers/usb/usbip/vhci_rx.c      |  4 ++--
>  drivers/usb/usbip/vhci_sysfs.c   |  2 +-
>  drivers/vhost/vhost.h            |  2 +-
>  include/linux/kcov.h             | 12 ++++++------
>  include/linux/skbuff.h           | 14 +++-----------
>  include/linux/types.h            |  6 ++++++
>  kernel/kcov.c                    |  6 +++---
>  8 files changed, 23 insertions(+), 52 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
