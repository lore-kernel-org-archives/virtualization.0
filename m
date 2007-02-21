From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 05/24] Xen-paravirt_ops: Add pagetable accessors to pack
	and unpack pagetable entries
Date: Wed, 21 Feb 2007 23:15:12 +0100
Message-ID: <200702212315.12883.ak@suse.de>
References: <20070221205254.169835700@goop.org>
	<20070221205322.869165491@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070221205322.869165491@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 21 February 2007 21:52, Jeremy Fitzhardinge wrote:
> Add a set of accessors to pack, unpack and modify page table entries
> (at all levels).  This allows a paravirt implementation to control the
> contents of pgd/pmd/pte entries.  For example, Xen uses this to
> convert the (pseudo-)physical address into a machine address when
> populating a pagetable entry, and converting back to pphys address
> when an entry is read.

Do you have some lmbench numbers before/after this change? =

iirc at least fork and exit do a lot of pte accesses in various forms.
If it's measurable it might be needed to patch those for the native case.

-Andi
