From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 10:12:02 -0800
Message-ID: <4756E9F2.4050502@goop.org>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>		<4753FC6A.4020601@redhat.com>
	<4754024C.7020905@cl.cam.ac.uk>		<47540FB8.8000106@redhat.com>
	<475417E7.9070006@cl.cam.ac.uk>		<47546931.2090602@redhat.com>
	<475520A1.6080909@cl.cam.ac.uk>		<475541A8.7030100@redhat.com>	<1196771999.10809.18.camel@sisko.scot.redhat.com>	<4755B158.3030008@redhat.com>
	<47569014.8080008@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <47569014.8080008@cl.cam.ac.uk>
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
> Ultimately, fork calls dup_mm, which calls, dup_mmap, which calls
> copy_{page,pud,pmd,pte}_range, which calls copy_one_pte, which calls
> set_pte_at, which hypercalls HYPERVISOR_update_va_mapping.
>
> The hypercall will not succeed and will return an error code
> indicating the reason for this. Therefore the PTE will not be set.
> There appears to be no way to propagate this error through the Linux
> VM code, because there is no concept of a PTE update failing. I could
> add return codes to all those functions, but I don't fancy their
> chances upstream....

Could we use one of the software-defined bits in the PTE to indicate
that this is a foreign/granted PTE, and have set_pte_at behave
differently if you pass it a pte with this bit set?

    J
