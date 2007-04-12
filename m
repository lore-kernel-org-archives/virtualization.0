From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 3/4] Pte xchg optimization.patch
Date: Thu, 12 Apr 2007 14:18:09 -0400
Message-ID: <20070412181809.GC25646@redhat.com>
References: <200704120530.l3C5UweV022834@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200704120530.l3C5UweV022834@zach-dev.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, David Rientjes <rientjes@google.com>, Hugh Dickins <hugh@veritas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 11, 2007 at 10:30:58PM -0700, Zachary Amsden wrote:
 > In situations where page table updates need only be made locally, and th=
ere
 > is no cross-processor A/D bit races involved, we need not use the heavyw=
eight
 > xchg instruction to atomically fetch and clear page table entries.  Inst=
ead,
 > we can just read and clear them directly.
 > =

 > This introduces a neat optimization for non-SMP kernels; drop the atomic
 > xchg operations from page table updates.

Would it be feasible to do this using the smp_alternatives stuff?
Given many distros are now shipping SMP-only kernels, it'd be nice
to get that win without using having to rebuild their kernels.

	Dave

-- =

http://www.codemonkey.org.uk
