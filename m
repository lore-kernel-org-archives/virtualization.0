Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650A30596F
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055452; cv=none; b=vGoWmsBkal/JSRG0JX3wVnYW342UO1X6Yazw3qXIJ+Yq/fX5DAflRXdo90jJpU1ABTbVaNJsdEX1RBzcAA9YsyXyd/adQh+GRAaQeTCARgi2p97nuVC+FVJrpepmhYpbwsOhX8HoijsYpTZblIXEI99fCAtGitk04oM0ySsLzw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055452; c=relaxed/simple;
	bh=C6sELIhv1S+5sf5c4uqOjdCGgTBs3Sk91TiW2PizCkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0KqjyggNMqAZaMxEar1QlgXqF1whDSZ2Mq5BQjQ9bqnPugGtIMyBH1+qTMHDZif4e+AIY0gbPESJcqiXVt3VvXlPnenhQ3gAfhVPYYRyZTdd74TKcEGh68H6W31QAAz88I1x8f20Gl/wjZ1jfQdYLFGIYdWSDlEvzCGlfkFzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLOP4Iwl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLOP4Iwl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceaf8a1265so66429865ad.2
        for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787055451; x=1787660251; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6sELIhv1S+5sf5c4uqOjdCGgTBs3Sk91TiW2PizCkk=;
        b=eLOP4IwlWfygd5BvNPTJdzWH6tBPBR9ad71+SRhhonxGEHg/YGc6tpNxh7VuMrYG66
         YcXCqNXVQzmbr03pHMC0sOsuxBiLnUTbdyX40fg8JG1loNsgvUuzZuG3zUZ7sOF52ktX
         Ym3dOw35Lh7BYymOjwkDGXnac4VOela6NjyCtcSBAWUF6+i3IExw3lCKfl/pi1bsslKQ
         xVvcZfxToCZuTGELuyiYjJnaQYJXZCWUqellqax24kNmpDttct0ZwKHcbZuH0+Kt0QYt
         uUQm5t0CVRa5cYn5Swkkn3CdrdirOsIMAMd4cmnqQjZK0giTByMDt9KNdT8ubNRIzmQV
         GQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787055451; x=1787660251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C6sELIhv1S+5sf5c4uqOjdCGgTBs3Sk91TiW2PizCkk=;
        b=FkFgGczlYXGEM1DrcLCHvll9tgMbiHDhif/pJgnbHIVJ9TZaQQxbiMAKaqZdI9cK2h
         qjAlZSByj23SOe1saPJ2hW9v/X0QBpC3FFiTG8tNX2CXwYvHdhuTHHqSJ9XeHPKHExfF
         2KgyFNQfc1IBCXICzUChxiAHrBIVHUCzQcQI+xoyjzKZzJmm69zFb8Y3iamew1lzSbCE
         hT40UxDei+Rn6aDp7svH56UAEgbiOMl1wbKtKNe2czqwTCJGQl6GRVvG8IGtNpGWpGGh
         NRcUJwmbQpJagMqM/h26UkGlIp0tvAYQ68L8zopkADuajKW9Z455MmIFM1wXYa/scsB0
         Wmdg==
X-Forwarded-Encrypted: i=1; AHgh+RqAgHR9m966M2YxOprtzZnCGSNYIb5Mt8my/k6a160Zb/e9yqf4qHLKlISGxU/V7sOlhNjkhv9NCo6jouRO6g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+DapXAk5WnTiZPPwT5TUTWYwDDKwNKNs4kNuHuLTcLJjk8ufW
	ACGt8uSzhDjFwMzpfs9teSXZKjTNLS/5VGT+lwFbUW9tOgfnLS2lkW8=
X-Gm-Gg: AR+sD13BkSn3sGFx7hxYsBJnjooqENvBwYAWHI3OsVGUl7nnImjzIWYXitxmG5k9pJI
	Pimx0PTeu1dtwceu+8XZb1fgwfjdNUQHfmaQdfIG/KMlTCPUentHn7Qh274gwE+mrCXRVoAlha9
	AIbNGTYYdnt7WjBVi+WIoW/n1EwxxIKhxBRuPlZmuYJrqin3mN9B5Svj0rUuiMUBLxxG43ofc7m
	+D2A2ZnHJJFzbt5vaGym6zrp+QBN2QnIen4IWtg5yJPepmFJUJ9PZJTG5iyxmOYA7pl/8a2ly8b
	MDpRKMNkSsjWfi10rGYhL05AsiN5c8HEY8BlEFBQYdMvQZrusWu6Pb9pkr4vEPV0lQPyFbzy8h8
	ks5dE8AhRjUJs6/A2ZB3hHqo+WWxafDMVUH5AI5yFTyrRGVjrd1bDihWiRQetaqRPIpl+hXapPp
	/0pRaiK1sP7OKEEGTvvbqB8EjoaG+lnMirXUYplq4jzS5M3gqOU/YYCY4nTkF28QbQr4+1He9Vz
	Zn68fy5+6uTBB4Izx7iewWmP/+yfEbuo0keYlSs6jRNyX1f7DsmkmKVhY0PjO7Rs47u
X-Received: by 2002:a17:902:eb83:b0:2cf:b68a:2050 with SMTP id d9443c01a7336-2d5c5370140mr111173305ad.15.1787055451082;
        Tue, 18 Aug 2026 05:17:31 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ed8b0csm13769275ad.74.2026.08.18.05.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:17:30 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: triet.hoang.dev@gmail.com
Cc: airlied@redhat.com,
	dmitry.osipenko@collabora.com,
	dri-devel@lists.freedesktop.org,
	gurchetansingh@chromium.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	olvaffe@gmail.com,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/virtio: Fix possible memory allocation failure
Date: Tue, 18 Aug 2026 12:17:14 +0000
Message-ID: <20260818121714.47251-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818113256.27848-1-triet.hoang.dev@gmail.com>
References: <20260818113256.27848-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a stupid idea. Sorry about that and just forget the PATCH.

Regards,
Triet
