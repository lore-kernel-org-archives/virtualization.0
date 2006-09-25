From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
Date: Sun, 24 Sep 2006 22:25:57 -0700
Message-ID: <45176865.7020300@goop.org>
References: <1158925861.26261.3.camel@localhost.localdomain>	
	<1158925997.26261.6.camel@localhost.localdomain>	
	<1158926106.26261.8.camel@localhost.localdomain>	
	<1158926215.26261.11.camel@localhost.localdomain>	
	<1158926308.26261.14.camel@localhost.localdomain>	
	<1158926386.26261.17.camel@localhost.localdomain>	
	<4514663E.5050707@goop.org>	
	<1158985882.26261.60.camel@localhost.localdomain>	
	<45172AC8.2070701@goop.org>	
	<1159146974.26986.30.camel@localhost.localdomain>	
	<45173287.8070204@goop.org>
	<1159152678.26986.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1159152678.26986.38.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> That can't happen, since 0xc100000 is not in the kernel address space.
> 0xc1000000 is though, perhaps that's what you meant?
>   =


Yes, it is.  Though it doesn't actually make any material difference to =

my argument.

>> So, in this case the %gs base will be loaded with 0xc100000-0xc0431100 =
=3D =

>> 0x4bccef00
>>     =

>
>   =

> A negative offset, exactly, which can't happen, as I said.
0x4bccef00 is positive. The correct number is 0xc1000000-0xc0431100 =3D =

0xbcef00

The %gs:per_cpu__foo addressing mode still calculates =

0xbcef00+0xc0433800, which is still a subtraction.  My essential point =

is that *all* kernel addresses (=3Dkernel symbols) are negative, so using =

them as an offset from a segment base (any segment base) is a =

subtraction, which requires a 4G limit.

    J
