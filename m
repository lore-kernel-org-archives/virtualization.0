Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC51A76BB
	for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634724; cv=none; b=pCYcIopRxSuOqg9zZDnF55dABy7KERvEnwapv6KmSSS/pUknkjTHod8T78TTukLPQWW+02jiorqJs7SV6I5bRqSUp9JD5WJ/EwWLRxSTZudwtMGFkiIemM7UmKNtXhnI568IxEyJf6w2NKqSreBUTPtB7qAz3FmK6Xw2rGt4Y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634724; c=relaxed/simple;
	bh=9JS1nLGsRdm2GmtsediR0LcX4P5CKPhOlaAoyG5KrQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqFe6tQJOilJhPuGKAhBS7VF7oNr9b9k/o8NHZwqdY5IQz9iK58DqoUnIOHhV4v9cA3dzdvtKpU86LREmX0o0ov7GZ1E7dEI5yNamGLfTXVJXqojtGrfrcGisxxNgcWt9vGnHbINaZZe9jWUMqt/ySE2eLrFbA3qQX4Y12Y9Awk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXad9Xqy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXad9Xqy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215740b7fb8so14025ad.0
        for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 10:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734634722; x=1735239522; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JS1nLGsRdm2GmtsediR0LcX4P5CKPhOlaAoyG5KrQo=;
        b=oXad9XqygXM0FdGRtI4vaFBBfU+wFdOcRBdLzsTenr3jLvycdC8gXJWRCaD0Po/J85
         U+cSbeZeIeWBBTboxWowbNZ5pwSVGnkR40xhwQ+ofmImm7VdhNyguiGlllqhtoQoSTQ4
         jdLAmBdlMofXRMHyO8wha8wdmJ1crks4Yg3+7ifbP9Ml9Vv5TrtOl803zJLkBneFzV8C
         002HGbnoOaq/L3B7SGbAOW5xu2T2nmq5e8t2GUb+W/NwmOk42g25wVCHAMJCXzfwlhCs
         IL0FWVJwCBGfsR+uAn0MQ8RTsqqzLiN2AmIPGrRV9bIxgctVQ//9WRr48E9ZcgacyEr7
         VVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734634722; x=1735239522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JS1nLGsRdm2GmtsediR0LcX4P5CKPhOlaAoyG5KrQo=;
        b=MXe/dfIaqp6SfyGRsc+fdmlo9Jnp308uUxumIiPiejteF5v6qNPCKwgHV50aq56z1X
         gS9xnZQA8M2wTFQzQMEkBbP2xVTRM1kwLMAJ5xEzPsKWouRU+ooYs6uIIJiJdA/2+fys
         J02u+YQs4hyN96e3wZwWALEHB0opk70wiWV786Y6R2aeQcmNkTsNwJBuuwtSlAecdAml
         B5nGi7Mnmw3maD4YPlH7cROmiQxx09JplryOZkzX3gpXJ9c9jxtzQ3skj9EAYUSBiwaA
         0FIyj0ISk4/ZlFbLLlkpXUPif7LoNkmrGKT4sxMcGiNW8UglqSPBy7p1CqQCM6Y7ceVu
         HFbw==
X-Forwarded-Encrypted: i=1; AJvYcCWaltFVhVNWGmy4ocyCY9J7syEFd5IL6ScdW0fqlt4grZdIlDWLh3IY/QprZ7Wo2FGzfQ/c4ojHb0gFqnS37Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9t3AkoGD/za62NLCjZpO0/LzfGxp34wAev7qUc1dQ0B9/gvm5
	7ITgx6j7mA78yWL7OLBBdFWuyrEivlsszbRW3zAyEQg5MqtodYHYyouMNaXC0P5gBavE90vUxzK
	XeEdWOxFdoSnSl9m89RtJZTsMR4hY/+eBIfPB
X-Gm-Gg: ASbGncuVPLdlFyLC/s89VCUUWjnh7BbqZ7sJErQSKaJHx3Dl7tjW2158DOVRAPkGket
	hVPw5TwY1gC84FbcgxY8IRG3B1NQUdNDrvWvE+Q==
X-Google-Smtp-Source: AGHT+IEtqWh80ytR520gQgE2R1z5Ywcq1MyXHaz7g58hEX9BLezeXel5Ss63xiUtuaYs55iEKYe9EOBe7VRCo78PcuQ=
X-Received: by 2002:a17:903:120d:b0:216:27f5:9dd7 with SMTP id
 d9443c01a7336-219e6a9a900mr26385ad.11.1734634721761; Thu, 19 Dec 2024
 10:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203002328.694071-1-yuanchu@google.com>
In-Reply-To: <20241203002328.694071-1-yuanchu@google.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Thu, 19 Dec 2024 10:58:24 -0800
Message-ID: <CAJj2-QFSmtCcQ=dm3yMhNi9F6trbcP0rg5z8cns5V64Pmn0c9Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] virt: pvmemcontrol: control guest physical memory properties
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:24=E2=80=AFPM Yuanchu Xie <yuanchu@google.com> wro=
te:
>
> Pvmemcontrol provides a way for the guest to control its physical memory
> properties and enables optimizations and security features. For example,
> the guest can provide information to the host where parts of a hugepage
> may be unbacked, or sensitive data may not be swapped out, etc.
Hello Greg,

I addressed the feedback from you earlier at [1]. Let me know how the v5 go=
es.

Thanks,
Yuanchu

[1] https://lore.kernel.org/linux-mm/2024102220-creed-darkening-aac0@gregkh=
/
