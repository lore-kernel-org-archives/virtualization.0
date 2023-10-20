Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EBCCDB47E
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 10:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76DFE70433;
	Fri, 20 Oct 2023 10:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76DFE70433
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ifl/oYvh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-Ay2FYV7b9s; Fri, 20 Oct 2023 10:44:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02D477042E;
	Fri, 20 Oct 2023 10:44:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02D477042E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5D79C0039;
	Fri, 20 Oct 2023 10:44:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4544EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 10:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12BC14050C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 10:44:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12BC14050C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ifl/oYvh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id im1jJRCzKwyS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 10:44:27 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA88A432BC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 10:44:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA88A432BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1697798659;
 bh=BOQy2S+gkRQ6GqEG1l3wx7Pc1XFdYna8OiPHPqKzES4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ifl/oYvh+TRsSqRgEPMixGOqr4MoU0N6idL02NbzyNh9SF3hMbCT+41P1QDWt9mVo
 r0TnbRSCGpHxnFA9gfGRPjgqC0x+mJUC+G5G3bjzrS2ECDmKQriQsQBsa5eSkJrlLT
 nIqcKEqedWmBVS5HNXbL1uOSBHiHHvVSm1LE7Kg0f1/pSXNmJVbpWAnvbch0WWD0+u
 Z0dVWmEId377e1yEOsZALaWYmd8CxmAeINvjgQIdioHEWLBHybz/2wsXn2p1O86dEd
 SGlFy6Qr3r8lxy7s+ZxRnYq6QqQnhT34XhJPgr0BVQ0hdxxZZmMskpbccxYulBee/c
 Cwb6zW0meP0UQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBh6B6KH4z4xdP;
 Fri, 20 Oct 2023 21:44:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/6] powerpc/smp: Move shared_processor static key to
 smp.h
In-Reply-To: <20231019130843.GI2194132@linux.vnet.ibm.com>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-4-srikar@linux.vnet.ibm.com>
 <87sf675im3.fsf@mail.lhotse> <20231019130843.GI2194132@linux.vnet.ibm.com>
Date: Fri, 20 Oct 2023 21:44:14 +1100
Message-ID: <877cnh60ap.fsf@mail.lhotse>
MIME-Version: 1.0
Cc: Valentin Schneider <vschneid@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Ajay Kaher <akaher@vmware.com>,
 Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Rohan McLure <rmclure@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexey Makhalov <amakhalov@vmware.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
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

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [2023-10-19 15:41:40]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > The ability to detect if the system is running in a shared processor
>> > mode is helpful in few more generic cases not just in
>> > paravirtualization.
>> > For example: At boot time, different scheduler/ topology flags may be
>> > set based on the processor mode. Hence move it to a more generic file.
>> 
>> I'd rather you just included paravirt.h in the few files where you need it.
>
> I thought, detecting if a Processor was shared or not was more a
> smp/processor related than a paravirt related.

It's both really :)

It's definitely paravirt related though, because if we weren't
*para*virt then we wouldn't know there was a hypervisor at all :)

But having smaller more focused headers is preferable in general just
for mechanical reasons.

cheers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
