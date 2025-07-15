Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72015624D
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595300; cv=none; b=uUcwQa6TeVfIJn8Ax9cdbnnpqOkVE4nw9neWhdTyvvyqdt6pJN3OV4HnlFBUZTPWEANWZ1tikyulhG7PxNxvurDnn97X/3iGML70FL4oFPFZkmpxOYNcqs60429bgPfNUFBEXNBsrBYh9BhxuRJfM5wQi1q1jpYYUhnoNjc3ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595300; c=relaxed/simple;
	bh=ZQ0j1/DqwHYNjpT8525Bm0Q0Yv2cqtqle57qb7lTBDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7XXW2cAoTC1ygot60rgnBLvgEHOeG1cHemDH3K+mMJZYViuzivczN+7sdmg6f/Ov3Kh7713XYfxKiWP9IgGW7FrGBenbK9mWtMac6wqUZ7rMfi1c/5Flqmao+yWvAhQ2NIKO7mXFYWwU/zgWZg1kW45HW8UCaCnXPrMB4S8nPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PS/aUEdm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PS/aUEdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752595298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQ0j1/DqwHYNjpT8525Bm0Q0Yv2cqtqle57qb7lTBDY=;
	b=PS/aUEdmtbQv9GHcebWWbONkQ18hxrx9uCoApobFg/BzjhMtuxGs9PAdpVbr40TzVUxRsR
	4RVfJ3j5KAqvZMaioKtgRFDheZierI+VhecOZvmBNjEtQlWGtYQP4ONQGHoxKXM1FvZH6O
	G0HvgHfLw5XYKtSADXMMVpddCG7sxTM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-nO_UUTn9OrODob-ngkqn7A-1; Tue, 15 Jul 2025 12:01:34 -0400
X-MC-Unique: nO_UUTn9OrODob-ngkqn7A-1
X-Mimecast-MFC-AGG-ID: nO_UUTn9OrODob-ngkqn7A_1752595294
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae371f9e3f5so1444266b.1
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 09:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595294; x=1753200094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ0j1/DqwHYNjpT8525Bm0Q0Yv2cqtqle57qb7lTBDY=;
        b=gBta9O4nmWYyWkZ6Yzj6JyTFywyjH9iiFZRxCt68p/AJtle5nTQa3nMi5E86jBRKVO
         pJyix2QyG47zGyrUyJP3ObXXEGgWXpe6N3eCMq2I3KfsYA1xMlN/W/heMdqj9vCC3ikY
         aX+2/7NagDG9misueakRHaUi6T12uqmIcLoaABKPAIp1zfmyudoUN/1E9HUG5Tk90Gin
         4RqTQJvGJNtg581sTyXZj3wrx9aCE4+deggQWUpPLQIZwTRx6bMHIBWLVjupEv7Q1jwQ
         fSRDyFfrvkpe9JVC2SlQNiipyJjcA5Wfexpbki2dYhFXTKhMxiTmA7nJmUVV77L0jQgJ
         mRgA==
X-Forwarded-Encrypted: i=1; AJvYcCUnekpiGsoA93/D63kaeQ6L8EaRBT4TjesjCezeNE32313Aqzss1tU9pNA4a5PPojQUBlY/oaCNU1XRwanh4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLPiimPWrPWliHkxdudlbSYmYrjD+61zPoeT36RebbYBYbm0SZ
	zS4vnzxBGj7ke9huIcwiYFsMXUKxpssQkmNyjhVc1feQHtKEWmMZH+Vot74xyp8gmZpbpewjGKQ
	oZjqu2VwKhWKFyYQ+iV302LcRFRrwRJL8hEZ4ZKpA7Vh0f5HwPM/uYR9SZE+uTFE+pt5RoSiioy
	PO4GHbPCEodcizNCeskloU0QEGZFylMwNTz0oItQvgP4E=
X-Gm-Gg: ASbGncvYnySWtQ6s7Vv4Da2J72g4Lmmf1mkniCgM4kzQ4b0Q4pbpU1u2vcdULGSks1Y
	Y3kXIGdFiNcrB6nXqgIr36NJWXr1stiMv6FIdvT6vkee0/ylUaGt/7diZegpKrZM2O7VElDcOUD
	iGme2caY4pVjeQGRi8a9VfVg==
X-Received: by 2002:a17:907:6d10:b0:ae6:f7b5:70b4 with SMTP id a640c23a62f3a-ae9b5d3255cmr491382366b.16.1752595292027;
        Tue, 15 Jul 2025 09:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBNkiu+KQ5oFA0wwnTagSgW/CRAwhWpJ4c1BHoReinXdEEf7eauOJVlEwHLa0R5HQVe1DaLCb/j1PYAiAn6ZY=
X-Received: by 2002:a17:907:6d10:b0:ae6:f7b5:70b4 with SMTP id
 a640c23a62f3a-ae9b5d3255cmr491368266b.16.1752595291206; Tue, 15 Jul 2025
 09:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250714-vlan-v2-1-2d589ba4dcd3@rsg.ci.i.u-tokyo.ac.jp> <e0d7a518-7736-4de1-814c-578f14e591f2@linux.ibm.com>
In-Reply-To: <e0d7a518-7736-4de1-814c-578f14e591f2@linux.ibm.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 16 Jul 2025 00:00:54 +0800
X-Gm-Features: Ac12FXwbzANFFYILs9MpijrHBLLCk_jwZgVFJCwhCCMj8OCKSYeIH2n0WXXELOI
Message-ID: <CAPpAL=wXjo7tBzZAcNV01Lm3nZBx6+O2KqaN4JgGaP6WyPNaXQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2] virtio-net: Fix VLAN filter table reset timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, 
	Konstantin Shkolnyy <kshk@linux.ibm.com>, eperezma@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, virtualization@lists.linux.dev, qemu-stable@nongnu.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UKaQruGHKUJbxSgiCvu7aPOrJH6AyTAMe3RKyhf4JIk_1752595294
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested v2 again with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 10:28=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.ib=
m.com> wrote:
>
> On 14-Jul-25 04:31, Akihiko Odaki wrote:
> > Konstantin, I would also want you to test this new version. Please also
> > give it Tested-by, and, if possible, Reviewed-by.
>
> It works as expected during the boot. All bits in vlans[] remain set
> until virtio_pci_common_write(VIRTIO_PCI_GUEST_FEATURES) comes with
> VIRTIO_NET_F_CTRL_VLAN set, and clears vlans[]. Then I see
> virtio_net_set_status(0xb) and virtio_net_set_status(0xf).
>
> I can't test migration because currently it's not supported on s390 for
> PCI devices.
>
> Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>
>

