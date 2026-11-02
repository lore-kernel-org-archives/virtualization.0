Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647822;
	b=IioY8YNk9+YbqDoTYz75AhJE0RY3LjTz1AqWwKoQRkmn5rAD5zihxJfetCIlnGMiolko
	 dd6W9JO6w1RpNRpDBOHTfsiHmR9bylcKWrVj8ovW1Fbml/116s80AFwZeP9+A0CzjN/lD
	 UKi6z9Xiexih9WGcEEqZAIEEMEoYW74DwW82Bdr7PMtoJvUtJn1W2neKf9Q/D181zazsg
	 PwFlZF2mdppL+ISw5nl7NgNZiB82Kyy88f9vgFHMRJMYMiGm8cnC1zE5//qapvtjMdJdj
	 Pwwpilt4z2sXlKaTK7V0XYpriJ0tlaYkdqd8MDAZKiGRvqBliVDYeAELxBa93/k5zBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=KMZG+Vonh2kG6IEXx5qekjJyTd7RpEVJ3Nhz9EIK9Q4=;
	b=4hvCfmMAJGOsBASjwq3UdnRgKcBUoYUsRJ1HK8yCNUT0mL1Mk7IuUa+3FxKK8l7/g9Wj
	 jOu3RUeh8NYf8cuT++4cCXa+PhabESxEaQtqQ7lobHMTWAuqtbrA6HIdTGxc/cp3cua1F
	 79ADe/LhQGQ2qxTYzQTJW9TRhirYvLVdB0ZnZ5/D8Or+v7vBzAKRhU6vYMD69wQq3dYJl
	 KZPus9HfXwB7ACyzZotclUpgma7Qu2b/houAX04ywbxBl/FHsrXFbAihODb9oAYbA81RH
	 El0LShmjs6JXitKOAMmdiJMF6oBIoTI6mxyRtTMLBGpIBRBzaGgAyzPN/OW1wHrfRWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="AsLwfo/F";
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B1606A32C
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 19:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE7B1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AsLwfo/F
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd61bdc8683so1694307a12.3
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 11:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793647816; x=1794252616; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMZG+Vonh2kG6IEXx5qekjJyTd7RpEVJ3Nhz9EIK9Q4=;
        b=AsLwfo/FByXmLrelQDaDkVDmBvAWxBHg6g0PaE5IGCWW94NA8do/uz8h+eL9rLjpn8
         KFBudOgjlkprtjInOp4wNniULhvwrcXVU0f7IG2BQK0f+HdCYxsGpAASVtakUrsFa4s3
         fTrt2zyE4KPumzNXTpKSdcJV7sM+6vAhd5HXoBWuvQVXrDuIeDpBKrfKc60XmJvoVRIt
         melptblAPwxtK0/iPnAQ/9WKkg32a6eiFZ1SJdUErC41rWSB1AiPYTozAZ+DoD/tvgky
         M1XBCdohon1cEsl+dytFN8LHgPoaDAJSLzPuEEgbe5ib5gJUzgvfosiVQKSWJyDF/bHG
         n9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647816; x=1794252616;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMZG+Vonh2kG6IEXx5qekjJyTd7RpEVJ3Nhz9EIK9Q4=;
        b=SELVNpPnvXKHzyrP0ElWOKPlwo7lnHJLMoGH48EG8pObdldZ9MjImz2GSfiLysJ/XH
         G2ZLnKMbx/AlvrC8gdS9Lmj0xngOd1Rk/S3w8e1S2b4wg/9b3JXh+FXYAoj9N8g0dG8O
         NTBPufe/elHTU8zIyF/hqFu229V7UiEAWkB3DugRYrz0mnnf55RFAYT6d1sB1mYEEJ8i
         LjcHWLBWJ9ebcytSHQjvS0wWS6oRqtzwCy1GPPK25r6s7vBRVsDt1ovEHZW21CsQ2u9B
         jATsxetkmfVpJ9tMaBXveOdKU6XTIVnSBOQz2DpkrFsaRcc+rr+y8qqH2FNB31oGtyJ5
         o9VA==
X-Forwarded-Encrypted: i=1; AKwUvBw/vflq6gqyMKTSz+1uOjNd3z7HJudB3u6wtV3+t0PqG4UH8jsTLgdzKZVzs3XT7vbzs7RRvfEY3B3CzVwfRw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJSOHC73XhMYQt5oY8zjUtSMlr31Xz66X12Tl3k6q6brosN38/E
	fvg65OCXUCHMXQjsxrw1s957UfDMwycCDhknBgVVJYtsDnvRRc1FCZfhPd2pr3TS7PKZN/9jq9+
	SdAc/2A==
X-Received: from pgfd13-n2.prod.google.com ([2002:a05:6a02:654d:20b0:cd6:1ef9:53db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1441:b0:3e1:a4ac:2d5b
 with SMTP id adf61e73a8af0-3e928dc6c6fmr8634625637.41.1793647815861; Mon, 02
 Nov 2026 11:30:15 -0800 (PST)
Date: Mon, 2 Nov 2026 11:30:15 -0800
In-Reply-To: <979f3d53-d4b8-411f-bc66-cf487ff76d42@amd.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261031003309.3751-1-jason.andryuk@amd.com> <20261031032009.GIauVeaXTMNHgjYEiM@fat_crate.local>
 <979f3d53-d4b8-411f-bc66-cf487ff76d42@amd.com>
Message-ID: <aujkx3-YmRrWd6nX@google.com>
Subject: Re: [PATCH] x86/paravirt: Add ioremap_verify_range hook and implement
 it for Xen PV
From: Sean Christopherson <seanjc@google.com>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Yazen Ghannam <yazen.ghannam@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Ingo Molnar <mingo@kernel.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 02, 2026, Jason Andryuk wrote:
> On 2026-10-30 23:20, Borislav Petkov wrote:
> > And I know Sean doesn't like X86_FEATURE_HYPERVISOR but sorry, nothing beats
> > a oneliner at the beginning of print_s5_reset_status_mmio() vs this overkill.

Deleting Xen PV support would beat it :-D

Yeah, just go X86_FEATURE_HYPERVISOR, I don't care _that_ much.
