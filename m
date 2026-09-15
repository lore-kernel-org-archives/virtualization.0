Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12168314A65;
	Tue, 15 Sep 2026 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465922; cv=none; b=ZaYuwBOL6MHFgWFNpyMxpecS2FxfofHLZ7BhHc3tM4N0U7cDFyk/O2XX88CV2ogqvV1n4wevcZNau6XLteF5w0LHwJNGSJi/JHO5QHK+mPHq5C1mGWlTSdOE13uItr76LBLWnTCktE/Ktbg6aBViqdjSdSWh0gNh72J6P4JPiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465922; c=relaxed/simple;
	bh=h1zjG3koTnMKvU+opzsxluwJJeiunRE1iUkSrANAhus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WXY84oV8fqV84Y/Crw77oo41ge+HqRijlIZz6MK9PL1mhsBXd7pdQezHh8JzetyaND9WOm2nicfztmTH8FjEUipTMsGv+V7SqdKH6tO3huCUjjFv+hvUOoxs2oNEhCtpdRPG8abz0S1RMDsmknyIp8X1WGG4gYHYcbf8SULpf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6EjwcNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6EjwcNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620501F000FF;
	Tue, 15 Sep 2026 09:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789465920;
	bh=h1zjG3koTnMKvU+opzsxluwJJeiunRE1iUkSrANAhus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6EjwcNjPTXL4fAW+8YBG5fi9t4gybZUxK2VvwAt+vMDbrm74GLjyZFQWRoAsE5Bu
	 y338hd2fz+53BDhrO2WHbXbm3QfAz5d/XCyJ8NlcslpTCTZ0IN5mar8mj0i3FZsfN4
	 tFSfO9ZJFrphmjVqsqONT8l3bYqiL9wOpx9M2qn6rEadjmGj+1oNUyArpH7+HRrgFS
	 1IA8HCzc58VbEWwxqZoKN00eW/m9vb2CPXg6N7JxlHNlmgsgL7CuAqyflX54MOpcxy
	 0KIMrnPaRfnlr3sreUvMYjrXTfoNW7kb8nip7CaUJ0wzCABr6FHzkVueMyqTXQd+Ao
	 asbs32AdqlfJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] vhost-scsi: preserve event ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: physicalmtea@gmail.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915094244.7900-2-physicalmtea@gmail.com>
References: <20260915094244.7900-1-physicalmtea@gmail.com>
 <20260915094244.7900-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 09:51:59 +0000
Message-Id: <20260915095200.620501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> From: Jia Jia <physicalmtea@gmail.com>
>=20
> vhost_scsi_send_evt() uses llist_add(), so pending events are LIFO.
> vhost_scsi_complete_events() walks the detached list directly.
> This can deliver a later hotplug or hotunplug event before an earlier
> one.
>=20
> Reverse the detached list before processing it.
> This keeps delivery in enqueue order.
>=20
> Fixes: a6c9af87363c ("tcm_vhost: Add hotplug/hotunplug support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915094244.7900=
-1-physicalmtea@gmail.com?part=3D1

