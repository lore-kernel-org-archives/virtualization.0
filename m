Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AC13CFA1
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888458; cv=none; b=Ydxscfaww4jrvFyKOji8LJY/SYmZZAupxwIF1Zk8XvhuE4gdBVQWvvnKQ9D7nfD1g0Y6untN48QUKDFo5b0SQXl1EkgC0AVpfT09ITUhnEsBTI3DeSiHqxVYN9NbEKyMSuCSYIV5P9JVrRjZKG9YULNkzMSxXnRP2WJRhCfxtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888458; c=relaxed/simple;
	bh=geiKVVWurTTMbaHNh5ddy9vS+rzka6UiYWfq7KT0eM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPeWk/i4+jZ9SymyghTrmuFKRdmps7OWyympV5JkYQylFOtI2luFGdA7FsIBjdnRA6vbTR/wuc8NBSJvANPqiQiaprjRyGB362xoW5qoR7UWsdh882HvAEWbQsV1W0o5Wsyt3GnrfMWfmQA1N5/sE+22BRyfABkei+NgR9NKwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dF9yxFTA; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF9yxFTA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A21A80ECA
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 06:47:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mODklydn3VTT for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Oct 2024 06:47:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7689E80EBC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7689E80EBC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dF9yxFTA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7689E80EBC
	for <virtualization@lists.linux-foundation.org>; Mon, 14 Oct 2024 06:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728888453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0rlO66l0G1ddEG+NUukiH15fKO4cHxOJ0004NGjApZ0=;
	b=dF9yxFTA9awb1d8Mw8AsS+eTbd2I8d2qylgjwdvqerFEnONPfH7/FPsLspdSmThQBCJx7g
	jVevEkNSykgOTAdz5uU8n/fBKRkxsp8EbDq3ZyUFmosMW47YgdtRVEtzv09/9Jzv0WDixj
	Vxu0jvwQ3JBUkbFJkBDkGkhVWFCC1ug=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-aHF-Tk7EOfyRODCHV-UW9Q-1; Mon, 14 Oct 2024 02:47:32 -0400
X-MC-Unique: aHF-Tk7EOfyRODCHV-UW9Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a157d028aso25928366b.2
        for <virtualization@lists.linux-foundation.org>; Sun, 13 Oct 2024 23:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728888451; x=1729493251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rlO66l0G1ddEG+NUukiH15fKO4cHxOJ0004NGjApZ0=;
        b=fMdzcafoBtaX1Vx3+ZyDrsvndagouuxUD3MFkxbyi0PeTzURDMxeWbJi2Noo1BohbA
         /fWT51w9a+dr2dZ4tE1dZAIF1FbQfmipf2EKrOAbuSjOxOdQ5Ir0pgue9dg0ZDzHuMEU
         SkhVJ61cJ/Tmfdy0JblF48FwbY8hkptHzRr0mv1s0dsBq9ApsqdKFEtP6DstUzOJ9iN7
         ETnkj7uczd8aQ91/YUsBcCiBWc6WLjHCSeSc8BS131rC8N/STfJFCPgdszDJUh2mFgBh
         UvRprmqJz4oQWM2vlIe7U4/shc3f/FDg/uKHnHF2hJeKNAh6f2CEtyiKqsgUNKXmzzp8
         tc3w==
X-Forwarded-Encrypted: i=1; AJvYcCUXlhwtIDdCu2yX5KsnvrpXV8rdjWKmykL/keDd1Jjo748vZU6/w8pHM3F9Hnkb84UtRfQE1YdNyqR2SXwTBA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzxJQzj8wpwftipRRqPFC0Xjl7X9YrUdFM/jkuA0P2lW2iyH8XB
	IyWbw0TWOR0dSlxQejM+P9E5vXUpjLrjm5gL5b4JvhgEYnvNcMEtli4rVEFPfYhzb0QeBI16ax9
	mnjr96zGUmgZgbXdLkPCt8jouGwQK3uu4ayv5J+cD8jz+ENznNDRuCsFvqfIPIlJ7ttStfqwAay
	YJfDNNNMDnL7LomlxwHiQ2FgLt3yvY0j0VLx3jmSevx9vy7+N4VCvZRw==
X-Received: by 2002:a17:907:1b1c:b0:a99:7455:25f2 with SMTP id a640c23a62f3a-a99e3cdc18bmr665136166b.39.1728888450764;
        Sun, 13 Oct 2024 23:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeOnrOdNUEBMfyq1gIKua3lIPx5v7BSWHO1RcInq0vuWfRf2Nuq+JEPEGDfi3YGea2aOTX7QV0c3/vzxWlHi8=
X-Received: by 2002:a17:907:1b1c:b0:a99:7455:25f2 with SMTP id
 a640c23a62f3a-a99e3cdc18bmr665135066b.39.1728888450418; Sun, 13 Oct 2024
 23:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-2-lulu@redhat.com>
 <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
In-Reply-To: <olbm26f3ifb6ypfmfl22xszbpevqsxc3ogfzosrb44ujtzt6pw@uh7irbqfy5jr>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 14 Oct 2024 14:46:53 +0800
Message-ID: <CACLfguU2cmy0UG4Zru49wap0U+oX6Como3NZvBxQeKgY8kX9sA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace
 select vhost_task
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 21:31, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Oct 04, 2024 at 09:58:15AM GMT, Cindy Lu wrote:
> >The vhost is now using vhost_task and working as a child of the owner thread.
> >While this makes sense from containerization POV, some old userspace is
> >confused, as previously vhost not
>
> not what?
>
> > and so was allowed to steal cpu resources
> >from outside the container. So we add the kthread API support back
>
> Sorry, but it's not clear the reason.
>
> I understand that we want to provide a way to bring back the previous
> behavior when we had kthreads, but why do we want that?
> Do you have examples where the new mechanism is causing problems?
>
> >
> >Add a new module parameter to allow userspace to select behaviour
> >between using kthread and task
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 9ac25d08f473..a4a0bc34f59b 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
> > module_param(max_iotlb_entries, int, 0444);
> > MODULE_PARM_DESC(max_iotlb_entries,
> >       "Maximum number of iotlb entries. (default: 2048)");
> >+bool enforce_inherit_owner = true;
>         ^
> This should be static:
>
> $ make -j6 O=build C=2 drivers/vhost/
> ...
>    CHECK   ../drivers/vhost/vhost.c
> ../drivers/vhost/vhost.c:45:6: warning: symbol 'enforce_inherit_owner'
> was not declared. Should it be static?
>
> >+module_param(enforce_inherit_owner, bool, 0444);
> >+MODULE_PARM_DESC(enforce_inherit_owner,
> >+               "enforce vhost use vhost_task(default: Y)");
>
> I would follow the style of the other 2 parameters:
>                   "Enforce vhost use vhost_task. (default: Y)"
>
> With a view to simplifying bisection, we added this parameter in this
> patch, but it does nothing, so IMHO we should only add it at the end of
> the series when we have all the code ready. Maybe you can just add
> `enforce_inherit_owner` here or in the first patch where you need it,
> but I'd expose it with module_param() only when we have all the pieces
> in place.
>
> About the param name, I'm not sure "enforce" is the right word, since
> IIUC the user can still change it using the ioctl. It would seem that
> set `enforce_inherit_owner` to true, it is always forced, but instead
> ioctl allows you to change it, right?
>
> Is it more of a default behavior?
> Something like `inherit_owner_default` ?
>
> Thanks,
> Stefano
>
thanks, Stefano, I will change this
thanks
cindy

