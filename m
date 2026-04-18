Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C36175A66
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473242; cv=pass; b=WL7vakk1XHjwUiRBwWtS8OXhVFySw9cOMxNuD054YnnJhpSqJxyE/4Fo1wmGFdxTtJdzwkLFoSj0gbO7+WhCxPvci9dtRpu8boWwprWMB80naSRumHddTpXn+56fuDk2GSTj7TBW9ZxswfmZAMa+kpDSkjW+GK92k1pd13hzFZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473242; c=relaxed/simple;
	bh=rI75D/XswJG3sRrX5mA7QIVX2img+GchrkKkvbE4OOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3eInRnCq8RjLhUZMZVkAqZpqRHAv3TqFfTvI4kdAaLf72i2kcT9Ep144VYH0ih9D9qKZlyXF847/7UgPY26VRt1H7DKMK9YSUmM3qTAB7Z7PZY2Bi6WxgS8h4p+pgPZu8xfi9TRTsy2vJP07V6aiUGjN9riczdeKzH7j2aF0UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5i+p8AZ; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5i+p8AZ"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6501d242e2fso1273458d50.3
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 17:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776473240; cv=none;
        d=google.com; s=arc-20240605;
        b=C3JaS67MEJgI9GKx5PP9PKwYAAkId37WBlKEygJPiu4DenEADH5hsc9VEjrdYSOCbG
         767A1V/ed1+MOANmRs1CP1/gJ8qrIdLOhCrZHEAxow9+L9Fuc2LumWFuy98pMwoQouup
         d3rHu45vgISDHYvmHS7XzBxXchErOtxpIxKZjWo4MEb4voDRalf8QBVZ/hFdb2JEaDEy
         D9/1c932Lb4m+sRsHRljsJZ+pRzezljwo8iAKcbJzvF3k6zRfFyg1faorL5NzPzh1mJG
         C8vTW/114f5UyEZbAufyTxv1Qp07TUtZK8Fm27XVVB64WwQOWF+vR4wQS9XIh0kwYjHk
         7lag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=72V9NqGcW6qqoMdzaKMDd1yz64pFCmzqJwHFxWDRYog=;
        fh=Q2eL3NQyr+hp4+AkN8LUf30Lo/Bya6b4ifme7DEziGc=;
        b=FeeyOHQbpDFuAHgCbIamrOvtwxUXkszeFGoTbFxwv/Qy+0HZj6n4sVU3bnnKfiIH6j
         DwGHYzE/oIF2TXpsJ+fEPEnwBmXAekVEEm6YWcweoL6MRUr8JOHdRC0pUVOUmBzLJExI
         SEu8z/mEedcvXnAeLFIV25rEIrNL1KFINzyv5FxkoQ59gKQv50rQYnPghK6DN/JM7gpF
         QhuVL+n2kXxorL/2ruXj83YCKuCuEebqRfr3rc8AH2mBDaa3yAZFMT52366t2CMQQYbP
         7rHdHBSpdKJFHcU2ynASBOtQuf7cOIMZOHska7YU8blnfIWh5hYD0qaa2i/hpDS6dCAB
         MJLw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776473240; x=1777078040; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72V9NqGcW6qqoMdzaKMDd1yz64pFCmzqJwHFxWDRYog=;
        b=L5i+p8AZQaTVMjX9Dn/jPQLvc2DOm5twsQwjSMkujxMlqaIinrSHmPbY11Y7WMN99E
         T1A2zYfEnXJxVfOiNAK+CvgLiNBinr0NfKb9i3RfGUYTv0mVJ4bSfaNk9qdzS5xJLO19
         0RWtqxnpMfAKo90jLC39YLnvstjEWP56BI81qcTau+7VXOdHAOUvB5d+iVSJFI0m9rhX
         pVXZFg/Ffk1fKUUM9jOuS7xMtz423vD7cIYB6U/hI9b6Efyk1UZXKDHQMtMhwlbAAwkZ
         LZq5ZIrP7S0o2oR/ohXCdyBdAxufyVadbuIK7gXcFeksuzf2uz0phXzob8UWC8fFdgKj
         pUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776473240; x=1777078040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72V9NqGcW6qqoMdzaKMDd1yz64pFCmzqJwHFxWDRYog=;
        b=ZZUyEksGKze/wjp3zDEoqyOzAz7xp3M1t1P7UXt/jw3munVKwUWeNqA1Duf+NH9viq
         fOO/MMMZ8ZY6Yw7NSyFExU1Zt805WTVFpS+SddaefiRSbab6bt2jxmwcGQZxvNTiuHSv
         cPoU+k961QQZ8dLxV1T2yGiywtXc0M9xiItJqiJLn5bbDb+amw9B6027VQTBMoOp01OW
         8Mp8br6McmyobGykK1wtl5SJz1h9IpbrDP6BHCV/KeO2fp/nwULKMeIiRmBfrfcTjYK8
         mh9NrryuuDfZxo0iqDz/xE5qwlQzvn82OJQTWUNV2G2vavyEXyDMTQ8+N+Iw7NNcRYJg
         nw5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+98fogCDYd61Y6GfAk8GZbb3q+uzCxqjGMzvsQepv48YRqOnI5ofS2Sbl+i54TwANWoOWi7+8pJY74poEXwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXWdi3uiBFb4R3fMCvVIX3rxYaOSQ3qCGGByD4VCQB4JOpZVsT
	QLHGHuV73jd+bzC1GWhxDWM+iH5H/rxIQkqswKMCuQVHIWK7S9vp4htBgCm9M1tofjDDMN+oLPE
	SWfxa5L6BwkY9wyI2uWLv5kWYQum0h3M=
X-Gm-Gg: AeBDievspuesqd8/qYDsFtTnxZ4y5iWoQefvLfe6kgTOBRmXXcKmUk3LuzLEiJmJTDt
	TFCH1pIW7Ix7BfuBP4Ze9oYzlxXgg2SAsuuG1Zd0CHenP1t6rlqI05yx6u9iF217BPFnkB+gXT8
	Zzky79NQd+XQZK/r/40NXjUBhf9vj2TAQnVQXzl56FhpjuBzEqC2iIl5TFA6YWdTsooCH9p5x76
	Jw6/lQPSAWh5hICqFxHrE3PD8b9hP6oV5wjRkI6PpcXqxsP22wViyiSYVe/kThCDLkjXGIuDDKd
	gX57UyL/y/PGs9KxeP78dSEW7LO6iSooRcvohNC/7EmGsow=
X-Received: by 2002:a53:ac9b:0:b0:654:c28:551 with SMTP id 956f58d0204a3-6540c282024mr1617570d50.32.1776473240188;
 Fri, 17 Apr 2026 17:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260418000020.1847122-1-michael.bommarito@gmail.com>
 <20260417201129-mutt-send-email-mst@kernel.org> <CAJJ9bXzhKTBx4m3-SCM+ccGd6ZhTXTAbRxKekCzidnXY6yXbWg@mail.gmail.com>
 <20260417202330-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260417202330-mutt-send-email-mst@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 17 Apr 2026 20:47:09 -0400
X-Gm-Features: AQROBzC2J6INtNnpHboIyzK84Yzmhpw9H84-rHj4d_Q05M5JZKKJ7A_UXrtOiM4
Message-ID: <CAJJ9bXweZ2k+F5A7rOWSodzTN6UYOP3rf2oBbrVirOuof0tqNg@mail.gmail.com>
Subject: Re: [PATCH] hwrng: virtio: reject invalid used.len from the device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 8:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> Actionable meaning what?

Well, between the BLAKE2 pass and the fact that 99% of guests already
shouldn't trust what's above, I agree that actionable doesn't mean
much to most people, not even for breaking KASLR.

But after doing some research, I realized that SEV-SNP/TDX guests that
expect lockdown=3Dconfidentiality might actually expect otherwise under
that security model.  Still not a lot to work with, but more than just
correctness in those cases, and those might be the environments that
care the most.

> Maybe clamp at sizeof(vi->data) then? 0 might break buggy devices that
> were working earlier.
> Or just clamp where it's used, for clarity.
> And maybe we need the array_index dance, given
> you are worried about malicious.

Happy to send a v2 with those changes but I can only test on a 1-2 TDX
variants at home and don't have access to an EPYC bare metal box, so
not very confident about your buggy device point
