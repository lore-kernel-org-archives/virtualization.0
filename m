Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08F3502A9
	for <virtualization@lists.linux-foundation.org>; Fri,  8 May 2026 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220576; cv=none; b=uuI0OhYy2/YtCG+HmleLXSSHP7+TyP399Z0+sVk0SWZAE+cYrKn5liH4m3QgKZo2uJjzR1Bsibo56h2XKnBonUuZlrcIEVR0XMVp7mElXLd6F48Ap7p0nA2zoelMBQWOZvrqAbuTjev9nvhWoOni3QlLS+F3LIxZPczyDbEiGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220576; c=relaxed/simple;
	bh=K5xtDAuyrMvBSiVkIb+d9ftD5LvUthW6cMj49rrgJho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e6jxfKb2+dGHagBWXFsNVjATtR2BPSNkVw2Z5E5LH/HSehNvC8uxpoBBa4z/Cis+MAjCDCiAHpVXdTb45PrygqLzPXVcHaeU/ZzT5bSqdvXlLIBqSiko5GVtcnVzZbVInD0Mo4kT7v0ZYuApyHM1J1tV0W73PyWmbfwApqQ1HsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRUlesgA; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRUlesgA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0907830E6
	for <virtualization@lists.linux-foundation.org>; Fri,  8 May 2026 06:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7f8eHKVc39n for <virtualization@lists.linux-foundation.org>;
 Fri,  8 May 2026 06:09:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BFC4C832C2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFC4C832C2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hRUlesgA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BFC4C832C2
	for <virtualization@lists.linux-foundation.org>; Fri,  8 May 2026 06:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778220558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeECdFhE1e2rNXT3Sj2OPEv03eYYs8feiSdikU8nZxQ=;
	b=hRUlesgAN+BcZ4rQpKV3f8qsSalfdk3LALPD7oqWo80omQlfKU7+ISMeVdXGev8ixIFGLx
	iPdkzPYTLcgRyfyAuxpSu1rYU2LuPhWJ9MaftCb9JteAHLTL0sgT3CVffLK9SzjzJZyowO
	4D1tsk+Z47bk4VFnNoHyZdR1E5HiPdY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-h1VBWfy1NXyNtJZKx42PWQ-1; Fri, 08 May 2026 02:09:16 -0400
X-MC-Unique: h1VBWfy1NXyNtJZKx42PWQ-1
X-Mimecast-MFC-AGG-ID: h1VBWfy1NXyNtJZKx42PWQ_1778220556
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso18994025e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 07 May 2026 23:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220555; x=1778825355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeECdFhE1e2rNXT3Sj2OPEv03eYYs8feiSdikU8nZxQ=;
        b=FAK8MG0ZpobpweSA1rk7OhyN7I1dvzzhxvF1i/poo2tPlMrVfox92UHgdYgrpfbltl
         9WF5JQ+vq/7f5EEeF0F4owGmQKTPf1MARohZHKwKnNSzX1j8P1S75jdAjveUGkvA/RAI
         tcrFgwDHgtX+ZDtd3YezEBgUJbrpvvI+FvR48lQcJNGManJZTzm6yJgzc8Ithbd69XUL
         SZfY3Z8q3SfdPTplmytPPpSkCZsZmonrIC/5GdRsJGGBDwVxyhOpm44sVo7qJ3Y3e4Ri
         tPwWwtoCJKhu9JFi00qFIiokGa1rL4KefsEJ1KhGN7R2qexiAECtI9Z6qk2BoKPoedJh
         jCzw==
X-Forwarded-Encrypted: i=1; AFNElJ/JeFlMgK9y80cz/NFCJRlfi1fT3hwqGT0ns4kTGC4SMiz823xfI3VTyQGo2+kHbfnNLCTQzOdldxrNWhNp5A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx0S7jFhCXjK/rOAncdrzLGNOxA0OI7yMrYJiIHXdi/TOAH3Whf
	F2Cdc+WX2bO6pZzVPME6H8eIEBowFsZNV1MmAP8h78csOaho1bIXU+I9O1cwW7IL11ku/3h2fx8
	v9YDN1y06Sdy6ZB+AtvGnHJYvHafrBD1iqyUC4QmTkE3mXD3wgyp2Kp89DryK1K7HjZQxHVyyTc
	2+arOqeWM=
X-Gm-Gg: AeBDiesQvI08LCESIfe8aOJ2KvZI1a0TJ8swUCZRCRYC4JdvyeZkVz82kHhaTWADL3T
	RnbW8UJ1VyKZqxZiIxPOlo35rjNxQGCcUmOy5sq2z5x5UsLfd2RI7guLJakr7xpicno3c7sBTZp
	+19MfFks4rQn9xRhJXOSrw4fFpbnX7XuA2I77juTsHHpmsf6/T831Fhg/hglG9r0ZBXew5setMl
	KkiaL2UfK78KKtIkYnkqbMiFxO0M4J1sfyIbCFvwT33yWkxUmxdkzMibGp8/U/m5SLJaQkNRgL6
	LjctXPPr2mDUYBa8hNxBiCRTkTXSdmXCXuGvI+2j547xTw3a6MFD9gwJ/hClnsG2e2YmSWg6ab0
	6Ln1/2YMNWT2BjBvKVQsk+IpR07xFN0fUUY3lRaQO
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr83500515e9.6.1778220555290;
        Thu, 07 May 2026 23:09:15 -0700 (PDT)
X-Received: by 2002:a05:600c:444f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48e5dfd6a6amr83499615e9.6.1778220554672;
        Thu, 07 May 2026 23:09:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f45d72sm13235625e9.9.2026.05.07.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:09:14 -0700 (PDT)
Date: Fri, 8 May 2026 02:09:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [mst-vhost:balloon 6/30] Warning: mm/mempolicy.c:2444 function
 parameter 'user_addr' not described in '__alloc_pages_mpol'
Message-ID: <20260508020425-mutt-send-email-mst@kernel.org>
References: <202605080515.6jRN5wN7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202605080515.6jRN5wN7-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: af7OqZZuiR6bvKpCfj2xO4NjjX7oX07u-iNrnPQGIiw_1778220556
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2026 at 05:26:30AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
> head:   9f56ee36fbf6a6d336dc6a9eaeb4f8a67cb42a31
> commit: c4289f5a4e563611a468b4b5379025a4aa4a7c12 [6/30] mm: thread user_addr through page allocator for cache-friendly zeroing
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260508/202605080515.6jRN5wN7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605080515.6jRN5wN7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> Warning: mm/mempolicy.c:2444 function parameter 'user_addr' not described in '__alloc_pages_mpol'
> >> Warning: mm/mempolicy.c:2444 expecting prototype for alloc_pages_mpol(). Prototype was for __alloc_pages_mpol() instead
>    Warning: mm/mempolicy.c:2547 expecting prototype for vma_alloc_folio(). Prototype was for alloc_frozen_pages() instead
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


kerneldoc messed up with a rebase. will fix in v6.

