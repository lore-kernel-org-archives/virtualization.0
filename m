Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60702C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:30:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A99D610E7
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A99D610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA3C44024C;
	Thu, 14 Oct 2021 02:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qa_PgK9umdWx; Thu, 14 Oct 2021 02:30:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F07E40108;
	Thu, 14 Oct 2021 02:30:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7E1DC000F;
	Thu, 14 Oct 2021 02:30:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 763C0C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 574B2406F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:30:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPDZftsflyws
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:30:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2CFF406F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634178607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IynqbknfdhAtpAsTc+n5KzLs0d2B4KuFYlrAM62Za7c=;
 b=gTPWRbvkXWOBqV6o3SIqYu/VJDhChDobef85zLRFZkDc9H4eAv9X7WuejhhrcWjzyNMqEw
 pagxnQHZjPLbYZpWb8g0OzRBPe3o6w7v/LwqBt4iYf7yeBZtHjeu4cMDY4R4PKlO676+X+
 Xlwt9JrLXdvWPyTzVjRyvl5tBCIlkqg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-Dw8FitkJMjSADof74c_EmQ-1; Wed, 13 Oct 2021 22:30:04 -0400
X-MC-Unique: Dw8FitkJMjSADof74c_EmQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 o5-20020ac24c45000000b003fd932e4642so3301028lfk.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 19:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IynqbknfdhAtpAsTc+n5KzLs0d2B4KuFYlrAM62Za7c=;
 b=FxrsrCpOAW172C1k6jd8SE02SPRDjrGnTOKrFdfZMZjU898zTarorEEbu5rPsoOhvO
 paVqxwllsAWJfZmSMTtPhtCkB1MVaqRfnL/KPg0IA51eSaha05As90QMYCX3AccSQX64
 AEhrIzBRDFpcMZe6dGkmi+YW94hQrBJAcocWNqtyDPKT4aF5Bp8svNIAiHtLGNiqw8tV
 vXO5SqK6skIOU2sp91I18F5y1tHu+FhSYTu0qZE/7SlqSe6N/adMZcsIWhTXBCJXIbJ9
 78XEGPj6w3fRZU/j+3mIprmcyGehgGODcl+f6TkRpn6Wkkzuu1cGXUKnaGe8EMmX6cO6
 iRcA==
X-Gm-Message-State: AOAM5333bVBeK7m9B85vEpB3syCuT40UJq4wW4nD44KP+iVyZwLhcDo7
 235YrDEOH3Lhu9eRTIY08i+qZRc7uWWZPytDncCg9mwFIQSnYRE+zgGk0ciAISzgAYzhDR/CAH3
 ZSc1GH7sxe2WTCKBPED/+p4OlRUIw6OF7BG7YdsSG6OB7Ocp2OaKaHI4Hrg==
X-Received: by 2002:a05:6512:110d:: with SMTP id
 l13mr2432431lfg.199.1634178602925; 
 Wed, 13 Oct 2021 19:30:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCBnldX41BfPregta5x39FHwsgQm6jJf2AND+80Y0yMuBE60tF0GZs4V1GmdAp+U7WPN/6sjW2EZGHISIZvPc=
X-Received: by 2002:a05:6512:110d:: with SMTP id
 l13mr2432414lfg.199.1634178602690; 
 Wed, 13 Oct 2021 19:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
 <20211013055752-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013055752-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 10:29:49 +0800
Message-ID: <CACGkMEtZB7y=OVcCvLWkdOyPrifAKJOU_tHLSyfMNGMkPspp4g@mail.gmail.com>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E . McKenney" <paulmck@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Oct 13, 2021 at 5:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:21PM +0800, Jason Wang wrote:
> > We used to synchronize pending MSI-X irq handlers via
> > synchronize_irq(), this may not work for the untrusted device which
> > may keep sending interrupts after reset which may lead unexpected
> > results. Similarly, we should not enable MSI-X interrupt until the
> > device is ready.
>
> You mean until the driver is ready.

RIght, I will fix it.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
