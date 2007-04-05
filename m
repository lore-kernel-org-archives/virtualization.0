From: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: New CPUID/MSR driver; virtualization hooks
Date: Thu, 5 Apr 2007 11:48:32 +1000
Message-ID: <20070405014832.GU12768@bakeyournoodle.com>
References: <461447F2.9010807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <461447F2.9010807@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 04, 2007 at 05:50:58PM -0700, H. Peter Anvin wrote:
> I have finally gotten off the pot and finished writing up my new =

> CPUID/MSR driver, which contains support for registers that need =

> arbitrary GPRs touched.  For i386 vs x86-64 compatibility, both use an =

> x86-64 register image (16 64-bit register fields); this allows 32-bit =

> userspace to access the full 64-bit image if the kernel is 64 bits.
> =

> Anyway, this presumably requires new paravirtualization hooks.  The =

> patch is at:
> =

> http://www.kernel.org/pub/linux/kernel/people/hpa/new-cpuid-msr.patch

I think you mean?

http://www.kernel.org/pub/linux/kernel/people/hpa/new-msr-cpuid.patch

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
