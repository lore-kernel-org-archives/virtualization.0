From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/4] clean up identify_cpu
Date: Sat, 7 Apr 2007 02:14:01 -0700
Message-ID: <20070407021401.a993892b.akpm@linux-foundation.org>
References: <20070406224152.556848893@goop.org>
	<20070406224204.782242327@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070406224204.782242327@goop.org>
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
Cc: virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 06 Apr 2007 15:41:54 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> identify_cpu() is used to identify both the boot CPU and secondary
> CPUs, but it performs some actions which only apply to the boot CPU.
> Those functions are therefore really __init functions, but because
> they're called by identify_cpu(), they must be marked __cpuinit.
> =

> This patch splits identify_cpu() into identify_boot_cpu() and
> identify_secondary_cpu(), and calls the appropriate init functions
> from each.  Also, identify_boot_cpu() and all the functions it
> dominates are marked __init.

x86_64 uses this too.

WARNING: arch/x86_64/kernel/built-in.o - Section mismatch: reference to .in=
it.text:mtrr_bp_init from .text.identify_cpu after 'identify_cpu' (at offse=
t 0x655)
