Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1D50B408;
	Wed, 30 Sep 2026 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785996; cv=none; b=J54gvg71B0/Jsu+6FzsqQkpRqzUedD9wEaGPwt3PIQjZ848iFbKrHbDXW+XrmncIR16JdU0+e9IpCA9VdG8fB9zxRuMhSxb9F5MAgH4NptN6VQI3EPtzkVi95wqsWmH1FJma/GexF07s4Db2uG69/38m8h+NZqTN2eZrUsLc1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785996; c=relaxed/simple;
	bh=PZClB3hcHr0mBs5SluinIGMwc8ztR2078weyUcJ7Alk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=icq0VoDKD+/CR86lTzc1Ru4L8/8SdRaXFNjRB8b4G4rereHFflFWYa8ZooYSi0gRhg4O1leTcreSirn6/GYnDzmV3FZVdKDxuuNZR6rmtj7hN+HyUT7uKSWw0cm6bWOtk/BXZ9BgtZNeiVE7kQ2afO6vcyZYNXpEBnkbTMpsY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIKGiiZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIKGiiZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC631F00893;
	Wed, 30 Sep 2026 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790785995;
	bh=N6EYaOFVfqRRamRYn4UitDg1nDKbxgTcdr2wLMEiLb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eIKGiiZEuHMPM4i2BOPzx7/KwrGhZa+jz1wOX08OiQ7tG277WtEmg+B6mapmB5b+Z
	 gswZNeGIaC7wBO72MP/dSCXMK5M/Czstl/uVKGuW6u9EPvfXAMIDk+NAMIP3DP6RnO
	 bN+VeCTtDotIp8/lwLQMziEOvwaHQm7wTxRpTH/WHWbiI8gaa8TP8CpiPF8sllbUnR
	 9Vly6SMeu6dN0gY5C1qwuhM6YHAYhIxhyGU39LzmuZKIg6ELhIYR39l4E+EiWr97Rk
	 8bq+xtDv/Eqp/3IOUVLxf/XHNeir011q5kC0eAG8TsngMjtotfi3Q9H77eSwbIJSuW
	 lGyqy+w3ZqqMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] vsock/bpf: release sock lock while waiting for data
 in recvmsg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Mohm" <jrmmhm.kernel@eldare.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
References: <20260929-kbh3-1-022-fix-v1-1-cc97cc95d269@eldare.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 16:33:14 +0000
Message-Id: <20260930163315.4EC631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vsock/bpf: blocking recvmsg returns -EAGAIN on EOF/errors
--

commit 8e70f21df314d9898f7fd2e5b9f42b2d7a42d677
Author: Jerome Mohm <jrmmhm.kernel@eldare.de>

vsock/bpf: release sock lock while waiting for data in recvmsg

This commit modifies vsock_msg_wait_data() to drop the socket lock while
sleeping in wait_woken(), and reacquire it upon waking. This prevents the
transport's delivery context from stalling when a blocking recvmsg is in
progress.

> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index 9049d26486460..bb7d81a95baa6 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -50,7 +50,9 @@ static bool vsock_msg_wait_data(struct sock *sk, struct=
 sk_psock *psock, long ti
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  	ret =3D vsock_has_data(sk, psock);
>  	if (!ret) {
> +		release_sock(sk);
>  		wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> +		lock_sock(sk);
>  		ret =3D vsock_has_data(sk, psock);

[Severity: High]
Does this check in vsock_msg_wait_data() miss terminal states when
waking up? If the wakeup is caused by a socket shutdown (EOF), signal,
or socket error, vsock_has_data() will return false since there is no
data.

This would cause vsock_msg_wait_data() to return false, which in turn
makes the caller vsock_bpf_recvmsg() unconditionally translate the
result to -EAGAIN:

net/vmw_vsock/vsock_bpf.c:vsock_bpf_recvmsg() {
...
	if (!vsock_msg_wait_data(sk, psock, timeo)) {
		copied =3D -EAGAIN;
		break;
	}
...
}

Could this result in blocking recvmsg calls returning -EAGAIN on EOF
or socket errors, violating POSIX semantics and potentially causing
applications to spin in infinite polling loops?

>  	}
>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  	remove_wait_queue(sk_sleep(sk), &wait);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-kbh3-1-022=
-fix-v1-1-cc97cc95d269@eldare.de?part=3D1
