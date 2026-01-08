Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC73BFE28;
	Thu,  8 Jan 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878403; cv=none; b=D1cuwIVvPmdXYDUNb8W5/HRqQ25XUb+eRXdSLy08UQQoDnaIyMUidFZy+mUEt114xa5Ern99+bDoG9iGhbTvtN1QswWlDALx1cXYoasjYM07OH0N72EBn8+ZVFGl0+GgwIuC5nEgR6HL/hsAqN6Yv5LIsRiR9s1C41hidec64jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878403; c=relaxed/simple;
	bh=DKzOCdahqrVMEyxwxaD6ISQwSXNxJv5l0VXKtFECZ0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK3vKitNYCc2U2vejmoIyKiqP0rsj4SdlmlTB8qMyug6kqVar0wXKAU0aRbOPcNCQdURiP+VNDB7ENVwOPpAmR8hon4NnvFPrLd+lz6Sj/jFEz1GgVhG+d19zbw4EUnHBCPqyvs6MQt2XYFqVAimuK+h3C85l4ZvnL+Aia9H6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GW6Ba7Vb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GW6Ba7Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0926EC116C6;
	Thu,  8 Jan 2026 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767878402;
	bh=DKzOCdahqrVMEyxwxaD6ISQwSXNxJv5l0VXKtFECZ0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GW6Ba7Vb+YHVfwi8TbBL38JHGk/wstunENX6HqqBWHPuilZh80L7u1SFMUG7ZKbP5
	 T0EVyVaIKoSdjHoKpFrOi+Dzv4jCAjiMQlnF1mP8/L8vYwoEHzUagOlruhQOQITi2s
	 xKc871vODO5LK9iQZRYMGrullC2ZorsboxT1MJB0=
Date: Thu, 8 Jan 2026 14:19:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <2026010850-bottling-these-e43d@gregkh>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
 <b905018d5ac8a852759e8483ccf8d396eac4380b.camel@gmail.com>
 <20251223165135-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223165135-mutt-send-email-mst@kernel.org>

On Tue, Dec 23, 2025 at 04:51:41PM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 10:36:48PM +0100, Filip Hejsek wrote:
> > Hi,
> > 
> > I would like to once again request backporting 5326ab737a47
> > ("virtio_console: fix order of fields cols and rows") to LTS kernels
> > (6.12.x, 6.6.x, 6.1.x, 5.15.x and 5.10.x). The patch fixes a
> > discrepancy between the Virtio spec and the Linux implementation.
> > 
> > Previously, we were considering changing the spec instead, however, a
> > decision has been made [1] to keep the spec and backport the kernel
> > fix.
> > 
> > [1]: https://lore.kernel.org/virtio-comment/20251013035826-mutt-send-email-mst@kernel.org/
> > 
> > Thanks,
> > Filip Hejsek
> 
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Now queued up, thanks.

greg k-h
