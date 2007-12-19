From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] remove __init modifier from header declaration
Date: Wed, 19 Dec 2007 11:12:36 +0100
Message-ID: <20071219101236.GB3521__46113.1189637401$1198059329$gmane$org@elte.hu>
References: <11979967763153-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <11979967763153-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber de Oliveira Costa <gcosta@redhat.com> wrote:

> This patch removes the __init modifier from an extern function 
> declaration in acpi.h.
> 
> Besides not being strictly needed, it requires the inclusion of 
> linux/init.h, which is usually not even included directly, increasing 
> header mess by a lot.

thanks, applied.

btw., people have been talking about reducing the include file mess for 
nearly a decade now, but it didnt get that much better - at least not in 
include/asm-x86/*.h. So include file dependency flattening patches would 
be more than welcome as well. (and unlike unification patches they have 
no expectation of being 100% perfect, so a natural ping-pong of fixes, 
until the changes are fully correct, would be natural.)

	Ingo
