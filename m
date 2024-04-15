Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0AA78C75
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191487; cv=none; b=hNoocms47ohvxxE3335CVyO4bxy/uK3Uqu5o9GPQ6y5f+Mk2TyXzSo3/uB11sIXTT2jT8a8ywSY28EZJ08nl45zkkX7a3B2l4TQnzXNsSiy00Xhm5K82DKZyOxyqDZbVGdVh+/G9ecy5FAmyCqamNHJuHAAPOF1ydg2gXrVZb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191487; c=relaxed/simple;
	bh=XJDkfyzGgfUey/2BeVH9JOtxWfTF+sYZtGH3YVzMcTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BV325/XXsi4P/R2lWPxnoduFbqIXyfdWE/lbq6GTvXpTsI+tBE0ehyEKy9mWg0vXZsZpSsb2Wi9rmBVHQy7MjEw/P3GXXVFJ6D4YkfS5NdV1//RRTOiU6hStFWhMqpjq6fPVbvS1r8jVvzKhFeIO9l7J4vzGu8rXs8vWrLxizhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc0EYBG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc0EYBG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B58C4AF0B
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713191487;
	bh=XJDkfyzGgfUey/2BeVH9JOtxWfTF+sYZtGH3YVzMcTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xc0EYBG6me0yl5/v2kaeV9oxHiaJt3nZljbgyzjpGWBogwNyioie6gmIm5gHFfN4x
	 eeDsXXG/EClSwYm6in2MOIFNaXSCVcSHnTpC/pvf/9ueG3FHanO+hTawPOFDe+lsz4
	 UEW/7uajN4rJEe2B8AAC/I05gf92I5WpMpd157fPZdKADsnQ3Xi4wWndYhmqnbgZpw
	 0vLDSCggzMsRe5gqUvE2odxGj9W79YipzVSyxifhsjsrWHVcnQkF+CRssBUvAh8H05
	 qn9PCd7242E1CtJ2T1SrfwHa4OUk/kpQok0GUrBTdDDH3LYKsFZdRawFRS8+VZYFwn
	 aAP473QP/wMDw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22ec8db3803so321500fac.1
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 07:31:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyOWUycvRjDztng1EOoEXi7RK2IjiKwVcvcwSBM+IM/91kIQsKAucL5eiNEKiBIcArKt/flR4aQr+F/YJHDkCKIbseAl9yCSDngko/k6U=
X-Gm-Message-State: AOJu0Yzvd+cF1Sy8lOEaM/HxvesjsQ6U+3h/EGB/rwsJ8DYYMHOin2f7
	A3sLaicr9Oj8yJMk5UohcToq3VxOylNPzJ6jGc1E/BV04tpCHazAb4ixkEvv7LEmIXfq3gtGVsE
	JIWoTJYaaFc4y6q07kGaTXgHqlwY=
X-Google-Smtp-Source: AGHT+IH4pgXMQKRTbZMVSxZiA8nkndxDSTY5Glu6EcSiD7hcI3clm1WG+uX4vUrxkMJQZpJUHRl/fbkr4xQhXy5Cd9k=
X-Received: by 2002:a05:6870:e9a9:b0:229:e46d:763a with SMTP id
 r41-20020a056870e9a900b00229e46d763amr11989427oao.0.1713191486574; Mon, 15
 Apr 2024 07:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <20240414043707-mutt-send-email-mst@kernel.org> <20240415145153.21075173@imammedo.users.ipa.redhat.com>
 <CAJZ5v0j3BVUKDFE-_Tdykt42zCiDfYMpSYN54JUqdr2O8a__1w@mail.gmail.com> <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
In-Reply-To: <CANiDSCuvDQWam0v1b3adA=j6w+dA263QruBonsA6TJBvO9XsWQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 16:31:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iueKy1Jw07XFnBq4s97iGkK7uRYirUDnixkGXJVqgXnw@mail.gmail.com>
Message-ID: <CAJZ5v0iueKy1Jw07XFnBq4s97iGkK7uRYirUDnixkGXJVqgXnw@mail.gmail.com>
Subject: Re: ACPI timeouts when enabling KASAN
To: Ricardo Ribalda <ribalda@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Andrea Righi <andrea.righi@canonical.com>, 
	virtualization@lists.linux.dev, stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:18=E2=80=AFPM Ricardo Ribalda <ribalda@google.com=
> wrote:
>
> Hi Igor, Hi Rafael
>
> Yes, it seems that it is just KASAN being extremely slow.
> From a completely newbie here... Is there a reason why qemu generates
> the table vs returning a precomputed one?

I have no idea, I'm not familiar with qemu internals, sorry.
