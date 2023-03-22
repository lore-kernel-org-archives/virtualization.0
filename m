Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D906C76196
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 16:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3F5C417F0;
	Wed, 22 Mar 2023 16:42:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3F5C417F0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ifPGVzli
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZvcduiQfTYRH; Wed, 22 Mar 2023 16:42:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 60C66401F3;
	Wed, 22 Mar 2023 16:42:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60C66401F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3519CC0071;
	Wed, 22 Mar 2023 16:42:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAC11C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 770A5418FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:42:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 770A5418FD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ifPGVzli
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXnhjxI5xmn5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:42:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D4E34096D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D4E34096D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679503345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cC9A56nYy1+m5j88UXEHoA+LJcmsoLgXsOwYg6hVvpA=;
 b=ifPGVzlip0YKEZkqFCD9cPSfxWpiEXR0xNNtkQDCA2SfaQJwc/g6J9h7R/r8M9kfzVkeZD
 Cq3Ad9gcf7pxxf+W22AfH4zqlsrdqiNJI+gx9VgEq8jqXE5QCN3X9gBVGAcYty4WEiyotH
 Mdwl+0dE/NnuglA7oacoORrQ4bLdrHQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-5HfkHJV8NauG4Jivpvuunw-1; Wed, 22 Mar 2023 12:42:22 -0400
X-MC-Unique: 5HfkHJV8NauG4Jivpvuunw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56DB02823822;
 Wed, 22 Mar 2023 16:42:21 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CD47492C13;
 Wed, 22 Mar 2023 16:42:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Viktor Prutyanov <viktor@daynix.com>
Subject: Re: [PATCH v4] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
In-Reply-To: <20230322123121-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230322141031.2211141-1-viktor@daynix.com>
 <20230322123121-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 22 Mar 2023 17:42:20 +0100
Message-ID: <87mt44hh5f.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, yan@daynix.com
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

On Wed, Mar 22 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Mar 22, 2023 at 05:10:31PM +0300, Viktor Prutyanov wrote:
>> According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
>> indicates that the driver passes extra data along with the queue
>> notifications.
>> 
>> In a split queue case, the extra data is 16-bit available index. In a
>> packed queue case, the extra data is 1-bit wrap counter and 15-bit
>> available index.
>> 
>> Add support for this feature for MMIO, channel I/O and modern PCI
>> transports.
>> 
>> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
>> ---
>>  v4: remove VP_NOTIFY macro and legacy PCI support, add
>>     virtio_ccw_kvm_notify_with_data to virtio_ccw
>>  v3: support feature in virtio_ccw, remove VM_NOTIFY, use avail_idx_shadow,
>>     remove byte swap, rename to vring_notification_data
>>  v2: reject the feature in virtio_ccw, replace __le32 with u32
>> 
>>  Tested with disabled VIRTIO_F_NOTIFICATION_DATA on qemu-system-s390x
>>  (virtio-blk-ccw), qemu-system-riscv64 (virtio-blk-device,
>>  virtio-rng-device), qemu-system-x86_64 (virtio-blk-pci, virtio-net-pci)
>>  to make sure nothing is broken.
>>  Tested with enabled VIRTIO_F_NOTIFICATION_DATA on 64-bit RISC-V Linux
>>  and my hardware implementation of virtio-rng.
>
> what did you test? virtio pci? mmio? guessing not ccw...
>
> Cornelia could you hack up something to quickly test ccw?

Hm, I'm not entirely sure how notification data is supposed to be used
in real life -- Viktor, what is your virtio-rng implementation doing;
can this be hacked into all transports?

(Also, if the other ccw folks have something handy, please speak up :)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
