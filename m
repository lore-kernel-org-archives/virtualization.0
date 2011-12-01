From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Android-virt] [Embeddedxen-devel] [Xen-devel] [ANNOUNCE] Xen
	port to Cortex-A15 / ARMv7 with virt extensions
Date: Thu, 1 Dec 2011 16:44:40 +0000
Message-ID: <201112011644.41101.arnd@arndb.de>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
	<201112011542.19377.arnd@arndb.de> <20111201160241.GH27394@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111201160241.GH27394@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, Ian Campbell <Ian.Campbell@citrix.com>, Pawel Moll <Pawel.Moll@arm.com>, Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "android-virt@lists.cs.columbia.edu" <android-virt@lists.cs.columbia.edu>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "embeddedxen-devel@lists.sourceforge.net" <embeddedxen-devel@lists.sourceforge.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 01 December 2011, Catalin Marinas wrote:
> On Thu, Dec 01, 2011 at 03:42:19PM +0000, Arnd Bergmann wrote:
> > On Thursday 01 December 2011, Catalin Marinas wrote:
> > How do you deal with signed integer arguments passed into SVC or HVC from
> > a caller? If I understand the architecture correctly, the upper
> > halves of the argument register end up zero-padded, while the callee
> > expects sign-extension.
> 
> If you treat it as an "int" (32-bit) and function prototype defined
> accordingly, then the generated code only accesses it as a W (rather
> than X) register and the top 32-bit part is ignored (no need for
> sign-extension). If it is defined as a "long" in the 32-bit world, then
> it indeed needs explicit conversion given the different sizes for long
> (for example sys_lseek, the second argument is a 'long' and we do
> explicit sign extension in the wrapper).

Ok, so it's actually different from most other 64 bit architectures, which
normally operate on 64-bit registers and expect the caller to do the
correct sign-extension.

Doing the sign-extension for long arguments then falls into the same
category as long long and unsigned long long arguments, which also need
a wrapper, as you mentioned. Strictly speaking, we only need to do it
for those where the long argument has a meaning outside of the 0..2^31
range, e.g. io_submit can only take small positive numbers although
the type is 'long'.

What about unsigned long and pointer? Can we always rely on the upper
half of the register to be zero-filled when we get an exception from 32
bit into 64 bit state, or do we also have to zero-extend those?

	Arnd
