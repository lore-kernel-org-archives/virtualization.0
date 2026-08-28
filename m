Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A0397B0B
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787940578; cv=none; b=XuZLEaSaLfWkY5odIajBt3yhdTHLBErtR/Hw8+jFOiUn37nBJWe4xnmUaquuQeWc5jeMu/J3II29eYRcob24dsUeajLX40Hbd+H+PDIpRNxpItxER415VOFPxKreqbPFenUXezY+v7zK1vo5KBl7szUVZko7d3qalSFaAh7vq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787940578; c=relaxed/simple;
	bh=Ugpvaz+FwUowalgYQSZeQPmONoAAl1nlU+pdz9LB4tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i6fJCBI3Q6b8sWu1KspXayMhR3yKzHhJrmyyBK2EMu9CTTTpuPMgjBSJQ0zcM7+MpE9Lf93OG6YZdfhDf+zuRglbiZm8a4gIl9fO6knS94FA8qQ2ea9F+gbYTle63hcUbw8hZGuCWlHrfIi2wWO9P/rx+6eQq6MjU8tsfvR0URo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pf3de5Sk; arc=none smtp.client-ip=209.85.219.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pf3de5Sk"
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90cdc69a7b5so12932506d6.2
        for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 11:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787940575; x=1788545375; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JnpgDp/+EDzOPy1A4LRxbe5FNGtxdeXUihLtU+6Z1Q8=;
        b=pf3de5SkCEwmRN2Y+A/1c6fMkhufWBdsaQqx64DOOBmw22DTOai3+inRR509SOBFGj
         m/sBHOfPH6WhjUnBOEAH0A4Jo3Su71DkG5KgJ2amCEGUoby4D/Ntpkuys7icIu3waY0U
         XkWF2IhLnMV9wrgcA6OZUqF9ITew5hCwj36gI2GvvciG482yxk2MTUadhWn6y09vGqe/
         69fAZD3cvb83fhg3ga8cT7RhNwWvyB4BeBQSAJ3X9XQSG8LonhM8IU3nwoMFBtoWY6JJ
         x2J2ORwCn+7vqOXO84xLBlGaIUlODWmXoKJbZUi3Z/0LIRL8+4D94KQXxn98jg8BOjCX
         Uzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787940575; x=1788545375;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnpgDp/+EDzOPy1A4LRxbe5FNGtxdeXUihLtU+6Z1Q8=;
        b=KrOruNJCTjLKnaxOgSlfTT8Q7yjXkMpwpxLd3H1/Aq9J1AMVrJfkkozGM8SwSRmfBZ
         qcP31NyOiTvyPJAeb4Qbt/6gRK/xA2NWx7cu04/3WbyyymG4pDh/Db8uAsBgA/nLnKHw
         cAlf1SdaykykunQcK0n5sDzMl+Xyz+jNSbVAZT9tplriPDcThtny6ClELfp6vWxVPi3E
         p4BvsmmIDppi7o9c+LDhb74XF2nbRp9T0JIhcNoGqXJ0spzGbsFjTlVmZFwQDTqL/z3Y
         MnyBPZIBIponewEdoteJEpWt14ZecHAQPALBHtoYvnsSgs+w02gg+0TOrtp7POMrCf0d
         1Zbg==
X-Forwarded-Encrypted: i=1; AHgh+RoXFgIDjZ+x29njU0Stbv3ahaf9xqc8nPkiF//roOKuApeOwcX+7xqFhzQRLwSdzUae2xE43b0b+08DXkPaYQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nbVjtbZQo34AEXFP4+kpbPavqJS9OObF+zCrB7CZ5oDsG9FMSh
	B9LtO0GCW9NuNnpP0rXerHbHC7R9iJ88fT+swwBGgPUcqDtBe1incwc9Go1yx3iCYCf0yR2LfBd
	f1gz/c7dc8LIdAo6G4aao30BzpACP
X-Received: from qvjh18.prod.google.com ([2002:a0c:d812:0:b0:907:46e5:8768])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:cae:b0:90c:40ba:e64d with SMTP id 6a1803df08f44-90ce0c0a094mr108859686d6.8.1787940575111;
 Fri, 28 Aug 2026 11:09:35 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:09:29 -0400
In-Reply-To: <20260424123123-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260424123123-mutt-send-email-mst@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828180933.743887-1-briandaniels@google.com>
Subject: Re: [PATCH] virtio: Add ID for virtio media
From: Brian Daniels <briandaniels@google.com>
To: mst@redhat.com
Cc: aesteve@redhat.com, eperezma@redhat.com, gnurou@gmail.com, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Fri, Apr 24, 2026 at 03:37:14PM +0200, Albert Esteve wrote:
> > On Fri, Apr 24, 2026 at 3:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Apr 09, 2026 at 06:53:41PM +0200, Albert Esteve wrote:
> > > > Hi,
> > > >
> > > >
> > > > On Tue, Mar 10, 2026 at 9:41=E2=80=AFAM Albert Esteve <aesteve@redh=
at.com> wrote:
> > > > >
> > > > > Add VIRTIO_ID_MEDIA definition for virtio-media.
> > > > >
> > > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > >
> > > > Are there any thoughts on this patch, or any actions I need to take=
?
> > > >
> > > > Thanks,
> > > > Albert
> > >
> > > Create a github issue and request a vote as documented in README.md
> >=20
> > The inclusion of this ID was already voted and approved. The device
> > already appears in the VirtIO v1.4 specification, with the same ID (as
> > linked below). This patch is only meant to translate the decision to
> > the kernel header.
> >=20
> > >
> > > > > ---
> > > > > While the Linux driver for virtio media is currently under active
> > > > > development and review [1], the VirtIO v1.4 specification has
> > > > > already been published and oficially defines the media device typ=
e [2].
> > > > >
> > > > > Adding the device ID now allows other components and tools to ref=
erence it
> > > > > before the driver lands, and ensures the kernel headers stay alig=
ned
> > > > > with the specification.
> > > > >
> > > > > [1] https://lore.kernel.org/linux-media/20250412-virtio-media-v3-=
1-97dc94c18398@gmail.com/
> > > > > [2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.ht=
ml#x1-82200022
> > > > > ---
> > > > >  include/uapi/linux/virtio_ids.h | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux=
/virtio_ids.h
> > > > > index 6c12db16faa3a..f9056af0c6223 100644
> > > > > --- a/include/uapi/linux/virtio_ids.h
> > > > > +++ b/include/uapi/linux/virtio_ids.h
> > > > > @@ -69,6 +69,7 @@
> > > > >  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
> > > > >  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> > > > >  #define VIRTIO_ID_SPI                  45 /* virtio spi */
> > > > > +#define VIRTIO_ID_MEDIA                        48 /* virtio medi=
a */
> > > > >
> > > > >  /*
> > > > >   * Virtio Transitional IDs
> > > > >
> > > > > ---
> > > > > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > > > > change-id: 20260310-virtio-media-id-b31179fcdc44
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > Albert Esteve <aesteve@redhat.com>
> > > > >
> > >
>=20
>=20
> Oh my bad. I misfiled it into the spec folder. I will take care of this.
> Thanks!

Any plans to merge this in soon? This is a dependency of the virtio-media d=
river.

Thanks!
Brian
