Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8498BC25B47
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 17:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FF5A42255;
	Mon, 23 Oct 2023 17:11:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FF5A42255
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=OPBnGNnH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B96RzFny4BHB; Mon, 23 Oct 2023 17:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A15B342220;
	Mon, 23 Oct 2023 17:11:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A15B342220
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71BF0C0039;
	Mon, 23 Oct 2023 17:11:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7221DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 17:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35910417FC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 17:11:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35910417FC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com
 header.a=rsa-sha256 header.s=google09082023 header.b=OPBnGNnH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DSO8V7Cv7_GT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 17:10:58 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16FC240012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 17:10:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16FC240012
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so3473013e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloudflare.com; s=google09082023; t=1698081056; x=1698685856;
 darn=lists.linux-foundation.org; 
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
 bh=nLXx7mlPs/OQb0ZwhhQH6B6jy+zC/eGvf9D/oXTg+Mk=;
 b=OPBnGNnH5IEQJihyGZCreFRDOM0fD4yHuiqieKjXYKpyLc0FgKxVIeex/D2RvtETtc
 cv9Jj9I074pgg+LqUa3SiRFV1OXmq55YbbO7G135MFz8T17FZDFGZiEQaJASIJAOmlxE
 XZveDg8uk+DEN8p63Nc64tSfE0mqmhswv0jPbVzXiJqrz7+DOziTZRD2RJmpp1HEjsRE
 Ihp/ltwZ+/5rBMQyBAAeIkH4S76J79+GUsIbqfTRDMtDm2V2KXb6kdgk7be/zJeJdWR9
 xnHObm35//lb29FHCGkG8QJNs1V0dktGwvo9FyObabh3nT4Xs2knp+ORHaPLdzRhWgwp
 bcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698081056; x=1698685856;
 h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
 :user-agent:references:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLXx7mlPs/OQb0ZwhhQH6B6jy+zC/eGvf9D/oXTg+Mk=;
 b=I0PQy3ObKEsJJDjjna9buuxRwQfi5efvNAGFphgybneiYOi+E5YlWvyfULbq/iVEpv
 haHe/re3ZI18P9AZEXV78XiRbuh75XJuXWxzYr5Xn+3DWbD227Y89CvrWxDW/KPLf0C5
 1SRkCLYkk1cQR4Hgv2//aCqE6d88ibInZ8uVGEPUsFcaOiJBcAR9JgnCN+eu5Jgz+2i1
 CE4dwMGUOg0oM3Q/Qpyyh+NoNXwBINk0nPpAFq1C7gH72/glGklyIYyzVeoxbYNTV/6p
 Y46dk2/7Ll9e/xWs/X6xqKyVMwCieDJTORJV5lio8XACYpLIWKgoC1gP89mE+kUQds52
 kN6Q==
X-Gm-Message-State: AOJu0YzGU0PuLgC9jIkYVtiYpZBbU3de6dfS5qVpz9gv8P4dnBC0LTwz
 j+ui6cU5BFl8REzsGAuIfWcltg==
X-Google-Smtp-Source: AGHT+IEvOkxYrug1krm+yJscF/JHitwboKBGBCis1eGb3W39NQ2kT1N2cdAdPFhubOMydlAxfQVd2A==
X-Received: by 2002:a19:7609:0:b0:507:9a13:27bd with SMTP id
 c9-20020a197609000000b005079a1327bdmr6324284lff.7.1698081055862; 
 Mon, 23 Oct 2023 10:10:55 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1ce])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a170906489500b00997d76981e0sm6862736ejq.208.2023.10.23.10.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 10:10:55 -0700 (PDT)
References: <20231019101625.412936-1-jakub@cloudflare.com>
 <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
User-agent: mu4e 1.6.10; emacs 28.3
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu
 affinity mask
Date: Mon, 23 Oct 2023 18:52:45 +0200
In-reply-to: <1697720122.49851-2-xuanzhuo@linux.alibaba.com>
Message-ID: <87il6x2rj6.fsf@cloudflare.com>
MIME-Version: 1.0
Cc: Caleb Raitto <caraitto@google.com>, kernel-team@cloudflare.com,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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
From: Jakub Sitnicki via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 19, 2023 at 08:55 PM +08, Xuan Zhuo wrote:
> On Thu, 19 Oct 2023 12:16:24 +0200, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
>> mask.") it is actually not needed to have a local copy of the cpu mask.
>
>
> Could you give more info to prove this?
>
> If you are right, I think you should delete all code about msix_affinity_masks?

Sorry for the late reply. I've been away.

It looks that msix_affinity_masks became unused - intentionally - in
2015, after commit 210d150e1f5d ("virtio_pci: Clear stale cpumask when
setting irq affinity") [1].

Originally introduced in 2012 in commit 75a0a52be3c2 ("virtio: introduce
an API to set affinity for a virtqueue") [2]. As I understand, it was
meant to make it possible to set VQ affinity to more than once CPU.

Now that we can pass a CPU mask, listing all CPUs, to set_vq_affinity,
msix_affinity_masks seems to no longer have a purpose.

So, IMO, you're right. We can remove it.

Happy to do that in a follow up series.

That is - if you're okay with these two patches in the current form.

Thanks for reviewing.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=210d150e1f5da506875e376422ba31ead2d49621
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75a0a52be3c27b58654fbed2c8f2ff401482b9a4
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
