From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: how set_pte_at()'s vaddr and ptep args relate
Date: Wed, 08 Nov 2006 08:34:27 +0000
Message-ID: <C1774713.3FA7%Keir.Fraser@cl.cam.ac.uk>
References: <45512195.3060101@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45512195.3060101@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On 8/11/06 12:15 am, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

> The parenthetic clause is annoyingly ambiguous: does it mean "when the
> present flag is currently set to 0" or "when setting the present flag to
> 0"?  The passive voice should always be avoided.

If the PTE was previously NP, and you already flushed the TLB since it
became NP, then you can be quite sure that there is no stale TLB entry. x86
TLBs do not cache failed lookups. If they did, many OSes would not work!

Changing from read-only to writable is more exciting. You get a spurious
page fault when the CPU finds the read-only TLB entry on your first write
access. The CPU does throw away the TLB entry at that point though, so the
fault handler can do nothing and yet still make progress. That's guaranteed.

 -- Keir
