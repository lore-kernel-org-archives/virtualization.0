From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest problem on boot of guest kernel
Date: Sat, 02 Jun 2007 20:27:39 +1000
Message-ID: <1180780059.9228.72.camel@localhost.localdomain>
References: <Pine.LNX.4.60.0706011704240.786@rtl14.hofr.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0706011704240.786@rtl14.hofr.at>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-06-01 at 17:25 +0200, Nicholas Mc Guire wrote:
> Hi !
> 
> Kenrel 2.6.21 (kernel.org)
> Patch  lguest-2.6.21-254.patch
> Distro Slackware 11.0
> GCC    3.4.6
> GLIBC  2.3.6
> HW     model name      : AMD Duron(tm) procu{s{
> 
> 
> Module                  Size  Used by
> tun                     7680  0
> lg                     54600  0
> 
> 
>   just started playing with lguest - patching, compiling and booting the
>   host-kernel goes ok - compiling lguest is ok as well after hardcodeing
>   SIOCBRADDIF - but on the first boot attempt of a guest linux I get:
> 
> root@darkstar:/usr/src/linux-2.6.21# Documentation/lguest/lguest
> 64m vmlinux --tunnet=192.168.2.1 --block=../root_fs root=/dev/lgba
> lguest: unhandled trap 6 at 0xc0117903 (0x0)
> 
>   this should be in "c01178db T reserve_top_address" - any idea what could 
> be wrong ?

Hi Nicholas!

	You're the second one to hit this in as many days.  I just uploaded an
updated patch, but the summary is that you have to turn off COMPAT_VDSO
for the 2.6.21 patch.  (You can actually leave it on in the host, it's
just the guests...)

Thanks for the bug report!
Rusty.
