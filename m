From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 07:57:47 -0700
Message-ID: <1157122667.28577.69.camel@localhost.localdomain>
References: <20060901110948.GD15684@skybase>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750739AbWIAO6I@vger.kernel.org>
In-Reply-To: <20060901110948.GD15684@skybase>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu, Andy Whitcroft <apw@shadowen.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 13:09 +0200, Martin Schwidefsky wrote:
> +#define PG_state_change                21      /* HV page state is changing. */
> +#define PG_discarded           22      /* HV page has been discarded. */ 

We're already desperately short on page flags on 32-bit architectures.
It seems a wee bit silly to add two arch-generic flags for what is a
very specialized arch-specific feature at this point.

I know that there are 32-bit s390 kernels, but would this be a
reasonable feature to restrict to only 64-bit kernels?  That might be a
decent compromise.

-- Dave
