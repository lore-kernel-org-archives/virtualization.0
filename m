From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Thu, 06 Dec 2007 10:00:06 +0000
Message-ID: <4757C826.10506@cl.cam.ac.uk>
References: <C37CBE1F.10E88%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C37CBE1F.10E88%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> You'd need to track pte->grant_handle mappings somewhere, but it could
> certainly be done this way, yes.

At the moment, blktap and gntdev provide struct pages to get_user_pages 
by smuggling them in the vm_private_data field of the relevant 
vm_area_struct. Could we use this field to get the handles to 
ptep_get_and_clear_full as well?

Only downside that I can see is that we would need to find the vma for 
each PTE that needs to be cleared this way (since we don't get this 
passed to ptep_get_and_clear_full), but this is mitigated by (i) it only 
happening in the erroneous, unclean-shutdown case, and (ii) getting a 
hit in the mm->mmap_cache for consecutive runs of mapped grants.

Regards,

Derek.
