Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9A39A05F
	for <virtualization@lists.linux.dev>; Mon,  6 Apr 2026 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505888; cv=none; b=FoxpWpUADEx+J+00IRMm7+NuvVXpZLrz13geZm4LXl8qsTbMYmySpgRvj7NPVlhRFUOP40IFuf3TR/Q6eU6jDUqHOhCum9cuPLY/hvJGPW3XDBQHehiSL2Tnr+6ldGcLMgOB1MjhkeWGgNIsSpOrOXnVrxYPhCqyOCm7F+uQv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505888; c=relaxed/simple;
	bh=BVBjRU8R+cBS4ShnNkWw2geTEpx0uy5I1ASSk5q7N0Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uUdHNPP0PNHhOIUcfAkTkA2O43udkbSWP9aLjDY8vC6+iFm9SWfoqBmE6lRzpvz9pZMEzZAmwRpChNA5HvNr2wCPkd0GsXHKInTopZ/nfWhJJ3/dnzeHSNLIBLsf0Cpg3peWtZfKOTEs/IyJNVJ+iDeTECb4Z/3ApxaIPUfSaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=ejQHUZYW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="ejQHUZYW"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c280322e0so514670166b.0
        for <virtualization@lists.linux.dev>; Mon, 06 Apr 2026 13:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1775505880; x=1776110680; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9PRdhuyqvsBKCnvXw6TdIqodY8RtCaLeWXlPrboPE4=;
        b=ejQHUZYWsufEi2G8Bk5IHF+7F/Zs04Psh+XnizOIUdChaGw0CFPd3XfE2P0kaXN9jR
         Ff5lqbqi4cXIqLqHafT7xOMMgF44M5+iOnl0HFVwT181YOmTIFKf93FgVWhpQdXlF+8/
         exNs414D+bI2BhX7HhXqasnrJT1He3Q+Xz5FFaoe7Wboi0DQJKKTe9xeKRY1rZhQOjam
         8y4uzxuu4U/XZWMAh02nzXE9sUJ/QU4byr8UeU4ij/ef6RuHPlyHGWo77eaEmz0hPh0k
         WyC+HWPXJc9i7xc77ETdZMik1EjxN9FOY1WbPncoKocHqn0ri3ax34JdOIES7pYZlNtX
         IlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505880; x=1776110680;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9PRdhuyqvsBKCnvXw6TdIqodY8RtCaLeWXlPrboPE4=;
        b=DD3NVZoZ4lUAmJC08hYicMgz4dF3g8SHs/Dzl9yxla00z8RZN2WxBFYp8CD3qVbyfz
         /9wZgmBuJi7D+KSkclt5fb+PmXikP17BFi1hKPkIiq5PjpqBGCdZNdKSMxNqREcpcdaf
         qYR0j8EKaHo9gvsjaBDxL9kx76rbNvMDznm1sB+Yi3EdNWmN0r/fO+W7A49A62jXXDi/
         ketdYqYSJEvxnb+x2YbvFbl0cvPbwnBEy4JrFbfTWmxKfY2psNQ9EDnXXhJD6c/ksu4h
         Xx3gcIIuRyUpxLkgFeFFKwtKwi9D4zLz0h9UKQC7Nu4li6WA8PGjSNb4C3Hn9SWu7+Oa
         Clxw==
X-Forwarded-Encrypted: i=1; AJvYcCWG3ZXkueB9vqtReScvNkfs/zskWPJaf8SWH86deotSg5ioHNg3caBHZYsm0IBfCvCjUZjMEghPdD+oyp3K3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqmIp/PslO716fOOcgcP1Z/vO2NwVOqruEa458v8h/zPvfrKUq
	cTZU3tdbKpqIymcnfDEIiwrnqUDj3Ul6NgUrinjCGDoXqMhQ7lpn/WdKt7B2CGntqQY=
X-Gm-Gg: AeBDieuK6/GHZ8CffkZdE89EfYIpTjnPzM8FU/QgCw2npzBn6+v8PawDAxaSBndYp0M
	/JB11XwnT0SewA2hY+bNZU+d8DYkVcGR6QgXgZ274czaQMZ6qV3Buzhvmbq36MCm4rGY6RBuMf8
	onpxmQC2cKKMrC0s6R4I+GXUH6i8cRTPmX6ayImXoT/tG3UUEhDgioos96Z0UHG/oZlV8UqwS0p
	igD/7QGCcDNnJviXBBPYUth3kaTy7L1ADOaefCPIUuMPiZY/WYe86Wc5y/DfOG4o0WNZtnmYuGj
	uxakC3hpHLbK8LECDbx98P6mq9VXQXDRm8xyZTfaSnEOotTYdMxwjjkkML2xBwJx6edE/7/H6dr
	otpCJ2DBMU4QZ+oPxm7NoIjfFhO5v/1rD+w+BkyjOCn6n+Jqq84MkltzglAlcz1uHzkIxHzAzVp
	QMRHp5zkBkOcXBSiaVP8aYOnmL5Y7Lea1+K1pO8fv2oZNibT6Qa9kRkR6spG6SVHfDljR8RoDvU
	ZqiCGPCDy9MwKs=
X-Received: by 2002:a17:907:72cc:b0:b9c:ccbf:bf14 with SMTP id a640c23a62f3a-b9cccbfc069mr268486966b.41.1775505879586;
        Mon, 06 Apr 2026 13:04:39 -0700 (PDT)
Received: from smtpclient.apple (83.10.27.44.ipv4.supernova.orange.pl. [83.10.27.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cad1350sm488788566b.28.2026.04.06.13.04.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 13:04:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH v2 net] vsock: fix buffer size clamping order
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <102981F1-2CAE-481F-8FAE-4F3085E25E89@doyensec.com>
Date: Mon, 6 Apr 2026 22:04:26 +0200
Cc: davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 John Villamil <john@doyensec.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <69317E49-40AA-4985-8A4E-447C58665A68@doyensec.com>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
 <acuKUpZQq6z1DY_n@sgarzare-redhat>
 <102981F1-2CAE-481F-8FAE-4F3085E25E89@doyensec.com>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hi,

v2: fix indentation/whitespace issues in the previous patch.

-- >8 --
=46rom f5d160167c862c7f2ad6e6a1d4181d01997b683a Mon Sep 17 00:00:00 2001
From: Norbert Szetei <norbert@doyensec.com>
Date: Mon, 6 Apr 2026 19:52:52 +0200
Subject: [PATCH] vsock: fix buffer size clamping order

In vsock_update_buffer_size(), the buffer size was being clamped to the
maximum first, and then to the minimum. If a user sets a minimum buffer
size larger than the maximum, the minimum check overrides the maximum
check, inverting the constraint.

This breaks the intended socket memory boundaries by allowing the
vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.

Fix this by checking the minimum first, and then the maximum. This
ensures the buffer size never exceeds the buffer_max_size.

Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
 net/vmw_vsock/af_vsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d912ed2f012a..08f4dfb9782c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1951,12 +1951,12 @@ static void vsock_update_buffer_size(struct =
vsock_sock *vsk,
 				     const struct vsock_transport =
*transport,
 				     u64 val)
 {
-	if (val > vsk->buffer_max_size)
-		val =3D vsk->buffer_max_size;
-
 	if (val < vsk->buffer_min_size)
 		val =3D vsk->buffer_min_size;
=20
+	if (val > vsk->buffer_max_size)
+		val =3D vsk->buffer_max_size;
+
 	if (val !=3D vsk->buffer_size &&
 	    transport && transport->notify_buffer_size)
 		transport->notify_buffer_size(vsk, &val);
--=20
2.53.0


> On Apr 6, 2026, at 20:41, Norbert Szetei <norbert@doyensec.com> wrote:
>=20
> Hi Stefano,
>=20
> I like option 1 the most, as it is the most straightforward way to fix
> the issue. I am including the patch below. This fixes the clamping
> mismatch, but as you pointed out, it won't solve the root problem
> regarding the issue to arbitrarily set a maximum buffer value.
>=20
> Since VSOCK uses a unified buffer size rather than separating read and
> write buffers like the core stack, introducing a vsock-specific sysctl
> (e.g., net.vmw_vsock.buffer_max_size) seems the cleanest approach to =
me.
> I was also considering net.core.wmem_max/rmem_max, but mapping to =
those
> feels less natural.
>=20
> If you agree with the vsock-specific sysctl, or have a different
> suggestion, let me know and I will send a follow-up patch for that.
> Thanks.
>=20
> Best, Norbert
>=20
> -- >8 --
> =46rom f5d160167c862c7f2ad6e6a1d4181d01997b683a Mon Sep 17 00:00:00 =
2001
> From: Norbert Szetei <norbert@doyensec.com>
> Date: Mon, 6 Apr 2026 19:52:52 +0200
> Subject: [PATCH] vsock: fix buffer size clamping order
>=20
> In vsock_update_buffer_size(), the buffer size was being clamped to =
the
> maximum first, and then to the minimum. If a user sets a minimum =
buffer
> size larger than the maximum, the minimum check overrides the maximum
> check, inverting the constraint.
>=20
> This breaks the intended socket memory boundaries by allowing the
> vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
>=20
> Fix this by checking the minimum first, and then the maximum. This
> ensures the buffer size never exceeds the buffer_max_size.
>=20
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
> net/vmw_vsock/af_vsock.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index d912ed2f012a..08f4dfb9782c 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1951,12 +1951,12 @@ static void vsock_update_buffer_size(struct =
vsock_sock *vsk,
>     const struct vsock_transport *transport,
>     u64 val)
> {
> - if (val > vsk->buffer_max_size)
> - val =3D vsk->buffer_max_size;
> -
>  if (val < vsk->buffer_min_size)
>  val =3D vsk->buffer_min_size;
> + if (val > vsk->buffer_max_size)
> + val =3D vsk->buffer_max_size;
> +
>  if (val !=3D vsk->buffer_size &&
>    transport && transport->notify_buffer_size)
>  transport->notify_buffer_size(vsk, &val);
> --=20
> 2.53.0
>=20
>> On Mar 31, 2026, at 14:37, Stefano Garzarella <sgarzare@redhat.com> =
wrote:
>>=20
>> On Tue, Mar 24, 2026 at 06:28:12PM +0100, Norbert Szetei wrote:
>>> Hello,
>>>=20
>>> we have discovered a bug in AF_VSOCK where an unprivileged user can =
bypass socket
>>> memory constraints. This leads to refcount_t saturation and OOM. =
While
>>> refcount_t prevents a true UAF by saturating, the resulting state =
triggers
>>> kernel warnings and kernel panic, depending on the setup.
>>>=20
>>> In vsock_connectible_setsockopt(), the SO_VM_SOCKETS_BUFFER_MIN_SIZE =
and
>>> SO_VM_SOCKETS_BUFFER_MAX_SIZE options are used to update the =
buffer's minimum
>>> and maximum values independently.
>>>=20
>>> The vsock_update_buffer_size() function clamps the buffer size to =
the maximum
>>> first, then the minimum:
>>>=20
>>> // =
https://github.com/torvalds/linux/blob/c369299895a591d96745d6492d4888259b0=
04a9e/net/vmw_vsock/af_vsock.c#L1950
>>> if (val > vsk->buffer_max_size)
>>> val =3D vsk->buffer_max_size;
>>>=20
>>> if (val < vsk->buffer_min_size)
>>> val =3D vsk->buffer_min_size;
>>>=20
>>> vsk->buffer_size =3D val;
>>>=20
>>> By setting buffer_min_size to a large value, the second clamp =
overrides the
>>> first, forcing vsk->buffer_size to exceed the intended maximum. The =
transport
>>> layer then uses this value, allowing unbounded SKB allocation that =
saturates the
>>> 32-bit sk_wmem_alloc refcount.
>>>=20
>>> The fix should ensure that SO_VM_SOCKETS_BUFFER_MIN_SIZE cannot be =
used to set a
>>> value higher than the current buffer_max_size. Conversely,
>>> SO_VM_SOCKETS_BUFFER_MAX_SIZE should not be allowed to be set lower =
than the
>>> current buffer_min_size.
>>=20
>> Okay, but that wouldn't change much. As long as the user sets the =
maximum to match the minimum you set in the POC, it behaves exactly the =
same way, right?
>>=20
>> Maybe we should add a sysctl to set a global upper bound, but this is =
another problem, I agree that we should improve the kernel behavior =
around min/max.  I see 3 options:
>>=20
>> 1. Just invert the checks, fist check for min, then for max.
>>=20
>> 2. Simply adjust the min and max values so that they make sense. For =
example, if the minimum value being set is greater than the maximum, the =
kernel could adjust the maximum to the same value. However, this would =
not change the behavior of your POC.
>>=20
>> 3. Force the minimum to be less than or equal to the maximum. This, =
however, would require a certain order when setting the minimum and =
maximum, especially relative to the default. For example, if you =
increase the minimum beyond the default maximum, you must adjust the =
maximum first; conversely, if you want to set the maximum below the =
default minimum, you must adjust the minimum first.
>>=20
>> I'm more into 1 or 2. 3 IMO is too much.
>>=20
>> Do you want to send a patch?
>>=20
>> Thanks,
>> Stefano
>=20
>=20

