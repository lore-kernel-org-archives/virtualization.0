Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D22EFD9C
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Jul 2025 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655862; cv=none; b=aEi8kBOtATY3KUPyEUDOyudXab5rVc+3Fxr95Can3Qt8ql4gIIGuMkCA5Ol8m5LzazYRKy559D9N2thc88utgmpUTF8orjegMzLz3GHRh1JlCyFp1Z1GZoOeu51CkMMAR6quk2AWVNuTY2/OGODN+u0KI1gTocNKyx1dxfMCoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655862; c=relaxed/simple;
	bh=GS2XHA226b6emGNknYbU7j3knflLrU/I0nHrns/wD+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz8lde7o2FErmOjgSFVtPCIyD66cz4EDMwet5lXYx93X8V2Opq0n2JsfOQU3FXK+KyPrrxRIoEgBFgLR8CYPV6clbWUGa8E1iUeXanrVGF8KOlv/Uk0FKyrl9amrp5bntfIvT3YdnSmTJpqcegGvbPMRJWLKKqC5eQxuOvzmMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAmTOu4z; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAmTOu4z"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1561683CCC
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Jul 2025 08:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sjzI1OThB4nf for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jul 2025 08:51:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3AD5283661
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AD5283661
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LAmTOu4z
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3AD5283661
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Jul 2025 08:51:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 868DE439FE;
	Wed, 16 Jul 2025 08:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF3BC4CEF0;
	Wed, 16 Jul 2025 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752655859;
	bh=GS2XHA226b6emGNknYbU7j3knflLrU/I0nHrns/wD+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAmTOu4zvCP8hEtoVUfB8Rk2hDssr+5Sw7W4iffqxMJkKWNdNAobP+ULQr7+C6T7l
	 QmZPP+t8wVXHn0AfE9Vp91U0PoFoG1SZyY4Uw9gYLkjKBYbr9hy2UyRw5kBhqEywgx
	 oZ+w5vwNcyrEbOEd+r48LSAfmVcK9iyrFVsmFstUdGi54fxc86FwB2G4gzNOcWtY3e
	 Rg2uKQe831FWqiTP9E2g+ycMSliNEWMPF99VhqWekx/FaBZM8tuyEyfKA47iubfrF5
	 kIO++//02Owst8ncBpYtIfMWsx45jtOtl1sgx0Jk/NkijNWarNwywBKVV74RJQEfn3
	 O4jbTUiod6TCw==
Date: Wed, 16 Jul 2025 09:50:55 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13] vhost: Reintroduces support of kthread API and adds
 mode selection
Message-ID: <20250716085055.GJ721198@horms.kernel.org>
References: <20250714071333.59794-2-lulu@redhat.com>
 <9dd21a72-9451-4b77-9ab4-d9b31b408e25@web.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd21a72-9451-4b77-9ab4-d9b31b408e25@web.de>

On Tue, Jul 15, 2025 at 08:43:45PM +0200, Markus Elfring wrote:
> > This patch reintroduces kthread mode for vhost workers and provides
> > configuration to select between kthread and task worker.
> …
> 
> Is there a need to reconsider the relevance once more for the presented
> cover letter?
> 
> 
> …
> > +++ b/drivers/vhost/vhost.c
> …
> > +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> > +{
> …
> > +	vhost_worker_queue(worker, &attach.work);
> > +
> > +	mutex_lock(&worker->mutex);
> …
> > +	worker->attachment_cnt = saved_cnt;
> > +
> > +	mutex_unlock(&worker->mutex);
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(mutex)(&worker->mutex);”?
> https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L225

Quoting the documentation, I'd suggest these circumstances:

  1.6.5. Using device-managed and cleanup.h constructs

  Netdev remains skeptical about promises of all “auto-cleanup” APIs,
  including even devm_ helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.

  Use of guard() is discouraged within any function longer than 20 lines,
  scoped_guard() is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.

  Low level cleanup constructs (such as __free()) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  __free() within networking core and drivers is discouraged. Similar
  guidance applies to declaring variables mid-function.

https://docs.kernel.org/6.16-rc6/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

IOW, the code is fine as-is.
