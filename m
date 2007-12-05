From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 17:17:23 +0000
Message-ID: <4756DD23.7070502@cl.cam.ac.uk>
References: <C37C894B.1970F%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C37C894B.1970F%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> 
> Actually I'm not so sure now. Presumably you add VM_PFNMAP to make
> vm_normal_page() return NULL? But actually I would expect pte_pfn() to
> return max_mapnr because the mapped page is not a local page. And that
> should cause vm_normal_page() to return NULL always, regardless of whether
> you assert VM_PFNMAP. Is gntdev being used to grant-and-map local pages in
> the test that causes the crash?

That's right (gntdev is being used to map (but not grant) a local page). 
The test case creates a virtual block device in Dom0, and attempts to 
map its ring buffer in a user-space daemon in Dom0. Therefore pte_pfn 
succeeds.

Regards,

Derek.
