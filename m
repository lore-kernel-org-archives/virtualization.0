From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 19/19] unify set_tss_desc
Date: Thu, 13 Dec 2007 13:46:33 +0100
Message-ID: <20071213124633.GG31699__17675.2553358257$1197550160$gmane$org@bingen.suse.de>
References: <1197511363887-git-send-email-gcosta@redhat.com>
	<11975113672937-git-send-email-gcosta@redhat.com>
	<11975113721808-git-send-email-gcosta@redhat.com>
	<11975113771692-git-send-email-gcosta@redhat.com>
	<11975113821418-git-send-email-gcosta@redhat.com>
	<11975113873364-git-send-email-gcosta@redhat.com>
	<11975113923422-git-send-email-gcosta@redhat.com>
	<11975113961144-git-send-email-gcosta@redhat.com>
	<1197511401733-git-send-email-gc!osta@redhat.com>
	<11975114062948-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11975114062948-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

> +static inline void pack_tss(tss_desc *tss, unsigned long addr,
> +			   unsigned size, unsigned entry)
> +{
> +#ifdef CONFIG_X86_64
> +		set_tssldt_descriptor(tss,
> +			     addr, entry, size);
> +#else
> +		pack_descriptor(tss, (unsigned long)addr,
> +				size,
> +				0x80 | entry, 0);

It would be better if you just unified that first instead of ifdef'ing.
I guess i386 could get a set_tssldt_descriptor() like wrapper
around pack_descriptor(). 

-Andi
