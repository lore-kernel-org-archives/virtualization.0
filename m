From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 3/16] read/write_crX, clts and wbinvd for 64-bit paravirt
Date: Thu, 01 Nov 2007 08:30:59 -0700
Message-ID: <4729F133.3060308__21467.0468973511$1193931372$gmane$org@goop.org>
References: <1193858101367-git-send-email-gcosta@redhat.com>
	<11938581073775-git-send-email-gcosta@redhat.com>
	<11938581133479-git-send-email-gcosta@redhat.com>
	<1193858118284-git-send-email-gcosta@redhat.com>
	<47295AA7.9090507@goop.org> <4729D92E.2030108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4729D92E.2030108@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
> I in fact have seen bugs with mixed reads and writes to the same cr,
> (cr4), but adding the volatile
> flag to the read function seemed to fix it.

Well, volatile will make a read be repeated rather than caching the
previous value, but it has no effect on ordering.

> Yet, I agree with you that
> the theorectical problem exists for the reorder, and your proposed fix
> seems fine (although if we're really desperate about memory usage, we
> can use a char instead a int and save 3 bytes!)

Sure.  Ideally the compiler would never even generate a reference to it,
and it could just be extern, but in practice the compiler will generate
references sometimes.

    J
