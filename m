Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59F530DF5
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188956; cv=pass; b=GXfcKiqRSrDtMh5UmOmDz/h4aOK+CN4/FkfNI2rMV4/8mly3P/oBiUwLOLz9X/lJFcD7OBeR0JjDPEfjWy95yfZs/vdwf/gslmorahzsNctJO0tpDoGVPc9D8ydynqWm2U5B8eLdp9oz5ZRafbUyzo+7YXY17hxs2s4tgyy9614=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188956; c=relaxed/simple;
	bh=cwJf22VLRgJ4mnooTR3ZZt/LF7eumDZMkCcLNRtvft8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7ObmwnvTHbh1cyoNy6I8FQx777+vmPvRryo5Zwi49kZ/x+uPFShFSkAXv6wd+ftUtd/P0F9bgTtPVQzPm2c4omyivzC2hu8vtRCAuMzQgDJ9ZnkV29fETWmD+NGNua+Ha2sYizpGChd8F3kzNZTQm2xiLeDZBzT4g9Yz8ribRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jreRynNm; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jreRynNm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cede6375caso167365ad.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 08:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788188954; cv=none;
        d=google.com; s=arc-20260327;
        b=PiPxIp9rJPEVaCbQGcCR43Oq7R02qiRgavT7v5Ya1ztUBA9a4whWCKhFJ01ScEdXwm
         YdzVumfUABtsiGTuBfMilczA/JKdY3VS1HY5i+Sr43/FSdYT1syjtfJklqa6YW0c/2Ky
         l25yeuVzEZ975Is/Te0TTid/TW0ohebnJ38uQFWg20HlCwj0ppD3nIYcK9dz/+cU2+VI
         eDHMnce0a6vvoCGOPofNzxgN8tW1XOYbE7c4lmH1iGKQJQlB2ykCjfHUcv6+YSA5J/YE
         i/8KrYMCf21JB27YuXjhh+/q+DzugnTxskdLR0cY3aLCnpHjbqbAUA+27cPF4u7i1sXY
         UauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u0q5v3dSQ6qISD+Je916/B623UqYBZrUBVMWQLY3tpM=;
        fh=CtyPQZpT2yof1tTqLA9CykDaRTlqkoiDX4uhZ9R7nuA=;
        b=b8rihHfwWuPRcpgXwDehzwKiUqG3QixvPs+VEy3pv3xyZHWJcokINy7yBUsp4TaHk0
         GOn85TB4g2Us/QpW62lX6/C7gMrJ0j9o0tnZ77/Tc1YoycnqVT2dSWPlkXbWLyRjt12n
         zUQDiyQlmN+VO0aP/dbYAijcVFYjXpO/SuK2o82bmTyX88pzLm8bL+GPFvkzKdrUfEpq
         wADvg7TATO6qwrNdcMeIVJXcvHgOZU3bXyCtXVEzkFCZK/WyUz5j8tygUmqy4N5xs5ue
         TbtA3vnAuh+6T2Qy3PgOR1qbTpCQoAIvCGddaD8GW+cnHLI5JqesQY95db4Jmecq1TWg
         DIqw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788188954; x=1788793754; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u0q5v3dSQ6qISD+Je916/B623UqYBZrUBVMWQLY3tpM=;
        b=jreRynNm2b7hQy22ua5FIxzNxeHoBYoySptX/SE8XIVQwjxEaSgO4/0S2UumL8I9pC
         XGe7NwdFyjZuYfoK/OuNNEmJd9bTWTRu2NNij4hB2zK+fjikGS9AJN2GSTLf0qkD1IFy
         WrxYXnWpCbq8HVTUnMsiDr4X/1sUeWH54ISwI2Qo58LTtU8DTvWZcqwg2RFJYvkLH7Aj
         dNUQlNjEZAGeCrLG029Yrjwr4ltiMpFXBgJNQMuTn6riLkbwyH6g4pCKwC487JPqFnx7
         67J26O9pVzNNTQkXPSvHJda3IU+OuGO/9hsjiLZgLe1rDgrsn3tdZWDcmRRTWWcpfJYB
         PUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188954; x=1788793754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0q5v3dSQ6qISD+Je916/B623UqYBZrUBVMWQLY3tpM=;
        b=dyh23Lmgh4MOMa6MtigU91a+ZJNcJJQrFqMn/myPjIme9T7ouMvr38Glan7ZasAcX2
         TFuAhG8t8mXOl5wWQN2PEVkwJWacB917IXyq/Xx5701A/nrq50p4KxRwOpItsudYBBTw
         aPwgCV8t5VWM23TbJRb9QEdzk0iyig4BpZKUrUWdsklkhx5vs1xsdPYLpTtmNzbAAmXJ
         DpwuBPSBZxa0kmBZNt5NJyslbXPtGNAVC9d4S2y/NOTCVYGRE3OfV+M4iqTi5bW9nnSn
         5C1W56bsEexi6z69sCP+bVm4pV3QexvykTpumrTDoFxcJZJvQs7CpM9ZNgox+rhK+fOB
         KCGw==
X-Forwarded-Encrypted: i=1; AKwUvByYzYRORJAOHj6RgGZs4b+XFi7SF03BNOUA2r5RXeGhMTn5U/GaLxoBQcDf3xEXDXUPatzNRsFcurSFUH+6Ow==@lists.linux.dev
X-Gm-Message-State: AFuF++luWByanpTkhPcua7jT3qNrmPpqvbk+XdI25QdHlSeyHvc2tteP
	v/h3Qvhho+oAR9mYXMT6OuB4cwmVvQzrd+pW/xnls43ixUa9eqP0QbtsAflg7ps3bzJcQNIurlY
	XDk38+w4Jfiu4H6mo+FTOkLOs8UbTScwN7NXkYyQ=
X-Gm-Gg: AYBFou0FlpSq0n7oAGFzrP1pZ1LCsSRwomfD2ju47cv5F8aiPZd+s0WSQG9sR2x30fz
	iYAN6iQv8IkBkfbKchjAEpovJLCkFjeOx+X/5is0JUoY1mg70JfxU8J6UWBEhik87lrksYNA1U5
	XdmkzhCDS20SpUb/v+qTaKElliWUI7t+02Skswik4jKojN9HObrkgWGOxAODt2BaCtn9kAHqo8w
	gm9Fft2Ku62gOz3rIi0tkZzUTxyFwdXrgc7RC4z6OSy6yRnvwU36U9Vg4ltpkeIj6wKLtm99F8V
	JMJkdyhZLrgOyT6b7uNETk5PZgr/IVPd/5cNt9zC0Q4=
X-Received: by 2002:a17:902:ec8f:b0:2d5:cad1:a2e8 with SMTP id
 d9443c01a7336-2d8df402aaamr10743115ad.6.1788188953604; Mon, 31 Aug 2026
 08:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424123123-mutt-send-email-mst@kernel.org>
 <20260828180933.743887-1-briandaniels@google.com> <CADSE00KB6g7Qya2H7w4hjczZBWtdrNR=hhL9X1c10uOTZd1ZAQ@mail.gmail.com>
In-Reply-To: <CADSE00KB6g7Qya2H7w4hjczZBWtdrNR=hhL9X1c10uOTZd1ZAQ@mail.gmail.com>
From: Brian Daniels <briandaniels@google.com>
Date: Mon, 31 Aug 2026 11:09:01 -0400
X-Gm-Features: AcwNN1XLoZxxmKqTZ2g0OS5eXuRtKfbM-0ITCjBS_YNiSW-b2z5ALHt0tVSbNjM
Message-ID: <CAD4i_GTGCop3=B5Bzw-9JpbrMr2vQWwJkcdrvUqUfE_5sNi=3g@mail.gmail.com>
Subject: Re: [PATCH] virtio: Add ID for virtio media
To: Albert Esteve <aesteve@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, gnurou@gmail.com, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, great. Thanks for the heads up, Albert. Will rebase.

Best,
Brian

On Mon, Aug 31, 2026 at 3:00=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Fri, Aug 28, 2026 at 8:09=E2=80=AFPM Brian Daniels <briandaniels@googl=
e.com> wrote:
> >
> > > On Fri, Apr 24, 2026 at 03:37:14PM +0200, Albert Esteve wrote:
> > > > On Fri, Apr 24, 2026 at 3:07=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Apr 09, 2026 at 06:53:41PM +0200, Albert Esteve wrote:
> > > > > > Hi,
> > > > > >
> > > > > >
> > > > > > On Tue, Mar 10, 2026 at 9:41=E2=80=AFAM Albert Esteve <aesteve@=
redhat.com> wrote:
> > > > > > >
> > > > > > > Add VIRTIO_ID_MEDIA definition for virtio-media.
> > > > > > >
> > > > > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > > >
> > > > > > Are there any thoughts on this patch, or any actions I need to =
take?
> > > > > >
> > > > > > Thanks,
> > > > > > Albert
> > > > >
> > > > > Create a github issue and request a vote as documented in README.=
md
> > > >
> > > > The inclusion of this ID was already voted and approved. The device
> > > > already appears in the VirtIO v1.4 specification, with the same ID =
(as
> > > > linked below). This patch is only meant to translate the decision t=
o
> > > > the kernel header.
> > > >
> > > > >
> > > > > > > ---
> > > > > > > While the Linux driver for virtio media is currently under ac=
tive
> > > > > > > development and review [1], the VirtIO v1.4 specification has
> > > > > > > already been published and oficially defines the media device=
 type [2].
> > > > > > >
> > > > > > > Adding the device ID now allows other components and tools to=
 reference it
> > > > > > > before the driver lands, and ensures the kernel headers stay =
aligned
> > > > > > > with the specification.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/linux-media/20250412-virtio-media=
-v3-1-97dc94c18398@gmail.com/
> > > > > > > [2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.=
4.html#x1-82200022
> > > > > > > ---
> > > > > > >  include/uapi/linux/virtio_ids.h | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/l=
inux/virtio_ids.h
> > > > > > > index 6c12db16faa3a..f9056af0c6223 100644
> > > > > > > --- a/include/uapi/linux/virtio_ids.h
> > > > > > > +++ b/include/uapi/linux/virtio_ids.h
> > > > > > > @@ -69,6 +69,7 @@
> > > > > > >  #define VIRTIO_ID_BT                   40 /* virtio bluetoot=
h */
> > > > > > >  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> > > > > > >  #define VIRTIO_ID_SPI                  45 /* virtio spi */
> > > > > > > +#define VIRTIO_ID_MEDIA                        48 /* virtio =
media */
> > > > > > >
> > > > > > >  /*
> > > > > > >   * Virtio Transitional IDs
> > > > > > >
> > > > > > > ---
> > > > > > > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > > > > > > change-id: 20260310-virtio-media-id-b31179fcdc44
> > > > > > >
> > > > > > > Best regards,
> > > > > > > --
> > > > > > > Albert Esteve <aesteve@redhat.com>
> > > > > > >
> > > > >
> > >
> > >
> > > Oh my bad. I misfiled it into the spec folder. I will take care of th=
is.
> > > Thanks!
> >
> > Any plans to merge this in soon? This is a dependency of the virtio-med=
ia driver.
>
> Hi!
>
> It was already merged:
> https://github.com/torvalds/linux/commit/2187be212179243f33da1271248571ac=
a3e99a3f
>
> You should get it if you rebase.
>
> Thanks for working on the driver!
>
> BR,
> Albert.
>
> >
> > Thanks!
> > Brian
> >
>
