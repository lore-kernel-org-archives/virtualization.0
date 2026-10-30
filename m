Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375926;
	b=URp9usPnv+x3U+dr0UeHPe91tCq/MMeGtw+CUIYuA06pVw3m71aLlQr+6LXaoAa2DpKB
	 IxUGutMf8jdHimQLmDpQuoTH9K7oKF4C0Gavl8JHrls/mTodkR2T1Msu8mEKkMUR6mR7M
	 9YbNSQFmbBEUCmwC1O559rEAkjeM0+RMx7w2Os1zlkCQR66n6W0mNsDLMeDT2hdaZNUcM
	 ETNyhWS1GBIu9f4jY0Pwek5UQDZpjo2dJRwT1WD4viFaE6uwxtki5YNYc/8119pONVfQH
	 pdYp4VHYY0C2tyfgSkTeOUYi4fOc60+j982A9qSl/4i8gSYpvJ0T+6+hq7UgoOm/ZYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375926;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=dJzragssLP/lFBThFlAGnmiIHyUCCp8kgWkFFZgDYfs=;
	b=v/t7MijJzY5e8BFDHGBhB1L5irGOuGO3hbbpgLDPPmHQ0rpC/7vlV5japPC5ldwNopsq
	 I6yt73PMyEM4Hd5mqc51WTFTVSEmZ7w+dsIU7nZBoguuXqbPWu1pQf3iqwpd2XmChk5/X
	 O9zqDdTR6cxfY3rXpnQmOCyEXfAHMzdregdkM4SMSG6s1qwW1caxn65Q75Q2I9kKWnoVI
	 c+5uEVuzcq/Gyb1uwjO2/3RIMbmH2KjUZP9rKiLLCByvNURApFDFhrc+0Rw0nm9WNLVrz
	 DhoplwI7w5e7uqtaq0kRn1HwQP0nsO54oATGef8BOoc6NO01kYEielmy+tUbxClXEiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=OXFoSvtC;
	arc=none smtp.remote-ip=188.68.63.98
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EC60A260B;
	Fri, 30 Oct 2026 15:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52EC60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=OXFoSvtC
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4jGQjx0zDgz6VvG;
	Fri, 30 Oct 2026 16:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793375893;
	bh=OVr3IPn5ra6s6XMsCtuY1UefiPqNwrn7wT8GKl4Uf94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OXFoSvtCejVlnGX936PLWrtCQoELbPTmjw/BohUC0kcQ6q7yDqM6BzurXgnJILW65
	 0T2BpV3W+xRv2yxIb+eQL340A+VuWU4FLdwuP1sTMRSY1TtxTV5glo6EVzGw0We9cD
	 /Y6buVHB15kKRhNJ68SC5T8/hqsCAaWGlrhaVDU5pqW3m/abpShO9MYwiowgUbSMK7
	 iUqTgoyPua3XMJCbY6g8PD2nwh6fFdOu0LQVEeLgOP/GYS5SYZDYMAiqvlDSHd5nbL
	 3N6cjdAvurv6pvfEv0aWVRzMa1poeDbXBsZU1iM6B9v/rbTg32kUVIcTh2nSt0iouW
	 iQp8utd6eUKPw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4jGQjx0FKZz4xn1;
	Fri, 30 Oct 2026 16:58:13 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jGQjv1nnTz8svH;
	Fri, 30 Oct 2026 16:58:11 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id A31715FA3E;
	Fri, 30 Oct 2026 16:58:05 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4597ff88-44e4-4b39-a2c9-5d7f5ae62b4c@leemhuis.info>
Date: Fri, 30 Oct 2026 16:58:04 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/vblank: Don't arm vblank timer with invalid frame
 duration
To: Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: me@romanilin.is, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, javierm@redhat.com, dmitry.osipenko@collabora.com,
 peter.m.arnesen@gmail.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, sashiko-reviews@lists.linux.dev
References: <20260914110004.211027-1-tzimmermann@suse.de>
 <auIMt8XmmaVykZTC@intel.com> <2c2f33cf-da6f-4e31-84bb-768778d7b063@suse.de>
 <auSIZNhP4DTj8Nb2@intel.com> <be8e41da-5ef1-4c37-a044-171ab1f32c6d@suse.de>
 <auSgII_W-FJJz44W@intel.com> <f406b2f6-cad9-411f-941a-7e4f26af3947@suse.de>
 <c874d311-f7b1-4a24-ab75-b502ba1c5e58@suse.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <c874d311-f7b1-4a24-ab75-b502ba1c5e58@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179337588621.3158380.2417310703814462568@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: A31715FA3E
X-NC-CID: xnGovnX+mJIHQu9XWrX0b9eHJeHbP/ZfuxaLShQFDKR/IgqgmW0=

On 10/30/26 16:33, Thomas Zimmermann wrote:
> Am 30.10.26 um 15:25 schrieb Thomas Zimmermann:
> [...]
>> How about we add a dedicated mode_fixup helper for vblank validation?
>> It would run after new CRTC's mode_fixup callback. [1] There we could
>> try to adapt the CRTC's adjusted_mode.  Since we know the bug exactly,
>> we can try to detect it, fix it, and document it.
>>
> 
> The attached patch implements this idea. It does work in the sense that
> it doesn't immediately break my testing setup.
> 
> Thorsten (or anyone else) could you please test if this patch also
> resolve the bug with SPICE?
Sorry, can't help you here, I'm not affected; I only cared because I
keep an eye on regressions in general -- and a few weeks ago it looked
like all that was needed to resolve this one was a relative easy
adjustment and a repost of an already tested fix.

Ohh well, that turned out to not be the case. Sorry.

Given that the original reporter is MIA (iirc) I wonder if we should
just leave things here as they are until someone shows up that is
affected who can also test the patch.

Ciao, Thorsten
