From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 2/4] clean up identify_cpu
Date: Sat, 07 Apr 2007 10:20:17 -0700
Message-ID: <4617D2D1.7040202@goop.org>
References: <20070406224152.556848893@goop.org>	<20070406224204.782242327@goop.org>
	<20070407021401.a993892b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070407021401.a993892b.akpm@linux-foundation.org>
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

Andrew Morton wrote:
> x86_64 uses this too.
>
> WARNING: arch/x86_64/kernel/built-in.o - Section mismatch: reference to .=
init.text:mtrr_bp_init from .text.identify_cpu after 'identify_cpu' (at off=
set 0x655)
>   =


OK, two patches to follow: a x86-64 variant of the bugs.h cleanup, and a
replacement for this patch. I don't have a x86-64 compile environment on
hand, so the 64 bits are completely untested, but they *look* they
should work.

J
