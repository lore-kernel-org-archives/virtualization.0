Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795843176;
	b=t/h4t/EygfT9hW1MQzqmFgCFiqzkSH0sHyDMaqv2ED4DK+VU0VotT5MxIcJza223Q0uS
	 EY1asBRg6Xlvo/3jmgzGmt3Uq1EOSj3NBkvwKjtwWZxKuMghn+IUooyT8No4nt9/GKDqJ
	 QL0MWBPdb0V6G3cQmUjw72Ge/CkHofxB2LbNFL6+2l2i50pBn+905yoxf/QTpYCg4Yo1u
	 DAyWZry0k06SLBLjhV9wZY3rfdD2HKschccV5sffOzRyjpOc3Qm+RJb6PN/rr4VRREFk6
	 2wWbpgKqEJP6i6YxJLuTXopCnTgnMmCvSIwSQsOrPP3wgyxPIA0PtUaMqFhR+jMbq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795843176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xGN7LVdkKHGQx1MpnuDSn6mI6jqoBhY6IEYd/gQNzLk=;
	b=2jkBc15fjPdyDSkrb3ux5FqKKRVq61HvfIvlc9txPNeTICK6jDET8Lp8OmLfQEmGCxzR
	 iR6+wmBv63H3wmk+e38ON0jRaN48TGNpKV60nJZ2IlqvLyC96mJF4Gr3jdgDTIGMRZDcX
	 0FqDKe9GeNVdW5md+XR3QX3QSeGckG6viJ/PuaCb58qvbUOPM0CYY25Nb6n8ckaEg6M2X
	 AioWvjNAuHFnJLf+1y3zkvSZed9prU2EwuTVv1xHX2ZacNZztzvUv/EN9TfgB3eoi2/8O
	 7s3q2F/T/SxSM1v6aZ1ZSz3CCjmJ38SMBXndS93qT7aJIE+RakNRAdTq3q9iIrg5B+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G+/RvX7z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CE606A31C
	for <virtualization@lists.linux.dev>; Sat, 28 Nov 2026 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+/RvX7z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0501F000C1;
	Sat, 28 Nov 2026 05:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795843175;
	bh=xGN7LVdkKHGQx1MpnuDSn6mI6jqoBhY6IEYd/gQNzLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+/RvX7zlWHbK69q8otYITJ3I9Bh7IbTuCt/V3c6xxFgMFjnu9xpAkvuhlv8x27Tc
	 26/W7Wsqif7Xr71O0oRB/Ui5tXjOKX1BGh43e/PJAAd3HQgccMrJFfH6b1Txl5N9kd
	 aHbYbYSbXdgJd/vaP86BWt/v1WZsiatFPHwmx5jQYX7TmWaVbpNvBH+SP7r13m9m0D
	 wVK+4fz423Drj8Q9Dm/vxfgeKzJ2MIoo+FatopdEhcreq60hsAp/CC19IGQd2oUMnM
	 1ZumMwiOrgzMqufnikCRCvK5EWeko3Li7PUhKw4ELkR6w7xyvlmy7FRKSRhwBxu4il
	 C2fbMnvdY8nuA==
Message-ID: <sashiko-outbox-238470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add stream MSG_WAITALL receive
 timeout test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <503c1d5538f5b41f8eda756f5ea4491f0bd44518.1795591531.git.caoruide123@gmail.com>
References: <cover.1795587333.git.caoruide123@gmail.com>
 <503c1d5538f5b41f8eda756f5ea4491f0bd44518.1795591531.git.caoruide123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 05:19:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vsock/test: inserting test in test_cases[] shifts IDs and
  breaks vmtest.sh
--

commit 3fdae506954ede6076a29bc4c547728169cd474c
Author: Ruide Cao <caoruide123@gmail.com>

vsock/test: add stream MSG_WAITALL receive timeout test

This commit adds a SOCK_STREAM receive timeout test that verifies
recv(MSG_WAITALL) enforces a cumulative SO_RCVTIMEO timeout across
partial drip-fed reads.

> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock=
_test.c
> index 10b9074fb87f7..868792f7729cf 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c

[ ... ]

> @@ -2739,6 +2846,11 @@ static struct test_case test_cases[] =3D {
>  		.run_client =3D test_seqpacket_timeout_client,
>  		.run_server =3D test_seqpacket_timeout_server,
>  	},
> +	{
> +		.name =3D "SOCK_STREAM MSG_WAITALL timeout",
> +		.run_client =3D test_stream_timeout_waitall_client,
> +		.run_server =3D test_stream_timeout_waitall_server,
> +	},
>  	{
>  		.name =3D "SOCK_SEQPACKET invalid receive buffer",
>  		.run_client =3D test_seqpacket_invalid_rec_buffer_client,

[Severity: Medium]
Does inserting this entry in the middle of test_cases[] shift the numeric
test IDs and break tools/testing/selftests/vsock/vmtest.sh?

test_ns_same_local_host_connect_to_local_vm_ok() in vmtest.sh passes
--skip=3D29 to skip "SOCK_STREAM transport release use-after-free":

tools/testing/selftests/vsock/vmtest.sh:test_ns_same_local_host_connect_to_=
local_vm_ok() {
    ...
	# virtio-vsock (G2H) does not support local namespaces, so skip test 29
	# (SOCK_STREAM transport release use-after-free) which requires a
	# local listener in the same namespace.
	host_vsock_test "${ns}" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}" --s=
kip=3D29
    ...
}

Inserting the new test here shifts that test from index 29 to 30, so
--skip=3D29 skips "SOCK_STREAM MSG_ZEROCOPY leak completion skb" instead
and runs the incompatible test.  Appending the new entry at the end of
test_cases[] keeps the existing test IDs stable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795587333.gi=
t.caoruide123@gmail.com?part=3D2
