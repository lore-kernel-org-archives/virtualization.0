Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCCF23394B
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791782261; cv=pass; b=DyluvUMLWIvdk1i87iM/Xm9aECNYjN+UZVTuRelICRgMMuFY1JQLnS2WRW2VKFtWJ0emoe9e21a6Klz2GD+wgFWfWfjrkkSIkDZmOmJIj9rMwLr7E3IHisN9qKXhbclUHh0T+00bwgDLod9cR1Vl4i56OnhBQxVuYytVGlxcIis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791782261; c=relaxed/simple;
	bh=eR+fmL22lupP1pDQ/Am7C6byc7i0RQGsHO+PHaoUMS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dilNCDbuhypn8fa9sLqJcM8STYfF+D7qH7xbTbvSb3ETJN3QYKs+GMX2NLd6qCtppltuO3L0toFmf2/yo3VwIH2u3sGLimWCql39jL2zhGS4D0MAkyOR2lRrtJnHcPBaIdOqhOwImhJDef4r2s77MZrnkyXmVC6Ni4zeAUuZQVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMBCb5YQ; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMBCb5YQ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e4f0d7d77so189966285a.0
        for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 22:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791782258; cv=none;
        d=google.com; s=arc-20260327;
        b=PffRZNEBrpHd4AA8Mw5GNq3sbYYhkpZ/uyVX23GaVkt4C4BF++2kNFRrwgM/Go7BEq
         8L3QC33LvquoYmPOLBHeAMsPwGfibChe1Q7NNyLPS6MroXXkQy7oRnIMvgmTf58G36j2
         YCFEypZu21hOnpTuTtZA+5xZBW3BN91Lkr1CY0Jx0MW0esFQlrT6jz189dZKd2JgC2+l
         lECd21g+g4M9UsfW6srLCnG68+XLsvCOPhpLhnPGIY9xBiJaUVVhF5dSNVw+UlBwsDrC
         JR67U2akKRXKZNMLuk0XBpakGGfQTsuR54KY7kcvJl7dGRL4sQCqKuBAaVibgptmfEUW
         POcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fgfFsidpQQCyeZD6VQBMcPL9jH+HS8umBdgVKZVkXdA=;
        fh=NLxwoBqmTQ5CpQX1b6rnh5Qe3IPJq/R097M078ebORI=;
        b=BApJAQW29QmTKAM9fUehHBp4qoM7j2fDiittxJUmD1HsplKlPFX9JhqzSoMjYr2J34
         EtA9PvgtWeLPyqGgbOkiq+uzp7zstsiSwQeVBLc2k3ixq/GCSM0EokdJuWaRYwOKPURP
         ZOGAer++NmUNQ+Jl5+K+/tdJon0YA4T+EgEueujIE1GqKFvBuKLhojCUfA3Zhkw8/z+k
         8fscbo1yXA4c9CSv+Dgz72BkFFbL/TL4c75dN+O0D7S3i7kFav11ou7iaBp6rr8bgUWt
         NNbE7kuB2/flX2T9770RWUYrQsRxbArETr/1ZjZKsXeZs2CeF8KL0fnHbqcs/wOE7tMZ
         N1TQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791782258; x=1792387058; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgfFsidpQQCyeZD6VQBMcPL9jH+HS8umBdgVKZVkXdA=;
        b=JMBCb5YQ3WBdl/nIM0E8HjsJmhxHtVEzlZwhjiJ/YmrtLII+zX6Wl43B0FNEJhtF9a
         QqUev1HQTdZaa0sFEvcMsqIg8G9Gi1ZHGkoo1kI4OYRjq4ivEO/D/lHRy5RhbhAbxiWp
         mhMUUZeZ7R6cDr2zoQ2XkPJQg+WQ9j3/43FWq2NLUP4r0aOtLrYI5+5yNWAiMGfTVYhe
         YNSgTzVB0tvyjgdcd8/8TnhL2Dz8SSYJ8uvj0rBwQqvCe1DqSTVPTY69/iNV6HXw1M7b
         i1WT1i2VeSpRzIl2Ekm80HunHYAcaxU9HZb3/B5C+asbLVW0jRY9rHczeaoGg+5+y6Vf
         P+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791782258; x=1792387058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgfFsidpQQCyeZD6VQBMcPL9jH+HS8umBdgVKZVkXdA=;
        b=Kb5h2Gjf/WaE2PlUVZuO1EQZ4AIaHDu6zzydLBL3FGECudPxvSbGg/JcpM6wQicf64
         aSMlnSAecaHtT80andaoQwXC6jec6Fql/1XhG5IGs19DYj8MxfN1W+PFVe6uwMcmucF0
         +9GaWSZ1RmuRsurjZaPwvSevX7BOAZ+mQQW3D3PoNaxqWO9F8FBBFlX2+48n0gloAf9Q
         NuEiRgO4fLvTQlW46A02mr7vHcEwqxNym4ZOhSuxsLfZbE/h6bKziqCyBTsxr9aircXb
         6h3N8CMqw6QKrJmCQRwOd2bNhS6a9CfkcXsOL5sZ6W3GPYYLiugShep6Df5k2aKNG7qj
         9zDA==
X-Forwarded-Encrypted: i=1; AKwUvBxV7Hb0a9mYNQ9BTrbrkR4V7RRZOdMvrvMUu53HHHjq6Y9DqoIi9Q7EJ1s9BUL7RDBrdOFglSRFZxstqcImow==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ5pS8MRhdnNF8BpL1dJ4tJju5rfHymigEtjlROqZSWO9G8d02U
	J1f+xIvtkHVRUGGr/evANFqILlofKpd+KWftWlTWtcoBSdDOQyzmq4x9jEggRFdWpcqL6XqXsjk
	BQ4bPt2FgW790UVaQsIndNWKhUs30PHs=
X-Gm-Gg: AYBFou1mYcq1GG1TaTCAeI3gdKPNR0sVS0oormTMYf+DzHXsiCeOeHsece00t5/1fmd
	EYfZAuNMwh/H7kMKRAXaj8h1dt0bNbzZ9MNe6v0ISR5e5VcNG9rrwuH7ubXrve1NRk4ovTl8ex+
	WynB4Zxi2CFgbogU2QhV/5chU7LpCwO+6lusMKS8KuJ2lvUriDsBKOdG8hFJYovsvOmfZAf1UKW
	lHr7TvkcrYfphBeIZBY0IRpB8kwuXXEiKVXbnSfv9GHzi4GWgrICe3OGlnil5BlxyNqqbvkRYxB
	xXtDvTKHTougRlWQVVA4h/cWLvZBdxkclvfJRvnFJyEk+oUPLTSydnJoSEVFWyOudRY=
X-Received: by 2002:a05:620a:468d:b0:93e:c173:f694 with SMTP id
 af79cd13be357-93ec173f895mr1213489685a.40.1791782257577; Sun, 11 Oct 2026
 22:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261011014803.100454-1-physicalmtea@gmail.com> <sashiko-outbox-167544@kernel.org>
In-Reply-To: <sashiko-outbox-167544@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Mon, 12 Oct 2026 13:17:00 +0800
X-Gm-Features: AclHuK-lnMJpW1Hk4QztCSGXZUH1H-mtHMg6D6LOi_sK5vUMHTywqi2KmYQFORE
Message-ID: <CAJwVaMK8MOfKjhWHH_MA3WqxxraQkQyeeN1RqUoANxZSnDJ2Dg@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-scsi: do not count PI bytes in the data length
To: sashiko-reviews@lists.linux.dev
Cc: Eugenio Perez <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] vhost-scsi: missing validation of prot_bytes alignment allow=
s OOB access
> --
>
> commit a2683cd412935b122ac2e93ce16af9655a892639
> Author: Jia Jia <physicalmtea@gmail.com>
>
> vhost-scsi: do not count PI bytes in the data length
>
> This commit updates the expected data length passed to the target core
> by omitting the protection information (PI) bytes. It adjusts the length
> so that protected read and write operations take their length directly
> from the CDB, preventing issues when the data scatterlist is smaller
> than the total length.
>
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 885fac5ed042e..8b32caa7ec294 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, stru=
ct vhost_virtqueue *vq)
> >                * vhost_scsi_queue_data_in() and vhost_scsi_queue_status=
()
> >                */
> >               cmd->tvc_vq_desc =3D vc.head;
> > +             /*
> > +              * exp_data_len is the data sgl. prot_bytes already sit i=
n
> > +              * the protection sgl. Protected READ and WRITE replace
> > +              * data_length from the CDB in sbc_check_prot().
> > +              */
> >               vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_at=
tr,
> > -                                         data_direction,
> > -                                         exp_data_len + prot_bytes);
> > +                                         data_direction, exp_data_len)=
;
>
> [Severity: Critical]
> Does this code allow an out-of-bounds access when prot_bytes is not align=
ed?
>
> In vhost_scsi_handle_vq(), prot_bytes is extracted from the virtqueue ele=
ment:
>
>     prot_bytes =3D vhost32_to_cpu(vq, v_req_pi.pi_bytesin);
>
> There doesn't appear to be validation ensuring it is a multiple of the 8-=
byte
> T10 PI tuple size before it dictates the length of the protection scatter=
list.
>
> When the target core later processes this command, functions like
> sbc_dif_generate() in drivers/target/target_core_sbc.c loop over the
> scatterlist length using 8-byte increments:
>
>     for (j =3D 0; j < psg->length; j +=3D sizeof(*sdt)) {
>
> If psg->length is not a multiple of 8, does the last iteration read or wr=
ite
> past the end of the mapped scatterlist element? A malicious guest could p=
rovide
> an unaligned pi_bytesin or pi_bytesout length, potentially causing an
> out-of-bounds access into an adjacent physical page on the host.
>

This issue is not introduced by the current patch. I have previously
sent related patches to fix similar issues. I personally believe that
this kind of issue should not be fixed in the transport layer.

https://lore.kernel.org/all/20261006093338.27342-5-physicalmtea@gmail.com/
https://lore.kernel.org/all/20261006093338.27342-6-physicalmtea@gmail.com/
https://lore.kernel.org/all/20261006093338.27342-7-physicalmtea@gmail.com/

> >               ret =3D 0;
> >  err:
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011014803.10=
0454-1-physicalmtea@gmail.com?part=3D1
