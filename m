Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519B844C8C
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Feb 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363474; cv=none; b=FgUdpJjA0t4WEN92wKbIxKMXb9xDcacl13pucJXzjWwz9yMeV7QI1mFlsl8b6fvSBR3QI5K8ZN8SdJqlH/6MIt5s3f/sUwvNHkJ7t35mxlHXpGBpYHucpnk6TEbdR09YeZwqCYXErpAB/yTKMbAx89t3tNTOpHzQXHEQaE5xAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363474; c=relaxed/simple;
	bh=IqXAlLKeekccseiZoETdUwjQ0rAhOYE1/rlcGiLxS4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jzdP6it2t6A26CwQAnjlT7df6qhUNAQPpc/H2oap+Ht9h56f5ZZ/6xqk6HxhbnY4f9LxPC34FSdMU68fESUQG4FRUJvYy4ojx02dabNVMTGONT6fFmVyrDrqKc/Odgkk0kMM/zAM3lShOzzkalyp63ybsYQPjrCxNYoEKMuAcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLOEVtjZ; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLOEVtjZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0DB2605CF
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Feb 2024 17:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.601
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEF4F35Zy80A
	for <virtualization@lists.linux-foundation.org>;
	Mon, 19 Feb 2024 17:24:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=3zo7tzqckag8qrkgrebtbbtyr.pbz@flex--dextero.bounces.google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1FBCF605A1
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FBCF605A1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=KLOEVtjZ
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FBCF605A1
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Feb 2024 17:24:31 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so6304576276.2
        for <virtualization@lists.linux-foundation.org>; Mon, 19 Feb 2024 09:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708363470; x=1708968270; darn=lists.linux-foundation.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqXAlLKeekccseiZoETdUwjQ0rAhOYE1/rlcGiLxS4M=;
        b=KLOEVtjZ3aiApc8H6F4aw5hZq+COmC0m65+hvEuJ+D/YATAJwd8fkI33uBAcwBKRSD
         AlqrjB5wmSxrVBFdikwhuGMWzc1E+1ZJuC86q+2ozw8xk6Vlah1KURwjwqs3GXMBF/sT
         /+vhqZUa8jIHhDjHqwL7O6XmI05IRWzSvaw73tdZhIjZAbssntPQ7Nxb+F5f5tohR0/4
         Amg5T3PaNWAAVJfRINzYr0ZMjmK8bMNOlHB6cZNeV/MiQiO/LSP7jS/AmPiexlm5hWOC
         EAJWGjwLZHYXNJCYxjeCCG3L3v6kHKCK8Cvkg/eHG8sYEOUzMgQ7DNK1Hm/2PbW4gDpj
         W/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363470; x=1708968270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqXAlLKeekccseiZoETdUwjQ0rAhOYE1/rlcGiLxS4M=;
        b=Ic4E2CSdF+hJf6HXsyFGSyRCwDeioJ2eNXqSBepsFyl/c5BgAOZ/DbnbbZW2QLGajt
         AAO6wacX/XpC/cmqqXP6w7hfQ/b53vt16WxynBWQsfnXcfGH2mGFtdHUkt+gGw9Jhdco
         tzvHwESIYJmTOvykx5vSqKIJNTDJDdVBnqhW9wWrRCsHqt9HUSIhEkEVsbqKNDokPiLp
         UcxzqrMMPpm07r310JjZJNX9BIEpTyZ86yVCgYfIIigg4X2Q11TW+faRIH1VI/60Fdqj
         B+zKgEj9SFYzC6CfOT1/NdKPEjTayl/2gUY1nyrDNfLwLoYv+nxLNGQlw2f5Ow0WPN1E
         IInA==
X-Forwarded-Encrypted: i=1; AJvYcCVAn84jpk3224etGwu+zsFk1C6scOfow6yhMu9hNBeXwjdeijU/0KhbxGH5GwQvzCSroTZjlUYP4AY9ULJ0+68El7X8VMNbJZYKMwCQtGiIiYQ4lDSoP0RFFQ==
X-Gm-Message-State: AOJu0YyBfOvq3LM9g2gLaTvKRAAROT6hevF8jQoVWpvvw55cvbUEWO02
	sKv+Bn6e9LwuqSQ2dPTOrdEDISea0MNWsfRapVcVWC55H70q3Yx+Ss0Es1Elqh2tmf8qmuQIZOz
	h8XG6yg==
X-Google-Smtp-Source: AGHT+IHb/LI2umaPKzrGXSM6YYmMbRda0hH22YF1Jjo5mhqYj23QHtTxbCVUfsVZSjB+mHPk+SsGS1fXXoBd
X-Received: from dextero.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:364e])
 (user=dextero job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP
 id w1-20020a056902100100b00dcc79abe522mr524910ybt.11.1708363470612; Mon, 19
 Feb 2024 09:24:30 -0800 (PST)
Date: Mon, 19 Feb 2024 17:24:17 +0000
In-Reply-To: <20240115133654.576068-2-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240115133654.576068-2-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219172417.1383044-1-dextero@google.com>
Subject: Re: [v2 PATCH 0/1] ALSA: virtio: add support for audio controls
From: Marcin Radomski <dextero@google.com>
To: aiswarya.cyriac@opensynergy.com
Cc: vill@google.com, alsa-devel@alsa-project.org, 
	anton.yakovlev@opensynergy.com, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, perex@perex.cz, tiwai@suse.com, 
	virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, 
	Marcin Radomski <dextero@google.com>
Content-Type: text/plain; charset="UTF-8"

Thanks Anton for the reupload.

I tested this series with a 6.1 kernel guest on a proprietary hypervisor. The
controls exposed by the host (BOOLEAN/INTEGER ones, as that was all I could
get) worked as expected when adjusted via ALSA APIs.

Reviewed-by: Marcin Radomski <dextero@google.com>
Tested-By: Marcin Radomski <dextero@google.com>
