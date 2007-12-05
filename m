From: "Geoffrey Lefebvre" <geoffrey@cs.ubc.ca>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 5 Dec 2007 12:35:36 -0800
Message-ID: <c3c918090712051235j6a4176c6t5145d6b9da78a5cd@mail.gmail.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>
	<475541A8.7030100@redhat.com>
	<1196771999.10809.18.camel@sisko.scot.redhat.com>
	<4755B158.3030008@redhat.com> <47569014.8080008@cl.cam.ac.uk>
	<4756E9F2.4050502@goop.org> <4756EDF3.30501@cl.cam.ac.uk>
	<475706C5.1000608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <475706C5.1000608@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Derek Murray <Derek.Murray@cl.cam.ac.uk>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> Can we take a different approach from the zap_pte hook?  Given that
> we're 1) planning on claiming a pte bit for grant mappings, and 2) need
> to hook ptep_get_and_clear anyway to solve the mprotect performance
> problems, couldn't we just special-case grant mapping pte_clears?
>
> In 2.6.18-xen the only two implementations of zap_pte are
> blktap_clear_pte and gntdev_clear_pte.  Given a ptep with the
> grant-mapping bit set, could we determine which of these need calling
> and do the appropriate thing?  Do we even need separate implementations
> of the core pte-clearing functionality?  Could we just say something like:
>
>         if (pte & _PAGE_XEN_FOREIGN)
>                 HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, ...);
>         else
>                 xen_set_pte_at(...);
>

Hi,

In order to unmap a grant, you need the grant handle obtained when the
grant is mapped. That handle needs to be stored somewhere for the
lifetime of the mapping. Where would the handle be stored (as Gerd
proposed) in order to be able to unmap from ptep_get_and_clear_full?

I haven't looked at the paravirt ops in details so I could be missing
something obvious here.

cheers,

geoffrey
