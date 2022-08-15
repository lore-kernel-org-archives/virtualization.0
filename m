Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE58C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 23:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EE9540992;
	Mon, 15 Aug 2022 23:35:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EE9540992
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dqXzWqaI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZ3VJ5e5SmiA; Mon, 15 Aug 2022 23:35:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79AEB4092B;
	Mon, 15 Aug 2022 23:35:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79AEB4092B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC7FC0033;
	Mon, 15 Aug 2022 23:35:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A81DEC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 783054098F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 783054098F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yDm2HHFY-lhE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:35:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77BA34092B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77BA34092B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 23:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660606518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5zb/VZQAOIgiltymKi0EU4LqXYPn7kX2Sef7eElYFw8=;
 b=dqXzWqaI0TrZPz9hwGxwas/KVW2CuVuMiXjoOUXdaOiwNqNGAZJ0qaYNsNaaOlLi5MG/G+
 v8p/Eo9bE/VkJ2melYmGKf9ygcAHq0Y1fPlsw+zT4JBGX8s8/hUGVUw8QKFCSS8BeBawFV
 uPQ4mJO3wOwdhNrvtF/UMaMzBqnl0Wk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-471-6Qi8_AoXMnObwpM9zQ6QAA-1; Mon, 15 Aug 2022 19:35:15 -0400
X-MC-Unique: 6Qi8_AoXMnObwpM9zQ6QAA-1
Received: by mail-wm1-f72.google.com with SMTP id
 v64-20020a1cac43000000b003a4bea31b4dso9366958wme.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 16:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=5zb/VZQAOIgiltymKi0EU4LqXYPn7kX2Sef7eElYFw8=;
 b=aYguPRJ/HEuP7V7WOXNFytKXm+QWy5QTRJo1pL9uziDCBrfSbTpqJcuWhnVnwkKPl6
 PqWcl8Ih8w8v/79AGUjkTlkhtIPBy2dN4jNzPhr0QgnYZHWffKZzuGJSj/DaaZTXowJ/
 5FiBgW4ANf8aYHmU9XcFzqJX1keWogLxS0lhqZMBGr9aZ8xUL85qzzMd/A2KGd7J24Qk
 tqSi7TpX7bcB4i9mHStTzG5Ugno6A916zpFOzJbWYi0GTk7Rbcckq0GAnf7/7ReEseJ6
 RPMwpu4b7fcCkHzY2VPJZDIz1xwyfrMiN+UNqiHo4N7cYRwJMCQQnez+pdBpiC+ftR8l
 Q5Hg==
X-Gm-Message-State: ACgBeo071GOBuu/sXOUR8B1K7WUHEqi30me16rsMMgpLZRgJSWI4FEOz
 mXU1SqfzAZ62x8jd6bYT1sMLY36PX5zfU4nzjyzgzmFtRnm0r9reqi80JH6VXmfZJRIJ2xMGSWj
 4VrBqCuhWDZ1hEywrJ5jyCdc/pGHVetQ05KWz84KBrQ==
X-Received: by 2002:adf:e68c:0:b0:223:a74e:7e63 with SMTP id
 r12-20020adfe68c000000b00223a74e7e63mr9161861wrm.603.1660606513924; 
 Mon, 15 Aug 2022 16:35:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7edmzM0cGxVsTi8/QYJs2FLXSn76zA+W0PpmBcUpfrSpvST9v2wXq+kEHGhFwDZ7zGXJdYvw==
X-Received: by 2002:adf:e68c:0:b0:223:a74e:7e63 with SMTP id
 r12-20020adfe68c000000b00223a74e7e63mr9161853wrm.603.1660606513724; 
 Mon, 15 Aug 2022 16:35:13 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c501200b003a545fe9db4sm11056782wmr.23.2022.08.15.16.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 16:35:12 -0700 (PDT)
Date: Mon, 15 Aug 2022 19:35:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 0/5] virtio: drop sizing vqs during init
Message-ID: <20220815193438-mutt-send-email-mst@kernel.org>
References: <20220815215938.154999-1-mst@redhat.com>
 <CAHk-=wj=Ju_jhbww7WmpgmHHebMSdd1U5WBjh925yLB_F1j9Ng@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj=Ju_jhbww7WmpgmHHebMSdd1U5WBjh925yLB_F1j9Ng@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

On Mon, Aug 15, 2022 at 03:24:28PM -0700, Linus Torvalds wrote:
> On Mon, Aug 15, 2022 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > But the benefit is unclear in any case, so let's revert for now.
> 
> Should I take this patch series directly, or will you be sending a
> pull request (preferred)?
> 
>              Linus

I'll be sending a pull request, just not today - I try not to do
this at strange hours of night.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
