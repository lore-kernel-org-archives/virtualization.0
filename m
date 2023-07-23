Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838A0C001B0
	for <virtualization@archiver.kernel.org>; Sun, 23 Jul 2023 09:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D3B9414E2;
	Sun, 23 Jul 2023 09:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D3B9414E2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIzGy9GZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ryionfBFqgbE; Sun, 23 Jul 2023 09:31:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E197540869;
	Sun, 23 Jul 2023 09:31:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E197540869
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C45A8C0071;
	Sun, 23 Jul 2023 09:31:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C484CC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A8D260B2B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:31:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A8D260B2B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIzGy9GZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GxzgFYpMXJRr
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:31:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25DEC60A5D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 09:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25DEC60A5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690104710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KnP1FvRt/WmVmVKNFuWV7tALXDgfHjSQsYEKOT5cUds=;
 b=EIzGy9GZQN5LQrZqOrV199AjvLyBgZCXMaRKHytiUtYyM5/X1Fyf3X73EJZeTwEo2ceQ37
 DoTvtMBvlISutN6GW2OGfnQbp/M2O9z5su/JxWfYoxUgBRoVHpDQuu2Y7bLjFo+qHK8Qzg
 ox6E79F9ILD7NvkegGD9LWbLhTNQf9A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-bkxWNC7tNwCQUcmDR3ScDA-1; Sun, 23 Jul 2023 05:31:48 -0400
X-MC-Unique: bkxWNC7tNwCQUcmDR3ScDA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-314134f403fso1565988f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jul 2023 02:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104707; x=1690709507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnP1FvRt/WmVmVKNFuWV7tALXDgfHjSQsYEKOT5cUds=;
 b=WUvGPvxr5LnQ5x2b7fXTyuXdD4cTBHek1eA9+au19jDV1G++GMhKAfOZBGQjFa35Eb
 btp0vmNg2nfzyIqYI5GEAPAGyZ+5PgKuTiRwaBfRd5v6faFrSBWlMENQ0u2ZHSotVpEb
 9Djr7EQbz9X4e3II/UqVtnIwtwyf6ZMUxFQjlYNgBvoUZjhkeGSdid47+1+Lo2heKPcz
 3i4tCqPTkoiWcRFOU7eR/mSGzTPHJ6iG9KMItzpNigcd4eLg7f2Zwgys33eTMTmpwJDM
 NQgNxxFCII/t5i+8OC05dnEY5ACDnyhT/GJhB3LdieORG2mwrFg+9KrZXKFoxDttd5xS
 7MjQ==
X-Gm-Message-State: ABy/qLZTsMzBIQxvJKodcMSkWwQKxMb0MZTxynk59MlES1+PNi+EChGh
 crmfGm2uTH6R7oazInXFz50zPaP6aenoeMHakZicTXEWJ/VHGxnTwgVdPGH5hqUDNLIF/3I5g2K
 RfSxbSYqgM18AnxrZVMZnVBIIHN0hzle/zW8Kuj9ybw==
X-Received: by 2002:adf:f283:0:b0:317:58fd:29c6 with SMTP id
 k3-20020adff283000000b0031758fd29c6mr475319wro.70.1690104707786; 
 Sun, 23 Jul 2023 02:31:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpURugFCWXHXOHG4DBWpzYEXSkSGvybDLH/yHQ+5/PVNnyQleFYSKOIOZg4Y7I/rnPhxJO7Q==
X-Received: by 2002:adf:f283:0:b0:317:58fd:29c6 with SMTP id
 k3-20020adff283000000b0031758fd29c6mr475304wro.70.1690104707428; 
 Sun, 23 Jul 2023 02:31:47 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 e18-20020a5d65d2000000b00314172ba213sm9117790wrw.108.2023.07.23.02.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:31:46 -0700 (PDT)
Date: Sun, 23 Jul 2023 05:31:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230723052921-mutt-send-email-mst@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <20230720090415-mutt-send-email-mst@kernel.org>
 <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
MIME-Version: 1.0
In-Reply-To: <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brauner@kernel.org, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, torvalds@linux-foundation.org
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

On Sat, Jul 22, 2023 at 11:03:29PM -0500, michael.christie@oracle.com wrote:
> On 7/20/23 8:06 AM, Michael S. Tsirkin wrote:
> > On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
> >> For vhost workers we use the kthread API which inherit's its values from
> >> and checks against the kthreadd thread. This results in the wrong RLIMITs
> >> being checked, so while tools like libvirt try to control the number of
> >> threads based on the nproc rlimit setting we can end up creating more
> >> threads than the user wanted.
> >>
> >> This patch has us use the vhost_task helpers which will inherit its
> >> values/checks from the thread that owns the device similar to if we did
> >> a clone in userspace. The vhost threads will now be counted in the nproc
> >> rlimits. And we get features like cgroups and mm sharing automatically,
> >> so we can remove those calls.
> >>
> >> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > 
> > Hi Mike,
> > So this seems to have caused a measureable regression in networking
> > performance (about 30%). Take a look here, and there's a zip file
> > with detailed measuraments attached:
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=2222603
> > 
> > 
> > Could you take a look please?
> > You can also ask reporter questions there assuming you
> > have or can create a (free) account.
> > 
> 
> Sorry for the late reply. I just got home from vacation.
> 
> The account creation link seems to be down. I keep getting a
> "unable to establish SMTP connection to bz-exim-prod port 25 " error.
> 
> Can you give me Quan's email?

Thanks for getting back!  I asked whether it's ok to share the email.
For now pasted your request in the bugzilla.

> I think I can replicate the problem. I just need some extra info from Quan:
> 
> 1. Just double check that they are using RHEL 9 on the host running the VMs.
> 2. The kernel config
> 3. Any tuning that was done. Is tuned running in guest and/or host running the
> VMs and what profile is being used in each.
> 4. Number of vCPUs and virtqueues being used.
> 5. Can they dump the contents of:
> 
> /sys/kernel/debug/sched
> 
> and
> 
> sysctl  -a
> 
> on the host running the VMs.
> 
> 6. With the 6.4 kernel, can they also run a quick test and tell me if they set
> the scheduler to batch:
> 
> ps -T -o comm,pid,tid $QEMU_THREAD
> 
> then for each vhost thread do:
> 
> chrt -b -p 0 $VHOST_THREAD
> 
> Does that end up increasing perf? When I do this I see throughput go up by
> around 50% vs 6.3 when sessions was 16 or more (16 was the number of vCPUs
> and virtqueues per net device in the VM). Note that I'm not saying that is a fix.
> It's just a difference I noticed when running some other tests.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
