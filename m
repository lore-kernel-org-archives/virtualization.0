Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E633D6F0
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592017; cv=pass; b=YaRp4QymI6Dz8r4bo+BQHQwECHN5BorgKan7JkiFepvezNM2oHC8oh0nLv4Lpv+zmytrRiBhTYAw70Eh4+WUlWEESgL06yhIYS2P74CvsLWCypfIZMggh2VjXM7HghhlCdvxlx/aQ8dDEPSAVQIlQK9kp4Y7aziA7kMoylGc1qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592017; c=relaxed/simple;
	bh=Rav5QAZDUd5X0iw0ia2oSwvucMC5riVwhOob7fw9u8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0vx+f1OSQ2jRRl66TqirPbfp2v3E4frNRViicQpI5JFrnbiFBT1pVx5msSkbg42tYsvhu8bg1WY8NT21apsbg0MXCv0FMNuV2edjZU9xdU1he3CMV0Ry0x59GjzVdI4OUls9yHMKO5Csy3OGc+qklRMOo5s6bWdE4z+9vjShtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=stellman-greene-com.20251104.gappssmtp.com header.i=@stellman-greene-com.20251104.gappssmtp.com header.b=dLbzIikl; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stellman-greene-com.20251104.gappssmtp.com header.i=@stellman-greene-com.20251104.gappssmtp.com header.b="dLbzIikl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66f916529d5so498093a12.3
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 13:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775592014; cv=none;
        d=google.com; s=arc-20240605;
        b=jWEDuzLI5JCE3XVwzZhcN5iZkk1RhqcTHAy+PtOm9+rLmXNI731fG89IumC0aiwRXU
         X12xT2fl7mrYPbsEFonG+qlSZA4yIKltMbZLzwCzsbc2O1JBW2RzEofxnyIpmRynXOFI
         gpiFMHcKlNxknj3G7RdPIHUnkNSqufXR+lMuDxL2OfuK3Xql89XlimoGwPnHbXoPmsac
         01LTc5hdyivigybEHu/n4Lu/91mX0N35Ieb6HBOhBPzZIrAQVeNjMzhnS947tPar17OC
         lVu8fS5/+AvbzlfoiCJ6McVjt1CO80sDEBwjDh7U4m7U7/3WU7tZMwfJ/Qupsq2m+4KW
         SnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jmUKg/j0i/Eze0CGADbSpEgqSzA2Wu/Qpwt9TMrxLl4=;
        fh=+FzU/O6jUlTCZEWUE9AjJ4fHwz/7aaKgad6nLCR2sQ4=;
        b=JC/KY9fxAepc/5GrKoHXOkww8gn4NGqZ8XqOPPGJYFfJl9U94o49W5q4dPibY6O6UH
         cb5s9sv+ZVmoNSuxvRD9lVGQVpwcPG02XqI1wORbQBLehTsYBMWqHsW6bqOcGMez65O7
         yYx8mhfr0pElO3eDfrPwz7/I6Uj9QHbt0vt8igZ51eurvdloM++EbwobrQVXJhHlFNVP
         mBEZRAnL2MLU7atB8H1klmJyzNmABgt8ww/wnbsXq3q+XZ11Q66QWCRLJUCaBdmKk3Xo
         RAF7s9O4q/9t/EEc1CaIAHNWQUW+l9gjXFjrpxHwQ7pLn0Cz1b3bJIM2QM16W3nOfvcT
         SufA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stellman-greene-com.20251104.gappssmtp.com; s=20251104; t=1775592014; x=1776196814; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmUKg/j0i/Eze0CGADbSpEgqSzA2Wu/Qpwt9TMrxLl4=;
        b=dLbzIikl1pDcIfA+RkBF/3uT26SO6fDwM+opIn29JpGGRG97nEaSyyze98Fhjoj4JQ
         TWD5dUyfkQ45TajHK3v7qKcWPBoJjh5YW60KatojAMvvmHWxoPffBQvmfom9yFuDvVIb
         RPcftRnqUKuHfy2uskM/b9+FoObA2rv0KRF+kiO7H09rAEEwlqnr8YR6mvhCJBPEJIAA
         lEIXuUSxPK3y5bnrypC9y3Z8Pd1ymlHpT9cjbNuxgIWaSL1cG3Nw5f54iSK8hVHPwvXM
         +EdAPPqUyL0EZy2yGmXQF8wXEPrGxEEyz8J1L+UE0Bzf1kMV+WqCfQ/5MdEFY1tJnt3Y
         Nrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592014; x=1776196814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmUKg/j0i/Eze0CGADbSpEgqSzA2Wu/Qpwt9TMrxLl4=;
        b=Lg6tLRnNHHRdAOlPjQR7FJ2HjvZYVetEol5EYqANvYfpdsttAPRx7KXwR/RU/L4CRH
         I8M1k5PS8YsRLFHUZYoly83weE6A4BxnF9EmS5q+jwCnNAmjtwFKe6dayf2vwNWZXt+C
         KrYeh+7wKhfBTjBJhY6BM+WeLRCvJfmQc2b5GC+CQ0tobUMtfk+BOdruUQFGTaSjHAoE
         4CUHBbo3RydiWCII9718JwZBhl76MjAUxKziPgM6ENL6v0j7VVlYc21+3eMYgykQc956
         qvCb63RP2moEspXs16ywJyhitLSm5dutccOlbgQ3zuiU5EPUCOxtlc/wBfEkVYFWu4lg
         XV3w==
X-Forwarded-Encrypted: i=1; AJvYcCX60QaGe6+J8+z6OgzzpV292dko4ZIwQ63k7dIk5S6H3vR/ZIK8KkTZwNF2BV4onN7i4CWqPIMk7W0e6eBeFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOLFjKWW/Axno1LsQE1U1W+b4RtrrevwgPzKVaMq/XAOKKLFGF
	F/O859sL72XtI45PLtthKrpJR1xVCB6hQqE+Kf/evXOLQDIpDFRlA+/BZw+CDUbKySsqTFGFpfC
	AlgyMRXKEPMyBkaRLFVHk2yeC32DGblw=
X-Gm-Gg: AeBDietFykwTk7mcq13AlltYNHQAb4UWpyTf6PMEA0frLQ7jsK6j8RNgEEuH5QUkduU
	PT1J/9XNh/2Osbl+2g0hkKwnScwxykgGLNW3DuHLMtAk59smDQmkzld0fSExpmnU/KIlu2uvSeT
	MzeXvbxf81eZHVo+zZ+VwL3APqnpSyxsTTpODZD7/SazmfS7xFqsPunbLllOyzoi0F1LBA5l/Bv
	8TBmwJ2BWZTP4y3So/gnnpV1IpM6RnIfGtTtZHPoyH7N+iyJnt4A67zhDfxj4hfMKxnKgR+a6Q9
	LMkT+3Mf9v1ARiWCeE+JXFwIcMQN7e94XJrMHoZQPlVdcezQsDObvyt9w0RkQYlaqirJPb3U4p2
	D03KWIz1I2nQWnYX3yXGzYnm6rRkp+smQXYV4qgIycabucEW8axCCKBr67O4=
X-Received: by 2002:a17:906:fd86:b0:b98:6926:13a5 with SMTP id
 a640c23a62f3a-b9c67b51d75mr960843066b.46.1775592013805; Tue, 07 Apr 2026
 13:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-5-astellman@stellman-greene.com> <20260407122025-mutt-send-email-mst@kernel.org>
 <CAChPuV92aD4BibJiGfMASQVQBHAoz+3OgzQS6Hb2Dw7JDcRJTQ@mail.gmail.com> <20260407140713-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260407140713-mutt-send-email-mst@kernel.org>
From: Andrew Stellman <astellman@stellman-greene.com>
Date: Tue, 7 Apr 2026 16:00:00 -0400
X-Gm-Features: AQROBzBkKHXLS5bO5e15GhUd3aaGzJArOuB3MVrIV3uiimeLehwWVjG0iFfavTU
Message-ID: <CAChPuV_D33D8t9wFNZB0pq9hfrAe_WKF4LX2VpEmF=npogx7gQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] virtio_ring: preserve VIRTIO_F_RING_RESET in
 transport features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000003ffbca064ee43b1d"

--0000000000003ffbca064ee43b1d
Content-Type: multipart/alternative; boundary="0000000000003ffbc7064ee43b1b"

--0000000000003ffbc7064ee43b1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No, sorry, I tested it, only with a unit test after finding it via static
analysis, not the "real" way using the whole kernel build. (Also replied
with the test for 0002.)

Found with static analysis, reproduced with a unit test (save attached file
to drivers/virtio/test0004.c):

% cd drivers/virtio
% git checkout virtio_ring.c
Updated 0 paths from the index
% sed -n '/^void vring_transport_features/,/^}/p' virtio_ring.c >
extracted.c && gcc -Wall -Werror -o test0004 test0004.c && ./test0004
FAIL: VIRTIO_F_RING_RESET cleared during negotiation
% git apply 0004-virtio_ring-preserve-VIRTIO_F_RING_RESET-in-transpor.patch
% sed -n '/^void vring_transport_features/,/^}/p' virtio_ring.c >
extracted.c && gcc -Wall -Werror -o test0004 test0004.c && ./test0004
PASS: VIRTIO_F_RING_RESET preserved

If this doesn't work, feel free to ditch.

On Tue, Apr 7, 2026 at 2:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> On Tue, Apr 07, 2026 at 01:33:39PM -0400, Andrew Stellman wrote:
> > Code analysis only =E2=80=94 not observed in practice. And you're right=
 that on
> PCI it
> > doesn't matter: vp_transport_features() re-sets the bit after
> > vring_transport_features() clears it, so PCI never actually loses the
> feature.
>
> Oh. please do test patches, or note they were not tested.
> how were rest of patches here tested?
>
> >
> > The gap is for transports that call vring_transport_features() without
> > independently re-setting VIRTIO_F_RING_RESET afterward. Whether any
> current
> > transport hits this in practice I'm not sure =E2=80=94 it may just be a=
 whitelist
> > consistency fix at this point.
> >
> > Happy to add a Fixes tag and resend, or drop it if you think the
> PCI-level
> > re-set makes it unnecessary.
> >
> > Fixes: 04ca0b0b16f1 ("virtio_pci: support VIRTIO_F_RING_RESET")
>
>
> surely not this because pci is fine.
>
> > On Tue, Apr 7, 2026 at 12:22=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com>
> wrote:
> >
> >     On Tue, Apr 07, 2026 at 08:39:04AM -0400, Andrew Stellman wrote:
> >     > vring_transport_features() whitelists known transport feature bit=
s
> and
> >     > clears the rest via __virtio_clear_bit(). VIRTIO_F_RING_RESET is
> >     > missing from the whitelist, so it is unconditionally cleared duri=
ng
> >     > feature negotiation. Drivers that depend on ring reset capability
> >     > silently lose the feature.
> >
> >     Hmm was this observed in practice or just from code analysis?
> >     And on which transport?
> >     Because
> >
> >
> >     static void vp_transport_features(struct virtio_device *vdev, u64
> features)
> >     {
> >             struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> >             struct pci_dev *pci_dev =3D vp_dev->pci_dev;
> >
> >             if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> >                             pci_find_ext_capability(pci_dev,
> >     PCI_EXT_CAP_ID_SRIOV))
> >                     __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> >
> >             if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> >                     __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> >
> >
> >     ...
> >
> >
> >
> >     }
> >
> >
> >
> >
> >     > Add VIRTIO_F_RING_RESET to the switch statement, matching the oth=
er
> >     > transport-level features.
> >     >
> >     > Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> >     > ---
> >     >  drivers/virtio/virtio_ring.c | 2 ++
> >     >  1 file changed, 2 insertions(+)
> >     >
> >     > diff --git a/drivers/virtio/virtio_ring.c
> b/drivers/virtio/virtio_ring.c
> >     > index fbca7ce..2cb643f 100644
> >     > --- a/drivers/virtio/virtio_ring.c
> >     > +++ b/drivers/virtio/virtio_ring.c
> >     > @@ -3524,6 +3524,8 @@ void vring_transport_features(struct
> virtio_device
> >     *vdev)
> >     >                       break;
> >     >               case VIRTIO_F_IN_ORDER:
> >     >                       break;
> >     > +             case VIRTIO_F_RING_RESET:
> >     > +                     break;
> >     >               default:
> >     >                       /* We don't understand this bit. */
> >     >                       __virtio_clear_bit(vdev, i);
> >     > --
> >     > 2.34.1
> >
> >
>
>

--0000000000003ffbc7064ee43b1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No, sorry, I tested it, only with a unit test after findin=
g it via static analysis, not the &quot;real&quot; way using the whole kern=
el build. (Also replied with the test for 0002.)<div><br></div><div>Found w=
ith static analysis, reproduced with a unit test (save attached file to dri=
vers/virtio/test0004.c):<br><br>% cd drivers/virtio =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>% git checkout virtio_ring.c <br>Updated 0 paths from the =
index<br>% sed -n &#39;/^void vring_transport_features/,/^}/p&#39; virtio_r=
ing.c &gt; extracted.c &amp;&amp; gcc -Wall -Werror -o test0004 test0004.c =
&amp;&amp; ./test0004<br>FAIL: VIRTIO_F_RING_RESET cleared during negotiati=
on<br>% git apply 0004-virtio_ring-preserve-VIRTIO_F_RING_RESET-in-transpor=
.patch <br>% sed -n &#39;/^void vring_transport_features/,/^}/p&#39; virtio=
_ring.c &gt; extracted.c &amp;&amp; gcc -Wall -Werror -o test0004 test0004.=
c &amp;&amp; ./test0004<br>PASS: VIRTIO_F_RING_RESET preserved</div><div><b=
r></div><div>If this doesn&#39;t work, feel free to ditch.</div></div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">On Tue, Apr 7, 2026 at 2:08=E2=80=AFPM Michael S. Tsirkin &lt;<a=
 href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Apr 07, 2026 at 01:33=
:39PM -0400, Andrew Stellman wrote:<br>
&gt; Code analysis only =E2=80=94 not observed in practice. And you&#39;re =
right that on PCI it<br>
&gt; doesn&#39;t matter: vp_transport_features() re-sets the bit after<br>
&gt; vring_transport_features() clears it, so PCI never actually loses the =
feature.<br>
<br>
Oh. please do test patches, or note they were not tested.<br>
how were rest of patches here tested?<br>
<br>
&gt; <br>
&gt; The gap is for transports that call vring_transport_features() without=
<br>
&gt; independently re-setting VIRTIO_F_RING_RESET afterward. Whether any cu=
rrent<br>
&gt; transport hits this in practice I&#39;m not sure =E2=80=94 it may just=
 be a whitelist<br>
&gt; consistency fix at this point.<br>
&gt; <br>
&gt; Happy to add a Fixes tag and resend, or drop it if you think the PCI-l=
evel<br>
&gt; re-set makes it unnecessary.<br>
&gt; <br>
&gt; Fixes: 04ca0b0b16f1 (&quot;virtio_pci: support VIRTIO_F_RING_RESET&quo=
t;)<br>
<br>
<br>
surely not this because pci is fine.<br>
<br>
&gt; On Tue, Apr 7, 2026 at 12:22=E2=80=AFPM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, Apr 07, 2026 at 08:39:04AM -0400, Andrew St=
ellman wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; vring_transport_features() whitelists known tr=
ansport feature bits and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; clears the rest via __virtio_clear_bit(). VIRT=
IO_F_RING_RESET is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; missing from the whitelist, so it is unconditi=
onally cleared during<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; feature negotiation. Drivers that depend on ri=
ng reset capability<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; silently lose the feature.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hmm was this observed in practice or just from code=
 analysis?<br>
&gt;=C2=A0 =C2=A0 =C2=A0And on which transport?<br>
&gt;=C2=A0 =C2=A0 =C2=A0Because<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0static void vp_transport_features(struct virtio_dev=
ice *vdev, u64 features)<br>
&gt;=C2=A0 =C2=A0 =C2=A0{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_pci_devic=
e *vp_dev =3D to_vp_device(vdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pci_dev *pci_dev=
 =3D vp_dev-&gt;pci_dev;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((features &amp; BIT=
_ULL(VIRTIO_F_SR_IOV)) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_find_ext_capability(pci_dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PCI_EXT_CAP_ID_SRIOV))<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __virtio_set_bit(vdev, VIRTIO_F_SR_IOV);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (features &amp; BIT_=
ULL(VIRTIO_F_RING_RESET))<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __virtio_set_bit(vdev, VIRTIO_F_RING_RESET);<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Add VIRTIO_F_RING_RESET to the switch statemen=
t, matching the other<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; transport-level features.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Signed-off-by: Andrew Stellman &lt;<a href=3D"=
mailto:astellman@stellman-greene.com" target=3D"_blank">astellman@stellman-=
greene.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/virtio/virtio_ring.c | 2 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/drivers/virtio/virtio_ring.c b/dr=
ivers/virtio/virtio_ring.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index fbca7ce..2cb643f 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/drivers/virtio/virtio_ring.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/drivers/virtio/virtio_ring.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -3524,6 +3524,8 @@ void vring_transport_fea=
tures(struct virtio_device<br>
&gt;=C2=A0 =C2=A0 =C2=A0*vdev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0case VIRTIO_F_IN_ORDER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0case VIRTIO_F_RING_RESET:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We don&#39;t understand this bit. =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__virtio_clear_bit(vdev, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; 2.34.1<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div>

--0000000000003ffbc7064ee43b1b--
--0000000000003ffbca064ee43b1d
Content-Type: application/octet-stream; name="test0004.c"
Content-Disposition: attachment; filename="test0004.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mnp1laro0>
X-Attachment-Id: f_mnp1laro0

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKiBUZXN0OiB2aXJ0aW9f
cmluZzogcHJlc2VydmUgVklSVElPX0ZfUklOR19SRVNFVCBpbiB0cmFuc3BvcnQgZmVhdHVyZXMK
ICoKICogVklSVElPX0ZfUklOR19SRVNFVCBpcyBtaXNzaW5nIGZyb20gdGhlIHZyaW5nX3RyYW5z
cG9ydF9mZWF0dXJlcygpCiAqIHdoaXRlbGlzdCwgc28gaXQgZ2V0cyBzaWxlbnRseSBjbGVhcmVk
IGR1cmluZyBmZWF0dXJlIG5lZ290aWF0aW9uLgogKgogKiBzZWQgLW4gJy9edm9pZCB2cmluZ190
cmFuc3BvcnRfZmVhdHVyZXMvLC9efS9wJyBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jID4g
ZXh0cmFjdGVkLmMgJiYgZ2NjIC1XYWxsIC1XZXJyb3IgLW8gdGVzdDAwMDQgdGVzdDAwMDQuYyAm
JiAuL3Rlc3QwMDA0CiAqLwojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGludC5oPgoK
dHlwZWRlZiB1aW50NjRfdCB1NjQ7CnN0cnVjdCB2aXJ0aW9fZGV2aWNlIHsgdTY0IGZlYXR1cmVz
OyB9OwoKc3RhdGljIHZvaWQgX192aXJ0aW9fY2xlYXJfYml0KHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2LCB1bnNpZ25lZCBpbnQgYml0KQp7Cgl2ZGV2LT5mZWF0dXJlcyAmPSB+KDFVTEwgPDwg
Yml0KTsKfQoKI2RlZmluZSBWSVJUSU9fVFJBTlNQT1JUX0ZfU1RBUlQJMjgKI2RlZmluZSBWSVJU
SU9fVFJBTlNQT1JUX0ZfRU5ECQk0MgojZGVmaW5lIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVT
QwkyOAojZGVmaW5lIFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYCQkyOQojZGVmaW5lIFZJUlRJT19G
X1ZFUlNJT05fMQkJMzIKI2RlZmluZSBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0JMzMKI2RlZmlu
ZSBWSVJUSU9fRl9SSU5HX1BBQ0tFRAkJMzQKI2RlZmluZSBWSVJUSU9fRl9JTl9PUkRFUgkJMzUK
I2RlZmluZSBWSVJUSU9fRl9PUkRFUl9QTEFURk9STQkJMzYKI2RlZmluZSBWSVJUSU9fRl9OT1RJ
RklDQVRJT05fREFUQQkzOAojZGVmaW5lIFZJUlRJT19GX1JJTkdfUkVTRVQJCTQwCgojaW5jbHVk
ZSAiZXh0cmFjdGVkLmMiCgppbnQgbWFpbih2b2lkKQp7CglzdHJ1Y3QgdmlydGlvX2RldmljZSB2
ZGV2OwoKCXZkZXYuZmVhdHVyZXMgPSAoMVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEpIHwgKDFV
TEwgPDwgVklSVElPX0ZfUklOR19SRVNFVCk7Cgl2cmluZ190cmFuc3BvcnRfZmVhdHVyZXMoJnZk
ZXYpOwoKCWlmICghKHZkZXYuZmVhdHVyZXMgJiAoMVVMTCA8PCBWSVJUSU9fRl9SSU5HX1JFU0VU
KSkpIHsKCQlwcmludGYoIkZBSUw6IFZJUlRJT19GX1JJTkdfUkVTRVQgY2xlYXJlZCBkdXJpbmcg
bmVnb3RpYXRpb25cbiIpOwoJCXJldHVybiAxOwoJfQoJcHJpbnRmKCJQQVNTOiBWSVJUSU9fRl9S
SU5HX1JFU0VUIHByZXNlcnZlZFxuIik7CglyZXR1cm4gMDsKfQo=
--0000000000003ffbca064ee43b1d--
