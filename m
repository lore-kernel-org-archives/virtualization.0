From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 10/21] Xen-paravirt: add hooks to intercept mm creation and destruction
Date: Thu, 22 Feb 2007 20:16:44 +0000
Message-ID: <20070222201644.GA4938@ucw.cz>
References: <20070216022449.739760547@goop.org> <20070216022531.267584466@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751828AbXBVUQ7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070216022531.267584466@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi!

> @@ -126,6 +126,12 @@ struct paravirt_ops
>  	void (*io_delay)(void);
>  	void (*const_udelay)(unsigned long loops);
>  
> +	void (fastcall *activate_mm)(struct mm_struct *prev,
> +				     struct mm_struct *next);
> +	void (fastcall *dup_mmap)(struct mm_struct *oldmm, 
> +				  struct mm_struct *mm);
> +	void (fastcall *exit_mmap)(struct mm_struct *mm);
> +

Why the fastcall stuff?  Why is io_delay different from activate_mm in
this regard?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
