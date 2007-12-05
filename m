From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 18:29:07 +0000
Message-ID: <4756EDF3.30501@cl.cam.ac.uk>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>		<4753FC6A.4020601@redhat.com>
	<4754024C.7020905@cl.cam.ac.uk>		<47540FB8.8000106@redhat.com>
	<475417E7.9070006@cl.cam.ac.uk>		<47546931.2090602@redhat.com>
	<475520A1.6080909@cl.cam.ac.uk>		<475541A8.7030100@redhat.com>	<1196771999.10809.18.camel@sisko.scot.redhat.com>	<4755B158.3030008@redhat.com>
	<47569014.8080008@cl.cam.ac.uk> <4756E9F2.4050502@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4756E9F2.4050502@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Could we use one of the software-defined bits in the PTE to indicate
> that this is a foreign/granted PTE, and have set_pte_at behave
> differently if you pass it a pte with this bit set?

Actually, as Gerd pointed out in his answer to his own question, the use 
of VM_DONTCOPY cuts out this entire code path, so we don't need to worry 
about it.

Mind you, it looks like we're going to go ahead and use one of the PTE 
bits to signify foreign PTEs anyway, per Keir's suggestion. Either way, 
it's going to involve making Xen-specific changes to the mm code... have 
you any ideas how we can either (i) get rid of the zap_pte hook in the 
vm_operations_struct, or (ii) make a really compelling case to the 
kernel maintainers that it really should get in?

Regards,

Derek.
