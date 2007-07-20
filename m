From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Remove -static from Documentation/lguest/Makefile
Date: Fri, 20 Jul 2007 08:39:12 -0700
Message-ID: <46A0D720.9000204@goop.org>
References: <200707192313.44106.caglar@pardus.org.tr>
	<1184932973.10380.293.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184932973.10380.293.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: caglar@pardus.org.tr, LKML <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> How's this?
> ===
> Link lguest example launcher non-static
>
> S.Caglar Onur points out that many distributions don't ship a static
> zlib.  Unfortunately the launcher currently maps virtual device memory
> where shared libraries want to go.
>
> The solution is to pre-scan the args to figure out how much memory we
> have, then allocate devices above that, rather than down from the top.
>   

The technique I used in Valgrind was to have a small core program which
links up high, which then uses mmap to reserve all the client (guest)
address space, and then dlopens any other libraries, which are
guaranteed to be loaded high.

There are a number of subtleties, of course.  You need to make the
initial stub static, but some versions of glibc have difficulties with
having static programs use dlopen.  And it means you need to use dlsym
and do all your library function accesses indirectly, which may not be a
problem for a relatively simple library like libz.

    J
