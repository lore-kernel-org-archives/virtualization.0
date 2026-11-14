Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794664313;
	b=BZjZKQmO3WuQ1rWOKGbAWBz7ZWh1tECu/fvN4Nk+LkmEO8N/1VPKXMnRaajr/xBHBAHc
	 OG8CZFFbsJqs7aDKrGRQ679uNItmcOBMxRCfoCb8TbWozEPQZeK6MZuVT9DpvsgMnEQR3
	 81cMThkDs0ODfBfh0coAxXa+fJKKFhZanzz8efmXaOVCcX9NkVWNB9Kcsmu9d1FL5c5aj
	 D3a0IWo1uLJfXBXWqPzJsaWJmzS7fa9q1N6lsSxnxMbhVU4dk1s2h74CKbPmQUJIQEI3N
	 JU/6a9UBIhyGYuTWlc2yc/MeGmxROsS5twkuNCipmETAaEfN0a9sND+EoSDI/18z/Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794664313;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CnWW9gpNC79/nZFswkxbrq3QlPD5NwtKAqBQkHXA8Ek=;
	b=CPsUcro/+lIIaA7gJvh/3nGyY1CTlpBPdpSjN5MkWmA0M7f/LGFb/uY7qPPEwjP7a8nO
	 gU2JtPep7s2tXHrROldwZQ+9YvYgeyGoAoWtXFzGpHpWpig4wtRHU9rhmWRiGcjGcSDVq
	 vBdmBl1ZzyyIlW+BW5rHy9cj/zGKeNQdUQLGA0LfBEq9qFqREadySSIhGxHlDJ55aZt1X
	 XHiyexoc3IAodo6ANnyO8AXeTYDPIaQqk+OX5UEsPsRHQhsybOABMWi3M+0RSjuYVtX+H
	 5cPvR4rJfYqeYlIe/XtcvAjT/gceTqRZ0ijLjr/5t8E0XMam2zKOMGLXm9FKPUBjp5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNM1lOrF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B86606A32D;
	Sat, 14 Nov 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNM1lOrF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A351F000C4;
	Sat, 14 Nov 2026 13:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794664313;
	bh=CnWW9gpNC79/nZFswkxbrq3QlPD5NwtKAqBQkHXA8Ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eNM1lOrFmFNoqyY7Zg+zbZETOrIHJDfIwRjw5kbfBCQene0fTVwTsdlrWC6g7oDD5
	 MiAFtMafjcMADffS57tvSIcGBOFJxfP5Vj/RrY29PT9MzBDEyJ0UbrIP4A2QLkhpff
	 GTbBce2zEWYPzbbCW4+WA35p4SHopqkLTuUsQ5+ayDO9LeUqvrNs/J+BznzuJWonx+
	 7l3RodaXwRpPQXYT1fils6n6B/9l1KhRFt8AfjVZ4Jqeptsaa9j+ymESAdVlPIXe2I
	 +G45ETUded+2Do3+1FR+VWKPJZWumTaNx9f0bbDwJe24iDW/kz6b4mkUc3ixQZ3kst
	 kbB/J6Hjkb8RQ==
Message-ID: <sashiko-outbox-214595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261113083351-mutt-send-email-mst@kernel.org>
References: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
 <20261113012937.40818-1-zhaoguohan@kylinos.cn>
 <20261113083351-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:51:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] vhost: missing drivers/vhost/vhost.c changes to use
  set_bit_user()
- [Low] x86/uaccess: missing local __label__ efault in set_bit_user()
--

commit 0fc009f80e8e18bd72e753ada02155e494eedeca
Author: Michael S. Tsirkin <mst@redhat.com>

vhost: set dirty log bits without pinning pages on x86

This commit adds the set_bit_user() macro in arch/x86/include/asm/uaccess.h
to atomically set a bit in a byte of user memory using scoped_user_rw_acces=
s().

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 3a0dd3c2b233e..0bffa43e02179 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -594,6 +594,28 @@ _label:									\
>  	__ret;								\
>  							})
> =20
> +/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
> +#define set_bit_user(nr, addr)					\

[Severity: Medium]
Is this commit missing the changes in drivers/vhost/vhost.c to call
set_bit_user()?

The commit appears to have been applied directly from a mailing-list reply
that only contained a replacement hunk for arch/x86/include/asm/uaccess.h.
As a result, set_bit_user() has no callers in the tree and
set_bit_to_user() in drivers/vhost/vhost.c still pins user pages with
pin_user_pages_fast().

> +({									\
> +	int __err =3D -EFAULT;						\
> +	u8 __user *__p =3D (addr);					\
> +	scoped_user_rw_access(__p, efault) {				\
> +		__err =3D 0;						\
> +		asm volatile("\n"					\
> +			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
> +			     "2:\n"					\
> +			     _ASM_EXTABLE_TYPE_REG(1b, 2b,			\
> +						   EX_TYPE_EFAULT_REG,	\
> +						   %[errout])		\
> +			     : [errout] "+r" (__err),			\
> +			       [ptr] "+m" (*__p)			\
> +			     : [mask] "q" ((unsigned char)BIT(nr))	\
> +			     : "memory", "cc");				\
> +	}								\
> +efault:									\
> +	__err;								\
> +})

[Severity: Low]
Should set_bit_user() declare __label__ efault; at the start of the
statement expression, as get_user_inline() and put_user_inline() do in
include/linux/uaccess.h?

Without __label__ efault;, the efault label has function scope, so
expanding set_bit_user() more than once in the same function (or inside a
function that already defines an efault label) will fail to compile with a
duplicate label error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113083351-mutt=
-send-email-mst@kernel.org?part=3D1
