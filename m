Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DB145348
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888513; cv=none; b=YnrH+ZR+6rougcGu2bbjgPnmWaxo6PUxdP9+iFnFgaj5Vl6gIV4IqH4u/nFa3BTQ8u9ZBOPHoc0yG2DYKnHX8uTMOR0E3BWqWr8eTzBpY+kTsO9rvPkqV99TMlpNUkeynpRvKmkxoZ+jRt/fTaiuRm4gU9GNsBgiJKTDBVr5G7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888513; c=relaxed/simple;
	bh=TWLY8gFXi6zZrdCtsmsuGezKS4Vv9L373qHibuel/Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chF8tvsLwZRQ1cYuTamh44hqkrBXAibf4YrqFsf8d7Bzh7yFzy7O+JU0n2IoKKDm6oMKHMxOyIouB7nWr5Md9i0qaf1jjIIkUoWoW1O5InOHbQrTiKPu2D8IJnmiOnquer7YPK/FP2jpGIllw/2L++PdvWOEha+gddWloIKgOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZzqDYQh; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZzqDYQh"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3C2480ECA
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 06:48:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-SHFLO1I7Lg for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Oct 2024 06:48:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DE79780EBC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE79780EBC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hZzqDYQh
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DE79780EBC
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 06:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728888509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWLY8gFXi6zZrdCtsmsuGezKS4Vv9L373qHibuel/Dg=;
	b=hZzqDYQhTH6a4AlkHhZRwiu8igmw8upYi/lgL7Cj6bA3zV4MTEHLQNCNIXjbrXgtcCrcXU
	YB5zyZ8SFrtfA1NJv+aRHdRzlkQK+ZFjIvi0R6Qb3i2hlaPuWm4UYGJvx68gibKpKONJNN
	Nk89PkgXPXCrhnaHOsZRBtSmyJ7Bsg4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-dUFdP9bzPweUjtlKKo5HIg-1; Mon, 14 Oct 2024 02:48:26 -0400
X-MC-Unique: dUFdP9bzPweUjtlKKo5HIg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a04210851so62783966b.2
        for <virtualization@lists.linux-foundation.org>; Sun, 13 Oct 2024 23:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728888505; x=1729493305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWLY8gFXi6zZrdCtsmsuGezKS4Vv9L373qHibuel/Dg=;
        b=fRWJAQpB31P8kZYqTIA2ScWtkkaBu2R7Yf9NQXqgBmo0n7nv4EIaZcBqGzFG+a2un4
         HXqRRUJPiI9zF/LnX/BhIbnHDCD5T5MDPDoQ/iQgHUwCo6oA5+8HED2WGkuL6xzdIx7K
         LVZkVB0p9iBcoI3BRXt5t+KIksJm5d9xVm0DUAlM5wZiW6dnk44Dxun3ZPmzZanLJAF+
         LySH5OjtNG0GPIufWCFlmihaISW4sJ7DfxFT/6zZvgdYNKRqg1ZdXbmQ9lxJQ1lnYlAf
         51NBMiQ+Fu2iKvZUg0vRgw92VlSQMnZJ+GwGx3HOCNhkrI2O2uWKCrIhvhMwusYzWa/s
         1KEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyPkJ7iW7osy8zT5sNJqBRpSjajWoA3gMbKnV/mEnZM+rlpPEIUZFKSRe+yyWC+QfeHTXJO36JK/erQiefsA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw6Yzxf/o7HTuZZNAgnawjdIpzWhW8aNrnZ/QJnuz88IIEXSYLe
	soYRSEC7qnfut+3qmUoDv/WJNisCM8kBjbDGC/4sLn2CR34rhoufUfgLRw+P35HYlYiSvSHlx9r
	iL36BmfJVTPZ7/qwY6oA4nX1RT1uoU/WMZnPrYoMsRvUGEWtdGdf8RzgaU4+xnnskpA2RTYR2Kx
	lPcnfnNO+Sjw6ZSUTyv4bJlgNq1mykjZfu/odY0NcZbIPwR4GeM4Z+pg==
X-Received: by 2002:a17:907:7288:b0:a99:5601:7dc1 with SMTP id a640c23a62f3a-a99b9586a29mr857241066b.49.1728888504955;
        Sun, 13 Oct 2024 23:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDZvvo05EHXZwdjWpt7gfBXCGbv70zK4KousTsCTsR0Vs+Ov9GRND0pLhhxGNdC5rR0lauK8au+RVOPzggu5s=
X-Received: by 2002:a17:907:7288:b0:a99:5601:7dc1 with SMTP id
 a640c23a62f3a-a99b9586a29mr857239266b.49.1728888504617; Sun, 13 Oct 2024
 23:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
 <CACGkMEt-8hdiAaAPjNAPNSNtBFHK+ogCndHFJMtYpjEzoTK6Qg@mail.gmail.com>
 <d4h4g7txswidmpau5i6evvnragzzgtbxgoelorcolowweb4qjo@ujevaic3uzrv> <CACGkMEv+qfmuEnjjgbZc2nSKCN0TbwJvu6D1CiYV_zHw7QR46g@mail.gmail.com>
In-Reply-To: <CACGkMEv+qfmuEnjjgbZc2nSKCN0TbwJvu6D1CiYV_zHw7QR46g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 14 Oct 2024 14:47:48 +0800
Message-ID: <CACLfguXTPkuS0fNZVJFq7KyByp_A4nCD2empyDUz+fYg1M2h0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
To: Jason Wang <jasowang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 at 16:20, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Oct 9, 2024 at 4:10=E2=80=AFPM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> >
> > On Wed, Oct 09, 2024 at 03:28:19PM GMT, Jason Wang wrote:
> > >On Mon, Oct 7, 2024 at 9:31=E2=80=AFPM Stefano Garzarella <sgarzare@re=
dhat.com> wrote:
> > >>
> > >> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
> > >> >The vhost is now using vhost_task and working as a child of the own=
er thread.
> > >> >While this makes sense from containerization POV, some old userspac=
e is
> > >> >confused, as previously vhost not
> > >>
> > >> not what?
> > >>
> > >> > and so was allowed to steal cpu resources
> > >> >from outside the container. So we add the kthread API support back
> > >>
> > >> Sorry, but it's not clear the reason.
> > >>
> > >> I understand that we want to provide a way to bring back the previou=
s
> > >> behavior when we had kthreads, but why do we want that?
> > >> Do you have examples where the new mechanism is causing problems?
> > >>
> > >
> > >The main difference is whose (kthreadd or the owner) attributes
> > >(namespace, affinities) would vhost thread inherit.
> > >
> > >The owner's attributes tend to be different from kthreadd, so
> > >management might be surprised for example, vhost might be created in
> > >different namespaces or having different scheduling affinities.
> >
> > Okay, so this requires some API to allow the managment to understand ho=
w
> > the device vhost will be created.
> >
> > But why do we need to restore the old behavior with a kthread where the
> > resource accounting is completely disconnected from userspace?
> > For the old managments that don't expect this?
>
> Yes, as such change can be easily noticed by the user space that
> breaks existing management layers or tools.
>
> >
> > BTW I would suggest adding all this information in this commit, in the
> > parameter/IOCTL documentation, and in the cover letter because IMHO it
> > is very important.
>
> I've asked this in the past. Cindy, please make sure such information
> were included in the next version in the cover letter.
>
> Thanks
>
Thanks Jason, I will add this
Thanks
cindy
> >
> > Thanks,
> > Stefano
> >
>

