Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200859;
	b=E0PiSMoIyrPl/1Ls64PSgMxAJtqkdzf+UhzdcDqkiCkP2hPTCs6ammjp+0aPC6l0XLPD
	 Hi6AlEQ3/l+rhnEdlPN5qk8fIwCsG9EvrQS6q1EFVEQCi+Xqel7WPIqXaqSf17LGzKmOw
	 hvPtuHVmGfQXEhzSUVQMRFi66HkbzSkyAYHcantNW+wrnXJS3DPDeDYcTHQVnJBixMiqe
	 OLy1NPYYY0pfQ5GJbiPC4K3uoGS+2sjF/sBREEKxaRJhz91l5mMkAlCufPYnFHU/6g8UY
	 akkHTlDzpRkKVn+K9Or9G1IHj7H1VBmfcwYYsHUEitk3w1aimdK+YV9DUxFeu/hYdig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2cDvgzaEPEJPCI6Ok0IK34cIag8JscyuYpBaCTCvSvo=;
	b=EA3MMpTgYe7x6gLb9AAJEKwPS7sytZZnMnO9+RcpWy1dOwJ6H/r9NuHuQ3kTFnOsPFkK
	 piWpNNH7MSxD64TMfr0gkHpPLwBSqTCRM0L2S+1+595RIru6/Cj3DzDjJ8D4loaskvlFU
	 y3Vu1tx9HGmMmuHNbt0oBeuh2WrRd9xTJ4WeCv1xehu1rNw+Vrdpw57sHKUd2GBOCPa3H
	 Qzuj02ph3BIqj/LF9SNbSiGigp+SslZjSZ97t+26LkGnSboRvTfEAiaqRlVyfnlvGTytd
	 CEBbn/zmIew8wSDBG4uhbGBbhK7cChcme2hrCEBX3947xlPPlrNJGpdiOmmcePNP+gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F1+J1JuK;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CF60A2623
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 18:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D6CF60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F1+J1JuK
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-949680e6d82so163312685a.2
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795200857; x=1795805657; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2cDvgzaEPEJPCI6Ok0IK34cIag8JscyuYpBaCTCvSvo=;
        b=F1+J1JuKXdu2Jsy1pAm0fxinsib3xUDh9dx8GIT2z19q7/wfHrZXrPaPXENO8OWi5F
         jQPmk1JVU4c2HeqKBzK30WBJlFo7jArzYb9lnXc0vJul2z9eIjqmUEkk3KU/wpZzj6kh
         Sgm48acdUMwDCXDpShGBcptS1oVF/NhfdswX7p5NUcvIIPQSOya8NaqMVxO+EwVfsAkK
         4IiZU4b8tGS3fjF1FBvQcQQNzUYk/mslI4xpHemNan1BqmPUijye4XW1OIo/Sqw/73h9
         rMvnMcyrf2rAESYGVUv1mP81stWksl6IL3ndDvG6wWXwKqOHQVpuXFLfpD0k/KQaFluz
         wDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795200857; x=1795805657;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cDvgzaEPEJPCI6Ok0IK34cIag8JscyuYpBaCTCvSvo=;
        b=BTBBtrAABDZ7a5SKjtr6XSEyzrtVU/Nf5AQjJE3TJ/QzB3uOatWNI8xCdQ3yFhTiX4
         4QiKncEEG5sTcneUiPjNchoEApIXuVik3ooj/4CTGVcNUIVYRROFMuRSKPhXNsBpRPD2
         3h+ni0XGUzXbPGWFNxbxPTyr5G49e6cDx3E0gvKqnBuEID2fwFlqTEVx4O7KvZw9HBpi
         UXbCjonXa5aO2OdBTeiD+mACIlon7WNQJSpxv0O4XmG++fHb9Io+3qqkKpXk0UdPA6f9
         E6rhvPAVMKOQ/zmN2+r2rPglFDPTI65h3G8sbdz3b+W/qbXK09YxVTJN3Prlo7alq5q+
         9upA==
X-Forwarded-Encrypted: i=1; AL+hErGMv5IsLwuBntvVY9nyciOD+2HzR1AZ41G9dgCUIcvlOJ9OVZekPkaRRBaLzYwNtcy9fxT5I/6JW/62bHAt4A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+X6r3HVJNMgWP42NU5s7X91Oez+S+WLHDr+4OiUjEU6hpPZIgm
	0h41FLjvSAHV1bebY3WfnynnW4Q1uhpxFb3k2FxqtQIAnE5bughfOzAjRPyQiKnR/7Y=
X-Gm-Gg: AYBFou2jN20PQ1cUxQcjRhGkeOx5a6Lp+lNZH+Mkn9woXtpCbjL4r2uZwzD30Y5Gk34
	t5acAL0iqhHFD6rc5C32fqIPP5i7poiFfDp4+nQoBzEupOHJ8Eg8Fg7fiqLTUqY9wwoArXrdKdA
	S73DwNkhvELBGfHynojqjkjUC80w4l8C0dtbegymdBddKA+gH+OrKv6/mv+TdTozA52MhTRMxBD
	2chA5gEYXjAt14RZLtRaKXSClnfKKaYz6Yp95y2EytvwLuop4Q6Zp1kLOx5gb+OWHUfSG6vf+qo
	UaNYh9UkMA9KFwQuljQOjLlLsYbUjpp/230a6F68wJc/LKezvo/cl1/1kQgewiTtwH/olXReY/l
	/JmB7SX7As5C5HAaSsrLTzMs9p7WF2Ar9ImuU8aDuYlBrOcAtsfcd4dojWsSB6Lx3CDJZyXkOv4
	Zt1Kt0gY6/TR3hkVc11WzpjShvREtgym3ox+2P0LxB8qpW9Hj+1fbqKoo9ITAnS2WsySWJdfVfB
	kE+q4gbiypHUfaqtDru2mag5+AVZXBeG+R7KhyOeAMBq58cFATI5LsrBditiu8plDZa3hL2Zbrj
	QIeDlA==
X-Received: by 2002:a05:620a:7008:b0:949:5fee:afc6 with SMTP id af79cd13be357-949baa07369mr665380885a.63.1795200857416;
        Fri, 20 Nov 2026 10:54:17 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm256798785a.17.2026.11.20.10.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:54:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUTkV-00000004ls7-3duu;
	Fri, 20 Nov 2026 14:54:15 -0400
Date: Fri, 20 Nov 2026 14:54:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, alex@shazbot.org, den@openvz.org,
	khorenko@virtuozzo.com
Subject: Re: [PATCH 0/1] vfio: fix KVM reference leak on QEMU CPR
Message-ID: <20261120185415.GA1133597@ziepe.ca>
References: <20261120154730.882393-1-andrey.drobyshev@virtuozzo.com>
 <1075a283-b745-418b-b49a-2dfd41faba3b@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075a283-b745-418b-b49a-2dfd41faba3b@redhat.com>

On Fri, Nov 20, 2026 at 05:52:09PM +0100, Paolo Bonzini wrote:
> On 11/20/26 16:47, Andrey Drobyshev wrote:
> > When a VM has a VFIO device and QEMU does a CPR (CheckPoint and Restart)
> > live update, QEMU creates a new VM and keeps the device open.  The
> > device holds a reference to the VM it was opened with, so the old VM is
> > not destroyed.  It stays until the device is closed, which usually means
> > for as long as the guest runs.
> > 
> > It is one stale VM, not one per update.  It is also visible: after
> > cpr-exec the kernel logs "kvm: debugfs: duplicate directory <pid>-<fd>",
> > and the new VM gets no debugfs directory.
> > 
> > This patch makes the device take that reference only if its driver uses
> > it.
> 
> There are two problems with this patch:
> 
> 1) It sweeps the bug under the carpet and only solves the case that *you*
> care about.  If the device keeps a reference to the VM it was first bound
> to, the problem is that there's no handoff from the old file descriptor to
> the new one.

Yeah, reflowing the kvm fd is not something vfio broadly supports at
all, there a several issues with even trying to do this this I think.

If qemu is doing a live update it probably has to keep the kvm fd
alive across the update too..

Ie when we get to things like confidential VMs there is state inside
that the kvm FD that cannot be checkpointed.

Jason
