Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF1AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 10:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D0F281431;
	Mon, 21 Feb 2022 10:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ArpyKDIkBLJP; Mon, 21 Feb 2022 10:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6CC8981422;
	Mon, 21 Feb 2022 10:05:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 240FCC0021;
	Mon, 21 Feb 2022 10:05:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57935C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 10:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37B74408C5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 10:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gTCpk_ah9y1K
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 10:05:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27516408F0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645437909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a7pC/8c3cMpM8i5986p+h+SJ6tgl0KTE+K3MKLjypsA=;
 b=a+YHmvj2JkDz1PSk69CjjKZ63EWuVTDZKHGwVy0kIoBr3dK8gGqFdjBfAxfU05OKBHyxm4
 EuiUPlSllFywGADvNUcxvqT/giAfnMflJMQBZk0A7JkRJ6pNXVrBKDTJLRwq5lr6YmZtQW
 BEvi4tCTWoDMuA+xvu6LDRa9edZNecU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-OC53FuTlMF2O0iXyBcZ-Kw-1; Mon, 21 Feb 2022 05:05:05 -0500
X-MC-Unique: OC53FuTlMF2O0iXyBcZ-Kw-1
Received: by mail-wr1-f72.google.com with SMTP id
 p18-20020adfba92000000b001e8f7697cc7so5161158wrg.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 02:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a7pC/8c3cMpM8i5986p+h+SJ6tgl0KTE+K3MKLjypsA=;
 b=nd/P21ayZhEzlEsQl8jPmiRxRyJNMQ0hMzAzAq44ZiChP4dcVaAv0mZOvsNCAEc7hd
 JYrRcnrqBYtSQx0RcFDmxxQuM6RnPxkApeDHHFcYHuVRQJKJrLmNNZftGwhQ5tNwvxPp
 qvf9Jv4gzMjk0HLsmKAP/w0+La3wgAWEkrh23jeKMHgxK78fUm47KtbS+kbR5PjSVT1l
 mIdgwcCwaRt63vzTbxen8Q9lvC0UXEpqjR2J+bVdCwx114m580sYqepVDZYISf1IqrQW
 jwS6EmFGGVRvIbpbxM80+EX4z5McJE8YiQZn9lFT6qNf4R3oovpOaIJ0QtiLwEIVC6YU
 slsw==
X-Gm-Message-State: AOAM531qMgklmL7QPxhOCz0waXX679mifgFogzctUUL+QgYN5HPCye9n
 BvDa3xya268gz4ULV1xOX9rJ22PhVflV/BmnV1GJws8OEgNcGctUrcTRuyXsGakFmuuTaOguyYw
 lNPDM56iBbViedXPdmH3KhVFc9vIGr3M1XUfJCEOYeA==
X-Received: by 2002:adf:cf12:0:b0:1e3:25ac:7b25 with SMTP id
 o18-20020adfcf12000000b001e325ac7b25mr15345143wrj.196.1645437904146; 
 Mon, 21 Feb 2022 02:05:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvL0v2ye0HlLbbizXym02UGy3yMeTg2IZU57hEMg6++fpRjZHeoaP1iJDYrJhnJl0FoOTdYg==
X-Received: by 2002:adf:cf12:0:b0:1e3:25ac:7b25 with SMTP id
 o18-20020adfcf12000000b001e325ac7b25mr15345112wrj.196.1645437903844; 
 Mon, 21 Feb 2022 02:05:03 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id w18sm32300769wrl.62.2022.02.21.02.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 02:05:03 -0800 (PST)
Date: Mon, 21 Feb 2022 11:05:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] WARNING in vhost_dev_cleanup (2)
Message-ID: <20220221100500.2x3s2sddqahgdfyt@sgarzare-redhat>
References: <0000000000006f656005d82d24e2@google.com>
 <CACGkMEsyWBBmx3g613tr97nidHd3-avMyO=WRxS8RpcEk7j2=A@mail.gmail.com>
 <20220217023550-mutt-send-email-mst@kernel.org>
 <CACGkMEtuL_4eRYYWd4aQj6rG=cJDQjjr86DWpid3o_N-6xvTWQ@mail.gmail.com>
 <20220217024359-mutt-send-email-mst@kernel.org>
 <CAGxU2F7CjNu5Wxg3k1hQF8A8uRt-wKLjMW6TMjb+UVCF+MHZbw@mail.gmail.com>
 <0b2a5c63-024b-b7a5-e4d1-aa12390bdd38@oracle.com>
 <a5fca5da-c139-b9bb-1929-d7621c06163d@oracle.com>
MIME-Version: 1.0
In-Reply-To: <a5fca5da-c139-b9bb-1929-d7621c06163d@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot <syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com>,
 kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Fri, Feb 18, 2022 at 12:23:10PM -0600, Mike Christie wrote:
>On 2/18/22 11:53 AM, Mike Christie wrote:
>> On 2/17/22 3:48 AM, Stefano Garzarella wrote:
>>>
>>> On Thu, Feb 17, 2022 at 8:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Thu, Feb 17, 2022 at 03:39:48PM +0800, Jason Wang wrote:
>>>>> On Thu, Feb 17, 2022 at 3:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>
>>>>>> On Thu, Feb 17, 2022 at 03:34:13PM +0800, Jason Wang wrote:
>>>>>>> On Thu, Feb 17, 2022 at 10:01 AM syzbot
>>>>>>> <syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com> wrote:
>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> syzbot found the following issue on:
>>>>>>>>
>>>>>>>> HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.org..
>>>>>>>> git tree:       upstream
>>>>>>>> console output: https://urldefense.com/v3/__https://syzkaller.appspot.com/x/log.txt?x=132e687c700000__;!!ACWV5N9M2RV99hQ!fLqQTyosTBm7FK50IVmo0ozZhsvUEPFCivEHFDGU3GjlAHDWl07UdOa-t9uf9YisMihn$
>>>>>>>> kernel config:  https://urldefense.com/v3/__https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912__;!!ACWV5N9M2RV99hQ!fLqQTyosTBm7FK50IVmo0ozZhsvUEPFCivEHFDGU3GjlAHDWl07UdOa-t9uf9RjOhplp$
>>>>>>>> dashboard link: https://urldefense.com/v3/__https://syzkaller.appspot.com/bug?extid=1e3ea63db39f2b4440e0__;!!ACWV5N9M2RV99hQ!fLqQTyosTBm7FK50IVmo0ozZhsvUEPFCivEHFDGU3GjlAHDWl07UdOa-t9uf9bBf5tv0$
>>>>>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>>>>>>>
>>>>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>>>>>>
>>>>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>>>>> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
>>>>>>>>
>>>>>>>> WARNING: CPU: 1 PID: 10828 at drivers/vhost/vhost.c:715 vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
>>>>>>>> Modules linked in:
>>>>>>>> CPU: 0 PID: 10828 Comm: syz-executor.0 Not tainted 5.17.0-rc4-syzkaller-00051-gc5d9ae265b10 #0
>>>>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>>>>>>> RIP: 0010:vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
>>>>>>>
>>>>>>> Probably a hint that we are missing a flush.
>>>>>>>
>>>>>>> Looking at vhost_vsock_stop() that is called by vhost_vsock_dev_release():
>>>>>>>
>>>>>>> static int vhost_vsock_stop(struct vhost_vsock *vsock)
>>>>>>> {
>>>>>>> size_t i;
>>>>>>>         int ret;
>>>>>>>
>>>>>>>         mutex_lock(&vsock->dev.mutex);
>>>>>>>
>>>>>>>         ret = vhost_dev_check_owner(&vsock->dev);
>>>>>>>         if (ret)
>>>>>>>                 goto err;
>>>>>>>
>>>>>>> Where it could fail so the device is not actually stopped.
>>>>>>>
>>>>>>> I wonder if this is something related.
>>>>>>>
>>>>>>> Thanks
>>>>>>
>>>>>>
>>>>>> But then if that is not the owner then no work should be running, right?
>>>>>
>>>>> Could it be a buggy user space that passes the fd to another process
>>>>> and changes the owner just before the mutex_lock() above?
>>>>>
>>>>> Thanks
>>>>
>>>> Maybe, but can you be a bit more explicit? what is the set of
>>>> conditions you see that can lead to this?
>>>
>>> I think the issue could be in the vhost_vsock_stop() as Jason mentioned,
>>> but not related to fd passing, but related to the do_exit() function.
>>>
>>> Looking the stack trace, we are in exit_task_work(), that is called
>>> after exit_mm(), so the vhost_dev_check_owner() can fail because
>>> current->mm should be NULL at that point.
>>>
>>> It seems the fput work is queued by fput_many() in a worker queue, and
>>> in some cases (maybe a lot of files opened?) the work is still queued
>>> when we enter in do_exit().
>> It normally happens if userspace doesn't do a close() when the VM
>
>Just one clarification. I meant to say it "always" happens when userspace
>doesn't do a close.
>
>It doesn't have anything to do with lots of files or something like that.
>We are actually running the vhost device's release function from
>do_exit->task_work_run and so all those __fputs are done from something
>like qemu's context (current == that process).
>
>We are *not* hitting the case:
>
>do_exit->exit_files->put_files_struct->filp_close->fput->fput_many
>
>and then in there hitting the schedule_delayed_work path. For that
>the last __fput would be done from a workqueue thread and so the current
>pointer would point to a completely different thread.
>
>
>
>> is shutdown and instead let's the kernel's reaper code cleanup. The qemu
>> vhost-scsi code doesn't do a close() during shutdown and so this is our
>> normal code path. It also happens when something like qemu is not
>> gracefully shutdown like during a crash.
>>
>> So fire up qemu, start IO, then crash it or kill 9 it while IO is still
>> running and you can hit it.

Thank you very much for this detailed explanation!

>>
>>>
>>> That said, I don't know if we can simply remove that check in
>>> vhost_vsock_stop(), or check if current->mm is NULL, to understand if
>>> the process is exiting.
>>>
>>
>> Should the caller do the vhost_dev_check_owner or tell vhost_vsock_stop
>> when to check?
>>
>> - vhost_vsock_dev_ioctl always wants to check for ownership right?
>>
>> - For vhost_vsock_dev_release ownership doesn't matter because we
>> always want to clean up or it doesn't hurt too much.
>>
>> For the case where we just do open then close and no ioctls then
>> running vhost_vq_set_backend in vhost_vsock_stop is just a minor
>> hit of extra work. If we've done ioctls, but are now in
>> vhost_vsock_dev_release then we know for the graceful and ungraceful
>> case that nothing is going to be accessing this device in the future
>> and it's getting completely freed so we must completely clean it up.

Yep, I think the easiest way is to add a parameter to vhost_vsock_stop() 
to tell when to call vhost_dev_check_owner() or not.  This is because 
dev->mm is protected by dev->mutex, acquired in vhost_vsock_stop().

I will send a patch right away, it would be great if you can review.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
