Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEA1DF99C
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594383; cv=none; b=Hu3rvSr9LllNzK/Ck7iPNVtI2GgBmnU4clnsv4spv4GD2BtspCSFg/J06v1CuZUGH5ziv2phmRM9mq6Kr0KIQXGS3MxpYY3r7NPKqod7rhE8b2fpb/lD06/Jbx4D+71fh1QlGrMmR64WFBk7+pU3sV4WQwsj9LjViQ/1sEHrTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594383; c=relaxed/simple;
	bh=YeKZ0KmVhAbqsdVN0qJho6dSv0EDr6zEMDxOmyQv/m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1Zk7coeIbFbOu8zfz0Sl6qbl1WYKfX7nxlrFTh2hZP5WbGTNu9tsAMnvESF0qw0PKZPRvrTG5CV+jSnTtxaK+REk7LY3kfB33FT4nt3hrXjODdmzar2LzF/xuN84hGuECkQV9f+B4PH/D6wW7QgK4Eur80IhUgXOu/wtxg4pMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hy+LaJ24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hy+LaJ24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeKZ0KmVhAbqsdVN0qJho6dSv0EDr6zEMDxOmyQv/m4=;
	b=hy+LaJ24EHpp/397fZwYDdUDXM/BhQvgEevqyGq9lUx2rNdhIv/HUmoR8AKPDSNHeRkHIh
	N5oKCycO43Qkmo0la88sDdpSOfU50fFGtX6Gz52LbbnGIwUTpHZ68I5H4tu0k8LDXFN726
	QJmXOyypkx1Lf5qBT7TL0NiD68BKIYE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-ij3QKvlMOguJc7i96oWuZQ-1; Tue, 15 Jul 2025 11:46:19 -0400
X-MC-Unique: ij3QKvlMOguJc7i96oWuZQ-1
X-Mimecast-MFC-AGG-ID: ij3QKvlMOguJc7i96oWuZQ_1752594378
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae3b2630529so473660466b.1
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 08:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594378; x=1753199178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeKZ0KmVhAbqsdVN0qJho6dSv0EDr6zEMDxOmyQv/m4=;
        b=t6e2ZemFH7Xx1xR56b19ek3RULvzhMqyZiLdonfssl/V0fzw2wPVvSadjCHpJesZSc
         2XKtDJk7WsvTvTgEgbbSMWtafJrv4xM6e25xzP+dI3iGCq+gHEVSQnkc7G0DXEfUOs0w
         zHnwJbWZJOMczV6LzFB7pmHL8h1QsIr35FQHiTXN7jOCGPK6XSunabDc26rsQGMWhpsh
         PcH8kVUyn0oh+HgrSpurhxhU0rlZx/sLFm9xCB6WR9JK40UEZnwi9070GRl49PzwXFf3
         7/FMo1WtIJzBgYoi8q9msP+s7bOZNhb3l75hIBkxUAbWTL5ixkZPsuJC1y76nN9qIqnv
         QpIg==
X-Forwarded-Encrypted: i=1; AJvYcCUNTl6vyY9KyPeML9Am7ice//LVY3SBF+cGWyGvH1brFWrw+GJOx+RGttDZCll5aPha2Q0efQg0bI2J+wUdvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yymc50EXGM1iADM8fS4lnXxbBQIqvNPBxiVUmqSxS7Dsyzw/v4C
	K8wloXHYuHHCKd7HA4dHE//u4q0sGvtVLoO0VX6wU0rtQ/fKI7OqjKg/rHWEJ9+XktZGNKRcuj2
	YZpZNcyo/SHWI9cfHIMbfaOfzY7gUXHm4rd1BKx+yaCDJTIe2qYnhrwsNaJ75qOfKqdgpvhCpEk
	vrmHsm934S9HvrFmpES7ezi4/4OhLgYV7y6eS1OMfG48Q=
X-Gm-Gg: ASbGncsQ6jBXqa8JM6AOZLAKRF+uLfFifPLTP1+37NB/fUju9KHdCONGyYUWvGWehrR
	ea+Zw8dPC0keXTocvJm8wxZFSPlDnWTS0xPUmGMy0vf7hikHNrOccB3WYMEfur3dUaDSFEzflA2
	zz6MLhBtsjpBqkMVLfO2ZluA==
X-Received: by 2002:a17:907:962a:b0:ae0:3f20:68f8 with SMTP id a640c23a62f3a-ae6fcbc2c32mr1887245166b.39.1752594378044;
        Tue, 15 Jul 2025 08:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlCyXikNssAjjTBsAdIH0MIVmRcQfeT4dCIv8bEKRZETD1LqB+ZQ3r062eu/OZ/7fnE746+1I/QZe0sQ3hiM4=
X-Received: by 2002:a17:907:962a:b0:ae0:3f20:68f8 with SMTP id
 a640c23a62f3a-ae6fcbc2c32mr1887243166b.39.1752594377707; Tue, 15 Jul 2025
 08:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp> <ae225e65-0a13-47a8-9bfc-0f8497af2e58@linux.ibm.com>
In-Reply-To: <ae225e65-0a13-47a8-9bfc-0f8497af2e58@linux.ibm.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:45:41 +0800
X-Gm-Features: Ac12FXxAVi3H2kkwLzNgapGt3HL99l3IuWXYcy9Tgg-NKyIA1vi-6LvLTL1aVjA
Message-ID: <CAPpAL=wxV0RmFq+nwSjsYbmYpBkaXE3TPLrxNfrjYrr0hCjkjQ@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio-net: Fix VLAN filter table initialization timing
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, yin31149@gmail.com, 
	eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GQvc8DmH1w8PCUKaU-JKYUb9CTAcUTOJtOxinSnZS0Q_1752594378
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 5:34=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> On 13-Jul-25 06:52, Akihiko Odaki wrote:
> > Konstantin, please see if this patch fixes your workload.
> Yes, it does. It delays vlans[] initialization until
> virtio_net_set_status(0xf) which later also calls vhost_net_start()
> which is where the NIC is actually programmed.
>
>

