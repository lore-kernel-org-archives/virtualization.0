Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9A3AE1A6
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303957; cv=none; b=s6qf3qIltIomVLZtyZopE1zc5wRGioUe/n1Q1Yx26xO1y1aejvdAXrwsf6WImP/4sTfjgPfNBgL/csRTrdc0d1oCAlxXWRlxJUdwkzbnsRyx4auRGsLLraKv+d6t0o7DdUW/cfsfMR15uZxdBs2fAlhHqgR6Ht3gMinxZrT+dOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303957; c=relaxed/simple;
	bh=FtFq0WKT4r2lSgaGZvlrvlEpqmrahVg2BRnTRQJ6M7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okIFGTA7GeKGnJCmBzv0wIJfnW3zpSR5PdejYsvlNJyYF28WaSJ21v/iXf7SHTk9ewbdoPiPbQf7M3hvoQO2V6jjs28GHrMBUD4PHgDzP6dymj1LtOC5avNLPljdgMNJV+t3O9t4sgGPveNT8eAxbMiUf5kk56V1NmPpaKjAy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3Jt4SgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3Jt4SgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62901F00A3A;
	Wed, 24 Jun 2026 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782303955;
	bh=TQD+wAPfgrJ+We19k8i+bBm5RwCInd87+tkU1eHjd3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b3Jt4SgUAlDImUqrHQSzV+QHSFDH5v2kCOo5b3UylUXkZLqEruvfdDsY4BYlJRn+0
	 h+gFbOPTY9YKzJj4LwA4jiazI/uFe+YKxuLKv/t21/AKbdBim+sSI97Oz/ARDETanY
	 13uOgMd1yv+Pu1yLkyVMprDThWSuQh7+HPebTy1FLVcpALK/ggnsG62eTdRrxJw11t
	 7D7+c80+aKVJ0lMXD2WwMkaiCpA365gK5Tsk4mQU2H3XN2BAk14oIaHCs+6awzBtMP
	 /04uMk4K9NFAOhQ+pVqtmSqEmWlAXlcvEie5FSeipAdNVjDftF5iDqG56FvTH3z2pd
	 GmKTBniydw50g==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF7A7F4008A;
	Wed, 24 Jun 2026 08:25:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 08:25:53 -0400
X-ME-Sender: <xms:0cw7akmMatnmq2tN9H9uOaRUKfVYShW2-aodrFzivkNo1sVxI7gdbg>
    <xme:0cw7agl7GIyaW_2WzXMwTXmCIBvWD3QmeUIcd_xa_6LSzd3_qpGYshNMkbwzBXzaM
    XTzwM-etXzOKECfWakm5gD9rWnGQXZdIwNILGEGDUJVt8E8KGFO4pip>
X-ME-Received: <xmr:0cw7aiNDZKcW0vLCHN91zVgqq-LVdIZofYwfqvLZQaal8lcLIPPFFyloV8qx7Q>
X-ME-Proxy-Cause: dmFkZTGQArAWzBSIqfuCjB0QzONNhA+q1CTAuSMwuEBhzBy/tzZqNdZnhLnrUk/bzcO1Ob
    qV5IsSKZlnlHEtJlLVg73sfCfTAynNDnYDTF4kwRi+w+FTkK0Cj/188NyX7JkGKPWfnNxe
    ZM17FZj2tytGZvcbggL5ccIEAiZubQjW2zQ07p6w8z8ORw0594PYKzpLhaAAFoTGFnu7lT
    mIFyKVlsfgsicOOXIpKoRyBfzhw2QmhbjRQVUl1F5TMPInjH/W7zYT1cpsVHPi/+sVRVBH
    vqkvswFzfuR86M13twlXL/uVXDyIS9Q4ttcM4JAEe/dw44lKApfjLlgg9VpuTCIqLAFjc8
    lfAZXsw2ZesBSuqmCqHnfm0szX9ve6I/yW+B6kKyqC0V/2aPyrKzOTeXKquR9ugthq9ZpI
    2JVQ/bsKwGCEQEXT285scThoRVpDrBEKWa0mVQfEdSFtnvAk4EsophWkKFIkvbjdR+3XfW
    bilOl6viVL06Aire7DQ7K4tVqWWx8hkt4cbd/EhNP+6iMuaZlLQcahtz650vQao+VKtLj+
    V1oyDhTU+toFWUL8Bf4o++J3KnmI0+jQ29QFyd0y/KgrxirVQZAYNqfuMBkwYfbX6oEomz
    1AKR0idZNDijlc7P9LpEqBNH+0d+VkhkmA7R+bHK9i2x+1wGYiRHHdDfjxPw
X-ME-Proxy: <xmx:0cw7apNiqmuBGIWNhu0Adz4cCweJv7pRzgW9qBjueoSW0oPnMI035w>
    <xmx:0cw7anFtCs2h1-OX0m5Z57eiGOTvVF5ZcLwPV3fy6KS-Majg8G7kxw>
    <xmx:0cw7anpjyeIcJSTNOl8d2GmXTYH5_MbZ8vzAOPQxOm_lN03rbqIpog>
    <xmx:0cw7ak_lKPalAMXZGFhJTidGndG7TjIfwpIW2s9s8w_7w9Y1W69Vpw>
    <xmx:0cw7aoRGeoI9z0aiA_uA_vVBmVTAAJeCgRJI_Oo5yMkYHuOd8OytQ-cX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 08:25:51 -0400 (EDT)
Date: Wed, 24 Jun 2026 13:25:46 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: marcandre.lureau@redhat.com, david@kernel.org, 
	rick.p.edgecombe@intel.com, prsampat@amd.com, pbonzini@redhat.com, mst@redhat.com, 
	peterx@redhat.com, chenyi.qiang@intel.com, elena.reshetova@intel.com, 
	michael.roth@amd.com, ackerleytng@google.com, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, x86@kernel.org, 
	yilun.xu@intel.com, xiaoyao.li@intel.com, chao.p.peng@intel.com
Subject: Re: [RFCv2 PATCH 1/6] efi/unaccepted: Support hotplug memory in
 unaccepted bitmap via SRAT
Message-ID: <ajvLaBs62bDoxC3W@thinkstation>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <20260623101739.79695-2-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623101739.79695-2-zhenzhong.duan@intel.com>

On Tue, Jun 23, 2026 at 06:17:32AM -0400, Zhenzhong Duan wrote:
> Currently, allocate_unaccepted_bitmap() only scans the initial EFI
> boot memory map. This misses hotpluggable ranges described in the
> ACPI SRAT. Without early tracking, hotplug pages are accessed without
> acceptance and this triggers guest crash.
> 
> Introduce a lightweight ACPI SRAT parser to scan these regions early.
> If a region has both ACPI_SRAT_MEM_ENABLED and ACPI_SRAT_MEM_HOT_PLUGGABLE
> flags, expand the tracking boundaries. This avoids pulling in the full
> ACPI subsystem while ensuring the bitmap covers both static memory and
> hotplug memory.

Ugh.. Parsing SRAT there is ugly. I would rather avoid it.

Do I understand correctly that we don't have a way represent pluggable,
but not present memory in EFI memory map?

IIUC, EFI_MEMORY_HOT_PLUGGABLE is actually present, but unpluggable
memory.

Maybe it would be better just allocate bitmap upto maxmem?

And fix EFI spec to add pluggable-but-not-present attribute.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
