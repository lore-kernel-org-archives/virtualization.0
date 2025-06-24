Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCCA286433
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760532; cv=none; b=lrDNaC+uwDPJ3Jn36OsVFmSfnr36kQUFseQaFHASkfMPT/L6TcN2hYltcr+btzLZXfEpMKfcHvrz18zT55R6Juz78yLo71QKpjCwkFH3NC7EUWGPcVC0XzOlDR9h/3+qDAWEBAOKbqY0bEtGiJf9n+mNpzNuakTYt/azKtzJQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760532; c=relaxed/simple;
	bh=EAplqW2ugJAkvDa+aOJIODUp0iAnSPiEybzJg50wrII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i17thWzSgxhlLbUHK5SirLXg7y7eVZnJczXqFiV/swsg8FytAt8oMLplazIazuPSA5jeOOC6Mnu/davi2/DPsi+pRYtFCuuooxwmVVeauV9U9HO0fW+uIj6xmuZo2LcfdhhXv5O+WJmUD8fPShACJSFXqegsUGTiEWshBkGWqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ht9+kCU/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ht9+kCU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750760528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBSg8EY7sp1BX+AXcNCVD/E1en0mg8rYiqbGQhd2mHE=;
	b=ht9+kCU/TnJPD5agk2ZyZrHPVFM7ysb93WKE3bVa5uFZmPCMewDQyCnpnaZg9NcoaauYvZ
	9Ttgi5DofF3c7u7gG3RTYCz1NeqSVBkc+aBWg8PgTTatYc9K0mbZn4/1Mt603GE0kb6QgI
	aEIUG9aFSxHPb7v2tGWFgdd6Eduuyro=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-SwwMT-66NjWjeL-vbumrwQ-1; Tue, 24 Jun 2025 06:22:07 -0400
X-MC-Unique: SwwMT-66NjWjeL-vbumrwQ-1
X-Mimecast-MFC-AGG-ID: SwwMT-66NjWjeL-vbumrwQ_1750760526
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad9a8a5ecc6so29420066b.2
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 03:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760526; x=1751365326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBSg8EY7sp1BX+AXcNCVD/E1en0mg8rYiqbGQhd2mHE=;
        b=UT73/b5h66783WOrlC/ib5NPQOutUwg/n9SPcZCKDrptCVXeSqfdUGXHlTX602gwDQ
         ZSEIVtRUgraglr61zIVeo7sUruspvRIcDnm6DKrf5GkTH1NpSIktV/NeIHjOCZaJm5Xb
         OJMVOGks9nWEQYOIoMkL4Ighuhpu4Og9nzLT/vzz03SnY6wBbGZE9qjFjA2/5CM9ayMc
         B5w70IQdSELzoS5Mzy/em4mOhceIZunyY/NenqbR8ko+VdagNijijt56ZD0UVmy9Uwp2
         KrbsWyJDoPMJp0q/gBjPsFKAT4nhbePQejUUJBjb2vJZU9K0j0+i2UENEyX/Xtprop8n
         gwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe35vy9H37pWPnn/DUgkEGnyeC23Rcl4UDPi6eWmun8z4tt20LWxLVO3KYuJI39/ANyVWyNllq4e6R7l/1XQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmDvTZngKLlQ9ayEbolKtORQMHrlSDQEyks1OsbtU2aR4G5TzZ
	tSwlx/WoNbUkdoQUAcCJ4wGxwTwSQoXNA4bmNwCr3ZumFwkqBWDH8JwfLE8xE7mTQgasbGms+Fe
	o363jF9igVcw8ScKcwTM8dkkbyPZWH/aAhZORiIpMQGn19u+YitY1kEOnb4f1i/cUV53qbRhxCp
	NP/gW0zffFpPRDEgiKa6nq2hfwcoOGywhxH9tvqtvwpkw=
X-Gm-Gg: ASbGncvvqe2ROm1cBTYl7jQ1cHvqchkjTpaxIqrwhP3xvUbg0XfcJ+/SOPcas71khKc
	ErQyg9tlE8KeG8exVaBzFExA79mn3zNboeSmuDOV06HVUZa+d1iuPxO+9VYrL/Nxt06G23/jNjk
	JMVA6R
X-Received: by 2002:a17:906:8924:b0:ae0:ad5c:4185 with SMTP id a640c23a62f3a-ae0ad5c4bb6mr127041866b.57.1750760525917;
        Tue, 24 Jun 2025 03:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK7idR9ddwSthjp78IPlVH980PF43V9ofMCipwNRyRw+Vq3cABVYLahb6LovHNST8gpasNwDNrhBfNArPnPZc=
X-Received: by 2002:a17:906:8924:b0:ae0:ad5c:4185 with SMTP id
 a640c23a62f3a-ae0ad5c4bb6mr127039766b.57.1750760525506; Tue, 24 Jun 2025
 03:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617001838.114457-1-linux@treblig.org> <CAJaqyWfD1xy+Y=fn1x8uXTMQuq8ewVV9MsttzCxLACJJZg2A2Q@mail.gmail.com>
In-Reply-To: <CAJaqyWfD1xy+Y=fn1x8uXTMQuq8ewVV9MsttzCxLACJJZg2A2Q@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 24 Jun 2025 18:21:28 +0800
X-Gm-Features: Ac12FXzfQeWK8ouZps9YTtPNR42ROlRbSB3jIfmuYcflJDxiz6fBrlpSiur_mHY
Message-ID: <CAPpAL=xgBK3qqNdaiR=OwbiMaA_5VpouE4YfaEyYghkHxJ0CtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] vringh small unused functions
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux@treblig.org, mst@redhat.com, horms@kernel.org, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tqf_Ej8s_sg3RPRIfVN0W0QfhcVJNVFT44-vOr9Av4M_1750760526
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Jun 17, 2025 at 8:31=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Jun 17, 2025 at 2:18=E2=80=AFAM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > Hi,
> >   The following pair of patches remove a bunch of small functions
> > that have been unused for a long time.
> >
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>
>

