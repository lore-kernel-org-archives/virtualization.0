Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D339B946
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669586; cv=none; b=fwTvd0gj10uPh44QfnD8YvkT0nJ+PQtKnb00EgXB6h9FW6LXJLJkoJffgibigrHRIpx8A4kms8nrkb1mJMrcalQkXWc3YI/rXdirKPwYupqtS1iTzrvBgYnwuXQ8Oop6Al1Z+7yBnnO+zd3gVqjVdTUYzgOVTjwxQ/DTCEUwrXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669586; c=relaxed/simple;
	bh=Fjb9fZZs1ZvFOQ4C9uQbO/1B6MRyMCO+ilDgqLwjVi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePzamLiVLi4gkl62pNwfQx/MZgkUKXQ7If5o8quAgDRvIWJ23T02lJIpBwmsD7V53oDut01I7bA1+79Whsyn/awdfAx0Ai0MrVvOFU5hL+1/jLungP2abOXifhE6ylFlKdgduo85jcnsphmSfBhPq975otEP3nuViSf/bBlKORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhpcxDUh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhpcxDUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20E2C19421
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773669585;
	bh=Fjb9fZZs1ZvFOQ4C9uQbO/1B6MRyMCO+ilDgqLwjVi0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FhpcxDUhFXxP/s3z39GyLkA3mHIjnO2p5Uh4OJyIo2zbv+tGGXQhmmy61586p5uK/
	 nAaSsf36BROI3y4U/G/YXqD559zF1wOqncS7bdegu6Ks1lIccfTXCkIffTyhGOUERr
	 wxKfVzq3H8C4TaefrFOl+se3XbNKBj29IiDakLpcXawhz/CbJqsZQzdavfFNAMZ1V6
	 CsutPglymEjrrSA9rEz6jYIpZdIusb58StT18CTu5s1DVtaMVWj7IqEoUYmC2ovuac
	 Jtus0JLCX8SNvN8/IyExRHpJIy9B98M6iGC65oDVjYcjTT+djMPSsU3qx+VLNm9FCF
	 IqZBvPgKqtEPw==
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ca09f2056so3411088d50.2
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 06:59:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULoiVFh3DQEtoKwBcokGXu27fbVh95844DTDQkBhy3lOKF0adbrqZroMp1tKaR0SJMK5971qcI7i0rogsb2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNkApcHwgwLrfqVEERkv98/HABad6u9BZaOZNStHlaGtFZecDG
	Wce92m+/H9IDBJLUjGZBeFb/+5tR7FK+Bo0E0AUDl0D0yf3hNdYB/YZGvaICWH8plNMFrvk4REl
	fQBIAdLq2snRfpXkof7jLkP3Ednl37yk=
X-Received: by 2002:a05:690e:1c7:b0:63c:f5a6:f2ef with SMTP id
 956f58d0204a3-64e6307f5dcmr9995930d50.65.1773669585234; Mon, 16 Mar 2026
 06:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312193717.12221-1-rosenp@gmail.com>
In-Reply-To: <20260312193717.12221-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Mar 2026 14:59:34 +0100
X-Gmail-Original-Message-ID: <CAD++jLnRseLfMFq982ggXSYCrO-5xoxPD30eepGKY6-EEeuhLA@mail.gmail.com>
X-Gm-Features: AaiRm51aOzZzJaZ_mm2VdjhqhKeQ3AoEaq_JqIIJjrVjOdtyD03zXAXm1_l24VE
Message-ID: <CAD++jLnRseLfMFq982ggXSYCrO-5xoxPD30eepGKY6-EEeuhLA@mail.gmail.com>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 8:37=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:

> A flexible array member can be used to combine allocations.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
