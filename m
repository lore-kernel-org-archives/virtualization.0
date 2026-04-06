Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA4390980
	for <virtualization@lists.linux.dev>; Mon,  6 Apr 2026 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500886; cv=none; b=VrRB7eKBhfFzil9TChEPnnLsroOd1RNspa67wKcrYtX1IoI/1JTYAmDIYiRLyLhOPS0e1r9L/K3xgvX4brn2EjWiEpTW5jRVe1dlAy2uI6lAtUAv1NS28fmrt81q1ncBEkbIcpiJGkhLOn9iF2c2WoeYWcWj1iynyidksCr7+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500886; c=relaxed/simple;
	bh=kyZtKgfDTMnWtgVFhQnsWqmq0e21Xma/ta0AOxW1IEk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LdMa5/OzIFa/qhcHVj5rLCfNidcuZhqeqKz0ddhT45JXJ2gql+GVVjQKI4UcMRRvCOhmXdMrKSEhCQat8o3ndGN1aOqrTJY3ndedmPnozib7UeBGXPrHQ2Bz+SrO3M+aGMAs4UdY4dyzVBzq+brZtr5shIie7/OUnMQNXb16TiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=epZmzHe3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="epZmzHe3"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c01854477so690820966b.0
        for <virtualization@lists.linux.dev>; Mon, 06 Apr 2026 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1775500883; x=1776105683; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP/yvoRepvhIHG6haXf5odvDzcCl89qKQZxzI6ipHkE=;
        b=epZmzHe3hm00TBh6qSKkxdHU0a0ToETktU4HWmayUWMDTcREIc7f3BKFY6vL1OmZtj
         QQWQyI5rOdpdZIcF0ZA9VJgdfOYhhf3OEjf28QcapfJqRYfc+qltGrCLtbxa/UjctoCT
         Fa86yjjssfAP7dsXsbjSAPt0L7w4rXRRUIa7sOxU6ZTPufEiiTZuMH7RfDwDFZdWc2Au
         TH1htFDLaCu4zlhhkhzcLssYHq96EqiESdokGRhRML6u1DNzvxctjEQM169iOT64H7El
         Y2rGMKf8dQmp4FCRhOLBFnL8jRF1sOkrAZ65SfX37NQASv3uETevw7rILzI1NxQW9Cvs
         4wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500883; x=1776105683;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vP/yvoRepvhIHG6haXf5odvDzcCl89qKQZxzI6ipHkE=;
        b=U7LF4myo0Pj+A8bz+YdrrhVWBUkRwmX4qBrFdV32aOZIbBQ7Poz9kQ8Tu3AnJwql/r
         MjdOW1GywOq1gfv8sxbmNnFBcvqMYvz8TTpN457o0brsJHsOKOgT3pCGsXOiPwkDzsUa
         vndugI0FfrJ5fCYHP92BKUWuDgAF7+tk2kDH2fUDUscXjfLsIfkI/vA795Oo5WirNEGv
         JBu3HF4fGALOPsvhgRc7n7UqYQG7XP0TT8p73/kfLej+3paJWdOYd2ubFBpeYMdCOUZa
         1M8t/zbTknIR7db7X6U0HBtLAIaM0Dl0z86sfleeIDF1ubwHrs0nCqhesQE/fmd2NBfp
         x1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVfJD2sc7l/CCGd2tMmARSv6y31Fnqf6vO4+iDlTVNyu2G/sd7AmpmExMyx+ilEGwfNN3To0Sam7xsUqa3vhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfslX3uo/f6cf90eCuoZ2tvOwh3D4WVmSPOS+QJ1P0QW1w/H3x
	bfekjtnE7KnTSA/pwIFB6TRJgCEXl7sh2d0uQncIKUOIFIOw87inRUio+9Mq1DojRLM=
X-Gm-Gg: AeBDietI0PE70TsMM0Kd3hUrfrtF5a/OR7zakTTT5MhFRepk5YbvOr0DfAFfxomolXz
	dhZicpPS1SDK0bvOSlfu3RHWfU6MDx/un22orcgLTDmRNxt8bCVA7DcqLHVZ5Ye6BuVj8ze8i1i
	UTrANQjnwfMgVjSV02u7Bhzgs5I92HSWlTInSKeq8VCZFdJpfwglpRBGC1F7xS9st95LYHAlm5s
	+DwD7/S+U+3f/sFs3nAwCVERH91VHRjS5y7isLbrEpS68RHzK+YnP21chNtBkeSt6iFCOnNPzP9
	FuHJ7eqFmJ6CYL3PzUJ7tp2qkD0APo+gV+0306IEPwNwDPHZMy711Aulpvven/8UVWejCjVaz9E
	BLEOd5pTcX6XncVJJffig1vJ5KwIO9G/ZFY6eEYK0oEQf3spf+kN0luc7p/WCnE2tJMHRAZo9ib
	IudqybQVmcAwY5/AATtyzj/jjO0Snie19T60gprjA8zPihuP3Ba8fzfqLz6YOMpwl/lYzxoDseP
	Jr22vrho/m9VZM=
X-Received: by 2002:a17:907:3f90:b0:b98:482:8ed7 with SMTP id a640c23a62f3a-b9c679e1ec2mr638754966b.38.1775500882177;
        Mon, 06 Apr 2026 11:41:22 -0700 (PDT)
Received: from smtpclient.apple (83.10.27.44.ipv4.supernova.orange.pl. [83.10.27.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972181sm490323566b.8.2026.04.06.11.41.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 11:41:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [BUG] vsock: refcount_t saturation and OOM via buffer size
 invariant inversion
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <acuKUpZQq6z1DY_n@sgarzare-redhat>
Date: Mon, 6 Apr 2026 20:41:10 +0200
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
Message-Id: <102981F1-2CAE-481F-8FAE-4F3085E25E89@doyensec.com>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
 <acuKUpZQq6z1DY_n@sgarzare-redhat>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Hi Stefano,

I like option 1 the most, as it is the most straightforward way to fix
the issue. I am including the patch below. This fixes the clamping
mismatch, but as you pointed out, it won't solve the root problem
regarding the issue to arbitrarily set a maximum buffer value.

Since VSOCK uses a unified buffer size rather than separating read and
write buffers like the core stack, introducing a vsock-specific sysctl
(e.g., net.vmw_vsock.buffer_max_size) seems the cleanest approach to me.
I was also considering net.core.wmem_max/rmem_max, but mapping to those
feels less natural.

If you agree with the vsock-specific sysctl, or have a different
suggestion, let me know and I will send a follow-up patch for that.
Thanks.

Best, Norbert

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
     const struct vsock_transport *transport,
     u64 val)
 {
- if (val > vsk->buffer_max_size)
- val =3D vsk->buffer_max_size;
-
  if (val < vsk->buffer_min_size)
  val =3D vsk->buffer_min_size;
 + if (val > vsk->buffer_max_size)
+ val =3D vsk->buffer_max_size;
+
  if (val !=3D vsk->buffer_size &&
    transport && transport->notify_buffer_size)
  transport->notify_buffer_size(vsk, &val);
--=20
2.53.0

> On Mar 31, 2026, at 14:37, Stefano Garzarella <sgarzare@redhat.com> =
wrote:
>=20
> On Tue, Mar 24, 2026 at 06:28:12PM +0100, Norbert Szetei wrote:
>> Hello,
>>=20
>> we have discovered a bug in AF_VSOCK where an unprivileged user can =
bypass socket
>> memory constraints. This leads to refcount_t saturation and OOM. =
While
>> refcount_t prevents a true UAF by saturating, the resulting state =
triggers
>> kernel warnings and kernel panic, depending on the setup.
>>=20
>> In vsock_connectible_setsockopt(), the SO_VM_SOCKETS_BUFFER_MIN_SIZE =
and
>> SO_VM_SOCKETS_BUFFER_MAX_SIZE options are used to update the buffer's =
minimum
>> and maximum values independently.
>>=20
>> The vsock_update_buffer_size() function clamps the buffer size to the =
maximum
>> first, then the minimum:
>>=20
>> // =
https://github.com/torvalds/linux/blob/c369299895a591d96745d6492d4888259b0=
04a9e/net/vmw_vsock/af_vsock.c#L1950
>> if (val > vsk->buffer_max_size)
>> val =3D vsk->buffer_max_size;
>>=20
>> if (val < vsk->buffer_min_size)
>> val =3D vsk->buffer_min_size;
>>=20
>> vsk->buffer_size =3D val;
>>=20
>> By setting buffer_min_size to a large value, the second clamp =
overrides the
>> first, forcing vsk->buffer_size to exceed the intended maximum. The =
transport
>> layer then uses this value, allowing unbounded SKB allocation that =
saturates the
>> 32-bit sk_wmem_alloc refcount.
>>=20
>> The fix should ensure that SO_VM_SOCKETS_BUFFER_MIN_SIZE cannot be =
used to set a
>> value higher than the current buffer_max_size. Conversely,
>> SO_VM_SOCKETS_BUFFER_MAX_SIZE should not be allowed to be set lower =
than the
>> current buffer_min_size.
>=20
> Okay, but that wouldn't change much. As long as the user sets the =
maximum to match the minimum you set in the POC, it behaves exactly the =
same way, right?
>=20
> Maybe we should add a sysctl to set a global upper bound, but this is =
another problem, I agree that we should improve the kernel behavior =
around min/max.  I see 3 options:
>=20
> 1. Just invert the checks, fist check for min, then for max.
>=20
> 2. Simply adjust the min and max values so that they make sense. For =
example, if the minimum value being set is greater than the maximum, the =
kernel could adjust the maximum to the same value. However, this would =
not change the behavior of your POC.
>=20
> 3. Force the minimum to be less than or equal to the maximum. This, =
however, would require a certain order when setting the minimum and =
maximum, especially relative to the default. For example, if you =
increase the minimum beyond the default maximum, you must adjust the =
maximum first; conversely, if you want to set the maximum below the =
default minimum, you must adjust the minimum first.
>=20
> I'm more into 1 or 2. 3 IMO is too much.
>=20
> Do you want to send a patch?
>=20
> Thanks,
> Stefano


