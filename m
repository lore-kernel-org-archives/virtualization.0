From: Keir Fraser <keir@xensource.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and
	disable unsupported config options.
Date: Fri, 16 Feb 2007 10:49:10 +0000
Message-ID: <C1FB3CA6.98EC%keir__25863.7284780436$1171623056$gmane$org@xensource.com>
References: <45D56D5A.3000300@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D56D5A.3000300@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Dan Hecht <dhecht@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 08:37, "Dan Hecht" <dhecht@vmware.com> wrote:

> Hmm?  I thought the periodic timer and one-shot timer both generate the
> same VIRQ.  So, how can you mask one without masking the other?
> =

> The tickless idle works since the block hypercall disables the periodic
> timer.  But for dynticks (aka NO_HZ), you'll need to mask the periodic
> timer (even for a running vcpu), while keeping the one-shot timer
> unmasked.  I don't think Xen provides an interface to do that.

There's no interface for this right now, but we can easily add one in a
backward compatible way. This also will not prevent a dyntick kernel from
running on an older Xen -- the guest will then receive to many timer
interrupts, but that should only be a performance concern fixable by
upgrading the hypervisor component of the system.

 -- Keir
