From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Clean up x86 control register and MSR macros (corrected)
Date: Wed, 11 Apr 2007 14:13:34 +1000
Message-ID: <1176264814.26372.104.camel__25310.0257985809$1176282905$gmane$org@localhost.localdomain>
References: <200704101736.l3AHaiUv027830@tazenda.hos.anvin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704101736.l3AHaiUv027830@tazenda.hos.anvin.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-04-10 at 10:36 -0700, H. Peter Anvin wrote:
> This patch is based on Rusty's recent cleanup of the EFLAGS-related
> macros; it extends the same kind of cleanup to control registers and
> MSRs.

Thanks hpa, this looks nice.

Cheers,
Rusty.
