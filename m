Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB253E11
	for <virtualization@lists.linux.dev>; Mon, 25 Dec 2023 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyBd3Qm0"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dbca8c6eeeso803302a34.1
        for <virtualization@lists.linux.dev>; Mon, 25 Dec 2023 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703540133; x=1704144933; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk3BrCUhkF8HNi8hqkxjkr1dZsGMp84ddJ6VAzsBSHI=;
        b=MyBd3Qm0GWXYn8nlECiQ1KY+jq7h/hWOvEjjvNAJg7mSR5ecld+brae9YwLYxD2TWV
         qgddFpmPEj9DrkGF1rO70q97TT8MpekGHvJ+5DLZpHoJG0vTzcMARruX86KxXNRBCYRF
         5hwl3PQTL2uQ4BUtM9V732XMaHXnnWezeNYEk/R+8u1429dx6fXZc9hSDj58Xz7S2RWZ
         8gYmdEgElMp0K/qFWGLpL1JYXkzVN3ROCUeiRjEK2oiuO7tJ/ZdRjaWIGWt/UMYTzjTj
         C2tahImRycGb+2sY82TsKx/vQ5J8VGFXl30lRPp6QLY7PwyBg8JJSu0FD+Hu3JVaoiso
         6wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703540133; x=1704144933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vk3BrCUhkF8HNi8hqkxjkr1dZsGMp84ddJ6VAzsBSHI=;
        b=aVUHLoyVU8Ky62bYrNFBQkGIVa0VfnHg9vBAve8/ihHbMuVN445ZrvPcVH3UyPrFuN
         fVA4TKjNwtHFIT4yfrDg2nutYv8sZRf7I2JQobn4dPQZO/6a6vyqDZ2xT11XdgQQrLzu
         zF4hFunJEEcJef3qLCd1djkbU8rZ2kyXV5/hW2sI98klQuCFwd+ti+LPhDYh+kzFhI3F
         GsXVTjMJ01diJehcZIyQ+Bo3N9jSyr5HAEx6+4LGUSgos09CgaYytpc74k3cyyonqMwt
         /cPu/ycVoAiJ4Ch32FNdPftyYKUFPJIxhnzwQYoumtF9xHf/EssquWiPehE/IMSNRzb+
         tz/Q==
X-Gm-Message-State: AOJu0YyPq51enX1bCPfFapwsKL7UNlxibyeuNLlw0FZ4twS6ELhKKBfk
	m36hIjdWmZQjp9kmNLSCTzHdLJ2HF4pbvJqpVp+XvioelO8=
X-Google-Smtp-Source: AGHT+IF1ALMcZKnA4llsyBw7rVtGfnYUrZqqpeQaYHATEY6RAt9XEi5JjGL9mAun1x7rCUMA0cgxJM1hWmcGDvIbtRo=
X-Received: by 2002:a05:6359:c1c:b0:174:ed0f:672e with SMTP id
 gn28-20020a0563590c1c00b00174ed0f672emr2919571rwb.1.1703540132944; Mon, 25
 Dec 2023 13:35:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 26 Dec 2023 00:34:44 +0300
Message-ID: <CAPnZJGCdr7pw80Pq38UacmxsbQAowmasPtFxQVCP+tm6Cj9pUg@mail.gmail.com>
Subject: Re: Avoid unprivileged splice(file->)/(->socket) pipe exclusion
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man <linux-man@vger.kernel.org>, linux-s390@vger.kernel.org, 
	linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ahelenia Ziemia=C5=84ska! Thanks a lot for all this splice-related hard=
 work!

In https://lore.kernel.org/lkml/CAHk-=3DwgG_2cmHgZwKjydi7=3DiimyHyN8aessnbM=
9XQ9ufbaUz9g@mail.gmail.com/
Linus said:
> I have grown to pretty much hate
> splice() over the years, just because it's been a constant source of
> sorrow in so many ways.

> It's just that it was never as lovely and as useful as it promised to
> be. So I'd actually be more than happy to just say "let's decommission
> splice entirely, just keeping the interfaces alive for backwards
> compatibility"

So probably we should do this as Linus suggested? I. e. fully remove
splice by replacing it with trivial read-write?

--=20
Askar Safin
