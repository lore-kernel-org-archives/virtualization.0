From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/4] i386 - pte update optimizations
Date: Thu, 12 Apr 2007 18:25:05 -0700
Message-ID: <461EDBF1.4080904@zytor.com>
References: <200704120530.l3C5UGbv022814@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704120530.l3C5UGbv022814@zach-dev.vmware.com>
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

Zachary Amsden wrote:
> Some PTE optimizations for native and paravirt-ops kernels; this
> provides a huge win for shadow mode hypervisors and gets rid of
> some unnecessary atomic instructions in native kernels, saving
> even more on UP by getting rid of implicit LOCK on xchg instruction.

You do know that P6 and higher don't do locked bus references as long as =

the value is in the cache, right?

	-hpa
