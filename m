From: Jeremy Fitzhardinge <Jeremy.Fitzhardinge@citrix.com>
Subject: Re: [Xen-devel] Re: Next steps with pv_ops for Xen
Date: Thu, 06 Dec 2007 11:55:38 -0800
Message-ID: <475853BA.1050405@citrix.com>
References: <C37CBE1F.10E88%Keir.Fraser@cl.cam.ac.uk>
	<4757C826.10506@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4757C826.10506@cl.cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Derek Murray wrote:
> Keir Fraser wrote:
>> You'd need to track pte->grant_handle mappings somewhere, but it could
>> certainly be done this way, yes.
>
> At the moment, blktap and gntdev provide struct pages to
> get_user_pages by smuggling them in the vm_private_data field of the
> relevant vm_area_struct. Could we use this field to get the handles to
> ptep_get_and_clear_full as well?

Yes.  Given the mm and a vaddr passed to ptep_get_and_clear, find_vma()
will return the vma_struct.  If we assert that anyone who sets the "I'm
foreign" bit in a pte has a standard format for the vm_private_data
field, then we can stash a callback pointer there and make the
appropriate callback.

> Only downside that I can see is that we would need to find the vma for
> each PTE that needs to be cleared this way (since we don't get this
> passed to ptep_get_and_clear_full), but this is mitigated by (i) it
> only happening in the erroneous, unclean-shutdown case, and (ii)
> getting a hit in the mm->mmap_cache for consecutive runs of mapped
> grants.

Yes.  find_vma is fairly hot, since its used on every fault, so it
should be reasonably fast.  And it doesn't sound like our case is
particularly performance critical.

    J
