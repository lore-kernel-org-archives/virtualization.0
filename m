Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488219;
	b=pBNMAQkS6CX3TPZqA1rhtmYODQ5Yv8HUv75Ci+cPFX9Ym59yDTIHDHPmOAU52a7qB19b
	 8ZVYP18adGdhBmtUSXzOH4tdRCHkPPFV2vDOSofdcna8aoP9qr5gcnoqEAjc6+sPAAUAx
	 2WlDgIOs+PNqDA/Qh04yCxixefpK2dfJGmZp8stExDYdekHLE3VgabIRRmdZbJvfMwC9u
	 PLCR2Qqhg4U54tUFaI6/L0dwc83dbfjuVZaUNwW9di06OoyQ95rdcsa+eVQUSnwu8RKTc
	 tykHeA2L0ScmejE0m+GsYUJQ752mCtA8XuMfrFs+tuhKMwlWxtR3slmuPf5fnH0fzjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488219;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
	b=brIw1ojs5Q5JcYmDu1K9pJVHq4ux82Y84IPYfgd2MW0lCR4uxEeX0KL0d+dRJNltsOXR
	 r0JpspE8qyXnB3G4he0UL0VWOwHXpfcJ+NRXGidnF204/FDrbECnH302CpCine9hLu+R5
	 tPaZt7x9haoHADN55n/IfEX+vTcreXLINmBzFj/k9xJeFMcREMuf0sJEi2ax8t+eYjK0t
	 bFHVyaKXGLPZN+WeS3epZYRypoKzXrcSQqV2Xn8eGFpax4ChGa5OpyfPE1HkUG8Zu7UC2
	 kIJ/zfJhXYcnzd8089757Q8+OkvgqAeSs4fU8AcCzkeq/D/aJ/egmZ73aTPG65NU3/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfypJeRK;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6B606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 09:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfypJeRK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792488218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
	b=NfypJeRKRqwFquvhsEq68Ko04X10FJe9akXqv9Cw/6TVq8Os91UDZc0hjOHkQ9pctkfk4j
	Gip1o/G3nuaifXgBFIHG0dCERaCSCtu168weusAWOT4RzHwPlLnIjg10usOqq8IbOEGMYB
	91uKhEY4Z2moI60gkOmmaWWwqDyyFnc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-Lfknp58ROS2rJuZdPirxTQ-1; Tue, 20 Oct 2026 05:23:37 -0400
X-MC-Unique: Lfknp58ROS2rJuZdPirxTQ-1
X-Mimecast-MFC-AGG-ID: Lfknp58ROS2rJuZdPirxTQ_1792488216
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b0da010661so36983187b3.3
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 02:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488216; x=1793093016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
        b=WE0xIkiZihOdJsc1VRRfTf3Vzde3ovSOvW8bpPGM//U06IuoTyokYVwgHW/QHjiwWt
         rIZ7jgKMPZ3AuhBMoxpKsH7ZoWddxkVx+xPzf+55D+t26lU+qibqza2TAfD0KhS8/aCI
         +hb7vHlBtOYaQW/LfSH6VYjzh3zNIv3WMg6Sm8F1nyEHXkjh5rTyHQssgUITQOs//JcQ
         eqeMVdsAaFDL/+J5f+SIO5d+VVBkU2neeQj+9ukkwUr76tqeRWKsr6QLLB076dkUj8xT
         BG0xymvMy0dHs+Rx4ep1rt+JWrLh/caomfgIuqdyIsdFwdiQ5/hNuQT8IISB3o53VZgU
         AhFg==
X-Forwarded-Encrypted: i=1; AKwUvByXtbOolDharoY5hhdp5Nw67GJxi/3xjzRtTy5R21fnOI3M+R4djIsJEVj36/nC+P0yxBdIm/SYKpH5K8XN3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJvsAb9vxRn1z/HRtB4HkyYPPbF7YYAKG2eIohv/Z/r3wTugvYe
	NsV+rPj7e154UkA5OskE2vOm4cSt1aHeG3QokKv6eyR6jy/KIsFsW4EIhx5Pr7X/dKEcDIBJfNA
	OGoKJkdhvPnZlm+y+F2EmPU+PNEGp/91ajpFCPFmaJx4wNrqjJLd/bjO3dxxEFhAJrzr51fO2H1
	MsdQVLGR6THPxIZ6kPgsnyEjW6PxauonVnS4tcLAyNrCY=
X-Gm-Gg: AYBFou0sBcXtxEnnbttyfzqdIELcqUBASk/VLFYltH1Uc5nwn3AeMbjGWhDojL7xGu6
	hQ3Tvynd8LNZWEdd3J27QA6xPGCmyzgd9nV8CGp2SUDYSPcYrl1PhR6XCc4GyAwMU/ymgYJ5kvf
	PnVoKHKsqjpmwySjXU4sYz4fMgBncHg9igODxYaCMkaSxZuX1IITcfjwcRoZFZ7S7y0xD1c/56W
	HB///kjPWJcaWFvphrANsFu56fi8KOB5Z0SWBq950UJ83ct+RNvSEDGILw=
X-Received: by 2002:a05:690c:7107:b0:8ab:41ed:c08a with SMTP id 00721157ae682-8b0f1f1a888mr37599687b3.0.1792488216202;
        Tue, 20 Oct 2026 02:23:36 -0700 (PDT)
X-Received: by 2002:a05:690c:7107:b0:8ab:41ed:c08a with SMTP id
 00721157ae682-8b0f1f1a888mr37599617b3.0.1792488215700; Tue, 20 Oct 2026
 02:23:35 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org> <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261020021924-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 20 Oct 2026 11:22:59 +0200
X-Gm-Features: AclHuK9FUCG_bUrdJCcSR0YUoQOz7ayN0KKtj2bVgQH1ECGQzQu04PmOJxsZwI8
Message-ID: <CAJaqyWfcg_K33c5hzSh83vgTvujn_M_8odcxFSTVzkcv6jQu9g@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, torvalds@linuxfoundation.org, 
	jasowangio@gmail.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XAKedPXS74FWWjcrRPuF42xrJEtO0DsZtglMS6WlpVs_1792488216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 8:31=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 19, 2026 at 03:14:46PM +0800, Wang Haoran wrote:
> > Eugenio previously offered some additional suggestions in reply to
> > my patch email. Should these also be addressed?
>
> The following seems to work for me. Testing would be appreciated.
>
> From: Michael S. Tsirkin <mst@redhat.com>
> Subject: [PATCH v2] vringh: use get_user/put_user in the use_va path
>
> getu16_iotlb()/putu16_iotlb() pass the address produced by
> iotlb_translate() straight to __get_user()/__put_user(),
> without access_ok checked anywhere. Not good.
>
> Switch to get_user()/put_user(), which are always
> correct, and safer.
>
> But the fact is that accessing user memory like this
> will sometimes (rarely) race with page being swapped
> out, trigger EFAULT, and it should be retried
> from a worker, and vdpa_sim currently does not do this.
>
> Fixes: 42823a871fd4 ("vringh: support VA with iotlb")
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>
> Notes (changelog):
> v1->v2:
>     Use get_user()/put_user() wrapped in pagefault_disable() instead of
>     access_ok() followed by __get_user()/__put_user(); the helpers are
>     reached from BH-disabled sections, and __get_user() is not a valid
>     way around that (David Laight, Linus Torvalds)
>
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 2 ++
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 ++
>  drivers/vhost/vringh.c               | 4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index 76dd5b0828d7..325ec8f0ab85 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -347,8 +347,10 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim=
)
>                         smp_wmb();
>
>                         local_bh_disable();
> +                       pagefault_disable();
>                         if (vringh_need_notify_iotlb(&vq->vring) > 0)
>                                 vringh_notify(&vq->vring);
> +                       pagefault_enable();
>                         local_bh_enable();
>
>                         if (++reqs > 4) {
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index a6514b5ccd86..964cdf422467 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -77,8 +77,10 @@ static void vdpasim_net_complete(struct vdpasim_virtqu=
eue *vq, size_t len)
>         smp_wmb();
>
>         local_bh_disable();
> +       pagefault_disable();
>         if (vringh_need_notify_iotlb(&vq->vring) > 0)
>                 vringh_notify(&vq->vring);
> +       pagefault_enable();
>         local_bh_enable();
>  }
>

Why not move the pagefault disable_enable to wrap just the accesses?
Future vdpa drivers could use va and we might miss the call. Also, the
reverse is also true, vdpa_sim could be configured to not use it, even
if it is not a big waste.

> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..74836eb60c7a 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vringh =
*vrh,
>                 return ret;
>
>         if (vrh->use_va) {
> -               ret =3D __get_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
> +               ret =3D get_user(tmp, (__virtio16 __user *)ivec.iov.iovec=
[0].iov_base);
>                 if (ret)
>                         return ret;
>         } else {
> @@ -1251,7 +1251,7 @@ static inline int putu16_iotlb(const struct vringh =
*vrh,
>         tmp =3D cpu_to_vringh16(vrh, val);
>
>         if (vrh->use_va) {
> -               ret =3D __put_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
> +               ret =3D put_user(tmp, (__virtio16 __user *)ivec.iov.iovec=
[0].iov_base);
>                 if (ret)
>                         return ret;
>         } else {
>

