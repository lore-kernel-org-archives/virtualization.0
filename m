From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Remove -static from Documentation/lguest/Makefile
Date: Sun, 22 Jul 2007 21:09:33 +1000
Message-ID: <1185102573.6344.95.camel__20947.9255405769$1185102732$gmane$org@localhost.localdomain>
References: <200707192313.44106.caglar@pardus.org.tr>
	<1184932973.10380.293.camel@localhost.localdomain>
	<46A0D720.9000204@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46A0D720.9000204@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: caglar@pardus.org.tr, LKML <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-07-20 at 08:39 -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > How's this?
> > ===
> > Link lguest example launcher non-static
> >
> > S.Caglar Onur points out that many distributions don't ship a static
> > zlib.  Unfortunately the launcher currently maps virtual device memory
> > where shared libraries want to go.
>
> The technique I used in Valgrind was to have a small core program which
> links up high, which then uses mmap to reserve all the client (guest)
> address space, and then dlopens any other libraries, which are
> guaranteed to be loaded high.
> 
> There are a number of subtleties, of course.  You need to make the
> initial stub static, but some versions of glibc have difficulties with
> having static programs use dlopen.  And it means you need to use dlsym
> and do all your library function accesses indirectly, which may not be a
> problem for a relatively simple library like libz.

The other option is to simply mmap the memory and device descriptors,
then tell the kernel the offset.  This means no more linking tricks at
all, but I'd have to check what limit this would impose on maximum guest
physical memory.

And such a significant change is not 2.6.23 material, of course.
Rusty.
