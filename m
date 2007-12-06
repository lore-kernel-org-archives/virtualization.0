From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Thu, 06 Dec 2007 11:15:57 +0100
Message-ID: <4757CBDD.8040600@redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	<47546931.2090602@redhat.com>
	<475520A1.6080909@cl.cam.ac.uk>	<475541A8.7030100@redhat.com>	<1196771999.10809.18.camel@sisko.scot.redhat.com>	<4755B158.3030008@redhat.com>
	<47569014.8080008@cl.cam.ac.uk>	<4756E9F2.4050502@goop.org>
	<4756EDF3.30501@cl.cam.ac.uk>	<475706C5.1000608@goop.org>
	<c3c918090712051235j6a4176c6t5145d6b9da78a5cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <c3c918090712051235j6a4176c6t5145d6b9da78a5cd@mail.gmail.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Geoffrey Lefebvre <geoffrey@cs.ubc.ca>
Cc: Derek Murray <Derek.Murray@cl.cam.ac.uk>, Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Geoffrey Lefebvre wrote:
> In order to unmap a grant, you need the grant handle obtained when the
> grant is mapped. That handle needs to be stored somewhere for the
> lifetime of the mapping. Where would the handle be stored (as Gerd
> proposed) in order to be able to unmap from ptep_get_and_clear_full?

Sure. the kernel has to keep track of the grant mappings somewhere, so
it can lookup the grant handle from the available information.  Hashing
by machine address should work reasonable fast.  It's probably useful to
have an in-kernel API for that which then can be used by both gntdev and
the in-kernel backend drivers.  This API can also abstract out
arch-specific bits to make life easier for the ia64 guys ...

cheers,
  Gerd
