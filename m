Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954A22A4DB
	for <virtualization@lists.linux.dev>; Tue,  8 Apr 2025 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093685; cv=none; b=HrjIv/aN8BZcKu5KZY4HNcsZQBZGfWwxxmC7nwoOuUk/Gs3P8x9RZ+rjnK9dxQQa6rX/CnNdHU+iy2iBwFjulScHHcG2Q7YQPlIODymwT3TY69hB1jVS6KDDEM86cS6HsJJkkkUoUKL9Q5/HeOZ/GCaxkzvucj5yh6/8APMS53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093685; c=relaxed/simple;
	bh=y8O4HBajyfWwVy+Bq+XgIOZedoREl2poIYNvV6UwCcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCl5dYqNwvFAvv+l2QXTEYRnuxqSROL5AGHfFKth1slvRxhIZ76UbcI6HWTz8TWxDzD3fKidSPNv1tbDTqS16Q3o6YQ3LS1DOFNF1foqdYFP4jZRwlSnql+sA8OYjXtzrp2XvEteru4lXSBYN3wE/p9i06t2Ce2d2BfXvXXRkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxfGi3XB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxfGi3XB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744093682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFEAHfNF2upt4iBW1CVn1hW5AhNTxhgDogV7FrnTJvk=;
	b=CxfGi3XB9dDQ/CEXQCxl+uQzkckQSzi4ipVcEbqAotuIP7C/y275IiNp+wxP/eS/MDux2U
	yTzy6gx4tagpj9fGQt4EeAcMv/NATOKQk4kS99fahdwiL2MCbpNZW4jWvZoCJoUSNZvCY0
	S1pLJHzL53l9ZIeS+3oYSBoGVtwRREA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-rBXGlYaCMH6-_lvvIB489Q-1; Tue, 08 Apr 2025 02:28:01 -0400
X-MC-Unique: rBXGlYaCMH6-_lvvIB489Q-1
X-Mimecast-MFC-AGG-ID: rBXGlYaCMH6-_lvvIB489Q_1744093680
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-523f916da3fso830895e0c.3
        for <virtualization@lists.linux.dev>; Mon, 07 Apr 2025 23:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744093680; x=1744698480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFEAHfNF2upt4iBW1CVn1hW5AhNTxhgDogV7FrnTJvk=;
        b=wUAy41qj6oLJhblqSfEOgOJXzLe6bTvEaTXvkq8PzYFdr+rJiUDP55/r/V9KoRgkOM
         hvqYmHlPo2ocNkfEN9LZMaCzlozyRaQVDGctPQS+Vnu82DMsJW+XOZgER30djNNT7inl
         CUnlDyCNg27F3fhKQG+Zv1li2oq1EcEYjwRCQVGbz3yCkdnvVHdwAeamcUxgeTpYqUDQ
         rFxGbJXq7eOkzFVsDY0BNZPqcw0p1AmfgcRnJ5SU7DyTfYFxbMgXNp4NTldNlRZFhzka
         ooVDedXlqpl8O/IpJCjmRkHmtPIqUsgOL+8LqccxLjIAnK/X0hpoBeM4hp7VsbKrXI8H
         9xeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXXjzpl9ZM6edeY/Yt+RifOPPVwh0DOs1lupqaHo3U0KuO4Lgubhk4KafMLw75lqHqHfhfWqfcKmJuWSnMlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxovalAyz0Zf6Kx5pPC+OV0V9gX1MnUgFNn6Gyih1H+vJ4aIwv1
	LWFGICexmPmS94ApYNCNMhlOOGphTH+8Mf95CABC6x8oXgQfhtkNVO1lhoRWV9wEkIagLIcRd8a
	3zqBhSVW0+iAzdTh24SgdOyL7OhpC1fuz1eF0i08fjh8pyvHMwkwG6JnLyG1tON4iECT6MAE4ER
	ZnosB3MEZl5+b7K1p+YzMlUWthKG1pc6SKwXC28GU=
X-Gm-Gg: ASbGncuofIaZWvCi0Y4nMMzEyDv7xI30L574ec2CHsvqXj43MBc6oxhs7gvhVWd1ftl
	5tADT8RMnShsnNpRxvF4y07fwEHUzuYgYpnRV0Rixw4O2dejg9VPLhHyF4tHxsob/Twt2HnUU
X-Received: by 2002:a05:6102:2b8d:b0:4c4:e414:b4eb with SMTP id ada2fe7eead31-4c8553ddbd7mr13452804137.12.1744093680461;
        Mon, 07 Apr 2025 23:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeRUBOqMK5hyNx0Viqtj2BdChVeCwFqQAKfIszSRcQ8GXs6TF7Lz3t65QjInAuYEEWZxiV0+j7wcTUD0tEPS8=
X-Received: by 2002:a05:6102:2b8d:b0:4c4:e414:b4eb with SMTP id
 ada2fe7eead31-4c8553ddbd7mr13452795137.12.1744093680116; Mon, 07 Apr 2025
 23:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250404145241.1125078-1-jon@nutanix.com> <CACGkMEsFc-URhXBCGZ1=CTMZKcWPf57pYy1TcyKLL=N65u+F0Q@mail.gmail.com>
 <B32E2C5D-25FB-427F-8567-701C152DFDE6@nutanix.com>
In-Reply-To: <B32E2C5D-25FB-427F-8567-701C152DFDE6@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 14:27:48 +0800
X-Gm-Features: ATxdqUHPgD0AF9QYRz_3XemrYCxKbVxtWo52WcdpgKy0DwPXI7mtOhUMNAmsIo0
Message-ID: <CACGkMEucg5mduA-xoyrTRK5nOkdHvUAkG9fH6KpO=HxMVPYONA@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: remove zerocopy support
To: Jon Kohler <jon@nutanix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dD2yFV4-wLtwdBmEugtjkDHOZvpqjFvTG2HVdYBON2w_1744093680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 9:18=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Apr 6, 2025, at 7:14=E2=80=AFPM, Jason Wang <jasowang@redhat.com> wr=
ote:
> >
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > On Fri, Apr 4, 2025 at 10:24=E2=80=AFPM Jon Kohler <jon@nutanix.com> wr=
ote:
> >>
> >> Commit 098eadce3c62 ("vhost_net: disable zerocopy by default") disable=
d
> >> the module parameter for the handle_tx_zerocopy path back in 2019,
> >> nothing that many downstream distributions (e.g., RHEL7 and later) had
> >> already done the same.
> >>
> >> Both upstream and downstream disablement suggest this path is rarely
> >> used.
> >>
> >> Testing the module parameter shows that while the path allows packet
> >> forwarding, the zerocopy functionality itself is broken. On outbound
> >> traffic (guest TX -> external), zerocopy SKBs are orphaned by either
> >> skb_orphan_frags_rx() (used with the tun driver via tun_net_xmit())
> >
> > This is by design to avoid DOS.
>
> I understand that, but it makes ZC non-functional in general, as ZC fails
> and immediately increments the error counters.

The main issue is HOL, but zerocopy may still work in some setups that
don't need to care about HOL. One example the macvtap passthrough
mode.

>
> >
> >> or
> >> skb_orphan_frags() elsewhere in the stack,
> >
> > Basically zerocopy is expected to work for guest -> remote case, so
> > could we still hit skb_orphan_frags() in this case?
>
> Yes, you=E2=80=99d hit that in tun_net_xmit().

Only for local VM to local VM communication.

> If you punch a hole in that *and* in the
> zc error counter (such that failed ZC doesn=E2=80=99t disable ZC in vhost=
), you get ZC
> from vhost; however, the network interrupt handler under net_tx_action an=
d
> eventually incurs the memcpy under dev_queue_xmit_nit().

Well, yes, we need a copy if there's a packet socket. But if there's
no network interface taps, we don't need to do the copy here.

>
> This is no more performant, and in fact is actually worse since the time =
spent
> waiting on that memcpy to resolve is longer.
>
> >
> >> as vhost_net does not set
> >> SKBFL_DONT_ORPHAN.

Maybe we can try to set this as vhost-net can hornor ulimit now.

> >>
> >> Orphaning enforces a memcpy and triggers the completion callback, whic=
h
> >> increments the failed TX counter, effectively disabling zerocopy again=
.
> >>
> >> Even after addressing these issues to prevent SKB orphaning and error
> >> counter increments, performance remains poor. By default, only 64
> >> messages can be zerocopied, which is immediately exhausted by workload=
s
> >> like iperf, resulting in most messages being memcpy'd anyhow.
> >>
> >> Additionally, memcpy'd messages do not benefit from the XDP batching
> >> optimizations present in the handle_tx_copy path.
> >>
> >> Given these limitations and the lack of any tangible benefits, remove
> >> zerocopy entirely to simplify the code base.
> >>
> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >
> > Any chance we can fix those issues? Actually, we had a plan to make
> > use of vhost-net and its tx zerocopy (or even implement the rx
> > zerocopy) in pasta.
>
> Happy to take direction and ideas here, but I don=E2=80=99t see a clear w=
ay to fix these
> issues, without dealing with the assertions that skb_orphan_frags_rx call=
s out.
>
> Said another way, I=E2=80=99d be interested in hearing if there is a conf=
ig where ZC in
> current host-net implementation works, as I was driving myself crazy tryi=
ng to
> reverse engineer.

See above.

>
> Happy to collaborate if there is something we could do here.

Great, we can start here by seeking a way to fix the known issues of
the vhost-net zerocopy code.

Thanks

>
> >
> > Eugenio may explain more here.
> >
> > Thanks
> >
>

