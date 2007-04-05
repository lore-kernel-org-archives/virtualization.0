From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Thu, 05 Apr 2007 11:03:11 -0700
Message-ID: <461539DF.6010502@zytor.com>
References: <461447F2.9010807@zytor.com>	<20070405011640.GL19575@sequoia.sous-sol.org>
	<46144FA6.1000802@zytor.com> <4614867C.4060506@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4614867C.4060506@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
 > H. Peter Anvin wrote:
 >> http://www.kernel.org/pub/linux/kernel/people/hpa/new-cpuid-msr.patch
 >
 > The requested URL /pub/linux/kernel/people/hpa/new-cpuid-msr.patch =

was > not found on this server.

Fixed.

>> It's not *quite* that easy.  The assembly code around this is pretty =

>> extensive, because it has to stand on its head in order to present the =

>> proper register image.
> =

> Having just stood on my head for 55 breaths, might I suggest we =

> implement a binary equivalent CPUID paravirt-ops wrapper; then the =

> assembly code can just call CPUID and we can redefine it to call to a =

> stub, which makes the pv-ops CPUID call, the puts the outputs back in =

> the proper registers.
> =

> The VMI ROM CPUID is binary identical in register format with the native =

> instruction, so it need not do a headstand.  For the others,
> =

[snip]

This code is almost entirely identical to the setgpr_wrapper in the =

patch (except for the fact that setgpr_wrapper sets and captures *ALL* =

the GPRs), and it seems rather pointless to use another wrapper.  It =

takes a pointer to an entrypoint (default to "cpuid; ret" in the CPUID =

case), so it should do what you need.

	-hpa
