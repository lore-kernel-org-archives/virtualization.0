Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A4385D9B
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716113; cv=none; b=akkzW1u885+YXd8Cg4ZyfpSzfKO87g9h5eFPy+wcw3YBL1q8DbrdrytlLoaHkuli0jeVBB69ysj4iNVlUk9JOZSVCZq07fOSkBbfy4Ud6ISpJAnj7flkxMT9RXSSX5zTaVWxmEPll4vgBspW+ttJ8ecarjHtshO1RBD0gbChzbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716113; c=relaxed/simple;
	bh=s/CzDsE1zdMqB98tClQW/DiNhe7WU760fn0iU6bx43Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=picg7jRPhqbosUp9AWUmlkUcsG6/1darLHEMWJvKh8c3T3YQP57CB6F0oVxK5OC5bDdikByV4cJRnj2RLr3tG40AGJ6ZmD4O4Bk3qbco6ZWf2H9JPfRWm7uE5BAybQNp+P5B40kYlBVEoCFHwNpYTJBwpwrDBmSUjXxoL5yjs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DWSL1FYS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DWSL1FYS"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d734223e4so6077901f8f.0
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779716110; x=1780320910; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XVHRPBSt9KXo5wrulw6nEDVPqzcFN/DF35DZwL4F0c=;
        b=DWSL1FYS6iGoctUgR5x/kNk3v7fMWapajNvJ88hphzgCJcB0LFgwY+8wop/mpekWrl
         BEXbHPxSwy81k8b8bGaBYvYUqUImpOR7NhlfM/mkBh6hF0yPSQWxcVCl/n6bwJTk868a
         IAGoLKoTKcIHDYOaJIMunIsa8BruwfP8t2HPKxpbh7/ZVsb66C//D5cLKx3SO+x3YNhe
         6IaXnz2R3h5SYubModD91HGI73hhGPMiqjn0oHhFgGw7VwFnZjYvn1H8xWFQ833eeqye
         ZwiuLAHKXC7WsIF7p6DPujuyHIOlQEN8JKf90ce6/ZEB0mJ+KyV8qiN6/5nazSHgyJxS
         Innw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779716110; x=1780320910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XVHRPBSt9KXo5wrulw6nEDVPqzcFN/DF35DZwL4F0c=;
        b=g91HUOUsVUsJNq7uRabSdWGXtO1KXK3sb1d1WDlyArxXmUbcGL+x/ZSr32JOmKTSrO
         LwYYVFn15PT/do5AzfMVWvftyjwW83fyUdI+chfh71pIlInd1KUmgOVtsoaFep758OWs
         P8jrmL8caQfqQJonavbYyZjG2dQZfhIFYmfyFnaCz8v/xz+dPm5KWdBpw7u4SJ9JkMQD
         mPxS3s946IGaKsUGbK/7pF01Ic0gBhYBWNMbRr0Mipz7FnLT7g8AYLWfxSIHX4GKk9JN
         dfmguL8MAMq6EOvuCGmntzdHboIQVuEDJyHunillbdYplundE6MznEvumK/rfCJ3isg7
         b49w==
X-Forwarded-Encrypted: i=1; AFNElJ/gttj5ZBG+qKOKiK2gEEaTfvkcKronxe3Wwk3sat6n/OY+a1lwGC8D5AwU7r5juWf4zPhWUaOw03CgTeYIyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfadutpA0y0XnKZfmVQR5kvLzfEJntQATQ5b/hEx56RpOpUh6e
	Y9mtg+k5PKhQAuPjkUsLvfFoRkbKYbZbcGoPVLZP+LCJ0LNsEnBQ4qV5QjcF0wCQqyI=
X-Gm-Gg: Acq92OGkjOToh12biGlkTy//sD6mhazBB2xKySmUBqcG7hqL2Rg9eVDrToE1HrpxSLz
	rmoEdaLkWyMxk53iH2VmZK0+EWlYlDlnkeWuFUe6KymjuHQaJV02+MscfsNMvBtaIwlGAH2gcIk
	lW1uy+M9/1OLB890a77Mih3ipnSDIHBzbJFH7/Da6b8RFFM2+TtHcyYSEAj/PcliXcpYcH4Pm06
	8M1mW/+MtdMxFEu2x+UYD5DHXB1mnaX9GjZrPaJ4gkQBBKf9RXo+5kEFTzzyakjqPomcCVQ0Vqu
	54HHY/2IuHYfB1nD3ss0apS44CiEro3AYhltOEcy9VdmEjQ/ceHJ7ZX6nlxPnYfRU/WjfgxA3CX
	e5fh0148HAx+DWc2/TT2oktuVakBKeotQsTu9vOaGt/j/uMeLoIXrJmDZBI8xiElCPuN0iQd1og
	E3AclvkeLfQ2/IuymShIR04Mpwl2AvPd1L25AiU/+d2BNfRvAbqc5urWIOgos1bgGE8YV8IkT2C
	TgSE/9aXV2R0b1ORQv1TichBIG3VN21gZ7RMqpI+yq9T1QkxBoqlzxrzro/QVNUdXQpEw==
X-Received: by 2002:a05:6000:2008:b0:45e:8cdc:4ee8 with SMTP id ffacd0b85a97d-45ea3128ccdmr31052715f8f.6.1779716109692;
        Mon, 25 May 2026 06:35:09 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb9asm29456456f8f.27.2026.05.25.06.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 06:35:09 -0700 (PDT)
Message-ID: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
Date: Mon, 25 May 2026 15:35:06 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-4-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-4-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Using Coccinelle, rewrite every struct kernel_param_ops initializer that
> sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> for example:
> 
> @@
> declarer name DEFINE_KERNEL_PARAM_OPS;
> identifier OPS;
> expression SET, GET;
> @@
> - const struct kernel_param_ops OPS = {
> -       .set = SET,
> -       .get = GET,
> - };
> + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> 
> Using the macro for initialization means future changes can manipulate
> the struct layout and callback prototypes without having to change every
> initializer.

Nit: For consistency, I suggest also converting the few remaining
kernel_param_ops instances that specify only .set and no .get, such as
simdisk_param_ops_filename.

-- 
Thanks,
Petr
