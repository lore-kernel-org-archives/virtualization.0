Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7B3C04A6A
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 18:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AC6C41DF1;
	Thu, 10 Aug 2023 18:57:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AC6C41DF1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTjlcDRc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9DQpgx2JSZG0; Thu, 10 Aug 2023 18:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F88F41DF4;
	Thu, 10 Aug 2023 18:57:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F88F41DF4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 378F8C0072;
	Thu, 10 Aug 2023 18:57:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50951C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 18:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29C1A40612
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 18:57:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29C1A40612
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZTjlcDRc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id blYSnxl0H7HO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 18:57:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7783400DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 18:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7783400DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691693832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qcj+tDm8JEghFQmSsjSMzUhYwNpXARHk6T+1xXCWR28=;
 b=ZTjlcDRcfA403xLt2b3JOKPLiKlq7Fsz65I4sNeROudqWHLeJZjaQ1OcHU5yVbz/KAYWOx
 0o+aCRj7sHvaAHEwV80pcMQq2BFLUCMCldea6VQgz8ydWchOMZRCFoF9J+XntF9dbWVFab
 q+GGU2021eykvB7wqsNRc+oJefsZXX0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-WPrlTnYkPZWyzHXRrIKmwQ-1; Thu, 10 Aug 2023 14:57:09 -0400
X-MC-Unique: WPrlTnYkPZWyzHXRrIKmwQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fe4a1ce065so1203811e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 11:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691693827; x=1692298627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcj+tDm8JEghFQmSsjSMzUhYwNpXARHk6T+1xXCWR28=;
 b=RMau7EdONvZ14j+dRnFk0RN/HUUvIny5hDUtI7cJlS+aX+/rk/L2whIQVu+R4Gbpiy
 2Vz7zfo/03oFEKKOau9ixvbbo9nzALbxTRQLTnzZml75TxptGH+Y4tZkeCCpVoFn7enz
 immtr14JyrJVxZj5b6+B0O5n6NdRJ48sgW3zmwLE2PfhvtxANm3IJ4RdTGVcsSfh5nKz
 sL5mhjJgxBXInKSCVm1VvQMcQ5j1MCh49XCgP0jsS/bea86z26b7S94eUUbDG/I5GBkQ
 6uaF654jVHWEgkpo1kM2T5aTLXw7h8X2pLqZEvVkkpPj1VfP8etpJ/odRyuQmSYZB5wy
 N0vg==
X-Gm-Message-State: AOJu0Yx/rNaI4apxKCBFNdvyrYvjbUTbk8tSVsp8+TXIdkjLiRRK/h7g
 klDs7XzTLgTzKSNSVd/BWHLl9IzEjdXmqLTwSx2qqOWhcwiK+shNbxv2F36jN0MrweJv7Vkoi5M
 Qq75PusMbZwV7QYNe93x5OSWI5xTHSxCm33IcA7vdVQ==
X-Received: by 2002:a05:6512:3e06:b0:4f8:4512:c844 with SMTP id
 i6-20020a0565123e0600b004f84512c844mr3345571lfv.48.1691693827603; 
 Thu, 10 Aug 2023 11:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjOQhPtdsz07nsN78L6/m9BnGD+oeQzzTg0A1y1+etFBqOapEHl8thpyvELgSFyQLw02rLAA==
X-Received: by 2002:a05:6512:3e06:b0:4f8:4512:c844 with SMTP id
 i6-20020a0565123e0600b004f84512c844mr3345550lfv.48.1691693827235; 
 Thu, 10 Aug 2023 11:57:07 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 n13-20020aa7c68d000000b005231e1780aasm1116137edq.91.2023.08.10.11.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 11:57:06 -0700 (PDT)
Date: Thu, 10 Aug 2023 14:57:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230810145528-mutt-send-email-mst@kernel.org>
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
> 
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


Mike I'm unsure what to do at this point. Regressions are not nice
but if the kernel is released with the new userspace api we won't
be able to revert. So what's the plan?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
