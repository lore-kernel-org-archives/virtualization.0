Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65BCC00448
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 03:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1168A60F42;
	Thu, 25 Aug 2022 03:01:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1168A60F42
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GL1MSJUL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MEIvatg1X4V3; Thu, 25 Aug 2022 03:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 84A5660AF1;
	Thu, 25 Aug 2022 03:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84A5660AF1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57EA4C0033;
	Thu, 25 Aug 2022 03:01:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2677BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 03:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3E63831DA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 03:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3E63831DA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GL1MSJUL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yk2mF9z2iq8f
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 03:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C235831A5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C235831A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 03:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661396511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E492f0HHkMYcghK0x25Bpb9Pnfrj7oR4GMzPFAL974Q=;
 b=GL1MSJULLssfioXbmJqpTMQf/q5zBBgt2xV/9QBTKoBIQ1+Y9gApTOi/9yi4A6zYQwezDN
 8HnY8X5guecaPwQFXElPKrTVKueEQqCDCsFhcLcY3TihBhV+JOQ833JzHlwruFsRLnOz3A
 P5Vbymw9foAf/cRWcrEZFIhli3Gimjk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-HqeEaGfnMd6GGM8l-7wG1g-1; Wed, 24 Aug 2022 23:01:50 -0400
X-MC-Unique: HqeEaGfnMd6GGM8l-7wG1g-1
Received: by mail-lf1-f69.google.com with SMTP id
 m6-20020a05651202e600b00492d736eeefso4361985lfq.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 20:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=E492f0HHkMYcghK0x25Bpb9Pnfrj7oR4GMzPFAL974Q=;
 b=k0AwXzy9c7WiXleSNevonvwJ7MIBeg30VTlEa9eLqeWNEg1A9vW6dJ8hB2unCnIPLG
 04vmjx8rz5jMJ4L+iMhrkBZvDeWaJTM3KvQ/5JrAzslUhaXZ0rCF7uj6tVaq/jF34z36
 ZZ4J8G042UKNKzhI9q8tqlJcHsYoMaXwX7mHR/pRUiD+FjpaR9mxBc7kpwA7nXcM/eou
 ouC5lK1pRwDz/k6ZmtJLyVmbUyrNXMe4C8c+fq/8rDnzJ4r1Mre5M7UhwhvWUbZGyhgd
 1KadDp4CPP1T5g5Qd/03oRCegWR79eENvUpOoFJnqCers441uvQCx9irayuCA+zlgYSY
 oZRg==
X-Gm-Message-State: ACgBeo26CeAXrSM2aMWpHP/5yvjAuRpkypO9s/BEj2Lw+n9uWYm9QiLn
 TEk6S9HOJ9E3a2a9Y7KLAjNanmA0RV6eWfTyMjXyo0ZcFXlySvty1f/D7yqEoUXMbWHxL0UueFq
 vn9RU2OnQL9diruMi0yyxs5XLschupu75FUX3Ow5EHgCuZKkfOoBmlSzlRA==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr480407lfa.124.1661396508994; 
 Wed, 24 Aug 2022 20:01:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5VCMWjvPRxyj+8VdLBKVxOBpgDULB805ZtSN8S5WWLszxzgfkAKFwkqX6nPWQsf7u6IkA+XZ2rjAVAhWo1gn8=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr480402lfa.124.1661396508820; Wed, 24
 Aug 2022 20:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
 <2ff3d36b-f044-71cc-8001-d7f4073282c1@suse.de>
 <CAJs=3_AUiaDtyRTMcDd_DGuiKZVKuMUSZRUosQa7wU=5UZwtqw@mail.gmail.com>
In-Reply-To: <CAJs=3_AUiaDtyRTMcDd_DGuiKZVKuMUSZRUosQa7wU=5UZwtqw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Aug 2022 11:01:37 +0800
Message-ID: <CACGkMEvsQb6RY-0MZSa9Crjt7BAONHrLOV6HBpSENftpUCXrVQ@mail.gmail.com>
Subject: Re: Virtio-net - add timeouts to control commands
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Aug 24, 2022 at 5:43 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> Hi Hannes,
>
> > a) let the device do the timeout: pass in a timeout value with the
> > command, and allow the device to return an ETIMEDOUT error when the
> > timeout expires. Then it's up to the device to do the necessary timeout
> > handling; the server won't be involved at all (except for handling an
> > ETIMEDOUT error)
>
>
> This won't work if the device crashes.

Yes, from the view of the hardening. Driver should not trust/depend on
device behaviour.

>
> >
> > b) implement an 'abort' command. With that the server controls the
> > timeout, and is allowed to send an 'abort' command when the timeout
> > expires. That requires the device to be able to abort commands (which
> > not all devices are able to), but avoids having to implement a timeout
> > handling in the device.
>
>
> I actually thought about this idea.
> This may work, but you'll still have a few moments when the server
> assumes that the command failed, and the network device assumes that
> it succeeded.
> So the server may still receive packets in an unexpected queue.

Similar to the previous case. Driver should not trust the device to
execute any command correctly.

>
>
> >
> > I am very much in favour of having timeouts for virtio commands; we've
> > had several massive customer escalations which could have been solved if
> > we were able to set the command timeout in the VM.
> > As this was for virtio-scsi/virtio-block I would advocate to have a
> > generic virtio command timeout, not a protocol-specific one.
>
> This may be difficult to implement.
> Especially when multiple commands may be queued at the same time, and
> the device can handle the commands in any order.
> We'll need to add identifiers for every command.

Having a timeout that is under the control of the driver might be
possible. Anyhow this needs to be discussed in the virtio-dev.

Thanks

>
> I'm actually referring here to the Linux kernel implementation of
> virtnet control commands, in which the server spins for a response.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
