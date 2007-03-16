From: Keir Fraser <keir@xensource.com>
Subject: Re: [Xen-devel] Re: [patch 21/26] Xen-paravirt_ops: Use the hvc
	console infrastructure for Xen console
Date: Fri, 16 Mar 2007 09:28:41 +0000
Message-ID: <C22013C9.B9E6%keir__46236.4507643089$1174037474$gmane$org@xensource.com>
References: <20070316085451.GE23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070316085451.GE23174@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 16/3/07 08:54, "Ingo Molnar" <mingo@elte.hu> wrote:

>> + prod =3D intf->in_prod;
>> + mb();
>> + BUG_ON((prod - cons) > sizeof(intf->in));
> =

> such mb()'s are typically a sign of "i have no clear idea what SMP
> serialization rules apply here, but something is needed because
> otherwise it breaks" ?

These mb()'s are pretty standard for lock-free producer/consumer rings.
Write descriptor /then/ write the updated producer. Read the producer /then/
read any descriptors revealed by this new producer value.

All our ring protocols (and we have a few) require memory barriers. Those
that use our standard set of ring macros have the memory barriers hidden
from view, but they're still there.

 -- Keir
