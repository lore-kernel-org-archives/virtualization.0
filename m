Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E45C77B72
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 11:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1066C81F85;
	Mon, 17 Apr 2023 11:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1066C81F85
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i3oFxcza
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gDXu4fFAru28; Mon, 17 Apr 2023 11:14:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6029381F79;
	Mon, 17 Apr 2023 11:14:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6029381F79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC19C0036;
	Mon, 17 Apr 2023 11:14:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAA31C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2B1041C9C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:14:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2B1041C9C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i3oFxcza
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMuFK8ocFx4A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:14:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F32A640120
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F32A640120
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681730081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KNRdeLRU2Xq/n1iDZzMtTXMvfraDKy7YfY/QU65aIc=;
 b=i3oFxczaEt479I0iFXaRhrqLSx9P6FifoKisSNQvp7e9tktK5cHxJxAFqtr3/GP3+qQL9I
 nFNrBUPeyJNPD5WLlgYOR+rD9soVZlgW5jRZCfGZG+xYH4q8JIoahT5ZvWoP57opaZ5sBw
 6jIV08hpzQ46euOkDOabHH0mEPAqZTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-v-bM-4kSMgyoU--z6Miudw-1; Mon, 17 Apr 2023 07:14:40 -0400
X-MC-Unique: v-bM-4kSMgyoU--z6Miudw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f0990ea54bso8125515e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 04:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681730079; x=1684322079;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5KNRdeLRU2Xq/n1iDZzMtTXMvfraDKy7YfY/QU65aIc=;
 b=U9WR0z1ocUu4rD9OKOPVdWAWmd7UjaylBW/DUGSZJPTcUzNXrK2xEPSxFAtEwbzUV6
 K3jlisvK0z1AvYjP06bgxEUeGslsuMYXFqSubiSszhVbckmlVzf5BA2nz5MD6p3Wdl+Y
 Ad/GLidQ0FKz3g43bUzafG9ArzFtPqP97d+h7fYyPKOOcL9DErW1AkBozWeuQrj16ElM
 9bf9rNZPoQaA0DJYqKtVAHgEgAbVeNga1aT03rmpAvQtrcbBHa3ZAEzi2NCKGHof8NQF
 owhjyIGcDab4KbfMs4DQ8zZZByRtDXe3oBjnssDJNiYZKDAymVR3lXIlzaynOp4X9PuY
 kwMw==
X-Gm-Message-State: AAQBX9dkEBUrMj7P5uJs0YZ+zrCz1vMSot7hIu7ZPUwn4BMD/j3B3jHx
 Fks9X3dV/HQgWXZpBuCEG/mjclQDWDqRL65A3x8QbQpbpBkEeaC9ue736szE+l2RHSVWFNVcHgS
 dPaOAdGoiIpiyaDq5xQmG1kO6ME7m5pkmUtI150a01g==
X-Received: by 2002:a5d:650c:0:b0:2f8:3225:2bc2 with SMTP id
 x12-20020a5d650c000000b002f832252bc2mr4681553wru.41.1681730079148; 
 Mon, 17 Apr 2023 04:14:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350bNt0CQlgSAneNNoqT/xp81/MyHZrBQz3dDdnffEdIUnbPzTF+43gFytbOZ+e3kttt+3w0ALw==
X-Received: by 2002:a5d:650c:0:b0:2f8:3225:2bc2 with SMTP id
 x12-20020a5d650c000000b002f832252bc2mr4681519wru.41.1681730078827; 
 Mon, 17 Apr 2023 04:14:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf?
 (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de.
 [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
 by smtp.gmail.com with ESMTPSA id
 v3-20020adfe4c3000000b002f459afc809sm10282660wrm.72.2023.04.17.04.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Apr 2023 04:14:38 -0700 (PDT)
Message-ID: <eb624430-6fb5-0349-0798-3f71c39e8768@redhat.com>
Date: Mon, 17 Apr 2023 13:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 6/7] mm/gup: remove vmas parameter from pin_user_pages()
To: Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <fa5487e54dfae725c84dfd7297b06567340165bd.1681558407.git.lstoakes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <fa5487e54dfae725c84dfd7297b06567340165bd.1681558407.git.lstoakes@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Nelson Escobar <neescoba@cisco.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Leon Romanovsky <leon@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 John Fastabend <john.fastabend@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-media@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bernard Metzler <bmt@zurich.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, io-uring@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, Bjorn Topel <bjorn@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>,
 Christian Benvenuti <benve@cisco.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> After the introduction of FOLL_SAME_FILE we no longer require vmas for any
> invocation of pin_user_pages(), so eliminate this parameter from the
> function and all callers.
> 
> This clears the way to removing the vmas parameter from GUP altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Ideally, we'd avoid FOLL_SAME_FILE as well

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
