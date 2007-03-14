From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 28/34] Xen-pv_ops: Xen SMP guest support
Date: Wed, 14 Mar 2007 08:05:28 -0700
Message-ID: <45F80F38.2080707@goop.org>
References: <20070313233017.933601256@goop.org>
	<20070313233034.586018620@goop.org>
	<20070314132820.GL6209@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070314132820.GL6209@kvack.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Benjamin LaHaise wrote:
> Are you switching mms in order to avoid all of the overhead associated wi=
th =

> flushing an active mm during task exit?  If so, it makes much more sense =
to =

> do this in the generic helper, as it should be a win on x86 and x86-64 =

> where switching to init_mm is relatively low cost given the support for =

> global pages.  I'll run some tests on a couple of systems this evening an=
d =

> post the results.

Under Xen, the pagetables are mapped read-only to the guest, so all
pagetable updates need to go via the hypervisor.  If we switch to
init_mm and unpin (make all the pages RW) before pulling the pagetable
apart, then we can just traverse and modify the pagetable memory as
normal RW memory.  It avoids a heap of traps into the hypervisor.

    J
