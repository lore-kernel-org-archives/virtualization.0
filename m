From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 20:44:15 +0000
Message-ID: <C37CBE1F.10E88%Keir.Fraser@cl.cam.ac.uk>
References: <475706C5.1000608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <475706C5.1000608@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>, Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 5/12/07 20:15, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

> In 2.6.18-xen the only two implementations of zap_pte are
> blktap_clear_pte and gntdev_clear_pte.  Given a ptep with the
> grant-mapping bit set, could we determine which of these need calling
> and do the appropriate thing?  Do we even need separate implementations
> of the core pte-clearing functionality?  Could we just say something like:
> 
> if (pte & _PAGE_XEN_FOREIGN)
> HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, ...);
> else
> xen_set_pte_at(...);

You'd need to track pte->grant_handle mappings somewhere, but it could
certainly be done this way, yes.

 -- Keir
