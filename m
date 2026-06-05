Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC37284B3B;
	Fri,  5 Jun 2026 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653688; cv=none; b=QpXQ16HScylzs6BQTNUsy+LfzyM8UEcC31yw8+F79yBshXsS0G+uwik19vnIWpPD9cRlGBx3r0DrE2uAp+LXOUDRHvk8pLB/YB2wiMXanR64djzrsYpm3BrUru2aCVv18hLqan+WtUNQAXDT/ygTLJ1bt4R/iB6WKr+8NvotN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653688; c=relaxed/simple;
	bh=Qc67DaEWxkNS8DklcsiFvXqNSb60HqMWp42xseGzZB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnP5reOv/vBGAkH+e6jlIO9OWOiNvC/HGwS5SOP01Oj0G29PoP1iumAZw6+Efx1LugFHKoWpGH3TtY58LY1Pc7qGsrFvwluHXOKPsvDJzO6Cndl19cWNZlRyW21vBlQVldQVFrm9imjGWaGVAjg/VD47SzMj+C9m75XxBLxJNvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXM2X9sU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXM2X9sU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C889B1F00893;
	Fri,  5 Jun 2026 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653687;
	bh=mrsvcLiXu0Ao4hop+97PyaFalNBqMBwfs4IXB2xIg/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JXM2X9sUmgYygZViFPws42mlS52xAuLUysMwyczGH6IbsSeUykjROPSC5zgwJwLEW
	 yP8fAzMJSVlc0j3RD2m1nqZXbiZVTBcDG6GKa0GFORPcGcTSQwstZ1G8xsfXbBdYHk
	 ERGVQ1XfT48cMeZLk7CiEPGR0c975AsATGwq+TMzVbkWAXrqXymU61e16sGCxcHgyL
	 d5+CbQ9segPCbjaBqIEuDqxu+v/ReonK1DSardjyp/tWsRyJjWakIEyDcn2N2BhEBb
	 qSQoPQW3Byr5goHSNMWy1549+PcXDKlHKJ1Wep7RyPIR1mkfoyL+A9dUGGw7C9Zdz6
	 xnY6gvIi8ch0w==
Date: Fri, 5 Jun 2026 11:01:47 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 2/2] iommu/virtio: Avoid using the list iterator past the
 loop in viommu_add_resv_mem()
Message-ID: <20260605100147.GB1679101@myrica>
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <20260604051816.2976221-1-maoyixie.tju@gmail.com>
 <20260604051816.2976221-3-maoyixie.tju@gmail.com>
 <20260604160449.GA1619938@myrica>
 <CAHPEe=HV+wpgg3YMQcOxN5M7c+ew6MQRgY0YgW-3KgB91gn_sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHPEe=HV+wpgg3YMQcOxN5M7c+ew6MQRgY0YgW-3KgB91gn_sw@mail.gmail.com>

On Fri, Jun 05, 2026 at 04:59:47PM +0800, Maoyi Xie wrote:
> Hi Jean-Philippe,
> 
> On Fri, Jun 5, 2026 at 12:04 AM Jean-Philippe Brucker <jpb@kernel.org> wrote:
> > Thank you for removing this hack, though I don't find a contract in the
> > list_for_each_entry() doc, and the fix still accesses a cursor outside the
> > loop. Since you mentioned C11 UB in another email, do you have more info
> > on the precise operation which is undefined in the kernel (container_of
> > into an invalid object or the &next->list addition)?  Just so I can avoid
> > it in the future.
> 
> > Anyway, thanks for the patch. If this is just general cleanup that's fine
> > too.
> 
> Thanks for the review. You're right.
> 
> There is no such contract in the docs. I overstated it. And no undefined
> pointer arithmetic happens here either.
> 
> iommu_resv_region has list as its first member, so offsetof is 0. That
> makes container_of(&vdev->resv_regions, struct iommu_resv_region, list)
> just (char *)&vdev->resv_regions - 0, i.e. the head with a different
> type. &next->list is the head again. Nothing reads next as an
> iommu_resv_region, so no pointer leaves its object.
> 
> The container_of would be undefined only if list was not the first
> member. Then the subtraction lands before the real object (C11 6.5.6).
> That is not the case here.
> 
> So this is cleanup, not a UB fix. The typed cursor points at the head but
> reads like an entry. That becomes a real bug the day someone reorders the
> struct or touches another field. The new pos stays a struct list_head *,
> which is just the head, so it avoids all of that. I should have said that
> in the message.
> 
> If you or Joerg prefer, I can resend the series with the wording fixed.

For me the patch is fine as is, I was just curious about what the kernel
expects for pointer arithmetic. Thanks for clarifying

Thanks,
Jean
