Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482959;
	b=bEB4dxyo3LT+VctuECPji8bX74CXIoKc6H7AjvwgYglUkWm/ptuO8yJ0pDlkh9eaCHlZ
	 H6ylAZ442w/Iqob4Z+koz1/4wkRJGtwWmHBWDMH5P8BcKuEqLNweDKm3BzqOuIVJWR6bS
	 YlvFDQ3wYvQi7OvaBbTBszGLXsmTnI3X53Ta2p5YvkiBsAEf/igzfUVgkewZTpJxfrrQF
	 NSXy6ap9fAXLnlZYTygK3KTQAGzQKydxUWWK5p9q1Hri6+fm9U1De3vgphRKk2ZCyVyaD
	 ltJxg44CvEPcvXbzL/vA8dscStA5x6yqI/wTfpksMMQKRHfSchofL4StD/PmpVCoE8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C6hzf2s6hKShPf7oAcRuMB0755YohpVsSX/WLyG5XrU=;
	b=g8ZpwQwSas4uB8R9RKnVZAA2QiUqNAjx4CYWXrPp95NvPkevTZ/M2UgBXpSMW4sH5+x9
	 DhYSMC16mu2GK6R1t31QZtmVxcESN+Q1AX+AJ2nzI8r1O4wzNx6WBXUJvJG3EIAIPiDT1
	 vRT7SUE6XUIWs20bPro1ygZPi9t8qmPtWgIBa0je3VblAPpdSL58Obbc7IDYlWrLc4aor
	 mq5zwQ1RVPIdQsJk2l8GmzfjZLK32+R/pKHKZKe92ebWnGopXIRcDXvcT9MjOBJHyKTJM
	 6LJrgVKQDZLOcHebJa+3IjmPCAsVZ8xUTcLwefndz77f/z4WDU18ly7NTgIuv9Y+vXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWaQdn0u;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7A606A322
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 01:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E7A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWaQdn0u
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-92157f2e8c1so18147306d6.1
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 17:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482958; x=1796087758; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C6hzf2s6hKShPf7oAcRuMB0755YohpVsSX/WLyG5XrU=;
        b=hWaQdn0uxmPnRzFMQSnDZHhnt8VGi75onkoz2qSa3DXcNATmjK//rK61Lv2MLuq1Am
         1+6r9HiouKUmdjU/grjLtGstYLDlyVz3e2d2Hs46D7oEnu9e74OeuSRW69lKFh0opPRj
         8J/kkPl87ciYfzoJ+S3RuODvXK6D91tNyJI3hGkajrFiJnaxCwerbzYijPPghk4lUOe4
         ZOSjbNafPMbMyWx4PC4A15QOn5ZsazKs3eiS+P9GPaZKVw+v00hMTG9PsQNCpAAe6kQp
         WqYY6mdy5tufMg9NXRpJSf44Bq7rdH83qb27zJrbcoIRZahj325Tod1neX7CwZ3bbmIw
         LCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482958; x=1796087758;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6hzf2s6hKShPf7oAcRuMB0755YohpVsSX/WLyG5XrU=;
        b=IZSXgKlMEVOGpDLGrlx8VqaLO+tEOCZhYV1p73uQsDASAxxmRNxdsGW5CnUYc6Nskr
         ssIc98bna+keKsKc30afyYmtijHcBfUCoKhGzrCkBHDOmR/ViJZ/FJUr4Z5ZPv4iQmOS
         iDBBsyH/ECwyNkLsFh2sqLTKIqNDhcM0DshGZn3ArWsCpeJpjVDqh9tTxiCPVJLg//K0
         c5lbTF2UiZ9Oj/hu4QC+AubdY2Sb2C+mjEi0cvXgerPGcQ0F/9OhH90TsA2rzRX11Xhb
         OfSCkARg1FOVKO6kta1CNEZmKIWamkPsTeUQciV18H2Cc4Xa1yNdJkKGHSwtf4AP+QDD
         79jg==
X-Forwarded-Encrypted: i=1; AL+hErFAV+pJFkyb7/WNsK06LLT1kVHhAf2kzi8o0iA4DIROuky9oHlZI7s3111zSPV7VKQaPwPkomnpTfYBwjhNLw==@lists.linux.dev
X-Gm-Message-State: APuU4Z99vKLhZSuKuFVCsit7CqmX1u31FL9f+Qumd7uJiyKDpp3KZPyx
	7wyaCpgMieHveqpozVmRA3undO+Vbki6dIeMhcIAdBEp7iscQ5uyzRkf
X-Gm-Gg: AZFdTZeRsCCHC1kKdcmP41KqPTmywwH/5acGBGFrbcvzXln6feAJH+q1lll7spDbKT7
	e/cGrnKw4XebSSRf/0QBIieuaX6qDq4N60egyCqU6lx61tgVPegCHe5Oj4Q5I72DIxwQG6BSZ+1
	pZZD8uInBIG70ZieaOzmyDzzipj6TPdY1v9gdk0NCWA9LjTbs3y6Z+2H+laEwxcdSIZbIK4WUAU
	iA4XvPjJ9oxD4eymWUyQFm9RMDI9f4OBIaSRDpirzGlFTo5VZMvrDMAZZzeAXO9mWsL7I0uKTal
	ldHXcBvk6BgF3dJ/BtHcBJVV5xVKH3IL19iS/z91+Vwsd3jSRhc4mlE705Q1xWL2+nd01XoKH/x
	R7jSi+HRcm+S6mvXYyMswk4R+N9Sp4Tt858jf2YGZzk86oR+gmQMgoVU0Le9VoWsCaEC9e0/aF5
	P/R4O/ppJzb3OJr0hHFiX+3aK/YY1rXiQ7vCgzuvUZtE3EDo9ZGV8QudPCPKqvLyzpOFB0w5j8k
	TJUP38ugftSXusbuWkwfsGiXCigaxNqM2OHNzpo4mUaoqP0Ul240YIjYi8uFFHCWq8dt0QXLfER
	+GmLA8vpanD4Yqj52AvyIbNQHYDw/uxK/ZbmFGLdrif2RkTFRSCGD5ng01mW9yU+uv2X9b6a3XB
	ixLJcW8GB6+4B0/5tRPDb0JQyxdrCtmr+8Kty1SFXFYzA96wUiDG8llyQO8iDGQg=
X-Received: by 2002:a05:6214:8504:20b0:921:2245:73c2 with SMTP id 6a1803df08f44-92134abe315mr179048286d6.20.1795482958278;
        Mon, 23 Nov 2026 17:15:58 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349ee175sm123288296d6.26.2026.11.23.17.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:15:57 -0800 (PST)
Date: Mon, 23 Nov 2026 20:15:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 netdev-bot+sashiko@kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.19db5ff627b4e@gmail.com>
In-Reply-To: <c663141e-78bf-41cf-81d0-fdda6fcbca74@mandelbit.com>
References: <20261119153056.353156-1-antonio@mandelbit.com>
 <179530424233.3135.6226986969775563090@kernel.org>
 <c663141e-78bf-41cf-81d0-fdda6fcbca74@mandelbit.com>
Subject: Re: [PATCH net v7] tun: bound the NAPI receive queue
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> =

> =

> On 22/11/2026 00:37, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> > =

> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
> > =

> > If you believe none of the issues are legitimate, please reply to eac=
h
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patc=
hwork
> > know by including "pw-bot: cr" as a separate line at the end of your =
reply
> > (one such reply per series is enough).
> > =

> > - [High] Bounding the IFF_NAPI queue by packet count only
> >    (net_hotdata.max_backlog skbs per tun_file, ignoring size) does no=
t=E2=80=A6
> =

> =

> Right, and the commit message says so under "Still open": this bounds
> each queue the way enqueue_to_backlog() bounds the per-CPU backlog, but=

> not the memory a user can queue. Closing that needs the queued skbs
> charged to the writer's memcg, which touches more allocation sites (one=

> in vhost-net) and every tun user, so it will be a separate change.
> =

> =

> > - [Medium] The patch silently changes behaviour for IFF_NAPI users wh=
o
> >    set a finite send buffer with TUNSETSNDBUF, and the commit message=
=E2=80=A6
> > =

> =

> True for a send buffer larger than about netdev_max_backlog packets:
> there the queue limit now drops before the writer would block on socket=

> memory. With a smaller send buffer the writer still blocks first. A ful=
l
> queue dropping instead of pushing back is also what netif_rx() does for=

> a full backlog, regardless of the send buffer, and blocking on the NAPI=

> queue would need a wait/wake mechanism tun does not have.
> I'd rather
> keep the fix minimal; netdev_max_backlog tunes the limit and be done =

> with it.
> =

> =

> Given the above, I am not going to respin.

Agreed.
