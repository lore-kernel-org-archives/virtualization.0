Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10624C00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 10:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9476B40B39;
	Wed, 24 Aug 2022 10:32:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9476B40B39
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=nJDCv5Mv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZc6F-XOd3if; Wed, 24 Aug 2022 10:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2981A40105;
	Wed, 24 Aug 2022 10:32:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2981A40105
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F13FDC0033;
	Wed, 24 Aug 2022 10:32:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB8C5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 10:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 985694161F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 10:32:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 985694161F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=nJDCv5Mv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id amN64Y89Cu7d
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 10:32:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 450324161B
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 450324161B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 10:32:25 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id p18so15282607plr.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=QWUjYv3PAw2KKCyPciqDmHL/Uykg4GB+YSwET4kKU00=;
 b=nJDCv5MvoV0tFC/H3nF+Gz0GopUobrV3w0Ealf+DCSHZlGsDOJ0IegwLJ4lNyY3cnh
 g/E/DcbsAgk1iRNJEt1HPIBC+tJPYHh2VnEc3yN+iSFqyN2evtCOV6dKRb04HlGyuDdd
 txA719m8owNQgtAukY/d/zpDvqlMpSnFEwsG/inJhls30lsVvhjRdY/5wN54jasu4Q2z
 vMtzFlpCg/i+WrGML0TioobFNBZN5suZxZWUkVJkTumSZEuoa2sohBIV/tVkfeC+C7Rd
 0l3RGY8aLlQIFqjbM1R/Krzs8M+hO5wjTlYK8jHw4yHNAyu7+v8DIIqvYjMKzlTvQ4Qz
 wXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=QWUjYv3PAw2KKCyPciqDmHL/Uykg4GB+YSwET4kKU00=;
 b=sPJjGrkaEmsHgbLtZZfA3n7Nz+fIml/LR1tZvyDZVaSQkttm4zUSzEU6vKhXEXJNZ5
 qXtw2C5/oANauNYeoPtkEx0qTB4ThKTQJaCwGQ1gYjIHyXWKhg51u1mEuaLfsQt0r16t
 B6E7W21WM/Bb8zaOzbozF68MmDrozsTSXqH2uqLu+EWfv/llaHInMVmD8xW8UAC7xWuu
 jX+kFuVTFksXWtd3nNYAYaBS0MSPWNvKk4K3XasqUIB2E4C+BA7hpaXSkqqdTD8CGOCA
 TxGKzxV3rl6jS5ClYD6iJwZvyCSWeVQWwF4XQieKfR+2w75gXN2GFtEpy2POufKaw1eF
 QnQA==
X-Gm-Message-State: ACgBeo2zDSC5OKiMG+KNNqoOWL9J/OrnY46QN2Xn7DWjEmxd2axrIIZs
 jc9sf4SwODooSO3MnIZW/ETho578q++wDTE6TVGBzQ==
X-Google-Smtp-Source: AA6agR541X6poo1EF9l2XLD43XPikHFSPir3d3LNvMU5R5S466mUKrGdbYni6ROFlx7lLW7855cacbT0lPW8BmdMCfk=
X-Received: by 2002:a17:903:1ce:b0:16f:1c1f:50e5 with SMTP id
 e14-20020a17090301ce00b0016f1c1f50e5mr28972884plh.132.1661337144501; Wed, 24
 Aug 2022 03:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs=3_DJ8x5h98WBbXhzxVx+D6pqpBkCrBHXa_7ApqYO4vGDpQ@mail.gmail.com>
 <CACGkMEuQBLpaW6-tD3oqR90ya5=js6DJ=pHiOJmG2SOt-6ycpA@mail.gmail.com>
 <2ff3d36b-f044-71cc-8001-d7f4073282c1@suse.de>
 <CAJs=3_AUiaDtyRTMcDd_DGuiKZVKuMUSZRUosQa7wU=5UZwtqw@mail.gmail.com>
 <f0406458-319d-129b-655f-11343d99743d@suse.de>
In-Reply-To: <f0406458-319d-129b-655f-11343d99743d@suse.de>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 24 Aug 2022 13:31:48 +0300
Message-ID: <CAJs=3_BghDrTikawORaSwoJZYq_E-39zBqzuLEP2LTYaSWsKWw@mail.gmail.com>
Subject: Re: Virtio-net - add timeouts to control commands
To: Hannes Reinecke <hare@suse.de>
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

> No. The server may only assume that the command failed until it gets the
> response for the abort command.
> Before that the state of the command is undefined, and the server may
> not assume anything here.


You're right, but the device will think that the command succeeded, so
it may send packets in a queue that is not expected by the server.
I'm referring to the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.

Don't you think that as a quick fix, adding a big enough timeout is an
adequate solution (for virtio net control commands)?
The big timeout ensures that when the control command is not answered,
it is because of some crash/bug in the network device (which acts as
the hypervisor).
This way, we can detect the crash/bug and reset/remove the device.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
