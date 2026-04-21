Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A443A5E82
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809773; cv=pass; b=XBtf8ztmBAYTok9AN8B5Qoc4XkoJbGSeTZe8yi07sWqBYUfGWAXSxKZJKCndfkAos9YDJk4JL2+5Oby0+dULVmbcTVMwYCDbV4kIvywAMAwZ3WlcdNKaEbVjVcaP19wBOx+JofGsurC/wDQ0xasnvwpQ/SXEi9P2TCUIfeZiIOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809773; c=relaxed/simple;
	bh=wCb5WnK5IXMJykd0g+fzA1cYxAAqi0ZLgT1nUV+qTds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF9zI61WvwtwgJe2RA1pbixhwxUxDWI7cc7x8eTYZPtzPu9Ja31S1pFUo7jJX+amQF/gHa+m5FjJs9t/gjWJ/WNocxb9EbmNqyrgqDsLTPWd0BSqL5NtSkaJ11j2C3ZLFWJXam3aXIRD3FDk+qxkz821KzJ1jfIFDr+t4PeBj20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=op6FhtjC; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="op6FhtjC"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e61648f10so1846211cf.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776809768; cv=none;
        d=google.com; s=arc-20240605;
        b=Avu76a4yESnvhfWBXxitQDYr7dFbajj136CFb6AN9thdSsDmgIsuxvOphtS9x+9YRO
         GgxFc81vvdKGhwun6V0z5cbGSrv6uN1XcTomo3osxk1purWSO0L3yJOoe56AFsc52gqQ
         RKbFwABCQbVMi3izBKzCF6XW/rfXd6pc1JIo+6XoTt5jrr/ZYT7MYvEXgextNi+23g0G
         PdZTnTrpziodR7V+Cnn84jsXx723Y8/faSbWFlr2sgZo7qnmp18qIFLSML4gOnCeeVWU
         3+wAQvwG9Vg+0uKFsf6dHkkbm8FjEMmsQ8mrR1WzFSq2KR8D6Vaz/S5KDZiR+6fKN4/6
         8h/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yo7qsCjBTqq5Qqdw5bUyfKvL0SbBYn4qcy4CfrCnNpE=;
        fh=+qeIvPCNVoL1xw87djZJ4moPiqwPnR90GVuVDMpWm0c=;
        b=h0+hg4+YN0ZdN/DboVVEu4odz1EEMnflBqMe0+IV697Vf5btZmz+0WuhGhHMMhyMEd
         s0PoXAuNGJ/AxthaecJXjInR4wfCvnTBQEtZX8zNX8asKPQxzp0tHGlGVcF6fxWJFLiT
         RXJvqqQjkEHiJPohDqXohl4/ap/cnZfBnlGCB2VdpOlovpPjDJk6f1/ZoBDybRfTW1eR
         tdj52ckQba6MTfEYN3rrTHmc5V1TBfvUu626sd45/cFw9xdra5ERrPAsUiFK6sc4TCYS
         mlkJN356lcWaSDe5YHvgvtzIF7441MiuzZKRxIJX2dH3w2PLm0CKUqhrzaIcF52uj4bo
         TiqQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776809768; x=1777414568; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo7qsCjBTqq5Qqdw5bUyfKvL0SbBYn4qcy4CfrCnNpE=;
        b=op6FhtjCqzcu5CFd7dtaU6ohPpJJaPbvzgWUZ0CIGwN7lBxP6KepDMchSrfepIBQr1
         7XCZdi7vV4xF4vhYX2zdEtIPXS9Nr9LE1LYRECNFDTQyPqrVy+Z/KMGEXAoASnLRVcZ0
         Hq7xY1nUP7YldCR+EN7UwPRsxYpgCA6QpBI29/tNWQIHXfI8onLVZIuKsLT12p8rTUIG
         Br/usZ/EGnwMoBECHJRfQ9R8ZsX9kXswWCfM91fCAPhk1c5ZIbttpK13jS5X7zIlSpPl
         H4xYTuLVqND0QrLBBX7ECf8HrGfh0mOCpWWIyAZYkCf5wsuMLg2+p46jea/GhSMkGJIr
         Eexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809768; x=1777414568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yo7qsCjBTqq5Qqdw5bUyfKvL0SbBYn4qcy4CfrCnNpE=;
        b=ge0doEYMPsns7TJLAbQGuN4KHOSx/KDq5zdiaqkwFATp5bIKI1AEL4B1pjZRW1qN6k
         QI8o/KXtoCiwFKSnU9zZ8bY/Jx2XRII04Sb0s3xRz/tDlbhyfklgNFZ4F+pU8nk49ARv
         XajiCMWZTuweM4spVs3f4/4K7Ln/G2wJTmA52vvnlwaYdrAM08V9K6h55p+EtDy4gCBB
         o5WoAvGDAl1cJmPELsk++YUa5IZz+RGoYijqq57KBSeZuSKFi9qcdk84+Ufy9u1lRYw+
         4iMs3+mgub3GToxDLmYZsRvgqUlujhNAi2xx/KCQproGgpeXiKfPPsWaUaqQqo7gdpkl
         FJeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DOwE3tjZVpJ/TRCQv6yMGJ2lA+AagEwfjQTBtbhiIQlKV3KkpHcPadB4E6/Ss/m4Id51bxMEqXcviHmAlyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz8CSetnnYtlw+GyOgzKU1d2Vwc+ewTHawhbBKO1FTZVd06g+j
	dvY9KRBBdT6WUAd+DJoE+Fji5qSjCtC6jwTnZnmoxQFSA4MagSi3JT0hUwrufyMdGiz0Jtgwe4J
	fuofpaNmdGHU8MssyZbseyJKSXAfhfr41eF5IT6zr
X-Gm-Gg: AeBDiespLtNNbW0vqT6LkPD7fOglTEXk/iCYwv2ewFxAD2QKxNoRijA7SVPquiOHP98
	CDoZ9iMiHMI0dAYCJVgvZ2IxBJL2XVANUGMSlLmsp1nqyTq9VUNr9KnC0yQbzVHOEPJQB/HkdZ5
	bKT82T3v8TZnyMfurb0Sfb4gFAnlER2CnkHc6/u/YDICv7lgOnYCWQkff851gi6cpv7tK7qUA2a
	HCIf2BptBqS3Ygct7Zf1Ul6xLbWAH5CBh9lQeYzx12BEgW7/egbMnIW+DQw/XoDpeOPnyqEL/S0
	I9xRklHs1TPw4uc7MAh2tdTgjT2ClpePl5aC0acAK9W0veqqU1P6gQY=
X-Received: by 2002:a05:622a:1b90:b0:50e:6360:96e with SMTP id
 d75a77b69052e-50e636015acmr1944611cf.0.1776809766959; Tue, 21 Apr 2026
 15:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260407212521.934620-1-linkl@google.com> <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
 <CALUx4KTPcRCGvyvJfHSU_t61UJOuTBaAGxJ6nhUuaghE0_ZfUg@mail.gmail.com> <20260421175107-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260421175107-mutt-send-email-mst@kernel.org>
From: Link Lin <linkl@google.com>
Date: Tue, 21 Apr 2026 15:15:55 -0700
X-Gm-Features: AQROBzB0yzASCN8JZKEAk3nrm-V9Rw6WU2-rYVFHRD9F9ogjJf1kqd99CUdGJ6I
Message-ID: <CALUx4KRuJcW+ea7wrupQAd_cFJvzRxcrYq93DTYMDyB2vkf96Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1] virtio_pci: only store successfully populated virtio_pci_vq_info
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	jiaqiyan@google.com, rientjes@google.com, weixugc@google.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ammarfaizi2@openresty.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

That's essentially the same fix as ours but one month earlier. That's
great news!

Quick follow-up question: Do you know if this will make it into v7.1?

I also noticed the patch has the "Cc: stable@vger.kernel.org # v6.11+"
tag, which is perfect since we actually hit this bug in v6.12.

I wasn't aware of Ammar's patch as I wasn't subscribed to the mailing
list. Looks like we tried to reinvent the wheel ^_^;

Sincerely,
Link


On Tue, Apr 21, 2026 at 2:51=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Apr 21, 2026 at 02:47:32PM -0700, Link Lin wrote:
> > Hi everyone,
> >
> > Friendly ping. Apologies if you are getting this the second time - my
> > last ping wasn't in plain text mode and got rejected by some mailing
> > lists.
> >
> > Please let me know if anyone has had a chance to look at this RFC
> > patch, or if any changes are needed.
> >
> > Thanks,
> > Link
> >
> > On Tue, Apr 21, 2026 at 2:24=E2=80=AFPM Link Lin <linkl@google.com> wro=
te:
> > >
> > > Hi everyone,
> > >
> > > Friendly ping on this RFC patch. Please let me know if anyone has had=
 a chance to look at this, or if any changes are needed.
> > >
> > > Thanks,
> > > Link
> > >
> > > On Tue, Apr 7, 2026 at 2:25=E2=80=AFPM Link Lin <linkl@google.com> wr=
ote:
> > >>
> > >> In environments where free page reporting is disabled, a kernel
> > >> panic is triggered when tearing down the virtio_balloon module:
> > >>
> > >>   [12261.808190] Call trace:
> > >>   [12261.808471]  __list_del_entry_valid_or_report+0x18/0xe0
> > >>   [12261.809064]  vp_del_vqs+0x12c/0x270
> > >>   [12261.809462]  remove_common+0x80/0x98 [virtio_balloon]
> > >>   [12261.810034]  virtballoon_remove+0xfc/0x158 [virtio_balloon]
> > >>   [12261.810663]  virtio_dev_remove+0x68/0xf8
> > >>   [12261.811108]  device_release_driver_internal+0x17c/0x278
> > >>   [12261.811701]  driver_detach+0xd4/0x138
> > >>   [12261.812117]  bus_remove_driver+0x90/0xd0
> > >>   [12261.812562]  driver_unregister+0x40/0x70
> > >>   [12261.813006]  unregister_virtio_driver+0x20/0x38
> > >>   [12261.813518]  cleanup_module+0x20/0x7a8 [virtio_balloon]
> > >>   [12261.814109]  __arm64_sys_delete_module+0x278/0x3d0
> > >>   [12261.814654]  invoke_syscall+0x5c/0x120
> > >>   [12261.815086]  el0_svc_common+0x90/0xf8
> > >>   [12261.815506]  do_el0_svc+0x2c/0x48
> > >>   [12261.815883]  el0_svc+0x3c/0xa8
> > >>   [12261.816235]  el0t_64_sync_handler+0x8c/0x108
> > >>   [12261.816724]  el0t_64_sync+0x198/0x1a0
> > >>
> > >> The issue originates in vp_find_vqs_intx(). It kzalloc_objs() based
> > >> on the nvqs count provided by the caller, virtio_balloon::init_vqs()=
.
> > >> However, it is not always the case that all nvqs number of
> > >> virtio_pci_vq_info objects will be properly populated.
> > >>
> > >> For example, when VIRTIO_BALLOON_F_FREE_PAGE_HINT is absent, the
> > >> VIRTIO_BALLOON_VQ_FREE_PAGE-th item in the vp_dev->vqs array is
> > >> actually never populated, and is still a zeroe-initialized
> > >> virtio_pci_vq_info object, which is eventually going to trigger
> > >> a __list_del_entry_valid_or_report() crash.
> > >>
> > >> Tested by applying this patch to a guest VM kernel with the
> > >> VIRTIO_BALLOON_F_REPORTING feature enabled and the
> > >> VIRTIO_BALLOON_F_FREE_PAGE_HINT feature disabled.
> > >> Without this patch, unloading the virtio_balloon module triggers a p=
anic.
> > >> With this patch, no panic is observed.
> > >>
> > >> The fix is to use queue_idx to handle the case that vp_find_vqs_intx=
()
> > >> skips vp_setup_vq() when caller provided null vqs_info[i].name, when
> > >> the caller doesn't populate all nvqs number of virtqueue_info object=
s.
> > >> Invariantly queue_idx is the correct index to store a successfully
> > >> created and populated virtio_pci_vq_info object. As a result, now
> > >> a virtio_pci_device object only stores queue_idx number of valid
> > >> virtio_pci_vq_info objects in its vqs array when the for-loop over
> > >> nvqs finishes (of course, without goto out_del_vqs).
> > >>
> > >> vp_find_vqs_msix() has similar issue, so fix it in the same way.
> > >>
> > >> This patch is marked as RFC because we are uncertain if any virtio-p=
ci
> > >> code implicitly requires virtio_pci_device's vqs array to always
> > >> contain nvqs number of virtio_pci_vq_info objects, and to store
> > >> zero-initialized virtio_pci_vq_info objects. We have not observed
> > >> any issues in our testing, but insights or alternatives are welcome!
> > >>
> > >> Signed-off-by: Link Lin <linkl@google.com>
> > >> Co-developed-by: Jiaqi Yan <jiaqiyan@google.com>
> > >> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > >> ---
> > >>  drivers/virtio/virtio_pci_common.c | 10 ++++++----
> > >>  1 file changed, 6 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/vir=
tio_pci_common.c
> > >> index da97b6a988de..9b32301529e5 100644
> > >> --- a/drivers/virtio/virtio_pci_common.c
> > >> +++ b/drivers/virtio/virtio_pci_common.c
> > >> @@ -423,14 +423,15 @@ static int vp_find_vqs_msix(struct virtio_devi=
ce *vdev, unsigned int nvqs,
> > >>                         vqs[i] =3D NULL;
> > >>                         continue;
> > >>                 }
> > >> -               vqs[i] =3D vp_find_one_vq_msix(vdev, queue_idx++, vq=
i->callback,
> > >> +               vqs[i] =3D vp_find_one_vq_msix(vdev, queue_idx, vqi-=
>callback,
> > >>                                              vqi->name, vqi->ctx, fa=
lse,
> > >>                                              &allocated_vectors, vec=
tor_policy,
> > >> -                                            &vp_dev->vqs[i]);
> > >> +                                            &vp_dev->vqs[queue_idx]=
);
> > >>                 if (IS_ERR(vqs[i])) {
> > >>                         err =3D PTR_ERR(vqs[i]);
> > >>                         goto error_find;
> > >>                 }
> > >> +               ++queue_idx;
> > >>         }
> > >>
> > >>         if (!avq_num)
> > >> @@ -485,13 +486,14 @@ static int vp_find_vqs_intx(struct virtio_devi=
ce *vdev, unsigned int nvqs,
> > >>                         vqs[i] =3D NULL;
> > >>                         continue;
> > >>                 }
> > >> -               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, vqi->callb=
ack,
> > >> +               vqs[i] =3D vp_setup_vq(vdev, queue_idx, vqi->callbac=
k,
> > >>                                      vqi->name, vqi->ctx,
> > >> -                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->=
vqs[i]);
> > >> +                                    VIRTIO_MSI_NO_VECTOR, &vp_dev->=
vqs[queue_idx]);
> > >>                 if (IS_ERR(vqs[i])) {
> > >>                         err =3D PTR_ERR(vqs[i]);
> > >>                         goto out_del_vqs;
> > >>                 }
> > >> +               ++queue_idx;
> > >>         }
> > >>
> > >>         if (!avq_num)
> > >> --
> > >> 2.53.0.1213.gd9a14994de-goog
>
>
> I have this in my tree:
>
> https://lore.kernel.org/all/20260315141808.547081-1-ammarfaizi2@openresty=
.com/
>
>
> same?
>
>
