Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E63D47BC
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.245.177.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695678; cv=none; b=oNYz1zk9jZ1Iblmv9t4OdUCsOmLPq/06Zm3EzgSu5HaqI9pblgO4ZlaFtph8SSJvgS0G03BojRnloV3tirbkvYzumOj41Lw6v7+EhkaGUDcPTlLRnmrfhS6PdX7D8yN2eLfWltSd5cDEybC8Z6g5zfi6NWj9NYgB3hcvgC6iU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695678; c=relaxed/simple;
	bh=pZyWk+ZbO+WD6soPtxhlbtQe5nc7C2q6taMJVvJogRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b0oxag+3ArXpKULXV+tTW+VzNGBE7zoYTT8rtbdvAtiwQnk8pvEN2lk1D/9RwG3EWGBb1rRiFd3mFWP+pFRWCEyjcyNFIorL5LoT9ow5fCZZzhfifjGKHchPHY9zr7KNzFUl9jM9+ruMKiXQ5xA2c6a4S7CCeOqDLc+jyi2zBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=jI/n/bZ8; arc=none smtp.client-ip=188.245.177.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pitsidianak.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b="jI/n/bZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1779695673;
	bh=pZyWk+ZbO+WD6soPtxhlbtQe5nc7C2q6taMJVvJogRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
	b=jI/n/bZ8Uo5XNhb62HUo+9S47/HQLtVLbXK7GZ6XHshdTg+AhZBu1ZD2NElHNqXUS
	 iSmNSQNahv4RblDf/c0IFNRVzur8O2hbhqUWxDppmPxs6l6Unlb8bbiiQALNfNr39g
	 4Be8Vo5t5h5uXV/k9RLMnPoO3/RNUNvamzRJZoElVaPTxPB7WzRm0Z6DQ9oCF8hP2w
	 fqunhF5aPo4m+k6haGs1+XbdlaqzNQN0BMjKKd6Z9NhSvcOH5wjtQhVMPNE8tOHIUJ
	 bhAjs6oBPpIZeEsTXuJPe++j926iLBtVOmJwZYAg7cigcDrsbp2f6XvAy/NkdP7CiY
	 /S2LLyH8zqsfZj2yw6yJ0EbqKULWlc7RTfVyoDzq8Bmjl4j+oALqYykjoF/L4vvlH9
	 BcelRSQGrK6ORjngt4h6YfuVVRAIMaMAp0hEzKbJpkA/PK3aBasA18MEZP8ELCir5d
	 IkNoxG7HuFKOXFWkeqb1dJi6lTUPsVqUpDYEZKIIsmpDYXSC1ojwsrmBrtf7afkARA
	 ZF5rBEDothQ6PIxCbasaVjZU/4QukLY2+SnreoKXDloW3Su0eUlboju3nQ0XVrK5KW
	 fsCTGadsi63KVF8j/4d2DJZPttEF/KQSxBkQqpwyP1Qtl1xo0tPVDdhJDh8tGDb4b4
	 IpvJqWhNzLTnpKJqJyMHjMMs=
Date: Mon, 25 May 2026 10:51:35 +0300
From: Manos Pitsidianakis <manos@pitsidianak.is>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Peter Hilber <peter.hilber@oss.qualcomm.com>, Stefano Garzarella <sgarzare@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Bj=?UTF-8?B?w7Y=?=rn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, rust-for-linux@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/6] rust/helpers: add virtio.c
User-Agent: meli/0.8.13
References: <20260510-rust-virtio-v3-0-1427f14d67e1@pitsidianak.is> <20260510-rust-virtio-v3-2-1427f14d67e1@pitsidianak.is> <CAJaqyWexdTrXcVoxxZb+frrfnr+xYCm67GGtWajWY-ygdyJfKw@mail.gmail.com>
In-Reply-To: <CAJaqyWexdTrXcVoxxZb+frrfnr+xYCm67GGtWajWY-ygdyJfKw@mail.gmail.com>
Message-ID: <tfl1yw.godamgwg8dfs@pitsidianak.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed

On Thu, 21 May 2026 12:03, Eugenio Perez Martin <eperezma@redhat.com> wrote:
>On Sun, May 10, 2026 at 3:38 PM Manos Pitsidianakis
><manos@pitsidianak.is> wrote:
>>
>> Some internal kernel virtio API functions are inline macros, so define
>> their symbols in a helper file.
>>
>> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
>> ---
>>  MAINTAINERS            |  6 ++++++
>>  rust/helpers/helpers.c |  1 +
>>  rust/helpers/virtio.c  | 37 +++++++++++++++++++++++++++++++++++++
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
>> index a3c42e51f00a0990bea81ebce6e99bb397ce7533..5dc0d2f2ee6bd2ae8e6abfe4baa247c1963967f6 100644
>> --- a/rust/helpers/helpers.c
>> +++ b/rust/helpers/helpers.c
>> @@ -61,6 +61,7 @@
>>  #include "time.c"
>>  #include "uaccess.c"
>>  #include "usb.c"
>> +#include "virtio.c"
>>  #include "vmalloc.c"
>>  #include "wait.c"
>>  #include "workqueue.c"
>> diff --git a/rust/helpers/virtio.c b/rust/helpers/virtio.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..46aeeb063158823e66477777b3cd4bd1525df330
>> --- /dev/null
>> +++ b/rust/helpers/virtio.c
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#ifdef CONFIG_VIRTIO
>> +#include <linux/virtio_config.h>
>> +
>> +__rust_helper bool
>> +rust_helper_virtio_has_feature(const struct virtio_device *vdev,
>> +                              unsigned int fbit)
>> +{
>> +       return virtio_has_feature(vdev, fbit);
>> +}
>> +__rust_helper void rust_helper_virtio_get_features(struct virtio_device *vdev,
>> +                                                  u64 *features_out)
>> +{
>> +       return virtio_get_features(vdev, features_out);
>
>As a suggestion, perhaps an API that allows getting feature bits > 64,
>like VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO (65) or VIRTIO_NET_F_IPSEC (70)
>could save the need to add more functions in the future.

Yes, this will be needed indeed. I think however that as long as no 
driver that uses features exists, this would be dead code so we should 
not include it until it's needed.

I plan on dropping these helper bindings that have no user in my patches 
in the next revisions.

>
>> +}
>> +
>> +__rust_helper int rust_helper_virtio_find_vqs(struct virtio_device *vdev,
>> +                                             unsigned int nvqs,
>> +                                             struct virtqueue *vqs[],
>> +                                             struct virtqueue_info vqs_info[],
>> +                                             struct irq_affinity *desc)
>> +{
>> +       return virtio_find_vqs(vdev, nvqs, vqs, vqs_info, desc);
>> +}
>> +
>> +__rust_helper void rust_helper_virtio_device_ready(struct virtio_device *dev)
>> +{
>> +       return virtio_device_ready(dev);
>> +}
>> +
>> +__rust_helper bool
>> +rust_helper_virtio_is_little_endian(struct virtio_device *vdev)
>> +{
>> +       return virtio_is_little_endian(vdev);
>> +}
>> +#endif /* CONFIG_VIRTIO */
>>
>> --
>> 2.47.3
>>
>
