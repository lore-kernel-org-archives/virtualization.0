Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C02EB5CD
	for <virtualization@lists.linux.dev>; Tue,  2 Jun 2026 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403630; cv=none; b=EtXKhGvxw+nVePzkgN1r4kzg8EqC4RVEqQjtMV32KfKy9lcKNzxAKXRFOpI6tWKKBZRLrh6tXNwdiwYcxcFHXw/JHI5e+3ECeCM9F8MVNWd4uSf9Ddz+/kIjHBo3u1x5n3J8msT1b9zly2X8a/979zKAgRIu5aigrWO3/5i/V6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403630; c=relaxed/simple;
	bh=Dt7ynl7RjMDm10IwkFbV7yaqQ3XCHkv1Jhl7dMLZbl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsDvI7GQYVSmfjdeJ+G5EGQiSeq/VJ7w0dPRiXjCTY0wRAcK4yFjKdZBceeKNXi+QVySDDhEWYxyoMFSJ/mHuSnx6AZGqEEef4W4QCQunh9xsoqPSui/6wwatxC+CNJ9/uFvyLKF/GmA+SYuVZhQs1oW5JrPnDDBpACXinSOtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GkT7ogZk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GkT7ogZk"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5175b6c4e19so15977611cf.0
        for <virtualization@lists.linux.dev>; Tue, 02 Jun 2026 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780403626; x=1781008426; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=GkT7ogZk1Rmmk6tMn3J94GNNiKowOJPbjADjPgX78EfGUK8vo761MhvbIGMVjw2aGz
         oKnejFHRW0DoCevLsrrbUFaGbg/jrNoi/nC/0nkc4c/clhedrNbLYfA76SKOqxy+O81B
         YgcsIoF8IXMV4CsyqtNAbJFvHfISxgCwhqA4uqCypJz0t8Di1IrBO5dH/9hiOS4cTElD
         YXsDJKY1fg9luuh7s0iO6uwdBMqYqkEvj5uTuwwVXnQ61RaRK806H+2Tx2lHp9vT0qaZ
         dDU5uNDz9f3HRPB36g+xzVz13ktPQkwbFX+iGDtvVgRTcTfSKhaSjdfnJQJphVUOwMhq
         mfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780403626; x=1781008426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fuMy8ZTlB4sZmM4SRNfS45Rtpr0e2y/Uhs3uZMD108=;
        b=ED+Ghc1vEMALfJXfa5SGCZGIfVXwB8v46PlC/5T9BUzGgewohfkFrMeAmrfVcpP0wG
         LXT2meP9pCotqozsg7pmy28O1HtGzNrYvc6DFa7pcXEnRXwJo2Ah3XPJNEjSw07FlITV
         G2n86eEXULoXjaLOQYKuzTkl/mFKopJ3JGzGpepZOwo4DSa+O9pBLvdHDR9CjSGTQW30
         Wj6ZgaPHePoFXNQ66bj7RjPMQtEfS9pUwN63AI3txGhxhJAPgUNEvYTCO/n45/hVxe/b
         pN1HWg+lCbJnKpw2NkY71IzDJgKZ+Tax+GuJBaMMte0t5Zw0Fn5FGmxxm5OTT2cYsIFm
         3x1A==
X-Forwarded-Encrypted: i=1; AFNElJ+8F42X1iGw3xwUTT9VBMzxFxseOXXlW6pWUXE2lKjxAcwvC+kyjlzcIslrgNsDdEwjLeoys1OTFXyL81qacA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yybs/g/Z3TL9DIIqfG7AubDDhT5GH7WuqAmrAeL4z1KX+hKIMdA
	k84t2UKJyzdXqlq5523IMUu9a/PzcfOhQCkBe/LFoJJ63R07EUtTaEQJt/IRFXgWkuk=
X-Gm-Gg: Acq92OE6p0su7GKCJ1HVNfdU1NZmdL+8IIxJKkAs1MbiKyVHd7q4ldiqXNMIwtT4GKu
	/Zg1QESsHiN8uND4o5AXIT6/TF0Tb5zlVqxEGqNLfrkClY96vcbPrcSs2qpTry+9BWsxnUPGV3g
	YWQmetNsoPtdbDhsp3qzgBWy/FJYnH++ZxeEB8gdavJpTmSEFmZdEEU4IDytxfkhaBOEH4Iv5Vu
	tq0qa49ht+VRIjD6gAmcQemJwCgezE9eFwboU8kQ3kEM8lSiHtklYOhZiMXAsKnZsj6xos9wGgt
	wZISiLO414kVq+mA/ulO5wETHIniv7I3QUPpgA4hYGZTBMUnDGWAOlOOo7PDInVXEASmqZi/gnR
	U94eu++KmzZYcdvNo9UyxUGK85dU4VULe1X4cI0nIBEQ7If1X68Ly7ilrFxKlLdPC1FpRFKSLbO
	TMYysPa8qDP7OE41jcdZswKBQSZhS8tT67/FvO0rTnWZp60IzOcleZ48ryAX/l2PFzVQkCuqMhL
	814w3Fr2bVPA7sy
X-Received: by 2002:a05:622a:190a:b0:509:2527:d789 with SMTP id d75a77b69052e-5173a5c05ecmr228232631cf.6.1780403625864;
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741d6a240sm78686221cf.18.2026.06.02.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 05:33:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUOJU-00000003m5x-3DKO;
	Tue, 02 Jun 2026 09:33:44 -0300
Date: Tue, 2 Jun 2026 09:33:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, stable@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the caller's
 page buffer
Message-ID: <20260602123344.GG2487554@ziepe.ca>
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-1-kees@kernel.org>
 <ah699hwLxIIOZ0-7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah699hwLxIIOZ0-7@ashevche-desk.local>

On Tue, Jun 02, 2026 at 02:26:46PM +0300, Andy Shevchenko wrote:
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

I thought modern mm guidance was to use kmalloc whenever possible and
not use get_free_page() unless you intend to use the struct page bits?

Jason
