From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 17:59:57 +0000
Message-ID: <C37C979D.19732%Keir.Fraser@cl.cam.ac.uk>
References: <4756E481.1060201@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4756E481.1060201@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 5/12/07 17:48, "Derek Murray" <Derek.Murray@cl.cam.ac.uk> wrote:

> Keir Fraser wrote:
>> Need to bite the bullet and fix this properly by setting a software flag in
>> ptes that are not subject to reference counting.
> 
> Could we get away with testing the VM_FOREIGN flag in vm_normal_page()?
> Although I get the impression that this wouldn't be easily justified if
> trying to merge with upstream Linux....

Yes, this would work okay I suspect. Good enough as a stop-gap measure? Are
there any other responsibilities that you acquire if you make use of
VM_FOREIGN (in particular, how would this affect get_user_pages)?

> Alternatively, could we use the _PAGE_GNTTAB PTE flag that is used for
> debugging? Indeed, if we did this, could be obviate the need for the
> PTE-zapping hook, by instead catching the case where this flag is set,
> and unmapping the grant implicitly?

Well, in the general case you don't have enough info to know which grant to
release (a single page can be granted multiple times).

> Otherwise, what would the semantics of this new flag be?

It would cause pte_pfn() to return max_mapnr. It would be set for any
foreign page mapping, and replace mfn_to_local_pfn() in pte_pfn().

 -- Keir
