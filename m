Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841712;
	b=y1yjPUIN8E7IFYo/Q7aXpIFgqeV0FrrWtW0kFfA7rFEikm6Jwf9s3LXPTwlXCm9JLtJ4
	 dG8fJb3SluCsGKNdY8/F3sD5jklXadkZb5itB1yKWOVyj7QlHbrpLJBST/mp9wsRpg1Xd
	 GurWeqyMR8xOow6NaC4CykKvLdMbYtvS3t+C0ZEyWxQasyyQHrkzA1o6Uxg3+987ybuRi
	 U0YagwVZAuY8BhojM+39So5Q7IoI+A4dmr7Z6bKGJpVWCMDCcD9H2mdhsEVg4QV0YWKiZ
	 ss49QVDSE+ILl/iVvqyvxvBNxLH32UyZqkIlOPX9yvLRfqVuP2FDTQnK3+LYKzbpiyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MZdkfGsnek7E6N0INFbRzSJOWSi2Eq2ISwL7lVeYPRg=;
	b=wjjS5Xr073HqUbb0djF7I3UL+lJi6XjYnT59O4Ri6QLElAVXcLQgFFffsowP2peZTMTR
	 Gs3YbSet8qusLSvDUgEUWTv49TAdX3Bb600+8NGZlXnojYk2wCAwEslXY5zK97A++hUH+
	 WS9FmxVPKzJc8eKovmSfOgJ95mqoPlIS6GSaNg30eOF7lyLA8Hk7Qha/RlSCGnqhZUcB/
	 e7aWwJrxgZrO8C0MWpicYEff/69U8XJJhVg5GV4U1uOy3F1HkUTIByYkGxQ4/wHlVS5HK
	 qKYeGuqsZMWjNwxiY7Q2pI2Vz9absKd7BhGVUIW1mYiq+DmsbfXxVN9/KldWSRcqixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0qqrhVl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAB606A329
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0qqrhVl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F891F000C4;
	Mon, 16 Nov 2026 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841712;
	bh=MZdkfGsnek7E6N0INFbRzSJOWSi2Eq2ISwL7lVeYPRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0qqrhVliCXaAGZ7vhwmeCRpCOJnknC9oOPdF8MEm5kVN325IM2TbOnolXr39g2Rk
	 uixO1/A5eLL5BJZTJ658ZjhsjDz20eDlCcj8iZIOhPbk1gsah7BJIljfFHohmDru2r
	 kdKnHwE2tv9r9yWo9FR55QgxFufhjfVwEflFGhwsRPixuWGWkrJVg/XWCy1oFxvk5d
	 j2VM5EUVOLWbgFwhQTUR+eRmZiyk/v7UGAB2Tr6F8JuwwcBNpEy/26eijiXdlgQxAT
	 tXLSO2XE/b3NXJlxphTuNa2xIPInA5fcneY7hssfS0zSlH+ynyAevihGeE2Dk7NGFb
	 gb9XhbuoSwWSg==
Message-ID: <sashiko-outbox-217232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/12] x86/msr: Remove rdmsr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261116150208.1572254-11-jgross@suse.com>
References: <20261116150208.1572254-1-jgross@suse.com>
 <20261116150208.1572254-11-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:08:31 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> rdmsr() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116150208.1572=
254-1-jgross@suse.com?part=3D10

