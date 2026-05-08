Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB533260E
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226215; cv=none; b=b7mZb52Wjz4vsvvv5UQaHKtuLqifUAHgorex39fGjNw/sDbSrEeYp3BR1getJypkJCapEj1vYYJ6Fh+utBYZJnCHVm3E0h7i6Z2scYJnSkCbUCbrnVkUE2xsWD3Tc9VuBGLrilq+H1EFlT9xeBgNe05Xyivc9EWdDeVVRMujv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226215; c=relaxed/simple;
	bh=+Os89qT9lWZoyf0ho5AZI9aaHqEOG1x9v4JqfTAOc7I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UWek5P3ZNjTepSH56oWY7Em7SIvxIDPT9/TydwXOTIZnM8Wn1gql7PBFFZgRAq4Ak+mB5lLnR/tL+4LE0XccF3crHMZR5LZ96Gu6Tv5cRYdTNWW5uFi/6F7WJ1jt1UL5CBFBo4xoH8OxA6hvUNosiQEE4hTVA8DerpMiSm0X1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Nr7sws1Y; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Nr7sws1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778226203; x=1778831003; i=markus.elfring@web.de;
	bh=+Os89qT9lWZoyf0ho5AZI9aaHqEOG1x9v4JqfTAOc7I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nr7sws1YEWbgPX1iuRiH4vT3F+V3pNbFynHdQIAZZQIcg6yVsm4r1IainMtWOMrh
	 A7JWQGRvLHmOhM7GrwzQqRz1CgBVPvVOd/zAB3o9+Bej/AWtEqsvmbiUjYDr8F01t
	 vQRhK4+D5zR1EBCj9/ZGht3h7H2RCDBPH96GlGeruDsAKuxWeLvQTz0/3gnOQU2ow
	 VeL5+G7gVVTVfQgTi41R5JAZoJmKLlb6jROavc+C1jbXjFCb6ZZ6Oc4wnsuljjTVw
	 IZXMEo7QK1+YcPDMgVXo9hS7Ba6RyIg2RuEZaBoo1cWpXaUX282zWkJVFOXvTMwHj
	 bLHvo57Z2VeiMg84Lw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoca-1vnFPr061c-00JVks; Fri, 08
 May 2026 09:43:23 +0200
Message-ID: <c565ab8a-edcd-48fe-8ae4-e788febb4208@web.de>
Date: Fri, 8 May 2026 09:43:12 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Zimmermann <tzimmermann@suse.de>, Myeonghun Pak
 <mhun512@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, David Airlie <airlied@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <da9ecab6-063f-4c29-a685-7b776234905a@suse.de>
Subject: Re: drm/bochs: Drop manual put on probe error path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <da9ecab6-063f-4c29-a685-7b776234905a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F/3giASq9svOJyDZkN2hAZH1lLD5yErkrMd5Hb3JAx1BuNTJ3si
 GjHq+dd3lsfwBVa/ZAGjiwdC9kFhIBqfuDvWwIhGnSCefUlh8ocEuB6o9hyhH565RIKjNdn
 S1ZpD3/CQMfgbRZU0GfWXgaA0K1SxZ8TJtus6oZeE0uUdECaVGpLC/B9oN1y+8HXnjAGhYZ
 /4r28RdJ1pTwYFsy5Updw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z2tgfpUidK8=;OUNkxQTzilunVGrQ5jlXIfOB5zX
 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
 mg

=E2=80=A6
> > Return the probe error directly and let devres own the final put.
=E2=80=A6
> Fixes: 04826f588682 ("drm/bochs: Allocate DRM device in struct=20
> bochs_device")
=E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.1-rc2#n145

Regards,
Markus
