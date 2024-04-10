Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CB10A3E
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726963; cv=none; b=FPajqmiol+3QvYmn0LwqBztBah4wH+qNgThJwsM8CZ6DuIf+WHBP5LloWGjMpC0lqqce1/hAOa97zvx1fIBubjFULkkjQY7aOolw9AKnDU03/RS2lAmkhpfUPorqt2JDL0S42aU5uB98ac7hSH+GCFg+bpCppbL7Fjnj+W0rc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726963; c=relaxed/simple;
	bh=Garsb0yrb09cyxnrIqAQEaABu4EXVm1wLQ8zJlWQFy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k4dk8adrY6SrEj2IFnYjEyUBU9y6aRJGm/03dpfWzU0hMHzB6SRKYnY6dNQJ+d9Blb7/57wbik0pMtXjRRFcULr3epwtlmTXj4J3JQGL3PgejhY1TZEirD804jGIuZB2PB8Rxuzvq9fMwWamV7fRGxUKvLRewNQ2/guAUDv8Hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xql4mdAt; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xql4mdAt"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A42F401D8
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 05:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmQIZH4UB5ku for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Apr 2024 05:29:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A477040138
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A477040138
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xql4mdAt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A477040138
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 05:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712726959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALjg/ntug4MBk1XtNMajyyKljj175m906YvGN0uC3zY=;
	b=Xql4mdAtwbksp+5q++cuZUU1PmsezbLmn8xXnX6RiRQlqaSgxWBJbzjlp51dUIROdtOmBv
	rWK2pSacXRkEezcjy9lQEvTDxJrGh3tj8B0yWUOAVD+J/9pqvDQLRUUSbhD9EJTfaoCs4K
	K1fDjPGGN+knMqp27NlVUoHhVFvUD4c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-3ex2y7PcPASpOkDzBtzLbg-1; Wed, 10 Apr 2024 01:29:18 -0400
X-MC-Unique: 3ex2y7PcPASpOkDzBtzLbg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5199cc13b2so432325066b.0
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Apr 2024 22:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712726957; x=1713331757;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALjg/ntug4MBk1XtNMajyyKljj175m906YvGN0uC3zY=;
        b=nqK/YIXsUuAMyQyF2UlBAlStHlPyBQdKZGHbROcJZw9JEVqK4kMdOFfh2dpW3E+Iy9
         4sKeAt8QlLQJG2ruOwOzMI2pqFZglQBU80JsV/OB9w2cCzcT0/QxmRhRJ713ywbuUZpB
         GWoIE+hpVtUKArACfYF1DlLE4vrzcw5S4lgIJIdf+XMyyOGkytJCL2I6+epdCFkSMylA
         1eCQSW6YjKlbkcEztkTJAaeDzdfJEKwe5b+vlgOKsFyxrHPXtdfkjRM1Y2uPiS1Z+ko6
         h1oNV+rwJxw511XEaX7vJa1R9GucZcuC5/76nOicenZf8Cco5sYtmsjKgMYJHa9wpNio
         GHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2bM7oe2ixAoI4ygdWWjKOekxuNRKMATqEWWqHg9TBsc7z9uJu8DpHjFbk/1d6bL/cculLQKIBcpvNzaUFRN9QbJT2vsN47ZcJj5bsRhNDZ+/zoqYzz+OdmQ==
X-Gm-Message-State: AOJu0YyWYJ2zegGyCtqZpbYntzC+TomUsU46JzCLhWfVGpUcbDLx9ylz
	5mbI+EEUCzY+QqaqcYFt/NO1KQb5A5fnxPcAjgWJ9Z2XRsUpJe8d1RyU1pywbSJPK27VEIX9HTE
	zD+7SwKlS2WPNmIyor6CQj80EkDmwXK1QJ+R08zeWozVdGM5QZnwZh1cPHwH2DwXnr/azw1QXbs
	74Oc8KRvCNwy/+JPJaIpBF9qRnNGGKqmJNLggC+UaFgIDkydBAUX4mRg==
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id v25-20020a170906489900b00a51b49e473emr1381819ejq.19.1712726957043;
        Tue, 09 Apr 2024 22:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ro1TSS6P51R8HAGDNJrNtBNNdENLxX7oHAMyEfVHKQkSe40Ls/G0b/qqZdnwgw3ZDazI/7T4ggthUqEqHRk=
X-Received: by 2002:a17:906:4899:b0:a51:b49e:473e with SMTP id
 v25-20020a170906489900b00a51b49e473emr1381809ejq.19.1712726956864; Tue, 09
 Apr 2024 22:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240410043450.416752-1-lulu@redhat.com>
In-Reply-To: <20240410043450.416752-1-lulu@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 10 Apr 2024 13:28:39 +0800
Message-ID: <CACLfguW-o8ox5zmXdmr4Phm-8zSX3sWif8CtNDynW6kRH2fBoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] virtio-pci: Fix the crash that the vector was used
 after released
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, send to the wrong mail list, please ignore it

On Wed, Apr 10, 2024 at 12:35=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> During the booting process of the Vyatta image, the behavior of the
> called function in qemu is as follows:
>
> 1. vhost_net_stop() was triggered by guest image . This will call the fun=
ction
> virtio_pci_set_guest_notifiers() with assgin=3D false, and
> virtio_pci_set_guest_notifiers(=EF=BC=89 will release the irqfd for vecto=
r 0
>
> 2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VECTOR
>
> 3.vhost_net_start() was called (at this time, the configure vector is
> still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() with
> assgin=3D true, so the irqfd for vector 0 is still not "init" during this=
 process
>
> 4. The system continues to boot,set the vector back to 0, and msix_fire_v=
ector_notifier() was triggered
>  unmask the vector 0 and then met the crash
> [msix_fire_vector_notifier] 112 called vector 0 is_masked 1
> [msix_fire_vector_notifier] 112 called vector 0 is_masked 0
>
> To fix this, we need to call the function "kvm_virtio_pci_vector_use_one(=
)"
> when the vector changes back from VIRTIO_NO_VECTOR.
>
> The reason that we don't need to call kvm_virtio_pci_vector_release_one w=
hile the vector changes to
> VIRTIO_NO_VECTOR is this function will called in vhost_net_stop(),
> So this step will not lost during this process.
>
> Change from V1
> 1.add the check for if using irqfd
> 2.remove the check for bool recovery, irqfd's user is enough to check sta=
tus
>
> Cindy Lu (1):
>   virtio-pci: Fix the crash that the vector was used after released.
>
>  hw/virtio/virtio-pci.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> --
> 2.43.0
>

