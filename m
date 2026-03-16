Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30A39A06D
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670096; cv=none; b=JePtVuCEakRbl0QCW3wOPvceVE1ySUuTF5sqBMiwmKjd/y3CnwX3vilA7BG/thWGdvyMd9V7A6P+dOK5lQ1KRD93G2DCQg7ft4KZMPeLDmFNMnXntfTMOVd7MaIP943YhfEJXRG6XSZVLPpuER/fRTQP0rBQklup1LdBykkWL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670096; c=relaxed/simple;
	bh=l8oPYmCUox+HYD80+GdLFbBOPhRJJNmQ2cOQc3OAfqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZSFP4s6sTiNcqQ0FuK357VGT4ChHkcoJpGhAgEW4j8+JiZVsPC6m4kYnQwhlugA7Wk0dBoCgjt+t5CONckbFR9wPUUA4j5Xu+J2gouXTsLlkVTLTKA2YpIEHEc2emDzdz+B05CkYxeescso0ga1FS37ciDQ7zf4RNQdND+JnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2N8Bi1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2N8Bi1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7551C2BC87
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773670095;
	bh=l8oPYmCUox+HYD80+GdLFbBOPhRJJNmQ2cOQc3OAfqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O2N8Bi1x2GKkCRe6wLlkLVdEAumXUaVpOovUXiU0fi+BLLJniZHuMXOw3O4x+S8Vy
	 m6N4iZuveBY9FOa5ms0ZFDsKOwDPCsH91M6n52iHQ8REYtCrSZxyv5VLddXfMx9eIa
	 4Iq/Gbl2EGw4ZeMvoHYu8uR4YLlX2E/d+cwZIWEauYVXV6wsxukDuid9akg7sjs0Ja
	 hbn+fdQMaNV3ZqHqdRYc9x+MRORPWlObqDMItcrM2UWUl26VtYRAV3m+c3SXIpg+8M
	 pyDZii6akZPQYwdYAtEi+rrejSea6aMvFwySuMzY6zeaF/j3RILBk2wpdKoDnwBaHP
	 LhuO29wwxgoRw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a01c80c34so38219911fa.0
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 07:08:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxoa130qHhLD79TZ429w9X3Pcuf093io/zszDq8zqBJxvkHtioDq04jo21KovYHk6N8S8zVjOIrc1KbsAyhg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww68DkGsj7hnUGWeKFX6OHu++aXHYSNKO05l23ybCOS+q97sCf
	OtwtXCy3e8m1xe6adM2qvssFVTN3QuLHP46TkCR8WpqHeD89W7BX0OrDn+ZQD1cMiULDXWGuLvy
	5UkQwf8T5BDNfrUCMjEqwmm8V0w0m0LI=
X-Received: by 2002:a05:651c:198d:b0:389:f5b4:46cc with SMTP id
 38308e7fff4ca-38a89645d0cmr42254341fa.4.1773670094566; Mon, 16 Mar 2026
 07:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312193717.12221-1-rosenp@gmail.com> <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
 <CAKxU2N_7sZu+J46sCQH4jgVB0r9HsHREToeCTg0Hz4PaVjY+sQ@mail.gmail.com>
In-Reply-To: <CAKxU2N_7sZu+J46sCQH4jgVB0r9HsHREToeCTg0Hz4PaVjY+sQ@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Mar 2026 15:08:00 +0100
X-Gmail-Original-Message-ID: <CAD++jLkaxtuKZq-sJ3s1Rv4hAVT8Wb5RKTHo7L7EU7U5Csw=ag@mail.gmail.com>
X-Gm-Features: AaiRm514yMjy-riOY0-nNMAQ3Dm3EeSfZQ_Jeua8HVMt8JGxk9ChMWC5efBcsmM
Message-ID: <CAD++jLkaxtuKZq-sJ3s1Rv4hAVT8Wb5RKTHo7L7EU7U5Csw=ag@mail.gmail.com>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:30=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> > I wonder if it is worth it anymore. Why combining allocations is better=
 when we
> > are ending up using more memory ?

> No idea. That's what maintainers suggested for some unknown reason.

This YouTube seminar by Kees Cook and Gustavo Silva explains
exactly why we want this:
https://www.youtube.com/watch?v=3DV2kzptQG5_A

As mentioned briefly in my reply to Viresh, it brings some of the same
features that Rust has to the kernel C dialect.

This is done to avoid what we call undefined behaviour.

Yours,
Linus Walleij
