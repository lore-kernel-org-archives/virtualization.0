From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 17:22:36 +0000
Message-ID: <C37C8EDC.1971B%Keir.Fraser@cl.cam.ac.uk>
References: <4756DD23.7070502@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4756DD23.7070502@cl.cam.ac.uk>
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

On 5/12/07 17:17, "Derek Murray" <Derek.Murray@cl.cam.ac.uk> wrote:

>> Actually I'm not so sure now. Presumably you add VM_PFNMAP to make
>> vm_normal_page() return NULL? But actually I would expect pte_pfn() to
>> return max_mapnr because the mapped page is not a local page. And that
>> should cause vm_normal_page() to return NULL always, regardless of whether
>> you assert VM_PFNMAP. Is gntdev being used to grant-and-map local pages in
>> the test that causes the crash?
> 
> That's right (gntdev is being used to map (but not grant) a local page).
> The test case creates a virtual block device in Dom0, and attempts to
> map its ring buffer in a user-space daemon in Dom0. Therefore pte_pfn
> succeeds.

Need to bite the bullet and fix this properly by setting a software flag in
ptes that are not subject to reference counting.

Unfortunately that also needs a hypervisor interface change, to allow
setting of those pte flags. Easily done though, and we should definitely get
that piece in for 3.2.0.

Setting VM_PFNMAP is bogus. We used to do that for privcmd mappings too, but
we stopped because IIRC it had other unwanted side effects.

 -- Keir
