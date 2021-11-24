Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F64C433EF
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 01:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 155BA8186B;
	Wed, 24 Nov 2021 01:42:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t3JcCKSRIsbh; Wed, 24 Nov 2021 01:42:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A3D4881852;
	Wed, 24 Nov 2021 01:42:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 744F6C002E;
	Wed, 24 Nov 2021 01:42:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B29BC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 01:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA0118186B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 01:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z3_1dr4OG5DS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 01:42:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0000A81852
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 01:42:39 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HzNmQ6WlVz4xd8;
 Wed, 24 Nov 2021 12:32:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1637717559;
 bh=StwGzFhMGIPHAukmYeKeJosKoihe3KiFUMFiWnca8oc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=p7cnKYEJoC3ARYa1AnP2faJU3R82OGf1x8ED7XCHToBDc7gzUo2zUzLGZ902dwuQW
 OG8LtV1cnTCWqnyovaqhIArrUQrQVDKkdF2JW3pyLxmKMUDhNoGQjCEIjUOftltdkf
 o9K3ftruCkM+doHf9pPzc3EMqoFzwA/izPwdn9zjh9aAnTm7GdbqrTgD/3MrV/L4Hi
 Tgs4nQSErg6vG/mcWxqYT5kcR1RJlFR5VrIiWcA7nRFJWSfbn/6D0as7CZtYgAdmSa
 eWcDZ0J2U5x10gcplKS4TP1yMXCRUYsI0wnpD+V/A/1jDLavhqfhm1dR6PrH70WvVe
 91xTcuHeIMU7Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: update_balloon_size_func blocked for more than 120 seconds
In-Reply-To: <CADFyXm5DroJqhQVVxUcN8yqa8DLWRRDi0sQWGz7u-LMYg3JVyw@mail.gmail.com>
References: <YY2duTi0wAyAKUTJ@bombadil.infradead.org>
 <CADFyXm5DroJqhQVVxUcN8yqa8DLWRRDi0sQWGz7u-LMYg3JVyw@mail.gmail.com>
Date: Wed, 24 Nov 2021 12:32:38 +1100
Message-ID: <87wnkypccp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
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

David Hildenbrand <david@redhat.com> writes:
> On Thu, Nov 11, 2021 at 11:49 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> I get the following splats with a kvm guest in idle, after a few seconds
>> it starts:
>>
>> [  242.412806] INFO: task kworker/6:2:271 blockedfor more than 120 seconds.
>> [  242.415790]       Tainted: G            E     5.15.0-next-20211111 #68
>> [  242.417755] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  242.418332] task:kworker/6:2     state:D stack:    0 pid:  271 ppid: 2 flags:0x00004000
>> [  242.418954] Workqueue: events_freezable update_balloon_size_func [virtio_balloon]
>> [  242.419518] Call Trace:
>> [  242.419709]  <TASK>
>> [  242.419873]  __schedule+0x2fd/0x990
>> [  242.420142]  schedule+0x4e/0xc0
>> [  242.420382]  tell_host+0xaa/0xf0 [virtio_balloon]
>> [  242.420757]  ? do_wait_intr_irq+0xa0/0xa0
>> [  242.421065]  update_balloon_size_func+0x2c9/0x2e0 [virtio_balloon]
>> [  242.421527]  process_one_work+0x1e5/0x3c0
>> [  242.421833]  worker_thread+0x50/0x3b0
>> [  242.422204]  ? rescuer_thread+0x370/0x370
>> [  242.422507]  kthread+0x169/0x190
>> [  242.422754]  ? set_kthread_struct+0x40/0x40
>> [  242.423073]  ret_from_fork+0x1f/0x30
>> [  242.423347]  </TASK>
>>
>> And this goes on endlessly. The last one says it blocked for more than 1208
>> seconds. This was not happening until the last few weeks but I see no
>> relevant recent commits for virtio_balloon, so the related change could
>> be elsewhere.
>
> We're stuck somewhere in:
>
> wq: update_balloon_size_func()->fill_balloon()->tell_host()
>
> Most probably in wait_event().
>
>
> I am no waitqueue expert, but my best guess would be that we're
> waiting more than 2 minutes
> on a host reply with TASK_UNINTERRUPTIBLE. At least that's my interpretation,
>
> In case we're really stuck for more than 2 minutes, the hypervisor
> might not be processing our
> requests anymore -- or it's not getting processed for some other reason (or the
> waitqueue is not getting woken up due do some other BUG).
>
> IIUC, we can sleep longer via wait_event_interruptible(), TASK_UNINTERRUPTIBLE
> seems to be the issue that triggers the warning. But by changing that
> might just be hiding the fact that
> we're waiting more than 2 minutes on a reply.
>
>>
>> I could bisect but first I figured I'd check to see if someone already
>> had spotted this.
>
> Bisecting would be awesome, then we might at least know if this is a
> guest or a hypervisor issue.

I see this on ppc64le also.

I bisected it to:

  # first bad commit: [939779f5152d161b34f612af29e7dc1ac4472fcf] virtio_ring: validate used buffer length

I also reported it in the thread hanging off that patch:

  https://lore.kernel.org/lkml/87zgpupcga.fsf@mpe.ellerman.id.au/


cheers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
