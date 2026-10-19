Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBF4F4CE7
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414869; cv=pass; b=KK28dS8EQkzFJEFYkNezo9scf/ytb4CwMKAFoXYZAsBfCtZxeBIlY03IdvvQexedNj5VwARAs7L/eWRldfGMDHD1kxuVT/BplTmrJRE/oTgN5MhDP+q9UfONrMxA+xhZVslpky2zg/YYNkNFpFaEufC6qeWSeBPIXA00UEHd3+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414869; c=relaxed/simple;
	bh=de4WRoZFaD3lgjauScr5sV8aw74tWRpk4ewrSfnzero=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agKeKT6zfUjkecKOuRGJ0GNoUETE/F9jkwedjdXCowDx2HTcI97NuASBMGL0s9p0XDeaOm9HIrELZk5HEHxovOxzsrIYOw11erg80JcMVeI3QQaJkE1oSiMKiQN2pwlC1Y4cNf6WnGIK2+jHF4KHCgAljnZYsWj+JW9WqTmK7lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnYvm5wq; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnYvm5wq"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c37b612635bso247536266b.3
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 06:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792414866; cv=none;
        d=google.com; s=arc-20260327;
        b=fnHVQeVgdVrd9FjGDrXrwbYqKfwP3vxQfp/FwzKGnuGZ42rItUJrXHSv7OpsXmtM7h
         PMtsAd0muUlcs0asr0ceamzPnjq087dN3ZUT/GHOQn6LTF3PH3DrTOGRW9fHMVAETG/2
         M9gFmfvjGwoiBlaADMzbY7k0svyauYoSzv+mMVKA5mkOGQ6Sn6tl3GfiaS06+v+a3JW5
         3tG1DcFysEfSqK0xL95xFQrtou9rZOkeiuCsZqCQxuKA2Sb9dTegHz1Fqf2v8Wo0zkLE
         IzRMqhizB0rCRB7Tu3IVtMyixXGLb6rMQsb1FsISEWNqIB9H+ZaMHHff2Qka0qfixsFo
         9cOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=phogftG3FaF6nlP3xa0hV5oXVTce+rqKpGshxnP7eVk=;
        fh=IbyTWfA4Svy+T9WxxE68+srVE63Z51Y8OtgtPzi44b0=;
        b=FtRiBSK197iyGdQF+IDzLBhWjGe6qgwKCo/eWim3DhjWUxBPwM3ADbLLADgTLMKHrV
         R4uD8TCdSAh5ESAAhLXzaPwrfdEm7aBjz649W03IbWVWJAo8gkY3Gjhlgius9Fh4+900
         iS+p/5DErAQm6QE4FXhxFx6ktw9xM0HN7HEbwjk1C6uVaBgD+CCWqkn3IgpD3GXM/VyV
         PGSBQCc8OWqh87h8EydYWLHQMdMcWksrZ1o4cPfYZynKJFqmcR8cSHOJGakSX7W1uNfO
         Hwpu+pnfWHFUJ/XaY6IGTYIezJLR+XPN9tnmCHwYAlEiGeX/ij2A02okc0yBEAPdE/bW
         /xZg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792414866; x=1793019666; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phogftG3FaF6nlP3xa0hV5oXVTce+rqKpGshxnP7eVk=;
        b=NnYvm5wq/PgzowgieNs9mHY8vjqJ4ERv5nyOYg+YgTMgdeqopnbROoR//H16WiSqHT
         IOLksKl0LeWXISyFmFotxNtDKzvClyrJppDPf3qy99s2CR6nPtmClCI20l5RynpNJzQk
         RruL3uUz8Xd7eM7ORnpxmgAgf2P8dLReRsOOSpbKYMLHyeCMFR4R3UwhP5ffKe0/gTKa
         IEGBQepyiGeZblY+7qJXEV7sUfI9pO/pJug9EeV7/uJi26G75mKywjReMTyRFmgt0wVS
         d5tQJRBVamDqF/YCJSyvL3JHyalcrr/2TNGZUETwmyQTfh8wYB89NH0roWUpFYQuxOVw
         xz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414866; x=1793019666;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=phogftG3FaF6nlP3xa0hV5oXVTce+rqKpGshxnP7eVk=;
        b=QgNoIHAEufqNe8sXDnG7Zr4s39xwLvKk/tPLiTPxngCE7KFzD49EFI8pLbk5jAsaau
         yq2IVPRjQ0e3RHSKzFKClIs1OAV2zWWS8xPfZoppSlPuQ06LoBpQcEW193v566/LslzZ
         cMg1wDOo0OY6MshxoL5V6VPSwf1IINZ7yH8OKOzpFLOXVy+QtzvHBRIuBSSpzdm6M41k
         hM9onvULi2ife5FiU9/0T/bijEnkpv8GDkKZH+eSVpqb4PPgjHpM+CuP7ZED/rmg0jHs
         yU44TVptJstMIoeLaooMgh75wCYHk6EFpHM0gmW5Dtsmo4dNXBoLO0ug9I4OSiJfl0DE
         0bHw==
X-Forwarded-Encrypted: i=1; AKwUvBxhpobRwddnPEPpXv3RiRyK+KGGGHlidmoV4+dNuXkkOWYz3rZaF658xx+PUtQm7AXvySlsAlaHihgZ4COPdw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJQLNpleiJnOB7RcrI/s38riofe1M8AZgm/fT0ib2GIcNhuNjth
	XTW9viejNBUU9TG7Be42gJeiuYnZb0f7h2+NCEP3erQbhkKqN/7yweSsam+TQVdQGi3SuqcuPys
	OOG1zeL5tJeiDBfUXZNWXBefFty9nTEg=
X-Gm-Gg: AYBFou3CzExq7PS0n9Wn0IxdP8omiiH/L02Xvjvee1rxIkb+bKFUd7EYfaYdi57G2TN
	tNE2oeRg853auSNx7VatutSGhhx65WZKcCkLDA4wR2j5OBw3HxtLdI3tGUKUhf0HOlya5vFzQg+
	a0TIdsfz2AVbCva4mN4BCm37Te9ZQX3v1E0GtQ7xaX90fp2J5DNQAaaG8SQnwf0dReLJujWa5qz
	C2DC8xRZsULPyfpproj5jYyh/3TVItlb4wPE0PapeLY5pOXTIvotTtS/yVLoJYzM7+VG9CIzSEM
	CPVAwAoca1aqZIEEsHW0urf82Ygm2T+glO26Iu+xbOKartq7JwhbjAIm+82+Zmb5/ZE9n4pG9RG
	m0hU/rKJX7J1IkZ4ZmkYD1XorcdR/2mc+XGZOJyAch3U7muUFg+4FfLglsMRwEa9sFglgp7/WKs
	Y=
X-Received: by 2002:a17:907:9702:b0:c3f:7e8:235d with SMTP id
 a640c23a62f3a-c419b13cb81mr585828066b.5.1792414865469; Mon, 19 Oct 2026
 06:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261016103640.4989-2-blum@kernel.org> <CANc+2y7ruqmfO+D_nfdc9rnBE0uSSnZR9UJY2Dvc5Nez9U-61Q@mail.gmail.com>
 <atUuAsxE42s8NGEY@kernel.org>
In-Reply-To: <atUuAsxE42s8NGEY@kernel.org>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Mon, 19 Oct 2026 18:30:00 +0530
X-Gm-Features: AclHuK9F_lIB1oQ9kkXqLikaEL15-RIDnT85r6_EBtYmdugz9hD8gsTn-BpuPrU
Message-ID: <CANc+2y6Wf8HCf6mUdZb3dALZitMUR=JdhThQWMyp_R=AdMKH9Q@mail.gmail.com>
Subject: Re: [PATCH] hwrng: virtio - prevent use-after-free after a failed restore
To: Thorsten Blum <blum@kernel.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rusty Russell <rusty@rustcorp.com.au>, 
	Amos Kong <akong@redhat.com>, virtualization@lists.linux.dev, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 02:07, Thorsten Blum <blum@kernel.org> wrote:
>
> Hi PrasannaKumar,
>
> On Sun, Oct 18, 2026 at 10:30:08PM +0530, PrasannaKumar Muralidharan wrote:
> > Hi Thorsten,
> >
> > On Fri, 16 Oct 2026 at 16:16, Thorsten Blum <blum@kernel.org> wrote:
> > >
> > > remove_common() frees the driver data during freeze, but does not clear
> > > vdev->priv, which points to freed memory. If probe_common() then fails
> > > during restore, a later remove or freeze can dereference the dangling
> > > pointer.
> > >
> > > Clear vdev->priv on the probe_common() error cleanup path and before
> > > freeing the driver data in remove_common(). Also reset the device and
> > > return early from remove_common() if vdev->priv is already NULL for a
> > > safe teardown after a failed restore.
> > >
> > > Fixes: 08e53fbdb85c ("virtio-rng: support multiple virtio-rng devices")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Thorsten Blum <blum@kernel.org>
> > > ---
> > >  drivers/char/hw_random/virtio-rng.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > > index 5e83ffa105e4..a9ff520975a7 100644
> > > --- a/drivers/char/hw_random/virtio-rng.c
> > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > @@ -190,6 +190,7 @@ static int probe_common(struct virtio_device *vdev)
> > >  err_find:
> > >         ida_free(&rng_index_ida, index);
> > >  err_ida:
> > > +       vdev->priv = NULL;
> > >         kfree(vi);
> > >         return err;
> > >  }
> > > @@ -198,6 +199,11 @@ static void remove_common(struct virtio_device *vdev)
> > >  {
> > >         struct virtrng_info *vi = vdev->priv;
> > >
> > > +       if (!vi) {
> > > +               virtio_reset_device(vdev);
> > > +               return;
> > > +       }
> > > +
> >
> > The virtio_reset_device() is always called before setting vdev->priv
> > to NULL. So the virtio device is already quiesced, no need to do early
> > return. Isn't it?
>
> The check is still needed.
>
> For example, during hibernation or suspend, .freeze (virtrng_freeze() ->
> remove_common()) frees vi and sets vdev->priv to NULL.
>
> On resume, .restore (virtrng_restore()) calls probe_common(), which
> could fail and leave vdev->priv NULL. A later .freeze or .remove calls
> remove_common() again, which would dereference NULL without the check.

Yes, it makes sense.

> Best regards,
> Thorsten

Change looks good to me.

Feel free to add:
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>.

Thanks,
PrasannaKumar
