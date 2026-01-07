Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA234B413
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802499; cv=none; b=fkUp0L9eoJBJZGN/3omro/Op7Y7zMxcnF7rFvl5I8Jozqa/ChBpN5Om0O4zqxJ6n2Bt1md23jPcKN/A/jE5U9m4Fu5NFYfP0wZerzQ8aYxjUu+W/ABrwgMyiZVsLHyK7hP7UFsXTOLqwiSL40SLndtGCppYoVTZeX0bkRtP1XRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802499; c=relaxed/simple;
	bh=4Bf2zwdKuMQPmjyomvCRiDRso9p7R/TYGKy2hGAhLa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzKpecxa4S+LWw7vIAH9KSBax5KZeXJAQiEVyyFzeHfm5SoXA9kst114x1yyMpWNPFzyYGLeidMuOHBkFxG0oC+z+oVVJmAYEsSuvJDUpac/5N+o+4I7lV6v/UxY/QadUvuHFbG4qRI4kjPhYKb52lE95ZKIMPrKH/ecidgYWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EE06gifo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EE06gifo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767802481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7TulDsUIoUUXsalob4NbrEsky01/JB7jW1KypFdcu0=;
	b=EE06gifoBYagQkH/s1U4zuqgJ28lUpq8psIL5EaRqyV15y6CS8SZ/2l2y99VAPPtcE65s6
	X/z7hExKzRg8ps7hxp5/Zp7zZF5rYmGOWAiPEJHP0OCmeQRn8jLujKkXlGukro3LKldOCX
	guOUv0Qmghlk0iAQuEv+pso3/fuVSTU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-c_8sUXRXNmmeP_IFEWrYsQ-1; Wed, 07 Jan 2026 11:14:38 -0500
X-MC-Unique: c_8sUXRXNmmeP_IFEWrYsQ-1
X-Mimecast-MFC-AGG-ID: c_8sUXRXNmmeP_IFEWrYsQ_1767802478
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b841fc79f3eso226809666b.2
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 08:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802478; x=1768407278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7TulDsUIoUUXsalob4NbrEsky01/JB7jW1KypFdcu0=;
        b=LfbyxrsL98MvGI65kGzDVSFIi8yzJEVeAOKOIKc0F2aN/YNaycItTIDmwwBaFcGMPA
         mBEfPtINbQchWtXEVm0Txho2n+VMRehZAVB+lr6efD0pOmMKJOdbnDJXgWcCaA2uizK9
         fvQJOghqx+Omrjh/oNKAmYK51PgLvOQcvgFWsOMn8+p/KmT7E3s7fakAoNAUdMVsWJBE
         Ae/AlQMwwFQsz74NREbCRS9of7w2Rqy8uCavAXBrEIWnDIWvQ+mCqCZUFj8SijID88lw
         3Q13N5KzYP8x8eJDKUxbjK20qwIiH3xzjMekuSAGLqiBO0TtvC6x2OzsOk24hJ1z/dvs
         AKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsYRGofzAobPmF0YWvuqKFieyeFU62ZA5fipqeqplFJT0m9W5LDSXfLtmhCuuKKB+2cWRmLAf7Dgql3/fYJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXoRniqHzYCgi0ArlAEX9lVAeIRsc06CORDR51E6EtvsF1tzcO
	QKfNjGYOoXL4XTUeaeuaxBJtPxaxxUnXtZK+GtIp5lyrCEXTKPqh/yCcddC580VWXOQPuc9lUZ7
	W7JQsjHLVP8/vTtc788lbIt5XkHQnb6bTTeK4bw/cuQeaXiTj2G2dRqtMTxvNbKTcHaUebgtQfi
	oRNJeUqCmWcCIDCfrBOr7BngtNtIjnpTBr4bXa2M9DVkk=
X-Gm-Gg: AY/fxX7sHx60bOJhTama9EHHNoF4D1upOI3Yu67Y/HuvqVX9miAloPNywIXtGyoJERM
	6Dd6FvjjbREEWzKtXLHzXbr/l5EYlNI7We4iKjyIUoafM7Ust39ZGLLDHrhVrQRN4BFCPululto
	PYSQbeWh4yb6flQdzn1tbOS0+FkvLWXqPd8W1oYYBkpiQGKAW8LxqpBYEjchakeXPImtSxN9VEr
	Tx4cbKKG0GTBb3VqwaefRP1
X-Received: by 2002:a17:907:d8e:b0:b7d:266a:7728 with SMTP id a640c23a62f3a-b84453695d3mr284847766b.44.1767802477671;
        Wed, 07 Jan 2026 08:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElzm7zkv7ZclGZmqUlhgAe5G5tLnSradBGNYxt46392ibtMetTmULGCAhQlqjI1V8VHmLYzPP/1+tnQ3XTs/k=
X-Received: by 2002:a17:907:d8e:b0:b7d:266a:7728 with SMTP id
 a640c23a62f3a-b84453695d3mr284844566b.44.1767802477239; Wed, 07 Jan 2026
 08:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aU6lCL_vrF93lpYa@bywater>
In-Reply-To: <aU6lCL_vrF93lpYa@bywater>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Wed, 7 Jan 2026 17:14:25 +0100
X-Gm-Features: AQt7F2rxsUoKHks-6LhmwpO5LgspFNWkVaIpGX4dwhn6wdf4jpflCBL5LBTJN7E
Message-ID: <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org, 
	virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ea0PPRrqOcrSno6mnTId11wTwg2_ZpYS9V9C_xIxjqE_1767802478
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 4:09=E2=80=AFPM Francesco Valla <francesco@valla.it=
> wrote:
>
> Hi,
>
> On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> > While stress testing this, I noticed that flooding the virtio-can
> > interface with packets leads to an hang of the interface itself.
> > I am seeing this issuing, at host side:
> >
> >       while true; do cansend can0 123#00; done
> >
> > with:
> >
> >  - QEMU: the tip of the master branch plus [2]
> >  - vhost-device: the tip of the main branch
> >
> > and the following QEMU invocation:
> >
> > qemu-system-x86_64 -serial mon:stdio \
> >     -m 2G -smp 2 \
> >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> >     -append "loglevel=3D7 console=3DttyS0" \
> >     -machine memory-backend=3Dpc.ram \
> >     -object memory-backend-file,id=3Dpc.ram,size=3D2G,mem-path=3D/tmp/p=
c.ram,share=3Don \
> >     -chardev socket,id=3Dcan0,path=3D/tmp/sock-can0 \
> >     -device vhost-user-can-pci,chardev=3Dcan0
> >
> >
> > Restarting the interface (i.e.: ip link set down and the up) does not
> > fix the situation.
> >
> > I'll try to do some more testing during the next days.
>
> After a deep dive, I _think_ the problem actually lies in vhost-device,
> since it is not there (or al least, it seems so) using an alternative
> implementation that uses the qemu socketcan support [0] (implementation
> which builds on top of the work done by Harald and Mikhail):
>
> qemu-system-x86_64 -serial mon:stdio \
>     -m 2G -smp 2 -enable-kvm \
>     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
>     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
>     -append "loglevel=3D7 console=3DttyS0" \
>     -object can-bus,id=3Dcanbus0 -object can-host-socketcan,id=3Dcanhost0=
,if=3Dvcan0,canbus=3Dcanbus0 \
>     -device virtio-can-pci,canbus=3Dcanbus0
>
> Unfortunately, my Rust knoweledge is not sufficient to understand the
> vhost-device implementation [1]; the issue seems to be related to the
> host->guest vring becoming empty and not refilling anymore.
>

Can you try with
https://github.com/MatiasVara/vhost-device/commits/fix-for-923/?

Thanks, Matias

