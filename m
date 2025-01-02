Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C0D528;
	Thu,  2 Jan 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735834877; cv=none; b=d7xhHgThMTuCD41yw3da8twAgi3JqitjUTk3ZCgHjFrdCr+JB2trXNPqgSRyRMnqzH/nYFYSOZSqYm5hWdozYKoy/0v87HE7MJzK9bf12qVKv123BZdqcR7Y/hN9KIYkJDUMdVhugsF+AWbctrKNDgMDNry3oTM6+ljnsDG4lx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735834877; c=relaxed/simple;
	bh=dSJv3kAsx4e/jI21sZlJ4yX2VorXsrGLdIC+nkDYCUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF6/TKWxwkyCDllS65jMM3y6bMNg0K/ygv7R0OieZhets9GErbXdZhVjiiEVDZbLkb7wxnw5dWdKLe+wCy3FVMNHZboXm3u+jIJghz92Eo/TxXYCSWmaMHqz67PaIPsGubTrLd/4pUhsEJZf0/eQzuxnAM22lrLF42kcQHGuVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOhBeuCs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOhBeuCs"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e0e224cbso5788135f8f.2;
        Thu, 02 Jan 2025 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735834874; x=1736439674; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFwagoQckg1x48oSlTADI+AZ0xM8gKp36cMYG8nIBr0=;
        b=AOhBeuCsxqO+uJcM04qJpH0yzMYZ98MgbjdW17peIITd819+RbhHUSPQfmx+KQKNf+
         QnHttnLUX46xGWqqf3PnK62enI7TOr3fTNs97gk7oBbZwslRvjfvkvCyRf3RAi6m7Qh2
         FZJ+bjDhBoGQw+VvRbUl2KKQ9M77a1KLFKlkOoAJMs6l14mO2u+jpPNp/0/mWP99w1UL
         2/dWOjEilFpuMs0oqLnu2PihQ7zix2xm6ojLtd92vY/fwtxAU0OgtJoWNr272+eSAYD2
         O6HLpZVLmZmneIn8fMZ0WNPP5Wg6/B5W/6X38L+zBc5qD3qWO9tMZThBrdqh+hNly6K1
         QwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735834874; x=1736439674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFwagoQckg1x48oSlTADI+AZ0xM8gKp36cMYG8nIBr0=;
        b=KRY2GX7SI1ljo26q8bpjAWbo13t7NCQPHvruY6t4cenYti0/qX76N3hLLlEUXoYYbR
         PUXiIe6SDQOtEN+/Mz0VRksAKphr2IInRlSwwdnLCZavKjnFXdxQiJ8TD0HPtOePbc3+
         R3fOFHjPcoOtoPf1DIXnTHoqV7KPrVadKj2NNA7hHsR1e66YGFd6Jd5mgeH9Z6wtMgUT
         95t3gnHGP5piIhhJl1fzwxOdlTpm8peNBLa8pFN8dlu8D13Kyx5Uic1xsvWlMP2Nng2X
         cSiN81S1RER3P9Y4HlU9dxP4qIIyUNIGre7EsuC9WOJ4CzYtfQpGXqKHgX6Y0yO+waBI
         ZYMg==
X-Forwarded-Encrypted: i=1; AJvYcCUYxkop7x3ljjWztg3e+jxGUFsBb0VaM8Fzv29LkGlFvgGVbq0r2W6SbilNYnuFSvQFW/PiV5rnyKhnF9EaHcQ=@lists.linux.dev, AJvYcCXNjbnqNKg3XdFET4orw4MDispfxWssndL+Rxhs59V+roSGoSHIvjdElEJpCXmc2R2SeZv4Xj2Gj4EO@lists.linux.dev
X-Gm-Message-State: AOJu0YzDW/4c1M2FWCcpsrvU3fUGGoUJZ7ik2dTz8WYwB02tH7vE6ONC
	Np1gWjydXcH8Mf2JKOf0zWs1A9lJtGcA9kMvaRbi5LqsrUk5Osq9
X-Gm-Gg: ASbGncuZlPV37RKKdIG+U3iN4JlSxzgXFRds0jet1Iatue1Krl8xFRgT6KMGkxgASWx
	4mnvInR30ihARZ0ZTeEKRj51AP09Jj5MgPBn2qRB2x63b6oRpJcepBuDSKg2imoUWF9+wpH2Q5K
	/yR2f1hhV90r+g9Kye3wfGJGoDjaStrfEmAIZKk461deNbBCgMfGlMnHASU3a7DXOQI+guQm8ZL
	tjrqeNIEthweKrAMjtZfMPK4WRQqrwPiXR/53isOUKXU+gtgy0s19Y9YoSfDuOAM85yR7gb3gJW
	sMhS64qMpfmsSXG25Dd4
X-Google-Smtp-Source: AGHT+IG0AunmMSQFcstGX2xexmsNqbQEnotP3JgjDGhHiAOcDSrfECwecZI3LFYSIzW+tk7K7kLpPg==
X-Received: by 2002:a05:6000:1a8a:b0:385:df84:8496 with SMTP id ffacd0b85a97d-38a221f2ef4mr40402238f8f.3.1735834874159;
        Thu, 02 Jan 2025 08:21:14 -0800 (PST)
Received: from hoboy.vegasvil.org (89-26-16-1.stat.cablelink.at. [89.26.16.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c848a47sm38031656f8f.62.2025.01.02.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 08:21:13 -0800 (PST)
Date: Thu, 2 Jan 2025 08:21:11 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Peter Hilber <quic_philber@quicinc.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	virtio-dev@lists.linux.dev, netdev@vger.kernel.org,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	"Ridoux, Julien" <ridouxj@amazon.com>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH 1/2] ptp: add PTP_SYS_OFFSET_STAT for xtstamping with
 status
Message-ID: <Z3a892mBOSRl6BlN@hoboy.vegasvil.org>
References: <20241219204208.3160-1-quic_philber@quicinc.com>
 <20241219204208.3160-2-quic_philber@quicinc.com>
 <Z2WLGHRdlsRpT6BL@hoboy.vegasvil.org>
 <wcxdbqhoe4cppukyy5rvkq5am4ht6wk5u6d6g2k2swqhidjw7i@6nar5vuusm35>
 <Z2ymZuiFqY8mxihJ@hoboy.vegasvil.org>
 <a352mltlizneonxazn4bffydn57fyudrc3zougii2rnatg3jga@3yagssaob5sb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a352mltlizneonxazn4bffydn57fyudrc3zougii2rnatg3jga@3yagssaob5sb>

On Thu, Jan 02, 2025 at 05:11:01PM +0100, Peter Hilber wrote:
> Would it be more acceptable to just announce leap seconds, but not
> whether to smear?

Up until now, leap second announcements were handled in user space,
and the kernel played no role.

> I do not understand. Is the point that guests should decide through
> another channel about leap second smearing?

Yes, that would make more sense to me.

> I hope there will be some feedback from third parties (at least related
> to virtualization).

+1

I'm no VM expert, but I'd like to avoid tacking things onto the kernel
PTP layer, unless there is a really strong justification.

> For sure. But the aim of this proposal is to have an interoperable time
> synchronization solution for VMs through a Virtio device. So the idea is
> to include metrics, if a consensus on their usefulness can be reached.
> AFAIU it is difficult to bypass the kernel for Virtio devices.

Providing clock metrics only makes sense when there is some choice to
be made based on those metrics.  If the "limited" VM guests don't even
have networking, then they have no choice but to accept the time from
the VM host, right?  In which case, the metrics do not provide any
benefit to the guest.

Or what am I missing?

Thanks,
Richard
