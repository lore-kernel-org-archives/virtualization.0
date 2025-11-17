Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4C38DEC
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381825; cv=none; b=TafOMJc07sfhDuRDsOZ350OSBiCw6zvkEQBslHmNS7zvZv/6S29Q7vZd+PdZsR6BAjU2Oo0efJ1e8jXFu+ODsnmRVBv4GzUNtOsCCVXfy07F6nm7y5O++oCCN74pzZgMZphFGqOuFftQ2l+VhNUry+/OILOmIMbeKlU0lJRK2Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381825; c=relaxed/simple;
	bh=vBAXZUqUfkWXa8H0ePjSA7YabLoBg5g0PTSiLDMR4Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEkttfQH46kmBdTCaatH3ItBcBZ0a+x4Tb+5tTUPeQ4gJwWk2E/CdwHmMzNKOIOErtRRnd9iSYTR1OVbJ7LkoCczZkZLcdVk9CNzHXE35RJOOTr3+EOzEx1ivTXXBP3zRFrFnJukr8uk7MTwyWatkRyHrnlfzwKsG66uM3tBdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvDcDnYq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvDcDnYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763381823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBAXZUqUfkWXa8H0ePjSA7YabLoBg5g0PTSiLDMR4Fo=;
	b=fvDcDnYqG+FyfVAjMsiJPlx7J/w2hOl5nqXl8YNNGrB9i4WYWbB20jDwOMeRvZdTQVXqWk
	lv7raqd50XLagaEqQRHyhdLzAM7yhFySlgCNjFDI61/puAI6erMn54eFGBpP92+ZreVXMe
	R69MK57nIEC/VdiJ/xjqhAmKgc0nhxA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Q5MmQ1TkMIOBmpXr3mZy9A-1; Mon, 17 Nov 2025 07:17:02 -0500
X-MC-Unique: Q5MmQ1TkMIOBmpXr3mZy9A-1
X-Mimecast-MFC-AGG-ID: Q5MmQ1TkMIOBmpXr3mZy9A_1763381821
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6421142edc2so42307d50.0
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 04:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763381821; x=1763986621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBAXZUqUfkWXa8H0ePjSA7YabLoBg5g0PTSiLDMR4Fo=;
        b=ZAFHgfyb9UzJUK50H5kWFPcKZrmUWGTINmC5eS6HyfwEngUmKBrq3ucZxtQb+utmHE
         63kfSUVnLh3RcLPeY/XwQE1v+pgraKHg0vOfjGosyYhpjOCLb/CSYjDQz9Z1GTlELmAn
         r9h5ka8afzCNC8rhXJSvtSGxLc4wk5r9/hdmYLKaaD59yLROI/ghy7CBchkM9aBmPgAJ
         JrRFqqgc7bQo1sT/l8XkfRvtkb5hcEHJyNHZszQs2X4kwTyj8/paSyROYjL1BPxW7xP3
         F2iTf13FCOMSUGR9dwAB32RRyBe8JRqsTTwen46bv+2W7EoorYGmHGGEsyHO/Tn9q4WZ
         dJTg==
X-Forwarded-Encrypted: i=1; AJvYcCXZhYrjgPspKJdO6u6qcZJ24NKq7AKK0itMtIYN0pnYE8iyvMAvjC7tFGPFjpv5MvF0uAg722QRQju48Iyd+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrPwwx4swD9AhE3yRACGHVfKO0iigiloA6Q3DMTUBvDom2BP6b
	/PpkmeoPZvx/CpGi2EIIgtpuhl3PxH5Kpm9C9Z7jcPrjN1ZlO2Evy836YwaPFCrPVztgb1wnJjf
	kVt2qg7QG9XJglncXZbl9CcvY7VFsPPr5hmumz0dt4I/VXgGiKIpNmuoEghmES+jHeoLXvbgffS
	uFpgVZ50NqJNBt9aEiO1cdKAGlQw5j1mttp8qra3geuOU=
X-Gm-Gg: ASbGnctmKFcc0tT4RLWwnY0vpqxSOOAwf+l1+rGN59J+hfqin8DwHqqItRdeHBNuwOM
	skZILSv+21lM6ENz8DD0uUC5u0wSEMyZ7JlHT6YuFX74BhM9kzFeyyG8qrdKIkicR6+Ju5JoV7C
	5opLz5sEJZcdW9XgGPzEqMbDnzOIIaQ9sw9ixE/rAiGPM0/ZBjLIQeJWc6
X-Received: by 2002:a53:d056:0:20b0:63f:2bc7:706f with SMTP id 956f58d0204a3-641e76f3ab5mr8095816d50.57.1763381821573;
        Mon, 17 Nov 2025 04:17:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1hu70X0l/Q0l7chdbsTUOTOmfPP1QeNKG+LQN0+wmKU7q2nccNFj/AiPsJkXMudHiN7/PEQFiD40i5AmLRQs=
X-Received: by 2002:a53:d056:0:20b0:63f:2bc7:706f with SMTP id
 956f58d0204a3-641e76f3ab5mr8095800d50.57.1763381821260; Mon, 17 Nov 2025
 04:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com> <20251117054850-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251117054850-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 17 Nov 2025 13:16:23 +0100
X-Gm-Features: AWmQ_bl83Ay8hcp7Cx-ucluujPuXgWnh1rVqRUNnlyBZbh6nRlSNq_t40iCn-6g
Message-ID: <CAJaqyWcY=yXnh+ZT7qJkXK4GbtUmwmfhWUXhdi=c38ifeaaPbQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Qw5UzYtkIGlSCTWOE9TckuKzre-myxoE92GXVJg4iI_1763381821
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:50=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Nov 14, 2025 at 12:25:03PM +0100, Eugenio Perez Martin wrote:
> > RCU is protecting that the address space pointer of the vq group is
> > not modified concurrently with the access. Ideally, this should be a
> > full lock, but just making sure that all accesses from the reader are
> > coherent is enough. Userspace should expect nothing if it uses the map
> > and modifies the vq group ASID at the same time anyway, but the kernel
> > needs to be sure that it does not see intermediate states. TBH, we
> > could move to a READ_ONCE / WRITE_ONCE, would that be more clear?
>
> generally rcu itself does not need ONCE macros.
> these are for funky lockless things, and rcu can be
> seen as a kind of lock, after all.
>

Right, I meant to replace RCU by READ_ONCE / WRITE ONCE. But I also prefer =
RCU.

