Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567242;
	b=O6S7hLZG1T8tfsZlM+IpptTZZ6eWfN0WCQnxRg7iCE5EY732MvV1iwXGVteRzxFQHN/t
	 TrlkqQukaS5j/+GYurYS8V3OymZlAPNL7wVRFGDraljifthyrfTFlNdxQAdeP0dUqn7/6
	 kQ6zdLKsMdDzFa6EfdC4uyafSBfgIRU0j8gGBRv9L5MGgfomDWDa+858BBKM8qRn0KyZW
	 z9t27YOZ1TUs+v2CYJRyUu/Pq8wWbmjN5E5fOSiSZHqKc20+nbwwMHNYNpqNEy3Sf38sy
	 kCyKfg5fD/WqKoyNVLgQAG1BDhaI0+LwPEnApqONxed16HV/RQ4B8P2yebSAYHgr6UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fWJcRXjj6PRpDNlqYnDkesvi0jgKgQsveVoKe2eJUY8=;
	b=NQ4AAwEbAv+P5DNJDv9tjjEICE6oqY+i+/FeWg7UGAGc/Wmqqo2Ax39SNgj7nS1PQfaV
	 0fyJ7bGdsFabka5iIqBaMp9mB49X2EKO0888Sz9FXBxhITvkVfFTSK3JOxitWSChvokKb
	 /zmT8sJBzyuIEMX56AmPbZ9eecD2z76ELQvJYJimxjhtI8UY4qR+X6ZLWZaoAtrkl8JQ8
	 ngLjZI3ZsNZKuIdkqQ16Z2U/atUTvsfAzbAGMkkhf+f99XzMdJbyElxpYeaMBbZVb/VjH
	 Q1Y3SapLaXDqQ4PdZcJ/DCxvxPtsuKkmXc4PsfgwC2al9rnTRg3cIhLsAcreoudoLqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pn27p0uv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BF960A261D;
	Fri, 13 Nov 2026 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pn27p0uv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B661F000C4;
	Fri, 13 Nov 2026 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794567242;
	bh=fWJcRXjj6PRpDNlqYnDkesvi0jgKgQsveVoKe2eJUY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pn27p0uvBBJ6LJETrVO7gInmEWjKaScJ12M0nrPWh4qpqgq97VL0x3GAali/NNaJU
	 MwEkwg1NcMbZogVcig0dG+YRCWa5kVj4xKXiCKxuhzD2sRxpgIv5Ql0w+CwnTJ/K0c
	 Gft2wFjD8qfFKsfseolavAEka5VPRhCSGZVBkM8Pu7LKfNLcvz8bPZWqfkTgRzuv8W
	 0iEmz00CFxMTdLu+OMj0K4+BsG8VzX6XKs7wZyZHx5ycf5OvmeELXjEiP/+OmUVYJs
	 rBGZOQZcAh/CiB2OZ/CV42Red5o661j/OdsWdbBdga+6OZ2NBrM7iLP66Bp7O4yi9O
	 8kJVkMSrNB60Q==
Message-ID: <sashiko-outbox-212640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
References: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:54:01 +0000
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
- [Critical] x86/uaccess, vhost: missing access_ok() check in
  set_bit_user()
- [High] x86/uaccess: set_bit_user() uses write-only =3Dr constraint on
  __err
--

commit 508047a5899f1ab9b68b7a3a4c36fffabf6ab858
Author: Michael S. Tsirkin <mst@redhat.com>

vhost: set dirty log bits without pinning pages on x86

This commit introduces a set_bit_user() helper on x86 to atomically set a
bit in user memory using an exception table entry, and uses it in vhost's
set_bit_to_user() to avoid pinning user pages on the dirty-logging path.

Link: https://lore.kernel.org/all/20261112085631.128819-1-zhaoguohan@kylino=
s.cn/

> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uacces=
s.h
> index 3a0dd3c2b233e..ba1e7c3f83c8e 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -594,6 +594,24 @@ _label:									\
>  	__ret;								\
>  							})
> =20
> +/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
> +#define set_bit_user(nr, addr)					\
> +({									\
> +	int __err =3D 0;							\
> +	__uaccess_begin();						\
> +	asm volatile("\n"						\
> +		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
> +		     "2:\n"						\
> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> +					   %[errout])			\
> +		     : [errout] "=3Dr" (__err),				\
> +		       [ptr] "+m" (*(u8 __user *)(addr))		\
> +		     : [mask] "q" ((unsigned char)BIT(nr))		\
> +		     : "memory", "cc");				\
> +	__uaccess_end();						\
> +	__err ? -EFAULT : 0;						\
> +})

[Severity: Critical]
Does set_bit_user() need an access_ok() check (or user_access_begin() /
scoped_user_rw_access()) before calling __uaccess_begin()?

Previously, set_bit_to_user() called pin_user_pages_fast(), which rejected
kernel addresses.  Not every vhost path validates vq->log_base with
access_ok() before reaching set_bit_to_user(): when vq->iotlb is non-NULL
and vq->log_used is set (with VHOST_F_LOG_ALL unset), vq_log_access_ok()
skips log_access_ok() because vq_log_used_access_ok() returns true early:

drivers/vhost/vhost.c:vq_log_used_access_ok() {
	if (vq->iotlb)
		return true;

	return !log_used || log_access_ok(log_base, log_addr,
					  vhost_get_used_size(vq, vq->num));
}

When log_used() then runs, it calls log_write_hva() ->
log_write(vq->log_base, ...) -> set_bit_to_user(), allowing userspace to
set bits in arbitrary kernel memory with SMAP disabled.

[Severity: High]
Should the [errout] constraint on __err be "+r" instead of "=3Dr"?

%[errout] is only written by the exception handler when instruction 1b
faults.  With a write-only "=3Dr" constraint, the compiler treats the
initial "__err =3D 0" assignment as dead and can reuse a register holding a
non-zero input (such as [mask]), causing set_bit_user() to return -EFAULT
even when the atomic orb succeeds and aborting vhost dirty-page logging.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/af7f05bf637337d35fd=
d10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com?part=3D1
