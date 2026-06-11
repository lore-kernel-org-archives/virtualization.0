Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5152E62B3
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172231; cv=none; b=h3Ejj2w2B1Q9WlH/c2sO/GLwv37G/66M8w46ncah+kiHtA+JFG0AA75ATm/nDDNmxtRZ4xLuQzD+K0x+CYNLfWbTXXTvCt/2sIo64FIci0aHBMyUGTR6+pfVWS4eEFKnzosrOdOZIXgtnXN8JF/gqpV4pCe0P1ZV3MuAsEcokCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172231; c=relaxed/simple;
	bh=VAs/GCibCyDaqi3nHsOx9BPF6bvlc6LG8MqXmBo4L8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfhuIe598rFvr5VquvUx7pZwDEXd+z6me2KHH6fjOPqdKekRAHyaMl+a8X7tgaMNE+SGV0f3ZjAKZfr11AW3Q845wk+3ioKzQ3l2UlfKwLl+l1fPLJ5x5+exfNnR+7JnU2Mmk4Uim+LBWjUkYWTjxAe5PadYnJanoOA0pR950m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1LIFxo5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1LIFxo5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso5668975e9.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781172228; x=1781777028; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9STgvUk3oRIx7XFabbesfUNmdUEn9qMIeHh38tKNZA=;
        b=H1LIFxo5RvBovCdCpSArn68AVapLUg5fDA4IxiAW4+rU7gvwEA0xeiZ8ZZrcdzDyIk
         6/N5GUVLoX9UB/ohXYlarjHVruvKI20lNyUJwmPXSQW8dAy3+Z8AScubMLRAu7FGIHv+
         fyOTdb2AW4nU2DkYqqe0oVdPel0pgebQVgOH+FJMrB8rWKL2KFkSYYjkr2cbHloMtSDa
         AiCBKkKd53r1c5o/Amfr9LgBsuf+JP0ZcjRXu9cojYl6q3m+KvKti6uF1zxSiVtSjlNk
         oPCfUXikZfpB/r9EYPSN53pO6xC0YWtkVZLJLK6b65dUCeTlMTqi0m619OrNZh3kinLY
         RI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172228; x=1781777028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D9STgvUk3oRIx7XFabbesfUNmdUEn9qMIeHh38tKNZA=;
        b=lA8iabayqcY8fReh4WdQnCsQmsTyZ6Xqj7D4QQnyhqrWoa9efnBZ69k2paIM4zDFAU
         5ss0N8fsAi4vtHyZps5aNsR0DWQri+gjGSIjCLRdXTa05Cl6/TlY5WKLdqXqj9ifyGJd
         wJcXB1YLc4RUzQRxM9dGfjgpDAB6uLTUqcZT7850HoPdIiF8+2js/1DNTuExhDO9QO84
         qR/Z8otXsfU5ne5jIdnDBKQB2YjX/dLIhHMP0etoteOIWCxbdhNEFFog6tbyN0khgC0d
         HVjwPsq208Xp7COaZYF+GhbX3ufEwNTQ2OdnYizUcsB8n2+x1KnrRMBpQPZ6GfeMqnrD
         RNpA==
X-Forwarded-Encrypted: i=1; AFNElJ8bVti2nTC2A1y/r3EgtT8tIq2Y9FPF3w6XeR8Z53iuLQWhlZs1XpAiXiBSV4+YrGOEqBktP00DQACKFpg5eQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8NiVfjIghCZN6Pa/xx50CbzmZ3COC5+Kjg/pC5Fz1QFxyPwc0
	tYhIOALqyb9UhThx/Chvptrd6asf91xYrmgnYud58C+bne8RkVdXsCHy
X-Gm-Gg: Acq92OFfMLN+8p1qGMNnnr3HR/gwLHMEzwRlg6uk9wdwLk353bCJaTy5akQRsmpDf1X
	UD0tQztk6kd+0R5nK6gewyiftjs0Fc5jhYepRGXNQGagwrdO6kQcLtu5HqKVXubu3OoZIajb0Zk
	dtS+tl0xoo80eVR5lfj7ws+MYkb55mva4vQ5IuIehfa6iaPYnQyELxymr87+CSWl30uvOML3O7L
	WGeB4A3H+AOHKpzgKBjpoJXJvd1R+v4V9K/CQG4E0tyyry041IMvAWDn9KEV4ukvbGu9qnK5vzw
	CK8O6CJWdpBg9kw20BET8az8k1CxYxkyNYaqGxwj0JU+UDOqOnfBF6W+LSIXwUcdt/oAQqawFt/
	rGBFw53jNw67opmmqaqQMzoI3LYgvpLHC/U9GyZG2LDVrooFeF3I47Cg+dqOUpSHkNzeLFTXiGW
	eYkeeEEJ+Cwi/vm13hN+MRLxjHlU1LZXSXiOu42gRhRVleEivaST1rrnORISQrSctXr3uF3nk=
X-Received: by 2002:a05:600c:4f47:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-490e52d5bfdmr22105515e9.5.1781172228070;
        Thu, 11 Jun 2026 03:03:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e47a9284sm32769395e9.1.2026.06.11.03.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:03:47 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:03:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] vduse: Fix error around jumping over a __cleanup()
 variable
Message-ID: <20260611110346.2b9388a1@pumpkin>
In-Reply-To: <20260610-vduse_vq_kick-fix-guard-usage-v1-1-0ce02c08006e@kernel.org>
References: <20260610-vduse_vq_kick-fix-guard-usage-v1-1-0ce02c08006e@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 12:16:49 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> When building with clang, there is an error in vduse_vq_kick() from
> attempting to jump over a variable declared with the cleanup attribute
> using goto:
.
> Jumping over a variable declared with the cleanup attribute does not
> prevent the cleanup function from running, it would just result in the
> variable being passed uninitialized to the cleanup function .clang
> errors instead of generating the invalid code, unlike GCC.

Does the same apply to variables allocated inside switch statements?
I'm sure I've seen one that wasn't inside an extra block.

	David
