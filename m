From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Clean up mach_reboot_fixups
Date: Wed, 28 Mar 2007 22:14:51 +0200
Message-ID: <200703282214.52612.ak@suse.de>
References: <46099709.2000304@goop.org> <200703282154.04245.ak@suse.de>
	<460ACC05.4020401@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <460ACC05.4020401@goop.org>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Stephane Eranian <eranian@hpl.hp.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 28 March 2007 22:11, Jeremy Fitzhardinge wrote:
> Two cleanups:
>  - reboot_fixups.h is entirely i386-dependent, so put it in asm-i386
>  - use a weak version rather than ifdeffery
> =

> [ Andi - the machine_ops probably depends on this, but only in a minor
>   context-clash way. ]

Sorry I actually had it already, but forgot about it

-Andi
