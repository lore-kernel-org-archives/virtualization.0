Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F5427FB0
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785816400; cv=none; b=EuR88KjiwMiy1sHPS3LjgtzVsVTGTzPSgQAH+MxEo5mAvUGLzFG/qckDq8gc+C1mrgN7ycJeGPfRrrhs9XwmUhOlbRdfpHoY+qRcBbx/IvqiKR2hqiTcobeacw6nH7YTUbIWqz7lNoxKGnpxqmJvuFP3hAX64khjABqOXIXuJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785816400; c=relaxed/simple;
	bh=gMxPIHbTy7IeoHGRIMeUvkVaienL0v8BTLWTR483DeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CwHAScaOIGtW9qOfKnGDikFsuSNBtrfaxZdAq8K5l/4WoSSdQC6xOYRCdV8PPwB80kWh6dKspagSHZ70gwpu9UokPaG+ORwnlTXIaPm+0qOJHL6VHNJ2ZGfmMT4IocSTwlK2ius7pWkZrc3e6FniZP7s/NGxo704lFGCMljPyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg6rL1ya; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg6rL1ya"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3888865a91.0
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 21:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785816398; x=1786421198; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMxPIHbTy7IeoHGRIMeUvkVaienL0v8BTLWTR483DeY=;
        b=cg6rL1yaSBw8vHgqovjtvdITbOeQaGICD3bUQVkPUJszryyF6ua6ejMULzKnCL6Ecx
         MlBSQurDgfRgYlsrF6uXwzPNuRs7RV4+60fKdpsq7fnTzXX7UqkhdY+DDEN2+6vuWbZv
         Q+KBEwy21wWZM3GcL6KS/sxq4XXq86AM04XUD/Q2PBsaKLVKuyUGhdyA+s/jHUl2Kw8Z
         2MYNjVZKSptfKLpV7Ww8NPvUeCVzQXWeXeRrFVEXNpRbBu8DR4X/7ca4oEvr/r7LqZ8W
         zIC5r+hi+JDZx7g/YBsnD4elAe0/TOll2SUqOGZhtTOvmK0klBOPU/QlBgaDe75JG8aN
         DAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785816398; x=1786421198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gMxPIHbTy7IeoHGRIMeUvkVaienL0v8BTLWTR483DeY=;
        b=NIuwdA21dpmm4uux8vhoWE3qxzWMvEQhIJIqLoR5qa1mN0rt7eGY0sYY9UitMOXXwM
         08hP8Ezxv+NL9AKDaWembgMGHfbX5UFGZk/q1FdCAHXOor0lXcFDWAkcZOMIIWNiX4sU
         gAieNOecnPwkKq/JJqbNRnmC6l9rxpvykTMY1jVKDyW0u6P7PwE5uDWAhpgKxrBduxCU
         LRMultEeq1AEv6V1SD08eS9YbVBi7veGaTIXH0MDunkkRiWTVn8hklN7NeKKKPdnP/Dj
         Dxdp9iShucSrLytVWiVHOtTNTPkmK/ItHSgFq00XRd+W5AOeIOEL73j+hk4KyC2dxaOO
         nhAw==
X-Forwarded-Encrypted: i=1; AHgh+RrxKjXGuAmTpZocpqe4OMCj+eeQPV4PuhICpKFMvwj5qU7AvJJsuSqq4HNo8rhsUZIt5vwZ1oqbPsZwciQj3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx72QdTjjTqA8WVbnR5TvX+o2lcpOKybf3eqvTdbmaykrPb0Uif
	5x8REZv9TM4g648S0UYMXAXQYdynXgDoQHOS3ubY2x2siQfp/NGyeGfW
X-Gm-Gg: AR+sD12mycEnCOT8i33/YufWlfzIdj0LfboEXH1e+6UN6igm/MTpVNitdbg7WatnNVN
	7Cul6r6QkNexsKaDxALBFYZ2ADLlUOcm1eJUmGOZE3avQD3DwnslHj8espRNAslEW96uVAJztgV
	NF95/8nG6seOaL2Cd+dHWlhcScMuR9I8CuJYUI3LUGCvFS0Hq4OFXpr50qHpkT90nADbdQb5kkp
	GCAES+6X39IvRgYLYw3LofGtc4SvfDh36HCRTOEGvsCy60KMEotgQkqh/Uc1zqL9OPYZUPWOQ+c
	pR9sobJD0eldze/dPz40k+yW2pUySU/DW3wCawWou5+qhZszKFZx7OQkJ3uTMewMbRcCjSnb6UG
	ny8fBlcmej+H4I7217a92Tyrv87g+HoojiX/XQbUhzd/fwJRjHK6G+FFL53ltdyM/edatTpl6L8
	6N9KLBGdU+exZzUbscYlLkD+kZ+AAQZok5M3zEoukn60DwMhenHOupvWzZT03o4xo=
X-Received: by 2002:a05:6a21:e58d:b0:3bf:6c08:fba4 with SMTP id adf61e73a8af0-3c92a8498b4mr14546407637.56.1785816397767;
        Mon, 03 Aug 2026 21:06:37 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddd7a33sm41102146eec.12.2026.08.03.21.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:06:37 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: michael.christie@oracle.com,
	jasowangio@gmail.com,
	pbonzoni@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	pbonzini@redhat.com
Subject: Re: [PATCH v2] vhost-scsi: flush backend after device ioctls
Date: Tue,  4 Aug 2026 12:06:19 +0800
Message-Id: <20260804040619.5569-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803232144-mutt-send-email-mst@kernel.org>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <20260724060919.1569170-1-physicalmtea@gmail.com>
 <20260803232144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If you mean Mike's question on v1, I already answered it in:

<20260723105451.1563439-1-physicalmtea@gmail.com>

Thanks for the reminder. I'll put the changelog after `---` and post the next version as a new thread.
