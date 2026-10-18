Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF893DF01F
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355672; cv=none; b=pnvNwjMsbRGG1nkoMojj9tgwSfnWhz/Eo5LccszsKV00RykcMPyd5xDSYRWxc0YimiyWYLzZQXL5iaC1EIedeZ7qnNh5gPA7kEmKcsLdQDdcnvlXdifcjCTpg1Dope1yx6D8MMzUsbjH92T35/OwDVSYROg0vLXkhJQY45+l8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355672; c=relaxed/simple;
	bh=mGtMxGvGMAPxZX+KuCd0vFb++3GQYItv+c8z4egM++c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmrHHPiFbmJwm4s6oE1MUTgU1IKtg7Xh7fFU2Ac+iwVQ+x4sv3DuAXHAcfNqTTQ2nrPHESDcdO1/uzbILF0xNmL/olP/1LlkXSbo/jnmvBoqXMe5eaxq/npa3qmQVnIERbX/MW54SZI17afSMtFhkqnrPZzCQ2rtp+sR0VhDsbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UyEft1ke; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UyEft1ke"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c40447e25e6so160288666b.1
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792355669; x=1792960469; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LcZudtVZGXqPCpJjVd+PjoGGou1YwE9FLeXdn5NeRV4=;
        b=UyEft1keCWGO4NKsbwvGwqAO/l/GOOuZZg8siR1bA0h6GPrZT41UfTwLJf2tMgniJp
         ChWcR2AcPM1qOpzNsiaOdZ8Ep5IAQf+//JOVA/3rL5rR/0A4RTnZPdaIVJ9VeuDqkji0
         AqVcnDpmPEeRGZpw3sJ4iIEhIHyd4n7pLbnxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355669; x=1792960469;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LcZudtVZGXqPCpJjVd+PjoGGou1YwE9FLeXdn5NeRV4=;
        b=ahJrHmEZS7nHzYPPNakQSjtqplsXSf7zAqiv5/mqFk2Q9gDNTkD/CDe3i3VMe/rYxd
         jMcp7gowjnles8z8JgVhwAzfjLpLhjAlaombEhn9o7L2FkVKnY9pblrkRX++F/yJDN/j
         dKZdf0q7/mgt9vWtrT3DqB+zjNJ+LO+gucYi0LL6a8XaeHha5rvbDpdyiXfBtI9alesU
         Azs+uczluifiRXn/RPYctLeGWEVL/HuQ+VbEVExb6vCScewjWUoPBDQ0qI3eVmqzPYyr
         Qljdh1sNPOqYZtTItsoWfEzf+bG5bcAFdS4Py0WX+/e/fdNoaDCUymXhCSeHdMbNxvxm
         5DJA==
X-Forwarded-Encrypted: i=1; AKwUvBysr/GuCYHOT4nmSHBsCrbnCSNdE0mLtHlUzSkEVN0AiNBR62TgE3B1J85XIKxLIgtn629Tdd/xAc3bWqHJbA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIGZesgU4Ta2JCm5+bD5yk0ooAIvbyz6fLhJt16hn14zB6Sc5Mc
	isxMSWWixFvl+mh3hqovRLbuOhfH/Paozwtx45GH1ab2W+iFRFrLqiljPbjR1WkRdphUm+/C17T
	Ol9pT/uA=
X-Gm-Gg: AYBFou1cKabUsQj/GuCVH52gb1BiqLZUzqEOqsLoJHTOd0jA1oIK6y178hQJK1rtn8Z
	Jdao9YdkUBVGMociCzfsZgtkj3H63YcbLKyWQpg6IyzZd4TI9sfnDrZXpJt+aLwtSdTRhFANoaA
	QPnHySjceiT/KGc29IhcDUK0E71Po/+SLME7sdwoRUIyh3GlV9GiqRK9J4/Ik784q33Aznp6FIW
	bK11jUhLkcMmuUGHm7/Uyolvn7ZkpS154atNOFQBviAm2BRZY9s9ywThv64SqT3Fh+BwUlzPJLE
	JiTOba+V5at9I6vjhSZQhWJDO/DNjqhpFrnHgHWkmMT9127H/GJOK1ZNzBkdRSeNQ6rkbiV0ZgA
	p3JAE78UBhiKEqdTXRMc8k0XPx5qRCAyBvYd63Xjo2MltJvMjNKAqX4p70P5xCnNVfhSI/koW3f
	afnuu3B2iB0+EOe1y9HqqJbrm5962+cdIfmP2GXz0w5il/70zmLp36JKrfrnZ1spZ56o8SylyT0
	tAgvAQwK2KZCTWsWtUOzbN8uKmVqvp/9s2hsNaGtRhVxF0=
X-Received: by 2002:a17:907:9607:b0:c40:5ee3:8698 with SMTP id a640c23a62f3a-c419f70799bmr379339566b.31.1792355668936;
        Sun, 18 Oct 2026 13:34:28 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e328775sm293524766b.7.2026.10.18.13.34.28
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 13:34:28 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c40447e25e6so160287766b.1
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 13:34:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByNx7hjwKhDF2aempKlokjN9BS4thz9UbQ+D/8WlZfwB8sCt1U1nn6qwMz2q6ITjoDf5xvWRdycQZdLfbADlw==@lists.linux.dev
X-Received: by 2002:a17:907:6d0b:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c419faf81bemr359351966b.35.1792355668398; Sun, 18 Oct 2026
 13:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261018152358-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 18 Oct 2026 10:34:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
X-Gm-Features: AclHuK98aalKW5kTezoePJe0elXfnFi_e6X010Sl6ShLR7WlXp_TWSCo1UYtPLA
Message-ID: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 09:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> +               __virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +               if (!access_ok(uaddr, sizeof(*p)))
> +                       return -EFAULT;
> +               ret = __get_user(tmp, uaddr);

You should never use __get_user() in the first place. It is almost
always just a bug.

And __get_user() together with access_ok() is actively wrong and
stupid. It's slower, bigger, and more bug-prone than just using
"get_user()".

The *only* reason ever to use __get_user() is in very very iffy code
that might use a kernel pointer and doesn't want the access_ok() code.

Or old legacy code from the last century when __get_user() was faster
and was inlined.

               Linus
