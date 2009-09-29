From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Mon, 28 Sep 2009 19:25:28 -0700
Message-ID: <4AC17018.4040600@zytor.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>	
	<20090919224430.GB9567@kroah.com>	
	<1253419185.3253.21.camel@ank32.eng.vmware.com>	
	<20090920074247.GA5733@elte.hu>	
	<1253647845.10565.20.camel@ank32.eng.vmware.com>	
	<4AB9CE66.1030504@redhat.com>
	<1254185107.13456.32.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1254185107.13456.32.camel@ank32.eng.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akataria@vmware.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 09/28/2009 05:45 PM, Alok Kataria wrote:
> +	bool "VMI Guest support [will be deprecated soon]"
> +	default n

This is incorrect use of the word "deprecated"... it's *already*
deprecated (a word which pretty much means the opposite of "recommended".)

As far as "default n" is concerned... this is usually not necessary; "n"
is the default unless anything else is specified.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
