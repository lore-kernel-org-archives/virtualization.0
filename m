Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0519A288
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037828; cv=none; b=TkHCSXQ7bOuR43E6Sg6UC6gYDoKTuZziyhpajjp53hJ1dXTwj1nXjf4hDWpk8zzYPDVFr+SAFUExsLufPUB3brXuHY9kCfeTlIQIPwjBSB3fJvbDdhhr8jtm18NAzYRumuavBkXMJD+pJnhbpi0K2AgSjpu99FP9ECHtqBBiOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037828; c=relaxed/simple;
	bh=BSx3qFPNO/NMYwuSHNZB31nKRkS0Y90uuNokhVUvaPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGK9boRx2/8TjHbcuffCU9ri+Wf1Ulm1xhJXHAyJJfN8OJ9q/5rQPr14XATDT6gPoDYXV3qEtm9xzl8sAf/6Jg7HzQIZIcjzcNBWdoEmGN2D+l6mlCl6dO/qeLZjpy+HS3py70NyXDYw+7r878Id+3j9TK0X0iaB5Co+a/5zSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HFC15QFW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HFC15QFW"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ee63e91acfso336532185a.2
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777037827; x=1777642627; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uWWbj/VPS78zqXVF7C00n2rbNCSFE3WHczyNV5IMoNo=;
        b=HFC15QFWtiZZSH2LtD9RMqWxdGxFG1UfJGQ7I5EMzQJbkFHtbghS5g6rGzTdzyxywg
         WyZwkMuyIWM/bI5lJtEf6dAu/0pO9JzBz4dlarPTQ8WUPNsrqMP+SvqxFMmZoPyhcnzo
         rxuZv/QzO4Sb396SIq1/tOFDdOROO3tyT+s3mlmFBL3RduIliZieZFEpaa+4xlh36Y5K
         9K982tRI8eDQJbYczusiPEIbJV8yx7t/UduFmMzYoGECf7jvbr3LLnc3UPOccE5cBfhO
         ETN2q41YXtw811ErJaCfO7wAQGmQ/nUFPdczbsk0/81mN6ImZoQ0kiuJat+XLpbD9fmB
         7GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777037827; x=1777642627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWWbj/VPS78zqXVF7C00n2rbNCSFE3WHczyNV5IMoNo=;
        b=hYdzgWrhXH+RBO5YswbtRX/vQuCwF51vVVGn5iDZWz9JNu4T+tc90N3mBPFxeMDDYv
         OqT/xN1bLEi0ESN+LZ2olnGh0Nhv2lE6k3keV6cobBp/R0VHP4+6ccG36nOSNv9I9n4N
         GGHMzMGZ1JuPlWRuKWaGFdzb1e/hpmXJL7/eIUecfUVCyQQwWGwBrJZmo2sEB+baZTE8
         REKqIqhjj/JyyPLIItyIB/AFDJQkfSU7bX9iWSd+3CcCo5L33I8n84LjtWsXDCCoXEtD
         usYQdMlDg7/Xls9guD/fg2TPyvzaiJ/zD81nxn2FtKWnokU7OgcAG1Uquiemic6CzojF
         XHYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xYZN+3bfThUkJwj35ujFW4x9o5f+tTQRSbkxCcuVx1TsHHMIJrhMbwpoklSJtGeTrxnLjq3OaaE1IgkAq5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCemQllDk3P1AsTbDCNzsIXDsCIvC8cubD/yh0yZ8dNKQbxf5t
	ypWc9kNi3CLYCE6pgZx8iyT2DBcinVOjynOhqPMv0LQRP5v2fw9KKzLfskzoGnSBOes=
X-Gm-Gg: AeBDietquS90oeeYTu1YHZhk/2YFmQLO5lAJTa7ZsFkTQHRP1VRbCiAGab9/TFAYHYn
	CpxQWp8faQDCMFVxGo/n+bJ3L3vGuPu3LE7WxnDAOFOPqKZEAZ5uQGhCCBui0/RRZDmKZrENXlx
	SEEhZZBuGNJoktOAxK3gpV8Y425AtYvWtesbmhEAW9w+/Om9RiLa9zY9n93kPGRyCNTyzPcHtjZ
	eM1/T7D7UY9nO7c87gt34cSsAwwxHGnAhdT0kl58R6wXHRmlnDS1LGY2szZAZjHsDn12kqU5zdH
	rz4bJ8Ec2/9sn9xTXY+KZdyBbwt1Rzw9EO0TGwUJsQnxI+jb02x87oKJ0bWbypSnpu0LVJ6bMMO
	fyvmqPTcB18Cjck/t6UTP/L0nffF6mmrQriPUJxT+EAyqtJyjjaeLHXSwEaYy3ML/En5HgF+NGN
	dMasbhLFhbRCxojqSSpgDBgHhKLu9f1NcqcsTxY9lO1Ge6h1ch23NJVt94/QckUw==
X-Received: by 2002:a05:620a:17a3:b0:8d0:27b8:fb7 with SMTP id af79cd13be357-8e79246cd79mr4470598685a.46.1777037826446;
        Fri, 24 Apr 2026 06:37:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe98dcsm1992846185a.7.2026.04.24.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:37:06 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:37:04 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>, peterz@infradead.org, 
	david@kernel.org, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	ypodemsk@redhat.com, hughd@google.com, will@kernel.org, aneesh.kumar@kernel.org, 
	npiggin@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, 
	jannh@google.com, jgross@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	boris.ostrovsky@oracle.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <aetw4aoABYj3keMh@plex>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>

On 04-24 06:30, Andrew Morton wrote:
> On Fri, 24 Apr 2026 14:25:26 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> 
> > When page table operations require synchronization with software/lockless
> > walkers, they call tlb_remove_table_sync_{one,rcu}() after flushing the
> > TLB (tlb->freed_tables or tlb->unshared_tables).
> > 
> > On architectures where the TLB flush already sends IPIs to all target CPUs,
> > the subsequent sync IPI broadcast is redundant. This is not only costly on
> > large systems where it disrupts all CPUs even for single-process page table
> > operations, but has also been reported to hurt RT workloads[1].
> > 
> > This series introduces tlb_table_flush_implies_ipi_broadcast() to check if
> > the prior TLB flush already provided the necessary synchronization. When
> > true, the sync calls can early-return.
> > 
> > A few cases rely on this synchronization:
> > 
> > 1) hugetlb PMD unshare[2]: The problem is not the freeing but the reuse
> >    of the PMD table for other purposes in the last remaining user after
> >    unsharing.
> > 
> > 2) khugepaged collapse[3]: Ensure no concurrent GUP-fast before collapsing
> >    and (possibly) freeing the page table / re-depositing it.
> 
> Sashiko questions:
> 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> 
> (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> said the same stuff about v9 and it's all wrong.  But better safe than
> sorry!)

These emails are helpful; but, I do not believe you should have to 
manually follow up with a link to every new patch series.

Perhaps  Sashiko could automatically send a summary email in response to 
the cover letter, or provide a link once the reviews are complete. For 
the kexec ML, we opted-in with Roman to receive automated emails from 
sashiko.

+Cc: Roman.

> 
> 
