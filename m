From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/7] Add APIC accessors to paravirt-ops.
Date: Sun, 29 Oct 2006 08:31:20 -0800
Message-ID: <200610290831.21062.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061029024607.401333000@sous-sol.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de
List-Id: virtualization@lists.linuxfoundation.org


>
>  /* nop stub */
>  static void native_nop(void)
> @@ -382,6 +384,26 @@ static fastcall void native_io_delay(voi
>  	asm volatile("outb %al,$0x80");
>  }
>
> +#ifdef CONFIG_X86_LOCAL_APIC

It would be nicer if you renamed the functions in apic.h to native_apic_*
and then do

#ifdef CONFIG_PARAVIRT
#include <asm/paravirt.h>
#else
#define apic_read native_apic_read
...
#endif

This way we wouldn't get that much duplication.

This might apply to at least some of the other paravirt ops too.

-Andi
