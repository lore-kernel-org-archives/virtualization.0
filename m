From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Fri, 09 Feb 2007 22:00:12 +1100
Message-ID: <1171018812.2718.66.camel@localhost.localdomain>
References: <1171012296.2718.26.camel@localhost.localdomain>
	 <1171012458.2718.30.camel@localhost.localdomain>
	 <1171012693.2718.37.camel@localhost.localdomain>
	 <1171012761.2718.40.camel@localhost.localdomain>
	 <1171012827.2718.42.camel@localhost.localdomain>
	 <20070209013518.e75d5036.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965596AbXBILA6@vger.kernel.org>
In-Reply-To: <20070209013518.e75d5036.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>, Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-09 at 01:35 -0800, Andrew Morton wrote:
> On Fri, 09 Feb 2007 20:20:27 +1100 Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > +#define log(...)					\
> > +	do {						\
> > +		mm_segment_t oldfs = get_fs();		\
> > +		char buf[100];				\
> > +		sprintf(buf, "lguest:" __VA_ARGS__);	\
> > +		set_fs(KERNEL_DS);			\
> > +		sys_write(1, buf, strlen(buf));		\
> > +		set_fs(oldfs);				\
> > +	} while(0)
> 
> Due to gcc shortcomings, each instance of this will chew an additional 100
> bytes of stack.  Unless they fixed it recently.  Is a bit of a timebomb.  I
> guess ksaprintf() could be used.
> 
> It also looks a bit, umm, innovative.

It's also unused 8)

It's an extremely useful macro for doing grossly invasive logging of the
guest.  I'll drop it if you prefer.

Cheers,
Rusty.
