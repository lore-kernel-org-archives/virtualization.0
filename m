Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528133C1D62
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159631; cv=none; b=fmIcgu9oMaBBic86l+5wgzJQsmLEJUAt0LnJeApLCaUJhZJ6dRsBNLxf+OVfTjC5Flrr52ximwBSx9q923Kvf4FjhKX/wossvp3XbJvsVjAz88D9jj8/UjLdlxt4epoX18maM8K1xOrlqOM2vYEcIfdjn9dEIjH6oQmsTb4lU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159631; c=relaxed/simple;
	bh=MXXcOH+y4hl0L/RNN8RX65h8+wis8a7t0lw3Dv8huxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkg4Pp36Rqr9Yyr0UyoOHajM7D51NYs2I11aVLS01Us8Aw6TrZPt7Xl6VX2c9c80UnmikJpBzqn+nT76ZxIgFW9WrE6KzfilgwisoHEvp1h+zYg76rfWJb1YMWuCTbmn2ckOqysDDDzkeXedeBT9UW6P6Ebwo9vOC5bC9GjSqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPmlA6Ad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPmlA6Ad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788159628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2DvKAa4RARvXhQhytE/c96u+c2ks0rTMPN5Qc9vZ8A=;
	b=TPmlA6AdjRd/2+J0xWM5RXJJCNsyJiBkDJ94Hs/Qny0TSK+q3bZcFR/lOm6uG5h1DF10xi
	6NCgD+HRg3R7ldc3KzDtCXWuRJwFMtIp311DP2uycmFvOufUDP773U9yft6DcWXf6Wx5d4
	cp6u4kb28BnRRKU/yZbVLu4nz4xqbA0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-gKPO7IAuMQaL0qnUGgLrPw-1; Mon, 31 Aug 2026 03:00:27 -0400
X-MC-Unique: gKPO7IAuMQaL0qnUGgLrPw-1
X-Mimecast-MFC-AGG-ID: gKPO7IAuMQaL0qnUGgLrPw_1788159626
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-845cc1ab48eso18415607b3.0
        for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 00:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788159626; x=1788764426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2DvKAa4RARvXhQhytE/c96u+c2ks0rTMPN5Qc9vZ8A=;
        b=INpRvMJQ5CXkR9yXjo9AMfE8FLgMVeyUL/max7rdMidO6pfQVaudjdxfkrX8qGpuN9
         /pA2f3mofk6wsrAVjXXSBrl6JGskB6EfdFv9/djyd7HeNQky+MAyDVCRGz4Oc+z0mXvO
         5RDPcrP8AJ4nJlkmpsz29FounaIpyKk1GNlhcYH8H0gO+5SJl4mluk4io8PE4tY1K96z
         uLOXm3UpCa9hhK3OA1EHy+NJVdF/yb/tTicBNFbuLCdkEkMaDHrzd+yc94JJI71Y3R+V
         peigGUUujNnQWwJkIQnCLdtL0RtKE2blyFnPc18ET/enUp9VPwcmk4rrxNrEihIdW6Ar
         ZzLQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4T+1XLEG6DNYqglykYTDPhpTFnd3wBhXB/S79nUOX1scfTO5VGUP8+DtaAgs7vQr5hajMmYsykFFXbj6ctg==@lists.linux.dev
X-Gm-Message-State: AFuF++lBa91QlFDc2feR2onEPvM3siEu5a1TfLP5Wjq5M7/hYvHHU5Qv
	OPnXZji+SPkThCEVsPZ8cogtvXgDx/9KujS6I5V8DQ33GPD4EamfjKwvEMGra74sgH/CpaA4JwE
	/wU/AlLCcxUwbFMHKwMB1B15urdriNhgW1x7axUysDQwWj+2Lhub91a8F2lN1FSe/gwccRXKUbW
	zHM9L+vz7M590F94VAC1cyD4x65pssheMs4Kdu4v4nRF/BVywp1YZyOA==
X-Gm-Gg: AYBFou3J/MjRqGXTltXCLGFJzNqXIJrA8FZo9q+rOsYWaqYsvPgmK58hpEkODpTLCDD
	fjghbJbT5T40ZZpoUpz4sWI8GoaFeNtQ4Pnp7JeJI7BEyCDJlVOabroWbSZZSohY069RgfX465O
	uItW0ddq/VpHDkb+hT+6pmWba5mzFC8Bpwxq24XGk3WoqXtTlHFlRFdrw=
X-Received: by 2002:a05:690c:f08:b0:866:8f18:450 with SMTP id 00721157ae682-8668f274eb9mr11820607b3.26.1788159625664;
        Mon, 31 Aug 2026 00:00:25 -0700 (PDT)
X-Received: by 2002:a05:690c:f08:b0:866:8f18:450 with SMTP id
 00721157ae682-8668f274eb9mr11820317b3.26.1788159625076; Mon, 31 Aug 2026
 00:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424123123-mutt-send-email-mst@kernel.org> <20260828180933.743887-1-briandaniels@google.com>
In-Reply-To: <20260828180933.743887-1-briandaniels@google.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 31 Aug 2026 09:00:13 +0200
X-Gm-Features: AcwNN1XSJkuXBjZEwDIkh3xfc6n2M5txJOihoNH8-v1dWqr5sLesJvNRUV3Jp0o
Message-ID: <CADSE00KB6g7Qya2H7w4hjczZBWtdrNR=hhL9X1c10uOTZd1ZAQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: Add ID for virtio media
To: Brian Daniels <briandaniels@google.com>
Cc: mst@redhat.com, eperezma@redhat.com, gnurou@gmail.com, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PbvKu205FmWaY9r_h-W-VgEzeYjOK3eiraAVWbHjasw_1788159626
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:09=E2=80=AFPM Brian Daniels <briandaniels@google.=
com> wrote:
>
> > On Fri, Apr 24, 2026 at 03:37:14PM +0200, Albert Esteve wrote:
> > > On Fri, Apr 24, 2026 at 3:07=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Apr 09, 2026 at 06:53:41PM +0200, Albert Esteve wrote:
> > > > > Hi,
> > > > >
> > > > >
> > > > > On Tue, Mar 10, 2026 at 9:41=E2=80=AFAM Albert Esteve <aesteve@re=
dhat.com> wrote:
> > > > > >
> > > > > > Add VIRTIO_ID_MEDIA definition for virtio-media.
> > > > > >
> > > > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > >
> > > > > Are there any thoughts on this patch, or any actions I need to ta=
ke?
> > > > >
> > > > > Thanks,
> > > > > Albert
> > > >
> > > > Create a github issue and request a vote as documented in README.md
> > >
> > > The inclusion of this ID was already voted and approved. The device
> > > already appears in the VirtIO v1.4 specification, with the same ID (a=
s
> > > linked below). This patch is only meant to translate the decision to
> > > the kernel header.
> > >
> > > >
> > > > > > ---
> > > > > > While the Linux driver for virtio media is currently under acti=
ve
> > > > > > development and review [1], the VirtIO v1.4 specification has
> > > > > > already been published and oficially defines the media device t=
ype [2].
> > > > > >
> > > > > > Adding the device ID now allows other components and tools to r=
eference it
> > > > > > before the driver lands, and ensures the kernel headers stay al=
igned
> > > > > > with the specification.
> > > > > >
> > > > > > [1] https://lore.kernel.org/linux-media/20250412-virtio-media-v=
3-1-97dc94c18398@gmail.com/
> > > > > > [2] https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.=
html#x1-82200022
> > > > > > ---
> > > > > >  include/uapi/linux/virtio_ids.h | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/lin=
ux/virtio_ids.h
> > > > > > index 6c12db16faa3a..f9056af0c6223 100644
> > > > > > --- a/include/uapi/linux/virtio_ids.h
> > > > > > +++ b/include/uapi/linux/virtio_ids.h
> > > > > > @@ -69,6 +69,7 @@
> > > > > >  #define VIRTIO_ID_BT                   40 /* virtio bluetooth =
*/
> > > > > >  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> > > > > >  #define VIRTIO_ID_SPI                  45 /* virtio spi */
> > > > > > +#define VIRTIO_ID_MEDIA                        48 /* virtio me=
dia */
> > > > > >
> > > > > >  /*
> > > > > >   * Virtio Transitional IDs
> > > > > >
> > > > > > ---
> > > > > > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > > > > > change-id: 20260310-virtio-media-id-b31179fcdc44
> > > > > >
> > > > > > Best regards,
> > > > > > --
> > > > > > Albert Esteve <aesteve@redhat.com>
> > > > > >
> > > >
> >
> >
> > Oh my bad. I misfiled it into the spec folder. I will take care of this=
.
> > Thanks!
>
> Any plans to merge this in soon? This is a dependency of the virtio-media=
 driver.

Hi!

It was already merged:
https://github.com/torvalds/linux/commit/2187be212179243f33da1271248571aca3=
e99a3f

You should get it if you rebase.

Thanks for working on the driver!

BR,
Albert.

>
> Thanks!
> Brian
>

