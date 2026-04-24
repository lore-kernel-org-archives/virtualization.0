Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B863DA7C4
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041653; cv=none; b=Zg/Y4paPEzRJonMmJEkmCKyA7aP/nbpcFMQXEpWaKSdTF6Erc3uz+HrL40IwOwRSZdfcah8MgdWhEujuBavkz3go/6aVwJSHLJ/ZogM+FyhiKeJdSrB1/89yLNrsyfQbDjRiF4OutTPopwyNb4uOgoGFTQfMdpFQdLX2BjsKKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041653; c=relaxed/simple;
	bh=ssQXKcLcGAYDJ+MlHe6P5SXi6S6dHklut16i873xFNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdDxtoFK8vtmWKTDPxwOgxBAFMt56zBw7TF/CTb9dOXINDVj/l+2gKp+S7IOPxyG6xeEye2/JeQ11jKfSibvU/Q7BuXuAY//yG6Hz3msddz9D86vLRqNM4m0B0FZRe7jHYF9hNNOhOpO5a3HyWwx2X9/GCaZvj/5caO3e3TKRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dC9No9rS; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dC9No9rS"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651bf695701so6434613d50.2
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777041651; x=1777646451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MGeb+YYn7RN3axNi7qPpfKeHmTAGHGlAbe1TFBeXhXU=;
        b=dC9No9rS4hlSfEDgwEfmqSWGx0HvilAi01AZrIuiKLZk5vSzwb3QWsbvpOap34mLJz
         z7ZtM8AmkDAgHwErZgcsniTHl2VnMZNvkx5zme0+Ea3rptI3QNkJ9fIqX2Go23RRQle7
         7H9Ywf8uI0EsSOXOYbzRbpozx5gu4RT8wpl9JIJafF7k9h6FcqSkIdHw3Pjkq36nofO+
         6zkXDtA2B9F9fOHd41gWN/UMTONSlN5SVHNfLcNCHI4Nd79jzdH9nazks7M03wPJgXaV
         bczgt+r9Wz/c5H80HSDQDJJbsxYefX+jiSZwGocppxxUyO3yMhCm6qckjsB4Ab8Cah4W
         gugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041651; x=1777646451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGeb+YYn7RN3axNi7qPpfKeHmTAGHGlAbe1TFBeXhXU=;
        b=qM3AKDOYfxTzsIx1quyRtFWyVUbsnFxCwf9vr7OjR/pIias533ox/wDxJPs+nAY8KB
         a+MVZdkKsFBwonIR9e2f2EHUKfLZb18cBXm5xMUWbStxzBOt5B2M451rDYkgUAmy19Zy
         Eob7lgqJKnfkWxCNZdJ5iWrW3htJmC6H7GPw+DoquEGOhivSCa0mQ4RYzyhljUki3t0H
         fO2GTFn9NV241HWYhXcQPdRusSSqrj5gm+9M52QcZ5CHVWhckHvtvbtJpyZZUWfBpsKs
         DruT9DOiTvUpVqsa8L09yM5aLnpu586oVOT1/GL/YAhSsRucIlm99wf+a11BTj0X1dVg
         NkkA==
X-Forwarded-Encrypted: i=1; AFNElJ8wq6FvraIekxch98CLEUvWXK1Xe6X4XXZiZPriHg06MuEbKHxGh+es0LdlLm+RhEEQ1k0L4wdp4WeBwUkCzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCq1QDuG+l+War0/w2USdzudtL1T0Wr4DIrfUYhVE3qlifpY5e
	g8BLWx9aOzbCbzAt7XCGIOHKa3cj2GrP4endHOYZmTIdCTOR+9eQnhtMlYlyCDS4p2c=
X-Gm-Gg: AeBDiesFZ1WqxhWmZyy2o8ISoUnJHpI0mNgoupuJp4tWlNO0wmw5B4HmhXGUlH0oG0u
	Te0i1T8nSYF6qlVDTi7yXBnvxof4vH5KpEvBrpE+EHHGiqz3kOG9rmPr6t6yhxvxItK7W7/fhkR
	LTkXp7aJi9evz5UjJOBl+KYnSgjO556EPxb1z2vcyqJZa3kCwE+zi0ALGbAm2rAibFAYJCpeqC7
	06Z+YV/wSbBHR4vrK1Rbjj7ZrtRsWxQrRttS6+iMXWRU7f6uLWE3Rr2dUYMcUEurodgcBpPs2Tr
	0pTdLWRK3JOWMiOgqyMv1VtG8ZxMbE36zZlmFAlparQ5KQ+/6LfH7I2ZxD2fFMaHnXUrIFuX5pT
	JaHiP/7F50DVavq9LqcvI6sg0zY6DrvfO2vBjQ+2VJ7eUYLnnmNzyNG2QiKw2+dyUBTdrT/2Kwu
	U02/QK7bMcgw/I4imWY5pLW59Cmk4r5r2JWfbBecY4cAb/6+3Pcxd5vW8nR5jikJsChBpbcIHb1
	avKqt00cd5zX2PxiO4/nRgRLBN1jgyLY7F6PNbM
X-Received: by 2002:a05:690e:4004:b0:657:4568:c4c4 with SMTP id 956f58d0204a3-6574568c682mr1080804d50.18.1777041650771;
        Fri, 24 Apr 2026 07:40:50 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b25fa8sm10692424d50.1.2026.04.24.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:40:50 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:40:49 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Lance Yang <lance.yang@linux.dev>, peterz@infradead.org, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, ypodemsk@redhat.com, 
	hughd@google.com, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, jannh@google.com, 
	jgross@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	boris.ostrovsky@oracle.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <aeuAwkNsmDer08MD@google.com>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex>
 <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>

On 04-24 07:31, Andrew Morton wrote:
> On Fri, 24 Apr 2026 16:20:55 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
> > On 4/24/26 16:15, Andrew Morton wrote:
> > > On Fri, 24 Apr 2026 13:37:04 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > 
> > >> On 04-24 06:30, Andrew Morton wrote:
> > >>>
> > >>>
> > >>> Sashiko questions:
> > >>> 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> > >>>
> > >>> (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> > >>> said the same stuff about v9 and it's all wrong.  But better safe than
> > >>> sorry!)
> > >>
> > >> These emails are helpful; but, I do not believe you should have to 
> > >> manually follow up with a link to every new patch series.
> > >>
> > >> Perhaps  Sashiko could automatically send a summary email in response to 
> > >> the cover letter, or provide a link once the reviews are complete. For 
> > >> the kexec ML, we opted-in with Roman to receive automated emails from 
> > >> sashiko.
> > > 
> > > Yep.  I'd be OK with an automatic reply-to-all.  Maybe some won't like
> > > that.
> > > 
> > > An alternative I've discussed with Roman is an automated
> > > reply-to-author with a cc to a dedicated list (we could use mm-commits
> > > for now).
> > > 
> > > Preferences?
> > 
> > Reply-to-author would likely be better as a first step.
> 
> Why do you think so?
> 
> Pasha, is it too early to determine how reply-to-all is working out for
> kexec?

It is too early, we have opted-in only at the end of last week.

Pasha
