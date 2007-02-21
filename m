From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [patch 17/24] Xen-paravirt_ops: avoid having a bad selector
	in %gs during context switch
Date: Wed, 21 Feb 2007 22:16:15 +0000
Message-ID: <C202752F.26C4%Keir.Fraser@cl.cam.ac.uk>
References: <200702212310.02218.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200702212310.02218.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@linux-foundation.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 21/2/07 22:10, "Andi Kleen" <ak@suse.de> wrote:

>> /*
>> +  * Temporary hack: zero gs now that we've saved it so that Xen
>> +  * doesn't try to reload the old value after changing the GDT
>> +  * during the context switch.  This can go away once Xen has
>> +  * been taught to only reload %gs when it absolutely must.
>> +  */
>> + loadsegment(gs, 0);
> =

> Sorry, but i don't really want that unconditionally in the context switch.
> Adding a paravirt ops for it would be also ugly. Can Xen be fixed?

This is not an issue for correctness so this can safely be removed and still
work with current Xen.

 -- Keir
