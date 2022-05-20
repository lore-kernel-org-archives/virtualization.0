Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB0CC433F5
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 23:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E1F0411AC;
	Fri, 20 May 2022 23:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YqadqdTwNoaV; Fri, 20 May 2022 23:26:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4FF6641192;
	Fri, 20 May 2022 23:26:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 358D4C0039;
	Fri, 20 May 2022 23:26:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 982C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 23:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85D27426B8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 23:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="Ge1GbYxJ";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="bdrx6T6/"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qYMgGxeS8E0B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 23:26:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37512426B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 23:26:01 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1653089158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXl2vZK8puszcOApjIRM6ipBqamYF8etYeeQxgi9t5c=;
 b=Ge1GbYxJiIrzO7+HtjEO7xasn5LCGkqxqYYrM/F0B6gO0Q1SUxnLjfjWJCibrC/MXIpjJ3
 FtGAkaCTtAnpcrVC9FOp2RZfblScKVBXtToMz61M/KdI9ANzNZN1KlLqVxr9/Wh/2KObhA
 F3+wyQoA4maHBAATR8GCsrLC0CqxevVL28uEo2xPVafnalKJf2mVcibpqTtokBBR/GjJ0B
 B7JpFCWXL0NpRkRsB8Yzs+AvESIXQdH9nKyR46Hu8aZxEPX3mt3vyN3VYJjB5JtAvG8uGk
 JhRvNDjSTse1Q6zy9lhGiIpgNgxSHe5dg9H3URRXB1QJh5dD3uFf0vc3cSXDuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1653089158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXl2vZK8puszcOApjIRM6ipBqamYF8etYeeQxgi9t5c=;
 b=bdrx6T6/OumYHk0OqR+Y8wRLS0Vj5+UqI6uPx0nzpCsD/CVpT6lvt1ijM8c2h+x5jG4zGY
 SnVBUdez4bhQH/CQ==
To: Shreenidhi Shedi <yesshedi@gmail.com>, srivatsa@csail.mit.edu,
 amakhalov@vmware.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH v2] x86/vmware: use unsigned integer for shifting
In-Reply-To: <20220520140954.597725-1-sshedi@vmware.com>
References: <20220520140954.597725-1-sshedi@vmware.com>
Date: Sat, 21 May 2022 01:25:57 +0200
Message-ID: <87pmk7iy62.ffs@tglx>
MIME-Version: 1.0
Cc: Shreenidhi Shedi <sshedi@vmware.com>, pv-drivers@vmware.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 yesshedi@gmail.com
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

On Fri, May 20 2022 at 19:39, Shreenidhi Shedi wrote:

> From: Shreenidhi Shedi <yesshedi@gmail.com>
>
> From: Shreenidhi Shedi <sshedi@vmware.com>

Can you please decide which of your personalities wrote that patch?

> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.

Better option? There are no options. It's either correct or not. Please
be precise and technical in your wording.

> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")
>
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>

Please keep the tags together. This extra new line is pointless and
makes the maintainer do extra work to remove it.

Documentation/process/* has all the relevant directives for
you. Following them is not an option. It's mandatory.

> @@ -476,8 +477,8 @@ static bool __init vmware_legacy_x2apic_available(void)
>  {
>  	uint32_t eax, ebx, ecx, edx;
>  	VMWARE_CMD(GETVCPU_INFO, eax, ebx, ecx, edx);
> -	return (eax & (1 << VMWARE_CMD_VCPU_RESERVED)) == 0 &&
> -	       (eax & (1 << VMWARE_CMD_LEGACY_X2APIC)) != 0;
> +	return !(eax & BIT(VMWARE_CMD_VCPU_RESERVED)) &&
> +		(eax & BIT(VMWARE_CMD_LEGACY_X2APIC))

Testing your changes before submission is not optional either. How is
this supposed to compile?

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
