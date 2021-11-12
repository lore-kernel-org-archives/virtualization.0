Return-Path: <SRS0=b7zo=P7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98F0C433EF
	for <virtualization@archiver.kernel.org>; Fri, 12 Nov 2021 09:13:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5602D61027
	for <virtualization@archiver.kernel.org>; Fri, 12 Nov 2021 09:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5602D61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1325E80CAA;
	Fri, 12 Nov 2021 09:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1mkHFk3YVLw; Fri, 12 Nov 2021 09:13:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B9CA880CAC;
	Fri, 12 Nov 2021 09:13:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E62DC001E;
	Fri, 12 Nov 2021 09:13:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A32A3C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 09:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D7EB80CAC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 09:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iJNmH0TkoD82
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 09:13:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6884C80CAA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636708422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/UJZxf1rg8eMFR87IMiW9u+KeIoLex0Bdd2vdqsTBSQ=;
 b=GiXWvHoTB0VsRmdUbXkM5+fIlfdgP4i9FeHdqQnZoIghbFy8C03ZjgdBf6LAXWX2k10R09
 2kwetcHKo/o9Cziz2uF7jRyRs5x31wGY6npu2rCp2VQs5k8PG/0N6ryWnV9rYRu12DKAUs
 sMyfXtLo8nlA298BwunaPjHjBlUE8i8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-wi4AIVOPOFCvIqDYPxZ26Q-1; Fri, 12 Nov 2021 04:13:41 -0500
X-MC-Unique: wi4AIVOPOFCvIqDYPxZ26Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 i1-20020a056512340100b003fdd5b951e0so3524559lfr.22
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 01:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/UJZxf1rg8eMFR87IMiW9u+KeIoLex0Bdd2vdqsTBSQ=;
 b=JY/9fy2r5DmJ2cnPqx0V7S9XOHjLXuurz3J59XI5MitOtOfs0V6n+ORxKhTYN5O6RX
 7nknHerY//R8wo9w9N5GuwLTFsRnObhFm5RBwST4dhloh6s0cCTL0T5QRzP5WL9uXo/1
 Z9zstY2/Vakz4xj1Hmt//atr1u5loJ5XoZoJ4WVKtn0jKtB7+KxkSqJ+KZTSl0e9ZaxM
 cmroWIflVlae5WD7eM2zqzLrSsRBzYSl9Hr2ufFfXng00dIqo/fGNIiATaW2c4hD6N6h
 +bSOsRQz7gJTA27TAHS9UD0VFUoF1jbyv/aHMDaNyRaK8KT/4vJrOdR39dhR/kb/vQfU
 F4YQ==
X-Gm-Message-State: AOAM533RaOB8Li3ULveaiHzBmS64+xw9GxdUUz4vUuBj2tzX5aiCZ2eN
 TcvLmnQ10jJjScc1pA7bDLSGffp9HsX7W1nN0zqxSP+nhRKIz6FXQTSLYFUrnfEH12R/75dJ8H9
 iQExMJq54LPu4DX3oCLCbnJRQzOkW5gL3HEkLAkeA/SYmKt9SuwQ0iI3e/Q==
X-Received: by 2002:a05:651c:28e:: with SMTP id
 b14mr14022786ljo.440.1636708420240; 
 Fri, 12 Nov 2021 01:13:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0F0CWQYl9m9FBj62gxAvBUzPdVSEJofB9lQJLdxTMadeC7FiMMESs00TZNnsYIoG7YrRozlAk3XYE1AiAGcI=
X-Received: by 2002:a05:651c:28e:: with SMTP id
 b14mr14022756ljo.440.1636708419982; 
 Fri, 12 Nov 2021 01:13:39 -0800 (PST)
MIME-Version: 1.0
References: <YY2duTi0wAyAKUTJ@bombadil.infradead.org>
In-Reply-To: <YY2duTi0wAyAKUTJ@bombadil.infradead.org>
From: David Hildenbrand <david@redhat.com>
Date: Fri, 12 Nov 2021 10:13:28 +0100
Message-ID: <CADFyXm5DroJqhQVVxUcN8yqa8DLWRRDi0sQWGz7u-LMYg3JVyw@mail.gmail.com>
Subject: Re: update_balloon_size_func blocked for more than 120 seconds
To: Luis Chamberlain <mcgrof@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dhildenb@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Michael Tsirkin <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, virtualization@lists.linux-foundation.org,
 Vlastimil Babka <vbabka@suse.cz>
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

On Thu, Nov 11, 2021 at 11:49 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> I get the following splats with a kvm guest in idle, after a few seconds
> it starts:
>
> [  242.412806] INFO: task kworker/6:2:271 blockedfor more than 120 seconds.
> [  242.415790]       Tainted: G            E     5.15.0-next-20211111 #68
> [  242.417755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  242.418332] task:kworker/6:2     state:D stack:    0 pid:  271 ppid: 2 flags:0x00004000
> [  242.418954] Workqueue: events_freezable update_balloon_size_func [virtio_balloon]
> [  242.419518] Call Trace:
> [  242.419709]  <TASK>
> [  242.419873]  __schedule+0x2fd/0x990
> [  242.420142]  schedule+0x4e/0xc0
> [  242.420382]  tell_host+0xaa/0xf0 [virtio_balloon]
> [  242.420757]  ? do_wait_intr_irq+0xa0/0xa0
> [  242.421065]  update_balloon_size_func+0x2c9/0x2e0 [virtio_balloon]
> [  242.421527]  process_one_work+0x1e5/0x3c0
> [  242.421833]  worker_thread+0x50/0x3b0
> [  242.422204]  ? rescuer_thread+0x370/0x370
> [  242.422507]  kthread+0x169/0x190
> [  242.422754]  ? set_kthread_struct+0x40/0x40
> [  242.423073]  ret_from_fork+0x1f/0x30
> [  242.423347]  </TASK>
>
> And this goes on endlessly. The last one says it blocked for more than 1208
> seconds. This was not happening until the last few weeks but I see no
> relevant recent commits for virtio_balloon, so the related change could
> be elsewhere.

We're stuck somewhere in:

wq: update_balloon_size_func()->fill_balloon()->tell_host()

Most probably in wait_event().


I am no waitqueue expert, but my best guess would be that we're
waiting more than 2 minutes
on a host reply with TASK_UNINTERRUPTIBLE. At least that's my interpretation,

In case we're really stuck for more than 2 minutes, the hypervisor
might not be processing our
requests anymore -- or it's not getting processed for some other reason (or the
waitqueue is not getting woken up due do some other BUG).

IIUC, we can sleep longer via wait_event_interruptible(), TASK_UNINTERRUPTIBLE
seems to be the issue that triggers the warning. But by changing that
might just be hiding the fact that
we're waiting more than 2 minutes on a reply.

>
> I could bisect but first I figured I'd check to see if someone already
> had spotted this.

Bisecting would be awesome, then we might at least know if this is a
guest or a hypervisor issue.

Note that the environment matters: the hypervisor seems to be
requesting the guest to inflate
the balloon right when booting up. So you might not be able to
reproduce in a different environment.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
