Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AC3E3156
	for <virtualization@lists.linux.dev>; Tue,  2 Jun 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405500; cv=none; b=SB3sXB02fQkcFCG9V9CUI5Jq1aiCRA425FP1tJJBF01z85IsQmoVyqhUyDr/D0LfJEzz9qKJTb8TvS8W2/Xbc1MSOGkqLRG4F6pPXM/mVm75vyd4VNz4hiLXGFzyHPeFrB24uyuc3kXcvkWanPwSsBqzEk+8f57YmYkPJh2ymqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405500; c=relaxed/simple;
	bh=Lv88enNvVjptEHx4RPDpSYkoiYl4NHCAht/k1YwYRy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esmECfRY21hpRgQl2shzZ27+VwBC+FgXmRb4qUy0OCS0E2EqsN6uVhbBNaV8Yxhr4V/kv35fyfjQz5Etwc1Na9LLKsB0FzptSM17F6ma+/3HEyU69iLHlD/8B2oUtoEcf2RBsyxTgXL1sai6husMeKSN2qgjYBylYVjd8YuDBpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgfdSfsS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgfdSfsS"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45efa80e0afso2377667f8f.2
        for <virtualization@lists.linux.dev>; Tue, 02 Jun 2026 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405496; x=1781010296; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/8nMdqnIqVIuE86ZCCEmz0EQ1iXOszPXfKX9VZoGH4=;
        b=PgfdSfsSQFmbGwSCSw4Pcl2uB3HjER0Jxi5vlZ9T8m8AEjEG8PuUNHT1hCegGIshya
         ktLvHoReAGwKghARpWPuAXjEkmnG5NtlB9O/MtDhbRvnDJzMl/NMnxopg3nF+O7Clpxg
         xMsgV6djAjOxS6CrQ4aaumjGCScQVErX80qXLpvkyS20u7G49NB0mysI4Ps0GPxgoCby
         /Lj+gNSelkVdMoZwNqUA9mzt4TpY/j9b512XcUPTioH6A5jaKlHBpgqtZ3F/m+GH5ugZ
         0KgClzXksE+13bPAByyJ31z9cd4UX5H2Qb//MAV8NssrEAaIwrC1g3tpSfBQiKZvyzz8
         HotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405496; x=1781010296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/8nMdqnIqVIuE86ZCCEmz0EQ1iXOszPXfKX9VZoGH4=;
        b=eu7im/wfn+ZxqIzKvMZJ/FVKG0kkdrKkdRDD1zFASVYkg7ffc5VZEogqh12Hd7h0ke
         bqcK/GQyNcTEED1Dcq6oP4eifKX+8/d3QtlsrO9lW4k5mnXlh/zAzNEADqOkXjl6+VXq
         6ecbCdOeVF3ZXMC1iab8L4X6GZxpHwiiKFfI1h/IAAjfLSbMzpQ/yd1lwec59ZX898AV
         EdAfwAk2u6FxyufHfipgzzAyh85EB1qwItXHtxQb1M5p79pHD4X9VEUA4zY+dJWQQNbP
         sUAMBcaj/Sl+6rlcBcn4C4KvxZBCmphoQXXYMr5fWqxGf7CjAX0O+KqdfrnR5djQC/55
         jiYA==
X-Forwarded-Encrypted: i=1; AFNElJ8T25E/2eL0DCjLAdy681wqQoavJr4S5m7E54cj6J8m+cyqISTR3YU1c+YgdnmyJ+yvKeuvhKb+rV56XCoClQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjsxPHqnZR62hb3MfI+rzBQKPnxSp62A8Ufz5pRnPR0qAq8tx9
	ZjpoZiG/zfAp4kfZ1h3VydoIkDQ0Khf6Lo+zcvgkKSjZhowFT5vsrOnQ
X-Gm-Gg: Acq92OHQokP4KlMOrg5xDIJITGL/kU1nzGaqFJmqYVvzD6UcIuMtnMxY/YOZCI5dpo2
	TQjmIY7+6EIUlJoRcFjOLOgb5qBNsKTuJt9tIiAMiYP/0QvQqV+ogk5JHfhoCaQoq8Ai94JoRa7
	lK5eyWWvEM3WrbPw3+65qGxbMv0UV4bB06hDyyNzi28OLH+Hp/4iu/KWUR51hW+wgn9N5N1gcT9
	FSfHm9qEb2pHNWTGflOYnGSfoePemwrBk7RHuH+CHu/LTZPKH2LmbvcuJ41GElf/gE+INdzmBwg
	Ys0M0DHuyaSXu8VEUdessZnec0TgsBT6IoQpvsdhgQ1IBcKzm/wGvLTn0QzhaP2173U5WKy5+MA
	vsAmBMnqh5h2YNk9FtKRgYBGujhduTsY7W2JyvDak3AW8JHE8wNOwOqjajtyo8Ci9c5t/KD6hyi
	xNczyHwmGotTVWeEfGtQGN6brzLf3oBrGtpMJQnNipgNg8ujGVdv+0FArCEAf6WeHZVsZkbTmsE
	qzppqEdLg==
X-Received: by 2002:a05:600c:8105:b0:490:b072:1be6 with SMTP id 5b1f17b1804b1-490b0721e0amr76565325e9.25.1780405495119;
        Tue, 02 Jun 2026 06:04:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b834esm33184301f8f.11.2026.06.02.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:04:54 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:04:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org, Petr Pavlu
 <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, Gabriel Somlo
 <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Baron
 <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie
 <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, "David E. Box"
 <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Georgia Garcia <georgia.garcia@canonical.com>,
 kvm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, apparmor@lists.ubuntu.com,
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
Subject: Re: [PATCH 01/11] params: bound array element output to the
 caller's page buffer
Message-ID: <20260602140451.2e3e6622@pumpkin>
In-Reply-To: <ah699hwLxIIOZ0-7@ashevche-desk.local>
References: <20260521133315.work.845-kees@kernel.org>
	<20260521133326.2465264-1-kees@kernel.org>
	<ah699hwLxIIOZ0-7@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 14:26:46 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, May 21, 2026 at 06:33:14AM -0700, Kees Cook wrote:
> > 
> > param_array_get() appends each element's string representation into the
> > shared sysfs page buffer by passing buffer + off to the element getter.
> > 
> > That works for getters that only write a small bounded string, but
> > param_get_charp() and similar helpers format against PAGE_SIZE from the
> > pointer they receive. Once off is non-zero, an element getter can
> > therefore write past the end of the original sysfs page buffer.
> > 
> > Collect each element into a temporary PAGE_SIZE buffer first and then
> > copy only the remaining space into the caller's page buffer.  
> 
> ...
> 
> > +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);  
> 
> get_free_page() (or how it is called)?

The kmalloc() should be faster and I think has to be aligned.
There is another patch set to replace get_free_pages() with kmalloc().

Although all these 'show' functions should really head to using a safer
interface.
Although, at the moment, it is really difficult to find the ones that
are guaranteed to be passed a page aligned buffer.

-- David

> 
> > +	if (!elem_buf)
> > +		return -ENOMEM;
> > +
> >  	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> > -		/* Replace \n with comma */
> > -		if (i)
> > -			buffer[off - 1] = ',';
> >  		p.arg = arr->elem + arr->elemsize * i;
> >  		check_kparam_locked(p.mod);
> > -		ret = arr->ops->get(buffer + off, &p);
> > +		ret = arr->ops->get(elem_buf, &p);
> >  		if (ret < 0)
> > -			return ret;
> > +			goto out;
> > +		ret = min(ret, (int)(PAGE_SIZE - 1 - off));  
> 
> It's usually discouraged to use castings in min/max/clamp. Can we make ret long
> or do something different here?
> 
> > +		if (!ret)
> > +			break;  
> 
> > +		/* Replace the previous element's trailing newline with a comma. */
> > +		if (i)
> > +			buffer[off - 1] = ',';  
> 
> Can't we do this after with help of strreplace()?
> 
> > +		memcpy(buffer + off, elem_buf, ret);
> >  		off += ret;
> > +		if (off == PAGE_SIZE - 1)
> > +			break;
> >  	}
> >  	buffer[off] = '\0';
> > -	return off;
> > +	ret = off;
> > +out:
> > +	kfree(elem_buf);
> > +	return ret;  
> 

