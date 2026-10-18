Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABDD4D17A0
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357927; cv=none; b=AAYL3pW+MBgSBIXJja2XC8KDb3akaCDdJH9pShOuK/X38jnqrIwS3EOBoByQRyCiqXjWkI+Ai0zD/Il7MK2qKYylLDo4z7UkEVZqNQQbeRr8pWVf3wLIWfd/K9FluEy3vZ1WVglurc8Hqr1m9BflQI0ZIcRBD7fm2MoO4u5GZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357927; c=relaxed/simple;
	bh=+AhBVTr7AVwgOwcBqSG3YDlgmZAw3nrSuWm0g675vUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sra1JIC+F31cjfcgo5GsXggBXCiAxbj40S/2bC+JWlGJkk11VOA9HfgYRcuI/NS1uGrwKZZjLniC6g51Jih3/qiALUHjjUrYsAbSQtAOQr1wiasw/IJceWuYGbJG77EJpfHWmJSEVLjgs0yPoGz77bNalF+LYcUcLktY/fgdsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MUamrw5P; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MUamrw5P"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2dcbcc546fso154175866b.3
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 14:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792357924; x=1792962724; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FhrOh9ObXddFM4Jcmg5gPf4RqgcAG0wBDdYKHUigitI=;
        b=MUamrw5PvghHXPCkErxdLp2VSFZ56u1obCc5wK0DI9W6OFk3+DgXoPPW5QGnXfcqN3
         GcBx5kq847rfeS4R20FIa5CW5Qve7iA8168PIdDxvHMSX/aiUHv16odrpQsHPkvLUnz/
         jqLun2tCIzCLdPiG2M4aN2SHaiL2Mki+SXFvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792357924; x=1792962724;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FhrOh9ObXddFM4Jcmg5gPf4RqgcAG0wBDdYKHUigitI=;
        b=ZjtNt1zyYVZ1BJV0Raw3HCuprBaLsz8GshOuDq2m7ZZodpUE/WHn8MR9rYaBLL6Iwp
         ixGbJRo7J369zdToGFB82b/I9ttVVMlBPIePu9dGPNSc9YEpu/UJCz2bGHmp2Imjhfr0
         v/a13OAgJ3ze/OjnH2/TBJLep0PjlBg0HjvmvTvILtE0rHL4EPIFnfmR9St1ppETy6ad
         dX8ZTtASpcX8xbLobH7t+CdYfpMxR5o9XFT3jsvjf6ZVw/gqTrtNrXpCdmT2rRI629SM
         eU4cEhJCy27g7QPQyEiMnLq3bmapTpaIss2gruzSfKIYOlcx9o55gftatOkXS0BHOQ3X
         YKhQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYmhbpzc4XGJaltwLeROEQBYI2NRzyig1kE0EsS7RZiNQT6Igk63OPxXhrlD4IqHMQFFTianssNQn4Edc9YA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLHibauWIYo1WqV6U9cgy0xJyPQ6ZFD6Ea8Jdvmpt0IAZ3vIOOP
	NmG87Nq0gEQtKKP8n4yXb6mM/0WYCqMdss5Ih1OJEgkLCIKPIfSkoB6OzfVT9gLrptgLbzznGVk
	qrp6l89g=
X-Gm-Gg: AYBFou0myGWc4i8e6hsDj6LslKi5yTQ67+Sa+/M37ogBw3C6h+RtI8FyUpwFsoavpnc
	QjcRTrOoEJ3tj6te5P9b/gDt3OyJPdBiQ+TUUfm9smicp4kW/TPzrEchkTI3gyD+hUp6zXZuapn
	/EHiBVt9g3/1wZO5XnDDQwjiEOjG7qDW1eHz3dUhjG7yqfbatU46Jsngvh+N4hv99KsFlXaoFKm
	eql5qTOlV7t1R4NIK99kIGquxtGB6B/TnuuZwBGc4CTqB0w+Lx1hnSr3eKjdwKyNr/XATYVHxjo
	hCx6fpzsm2RoaIydNDxXVMlcj8WT9Mv/70XUra+wtdl944fDcmkOoe6KTCumaZwBM6VRwwKUbj1
	/F6ZGptg2Pgu4/PBfLaiREikXGI4FBzVew3iTotBfOzpdeyjTXApbUeJvfi+r5VQESpkOw2UC1i
	0X76MOnyTG3LlrAG6H1ptPIOHlRsfOXk+0jruQEzCJNu3HLqsugyU1XYgBVe0cQtFJl86YG6Zql
	CmSrw9a8vdsiBAKxg8It4HHbVDaRakkAlD7O1VZiZF9xbM=
X-Received: by 2002:a17:907:6d26:b0:c41:731c:534 with SMTP id a640c23a62f3a-c419e43f9c6mr395717166b.24.1792357924405;
        Sun, 18 Oct 2026 14:12:04 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb1835sm292728466b.79.2026.10.18.14.12.02
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 14:12:03 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so1544341a12.1
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 14:12:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz+Y0tyS6A/a3w1Gw2SgsPBjMcNG/ykYmIpySA4LcrUADMzatxVHOklOEF3kA5G3JK9FRWiCF6hWHjYDb68Kw==@lists.linux.dev
X-Received: by 2002:a17:907:86aa:b0:c31:e958:408c with SMTP id
 a640c23a62f3a-c419f803714mr362945266b.38.1792357922492; Sun, 18 Oct 2026
 14:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
In-Reply-To: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 18 Oct 2026 11:11:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjxOy24XQnSSGimnHbp9mVjUETBE5HrS+W9E8mRrtxBLw@mail.gmail.com>
X-Gm-Features: AclHuK-BuQ_t8DyWOTykYSUp3UkUFx2INkZ9fVII4LHbFyz6TFQuNw2DbQZKHk4
Message-ID: <CAHk-=wjxOy24XQnSSGimnHbp9mVjUETBE5HrS+W9E8mRrtxBLw@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: multipart/mixed; boundary="000000000000482e69065e23d9f5"

--000000000000482e69065e23d9f5
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 10:34, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> And __get_user() together with access_ok() is actively wrong and
> stupid. It's slower, bigger, and more bug-prone than just using
> "get_user()".

Btw, if you have *multiple* accesses to the same structure, that was a
historical reason to use access_ok() with multiple __get_user() calls.

But it's not a useful pattern today - and hasn't been for years -
because the real cost is not the access_ok(), but the stac/clac that
surrounds __get_user() on modern hardware.

If performance is really crticial, the new "unsafe_get_user()" model
is the way to go.

Here's an UNTESTED example patch of how to do a conversion. It
generates much better code than __get_user() ever did. That patch
looks good to me, but again: I didn't actually *test* it (and the
reason this signal.c code has never been updated to the modern pattern
is that it really doesn't matter for performance - I decided to use it
as an example not because it matters, but because it's a good example
code-sequence for the legacy model conversion).

Somebody should test it.

                     Linus

--000000000000482e69065e23d9f5
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mveblmwl0>
X-Attachment-Id: f_mveblmwl0

IGtlcm5lbC9zaWduYWwuYyB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwg
MjYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3NpZ25hbC5jIGIva2VybmVsL3Np
Z25hbC5jCmluZGV4IGQzMWViY2I2ZWQ0ZC4uMGZkMTI5NmU5MTJiIDEwMDY0NAotLS0gYS9rZXJu
ZWwvc2lnbmFsLmMKKysrIGIva2VybmVsL3NpZ25hbC5jCkBAIC00Nzc2LDEyICs0Nzc2LDEyIEBA
IFNZU0NBTExfREVGSU5FMyhzaWdhY3Rpb24sIGludCwgc2lnLAogCiAJaWYgKGFjdCkgewogCQlv
bGRfc2lnc2V0X3QgbWFzazsKLQkJaWYgKCFhY2Nlc3Nfb2soYWN0LCBzaXplb2YoKmFjdCkpIHx8
Ci0JCSAgICBfX2dldF91c2VyKG5ld19rYS5zYS5zYV9oYW5kbGVyLCAmYWN0LT5zYV9oYW5kbGVy
KSB8fAotCQkgICAgX19nZXRfdXNlcihuZXdfa2Euc2Euc2FfcmVzdG9yZXIsICZhY3QtPnNhX3Jl
c3RvcmVyKSB8fAotCQkgICAgX19nZXRfdXNlcihuZXdfa2Euc2Euc2FfZmxhZ3MsICZhY3QtPnNh
X2ZsYWdzKSB8fAotCQkgICAgX19nZXRfdXNlcihtYXNrLCAmYWN0LT5zYV9tYXNrKSkKLQkJCXJl
dHVybiAtRUZBVUxUOworCQlzY29wZWRfdXNlcl9yZWFkX2FjY2VzcyhhY3QsIEVmYXVsdCkgewor
CQkJdW5zYWZlX2dldF91c2VyKG5ld19rYS5zYS5zYV9oYW5kbGVyLCAmYWN0LT5zYV9oYW5kbGVy
LCBFZmF1bHQpOworCQkJdW5zYWZlX2dldF91c2VyKG5ld19rYS5zYS5zYV9yZXN0b3JlciwgJmFj
dC0+c2FfcmVzdG9yZXIsIEVmYXVsdCk7CisJCQl1bnNhZmVfZ2V0X3VzZXIobmV3X2thLnNhLnNh
X2ZsYWdzLCAmYWN0LT5zYV9mbGFncywgRWZhdWx0KTsKKwkJCXVuc2FmZV9nZXRfdXNlcihtYXNr
LCAmYWN0LT5zYV9tYXNrLCBFZmF1bHQpOworCQl9CiAjaWZkZWYgX19BUkNIX0hBU19LQV9SRVNU
T1JFUgogCQluZXdfa2Eua2FfcmVzdG9yZXIgPSBOVUxMOwogI2VuZGlmCkBAIC00NzkxLDE1ICs0
NzkxLDE4IEBAIFNZU0NBTExfREVGSU5FMyhzaWdhY3Rpb24sIGludCwgc2lnLAogCXJldCA9IGRv
X3NpZ2FjdGlvbihzaWcsIGFjdCA/ICZuZXdfa2EgOiBOVUxMLCBvYWN0ID8gJm9sZF9rYSA6IE5V
TEwpOwogCiAJaWYgKCFyZXQgJiYgb2FjdCkgewotCQlpZiAoIWFjY2Vzc19vayhvYWN0LCBzaXpl
b2YoKm9hY3QpKSB8fAotCQkgICAgX19wdXRfdXNlcihvbGRfa2Euc2Euc2FfaGFuZGxlciwgJm9h
Y3QtPnNhX2hhbmRsZXIpIHx8Ci0JCSAgICBfX3B1dF91c2VyKG9sZF9rYS5zYS5zYV9yZXN0b3Jl
ciwgJm9hY3QtPnNhX3Jlc3RvcmVyKSB8fAotCQkgICAgX19wdXRfdXNlcihvbGRfa2Euc2Euc2Ff
ZmxhZ3MsICZvYWN0LT5zYV9mbGFncykgfHwKLQkJICAgIF9fcHV0X3VzZXIob2xkX2thLnNhLnNh
X21hc2suc2lnWzBdLCAmb2FjdC0+c2FfbWFzaykpCi0JCQlyZXR1cm4gLUVGQVVMVDsKKwkJc2Nv
cGVkX3VzZXJfd3JpdGVfYWNjZXNzKGFjdCwgRWZhdWx0KSB7CisJCQl1bnNhZmVfcHV0X3VzZXIo
b2xkX2thLnNhLnNhX2hhbmRsZXIsICZvYWN0LT5zYV9oYW5kbGVyLCBFZmF1bHQpOworCQkJdW5z
YWZlX3B1dF91c2VyKG9sZF9rYS5zYS5zYV9yZXN0b3JlciwgJm9hY3QtPnNhX3Jlc3RvcmVyLCBF
ZmF1bHQpOworCQkJdW5zYWZlX3B1dF91c2VyKG9sZF9rYS5zYS5zYV9mbGFncywgJm9hY3QtPnNh
X2ZsYWdzLCBFZmF1bHQpOworCQkJdW5zYWZlX3B1dF91c2VyKG9sZF9rYS5zYS5zYV9tYXNrLnNp
Z1swXSwgJm9hY3QtPnNhX21hc2ssIEVmYXVsdCk7CisJCX0KIAl9CiAKIAlyZXR1cm4gcmV0Owor
CitFZmF1bHQ6CisJcmV0dXJuIC1FRkFVTFQ7CiB9CiAjZW5kaWYKICNpZmRlZiBDT05GSUdfQ09N
UEFUX09MRF9TSUdBQ1RJT04KQEAgLTQ4MTMsMTIgKzQ4MTYsMTIgQEAgQ09NUEFUX1NZU0NBTExf
REVGSU5FMyhzaWdhY3Rpb24sIGludCwgc2lnLAogCWNvbXBhdF91cHRyX3QgaGFuZGxlciwgcmVz
dG9yZXI7CiAKIAlpZiAoYWN0KSB7Ci0JCWlmICghYWNjZXNzX29rKGFjdCwgc2l6ZW9mKCphY3Qp
KSB8fAotCQkgICAgX19nZXRfdXNlcihoYW5kbGVyLCAmYWN0LT5zYV9oYW5kbGVyKSB8fAotCQkg
ICAgX19nZXRfdXNlcihyZXN0b3JlciwgJmFjdC0+c2FfcmVzdG9yZXIpIHx8Ci0JCSAgICBfX2dl
dF91c2VyKG5ld19rYS5zYS5zYV9mbGFncywgJmFjdC0+c2FfZmxhZ3MpIHx8Ci0JCSAgICBfX2dl
dF91c2VyKG1hc2ssICZhY3QtPnNhX21hc2spKQotCQkJcmV0dXJuIC1FRkFVTFQ7CisJCXNjb3Bl
ZF91c2VyX3JlYWRfYWNjZXNzKGFjdCwgRWZhdWx0KSB7CisJCQl1bnNhZmVfZ2V0X3VzZXIoaGFu
ZGxlciwgJmFjdC0+c2FfaGFuZGxlciwgRWZhdWx0KTsKKwkJCXVuc2FmZV9nZXRfdXNlcihyZXN0
b3JlciwgJmFjdC0+c2FfcmVzdG9yZXIsIEVmYXVsdCk7CisJCQl1bnNhZmVfZ2V0X3VzZXIobmV3
X2thLnNhLnNhX2ZsYWdzLCAmYWN0LT5zYV9mbGFncywgRWZhdWx0KTsKKwkJCXVuc2FmZV9nZXRf
dXNlcihtYXNrLCAmYWN0LT5zYV9tYXNrLCBFZmF1bHQpOworCQl9CiAKICNpZmRlZiBfX0FSQ0hf
SEFTX0tBX1JFU1RPUkVSCiAJCW5ld19rYS5rYV9yZXN0b3JlciA9IE5VTEw7CkBAIC00ODMxLDE2
ICs0ODM0LDE3IEBAIENPTVBBVF9TWVNDQUxMX0RFRklORTMoc2lnYWN0aW9uLCBpbnQsIHNpZywK
IAlyZXQgPSBkb19zaWdhY3Rpb24oc2lnLCBhY3QgPyAmbmV3X2thIDogTlVMTCwgb2FjdCA/ICZv
bGRfa2EgOiBOVUxMKTsKIAogCWlmICghcmV0ICYmIG9hY3QpIHsKLQkJaWYgKCFhY2Nlc3Nfb2so
b2FjdCwgc2l6ZW9mKCpvYWN0KSkgfHwKLQkJICAgIF9fcHV0X3VzZXIocHRyX3RvX2NvbXBhdChv
bGRfa2Euc2Euc2FfaGFuZGxlciksCi0JCQkgICAgICAgJm9hY3QtPnNhX2hhbmRsZXIpIHx8Ci0J
CSAgICBfX3B1dF91c2VyKHB0cl90b19jb21wYXQob2xkX2thLnNhLnNhX3Jlc3RvcmVyKSwKLQkJ
CSAgICAgICAmb2FjdC0+c2FfcmVzdG9yZXIpIHx8Ci0JCSAgICBfX3B1dF91c2VyKG9sZF9rYS5z
YS5zYV9mbGFncywgJm9hY3QtPnNhX2ZsYWdzKSB8fAotCQkgICAgX19wdXRfdXNlcihvbGRfa2Eu
c2Euc2FfbWFzay5zaWdbMF0sICZvYWN0LT5zYV9tYXNrKSkKLQkJCXJldHVybiAtRUZBVUxUOwor
CQlzY29wZWRfdXNlcl93cml0ZV9hY2Nlc3MoYWN0LCBFZmF1bHQpIHsKKwkJCXVuc2FmZV9wdXRf
dXNlcihwdHJfdG9fY29tcGF0KG9sZF9rYS5zYS5zYV9oYW5kbGVyKSwgJm9hY3QtPnNhX2hhbmRs
ZXIsIEVmYXVsdCk7CisJCQl1bnNhZmVfcHV0X3VzZXIocHRyX3RvX2NvbXBhdChvbGRfa2Euc2Eu
c2FfcmVzdG9yZXIpLCAmb2FjdC0+c2FfcmVzdG9yZXIsIEVmYXVsdCk7CisJCQl1bnNhZmVfcHV0
X3VzZXIob2xkX2thLnNhLnNhX2ZsYWdzLCAmb2FjdC0+c2FfZmxhZ3MsIEVmYXVsdCk7CisJCQl1
bnNhZmVfcHV0X3VzZXIob2xkX2thLnNhLnNhX21hc2suc2lnWzBdLCAmb2FjdC0+c2FfbWFzaywg
RWZhdWx0KTsKKwkJfQogCX0KIAlyZXR1cm4gcmV0OworCitFZmF1bHQ6CisJcmV0dXJuIC1FRkFV
TFQ7CiB9CiAjZW5kaWYKIAo=
--000000000000482e69065e23d9f5--
