Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D9C00A89
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 16:04:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D127620724
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 16:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pnfb5at3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D127620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 419BF85319;
	Fri, 30 Oct 2020 16:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rI-sGnsxEbLp; Fri, 30 Oct 2020 16:04:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5391869D7;
	Fri, 30 Oct 2020 16:04:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F041C0859;
	Fri, 30 Oct 2020 16:04:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF39C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 16:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7B40A8739C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 16:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLhKoXtql+HS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 16:04:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3FF1C872E1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604073858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZOY0se4WQ8x55VAXnO7UrS7S0TCfPfbJZdpu+fnITnI=;
 b=Pnfb5at3wzP25d3N2wX/6LuxyqwXP81gQfnZi31h6U0+LcSaaezetG8UVRGNHEAnw0/Zt0
 IuT5yGOuPGMZGFGV7aiE348Xh3bjmllIuShcydsQfwWZg/+EvydX/tcN4qz8p9f74DM6oE
 OS+TLedXnfBVXQk0czuRM7EEwoSbkiE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-BuQ4c6zCOPefMsLIBlBpBw-1; Fri, 30 Oct 2020 12:04:16 -0400
X-MC-Unique: BuQ4c6zCOPefMsLIBlBpBw-1
Received: by mail-ej1-f72.google.com with SMTP id c10so2616098ejm.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 09:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZOY0se4WQ8x55VAXnO7UrS7S0TCfPfbJZdpu+fnITnI=;
 b=MIphk/b1hvbMAMKa7Iyg6/Sw7l/gtcgft8fS12YlPCNPGnzGZyEVDjeiiRgsauAWuT
 4/c+/PstqWUFCz2yZosOQVFLsN6KBnspszlIvxxMtk5fwkq+JRjmL4aIayXKEKtmuZow
 Iuq1wkqqeEyGauS+4PADzN76Yopgt2SEjkWhBQYVnciVkzp24b12M/fqmccNhVnhmITd
 cRHBvz60Xd379r23cX4ylAaRpy0PlO8YvPTPQHkAiKEvH7x/FYu/9aYJyu1nkv+28g69
 bH82sSPX8BfZ5/PvTvW0ErETSFi7476h34X/02daEs96lKxSH1jBY/cJP7W4ScP/ixbE
 pkRA==
X-Gm-Message-State: AOAM532r8Hq6ozwe7mg8jhLb0mWqZsr5mQhdzsG+WJSxoqw3Gxx1hO8l
 Hv+qMz2LmDOpCnGrylbRgwtyMxW9T6XDhy6buq6QfDfv51pX2dEoOjEt/xKWoGgmqN9qr3/AjHo
 2bgpsW9S4eVb8TFnSI1eivsJlEtk486ybSld4rUTbNQ==
X-Received: by 2002:a17:906:7844:: with SMTP id
 p4mr3180822ejm.26.1604073854717; 
 Fri, 30 Oct 2020 09:04:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1LhBtUe4RfD7vdz6T+WU0b0bdIKVll+yCKX7zLk8O+pUhvNlQ2Df5Opp8ngLp1ngs7C94iQ==
X-Received: by 2002:a17:906:7844:: with SMTP id
 p4mr3180802ejm.26.1604073854514; 
 Fri, 30 Oct 2020 09:04:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id h26sm3266273edr.71.2020.10.30.09.04.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 09:04:13 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-10-git-send-email-michael.christie@oracle.com>
 <20201030045053-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 09/17] vhost scsi: fix cmd completion race
Message-ID: <5c319f1a-cf4c-f522-ecde-5b6b5a2e1ddd@redhat.com>
Date: Fri, 30 Oct 2020 17:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030045053-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com
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

On 30/10/20 09:51, Michael S. Tsirkin wrote:
> On Wed, Oct 21, 2020 at 07:34:55PM -0500, Mike Christie wrote:
>> We might not do the final se_cmd put from vhost_scsi_complete_cmd_work.
>> When the last put happens a little later then we could race where
>> vhost_scsi_complete_cmd_work does vhost_signal, the guest runs and sends
>> more IO, and vhost_scsi_handle_vq runs but does not find any free cmds.
>>
>> This patch has us delay completing the cmd until the last lio core ref
>> is dropped. We then know that once we signal to the guest that the cmd
>> is completed that if it queues a new command it will find a free cmd.
>>
>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> 
> Paolo, could you review this one?

I don't know how LIO does all the callbacks, honestly (I have only ever
worked on the virtio-scsi driver, not vhost-scsi, and I have only ever
reviewed some virtio-scsi spec bits of vhost-scsi).

The vhost_scsi_complete_cmd_work parts look fine, but I have no idea why
vhost_scsi_queue_data_in and vhost_scsi_queue_status call.

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
