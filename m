Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9366FC433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 08:34:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C8C8812DC;
	Tue,  5 Apr 2022 08:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZByMatxWFKt; Tue,  5 Apr 2022 08:34:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C087A812E1;
	Tue,  5 Apr 2022 08:34:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9157BC001D;
	Tue,  5 Apr 2022 08:34:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07E02C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 08:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E298960C0F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 08:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZOOKAxD4_GiM
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 08:34:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43A8560BD2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649147656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z65CXYbIBUl/IlVCrlM6BZQKF+ZppxomZMYuDllBYxE=;
 b=FgxQGsUhQ6/Ul6iA5ukP1u5jptq6njHxozoGUJI7Ky1QS0VITiCW0eItR4vU/q6m/I5uiv
 yhKiPpg6P/YPU1tE1bikZr/Lz5I42NNsSGkXxjdjXnjr0arQhnsTnC2/tPGLvPP5mlIXtg
 5gRVyDk6jGBOohC/CwWAW8YaGuJ0gUQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-bYIfSXvxPQ2HCL19_IPyWQ-1; Tue, 05 Apr 2022 04:34:12 -0400
X-MC-Unique: bYIfSXvxPQ2HCL19_IPyWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CF3F38025E9;
 Tue,  5 Apr 2022 08:34:01 +0000 (UTC)
Received: from localhost (dhcp-192-213.str.redhat.com [10.33.192.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28080145D850;
 Tue,  5 Apr 2022 08:33:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
In-Reply-To: <20220405012015-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
 <20220307040431-mutt-send-email-mst@kernel.org>
 <87h778g8nn.fsf@redhat.com>
 <20220405012015-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Tue, 05 Apr 2022 10:33:42 +0200
Message-ID: <87ee2cexp5.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 helei.sig11@bytedance.com
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

On Tue, Apr 05 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 04, 2022 at 05:39:24PM +0200, Cornelia Huck wrote:
>> On Mon, Mar 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
>> >> Hi, Michael & Lei
>> >> 
>> >> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
>> >> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
>> >> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
>> >> for a revoting procedure?
>> >
>> > You can but not it probably will be deferred to 1.3. OK with you?
>> >
>> >> Also cc Cornelia Huck.
>> 
>> [Apologies, I'm horribly behind on my email backlog, and on virtio
>> things in general :(]
>> 
>> The akcipher update had been deferred for 1.2, so I think it will be 1.3
>> material. However, I just noticed while browsing the fine lwn.net merge
>> window summary that this seems to have been merged already. That
>> situation is less than ideal, although I don't expect any really bad
>> problems, given that there had not been any negative feedback for the
>> spec proposal that I remember.
>
> Let's open a 1.3 branch? What do you think?

Yes, that's probably best, before things start piling up.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
