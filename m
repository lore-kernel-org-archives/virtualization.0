Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4FECC
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461018; cv=none; b=Gpdhq1dABsYsgsWz9hECMtxtNQ9jRjVzxkkPv+MizXX1mPoRu0PjJQ4ifyWgDJIbdp1QRNy4PC0Nnn85shFUng1x4u6s4aZGyOAwGV146t54PwTs8aJfkV7R/gBRh/J7d2yLda8AyxcMHgf8/Lv25s/wyVhNlfCBAU/8vfTow0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461018; c=relaxed/simple;
	bh=bvM0pADJsf/ny8qy1qpxXNEPBHi9kStugKigbeIsfP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PBMzxbIUrPJSukVgbgDGiVtQjwd/b6Tg79+gW5ZV3Y29AWV0Bkv1E1s8NwOxq9CeGp720/XK4p5tWEbta5qYjrSIA/1fddpF9wlN7ky+Zy5Y8o0jLQGsUzOHH93hzdkIaxAKgDJ7EfGaCyO0NjLaR0VhElourtJ4WAGZum56Ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1v6sLr8Q; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1v6sLr8Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9072940534
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 00:30:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.601
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxUMMMvTlf5F for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jun 2024 00:30:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1049; helo=mail-pj1-x1049.google.com; envelope-from=3fmbezgykaik5rn0wpt11tyr.p1z@flex--seanjc.bounces.google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9A7AE400F1
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A7AE400F1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=1v6sLr8Q
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A7AE400F1
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 00:30:15 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2c1a55ffd60so4437024a91.3
        for <virtualization@lists.linux-foundation.org>; Mon, 03 Jun 2024 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717461015; x=1718065815; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxZAvQthUOLtrgNKYUD6oiL7rAnsVeqwoSoZowsNkW0=;
        b=1v6sLr8QVLtFsv0Krt9y+0DLqAzjXYgzpzb4UdnkChhXbMLtmhF0OfgB221f7Gwh5o
         xIZxXS3L/56d04866c8zvz06ELH8klSQD7G9yzJ3B1a0AqzK2Edi9dg0bPH/bPf9Iw6O
         TzqE6om1+3/QY6pZA5VCXEzZxQwmFKmfcVOn4aXak+ddL8Z3etdBs6WT/2qXBS2s4uea
         KEqcaTS/JIdUAtRF03hEoRfqe13Je6PfEHN4G1elllyfZYDFqvZ0SLhXNh5KVpFXwkRP
         IcfsNqNLj23Ed+Nvd10qa9+koLZfnnGI7NffryXo4sd1w2GXwah9oPG7R9il3J42yZil
         xuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461015; x=1718065815;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qxZAvQthUOLtrgNKYUD6oiL7rAnsVeqwoSoZowsNkW0=;
        b=h/scaYmTlx5yRETkwvQGC1sl+h6TUI6jUy2QLH1JJUETTZ7HBZ0gfu/uNzl1FIH732
         QCFe/LBazz5HyzFSRaH06fx0jLqKDPz40AIcOprKaeBXEakb7fNWqfPSInKgttWSZSVN
         yeqhL2et/KUfxgbnfi806G4gLPUc/fqT4h0R2Ew57DMfmh+DI7Ydc1hWOdE35RaRY0la
         JB2xXqxTabwtVe18BZO6NqH/JHtKOJgoAE6/6ugayye3Fcl8UkTkK/Gpz8Ui776DqD/t
         YqrgWC60CMgOO2utEATNT6Cue+Cd0lR/y5/1wtyVx+EBgYhy04XO+Ke9ydEdYvjYDwZ+
         4kNg==
X-Forwarded-Encrypted: i=1; AJvYcCXl2H5x3B1farkiYKbUrpYVjJh5AueLt/hB7E7Tx8nl3Y9got2pXabgcnKnVWcuBZGmZi3dH2GzhwO5TPs1/R9WcKn4f3MM2DARKMIkb2W7W4A6WPiJq79maA==
X-Gm-Message-State: AOJu0YxDvaHyFR/QXcgppiRPE5HXMp3T66P+6K2wHKViMTcTxPCEyXIy
	c8wxp+7gzAWX1HZHBCRw0vDKuVMOCDGhk9RjP2C0J4tU9OcQ153TQBYe6rgvP2b5AoCe1+/Uzcw
	aQw==
X-Google-Smtp-Source: AGHT+IHQGaBTeBmAnXtOHPKtCDExst6sxM2uUbRh6POZbhCe3IxNIvO17m1N9WlbQ/aSMCylqTV+FPzEOtI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2c86:b0:2c1:aa8e:13cb with SMTP id
 98e67ed59e1d1-2c1dc5e0ab2mr29758a91.9.1717461014195; Mon, 03 Jun 2024
 17:30:14 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:30:12 -0700
In-Reply-To: <20240603.ahNg8waif6Fu@digikod.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240503131910.307630-4-mic@digikod.net> <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net> <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net> <ZjpTxt-Bxia3bRwB@google.com>
 <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com> <20240514.mai3Ahdoo2qu@digikod.net>
 <ZkUb2IWj4Z9FziCb@google.com> <20240603.ahNg8waif6Fu@digikod.net>
Message-ID: <Zl5gFMJp3nECJVW-@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, May 15, 2024 at 01:32:24PM -0700, Sean Christopherson wrote:
> > On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > > On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrot=
e:
> > > > Development happens
> > > > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-n=
ext
> > > > branch, but I'd advice against looking into it until we add some or=
der
> > > > to the rework. Regardless, feel free to get in touch.
> > >=20
> > > Thanks for the update.
> > >=20
> > > Could we schedule a PUCK meeting to synchronize and help each other?
> > > What about June 12?
> >=20
> > June 12th works on my end.
>=20
> Can you please send an invite?

I think this is all the info?

Time:  6am PDT
Video: https://meet.google.com/vdb-aeqo-knk
Phone: https://tel.meet/vdb-aeqo-knk?pin=3D3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=3DY182MWE1YjFmNjQ0Nz=
M5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb=
3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986S=
ngGlhPH?resourcekey=3D0-FDy0ykM3RerZedI8R-zj4A&usp=3Ddrive_link
