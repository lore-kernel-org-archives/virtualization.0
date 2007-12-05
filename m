From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 11:48:36 +0000
Message-ID: <47569014.8080008__5383.70828512615$1196855453$gmane$org@cl.cam.ac.uk>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>	
	<4753FC6A.4020601@redhat.com> <4754024C.7020905@cl.cam.ac.uk>	
	<47540FB8.8000106@redhat.com> <475417E7.9070006@cl.cam.ac.uk>	
	<47546931.2090602@redhat.com> <475520A1.6080909@cl.cam.ac.uk>	
	<475541A8.7030100@redhat.com>
	<1196771999.10809.18.camel@sisko.scot.redhat.com>
	<4755B158.3030008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4755B158.3030008@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Gerd,

Gerd Hoffmann wrote:
Want reproduce?  Here we go:
> 
>   * grab xenner 0.8 from http://dl.bytesex.org/releases/xenner/
>   * grab a xenified dom0 kernel without blktap driver (either not
>     compiled or module not loaded).
>   * start xend
>   * start blkbackd from xenner package (you probably want the -d switch
>     for debug output, twice for more).
>   * run "xm block-attach 0 tap:aio:/path/to/some/file xvda r"
>   * watch it blow up ;)

Thanks for the repro details. I'll have a go at this later. One thing we 
haven't tested AFAIK is mapping grants in the same domain: could you 
check to see if the bug is the same if you attach a block device to a 
domain other than Dom0? Also, could you send any Xen console output, if 
it contains errors or warnings?

>> I can't help wondering if this is a hint that now is the time to find a
>> better API, which doesn't have the requirement (a) that seems to be
>> causing such trouble?  Are other PV guests --- *BSD, Solaris --- going
>> to have the same problems with their VM layers if they try to implement
>> this API?  Upstream Linux pv_ops certainly will, and it would be good if
>> we could avoid tying unprivileged guests to ABIs which cannot hope to be
>> merged into pv_ops.
> 
> And I fear the problems I've trapped into up to now is only the tip of
> the iceberg.  What happens if an application with active grant table
> mappings calls fork() ?

Ultimately, fork calls dup_mm, which calls, dup_mmap, which calls 
copy_{page,pud,pmd,pte}_range, which calls copy_one_pte, which calls 
set_pte_at, which hypercalls HYPERVISOR_update_va_mapping.

The hypercall will not succeed and will return an error code indicating 
the reason for this. Therefore the PTE will not be set. There appears to 
be no way to propagate this error through the Linux VM code, because 
there is no concept of a PTE update failing. I could add return codes to 
all those functions, but I don't fancy their chances upstream....

A possibility for solving that might be to carry out the mappings upon a 
page fault: I believe this would be compatible with copy_page_range.

(In fact, it's possible that a forked process would attempt to 
demand-page in the granted page, bypassing the copy_page_range code. 
Since there is no nopage handler for a gntdev VMA, that would lead to an 
anonymous page being mapped into memory instead.)

So, as far as I can tell, there would be no kernel BUG() or 
domain_crash() in the event of a fork(). It looks like implementing 
nopage in gntdev would enable grants to be remapped after a fork() and 
the correct behaviour to happen.

Regards,

Derek.
