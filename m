From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Lguest
Date: Fri, 29 Jun 2007 22:11:54 +1000
Message-ID: <1183119114.10054.18.camel@localhost.localdomain>
References: <21a166410706281003p79949542t2f90bfe6e2d7bda3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <21a166410706281003p79949542t2f90bfe6e2d7bda3@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matias Zabaljauregui <matias.zabaljauregui@cern.ch>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-06-28 at 19:03 +0200, Matias Zabaljauregui wrote:
> Hello Rusty, 
> 
> I'have just started to read the code (and I'm not an expert kernel
> programmer), but is this condition ok ?
> 
> 
> (function setup_pagetables(), on file Documentation/lguest.c )
> 
>     /* Ideally we map all physical memory starting at page_offset. 
>      * However, if page_offset is 0xC0000000 we can only map 1G of
> physical
>      * (0xC0000000 + 1G overflows). */
> 
>     if (mem > -page_offset)
>         mapped_pages = mem/getpagesize();
>     else
>         mapped_pages = -page_offset/getpagesize(); 

Hi Matias,

	I think so: these are unsigned values, so "-page_offset" is the address
space available for kernel memory (usually 1G).  It's a little
strange-looking, I admit.

Hope that helps,
Rusty.
