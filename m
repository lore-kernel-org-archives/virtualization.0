Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933DEC433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 04:57:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE5964F94
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 04:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE5964F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EA224307A;
	Fri, 12 Mar 2021 04:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eZg1FwAXEGOb; Fri, 12 Mar 2021 04:57:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12A2A414FE;
	Fri, 12 Mar 2021 04:57:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1ABAC000A;
	Fri, 12 Mar 2021 04:57:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D2EAC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 04:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0375E6F972
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 04:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uyV9JGoG1erL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 04:57:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 627736067B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 04:57:20 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id m1so2850450ote.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 20:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZFB+SDHUBMAyNuw42aUgGYVm2Uo/6oSoaoVaMYt0E1w=;
 b=pGXi3z764J/1C3pHI0/n6skzBm45zHTzJnDBVhaUU2UT75RkhFmXAGSjXf3VgZjebI
 8GQ0o59IqnxMQGtPzfqoNwtSIExfR6F+FkRaI//YVBoxh0ktEdkxbTQAF1uIAgOiv7HG
 YTVeENbW8Nijy22OCHQWhJZb48fNtsGFD4tJUUBbQxMMWOhjQzuUC5I/J2ZeFfVfTi7R
 dpa2gXs7MZvC/Fxho62I/aRu5DmVDGnlDJgQ7bWKejQ3DBo5AsOU3kNpM69Ch+ZR7mRA
 Ce1EpXwEulQo9a/sXLZPw2Ln8ch80ZdrUsnPa7/1pP/x3dG03WPNPhnb8EHOCVGlGu+3
 EotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZFB+SDHUBMAyNuw42aUgGYVm2Uo/6oSoaoVaMYt0E1w=;
 b=MGgBnG+4UYmiWRHf8M08L1lbGAG+k0Ud/INZGGsC/BR17MDxHC5IBkwYLVGewd/Gne
 A3FZ6NI/rHyhSdFFYUVjG4LXsq93ESP8dvh96VhLx2SKPvnI9+DN1Gvcyiyi9HRyUI4j
 mHl1jAKu51ftHfb0GiSMJ0a+idnDqh0RnHdh7dRNvUNJrf2AaR0X5e/AeH8oGN4zwOn3
 IXMTGflpGrQzKNVHuV9UuAHqwnZYqdjXwz4nV9qOrg3ixqg0mejBFf8B81ASsG3LVNCw
 exGKK+kR1k19sCG4Px/nqePLwLwCSGVE7xNi2kJhsANtHVaMjwwNde9xZ6oqQjMVUUCM
 2AbQ==
X-Gm-Message-State: AOAM530awcmrau4VNBZp+OscDnTwuz6IMwvKppG38vj30nZjFsm9kDSe
 OIcosGSKzKiV0V1FR7f7AmoajFSgbQmbGjZtzfd9GA==
X-Google-Smtp-Source: ABdhPJwwIP59WVqaFiss1ILZxP6oBtFe5xdcNHitthuxIOwL2rUSFEqxcrr/M0pxx/6LPi+SFNpsZpwN1fAgzkj3zK4=
X-Received: by 2002:a9d:734b:: with SMTP id l11mr1947064otk.279.1615525039399; 
 Thu, 11 Mar 2021 20:57:19 -0800 (PST)
MIME-Version: 1.0
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
 <20210223045001-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210223045001-mutt-send-email-mst@kernel.org>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Thu, 11 Mar 2021 20:57:08 -0800
Message-ID: <CAP_N_Z-Y+a9mHH8GCqnaR=ZP9gQiu26Op35oZWm2LHkvCQ7=qg@mail.gmail.com>
Subject: Re: [External] Re: vsock virtio: questions about supporting DGRAM type
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 imbrenda@linux.vnet.ibm.com, xieyongji@bytedance.com, stefanha@redhat.com,
 asias@redhat.com, virtualization@lists.linux-foundation.org
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

Hi Michael,

Sorry for the late reply. I just saw your email yesterday somehow.

I read the email thread you mentioned, and I think the issue with
dgram is that it may drop packets because the sender cannot track the
tx_cnt with subtracting it from peer_fwd_cnt.

I agree with Stefan that the dgram is a best-effort service and may
drop packets. For the sender, I just add a maximum buffer size to
limit the memory usage. On the receiving side, I reuse the existing
virtio_transport_inc_rx_pkt() that Stefano added a year ago to limit
the memory usage. This will avoid denial of service attack to the
other end (host or guest VM).

For the application of dgram, we will use it for some remote logging
application. The application running in the VM will write some logs to
a server running on the host. This is  one way communication and the
log is not critical.

Regards,

Jiang

On Tue, Feb 23, 2021 at 1:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
> > Hi guys,
> >
> > I am working on supporting DGRAM type for virtio/vhost vsock. I
> > already did some work and a draft code is here (which passed my tests,
> > but still need some cleanup and only works from host to guest as of
> > now, will add host to guest soon):
> > https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
> > qemu changes are here:
> > https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
> >
> > Today, I just noticed that the Asias had an old version of virtio
> > which had both dgram and stream support, see this link:
> > https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
> >
> > But somehow, the dgram part seems never merged to upstream linux (the
> > stream part is merged). If so, does anyone know what is the reason for
> > this? Did we drop dgram support for some specific reason or the code
> > needs some improvement?
>
> It's not just code it's the spec that needs work.
>
> See some issues pointed out here:
>
> https://lists.oasis-open.org/archives/virtio-dev/201506/msg00003.html
>
>
>
> > My current code differs from Asias' code in some ways. It does not use
> > credit and does not support fragmentation.  It basically adds two virt
> > queues and re-uses the existing functions for tx and rx ( there is
> > somewhat duplicate code for now, but I will try to make common
> > functions to reduce it). If we still want to support dgram in upstream
> > linux, which way do you guys recommend? If necessary, I can try to
> > base on Asias' old code and continue working on it. If there is
> > anything unclear, just let me know. Thanks.
> >
> > Regards,
> >
> > Jiang
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
