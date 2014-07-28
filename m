From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86, paravirt: BUG_ON on {rd,wr}msr exceptions
Date: Mon, 28 Jul 2014 12:18:10 -0700
Message-ID: <53D6A1F2.5070404@zytor.com>
References: <1406574278-23946-1-git-send-email-ehabkost@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1406574278-23946-1-git-send-email-ehabkost@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Eduardo Habkost <ehabkost@redhat.com>, virtualization@lists.linux-foundation.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 07/28/2014 12:04 PM, Eduardo Habkost wrote:
> When CONFIG_PARAVIRT is enabled, the kernel is ignoring exceptions on
> the {rd,wr}msr instructions. This makes serious issues (either on the
> guest kernel, or on the host) be silently ignored, and is different from
> the native MSR code (which does not ignore the exceptions).
> 
> As paravirt.h already includes linux/bug.h, I don't see what was the
> original issue preventing BUG_ON from being used.
> 
> Change rdmsr(), wrmsr(), and rdmsrl() to BUG_ON() on errors.

How much does this bloat the kernel?

#include <stdparavirtrant.h>

	-hpa
