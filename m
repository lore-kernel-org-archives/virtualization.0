Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3532B10F;
	Fri, 18 Sep 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768891; cv=none; b=eeWpyFlJMfN2HuYlmEBnwiDTqCALdF34Yhvna2jFtLnyUS9IiEGrUh1ctCyn9DDrUqc6EEIHUSFFytrt0Be+NAZ2NdWaJOjUm+a+H8WW6CyFysRNmO2jusxES/nrujhvXRwS+KR68U+Pv6TyRH2YecZnqdA3PyBfH0rfloOIRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768891; c=relaxed/simple;
	bh=Fdk/Ms6FtOeNkLHRHudp5YBmg6FIwgshnPYfwsm5kgA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H1w2aWI9W5aKZH+bocC+lZOFbiyoJIOPgftreQB1it0kBlmx1KhEBWRFXzBO89K1plddRLBNWg/XxhJp3WRkrq97dohJs5fuQorM6HUiqMM16CUkRbGkGQZRdLXtbAM9FdN11MOsLlZjxtBXHe/nOJX4i6tHS92ElblhIpQAneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDqQycRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDqQycRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954E71F000FF;
	Fri, 18 Sep 2026 22:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768889;
	bh=HCrlkUQQSDq2VJoHSpWd3U4HAb+9XCnWZoAwII1yTcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDqQycRcqrDpIJlzTEH6KSjl4iLoYgdTetTDNvoLUn1RJILTGqX5OwVVl4Ngqgskf
	 WCUepLaOWFAEBOUx9WZETtOjuPeWXzGUuHWZe2Mg3yKC6lS4JTvjX9jDpqBF8pUGY3
	 yVJ8LcxlSf108LFG9SGVRL4/xm18baatobMxecZ/HFC7phQncL2a9mjm2sMohiyMz/
	 ClG1n1U+kSGeuk/A20yWq5Q4ZThcJQzCstH4xlhYkQgoKhDrFzyKXr3y8sKqQvsYsW
	 iMOO0gCCY2haEX5xx2hj7gRjyAmCYrNXMDDTEZxgGC88besVyt3Pb7aPFD1cIJ5W+f
	 aFq2j4VQWx0NQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] vsock: keep SOCK_SEQPACKET message boundaries on
 interrupted send
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFydMWCb21pZWogRG1pdHJ1aw==?= <bartlomiej.dmitruk@isec.pl>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org
In-Reply-To: <20260917220101.55744-1-bartlomiej.dmitruk@isec.pl>
References: <20260917220101.55744-1-bartlomiej.dmitruk@isec.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 22:01:29 +0000
Message-Id: <20260918220129.954E71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vsock: infinite wait for oversized SOCK_SEQPACKET messages
--

commit 05c4fa125400dc8e76be397870f9646f61e7a31d
Author: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>

vsock: keep SOCK_SEQPACKET message boundaries on interrupted send

A credit-limited SOCK_SEQPACKET send transmits fragments as credit becomes
available, and the VIRTIO_VSOCK_SEQ_EOM flag is set only on the fragment
where msg_data_left() reaches 0. If vsock_connectible_sendmsg() exits via
out_err after a partial send, the orphaned fragments are silently merged
into the next message.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f840498b58afb..3f7f01a7b8cbd 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2250,9 +2250,16 @@ static int vsock_connectible_sendmsg(struct socket=
 *sock, struct msghdr *msg,
> =20
>  	while (total_written < len) {
>  		ssize_t written;
> +		/* For SEQPACKET wait until the whole remaining message fits, so
> +		 * it is enqueued atomically.  A credit-limited partial send that
> +		 * then errors out (e.g. -EINTR) would otherwise leave EOM-less
> +		 * fragments that the peer merges into the next message.
> +		 */
> +		s64 min_space =3D (sk->sk_type =3D=3D SOCK_SEQPACKET) ?
> +				(s64)(len - total_written) : 1;
> =20
>  		add_wait_queue(sk_sleep(sk), &wait);
> -		while (vsock_stream_has_space(vsk) =3D=3D 0 &&
> +		while (vsock_stream_has_space(vsk) < min_space &&

[Severity: High]
Does this code introduce an infinite wait for oversized SOCK_SEQPACKET
messages?

If an application attempts to send a message larger than the transport's
maximum transmit buffer size, min_space will be set to the full message
length.

Because vsock_stream_has_space() is strictly upper-bounded by the buffer
allocation, the condition vsock_stream_has_space(vsk) < min_space will
never become false for these oversized messages.

The transport's -EMSGSIZE validation (such as in
virtio_transport_seqpacket_enqueue()) will never be reached because the
thread will block beforehand. A thread could hang indefinitely in an
interruptible sleep (unless a signal or timeout interrupts it) instead of
immediately returning an -EMSGSIZE error.

Could a malicious peer or guest VM advertise a very small peer_buf_alloc
and cause a host daemon that writes standard-sized messages to hang
unrecoverably?

>  		       sk->sk_err =3D=3D 0 &&
>  		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
>  		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917220101.5574=
4-1-bartlomiej.dmitruk@isec.pl?part=3D1
