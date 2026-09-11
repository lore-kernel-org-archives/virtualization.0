Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1144F550
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113342; cv=none; b=R/PHGaAchDE6UpUt5lfR5U/vD1fH7ZsAA0tumCX+Bb+aMM7ebJc0WjKcVfHHe0FVdkb5yF7I92TAUhkUyAM3W0D0maNuO2HNB/tbHsfudhz+zw1KdeNBDx+BcByGNUWBYUeBDZKVBG830HU8AdRiihYQ839c4RA7GiAnNJXnQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113342; c=relaxed/simple;
	bh=m4q02HueVVSMhHOjUZVrtgqwsGxocrGDt2T3V9NfJQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRO+BLnxZiZZF1h/INn7x51BWRTFq8VJPvuXWctaMTcRvLyndkXTNgm/uhgotZsiQJQIwQN5BYRbBTwLfecF2p+fIN1xHvxPvAWkqGIKpWPEs2mf4IKxCWSe9DFw/x3co/LZ8woSgE5mF4df1kTefBvSxJuiUlQ3M8EHB93hpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsAg3w6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsAg3w6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E3A1F00893;
	Fri, 11 Sep 2026 07:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113341;
	bh=m4q02HueVVSMhHOjUZVrtgqwsGxocrGDt2T3V9NfJQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DsAg3w6rzAtye1e8jP5PlJL65qFAoVFmWaJzbx6J7ldsc5K8AJit6qUSb1tmZwvKv
	 DoZg5dJSXmHWJQsrj2mzN9QKdr/VrXo3ThHeMnWG9gwOXCLv/TghxEGlxnH8GIO/rQ
	 hgX4oIBEBIJUqdvD8RncMMRudNds9xpTrkixuLDZLxJ3Qup7MUegwrA7w9HTHp5Ko3
	 Jpap9xLQs5+0dOfiW/0wlTyYj2JLqTdx8ul7PQgMEL5sJKUNNxZG8gv0pHBLns8e7E
	 t6ckerKqpQwbnJvQr/oxTWDQuWnXP0mHLNsvO26UqmkeGeAs2wT826h4iQOv79OdIT
	 5+TAEkJN21vig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/13] x86/msr: Remove rdmsr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260911074530.3140830-12-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
 <20260911074530.3140830-12-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:55:40 +0000
Message-Id: <20260911075540.E8E3A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> rdmsr() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911074530.3140=
830-1-jgross@suse.com?part=3D11

