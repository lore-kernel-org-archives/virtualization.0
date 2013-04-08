From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: make IDT read-only
Date: Mon, 08 Apr 2013 15:47:18 -0700
Message-ID: <516348F6.1080902@zytor.com>
References: <20130408224328.GA17641@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130408224328.GA17641@www.outflux.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Alex Shi <alex.shi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <borislav.petkov@amd.com>, Ingo Molnar <mingo@redhat.com>, kernel-hardening@lists.openwall.com, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On 04/08/2013 03:43 PM, Kees Cook wrote:
> This makes the IDT unconditionally read-only. This primarily removes
> the IDT from being a target for arbitrary memory write attacks. It has
> an added benefit of also not leaking (via the "sidt" instruction) the
> kernel base offset, if it has been relocated.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Eric Northup <digitaleric@google.com>

This isn't quite what this patch does, though, right?  There is still a
writable IDT mapping at all times, which is different from a true
readonly IDT, no?

	-hpa
