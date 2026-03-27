Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4236894B
	for <virtualization@lists.linux.dev>; Fri, 27 Mar 2026 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583027; cv=pass; b=ZxAlvJCNFKgf+VYjFo2rEUqDfiGe4VibbCkgXm2TViohmKe6NZnlAY5WWLnxYVZmQhU/or737rdamXLbmJzSqeaAbvvVoDRfyN93uOH4fnA9meRod84/Eb3W6JrjnkP/Sdk6L5fp1Rn75naGccv9aByfslpRiejJTMAQzZKRpm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583027; c=relaxed/simple;
	bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yufmud+pFZ0MJ1bUkkxxoYcyAi4+A26SaFseQ8RtGWWKrjA6gFLQ1rMgjYXn+5bY6su1OVkT+XrUWEE0TUuyAfxogGRoOEoLcgJnTANIOJ/CoDHGPXURIUf/GhB1dJXluxpwILqTsTGcYhBdFtM/7+hMFu7e9mGr2q+H+dVjCP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBZ3wz56; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBZ3wz56"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b351eaf81so15728541cf.3
        for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 20:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774583024; cv=none;
        d=google.com; s=arc-20240605;
        b=E5CKgM9t/pZGTORd1t332jV7m50fgUfTMY/UxT6BN8RBqdBfBqSCYlHpud97bZxxOJ
         5VeFmD2P6yC7zytGPJZ1K5EpFPuPB6WOhwiATLSkRUwc+dnfxzMhF3mf2kclC24J5YjG
         IAqg/8MHEeMlYh2HeQMGt5xAuoikwVEy0rUyIP4gsnE37kuBZp40vWDLFmRMEYNpxOA4
         e4PxzafZm08719NJoIXk8Xr3T1yilHca/E1jC81F62+lj/HiXSYRboyQsfKf9qjzhcl+
         Vs0tTDUPnfv3cY84NRWKg0UmawoPABFk7FdNXsgikBEJpq0pGNP9dkXSMq08/lm6lssr
         rrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        fh=zRrAo2Nxs6H51Du0zc72xr9yl9eoaISz6zNurhZnU+Q=;
        b=N5I6u63SfZUzQH1PpLe5XphIbcI1QtfFrxLRxjoTXYgaJjKl5t8hncmumqF2WXT+X4
         eYMROLeYXybmkfQPXrk6CoCzlyxGewkK8OkcSGqulaJEZWQFRorM6gNoRtSTTfvhXzVK
         uRxYsT399USD1aIrvdQr9mcOxAwRHE211rFfCnwAd3MsrbSH0iJ3LWQTiyuMoho6aTa1
         JP2oE8wET3gdYRrs+d0gMFHyxQAHz8xpbhi35WgIxWCk4CfwT0XrbS75fygW05n6VZSV
         m500VaxMOKP5I2r480sOj/jOB2RaTF7h5eDq5+BptsJ/MbAans72jmwoArE1YmnsKKsM
         mMKw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774583024; x=1775187824; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        b=BBZ3wz56PzhF5uwU9yGZnUWY2qWlyhKUZY7LHstIPttZV5VkfvEtruPIvyw+rKOsXP
         2QfnZxPJfi8Q53L/9XBZ+g0PRXanu3pCcVEzsHXF/QGp5KJIgQAZMhstyuNUc5oGzDGw
         lVlvmB7Z4m5SZg5q+0nkSHGPY0EXro6rQHpFqu/WXscY0JEsOjnypqPIyLB/oemB6SHj
         ThI+z8x5r1wICCNEpdHgfCUdjSfrlHstAGuDhEvvTQdZufpNJ1dVLtkiWec94nRjgBnl
         CHq+urJz/ThBoeOdp2v3dXPf+83NfBLqHAWYPfZmdiyPPXTk/I/RzHT2CmfA18OjWqTc
         A1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774583024; x=1775187824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZ+5Uk/DsKDjljxFTH2gNYDX6n86w4DiW+i7ZwAY4FQ=;
        b=JqCQC3F9jI5E3KwcpA94MGOWz5h86+WEtpk1PENpnOsCc7PraS/5Qg4ptoFomB8+U4
         hE6/iYY3HqGuR/bHNIjQ3oNIYgb13qj/tVRmNEOHa7bxnhtIfDwHq4cznvHAv5fjiRV6
         Ol7uw8csKh8rwv5HhvTyNbTFTs0kCM2gP/6GWX9HVlG5rDGoJRA0ELD7VaQUwiAboWA7
         HNfPT9IZOPkiW8lmC98lcn9h+yUzZLa3lQdkBuWl5OHxPdyfiiFOqQ5vwo0Gl2Wq75/w
         ozTSXXnUrnsCpWD5T8F92l6rMOfL61BCoB/vG/Wj8QFmR91doDsGRJ89rzdEWmSL68VO
         Qcag==
X-Forwarded-Encrypted: i=1; AJvYcCVNYd4UcgxiEsqu4/y7on5bWZyYRfIkkagWcziSjNAzsTuKlG/NrRTdvQ/Ww/ZyPBaw0oChQ+M2JPTmaBodiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKP/8zcRcO/5vLHf+hDN8ibRfTPstpMV9HkqKPDDFrbmpovnTK
	+Fn72AQNuT5oPWvaQmu1Qoy2fx8D5wUyw6+SU4K6+WHAS7uMoY179I7Fqn63ZwCtSrt0d1eHHJl
	BM9Xbuuo7TqhDQ+o7D3opEBw3JBNj9DmZfxl0SsLc
X-Gm-Gg: ATEYQzwmh8qxHMoXNbbMyzh5Q5h5yjaI80LorllMWrtIPBunfrY5WatkDnPnLzxJLP3
	BVYsn5gA0Bz7HU3ZnDutKsYwip857VPS9dytREfeYYFdwLH3d6tL4J/oMGppl9QFE8db9AszmdW
	KtyZj8iNk/iKpEJuHgZEMKb7db+yIowsyqqcntz+pVkM5dBFpbAqVv3eRJ/Po1XPk73o3KDc8g1
	BsmRJeu1j/q9pvHsVhrNnrVzEoSTwDzloV7IxUS9Gs9h72OgN88zXOziCqS3g+4n2K62UgbkWxZ
	VYylyA==
X-Received: by 2002:a05:622a:5a0a:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50ba37d3a17mr14739431cf.15.1774583024002; Thu, 26 Mar 2026
 20:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
 <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
In-Reply-To: <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 20:43:33 -0700
X-Gm-Features: AQROBzBTAZQiZv5gITUpNks5cRGZmqvxfVTU9Y6vZlwD1VKoOLXGxZ_EY6bfseI
Message-ID: <CANn89iKJUMP+7udEPs_j2Z5pPJnc8-Gkn==5OLr63OJQs1a5Mg@mail.gmail.com>
Subject: Re: [PATCH v2 net] ptr_ring: disable KCSAN warnings
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 8:17=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 26, 2026 at 1:36=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!
