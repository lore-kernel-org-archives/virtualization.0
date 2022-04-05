Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376AAC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 11:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD82840176;
	Tue,  5 Apr 2022 11:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mmAmzDHnEPQB; Tue,  5 Apr 2022 11:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4987C400F1;
	Tue,  5 Apr 2022 11:57:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28660C002C;
	Tue,  5 Apr 2022 11:57:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA6D5C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 11:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 979B740119
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 11:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kowYlUi29ofM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 11:57:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9DF7400F1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649159848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZyeehLgo43vPEC1Sp1n3r3jpBNtdCjtLwgkplLP3v4=;
 b=Gh1urVgDOeB9+9TxPEQeRkhcqCncaFa8w1U9aVXPwWd9+BzvwtLgauDuT5npxZ7ZsYGpEy
 +2cLGfjg87/sbCwjZPmJfPObdYuRuPoNUmNfjDY/szAPb3aPdw9c1mV+t+FVj9LCzmEPm1
 ma0vA+nyG5qidYPD19KL428n3aY96z4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-_V2-93v1MX-jX2VqeyBDyQ-1; Tue, 05 Apr 2022 07:57:27 -0400
X-MC-Unique: _V2-93v1MX-jX2VqeyBDyQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 h33-20020adf9024000000b00203fcba8aadso2410336wrh.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Apr 2022 04:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yZyeehLgo43vPEC1Sp1n3r3jpBNtdCjtLwgkplLP3v4=;
 b=2DBmTfaPZdby8zKwxUjQN61wqkgfzv3wNBlN+VVqCQVkrykL6kJsCystwTuHS6E+0c
 MwLNtN3OY9jkSLZ8qY/OBaRVrhvjH0nYT3wsSoQfXPdadVmorAwqzZaVMtgOwkSGPxe3
 B3uFoHiVCg+PVX/u604/wwMtBGojBQrowyxZMaT4N1bPFJAksU8BSdYgPfnGQoK3b1z+
 88Q6JHEZtIrphukhjVduRyj8jQDLswXa6uTHZZ4OgD9PKw5wOzJgTfm+kL66LuNv0O+T
 EMJqYmJ6rONmsWiFIVz3Ru7bD2RPb/jeSpHsBq/9Qr5SVVmcQmYD0dg+L2Nc5R2JiJHX
 WU/w==
X-Gm-Message-State: AOAM531KQneD1nlercSWafwkJ2ecrT5n+/og8IRQqGC0TMMCezuR2xPn
 azSSfh0qPt+NrBB2k6C5+PMgRFTFpW1mjE6OeNoIRvrZOa+eihfzoj4rOkTzc/ZSy6UENvCysOb
 0f6E4543zNve0xNO0kw/bEAtBrdniVmVpU8emD2Yzfg==
X-Received: by 2002:a05:6000:184a:b0:203:f8f0:3407 with SMTP id
 c10-20020a056000184a00b00203f8f03407mr2604217wri.190.1649159846180; 
 Tue, 05 Apr 2022 04:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypIKxQBes9FfmGLsTQSI+o8ZS7lLWmQJBmsfPcPeNLWB/aoHg6W8W0oB4kBqUTKA7V4gN8eQ==
X-Received: by 2002:a05:6000:184a:b0:203:f8f0:3407 with SMTP id
 c10-20020a056000184a00b00203f8f03407mr2604202wri.190.1649159845981; 
 Tue, 05 Apr 2022 04:57:25 -0700 (PDT)
Received: from redhat.com ([2.52.17.211]) by smtp.gmail.com with ESMTPSA id
 m4-20020a7bcb84000000b00389efb7a5b4sm1883255wmi.17.2022.04.05.04.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Apr 2022 04:57:25 -0700 (PDT)
Date: Tue, 5 Apr 2022 07:57:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <20220405075627-mutt-send-email-mst@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
 <YkvVOLj/Rv4yPf5K@infradead.org>
 <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization list <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Apr 05, 2022 at 08:29:36AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 5, 2022 at 7:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Apr 04, 2022 at 10:04:02AM +0200, Arnd Bergmann wrote:
> > > The header is shared between kernel and other projects using virtio, such as
> > > qemu and any boot loaders booting from virtio devices. It's not technically a
> > > /kernel/ ABI, but it is an ABI and for practical reasons the kernel version is
> > > maintained as the master copy if I understand it correctly.
> >
> > Besides that fact that as you correctly states these are not a UAPI at
> > all, qemu and bootloades are not specific to Linux and can't require a
> > specific kernel version.  So the same thing we do for file system
> > formats or network protocols applies here:  just copy the damn header.
> > And as stated above any reasonably portable userspace needs to have a
> > copy anyway.
> 
> I think the users all have their own copies, at least the ones I could
> find on codesearch.debian.org.

kvmtool does not seem to have its own copy, just grep vring_init.

> However, there are 27 virtio_*.h
> files in include/uapi/linux that probably should stay together for
> the purpose of defining the virtio protocol, and some others might
> be uapi relevant.
> 
> I see that at least include/uapi/linux/vhost.h has ioctl() definitions
> in it, and includes the virtio_ring.h header indirectly.
> 
> Adding the virtio maintainers to Cc to see if they can provide
> more background on this.
> 
> > If it is just as a "master copy" it can live in drivers/virtio/, just
> > like we do for other formats.
> 
> It has to be in include/linux/ at least because it's used by a number
> of drivers outside of drivers/virtio/.
> 
>         Arnd
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
