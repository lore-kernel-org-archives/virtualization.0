From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v3] x86: use a read-only IDT alias on all CPUs
Date: Thu, 11 Apr 2013 04:50:14 -0700
Message-ID: <m261ztxp55.fsf__13563.2543162957$1365681599$gmane$org@firstfloor.org>
References: <20130410192422.GA17344@www.outflux.net>
	<20130411083634.GA11824@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130411083634.GA11824@gmail.com> (Ingo Molnar's message of
	"Thu, 11 Apr 2013 10:36:34 +0200")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Alex Shi <alex.shi@intel.com>, Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <borislav.petkov@amd.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, kernel-hardening@lists.openwall.com, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar <mingo@kernel.org> writes:
>
> This looks very nice to me now. Peter, any objections?

it seems pointless without randomized main kernel text location, because
the IDT will be still at a known per kernel fixed writable location in
the direct mapping.

As long as such randomization is not there it just wastes a TLB entry.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
