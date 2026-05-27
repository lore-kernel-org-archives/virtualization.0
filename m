Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C242E000
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899354; cv=none; b=YdqebKhja/90sg1VoIkoY5niJDEYxIo0ne2C29W5jqaIOLhsgxf+7n2JPrgaXOblt2a+9C4cm7S7rrGBd78I1KgOcnMVLd07xyjC6uglMqyuBbAQknwfkiGuVyUx0VCmo84Mq/4QDvWesZgL2bWjtUn8HkszoqTlB0ABPkfBLtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899354; c=relaxed/simple;
	bh=MARgWSB2JRyHiWTRwBhBMqTryJPPS2jchIS4w1LrmWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoZndDlgTCj0/ydjq6vX7P1rDkpjkN/DvTgd7JNGbqwE+uItgb9lVj42q50SOWXcaWxUxpp80H19zhzWwFQukk0QhuIsYaAq1cHGVIyGFuqV2uzMR28ZQn3ZDZnp8RalYR5C9KxdhH9h+036Dkvqh4RiChiJaBhtIFFwmixVtm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwxFkqen; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwxFkqen"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49050bfe053so23852215e9.3
        for <virtualization@lists.linux.dev>; Wed, 27 May 2026 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779899344; x=1780504144; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp8EUEG6k+uQx75sbagyQs35jMaojHEjO5L3ntgLVNA=;
        b=iwxFkqen/hN/kYD3TU9/G5k82rgdQBXWcSvnQH7FIbH3WCb+3IBEIF8KCoz/ApqT3p
         aZ/h5P3FZsP8N6D0AqdkM2LiqvRRps4PR1UucGf/zokrek9JBCNh48HM7pUruOpOMTuc
         XyTLa2typy3tE2ePRSXxQHNHIuhPrjSMN/Recc1exlX0wYkXZ1EsEzC+xc+lOWUHrjL3
         WlSq0n5slaBi8DdBBsU2HsEhEbMMwNuqof0l+phBIOQn7OnPypU3YlgnLjopBTHxMeKW
         IYe63v3yiZUVfrijt0vb9dOdM2WbQR8fbNaTacR7KRlmo3+v9pHaC579uZzpXi8dJ1uA
         g0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899344; x=1780504144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp8EUEG6k+uQx75sbagyQs35jMaojHEjO5L3ntgLVNA=;
        b=DZrSeBD8PShIAN3M9Pifa9n9S1ukWoY6XXrudvWemynVsDA5XqEOUZ8JYG0JGc7tZK
         k8w2KOBjBRE/2QGAiMRMKKM2AVEPVhslF9mGPHGJz1nFB+UgkE8AAHobYgNEgBaFEcaK
         9HfTotFCAoMqYbe2JrXY3XfI9RSwUfqyTZwi+0IJNSbET1RunqXBn0YO4GIplxM1k/Xa
         hpjMi2hiLXO7Q/FZ4waHeLFgIj6N/w4wYq4IKK2m53nKLGTRCuNU0XHlvM2RQIP8G1d6
         pJSxOTtyNz5U2aPYOLPNns95YzlcdY6W5gu4p1KL6KgDukhuMZrpe/XT6XKQIBFwT3Ea
         QR5A==
X-Forwarded-Encrypted: i=1; AFNElJ8/jZyqpUuot6+gTvt07c8StA0sFjCs5lNXQAshnssvgU1KAo9L6vZtJE3bc/E9RIBdxxp9iLHVB5I+WRyuqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc5Ku+ebY2nR0v9EueisaeLoCdTZAdRbzn9A7uMIkdWqvuLgBq
	z5e/7vRzI9gG80PRds0DpPshdZrXdBwv/f/fRu64BK/WTpR6ERBDXKykO/7uuX0AWg==
X-Gm-Gg: Acq92OG15R/MNqFYddgyMdPC/d4iTiwWW26SfzpaIYgrHNhSAMUIQ0DAsIORKlAjAKM
	kMjPOOYwrO0SB4671rJZSVocIOgTNoiDPEf5cWx8or90LBN2Ev2Fl5VkmMk8P6vdzRflA2ZEBJC
	RWohymmR1ky08spikPrdakgx5VH6JzhBLCA81Dw2ESdYtXrb79IXS28rV9K3IXnKRQbtjj+Y/TJ
	elkWmQqp9iuF7M5vGV1yCuB8KggwfgIE+2S9GdP/uxduOF5Gyf6hMLdR3OnfTURZZyZ4I3kWBM9
	Rp9sMG6UvjYh5SuVe6WQ8sg31ZdfDEfNOgqCK3vhh5SFF25YE3olfEyDvQhyRkqcQv4uLTrqner
	OBsHaI1L4zj6JH2D5kK1tvOlwmJL0jbOecICiYHTC4HJpZ5bkb5ajPlPpIkm2RfZqWl8gppCHbz
	BGa3uPKbdmWpR0ENZb41KXHkA1e934hz1Y1apnoDOONf3ATzrPANnjtUM3Ihlh2N6hWnbtX9YTJ
	TSx5Q==
X-Received: by 2002:a05:600c:45ce:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-4905cd8d33emr244688485e9.15.1779899343733;
        Wed, 27 May 2026 09:29:03 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a160sm466125765e9.9.2026.05.27.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:29:03 -0700 (PDT)
Date: Wed, 27 May 2026 17:28:59 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	thomas.weissschuh@linutronix.de,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	Oliver Upton <oupton@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [patch 05/24] KVM: arm64: Use ktime_get_snapshot_id() to
 retrieve CLOCK_BOOTTIME
Message-ID: <ahcby8senHsmpOBm@google.com>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.070087856@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526171223.070087856@kernel.org>

On Tue, May 26, 2026 at 07:13:53PM +0200, Thomas Gleixner wrote:
> ktime_get_snapshot() is replaced by ktime_get_snapshot_id() which allows to
> request a particular CLOCK ID to be captured along with the clocksource
> counter.
> 
> Convert the tracing mechanism over and use the new
> system_time_snapshot::sys field, which holds the system timestamp selected
> by the CLOCK ID argument.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Vincent Donnefort <vdonnefort@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: kvmarm@lists.linux.dev

Acked-by: Vincent Donnefort <vdonnefort@google.com>

> ---
>  arch/arm64/kvm/hyp_trace.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/arch/arm64/kvm/hyp_trace.c
> +++ b/arch/arm64/kvm/hyp_trace.c
> @@ -51,8 +51,8 @@ static void __hyp_clock_work(struct work
>  
>  	hyp_clock = container_of(dwork, struct hyp_trace_clock, work);
>  
> -	ktime_get_snapshot(&snap);
> -	boot = ktime_to_ns(snap.boot);
> +	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
> +	boot = ktime_to_ns(snap.sys);
>  
>  	delta_boot = boot - hyp_clock->boot;
>  	delta_cycles = snap.cycles - hyp_clock->cycles;
> @@ -118,9 +118,9 @@ static void hyp_trace_clock_enable(struc
>  		hyp_clock->running = false;
>  	}
>  
> -	ktime_get_snapshot(&snap);
> +	ktime_get_snapshot_id(&snap, CLOCK_BOOTTIME);
>  
> -	hyp_clock->boot = ktime_to_ns(snap.boot);
> +	hyp_clock->boot = ktime_to_ns(snap.sys);
>  	hyp_clock->cycles = snap.cycles;
>  	hyp_clock->mult = 0;
>  
> 
