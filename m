From: Keir Fraser <keir@xensource.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and
	disableunsupported config options.
Date: Fri, 16 Feb 2007 10:47:11 +0000
Message-ID: <C1FB3C2F.98E9%keir__11913.1749998362$1171622930$gmane$org@xensource.com>
References: <20070216020947.03e1726e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070216020947.03e1726e.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Steven Hand <steven.hand@cl.cam.ac.uk>, Ian Pratt <Ian.Pratt@xensource.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 10:09, "Andrew Morton" <akpm@linux-foundation.org> wrote:

> Are the places where the domU code references machine addresses splattered
> all over the code?  If not, they can just be wrapped with
> preempt_disable/preempt_enable?

The main places where machine addresses are 'visible' are any code that
holds a pte_t,pmd_t,pud_t,pgd_t. We hide the machine-to-pseudophysical and
pseudophysical-to-machine translations inside e.g., pte_val() and __pte()
(i.e., constructors and extractors for page table entries). Obviously the
users of these macros are open coded all over the place, quite apart from
the performance cost of sprinkling preempt_{enable,disable} so liberally.

 -- Keir
