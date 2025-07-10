Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5D2AEF1
	for <virtualization@lists.linux.dev>; Thu, 10 Jul 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142737; cv=none; b=vGYnPAmzY5IqLXcunUhk5KIHWUPgwsXVtl8xKOXyNQL/vmtlMErwDdcq4CEFDEA2cJ6hDkeI/srVl3LTaN4YJiTyZkKp3NF8gV25MDagt2nknAZkmOdQ9HB/8hn1jOFZWgmeRVrJLNpXiJaOqUA3Tui9D5cii7iXO9znrziGWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142737; c=relaxed/simple;
	bh=d9WqkjzWFXGo0+Zam2d4Rcbwx9CE+ZmBSaMqy+wYQHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrtpFzFQlErefir+WjFoXpdE8WoQrGiqDxYHqXLaABEYcsNmD4cdcFPDJvBoWc+ds64hrh0clsQ14kDR3zjxtj0Le6jzHCgL/ySIxo34Z8FYncpNl1HD+QY8Cbq68cBFK/LxNwG+84Rg1k0zddNNlHG9CuqwEXD7gk/kL0JC+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHfYCat+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHfYCat+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752142733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XGrExRtD0wHnwLmIoNNRTlxChH0WdSJdSSnw3pnVID0=;
	b=CHfYCat+37+l7K91cCWla31wWWPOpaqeUjPMTTWk/b/3aPZvliZNEnej9WVE/TsXemovbl
	bJwD478AuSLqYZfCkhBcTX1RFUEoDQ61AI/KCiN591fuIjYPujriIGxRCyJYhk7gatFw4e
	3cG6Kt3dKTWZ4BH+cszYFdrBGkS8pIM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-5WBzpxRHPamReurb1Tb8Rw-1; Thu, 10 Jul 2025 06:18:52 -0400
X-MC-Unique: 5WBzpxRHPamReurb1Tb8Rw-1
X-Mimecast-MFC-AGG-ID: 5WBzpxRHPamReurb1Tb8Rw_1752142731
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5315999c994so274200e0c.2
        for <virtualization@lists.linux.dev>; Thu, 10 Jul 2025 03:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752142731; x=1752747531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGrExRtD0wHnwLmIoNNRTlxChH0WdSJdSSnw3pnVID0=;
        b=BW/Q+LM6wYcU106IinzjF0ObaRSrfXq3NxJ2zvSVsLdCaj7SbdqEGb4rKlKCJLcx/g
         7tmcZ6+sh1VeC0caGYJr46UEXhFz0t64oWzdYLUaP1m/oc2d5WgSNjkeqqWJZP8fjW+o
         FLZEnCUQ7DAuyUA5N2pRso26pSfyXeXCqoh4xkgOhjRYKfnNvth7QSS3zy2lJ9Sdjnkh
         nvj2N2QS62HU8om64scTRpMjM52jaJuIqbtLYIeAuw9Z8V6E0/VSSom7mxDWBTmk780B
         IcmcgxsAaomdE1hc889BlMT/DerfkdTKZwKiVBdulQViutRqk0v1Gmw5XdDIVAZoVr6e
         wavA==
X-Forwarded-Encrypted: i=1; AJvYcCUAfQAqeaUVjmHfMmHH4Ilw8rC5T2RqTRNed4hFOYDNisS4gZp5VHVvT3iChHSTrAI/63S0AZEnUvnLblAfkw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXvG3exb10CwOVDAYzMa8YhxRb8+75AV4ElnCptyBbd5xM9atc
	HldAm7afL/BjgL9AYtccsx9VGgZwnMef413fNTJd35RnkbH3AkTr8CU3Kk/hoesltobUDTgXKSo
	qZMQi+WNiIKPvvo/OJMoyC+Cd6JjkTnf5MOjzDJ/6rtXpi7m9mp7wTf2D8k+n50mgvOM+bjwhMT
	7+3AzOGiV1f5h6dG9spsC1FanKyF+c85tdHyJ3CIHBMyY=
X-Gm-Gg: ASbGncsUS2+x+C1W/MaPLxUOcnObIsA0UaDhIhNzN2ftr8TvIKsUEHJErtHm9mOc6Ng
	xrxYDx0MZScwllDb0yBIW5YdZf6rCR8NmuRVA6OTkExnu0P9Yo6WtccLZtjeBAHnsVUIZkPYnkW
	numw==
X-Received: by 2002:a05:6102:688a:b0:4e5:a6ad:8fee with SMTP id ada2fe7eead31-4f629819e22mr2236345137.19.1752142731561;
        Thu, 10 Jul 2025 03:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1si9u2HqZPDMoVj4UwvUmvaBMS+8dRnoff24ukunRs3GkVyOQwWq8rfsrm1m+/OZ1aMB4vr87zGtlilEf50k=
X-Received: by 2002:a05:6102:688a:b0:4e5:a6ad:8fee with SMTP id
 ada2fe7eead31-4f629819e22mr2236336137.19.1752142731168; Thu, 10 Jul 2025
 03:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADZSLS0zp9rqP2=vCh8eHVH_U+g+k_8pitV939u9Ls8ZPEMfJQ@mail.gmail.com>
 <zfddiyxykxaoev4wbaxh6ml6czew44k5mt4jsxylpbybnqbs6y@rcfi5dpy5qv4>
 <CADZSLS1KPX6rgCkdDPqqyYC-R3oBWDGb8o26QQXaG5U4R=8zzA@mail.gmail.com> <w5oshdtp3wdhydjmh6htwtgb6keyml2teft7ihu277tbktzbp6@mweh7pyfwlrl>
In-Reply-To: <w5oshdtp3wdhydjmh6htwtgb6keyml2teft7ihu277tbktzbp6@mweh7pyfwlrl>
From: Wenli Quan <wquan@redhat.com>
Date: Thu, 10 Jul 2025 18:18:39 +0800
X-Gm-Features: Ac12FXx3G1j8fQnFlnswaF5T1xofdsFi0PRayiJtK5R6lclhme7jJZjkDw3ERwg
Message-ID: <CADZSLS0A_EEi46U_zF+ssfgXWqg_YwekwOsCiNTbbKg3ueNhRQ@mail.gmail.com>
Subject: Re: Host Crash when re-running vDPA device creation script after interruption
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bfrXhMGfQ7aZA1haxzL4FVDrpIyLeyZ0rBIY53KHO4A_1752142731
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="00000000000016bc870639908546"

--00000000000016bc870639908546
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Wed, Jul 09, 2025 at 08:59:13PM +0800, Wenli Quan wrote:
> > On Wed, Jul 9, 2025 at 6:38=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> > >
> > > On Wed, Jul 09, 2025 at 05:36:04PM +0800, Wenli Quan wrote:
> > > > I am reporting an issue where the host system crashes when re-runni=
ng
> > > > a script that creates a vDPA device after interrupting its previous
> > > > execution. I am attaching the script for your analysis, as I am uns=
ure
> > > > of the exact step causing the crash.
> > > >
> > > Thanks for catching this Wenli. We'll look into it.
> > >
> > > > # uname -r
> > > > 6.16.0-rc2
> > > > # sh vdpa-setup.sh  0000:b5:00.1 1
> > > > interrupted by pressing Ctrl+C
> > > Could you specify during which stage of the script do you interrupt i=
t?
> >
> > Interrupted after running for a few seconds.
> >
> I was not yet able to reproduce the issue.
>
> Could you print out the commands of the debug script so that we can see
> where it was interrupted? set -x should be enough.

I tried again many times, just to reproduce once. the following script
for your inference. but it doesn=E2=80=99t cause a crash every time.

sh test-vdpa-crash.sh
=3D=3D=3D=3D [TEST] Kill after 0.1s =3D=3D=3D=3D
[INFO] Running vdpa-setup.sh in background...
[INFO] Script PID: 2646
[INFO] Re-running script after termination
Then the host crashes.

Best Regards,
wenli
>
> > I encountered the same crash on both the 6.16.0-rc2 kernel and the one
> > with the "[PATCH vhost] vdpa/mlx5: Fix release of uninitialized
> > resources on error path" applied.
> >
> Right. This is another issue that is coming from mlx5_core.
>
> Thanks,
> Dragos
>
>

--00000000000016bc870639908546
Content-Type: text/x-sh; charset="US-ASCII"; name="test-vdpa-crash.sh"
Content-Disposition: attachment; filename="test-vdpa-crash.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mcx8hdvu0>
X-Attachment-Id: f_mcx8hdvu0

IyEvYmluL2Jhc2gKCkRFVklDRT0iMDAwMDpiNTowMC4xIgpBUkcyPTEKU0NSSVBUPSIuL3ZkcGEt
c2V0dXAuc2giCgpLSUxMX1RJTUVTPSgkKHNlcSAwLjEgMC4xIDEzLjApKQoKbWtkaXIgLXAgb3V0
cHV0Cgpmb3IgVElNRSBpbiAiJHtLSUxMX1RJTUVTW0BdfSI7IGRvCiAgICBlY2hvICI9PT09IFtU
RVNUXSBLaWxsIGFmdGVyICR7VElNRX1zID09PT0iCiAgICBMT0dGSUxFPSJvdXRwdXQvdGVzdF9r
aWxsXyR7VElNRX0ubG9nIgoKICAgIGVjaG8gIltJTkZPXSBSdW5uaW5nIHZkcGEtc2V0dXAuc2gg
aW4gYmFja2dyb3VuZC4uLiIgfCB0ZWUgIiRMT0dGSUxFIgogICAgc2ggLXggIiRTQ1JJUFQiICIk
REVWSUNFIiAiJEFSRzIiID4+IiRMT0dGSUxFIiAyPiYxICYKICAgIFNDUklQVF9QSUQ9JCEKCiAg
ICBlY2hvICJbSU5GT10gU2NyaXB0IFBJRDogJFNDUklQVF9QSUQiIHwgdGVlIC1hICIkTE9HRklM
RSIKICAgIAogICAgKHNsZWVwICIkVElNRSIgJiYgZWNobyAiW0lORk9dIEtpbGxpbmcgJFNDUklQ
VF9QSUQgYWZ0ZXIgJFRJTUUgcyIgPj4iJExPR0ZJTEUiICYmIGtpbGwgLVRFUk0gIiRTQ1JJUFRf
UElEIikgJgoKICAgIHdhaXQgJFNDUklQVF9QSUQKCiAgICBlY2hvICJbSU5GT10gUmUtcnVubmlu
ZyBzY3JpcHQgYWZ0ZXIgdGVybWluYXRpb24iIHwgdGVlIC1hICIkTE9HRklMRSIKICAgIHNoICIk
U0NSSVBUIiAiJERFVklDRSIgIiRBUkcyIiA+PiIkTE9HRklMRSIgMj4mMQoKICAgIGVjaG8gIltE
T05FXSBLaWxsIGFmdGVyICR7VElNRX1zIiB8IHRlZSAtYSAiJExPR0ZJTEUiCiAgICBlY2hvCmRv
bmUKCmVjaG8gIj09PT09IEFsbCB0ZXN0cyBmaW5pc2hlZC4gTG9ncyBzYXZlZCBpbiAuL291dHB1
dCA9PT09PSIKCg==
--00000000000016bc870639908546--

