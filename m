Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785036;
	b=14uHPQjUZaTEN18X8L9mNB6nRbDON1JaZtnzMLcNMQJDJRJ0p/u8hxeKJ6auFm6Z0LqD
	 LhsG3iYHBr4ceS4+b/9HI+WgzwT1/JlcQBV7rirM4kQmB2v9MrXn8EOmuidzZpt5V6yZy
	 gvRfX25cjGh3sTXon+ProxvAv531rBIJJgxkiwvHcudeJXWphEzRswDDRg3I5LQisIULr
	 C1X3EPJboMip8xFwrhDfOrF93sGAXqD9kvFqh+Xg49n0jQG/Yc+dCVPzBwqb5lD1ivkow
	 8jUtzZw2W1zmP0AmQc+0Z/VAeN3IBLJlqgUC8ShtPiSDkXe2fxTmuuFDPxRbzn0PMmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785036;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=bVnR6268e6MGHFilapvpTtFzYLf3LYIaxg9LYvJQ5c4=;
	b=vrPwV6OG7xR2w9zGHc6NSWgfCnriDH25HBxBoglCQC3oE7byxjK4H4rP5XX8fmN45EU4
	 Cg1oXKPxyGrGV8sGeFbo1ga+qM0ZjRnDYs4LoTgYcGMUUPlCUvvpPKSKiVATsgDpa19Ed
	 1sokPm1Bq2a3j3VAZn2hGwMHoFhbcStzItl30i9wkFhrHg7atjBqX8sN1cGgl4kZRpP/a
	 qOJpEZeJy5EnOyy2l0b1GxriolFaHUhUAt4JhX+5tnSt1/J7rwG/trq9r/znVMKk84kfG
	 epG4BoCOTws4ShMARRan/cNFRhs6ldr2lOpeHEgWcgY2fOGXSiGMJNy+fLBfMD1M7gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SijPW3lC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC3606A336
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEBC3606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SijPW3lC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793785034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVnR6268e6MGHFilapvpTtFzYLf3LYIaxg9LYvJQ5c4=;
	b=SijPW3lCnSumw2erzSj7+gnwCrUqSPpIi4Ja2iOWxv9ZamYgkAAHVobfpdL4gQbARBcBoW
	Wu5i1ybIROgwUzgAgv2PDSuysjvnTeFPgs4iEgTJM2h5IyEUdLMCehVGObzvWR8LnTfbFh
	w2LItoNknhTlADFFzsPDaPOYfMuWvfU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-DjQk13TXPlm_DZVQPwkPnw-1; Wed, 04 Nov 2026 04:37:11 -0500
X-MC-Unique: DjQk13TXPlm_DZVQPwkPnw-1
X-Mimecast-MFC-AGG-ID: DjQk13TXPlm_DZVQPwkPnw_1793785031
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836c416b236so7531077b3.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 01:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785031; x=1794389831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVnR6268e6MGHFilapvpTtFzYLf3LYIaxg9LYvJQ5c4=;
        b=pRzukMKgGh9iZINpCXvCclp/Ho1hm33jokPYB9NNwp4NoeN/gEHv38WFKevxlGLpnN
         Avahq+NqTZyBfXO1is0yTllKg0twTabMza1c7PS/fIkGWKYQHG9ZJ+Hjlx0sxs0QxOFi
         NWiW6uu9hMI9ErtcQvMsSRL76UgRb0JO1Gjf/FBmHHmT6PKWdGJwUXMv69SMCcv24HPj
         DYWFpZpb7wXy0hB0uW5oRm0la8pdAUD5GcF5D18DATpBmJlkKolDsPbLbrleSqD+hSVb
         NQH2XUqIihLd8mwG/hZZEkSt3DLVE0gyh2KmD4SP0MRQ8Hbw7Vte/EzgP25B40NPYd1n
         ZK7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy0SsSTCSpE8aEIluFyChlLVDMesm9kdoX94c8o4ZESTtLD7q2aVs/1Jml8R+Bnbse+gbz8NQ23plU55M61oQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jjRsO3k+BYCUVndltpiaS6Q5KD1zBBuQVHiTbynTSxHRH8smE
	mzmynutBHsuJutGvqFmvxUlVtJ/M4G8sH1lWkLBEWvh0MkTZ6neqno7jSW5zwpUcr5PcrITUdYN
	H2XZdtu2eNcDaSBUBKOwQPcrg2knc0KUy7Kj1MiWWidEi352MghEZZ7UyZ3LrGK+f4shtOnbjuf
	TL50V7c8ztnTV92iT5Wsc07kYu5J4IFylhr/2obGR7Mr0=
X-Gm-Gg: AYBFou1kwuGikhrHODophivSbDGKAsyKG+aZl+Pf6jbddk2D8BNJyQ3fGN7c+2k24ab
	O2fQInlogBx0Rum9M+lRbU3XNY2vLd2hpEtFAPWHS3oFdc5HYPBQ50ORCa2Be2XqyaNqjeUfPdO
	RDvSyLms+k4dHE49WRM7vOr3HB9wJ+n3modxBx2NIjbVIyaGBPNcXY8eW0pezWPwgSxcVb5VpeD
	J48/130X81VmHIvBozGJkqyXM/vplrsgtqo4/WxMeBa2ZEsflQHa56Wl5M=
X-Received: by 2002:a05:690c:a4cf:10b0:8ab:44a4:6362 with SMTP id 00721157ae682-8b2b65b28edmr73174967b3.4.1793785030939;
        Wed, 04 Nov 2026 01:37:10 -0800 (PST)
X-Received: by 2002:a05:690c:a4cf:10b0:8ab:44a4:6362 with SMTP id
 00721157ae682-8b2b65b28edmr73174927b3.4.1793785030369; Wed, 04 Nov 2026
 01:37:10 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261104081903.1834-1-gubin@cmss.chinamobile.com>
In-Reply-To: <20261104081903.1834-1-gubin@cmss.chinamobile.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 4 Nov 2026 10:36:33 +0100
X-Gm-Features: AclHuK-c5sjTOvcK9KP6Rr8oWkxc5XccSDR94cElnJTWRBuorU92CHBGWIUNiE8
Message-ID: <CAJaqyWfQDD8OmK=-myHYp0fZuSAQDfwn_KyqUomp7jP1MOaD5w@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio/virtio-trace: fix swapped read/write label
 in path error
To: Gu Bin <gubin@cmss.chinamobile.com>
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6l8skOTuxZCj1fitYv8pBNSes0gL-LhisF8Oc-w7Fmg_1793785031
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 9:22=E2=80=AFAM Gu Bin <gubin@cmss.chinamobile.com> =
wrote:
>
> make_path() builds the path whose direction is given by
> this_is_write_path, but the pr_err() labels it with the opposite
> direction: "read" when building the write path and "write" when
> building the read path, pointing the user at the wrong side when
> path generation fails. This is a cosmetic fix: only the error
> message text is wrong, the path construction logic is unaffected.
>
> Swap the literals so the message matches the attempted path.
>
> Fixes: 108fc82596e3 ("tools: Add guest trace agent as a user tool")

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
> ---
>  tools/virtio/virtio-trace/trace-agent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/virtio/virtio-trace/trace-agent.c b/tools/virtio/virti=
o-trace/trace-agent.c
> index 7e2d9bbf0b84..555521fc8bfd 100644
> --- a/tools/virtio/virtio-trace/trace-agent.c
> +++ b/tools/virtio/virtio-trace/trace-agent.c
> @@ -130,7 +130,7 @@ static const char *make_path(int cpu_num, bool this_i=
s_write_path)
>
>         if (ret <=3D 0) {
>                 pr_err("Failed to generate %s path(CPU#%d):%d\n",
> -                       this_is_write_path ? "read" : "write", cpu_num, r=
et);
> +                       this_is_write_path ? "write" : "read", cpu_num, r=
et);
>                 goto error;
>         }
>
> --
> 2.55.0.windows.3
>
>
>

