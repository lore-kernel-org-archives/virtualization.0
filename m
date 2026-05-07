Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DBF38229C
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142652; cv=none; b=qyhyX494Fp1kFuvk0C6RtBOcBgr897IUAAPzGkzb7FcwwoWd1Om7THH+Wr1A6ClU+OHk1SAKaGVUJucTbuEby6Af77oO8GRmcNcmVmvKdPvukGpISirXkiQeKH/+/6RIUM1R3DzYVijjk9r1muJcETv/Tc+WQZr3Mx9WMteeT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142652; c=relaxed/simple;
	bh=sPUiUe3/ZahPWTv6ouQhacPk4e52CC7I+mZAhz62OY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Tf+vIB7zDiiKAf77OjiTKe5989f38IJHBWqUbK8kSXcNbah0mIuP2kXVt+EUS9a6bd74NduEcvE0jdbpP8wTl1LdhS6ymZ85puQ3A6rurm8PWpe0LLpKXdqwCrvg5aWGj4iYtML8Zl0L3YBdTaTnnR19oFdEUsS6mcZes90UzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=3dQKr2SF; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="3dQKr2SF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1778142639;
	bh=sPUiUe3/ZahPWTv6ouQhacPk4e52CC7I+mZAhz62OY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
	b=3dQKr2SFbNxypy+u0hyj8OUDwv8m8ATwhEeyKzxY1Daj74MeyscsGoIf610mJRo8f
	 nTq7UY3qkErNi9JjSe2ns0A7YgXmoXsGXX6AsYSFZCSARvjlSnsFLqYVTF+FqBKjHR
	 nM4Fqo3HRuDl0nrS5gKBLVZXdHiipL/3TL77uwWxE2oWgdpZY4PIQ1zuzNJ22seN82
	 p4AB7X8vRJt813PbH7lru0XWas81JrjMPDR6xhZ1aYqxhi/z5NUP98GXpNn4HMmZTh
	 jei3/bgADJgqJ1M7Y2EU+UE9MAsZPkOq8c8V1l+Qb/pf7CyMC0zG+JiTUYa7+/6hh2
	 iT5FyHzCGXBggCRcK0+jxnPfPHG0d66pSrZ4yJ7Lp9ku4kDL9VX6ffcrpDANUv5rKv
	 I0C+8yteS3dfMFUINOTDMXNtexN38gzQJz4CO0bShlklqx2LK6/DJJNG7FZXyU8Azx
	 9Sp5p7TxqlXtStYIa/VDwg29cAa6aQGYAdfTG0SnmTIYikI5aW28XUx+g7I566Nf1d
	 RZ4vg95KD9V23J03mNjAaIkt3K928q0aTCmJ4eqezSuvhx3388dOBaWIX6pnTLq8Lz
	 kwb3+181CXqo5jzjkyXlPjYlu0DbMup+cuUovIujMkKoeMbps9bgiNPysQUm943K0B
	 pV6ZOHTST9DG9/bTBypC5HBk=
Date: Thu, 07 May 2026 11:29:37 +0300
From: Manos Pitsidianakis <manos@pitsidianak.is>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber <peter.hilber@oss.qualcomm.com>, Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Y=?=rn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio P=?UTF-8?B?w6k=?=rez <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] rust/helpers: add virtio.c
User-Agent: meli/0.8.13
References: <20260505-rust-virtio-v1-0-9563383909e4@pitsidianak.is> <20260505-rust-virtio-v1-2-9563383909e4@pitsidianak.is> <CAH5fLgjFLBx3DDE7yGNSHmaW9w5GyzSOi4o=avGrMni1a0yS3A@mail.gmail.com>
In-Reply-To: <CAH5fLgjFLBx3DDE7yGNSHmaW9w5GyzSOi4o=avGrMni1a0yS3A@mail.gmail.com>
Message-ID: <tenrn1.131epks1cmid2@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Thu, 07 May 2026 11:28, Alice Ryhl <aliceryhl@google.com> wrote:
>On Tue, May 5, 2026 at 10:14 AM Manos Pitsidianakis
><manos@pitsidianak.is> wrote:
>>
>> Some internal kernel virtio API functions are inline macros, so define
>> their symbols in a helper file.
>>
>> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
>> ---
>>  MAINTAINERS            |  6 ++++++
>>  rust/helpers/helpers.c |  3 +++
>>  rust/helpers/virtio.c  | 35 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 44 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d1cc0e12fe1f004da89b1aa339116908f642e894..48c9c666d90b5a256ab6fae1f42508b789a0ce50 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -27930,6 +27930,12 @@ F:     include/uapi/linux/virtio_*.h
>>  F:     net/vmw_vsock/virtio*
>>  F:     tools/virtio/
>>
>> +VIRTIO CORE API BINDINGS [RUST]
>> +M:     Manos Pitsidianakis <manos@pitsidianak.is>
>> +L:     virtualization@lists.linux.dev
>> +S:     Maintained
>> +F:     rust/helpers/virtio.c
>> +
>>  VIRTIO CRYPTO DRIVER
>>  M:     Gonglei <arei.gonglei@huawei.com>
>>  L:     virtualization@lists.linux.dev
>> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
>> index a3c42e51f00a0990bea81ebce6e99bb397ce7533..84b54690d95be37699ef9a9c4d7cedec0bbae6d3 100644
>> --- a/rust/helpers/helpers.c
>> +++ b/rust/helpers/helpers.c
>> @@ -62,6 +62,9 @@
>>  #include "uaccess.c"
>>  #include "usb.c"
>>  #include "vmalloc.c"
>> +#if defined(CONFIG_VIRTIO)
>> +#include "virtio.c"
>> +#endif /* defined(CONFIG_VIRTIO) */
>
>Please move this ifdef inside the file instead, to match all other
>files with similar ifdefs.
>
>Alice

Will do, thanks. Should this also be IS_ENABLED(CONFIG_VIRTIO) btw?

Manos
