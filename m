Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E462848AA
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776738083; cv=none; b=aRT3biNTb8ewrcgsHHDdfK7PGNsEqqRk0j48I+D/bB5hghUsWeCXwlsjHZgiVkrpLueH89O4EPw+s/P/r/69c9NCkznNmsHUmLKNRaRmhY4YghL2iRvYmmTFBBrTOM2S2/HNYMWJOr7aFU9vUop+uXWJmZtPAtIBrckZiDEcobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776738083; c=relaxed/simple;
	bh=puw2Z06oXZwCZ5/QATkErGasEbCoKz+hvxu43KOvrCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaMzaj8++CyVELifI4TDj9dgmdrOlN6I4HDXvQVr5sVImgQCZVAS8u2YQEuYSrdtKPqghz7DOd8TxEEdtBLGntn2cCKLztJQNGz+TylQMSPGNZRremg+NI4M9YVPIz9elaeZuc8ayLNVHTTx48+JiUUt0gtTCPMdm1XGqrlzPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WK8l8smu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WK8l8smu"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d880e6fbbso50334981cf.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 19:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776738081; x=1777342881; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts4fktzEABhwW/8zC7If98qX/eLs2oXD1C9NL7CTV+M=;
        b=WK8l8smuUcdFkWcFVMGIlto4zlGJLWNnKuOnzs6ybMv/jCQLeCtc5XtESO3ys1kZ03
         J2HIjEDcyfUZ52aJan+H7w2mGWZ5fh4+GtngVJtl5yLDa6PRA72wl8mJblxTpVBE5Gyj
         XJORfClWCh33WHPqE+w+FZ4t686Nb53bSEfp5ORLl/BEt30neKY197AIFdF7f9cBDOkv
         Vb062iCcWp1zaKF2oGyxGToxdGenLWm6afr63eLlFP/4B474cjjWoQRCSr9Ay70Mzk5O
         hl867Ox3zntO00RNISemuBmBA/pF/tNs1IE/cW6tfzy9YPHpHxALqbS6qg0vm0V0iyaq
         n/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776738081; x=1777342881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts4fktzEABhwW/8zC7If98qX/eLs2oXD1C9NL7CTV+M=;
        b=KQ9lYz3PXaP+MC4JeI5rG31wP3JQNC+b4vBQ44B2ZuTvoKQABorMTgo3siSZVgiL3t
         LrJSTyOFNP1POutdLmFcYnijuZngpgX+q7JADMEGL89lc9X8qHUc5Sv3k5E4x65CYWjT
         AVHDIEazdwpoviHawutUBERXQTsHdMs9pDF4dq2EE5gjYwBKUniKsM3s/SR/PsU973Ib
         TsH/ZT0i9WQ9GWcHwkh5yyT5o0N0WlvXZPnGD7gmpE4RskNcQf8+3rzlppSPEkpYWDJi
         iQht+82pnlMTcfxeIwpqE1BeNMXA6LSPC+Ni+Xn/mJN29tAPGWO5trEnUDE+9YPvrOhS
         9MOA==
X-Forwarded-Encrypted: i=1; AFNElJ+GhU3VgZOvOqDNb0u1IUAdFmMrePGzLFzZrsCh4jvKUE1bHEjZiJD95Gk4bX6sEZf/De2GXGnrWGGsDVYEQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YybRI6Or3yo+HKO000R9zoP3Xh2bLtFTu7pYg8XPO345Cu6DcJw
	PGk3aBsp2fbBWBO3IbpE8nYkeT60l0egHzwpusBdpxcKUyEEO+gL5TJQPHM/ws/kC8I=
X-Gm-Gg: AeBDieupUPhBgaBwmxW2K66B2W+ZIa0rorwxK2grLAEOwFGI+DEOcx//NRItCEvByhS
	ghByYcnCOGz/njjE05Q3G6fTyn6YFK2P/Dzq/0eksXIx/KERfUWzrO/gcrUtn3BEOnDOqnjbcYY
	3Xu7rHsr2k0lrhq0qO94SAbJgBZBxlYxb/wqpdSBM7OZt7QoYqu9J9tyO/MWXw/TzNQGO9PIgEy
	yjIKWCFyDfipdKMeubQhYc69lz6VBJPAwRp7r9SEfDNEX342mq0qgSiMaJjJdrwLTPciNkdNmOj
	LEpxiaVqwO/N5re4Alf0w+R6dij0gGWfb23Mi0WYuejokrbfF15602N5L2bC0WBhufLOu9IixST
	TzGTU5YDHJCIG6aUyLzrENlyOIJv2hm8Jk7tu3oZqsvWca6O0xVcAx5BzZgi5Ls7YzPpmFI2Qme
	PZE17FM5vDJl5Tfma0cyAjIF5c5E18B+mBoTxWU+zaN4SVUAbNGxRfm/acuXkr+hztxwC9i447W
	Y1JuABdnFQdzqVjUYPdU/w=
X-Received: by 2002:a05:622a:8356:b0:509:2231:977a with SMTP id d75a77b69052e-50e3676f1fbmr145985271cf.30.1776738080875;
        Mon, 20 Apr 2026 19:21:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-51-163-112.washdc.fios.verizon.net. [108.51.163.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39495192sm99043001cf.27.2026.04.20.19.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:21:20 -0700 (PDT)
Date: Mon, 20 Apr 2026 22:21:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH RFC v2 00/18] mm/virtio: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <aebfHrTC4Iz6ZQpx@gourry-fedora-PF4VCD3F>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776689093.git.mst@redhat.com>

On Mon, Apr 20, 2026 at 08:51:13AM -0400, Michael S. Tsirkin wrote:
> 
> When a guest reports free pages to the hypervisor via virtio-balloon's
> free page reporting, the host typically zeros those pages when reclaiming
> their backing memory (e.g., via MADV_DONTNEED on anonymous mappings).
> When the guest later reallocates those pages, the kernel zeros them
> again -- redundantly.
>

It took me a second to really wrap my head around what you were saying
here, but if i'm following correctly:

  1) Guest steals a page, reports the free page to the host
  2) Host returns that page to the buddy
  3) Guest wants the page back -> vmexit, alloc()
      a) host gets a page from the buddy via fault path
      b) this memory is "user memory" so host zeroes the page
  4) Guest repeats step 3, re-zeoring the page

So you're adding a step that does:

  1) page_reporting_drain() in guest sets PG_zeroed if host_zeroes_pages=true
  2) on allocation, if PG_zeroed is set, don't zero

In theory this seems ok.  PG_zeroed being a buddy-only flag is nice.

In practice there are obvious concerns about an explicit flag that would
allow a kernel (in this case the guest) to skip zeroing a page destined
for userland mappings - but i'm also paranoid.

In concept this seems reasonable, in implementation I have concerns
about the pghint_t type being added. Will respond inline in David's
reply thread on that though where you already have notes.

~Gregory
