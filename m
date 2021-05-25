Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3722C2B9F8
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 17:24:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630B661417
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 17:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630B661417
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E0CC60B20;
	Tue, 25 May 2021 17:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id of1LZ_LP-tRP; Tue, 25 May 2021 17:24:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B34C4600BA;
	Tue, 25 May 2021 17:24:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A213C000E;
	Tue, 25 May 2021 17:24:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64DF2C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 17:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 471374047D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 17:24:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="ibvfbXRH";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="ykSpQFyT"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e5LFF9s6rdbL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 17:24:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47F49401F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 17:24:25 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621963462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8jZJtlCctlz4NX7pE+UiAv7dDWXJgGKttx44dP5P1I=;
 b=ibvfbXRHCkAns9UDhXGZ5oxkv/wnoGPdUrZmYoyqkOnDHKJjxtsmP6Eg/zxpjLuveqoZbv
 5h0zK9xCZ7UxOnTM247pXnIPuMS7/LRQsdPCrf6jFQhcBJY1J8lfIDLkMveB9dCrdgKm7n
 WUeTTqXNyCmBujAuDjqlNuLRY5i+vAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621963462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8jZJtlCctlz4NX7pE+UiAv7dDWXJgGKttx44dP5P1I=;
 b=ykSpQFyTV26JJMAK4L/6sslYrzqbNv08eKFk3eQqZDSF66FgOvODqVfZPLoP16UoRy2RZz
 p5351AZNqoolDtBw==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C4845AF33;
 Tue, 25 May 2021 17:24:22 +0000 (UTC)
Subject: Re: [RFC] virtio_scsi: to poll and kick the virtqueue in timeout
 handler
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Dongli Zhang <dongli.zhang@oracle.com>
References: <20210523063843.1177-1-dongli.zhang@oracle.com>
 <ac161748-15d2-2962-402e-23abca469623@suse.de>
 <YKupFeOtc6Pr5KS2@stefanha-x1.localdomain>
 <a0404035-2ab7-6b9c-f393-0bb0417c4b3d@oracle.com>
 <YK0qKMF0I8Wm1euN@stefanha-x1.localdomain>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1184a5ac-bbb4-a89d-b5e2-ee0bf58cd1b8@suse.de>
Date: Tue, 25 May 2021 19:24:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YK0qKMF0I8Wm1euN@stefanha-x1.localdomain>
Content-Language: en-US
Cc: srinivas.eeda@oracle.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, mst@redhat.com, joe.jin@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, pbonzini@redhat.com, junxiao.bi@oracle.com,
 jejb@linux.ibm.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 5/25/21 6:47 PM, Stefan Hajnoczi wrote:
> On Mon, May 24, 2021 at 11:33:33PM -0700, Dongli Zhang wrote:
>> On 5/24/21 6:24 AM, Stefan Hajnoczi wrote:
>>> On Sun, May 23, 2021 at 09:39:51AM +0200, Hannes Reinecke wrote:
>>>> On 5/23/21 8:38 AM, Dongli Zhang wrote:
>>>>> This RFC is to trigger the discussion about to poll and kick the
>>>>> virtqueue on purpose in virtio-scsi timeout handler.
>>>>>
>>>>> The virtio-scsi relies on the virtio vring shared between VM and host.
>>>>> The VM side produces requests to vring and kicks the virtqueue, while=
 the
>>>>> host side produces responses to vring and interrupts the VM side.
>>>>>
>>>>> By default the virtio-scsi handler depends on the host timeout handler
>>>>> by BLK_EH_RESET_TIMER to give host a chance to perform EH.
>>>>>
>>>>> However, this is not helpful for the case that the responses are avai=
lable
>>>>> on vring but the notification from host to VM is lost.
>>>>>
>>>> How can this happen?
>>>> If responses are lost the communication between VM and host is broken,=
 and
>>>> we should rather reset the virtio rings themselves.
>>>
>>> I agree. In principle it's fine to poll the virtqueue at any time, but I
>>> don't understand the failure scenario here. It's not clear to me why the
>>> device-to-driver vq notification could be lost.
>>>
>>
>> One example is the CPU hotplug issue before the commit bf0beec0607d ("bl=
k-mq:
>> drain I/O when all CPUs in a hctx are offline") was available. The issue=
 is
>> equivalent to loss of interrupt. Without the CPU hotplug fix, while NVMe=
 driver
>> relies on the timeout handler to complete inflight IO requests, the PV
>> virtio-scsi may hang permanently.
>>
>> In addition, as the virtio/vhost/QEMU are complex software, we are not a=
ble to
>> guarantee there is no further lost of interrupt/kick issue in the future=
. It is
>> really painful if we encounter such issue in production environment.
> =

> Any number of hardware or software bugs might exist that we don't know
> about, yet we don't pre-emptively add workarounds for them because where
> do you draw the line?
> =

> I checked other SCSI/block drivers and found it's rare to poll in the
> timeout function so there does not seem to be a consensus that it's
> useful to do this.
> =

Not only this; it's downright dangerous attempting to do that in SCSI.
In SCSI we don't have fixed lifetime guarantees that NVMe has, so there =

will be a race condition between timeout and command completion.
Plus there is no interface in SCSI allowing to 'poll' for completions in =

a meaningful manner.

> That said, it's technically fine to do it, the virtqueue APIs are there
> and can be used like this. So if you and others think this is necessary,
> then it's a pretty small change and I'm not against merging a patch like
> this.
> =

I would rather _not_ put more functionality into the virtio_scsi timeout =

handler; this only serves to assume that the timeout handler has some =

functionality in virtio.
Which it patently hasn't, as the prime reason for a timeout handler is =

to _abort_ a command, which we can't on virtio.
Well, we can on virtio, but qemu as the main user will re-route the I/O =

from virtio into doing async-I/O, and there is no way how we can abort =

outstanding asynchronous I/O.
Or any other ioctl, for that matter.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
HRB 36809 (AG N=FCrnberg), Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
