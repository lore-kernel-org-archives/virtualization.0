Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41197C43217
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 22:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C1114197C;
	Wed, 12 Oct 2022 22:28:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C1114197C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=PG8Sv/Yk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G9URZLicmpF4; Wed, 12 Oct 2022 22:28:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3AFD41975;
	Wed, 12 Oct 2022 22:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3AFD41975
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D0F9C0032;
	Wed, 12 Oct 2022 22:28:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1832C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B50BC4197D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:28:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B50BC4197D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TiqrTGFxsY5V
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:28:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83C6A41975
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83C6A41975
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 22:28:19 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-134072c15c1so395123fac.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9BN0Pk/K+PCpDcgg2tmeghFGpuxVnyr+nUJEj9O/iOg=;
 b=PG8Sv/Yka8Yp9Rz2YLwXRoCSk3ohLBk553apBMHs77bHj0q0NFj7kkqwZ0TBSsCYPk
 SGrv+k5MFvW+V0pa+FgG02mjEH0rkI/8l48hyyjlU3KRTTUBIeZRKDumRoLz0T0pgk91
 bPxfYJXWhXwseUvfKSSj2+OuNifFSdfr8kQU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9BN0Pk/K+PCpDcgg2tmeghFGpuxVnyr+nUJEj9O/iOg=;
 b=AwJHql5Wzl/fYZ3z/pA0zh2bBSUeWpnZ9GgPfPpsuJ5rgSNNInM1cKS/+tRBCTo0RJ
 s7+Td2/z9UNirIl0TZt8RyuQD3r10wLuSmlmBaQdspnzzRx1/HOfNgM8CnVSPnWTPDVi
 Mw8gy/5d6xQygfk4X23YjAaFBr2XaKqnlKCGR+4tu3vuMtVfWxrAmIDBSBVhrf40R16J
 Ve4itIN0sWyqN/lHuB+qhM08g/MlsLcdUeUO1E3ZcI1fdW+fu5JI3RORaurUE7yTRaVC
 EckUN7ZFRPIwojr7d6PfldDRah3mAuOv9n1ScmBbap0Ean75ZrkOKZ1a2FtiPXmybTVF
 T0vQ==
X-Gm-Message-State: ACrzQf0NUuTCfe1upIOZXzUQtoXnYY4HxBoLO53mhm7dboRNNn1GC5LW
 rmBUYRgW+n/qGDfH8pquvowyKS99M2Ctq8Yp
X-Google-Smtp-Source: AMsMyM4akX8PizdUv7cqeg9wwCJvo5iJ8Z0++IRR4m12bYbngx/9gljVtuKq6EYLoS+V3FA9pxRmhA==
X-Received: by 2002:a05:6870:9a05:b0:132:ebf:dc61 with SMTP id
 fo5-20020a0568709a0500b001320ebfdc61mr3641764oab.76.1665613697369; 
 Wed, 12 Oct 2022 15:28:17 -0700 (PDT)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com.
 [209.85.161.47]) by smtp.gmail.com with ESMTPSA id
 y32-20020a4a9823000000b00435a8024bc1sm1461450ooi.4.2022.10.12.15.28.15
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Oct 2022 15:28:15 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id
 j6-20020a4ab1c6000000b004809a59818cso190562ooo.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 15:28:15 -0700 (PDT)
X-Received: by 2002:a05:6830:4421:b0:661:8fdd:81e9 with SMTP id
 q33-20020a056830442100b006618fdd81e9mr10083311otv.69.1665613694769; Wed, 12
 Oct 2022 15:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221012220312.308522-1-mst@redhat.com>
In-Reply-To: <20221012220312.308522-1-mst@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Oct 2022 15:27:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjennbcJPkVy5fk5Hwv9uZvuzJzi9CN0gEwNs5j-psKyA@mail.gmail.com>
Message-ID: <CAHk-=wjennbcJPkVy5fk5Hwv9uZvuzJzi9CN0gEwNs5j-psKyA@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: use irq to detect interrupt support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Angus Chen <angus.chen@jaguarmicro.com>
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

On Wed, Oct 12, 2022 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This seems to happen because pci_dev->pin is not populated in
> pci_assign_irq().

Yeah, I have to say, I wonder why it was looking at pci_dev->pin in
the first place.

I was curious, as this is fairly odd.

Of course, I only did a fairly strange 'grep' for this thing, so I
might have missed some other use:

    git grep -e '->pin\>' $(git grep -l 'struct pci_dev')

and the above will possibly find other uses of 'pin' as a member than
the 'struct pci_dev', so I'm not going to claim the above is
exhaustive, but looking at the results, I do see how ACPI has somewhat
similar logic, and acpi_pci_irq_enable() does this:

        ...
        pin = dev->pin;
        if (!pin) {
                dev_dbg(&dev->dev, "No interrupt pin configured\n");
                return 0;
        }
        ...

but in the end that seems to be because it's then later using the pin
to do the actual PCI IRQ routing table lookup, and then it uses that
value to actually look up the IRQ number:

        dev->irq = rc;
        dev->irq_managed = 1;

and in fact all this code also has a "have I already looked this up"
and then it doesn't do anything (but somewhat illogically, it does
that *after* having tested for that "!pin" condition - I think it
would make more sense to go "oh, I already have this interrupt mapped,
I shouldn't care about the pin", but I suspect it doesn't matter in
practice).

And I really think that that is basically the only time you should use
that 'pci_dev->pin' thing: it basically exists not for "does this
device have an IRQ", but for "what is the routing of this irq on this
device".

There's also some testing of dev->pin in drives/pci/pci.c and
drivers/pci/probe.c, but it seems to be very similar: it's actually
doing the irq lookup, and the pin swizzling that goes along with it.

IOW, I think that yes, this patch makes sense, and virtio_pci was
doing something odd. That virtio_pci driver at no point actually cares
about the PCI pin, will not do any PCI irq routing lookup with it, it
will just do

        err = request_irq(vp_dev->pci_dev->irq, [...]

using the pci_dev->irq that has already been looked up.

So the patch makes sense to me. If there is some problem with
pci_dev->irq, then it's up to request_irq() to complain about it (ie
we have things like IRQ_NOTCONNECTED etc, which is a more modern-day
version of the old NO_IRQ thing).  Again, not something that
virtio_pci should check for itself, I think.

But I don't really know the virtio code. I can only say that "check
the pin" pattern seems entirely wrong and should only be done by code
that does actual irq routing, and "just check the irq" is what
everybody else does.

                    Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
