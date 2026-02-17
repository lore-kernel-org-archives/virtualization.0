Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA5136C5B2
	for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340926; cv=none; b=pIVK6wk2s671ZpehF7QUayKw/Yc7PqfjmSimOXN1gt1svYhAcUBEWwVQNswTxqhtvemK/GvSo9Gvk6+rl5r953FK9z6LUKpCM6e2tBbQNrd6/pM/0qXQwVWCo+pymRCjXZNi+kC015xnUtyIHwAYnXndsSKYMNZThm5XbVoR2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340926; c=relaxed/simple;
	bh=FATg9XsSiPlYwAbae8L/USKuKRBil6Mn8gqbYCmEG2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fa+2Jn+HIC2KmOqvFvrlqrULnCCeHsin7AkIMz3H7PAEjXxFoupa6vxqRVkNjoEmQ3gEzkKRjH8QpPDUz5TbKCZrVGT3LinJVB7ZtASiy1Xn5QcgZlG8muh/Wd6V87f6eawTnxoM+wR2L1Ful0IRPPvYnQMh74N5bymB2JcuRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvIR4Xa2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvIR4Xa2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771340924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEc67c+eucBHPlMa8Z8GafQvzyfH5CJQ48/ZIvcQG9w=;
	b=DvIR4Xa2UBXNvZfVQYJO07QOSLpI6nzQAapaS1fU15OuzIAfjiO4nNnvkQ6k7M3na8OvtE
	Gsmoz+aeWuYw61WjPynjf9B1ULdyKHHC2Gove/VsGa66uOWcWYqoDtEu0WWALRiV/50hN4
	o0Eo+ulmiga0gZrJMnav3w914Zfbukg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-ea060KvtMzqxFixLu5c3gA-1; Tue, 17 Feb 2026 10:08:42 -0500
X-MC-Unique: ea060KvtMzqxFixLu5c3gA-1
X-Mimecast-MFC-AGG-ID: ea060KvtMzqxFixLu5c3gA_1771340921
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so50580915e9.2
        for <virtualization@lists.linux.dev>; Tue, 17 Feb 2026 07:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771340921; x=1771945721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEc67c+eucBHPlMa8Z8GafQvzyfH5CJQ48/ZIvcQG9w=;
        b=Yhhxy7akpGWOwZ8U7J4ManT/qXUzdub1SqfVQ2v+rAHLrV/+Z/Nz33kxqVrItYwQfJ
         AFypkcCh0awLYgk7tG39kK3teHF7zTBr85wlC4Qg1fjZkJstPqKbBn//06no1vpzZveq
         UBRQcWzv8RDaUkkzKm64g/miRFXTnBGenwieUhWfrwcHdvq4Ob4UZC2DuhB5ATlxwFE8
         YkHauaOHlYfIde+6Whjea7IDb8dSoWcqxJ/ymCfh44Yy25skv3iEuCbzYWXa4AMeZOTq
         IixgZb+L/BWyWmf4jbCY1r23wX2vbqW2HurfW4LgGFbaaxRRetP9nlACKfWg/xzzwtL4
         Rxtw==
X-Forwarded-Encrypted: i=1; AJvYcCWgGmVKpxy1NXCnzeLQlifaEnX6bjLuVw8twQEtWvFCnup1zBQZHcPF/AnzWVHLBbr9OfD3bjTaO0hoJAridw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqwekWw70XtgEMZaFJnvVHN5QhdhW3cyDsjkofgWONbVPcW/58
	K2kQuIJSx8wJOZj7niRxuV/LOczmCAADzxBfVgKq9uUTCkwLQsjosQWmFW+WVC74SHHDRFzxHCa
	RTldu3vCm1Bhhm/q8aLDKjvrC2jT0pJPkvQc51yj8cVQiq4WOyTG9LhtYNtCO714m7wWd
X-Gm-Gg: AZuq6aLgfp9J/ENaENiI94eL5aEvcMUU/pEWzbSeqNIP9vOlfYzi3RoFqRl3OU5OoW0
	UwWB2OrxBMV+AgiNWfWf1/lA1jZxjNwwl46hqu2LoDMv4GyC4TvDOmF/iN5npy8zgZsLctQIvZA
	VUDNlIMsBjrQ14CU0qVst6BidMbt80GYN6+NrRNThQkTnjiVxQsLGlIVvPct3NuavgTYY+W45fY
	mDOaDmXxnvdcsLkITk4iJK6mvIWr7efVzw2shW4H6b105IDeko9+bkySiy0DRZwJpzXo9an75V9
	PYaBaoW8gYnsqSGQWDlnVonPfVBZLCABmE39G3mDGElSfb8uq+W8rxmsjm/NXl3rA9B5MvCG+pj
	34MQ0s1z/sThh3EG1SkgwXc3xzmjgrjdGbcxOp0nqnhjW+QfzCT6n7gLc0uGNlol0DBuXj3U=
X-Received: by 2002:a05:600c:1c1c:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-483739ff8damr256414575e9.7.1771340920691;
        Tue, 17 Feb 2026 07:08:40 -0800 (PST)
X-Received: by 2002:a05:600c:1c1c:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-483739ff8damr256413865e9.7.1771340920135;
        Tue, 17 Feb 2026 07:08:40 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b64b08bsm102571985e9.6.2026.02.17.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 07:08:39 -0800 (PST)
Date: Tue, 17 Feb 2026 16:08:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	linux-doc@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v16 01/12] vsock: add netns to vsock core
Message-ID: <aZNNBc390y6V09qO@sgarzare-redhat>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
 <20260121-vsock-vmtest-v16-1-2859a7512097@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260121-vsock-vmtest-v16-1-2859a7512097@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IObCewGOxyMiBzn18q0D9D_y86XwDVa6-_gMFiR2UAk_1771340921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi,

On Wed, Jan 21, 2026 at 02:11:41PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add netns logic to vsock core. Additionally, modify transport hook
>prototypes to be used by later transport-specific patches (e.g.,
>*_seqpacket_allow()).
>
>Namespaces are supported primarily by changing socket lookup functions
>(e.g., vsock_find_connected_socket()) to take into account the socket
>namespace and the namespace mode before considering a candidate socket a
>"match".
>
>This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
>report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
>for new namespaces.

talking about this new feature with Daan (in CC) we were discussing a 
possible change to `child_ns_mode`.

Currently, if two or more administrator processes in the same namespace 
set `child_ns_mode`, they compete. Obviously, after unshare()/clone(), 
the process can always access `ns_mode` to check if everything went well 
and eventually retry.

Daan suggested a more conservative approach, allowing `child_ns_mode` to 
be written only once (a bit like we did in the old version when the 
child could change the mode only once). This way, most users who want 
isolation write `local` in `child_ns_mode` at startup in the init_ns. At 
that point the user  and can be sure that no other process (including 
administrators, e.g., container managers) can change it, so all new 
namespaces will have `local` mode.

I think we should support this option in some way, because it seems to 
simplify the user space in most common cases (ensure isolation). I see 
few options for doing this:

1. Change the behavior of `child_ns_mode` to be written only once, but 
this would limit other possible use cases where `child_ns_mode` can be 
changed more than once (I don't know if Bobby had any in mind).

2. Add a new sysctl `child_ns_mode_lockin` (or something similar), which 
can only be written once with a mode (local or global). A write on this 
will also locks `child_ns_mode`, of course.

3. Add a new `local-locked` mode, reusing the same sysctl.


If we go for 1, maybe we can do it in 7.0, or not?

2 and 3, on the other hand, may have to wait until the next release.

What do you think? Any comments?

Thanks,
Stefano

