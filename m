From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Simplify smp_call_function*() by using common
	implementation
Date: Wed, 28 Mar 2007 21:03:49 +0200
Message-ID: <200703282103.50191.ak@suse.de>
References: <46099709.2000304@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46099709.2000304@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Stephane Eranian <eranian@hpl.hp.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Jan Beulich <jbeulich@novell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 28 March 2007 00:13, Jeremy Fitzhardinge wrote:
> smp_call_function and smp_call_function_single are almost complete
> duplicates of the same logic.  This patch combines them by
> implementing them in terms of the more general
> smp_call_function_mask().

I think I got those already.

-Andi
