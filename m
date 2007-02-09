From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Fri, 9 Feb 2007 01:35:18 -0800
Message-ID: <20070209013518.e75d5036.akpm@linux-foundation.org>
References: <1171012296.2718.26.camel@localhost.localdomain>
	<1171012458.2718.30.camel@localhost.localdomain>
	<1171012693.2718.37.camel@localhost.localdomain>
	<1171012761.2718.40.camel@localhost.localdomain>
	<1171012827.2718.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946267AbXBIJfk@vger.kernel.org>
In-Reply-To: <1171012827.2718.42.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>, Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 09 Feb 2007 20:20:27 +1100 Rusty Russell <rusty@rustcorp.com.au> wrote:

> +#define log(...)					\
> +	do {						\
> +		mm_segment_t oldfs = get_fs();		\
> +		char buf[100];				\
> +		sprintf(buf, "lguest:" __VA_ARGS__);	\
> +		set_fs(KERNEL_DS);			\
> +		sys_write(1, buf, strlen(buf));		\
> +		set_fs(oldfs);				\
> +	} while(0)

Due to gcc shortcomings, each instance of this will chew an additional 100
bytes of stack.  Unless they fixed it recently.  Is a bit of a timebomb.  I
guess ksaprintf() could be used.

It also looks a bit, umm, innovative.
