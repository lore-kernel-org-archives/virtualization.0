From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 2/4] clean up identify_cpu
Date: Sat, 7 Apr 2007 20:39:16 +0200
Message-ID: <20070407183916.GA30811@uranus.ravnborg.org>
References: <20070406224152.556848893@goop.org>
	<20070406224204.782242327@goop.org>
	<20070407021401.a993892b.akpm@linux-foundation.org>
	<4617D2D1.7040202@goop.org>
	<20070407105947.15128675.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070407105947.15128675.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Apr 07, 2007 at 10:59:47AM -0700, Andrew Morton wrote:
> On Sat, 07 Apr 2007 10:20:17 -0700 Jeremy Fitzhardinge <jeremy@goop.org> =
wrote:
> =

> >  I don't have a x86-64 compile environment on
> > hand, so the 64 bits are completely untested
> =

> http://userweb.kernel.org/~akpm/cross-compilers/

Does the alpha toolchain work for you?

For defconfig I get:
  CC      arch/alpha/kernel/core_cia.o
{standard input}: Assembler messages:
{standard input}:351: Error: macro requires $at register while noat in effe=
ct
{standard input}:376: Error: macro requires $at register while noat in effe=
ct
{standard input}:400: Error: macro requires $at register while noat in effe=
ct
{standard input}:419: Error: macro requires $at register while noat in effe=
ct
{standard input}:474: Error: macro requires $at register while noat in effe=
ct
{standard input}:499: Error: macro requires $at register while noat in effe=
ct
{standard input}:523: Error: macro requires $at register while noat in effe=
ct
{standard input}:542: Error: macro requires $at register while noat in effe=
ct
make[2]: *** [arch/alpha/kernel/core_cia.o] Error 1
make[1]: *** [arch/alpha/kernel] Error 2
make: *** [_all] Error 2

Same happens when I compile the same version direct from Dan's crosstool.

	Sam
