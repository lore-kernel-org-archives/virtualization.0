Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265252;
	b=V2AV1Z0gSbMHLnaZ1zND5ZIxOLzeAI41dkDfkdqVzejOhEFsbiYe8+FexVUmyieZERyI
	 GROAVCKF+2nWLYOE+lGnGX7Mel/wIepxHcQ0xS4Gq/Fqkk1lddiXmFAuJYbAZ7nLAMj9r
	 RPGmkwY9yPF2mM1uHDSu7Yfi3HbmIz8pjIC+8Ym+VkfrlJbgzG3E5nEvx8y7oNxnHEEQ9
	 z2mu+FJoSczlEWxdAQEu390/l9Msgh8pTjcTcix3mOZCwCibjdp00/Pqv4bJi3T5UhK02
	 wxBjCKfUBUfbvdu4cCpYbklxC933pwZVhos6yMbrD1zMrk9eS+Ap77X357rAvK5mznA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=dy/9BbEZRYuwT8a6wlWpCFQITWgRsvXhPUvkZriskFw=;
	b=EsFkhnf/Nu61SPWeGPNptAekfMAWleDOY0uTm1cB65wQzxkjl0CTCJp7MGJun2Br5n6C
	 BPuANWTr58l2nc3szmHt7ZK0iaL/DqKaK418pm2u6ur/MrkTaIKG0PvxtLeioUlngxkiC
	 rTA2WURpYJh/eHhJwsJziZrmVzCdpMNML1iVyk7WYUP7YAYfwmdhcmOfSlmlCu81Nf3g6
	 UsX73FkWeHSwwHGB5zOGkLky38D+x2FPvk7f/5gH4IQUJmX03N68TBP34Xd6jWIWLPZYI
	 hE4xuVnEuQTKoSH10qnr/QtjyrQZy5ep/cPF2HHO3AA+p+JyOgO1K7YaRui01ah115w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l+2kgzyh;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15110606A32C
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 12:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15110606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l+2kgzyh
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-194d0c31715so3293c88.0
        for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 04:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795265251; x=1795870051; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dy/9BbEZRYuwT8a6wlWpCFQITWgRsvXhPUvkZriskFw=;
        b=l+2kgzyh1xNTG1bqs3OB94rKm68zq6g/bly/9Qlve0BwtoXVlt+DY9Y2GcVQc8ST4Z
         aU5tiK3O6XR/OLXrtlNv2F7wtzynsiGHNJwNZD+vB0x70Qt+6u9ZSjfP1cUu21hdhYPG
         oNu/ej4IVixcP2Tv4etGLBnDrAZuBqii7FkH++WCd1auInwHJ9SJVcDfPkM2BKC72SIH
         NmBXJE3O5qtwh78qPgnPP4JDP6Ux+lf8fZhv4af74+dcFWkmZZC3rkdha8pcJzpoE67z
         qvZ3Cs/iQGgkVuTzLuNNgxCLli578wG8+/eaju2ab0/w/4dKTL1u9Ilo3ek5FZdnyHEI
         IWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265251; x=1795870051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dy/9BbEZRYuwT8a6wlWpCFQITWgRsvXhPUvkZriskFw=;
        b=xmW8nDjii51VdfWOZK0eaZbVXYNFUlrPu+VNKWqsmM/XUxUt1tb0sW86V3CqoFs192
         0dn9V2rO8IjNCihAeWFqFRmuORngbw9htyGnH6Ia8nCwDlp1iO0hQx9bNdUx8hqRUmhk
         Vpf52vOwBjWiDkudVQYRLytV3hemeuKfszU8f6VjDiZeRf85J/wNmFG1xCTvc5145QYw
         OfC3/F5W36z/m3LtSIE8sOsh2VpDYYw9PpEMPBXz+fH4AciCsE43y2H2zEQzVh0q1pAh
         Z6Y9/UeFzRFOUJOngAuGRLBjRSwkGk0FnXcmPV38mop34bm5D6SqiCEYUa7FNJ+8mtua
         MD4Q==
X-Forwarded-Encrypted: i=1; AL+hErFBT6SVWjVaW5b7uDA8gQcDKmIXNVwU9CTKhbwRqG7viNVJXCWQ3zEoLocyI7lEhlpKmiLtsxRh4izR3F/7tg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9mFwTMYrvhU6pp/zYBh2GJji5BqroD4fOj5iEut1pmJOIuwGM/
	xxtBNyeCGmTWiFsqLKij3VN0lyIBpOBuoaYnmNBYQA7JyDG3tkiAtjvO0B+xFiCCIw==
X-Gm-Gg: AZFdTZemPUeER686LHYlZWp9hpTcyysb7HAhysK+qSBTtWMbIWfbkH99t5eJvXeMPhn
	CbkSP8rXSnHZC9kGf7faIRMsRCLNADmlGPL5iStJzxog8TRM/hIjT7gNO0cXiNYCkFqHJhwBjcA
	pOYSqiEpT32Eg6I9BmSrHghhnSi6C6+u0FWBbGWivPc6jwlU0uCWaSo7GDs5A95gwEz3AAEprT3
	nman0e+yJu/dtaz7o+3RO3RRMrMqEz1fjs/lVOmsZAJcqIHUQGoy2IJ/oH2rXOr2kJCewmKpZmc
	5PpCdxisaiXkGWuHIcePe44z6vceDcFr0qIikmnF/yg4stGUXnrzASvJZSVAHPsLYEa5gcZPLj2
	BAADbk7I2t/3TQzd1pJquFc/9jYv6QkP8ttajSp+vsZ1SFlyqfRP3Ar92AzV7OKzQIhu9MZT1jt
	mIfTgCoBxjNUl0Ts1upTL5uj/UY3TOr135LANVu1ADB0hZH8gYW2teAPJxO8p2FZNuUYHozTIYR
	THxNdwSowhnhbKGBAGOzMaxpTF2y6z6qQjBdtbaUYz0gJ9dA9uIPtR0RX5mWxWqH3zHFGfKcjyK
	/f+HkWJca/ASxStNt5Tj4d5HLHdtoFjhV0AUisXDf8hwCw3otzPW2+NTSAGCistpxSY=
X-Received: by 2002:a05:701a:cca2:10b0:139:90c3:391b with SMTP id a92af1059eb24-1b56336e369mr649347c88.1.1795265250428;
        Sat, 21 Nov 2026 04:47:30 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm17147164eec.23.2026.11.21.04.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:47:29 -0800 (PST)
Date: Sat, 21 Nov 2026 12:47:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Mostafa Saleh <smostafa@google.com>, kvm@vger.kernel.org,
	qat-linux@intel.com, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2 03/10] vfio: Allow untainted use of driver_override
Message-ID: <awGS2tAtt0yKFXMC@google.com>
References: <cover.1795171088.git.u.kleine-koenig@baylibre.com>
 <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb0df5c89336b77a373ae0f890f63427e4adbb28.1795171088.git.u.kleine-koenig@baylibre.com>

On Fri, Nov 20, 2026 at 12:11:04PM +0100, Uwe Kleine-König wrote:
> From: Alex Williamson <alex@shazbot.org>
> 
> Driver overrides are the standard mechanism for binding vfio drivers
> to devices.  With the introduction of the support_driver_override flag
> in the core driver struct, it's now required for drivers to declare
> themselves as driver_override compatible, otherwise driver_override
> bindings will be denied or generate a kernel taint.
> 
> Set the support_driver_override flag on the driver struct across all
> vfio drivers.
> 
> Signed-off-by: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Ankit Agrawal <ankita@nvidia.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
