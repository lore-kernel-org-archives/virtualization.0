Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1035FC433FE
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 01:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A69348176A;
	Tue, 10 May 2022 01:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TajwGBJwVmgs; Tue, 10 May 2022 01:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A22D81469;
	Tue, 10 May 2022 01:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17A89C0032;
	Tue, 10 May 2022 01:51:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F894C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48D0181767
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9RiCELYGzbHE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:51:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEEA081469
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652147472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=teQJ5KLbxBAQsQDucoumVqAHigNqlNVTlH1Kv1gzM2M=;
 b=F7IGiLC5QlyhfkKUFeIyVsOhTiB2dr16b8f21KHK0abShUiEGz/MPnsGQsI6LvC4qfxoQG
 KnweYU2bOyiyrXA33IX1jAyjFhIS4QZOYe+xpZ75jrykN2hRlzX+P2AuIJsvqcmg7tCwWx
 mN1q0VK+6ZV2z3MDoyw+YNnp6jXbrkE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-Y_ziuhbRP9CupB0QeA1GoA-1; Mon, 09 May 2022 21:51:08 -0400
X-MC-Unique: Y_ziuhbRP9CupB0QeA1GoA-1
Received: by mail-lf1-f69.google.com with SMTP id
 e11-20020ac2546b000000b00472627d901eso6565348lfn.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 May 2022 18:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=teQJ5KLbxBAQsQDucoumVqAHigNqlNVTlH1Kv1gzM2M=;
 b=hi/HgW6pv4SYMS/MMCMOPlu5DY+dkVrqy1iNQKG3JPyNERs9CtrUss2pzKipQqmH8Z
 cFcq7I6SILyNk3mY7DrQwTe6UUiBKVA4BNjrOFhTfVNS55ultX1o9A1Bgxkp0M/kd1od
 xOYEy1Zjox/TRHCEDhI5nuZ8PQBvGOU/fiQu5S6Humf92BO8fp0dbIPQjIxu1p8VlJPB
 8C7sUcpqJFRedUpe83izsLRS+pt97zrt6FazAQYdVm256dpEQHZUV96bPfBikOz5n6/d
 +Vpa1p7JTHBrHZAa/B1VHZfsRGri9v0HOKnbGwoZ7W3heazYOFBrK6Df00ythdTr5wpZ
 7haQ==
X-Gm-Message-State: AOAM531yEeEdtzKbVUHn30H4TCvvCS7WzrzG7cChfQCKjUbXAUTUPw8b
 D6EaddxAQgd7Np8pG9XkofP1bHrX9GXpiPQLFLp4K1C9CpW65rUC7l7HkFRFsicat7qd5rqaU5u
 KCkTjsF+kGHSgfw1wc6Pby6IUC/mxHyuYzkHRIUSvIdpG87BcDgSGo1kW1A==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr14646498lfj.587.1652147467369; 
 Mon, 09 May 2022 18:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAD9vhgUsXPjEZITjdjVacUMMb+5bP4mBi9Gsh9amo66y0gdv+kqwYajul4yOnm15JVd7SjPCmReZLg0X9J8A=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr14646483lfj.587.1652147467196; Mon, 09
 May 2022 18:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-2-jasowang@redhat.com>
 <87bkw64tol.fsf@redhat.com>
In-Reply-To: <87bkw64tol.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 May 2022 09:50:56 +0800
Message-ID: <CACGkMEu=oG5KtouSGEBfaa1R0ivDBQRFqew1nttZKYFn9jQAHg@mail.gmail.com>
Subject: Re: [PATCH V4 1/9] virtio: use virtio_device_ready() in
 virtio_device_restore()
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Mon, May 9, 2022 at 11:22 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Sat, May 07 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > From: Stefano Garzarella <sgarzare@redhat.com>
> >
> > It will allow us to do extension on virtio_device_ready() without
> > duplicating code.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> I think you forgot my R-b on this and the following patch...

Sorry, I will add them in the next version (or I will repost if
everyone thinks this version is fine).

Thanks

>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
