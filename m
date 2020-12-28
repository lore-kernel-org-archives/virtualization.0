Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A63EC433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 19:51:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB55B204EF
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 19:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB55B204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B77C8436F;
	Mon, 28 Dec 2020 19:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKcYZ4-2VQm0; Mon, 28 Dec 2020 19:51:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D25748410C;
	Mon, 28 Dec 2020 19:51:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6D4BC0893;
	Mon, 28 Dec 2020 19:51:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 361A1C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 19:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1B8EA85BFB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 19:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QyFcCAnGTZF5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 19:51:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com
 [209.85.222.45])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 613C885BE4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 19:51:49 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id 73so3675383uac.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zzyjd88NUbxeK6ogA3JXthDFCQ1wxhoB9rYZKCKLlyk=;
 b=ln4L3Lw7MRyfZYMURHOVQ/6Q+rtDd1F16YYABE2HRAKpLkQ+Z+znsJprN+n0CQWh0n
 WUE1nt0HHttwIpNrZeJgMPCQIDzUYa6ylf3rg+x3+SpsZGaOD3+VDydr6wJUJzxwmNQX
 wek2Od4vkwkXRJWGJZkfugjcut1pUEeXrN8OmzHFOKy/FvKwKkm6wOWwRXKa/JUiJ7va
 HbJA4urwcfQxHgh/ciGfSzbPiFV0HPYpoVFzKhxRYkTjCLrDV1khyxJNTTcutQy7cjzF
 KFjLe7ktglKjKEsB58whX/4elHCkOXIarUjpaT4hKYOxaQs9SsnzVWe2sWogkM9NfIze
 vmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zzyjd88NUbxeK6ogA3JXthDFCQ1wxhoB9rYZKCKLlyk=;
 b=bgcXsHOZ4niNzo9WzgLl4H4+H+4sP+e1XTHhpEdzrPlYsQThUqxWpyOU3kVUAIjx4m
 NS6XWAQA+c5/wZRld4ZvaiFvg+Iy+MlP5l9TCYuTGeseXJ6SS9H1My5vpQZysIAqDO4m
 wmz1+w1haKlO+HUzJ6+mBv2G3IEJrJLkFhE4aeTBwSLoHgqBkuurhlzKVSgAtnmjNWWp
 vYmaaW660ZOtYXHHYfl4rIAbtTMymw7kw3POkFhDMBplq18Jrh92tqGi13TwPCBS5/JD
 qSlx6YagIV4n1/yfHdbiX12FebuClX9VnqpAe6TihZLx+Jh6d7gJE4j0SndPhJMV3bsz
 ZzHA==
X-Gm-Message-State: AOAM530Owf3m9Lj0jUpHplGaT2q0v1AJ5e4o5s/siHv4yzTdf9VEAqSn
 Fo0E9kot3dyOO8apGRWQ37iTWIMDNLE=
X-Google-Smtp-Source: ABdhPJzsibcxJ9WLOtdS+GE8ibaKj+Mn0yWJZpoWiq7p65IgsMYfp9Hjdxgp9/DaEKRgZO5/Mv3PWQ==
X-Received: by 2002:ab0:3c8f:: with SMTP id a15mr6543285uax.127.1609185107805; 
 Mon, 28 Dec 2020 11:51:47 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com.
 [209.85.222.53])
 by smtp.gmail.com with ESMTPSA id a2sm3109498vkc.41.2020.12.28.11.51.46
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Dec 2020 11:51:47 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id y21so3683700uag.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 11:51:46 -0800 (PST)
X-Received: by 2002:ab0:7386:: with SMTP id l6mr30028720uap.141.1609185106156; 
 Mon, 28 Dec 2020 11:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20201228162233.2032571-1-willemdebruijn.kernel@gmail.com>
 <20201228122911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201228122911-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 28 Dec 2020 14:51:09 -0500
X-Gmail-Original-Message-ID: <CA+FuTScXQ0U1+rFFpKxB1Qn73pG8jmFuujONov_9yEEKyyer_g@mail.gmail.com>
Message-ID: <CA+FuTScXQ0U1+rFFpKxB1Qn73pG8jmFuujONov_9yEEKyyer_g@mail.gmail.com>
Subject: Re: [PATCH rfc 0/3] virtio-net: add tx-hash, rx-tstamp and tx-tstamp
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 28, 2020 at 12:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Dec 28, 2020 at 11:22:30AM -0500, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > RFC for three new features to the virtio network device:
> >
> > 1. pass tx flow hash and state to host, for routing + telemetry
> > 2. pass rx tstamp to guest, for better RTT estimation
> > 3. pass tx tstamp to host, for accurate pacing
> >
> > All three would introduce an extension to the virtio spec.
> > I assume this would require opening three ballots against v1.2 at
> > https://www.oasis-open.org/committees/ballots.php?wg_abbrev=virtio
> >
> > This RFC is to informally discuss the proposals first.
> >
> > The patchset is against v5.10. Evaluation additionally requires
> > changes to qemu and at least one back-end. I implemented preliminary
> > support in Linux vhost-net. Both patches available through github at
> >
> > https://github.com/wdebruij/linux/tree/virtio-net-txhash-1
> > https://github.com/wdebruij/qemu/tree/virtio-net-txhash-1
>
> Any data on what the benefits are?

For the general method, yes. For this specific implementation, not  yet.

Swift congestion control is delay based. It won the best paper award
at SIGCOMM this year. That paper has a lot of data:
https://dl.acm.org/doi/pdf/10.1145/3387514.3406591 . Section 3.1 talks
about the different components that contribute to delay and how to
isolate them.

BBR and BBRv2 also have an explicit ProbeRTT phase as part of the design.

The specific additional benefits for VM-based TCP depends on many
conditions, e.g., whether a vCPU is exclusively owned and pinned. But
the same reasoning should be even more applicable to this even longer
stack, especially in the worst case conditions.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
