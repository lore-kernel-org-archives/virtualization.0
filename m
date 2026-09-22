Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1642E40F
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068983; cv=none; b=EuCeyv8P/38xLDe4oMbAfe9EVjrEAicNIr4Yjqk1N+0YYwMR9Sy9NUcow+JmwLsnIlGA3JdrBgA+G91hrVTddUeokAeK8lnxSVQpdmcyQJfmYx0A27DMUs6Ia0Dsz0TWZ6twQ1Ee+2nPGAHW5vRsfHxCytkyQxoZz892xEFQxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068983; c=relaxed/simple;
	bh=0MlNWyi4hCXVJVEWimjJfjTosZLJAjP+I7BsGPwrE50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SRwwNIvQ2YZUvidauEgetImQP1rDJq67q4Csrxt/1Z0l+Ew2c0bBkzuZgywrW3nwfcEk2SduvX9O2b3y9gMwzI0gSnknuZtmkzJuLt4ZAGS8na75Qrez2AIRG9kH4KZI7p9N5AsX2RKbPAFZ9NjgcLYXaPS1HbPqoY7XJ1Fjdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JojTQ7H2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JojTQ7H2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790068979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rpAVQ1UlV+yVL/E0QTVtJ9fL9FL/1XwCUiRQoK1VFSk=;
	b=JojTQ7H2pBNe5yFMbDwJ7+sE5gEhge6YPdwq9ej4Yt86p1x2QcWM6bD06XTsFoWf7tAVN2
	CaGMUgYRlf0EtK+aUlz2rhsUFsRLhea0eW7UobzvVEhJ9OiTZ+qukkLs8jNDdT6m1gu/4c
	g/M6nm/lWMVuDLLXyAfSAPjnGRN4NWs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-Vj9rVnmmNJijPll8ITp0ZQ-1; Tue, 22 Sep 2026 05:22:58 -0400
X-MC-Unique: Vj9rVnmmNJijPll8ITp0ZQ-1
X-Mimecast-MFC-AGG-ID: Vj9rVnmmNJijPll8ITp0ZQ_1790068977
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so28970905e9.1
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 02:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068977; x=1790673777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rpAVQ1UlV+yVL/E0QTVtJ9fL9FL/1XwCUiRQoK1VFSk=;
        b=Vm01wN5aTBoFMQG+IccB016x8YnHxgdAL5ecBCKG9tXDl8vbZGnl5Aba5mkuKSUoEU
         7jXeF/aEdkRo431R98+L6rTTJrZM8ICp+KBUMY4GY9E7bTQYg6Ltpitaoy6MeoZMl3Ty
         o7zSO1Hvu2Ic3W5o/YBifKyCPF0dRRjQ+nzhwy1d2V/AtlEpFJ2PusQi4EQFAnebYSbt
         T8qbw/XOKuYFsryQFuOzxK2+PPpWv6c43/yXLGOwYQWXHhLRdzT+qELANsDc6LjSmXQm
         FjxstKY5ZpzeWRcOaGA+Kywfu3AtRNvFXYvi3ty8UAxYke1DzaVjg+jWMfI528LJlxyw
         qzzg==
X-Forwarded-Encrypted: i=1; AKwUvBy8W9XVAmv7Usx7jDS9xNGWLTKDlv8uKe2r5JIbeX/51hPWZVjzN0krIDPuStrwktfqo8jjvuMLqJYI7CxRMw==@lists.linux.dev
X-Gm-Message-State: AFuF++kNgWTa4B4lTM3tjhdevgLGIo6iicmB8k+HddLXQauRIS0HSSTi
	Cdk9OANJ6LOmv26NBPOfhMMUhpVj1/bXmDmypPT61RerU2JTGhZlFsLJW7gVjc7eijdETgUtB+0
	lNDdYo/AWF/wM+iiSMjZJdhyG1+ZH+5vpl7ArGOApJbHFpAb534mU/5cCtO3X7N446ANr
X-Gm-Gg: AYBFou3d1KXMGueY9I6VE7oVmn5ZYJJJClskPSXGB0rnhnmPsoCUCkBoPHUgAwHiQB2
	1wpKSvhet9It+xC3xB8x+uUrsoirzhX7HKaOZq64bYzATCp336uO+Bh+eZ0Wy5e7T+dRHmdEAnE
	F+Ob/5A8MAhUrqjrGNkKzfgNuWB43dTjlFzPhNocOPhnoLC/aebLL3dreUsePJ3qEIToIlOQFBH
	g56K8Y/UFqm50sb6VWQ0O46inHzOWMSuODmPoSjJvxkeQz7RHzcDxppu8+2To8pXj8xYsiW8eCR
	Usjn1jQ+zKz/iBYOeEvvu9I4pMGoUFT0MkMST9tn3CjqjO/0wLuQkxDuw8duzp20Bwf6oGKiVcp
	Rpmewf9VinSofwUe/7b3vLio=
X-Received: by 2002:a05:600c:a013:b0:49e:6891:27a8 with SMTP id 5b1f17b1804b1-49fc574a9bcmr167312765e9.25.1790068976722;
        Tue, 22 Sep 2026 02:22:56 -0700 (PDT)
X-Received: by 2002:a05:600c:a013:b0:49e:6891:27a8 with SMTP id 5b1f17b1804b1-49fc574a9bcmr167312555e9.25.1790068976311;
        Tue, 22 Sep 2026 02:22:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ce2623sm79760035e9.13.2026.09.22.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:22:55 -0700 (PDT)
Date: Tue, 22 Sep 2026 05:22:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Baorui.Liu" <baorliu@amd.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	saravanak@kernel.org, jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev
Subject: Re: [RFC PATCH v2 0/1] cpufreq: virtio frontend to report host CPU
 frequency
Message-ID: <20260922052231-mutt-send-email-mst@kernel.org>
References: <20260916073735.541-1-baorliu@amd.com>
 <20260922090224.430-1-baorliu@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260922090224.430-1-baorliu@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cjBOfFqxEvMiVICk6nNNXGNa4jpZWFdYP6bWAjlYLd8_1790068977
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2026 at 05:02:23PM +0800, Baorui.Liu wrote:
> This is RFC v2 of the guest virtio-cpufreq frontend.
> 
> Changes since RFC v1
> ====================
> - Fix 0-day kbuild error: cpufreq_generic_attr is gone on current
>   linux-pm; use cpufreq_freq_attr_scaling_available_freqs.
>   Reported-by: kernel test robot <lkp@intel.com>
>   Closes: https://lore.kernel.org/oe-kbuild-all/202609191437.OaXd0Blz-lkp@intel.com/
> 
> RFC notes unchanged: experimental virtio ID 42, hardcoded OPPs,
> sleeping .get(), QEMU backend is a separate series.
> 
> v1: https://lore.kernel.org/r/20260916073735.541-1-baorliu@amd.com

could you link to qemu and spec series, please?


> Baorui.Liu (1):
>   cpufreq: virtio: add driver to report host frequency to guests
> 
>  drivers/cpufreq/Kconfig          |  14 ++
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/virtio-cpufreq.c | 240 +++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_ids.h  |   1 +
>  4 files changed, 256 insertions(+)
>  create mode 100644 drivers/cpufreq/virtio-cpufreq.c
> 
> -- 
> 2.34.1

