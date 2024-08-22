Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58E16D4EF
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337391; cv=none; b=ru85WI6Uf+4wYOyO1JhoRih0GOWXOPMlRpY+j8ulL7vohNmrwxhouIU9VbItsO0EgZtpY1Ne7CdpuZYKb9D3+iMRaV+VNq4mgx6vxPufPCbAu5gjwjkNyPaVToA3AmT2f1UrraeumBJImYn5yGKTNzA7v1DrOZP9xBIDN5zIoTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337391; c=relaxed/simple;
	bh=uUEhmg6pIDtUAlHLce+UF+hZRMPcMz2Hz9KThbEm5GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reCqtCE7kZHlREZnwPVFPgOPNwBbcj9aB2QgwtZ4g96Dvb5bSyCtNFh5mgGRArHAiHAjqLxuQnvlgsBXYBTlssgC1O8B+Kj7jPzlLeMVrDc1rw71MavI5QRDzkg2ruQ2mKnVFjMDOQDMtrg6I/cJPEd+ML+XHpEmvVBWeit4gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQBIOb8n; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQBIOb8n"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5de0e47b9so545919eaf.0
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724337389; x=1724942189; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BbnC8t2PJTnIbX+3XWfmLQvDXGHfT/Qc+/o6DnBM8k=;
        b=VQBIOb8nH2JSN3pajGLJrB/8sbRY6fxSzxWQG97vXaECpv0xY5tn1vKNobSenam2PZ
         PsquwfAEj3q5g2T+8bm8oRdRff9Hwoj7+kid3mijE7QLHEiW79OtYgKXGbTG/47t5YS5
         ZDCVEzlyLik6kEaJ7BAFpbYKN2Dpsnhh/wlb5kbePWfFvYVfHkp1YEfis1Y1ytYDkJrp
         ILUKlQIIYlmJ1UydojyPFQe9qkZ1h2nlPVqlKsKBSgvdEntQe8iDZceToUW3hC/UeyDN
         xL2gOuoka27q+ob0iXjo2Kp5tOTtnfKgbXZa4JKg+uc3AxfN9TZdnxNE+CbHecBHhSt/
         jtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337389; x=1724942189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BbnC8t2PJTnIbX+3XWfmLQvDXGHfT/Qc+/o6DnBM8k=;
        b=IJlfUnfOU7p9XQtukku0jP60sLCvBDGvuRuzP+KuC0z+pQErmOqK6hflIRBh8mg4Se
         Krk7T3mZOVMGA0D8ppb0QWUmiMFiBYr3aCxEhwarN2UN6uX4dejJaJUocuLvoW7l8J6w
         czOWP90H3FDwJ2lqCJdHV1qtmXtDeuIJTcWwBAaiAnJFIoVkHoZFiCU54r2CYyxEveFz
         R0tOO1aWGT0/qNuys1PC8AiZgJQ0tZNSkt+itKO8atxYLbR8sP5F/sDuqB8OlLTFgDVB
         t+1bMQDnqBJ1ErDAcu1qAsSh1tl0nqjgP+pnlqPxyXjEbrKV2BMMXcxOIdwg4nmzwbha
         3IYg==
X-Forwarded-Encrypted: i=1; AJvYcCW8oVOY/k+rkvc2DOv0cJkY6GBZngJrzKaN6vG/WZzzoDfe34IFoiuLs2JGMDvXev9DUU4ZgzqpAtLsdslbyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS8pDTOspdShXEAsrVUs76sLJOAHWA2N6RKCWdGIeEi3hV+9tU
	ZhqLTVKhXQZ14CUDIpaqmDaCeDwR+FKYXWbb4yJvLFlGK8+EqeDM2xBIOf115Gb/XeBNI8lzaWX
	GQt1SKIBp522zYpPUmSQz3S+prKU=
X-Google-Smtp-Source: AGHT+IHWMxdwUMfLtf5zUA8aXZE4o5FfBDVwPtGUufuYCxo0BWl8ikb5XZ4xY7aL7CHeRE7eIyKQ1fqp6MKADgra/No=
X-Received: by 2002:a05:6820:220a:b0:5d8:f3f:b1f7 with SMTP id
 006d021491bc7-5dca0648d97mr6666875eaf.6.1724337388886; Thu, 22 Aug 2024
 07:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240817062449.21164-1-21cnbao@gmail.com> <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka> <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <9fa8eca0-ad4e-445c-a21e-aaabb6aa4160@linux.alibaba.com> <ZsbuwJPtRwr5Hi6E@tiehlicka>
 <e811aeca-b8df-489a-b2ee-96abf6877d8c@linux.alibaba.com>
In-Reply-To: <e811aeca-b8df-489a-b2ee-96abf6877d8c@linux.alibaba.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 22 Aug 2024 22:35:50 +0800
Message-ID: <CALOAHbDoTnzovaw2nmmywiZLxiVx+dJymG2znrWN1+=VSowsRQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Michal Hocko <mhocko@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com, 
	hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org, 
	rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com, 
	v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 4:04=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Michal,
>
> On 2024/8/22 15:54, Michal Hocko wrote:
> > On Thu 22-08-24 15:01:43, Gao Xiang wrote:
> >> In my opinion, I'm not sure how PAGE_ALLOC_COSTLY_ORDER restriction
> >> means for a single shot.  Because assume even if you don't consider
> >> a virtual consecutive buffer, people could also do
> >> < PAGE_ALLOC_COSTLY_ORDER allocations multiple times to get almost
> >> the same heavy workload to the whole system.  And we also allow
> >> direct/kswap reclaim here.
> >
> > Quite honestly I do not think that PAGE_ALLOC_COSTLY_ORDER constrain
> > make sense outside of the page allocator proper. There is no reason why
> > vmalloc NOFAIL should be constrained by that. Sure it should be
> > contrained to some value but considering it is just a bunch of PAGE_SIZ=
E
> > allocation then the limit could be higher. I am not sure where the
> > practical limit should be but anything that requires more than couple o=
f
> > MBs seems really excessive.
>
> Yeah, totally agreed, that would make my own life easier, of
> course I will not allocate MBs insanely.
>
> I've always trying to kill unnecessary NOFAILs (mostly together
> with code cleanups), but if a failure path increases more than
> 100 LOCs just for rare failure and extreme workloads, I _do_
> hope kvmalloc(NOFAIL) could work instead.

If the LOCs in the error handler are a concern, I believe we can
simplify it to a single line: while (!alloc()), which is essentially
what NOFAIL does and is also the reason we want desperate NOFAIL.

A better approach might involve failing after a maximum number of
retries at the call site, for example:

  while (try < max_retries && !alloc())

At least that is better than the endless loop in the page allocator.

--=20
Regards
Yafang
