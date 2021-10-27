Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757E9C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 14:34:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E600E60F56
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 14:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E600E60F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97812403D7;
	Wed, 27 Oct 2021 14:34:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvQe36jnCEq0; Wed, 27 Oct 2021 14:34:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5CB734037E;
	Wed, 27 Oct 2021 14:34:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38377C0019;
	Wed, 27 Oct 2021 14:34:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8657FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 14:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75354403AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 14:34:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ArVEudwfdIKw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 14:34:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33B314037E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 14:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635345244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=IJF7PpbqwkPizKxWc/jCpfU55540njJfe60dVlYB+HE=;
 b=ZHVEDrxtEKxUekcvgO581ndGyO/9ggey9rWvLE+bMRIaz45S3af8P+Pi2Sw2yVRj6UFz2X
 OwmKQZup6lARTqh/UhbT06pOfT0olaJagkoXdK8v0OrlsYEYr0Y0Qf3DpWlR3E0KCarRjh
 mcNlZfbZLKTO2pYcIXUuEI4G6xDNbf0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-QHum_K2qOs-gCdqtepKmVw-1; Wed, 27 Oct 2021 10:34:03 -0400
X-MC-Unique: QHum_K2qOs-gCdqtepKmVw-1
Received: by mail-lj1-f198.google.com with SMTP id
 v17-20020a2e7a11000000b002118bb7d585so594302ljc.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=IJF7PpbqwkPizKxWc/jCpfU55540njJfe60dVlYB+HE=;
 b=RBXhwLM5kRNVq7o1L/ImbHCdz2fABykhNfzo+6RaCBi1UVUA6YT6kbIyf/BG0VYOeJ
 vr536HMgoOXR0jgHcsYAun8OI8CtB2leV4HyimmaAybYox4mcUwEeRG+WYLdk3ml2OLu
 P/0+zprVb6FaVZJ7v/ByxP1zHUq56mZYZkwlFrClEjQFgcsDl3Jqs7ZNHkFdMuOTEhJa
 zJqWcQqcvLOycqZQqbxqmKzLlMjt7EmxCjtVdnPoGHWc5SJo3jbTkXoij9vJOGeRR5qD
 uF2xqbOzUkXpyD/5Bwv5SohC6hq0mllkRzteSpeaRn/r93xupYqjAT0olwyDEMTlhOyK
 0Tcg==
X-Gm-Message-State: AOAM531Dg6ADzpiYZa3KrSXts6aeHkcQ8nV+MV1aImtPMO3yBlEraDtC
 8YYRwnVGDyxe9FftHdwXajP/I7wqgLi5usUwkBq25KdCiAkEHhDHDoxbSHRswEQ23PFByK/N/EE
 OgS76lzXJjCGPB7ih93fXIwkyE1pinySg+t5EXnvobrVRhKIh7Z32K8ol6w==
X-Received: by 2002:ac2:5f08:: with SMTP id 8mr28787207lfq.176.1635345242230; 
 Wed, 27 Oct 2021 07:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7St1R/1G48t1BpW5QgbzT5/rvhlmSRpPpDHEmMHJNWCCjIj6vpQcw5JNYL64/46fHQoq/3r1t/ON3qvPO5Rw=
X-Received: by 2002:ac2:5f08:: with SMTP id 8mr28787194lfq.176.1635345242022; 
 Wed, 27 Oct 2021 07:34:02 -0700 (PDT)
MIME-Version: 1.0
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 27 Oct 2021 16:33:50 +0200
Message-ID: <CAGxU2F7r7=P8E-f1Nnm2h18S-hL8YBt7s=J81fkQcrAdpZ-KwQ@mail.gmail.com>
Subject: vDPA bus driver selection
To: Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

Hi folks,
I was trying to understand if we have a way to specify which vDPA bus
driver (e.g. vhost-vdpa, virtio-vdpa) a device should use.
IIUC we don't have it, and the first registered driver is used when a
new device is registered.

I was thinking if it makes sense to extend the management API to
specify which bus driver to use for a device. A use case could be for
example a single host handling VMs and bare-metal containers, so we
would have both virtio-vdpa and vhost-vdpa loaded and we want to
attach some devices to VMs through vhost-vdpa and others to containers
through virtio-vdpa.

What do you think?

I can prepare an RFC with some code, the idea is to use the .match
callback of "struct bus_type" to use a driver instead of the other,
and extend netlink API to specify the vDPA bus driver name to use.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
