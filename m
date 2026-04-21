Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B0382387
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756517; cv=none; b=t258endC2OTC8qqGHLQjGF8QIxyHOT8ncoqWQxvghtqT3vyl/9JH4xA6KJpOZekU5WWPS1UcrVFv95jfyij9F9j/ABFFz6rtdAEm48w6HqhkmLq69NHEhXkB3pF/DLlheFbJsPZqvSksqANM4iQk5HZYMp1LKktq6Hud+0l9VLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756517; c=relaxed/simple;
	bh=wwmZXFfudo6vtD8Qyo2Fqwkv5D5eNldWMhPAPtQB018=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mN5j/TrQjFjkySBakrWbJlSjykOeQxNIHPJZtEbDR68LnECabPz9l8NR7/ffEaZI/dIPMtHIjpHL0bKgIeSf5STGmwGwMQami5UYkuzD6Y1LhO/1QDARjeqFRrqWjMVQlPqAUtwGBlQR8DcXAQNQNocGQ6CT4g53oL8GZN2Lpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZEVvcrW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZEVvcrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
	b=iZEVvcrWvfy54CNb3lCrxD6hQa/7k/kJMuZD4OJqyfMnl3Wm5yOu/DibVHSoe78qSCw54B
	owNWLa8X1Whru0/AY5vXIAAB/nPOSCvb3bpgEumcMBpEtI3FlyKZPOS79U8dTmhqPufRpc
	3uhW1H/3BHttGEZLWxtZCdILUOcrANY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-dClfj6fEP8KjJZFaMpFnwA-1; Tue, 21 Apr 2026 03:28:32 -0400
X-MC-Unique: dClfj6fEP8KjJZFaMpFnwA-1
X-Mimecast-MFC-AGG-ID: dClfj6fEP8KjJZFaMpFnwA_1776756511
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso3848572a91.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 00:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756511; x=1777361311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        b=m/pERLTM2YB6fK6/wjLNhq6PUxp+0MOeIBzobMZQC+qIlbuVMVLLHcJ0QLzistW5hI
         cn06jguwFDzndbJFKvjhI8uFij4jFcBeh0IPOsRcf6Bdt/NU11xKv7WzMeWXHacu5hQA
         ChfanuFah864jVgCoeeuQErEZ/TR9DKy9Kugj4sinIwkry3L0KTJxrQVUsA44yW9sZOQ
         vj8a5nSVR5eMFUwesdIvSFQ3EyASXqW4SHq9U8pyyfi5ekJfZu763elXDXyMk1GWiUcV
         ifpxgKOE5bFrH5pjWrl+Yqut6MI+3LBKJWVG67ncLVwDECidvc22Q87ldCzScYdsBxvo
         pfcA==
X-Forwarded-Encrypted: i=1; AFNElJ/14roMA5oo1cgkkrLKP+cFIx70gqwPTNQ8XJ0d97OPLg2TIsBu2n5h2jlJOMlfYejKTH9D0aXGUAtQ5rjjGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh86a3ZbaCS4G689W/LgLOFvs10ugZDr6DS5qzUrpW3osfOWZd
	rk/KHezIjrEN/soH8nBzrkuaAHV+0ltICefXavipoVVap8T5Nqctq7eRVxyzfBdiWpdfdR7SHhF
	xVsF2yAW6VoMlszXjmpnukNTmOSW9aFnttyjNAfE9D1ptBDGriLAUH7+E6gW058sfekNjNLW9rA
	sRhFe3Y9vU0GDEMxgfGZQNO4RrkDSgTuMSYRluknjeQuc=
X-Gm-Gg: AeBDievZu9aWEEj+3+cmBg0XVs0HPEIcUrED0FFMpIaWyYKg5yxoCnepazvhoA0xQy3
	hUCFcQAnsbdskjIJbbTueSjq2E631zsB4zTOUZQzGoxz2ODApfNkGKVa5WK5EwMZjB/PNunRewy
	Tf+sU8NW1yFUwOYditXFmF3EOdQ5ONo5jQOTpdM3B05CJUgAI7t0hKYleT43OA2IEdy659dDqHs
	6HzcAC7rj8yyMM=
X-Received: by 2002:a17:90b:4d0e:b0:35e:5ae3:298a with SMTP id 98e67ed59e1d1-36140462ad9mr17177838a91.18.1776756511189;
        Tue, 21 Apr 2026 00:28:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0e:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-36140462ad9mr17177809a91.18.1776756510684; Tue, 21 Apr 2026
 00:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260416191433.840637-1-decui@microsoft.com> <177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
 <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Apr 2026 09:28:19 +0200
X-Gm-Features: AQROBzDJwpjJV5oYDv9Ov-Jk-nnVA6bAoKM78g-QgMrimqa9KxhcXRiVCwSyCjw
Message-ID: <CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO
 for FIN
To: Dexuan Cui <DECUI@microsoft.com>
Cc: "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"niuxuewei.nxw@antgroup.com" <niuxuewei.nxw@antgroup.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>, 
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RvEe1qboFXtlIarO7_elHaYz_KTr7wQbBJzv2t-Ot6c_1776756511
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 05:13, Dexuan Cui <DECUI@microsoft.com> wrote:
>
> > From: patchwork-bot+netdevbpf@kernel.org <patchwork-
> > bot+netdevbpf@kernel.org>
> > Sent: Monday, April 20, 2026 3:00 PM
> > > [...]
> >
> > Here is the summary with links:
> >   - [net,v2] hv_sock: Report EOF instead of -EIO for FIN
> >  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=f63152958994
>
> Hi Jakub, Stefano,
> I'm sorry -- I just posted v3
>     https://lore.kernel.org/linux-hyperv/20260421025950.1099495-1-decui@microsoft.com/T/#u
> and then I realized that the v2 had been merged into the main branch :-(
>
> Should I post a new delta patch(with a Fixes tag against the v2) based on the main branch?

Ehm, I'm not sure about the process but if it's merged in net tree,
maybe we need a follow up patch.

Anyway, let's wait for Jakub's or other net maintainers' suggestions.

Thanks,
Stefano

