Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0308C433E2
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 13:24:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221E221D7D
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 13:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNgVgB16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221E221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 601B81FEB7;
	Wed,  9 Sep 2020 13:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EMTvj4VCSCHD; Wed,  9 Sep 2020 13:24:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E65552E183;
	Wed,  9 Sep 2020 13:24:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC37DC0859;
	Wed,  9 Sep 2020 13:24:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B6BDC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 13:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6761C8729F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 13:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKKnCI6YwZaF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 13:24:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7BE2A872E0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599657873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Z+yPEMCTmeMzDKoGBf7peDSr8BK2RKJoBhQ4aH3NRo=;
 b=JNgVgB16rp0va/LNwt4+DKni+khZn/W0vA4d6TuGIBEIw5Vlbym0U1itR8uQK21nOY5fWH
 Adm6oANLqvWSv14NY10ms0h3NIaubSTGH6DH/uBPn77s14Wgdhhgnrii63okmLgSRA9xvr
 tB2fVP8bY/ylE4AsKlBnWM2Cwr+qwqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-ek1SMh84NSq0ZRU3QtpJbQ-1; Wed, 09 Sep 2020 09:24:29 -0400
X-MC-Unique: ek1SMh84NSq0ZRU3QtpJbQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1053C100746A;
 Wed,  9 Sep 2020 13:24:26 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-82.ams2.redhat.com
 [10.36.114.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA0C15D9E8;
 Wed,  9 Sep 2020 13:24:20 +0000 (UTC)
Subject: Re: [PATCH v7 71/72] x86/efi: Add GHCB mappings when SEV-ES is active
From: Laszlo Ersek <lersek@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 brijesh.singh@amd.com
References: <20200907131613.12703-1-joro@8bytes.org>
 <20200907131613.12703-72-joro@8bytes.org> <20200908174616.GJ25236@zn.tnic>
 <CAMj1kXHbePrDYXGbVG0fHfH5=M19ZpCLm9YVTs-yKTuR_jFLDg@mail.gmail.com>
 <e3911fe6-84e8-cb50-d95d-e33f8ae005f8@redhat.com>
Message-ID: <0524c7fa-2fe2-ab6a-01f9-a04dacf86f6d@redhat.com>
Date: Wed, 9 Sep 2020 15:24:19 +0200
MIME-Version: 1.0
In-Reply-To: <e3911fe6-84e8-cb50-d95d-e33f8ae005f8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 X86 ML <x86@kernel.org>, David Rientjes <rientjes@google.com>,
 Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
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

On 09/09/20 14:44, Laszlo Ersek wrote:

> To summarize: for QemuFlashFvbServicesRuntimeDxe to allocate UEFI
> Runtime Services Data type memory, for its own runtime GHCB, two
> permissions are necessary (together), at OS runtime:
> 
> - QemuFlashFvbServicesRuntimeDxe must be allowed to swap MSR_SEV_ES_GHCB
>   temporarily (before executing VMGEXIT),
> 
> - QemuFlashFvbServicesRuntimeDxe must be allowed to change the OS-owned
>   PTE temporarily (for remapping the GHCB as plaintext, before writing
>   to it).

Condition#2 gets worse:

If the firmware-allocated runtime GHCB happens to be virt-mapped by the
OS using a 2MB page (covering other UEFI runtime data areas, perhaps?),
then simply flipping the encryption bit in
QemuFlashFvbServicesRuntimeDxe would mark more runtime memory than just
the GHCB as "plaintext". (2MB-4KB specifically.)

This could result in:
- firmware read accesses outside of the GHCB returning garbage
- firmware write accesses ouside of the GHCB leaking information to the
hypervisor, and reading back later as garbage

In order to prevent those symptoms, the firmware would have to split the
2MB page to 4KB pages, and decrypt just the one (GHCB) page.

But page splitting requires additional memory (for the finer granularity
page table), and fw memory cannot be allocated at OS runtime. So that
extra memory too would have to be pre-allocated by the firmware. Nasty.

I'd recommend sticking with this kernel patch.

Thanks,
Laszlo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
