From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 12:15:01 -0800
Message-ID: <475706C5.1000608@goop.org>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>		<4753FC6A.4020601@redhat.com>
	<4754024C.7020905@cl.cam.ac.uk>		<47540FB8.8000106@redhat.com>
	<475417E7.9070006@cl.cam.ac.uk>		<47546931.2090602@redhat.com>
	<475520A1.6080909@cl.cam.ac.uk>		<475541A8.7030100@redhat.com>	<1196771999.10809.18.camel@sisko.scot.redhat.com>	<4755B158.3030008@redhat.com>
	<47569014.8080008@cl.cam.ac.uk> <4756E9F2.4050502@goop.org>
	<4756EDF3.30501@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4756EDF3.30501@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Derek Murray wrote:
> Jeremy Fitzhardinge wrote:
>> Could we use one of the software-defined bits in the PTE to indicate
>> that this is a foreign/granted PTE, and have set_pte_at behave
>> differently if you pass it a pte with this bit set?
>
> Actually, as Gerd pointed out in his answer to his own question, the
> use of VM_DONTCOPY cuts out this entire code path, so we don't need to
> worry about it.
>
> Mind you, it looks like we're going to go ahead and use one of the PTE
> bits to signify foreign PTEs anyway, per Keir's suggestion. Either
> way, it's going to involve making Xen-specific changes to the mm code... 

Sneaking in a user for the otherwise completely unused PTE bits should
be fairly straightforward.

> have you any ideas how we can either (i) get rid of the zap_pte hook
> in the vm_operations_struct, or (ii) make a really compelling case to
> the kernel maintainers that it really should get in? 

Hm, I haven't spent much time looking at how grant tables and their
mappings work yet, so I can't say I really understand all this myself. 
Hence, questions:

Can we take a different approach from the zap_pte hook?  Given that
we're 1) planning on claiming a pte bit for grant mappings, and 2) need
to hook ptep_get_and_clear anyway to solve the mprotect performance
problems, couldn't we just special-case grant mapping pte_clears?

In 2.6.18-xen the only two implementations of zap_pte are
blktap_clear_pte and gntdev_clear_pte.  Given a ptep with the
grant-mapping bit set, could we determine which of these need calling
and do the appropriate thing?  Do we even need separate implementations
of the core pte-clearing functionality?  Could we just say something like:

	if (pte & _PAGE_XEN_FOREIGN)
		HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, ...);
	else
		xen_set_pte_at(...);


blktap_clear_pte and gntdev_clear_pte do other housekeeping, but do they
have to be done at the same instant as the grant mapping clear?  Could
they be done via some other hook?

(I see Gerd just proposed this, pretty much.)

    J
