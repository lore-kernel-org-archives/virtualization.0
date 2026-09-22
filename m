Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D77954857A;
	Tue, 22 Sep 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084624; cv=none; b=cSr+o7h76h7P6J5C8bTNWPJNw2rrL8y+uhD+liSXhUOzlxn+eUZ0ThSQsJhW4BWXrW+DQvUOKGvCHUFZiNMc3shi0FDK9R4F5sfiMC7/+UKSJw6cdxRi8d9+zdII3oaMKbXoS2kxu9bGBc9LrggUXySp5jHzR6NvUEUvlDc9w+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084624; c=relaxed/simple;
	bh=XoYZH+yOUHf4HF6yjIqqwJQ4q3wAL/sdHgzzwf3GumA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Thz3Ogdg7rMDcVG+XchyAKSoVNY9z+LxCMXDLwF5boHHESL8URk8AobNak+Voy9onsVNGKgHzZNhYIhLVLWBbUCgUu4P9y6i0+TVuKuH+OL+n4aX1+JtLYAaohqSQMZN36pbNvNKAAJH4Xq3aTGMkhSyGg+EsynaCBDT0wCtGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzFf9Pj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzFf9Pj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15311F00893;
	Tue, 22 Sep 2026 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084623;
	bh=XoYZH+yOUHf4HF6yjIqqwJQ4q3wAL/sdHgzzwf3GumA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YzFf9Pj9e6Pc8y2DdyQGVkhzdT9lGd4VHW0xDoaB5DYzNcWrbVop1SycFqWbBiFDh
	 YVC2qHbu+kFu72H7Faza20Q/ovIpMg/x+k9B6yYBI0phXsnrBPx7atCNrpFeRKsxgz
	 w05yRFk1zHQns7bzf38qVXwjOCrfytYfoz3UVEGYYZCokcfCsH2EqLtS95xFn0fvuf
	 zeqZJxby2z0+Lw8PiazgOBtPlig/NM/IJpyMuIEI9Pqb9zdJ6U+wKbxD9YmASbVhyK
	 A2q/UvtVePRwRhcE2X+HQXGB2ZV3JfTQLwQ3TfVGGOew45+GYd4feiH1mrJ06yQZjj
	 0aRX5vr/FQn5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 4/8] vsock: drop the re-assignment logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: kvm@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-4-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-4-78907b8200d4@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:43:42 +0000
Message-Id: <20260922134342.C15311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> On a failed connect(), transport is de-assigned. Connected socket keeps
> transport until close(). Hence, no more re-assigning.
>=20
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-vsock-conn=
ect-reset-closing-v3-0-78907b8200d4@rbox.co?part=3D4

