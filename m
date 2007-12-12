From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 12 Dec 2007 17:27:27 +0900
Message-ID: <20071212082727.GA31492%yamahata@valinux.co.jp>
References: <4756EAD5.9050407@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <4756EAD5.9050407@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 05, 2007 at 06:15:49PM +0000, Derek Murray wrote:
> Keir Fraser wrote:
> >Yes, this would work okay I suspect. Good enough as a stop-gap measure? Are
> >there any other responsibilities that you acquire if you make use of
> >VM_FOREIGN (in particular, how would this affect get_user_pages)?
> 
> VM_FOREIGN is already set for the gntdev VMA (mostly because it's 
> directly based on the blktap code). That means that it has the array of 
> page_structs in its vm_private_data, which can be used to fulfill a 
> get_user_pages call. I've attached a patch based on this fix.
> 
> Regards,
> 
> Derek.

Hi Derek. Sorry for this late alert.

This patch breaks blktap and gntdev on ia64.
With auto translated physmap mode enabled, bktap/gntdev update
the pte entry with vm_insert_page(). Not direct updating it with
the hypercall.
So when zapping the pte entry, it is necessary to release page
reference counting, rmapping and etc. Thus vm_normal_page() have
to return the struct page when auto translated physmap mode is enabled.

How about passing the page struct** to the zap_pte call back
and set it to NULL if necessary?
(or
Can the condition be changed to check auto trasnalted physmap mode?
or
Should the clean up be done in zap_pte callback?)
-- 
yamahata
