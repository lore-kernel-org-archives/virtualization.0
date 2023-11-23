Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E932FC4A
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="cKWk6SyY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE46982017
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 22:11:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE46982017
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=emersion.fr header.i=@emersion.fr header.a=rsa-sha256 header.s=protonmail2 header.b=cKWk6SyY
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id boVMhstS3Vms
	for <virtualization@lists.linux-foundation.org>;
	Thu, 23 Nov 2023 22:11:41 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4169981FE9
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 22:11:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4169981FE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail2; t=1700777494; x=1701036694;
	bh=1FSAtIYmUftMaxOldMoteCptRTxIkeeuJnWLHgIXrlA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cKWk6SyY7AK0lUuCp5Xn1fwoCcUc2EdFsBbzXNqYMgHpOlmoEFhqIx7LNPXCVydfZ
	 hp8uUX5zJnqE9v/ix0YVj0RqzUUCHMvjOCeH2Xwd2xHH0McUo9+3qYY54YBj84GacZ
	 pWI5jsjKxxLgTTePqS7y3u9F9k8ieFvYSl6Q6iK44gNmnWkWXB9Sy3Crf/06IaxflB
	 N+kSQL2L8hcB8CWR5XWZrqB6Bu0trOXoYPLKmAlRKP1X1oQuAlUPc6Uvripwnl25Fb
	 MZGqoGbgOMKE23vmgO0yvUp/CeMO2Lo1MNJHA1ZzK19jncMnk7Wwh95LC069Y4Wno8
	 XFTP4BYoDTbUg==
Date: Thu, 23 Nov 2023 22:11:14 +0000
To: Javier Martinez Canillas <javierm@redhat.com>
From: Simon Ser <contact@emersion.fr>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, iforbes@vmware.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Hans de Goede <hdegoede@redhat.com>, Matt Roper <matthew.d.roper@intel.com>, David Airlie <airlied@gmail.com>, banackm@vmware.com, Rob Clark <robdclark@gmail.com>, krastevm@vmware.com, spice-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>, Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mombasawalam@vmware.com, Daniel Vetter <daniel@ffwll.ch>, ppaalanen@gmail.com, VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
Message-ID: <xUgaKXv4lqgCEWWlB4KRGx-yLXefTg-uXEdXaTqAhOTxC4G7bCILTK9SH6ymdmMMBLooAl3_Kdvl5JXeUA8Hofg9PcCMBhPWhVhnCoxvgqA=@emersion.fr>
In-Reply-To: <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
References: <20231023074613.41327-1-aesteve@redhat.com> <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr> <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com> <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
Feedback-ID: 1358184:user:proton
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 22nd, 2023 at 13:49, Javier Martinez Canillas <javie=
rm@redhat.com> wrote:

> Any objections to merge the series ?

No objections from me :)
