Return-Path: <SRS0=H6i0=NZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1139FC433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 00:58:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE7661054
	for <virtualization@archiver.kernel.org>; Fri,  3 Sep 2021 00:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABE7661054
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6046C83673;
	Fri,  3 Sep 2021 00:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8hqjFZxJE7f; Fri,  3 Sep 2021 00:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EAC8383658;
	Fri,  3 Sep 2021 00:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1342C001A;
	Fri,  3 Sep 2021 00:58:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E3C1C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 00:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AB0960749
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 00:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yERrD7KWYoOq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 00:58:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 578BA606EA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Sep 2021 00:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630630692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dweDyOYjcmK69myJXjFnVZ/WQ447Q7GxQ0zWDd/1fFI=;
 b=BeBOEe6BK/egvYZju1heTP/MSRWakmziaTzNOKXjTfWUHxtWU7rjb6q+EY6ZUEc7vxPbWa
 dhtM1ZCZgLuADq5ClmuHvcytaKdLWtGO0wyq+QF2eq2rVxKgXZlRRRamZaBlwboYYhZbfZ
 58oTdQXUc/NqREd1wIJB2bBICebrPMk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-6vDcrh0SMhCm_SduwGFrlw-1; Thu, 02 Sep 2021 20:58:11 -0400
X-MC-Unique: 6vDcrh0SMhCm_SduwGFrlw-1
Received: by mail-lj1-f200.google.com with SMTP id
 p11-20020a2ea40b000000b001d68cffb055so1616760ljn.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Sep 2021 17:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dweDyOYjcmK69myJXjFnVZ/WQ447Q7GxQ0zWDd/1fFI=;
 b=ca+lawKjnUN8axhH1VkGztjek6vjpIXOvTI7fkM39ce/vMpfmh94ysQY6XIf/711Xi
 SugnADGN3U0Fo1ut0WjFQnMKLT/ah3Qxak5flwNI9N2nO1wn1lNr0dwHNClLUbbcXrMC
 /4kF0HIlp7ZLTlEb/L3fthndm+HOyIZ2VJ2rTuSCdHu//5leDbeHUJnT7ntZK9HA/MGL
 8n9DEhrZoIFnRh0a06+OaM/dcOJ3oOIa7umUA48q/fHtGMwYRd2BCCD4nj9fOB762dju
 Hzl90FvGQeKVJJjklkULTPTQyLy4C+IouRMT1oisekLAeFim7YJaK+nnDh84zIlM4rlY
 E10A==
X-Gm-Message-State: AOAM531GgUVKLy2+U/SyOETVD5zvnlI4hDSWk1Of3EEf7og9mh+xLBDT
 +Y17o9vK3Iqntt18KpSp8ZP6b0+xIMlORv3AvfxAUzcJQzlhSbV5Hff43l0xgjmZkiGjy5M/Ya+
 s2ofcGqUrbiDO0tU2ZniDEc5rb5F2gUzlYPxiqurGxpQm2yhAmjq7lu4dyg==
X-Received: by 2002:a2e:801a:: with SMTP id j26mr822126ljg.385.1630630689490; 
 Thu, 02 Sep 2021 17:58:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv+cC/51MDemLJlyzI1/sE33ac9c6oU7NLMZ7/q8qpYz09PPl+mZKp6gK057IgTiCC/j+wiUqVqDbsh2Yb5aA=
X-Received: by 2002:a2e:801a:: with SMTP id j26mr822105ljg.385.1630630689270; 
 Thu, 02 Sep 2021 17:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210902130625.25277-1-weijunji@bytedance.com>
In-Reply-To: <20210902130625.25277-1-weijunji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 3 Sep 2021 08:57:57 +0800
Message-ID: <CACGkMEsz4HQKpaw3P=ODXvN2AuqO+_YE0UHpzOFk5GbzX13V4A@mail.gmail.com>
Subject: Re: [RFC 0/5] VirtIO RDMA
To: Junji Wei <weijunji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>, mst <mst@redhat.com>,
 linux-rdma@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>,
 Cornelia Huck <cohuck@redhat.com>, yuval.shaia.ml@gmail.com,
 virtualization <virtualization@lists.linux-foundation.org>, jgg@ziepe.ca,
 dledford@redhat.com, =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>
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

On Thu, Sep 2, 2021 at 9:07 PM Junji Wei <weijunji@bytedance.com> wrote:
>
> Hi all,
>
> This RFC aims to reopen the discussion of Virtio RDMA.
> Now this is based on Yuval Shaia's RFC "VirtIO RDMA"
> which implemented a frame for Virtio RDMA and a simple
> control path (Not sure if Yuval Shaia has any further
> plan for it).
>
> We try to extend this work and implement a simple
> data-path and a completed control path. Now this can
> work with SEND, RECV and REG_MR in kernel. There is a
> simple test module in this patch that can communicate
> with ibv_rc_pingpong in rdma-core.
>
> During doing this work, we have found some problems and
> would like to ask for some suggestions from community:

I think it would be beneficial if you can post a spec patch.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
