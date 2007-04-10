From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Clean up x86 control register and MSR macros (corrected)
Date: Tue, 10 Apr 2007 20:00:23 +0200
Message-ID: <200704102000.23789.ak__45997.5605750971$1176234672$gmane$org@suse.de>
References: <200704101736.l3AHaiUv027830@tazenda.hos.anvin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704101736.l3AHaiUv027830@tazenda.hos.anvin.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 10 April 2007 19:36:44 H. Peter Anvin wrote:
> This patch is based on Rusty's recent cleanup of the EFLAGS-related
> macros; it extends the same kind of cleanup to control registers and
> MSRs.

Applied. Although it was somewhat painful because there were other
changes in the tree you diffed against.
 =

> It also unifies these between i386 and x86-64; at least with regards
> to MSRs, the two had definitely gotten out of sync.

Intentionally, x86-64 doesn't care about 32bit only CPUs.

-Andi
