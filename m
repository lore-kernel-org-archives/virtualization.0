Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A22745E
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280346; cv=none; b=Lf3Rc0V2sPmomDkdfcTBYR+8r/PfiFQXvSsH9MxZ9JhuBl3BC/XQkX60cZRA1xWAT51ewGrLKpqtcjivpTFHH58o69fxMywFThZ1UndZ9Awa+vNvPp3GE/jLkkOKGTK6x7uCEsyfJoXmkaE+oEWMoBSom13zjbfCwi0bE12lgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280346; c=relaxed/simple;
	bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5SR+EFx61IQVqYF+bi1yDTPzyjduxytUDminD71rFCB+njzVGamOYoWGadZMlUkuApMviq7yEmoIy5zqMxg5Ndgf1v7+3lGgHuLSS9Vq/sn90XHtnQCem1+GmCYu31hVIgzrCSMU9/zQLlvSuG0Yw/tdWasu+NRjrzlNFMNza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToW60DDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToW60DDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
	b=ToW60DDG6jf5qL8ueEin620G9V/uRcBiYc5tDpIb+auR4EBlKPeCPRpt52fGWb6FuAyXTw
	+rbXjfDV7Z5v+HAmqQJUwm823Dz6YoZupKh1+ObFiTS5vUpPfpwuQFf9UNONqV4/QYYXzX
	yvfGoY9x6r7u9pWz5j3rE+OtxJ9FZWQ=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-MqaONiFxPe6gv-llyCXcWQ-1; Tue, 03 Dec 2024 21:45:42 -0500
X-MC-Unique: MqaONiFxPe6gv-llyCXcWQ-1
X-Mimecast-MFC-AGG-ID: MqaONiFxPe6gv-llyCXcWQ
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4adcdd20a51so1770908137.0
        for <virtualization@lists.linux.dev>; Tue, 03 Dec 2024 18:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280342; x=1733885142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz82vSmSg4xAKvNdyUovhi8qPKmFolkeJ+4MDgY16pk=;
        b=dr4qk1XLS+7Qcy6PpLl5B29FQ3ZmDCls5s2+wV+ubGmK0umwagHdfIAfw35AF6sW3X
         19FWz4B4qqlAEpKAV3SC2n6aN0q9LXprNO0r06otnMPw/hh/XJEM7enrRjVsS8BR9uH7
         PiJ4qyn53O2tZDffOBju6JNL4tQn8TRhQISWucTmgJSXRJ+/jHSY+QbNU8/Z9VLvAWnz
         0m6UcE62CeB46ogvPCI7ycrJDzDU4eZVCmOxR7Otdw0cDe1uWPiB9jyIx/Nulun4yeTW
         soVucE8zmKCE0OHwjEhIEDL2MX8U7b13lBW2MMErjeDsNRuXdI/H6GBTzmA9JX3rUAb+
         0lgA==
X-Gm-Message-State: AOJu0YwZsrXFi81Qvta5xU2sEYFHNZygmCtuJQ+bzoaknfAYFAsLp2k0
	OlhWRNh7shE7J4zIPJWnD5ObIkD9Y0MLTII15TaKd4frS+60AZc+xeB0uyCtMaBLHaZXFGG1R2Y
	Ps2M1Uq3E/j88Y9ciwoyHkzk4bRMNmeP4AYN7bDae9y3QlFD+8r9uMtQrvw+p8GxLWS4/euDQ7p
	WZZjFSkPoCD6R+CypWCazFEnzD9ur4yM/RVoE6NE0=
X-Gm-Gg: ASbGnctuAgQ8fGx29FrD2gJKz/8aHpijClpZW1TKhegoIdn0eyBIeDuiEKyOOUeQp7N
	kfQafcK/H0w3OWCVe5wc9P9rIlQIlXEtl
X-Received: by 2002:a05:6102:38d1:b0:4af:56a8:737c with SMTP id ada2fe7eead31-4af971b193emr6430657137.12.1733280342240;
        Tue, 03 Dec 2024 18:45:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+v2rQ020MNSJM5uPbSBJm0D0/Db89xQqRoZNc5welU5BaKs9HJz5sd95RktgMEEi3m5Dwg3PuqbEbHeQzKSU=
X-Received: by 2002:a05:6102:38d1:b0:4af:56a8:737c with SMTP id
 ada2fe7eead31-4af971b193emr6430646137.12.1733280341977; Tue, 03 Dec 2024
 18:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-4-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-4-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:45:29 +0800
Message-ID: <CACGkMEsd_fVOFcFGmW0g7DbD_G5cAudWuxc9LD9PNPm=HvNHQw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] virtio_net: add missing
 netdev_tx_reset_queue() to virtnet_tx_resize()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B5KTlgQ2iXYnSILkZ4NjI2mgM9kWCJInVQyLkegf-7Y_1733280342
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:32=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> virtnet_tx_resize() flushes remaining tx skbs, so DQL counters need to
> be reset.
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

