Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9252443F4DD
	for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228811; cv=pass; b=tk8pMduGZTnPx4l69Qd/P4rsZI/084aL38FJQn4plqUfrCYDe//AhXBi6hOzeeT0F+dFBANnsuM53amZesDXFEBzYkGtYByLcFQmCMUm3LnPpAOBMxEP1nchppaD/9bqEdtVJmXYHL+wX1UbH5soAiQp2cYV/RMyVUwb6gXKvls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228811; c=relaxed/simple;
	bh=IGs71nhOgGaVjpIG8DskqbqnZo+eShOgII8VvXDhzeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEie3xdfDxNG2qkqn1F0YCHewfjtgSzNFnwf6B00oKJW6MbBfilDjUMLy1ES6KLwdcDg+BCelLfAjkEDpiJXJhwbxTNQKehFfoZdBShRWti1Wdt8yws/GwA7TtRqZ+1JOjvXDkfwn4KRkvcHGM4ltl3lsMLSzNcVC77O4Kx2+JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1bjgqyk; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1bjgqyk"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5b048375so124702385a.1
        for <virtualization@lists.linux.dev>; Thu, 20 Aug 2026 05:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228808; cv=none;
        d=google.com; s=arc-20260327;
        b=qqwlWI7OdbrqsCvJxyaZh0B24W783r+ca2Yso+o195JXBuXUOH76Bx5UQd8CC5eWul
         pxq8g1bHewKZWZj4ZWso+UJ6YffG7ib5rJnNTlPyLjgjQPN21HR5IsoWT4a4JP2zcwP5
         eimHzPU9Pfmxkiuk8Wvvy93ezPqEuYKpy7wiGpmkaD0d+qjaErENy9zBnKJRgw7Dl4lc
         7fdStCD0nAD7YNSb9JdYjG0YUeg8ysicEVc8iliiLWzJFAALRh9IZy3rVfhEv+Ut1r/9
         ABG97Xj+IGy5rLDm+67FJfSNyzUQYY4H1sIRyA+BEtR/MdvtOA9MTnwQdOcjEsSc4N0F
         71jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        fh=SD2lwS7GsyHiinh81vBqnJLh7LGb43BP8+YSNR228UM=;
        b=ar7TaCP0VvEmnzvfeWCBSka6lrtvnI28/lJ8EnDWrrKR1ge14T5htERNGnAZB++nf6
         bh8FkYUfMm6FTG3cHJyOBEqVtUiJzs6oBvCrtCpjZA/fFDpUKaIK/ZG4w0HF0l3lEH+T
         l2+d+sz/T3L54zE7gu6rmUNbb3+VmAUE/LAoWQo9N3ttwyVXaVISb14qU3fJVzzaMlzn
         46rTvxFb55/YIthtILyJrmfFPehUQ8p5g8sTQO9ilbbbsYHEo3nucTDtjwvaU2adBbi4
         tX31q6V06TBQ9RzKZOjn8NKI7HQ7ol8UeAREvCaeKS7sqUq6cxAPTo/7MvLCD4QBAL1s
         v6vA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228808; x=1787833608; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        b=H1bjgqyk9dx77gfZ4iYXdvoyYnbEJtMA0dpgQ+SB270bhN/KSE1Fcl1XgZPgaYS/zO
         yoGuW6Pn8Cm22HH/hhqBc1MeICGX7fLe2LaCm3cSpyTwgtvOu7STV/Wd7Vz59lLvW5sE
         2TZvmrQrWsae6TbUjfKCB0BZK2NxAaTLfKbi5sslryQM3NDbDPYX/cH1CcDatn0zjfRi
         zC8eYBGUybQv+MWsVqA+z1ZzAbuDzTPCfWL3BcTdPe+G5MEO5i5L9x40+gCMAYDU1tLA
         E0SKUAKraj7agkcPkOkFFpWHS8JkUAtUwIV6S0ko788AE2OJbrZcw+NmWuqPQFV2dgFO
         cUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228808; x=1787833608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngnJnixAtK4fZ8jMYvDkCA0g5N99ucaPAuQOZK7BSJU=;
        b=RX/BMWaURr1sPoqQcjLbBTuXzp5B9pnvpFi1UUdzkuwbiv8jqUChl2q1My2OGO0Tjj
         0MocaEe1ZcQdlHT2r0uYlyQwnvI0jdU8m/xSCu2Cz+uwZBWLLOctrDu4ssZCIM8IJOV+
         oHh+qhr1cZpTwKrZ+yVXwHEMo9F+VOB+t8fV7iFXb5aVhAhC058y7jgBuGqcYSqodtKi
         1uZpjgJJc/Bnktw/f1f2+NTltN1JtA6DPQmUe3k+1LPu1POGshDqXkaZi8FSWQrfrCl3
         KNgAUhwiJ8oj6vml1HKHBIJBX6IWvSKfcfvKBQY479pL5s1zYAWlnSCF/qAGNbE+46Al
         9YUQ==
X-Forwarded-Encrypted: i=1; AHgh+RotA+fLt7x8ZHx3xXbjssV4nTmUykTZTGXiriaSvZltWB/7iQx60zKqqmPVCytMaQ9wr+yI88SIi3sxm16qlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiHU4LaguceiVRlYA2xnNE2ItrlsM9lC4yLASgoiStlHq/Ir9q
	KNHTegGMvBRITNEpbxaKulkXVODcOo+xyBjpOcIHmpunE7Y0ZEiQpv2DIAd5c5Mtq/3JsZsdkNg
	jFLGhemPK0VC0ZTgiWXX4w4CGoNlrvcE=
X-Gm-Gg: AR+sD11nWLfQ8jSHkZH5CYptI0R2DamURzGboI6sjQuX8zoUwf8Gv8vQ9U2nRJML4/F
	c3GtC9duoXXeUJE2TGSa92SWdVmMG7Qe7f2tbAOxakdq1U/volsHSIGmcB+W6OqnkKMplBonw2p
	+Ppx3cc5CA/k+ZnYfI+YvUFYIYb8gMeT1eHOtO7tMFOmmxxaQ0Wz62paSt66kMLsC5s08jsPbjb
	/C7XQtj1q04eEBolYqdoYxW5WxpdiKfrS/vbnWn+fhDVjQs5XwZVPIeLKYbKeNY+sOpkAa/n6ZO
	IuIbkXBb+SQEXmrRsfrSBve6gixPwv6QwgNQGEfnP2z5
X-Received: by 2002:a05:620a:44c9:b0:936:d9ad:67fe with SMTP id
 af79cd13be357-9371e2029f2mr1042764485a.3.1787228807799; Thu, 20 Aug 2026
 05:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-3-physicalmtea@gmail.com> <aobEwtvZ2WELwX15@sgarzare-redhat>
In-Reply-To: <aobEwtvZ2WELwX15@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Thu, 20 Aug 2026 20:26:10 +0800
X-Gm-Features: AcwNN1W9WrFqa6rrna4A1-P2dxuYVQJvqoSZIMHeqb-Fn4IWrxAmb7MsiC3ZMZI
Message-ID: <CAJwVaMLrp4+d_6cx9mHEMC+FoD3UUu-Z8QVDAm7Ekt7SrqjACg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Thu, Aug 20, 2026 at 04:03:31PM +0800, Jia Jia wrote:
> >Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
> >Otherwise descriptor translation can continue to use mappings installed
> >before the feature change.
> >
> >The common helper invalidates cached vring access and applies the
> >transition even while a backend is attached. The backend remains attache=
d,
> >but userspace must configure the vring addresses for the new address mod=
e
> >after a successful live transition.
> >
> >Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> >Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> >---
> > drivers/vhost/vsock.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >index 9aaab6bb8061..e1e9d002d6ae 100644
> >--- a/drivers/vhost/vsock.c
> >+++ b/drivers/vhost/vsock.c
> >@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vs=
ock *vsock, u64 features)
> >               goto err;
> >       }
> >
> >-      if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> >+      if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
>
> Unrelated change...
>
> I think I've already pointed something like this in previous versions:
> for a patch that fixes a specific issue, these unrelated changes should
> be avoided. Please keep this in mind.
>
> Stefano

You're right, thanks for the reminder. That was my oversight=E2=80=94I shou=
ld
have cleaned it up more carefully. I'll remember that going forward.

>
> >               if (vhost_init_device_iotlb(&vsock->dev))
> >                       goto err;
> >+      } else {
> >+              vhost_clear_device_iotlb(&vsock->dev);
> >       }
> >
> >       vsock->seqpacket_allow =3D features & (1ULL << VIRTIO_VSOCK_F_SEQ=
PACKET);
> >--
> >2.34.1
> >
>
