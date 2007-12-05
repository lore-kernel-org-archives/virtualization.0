From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 05 Dec 2007 21:06:08 +0100
Message-ID: <475704B0.1000701@redhat.com>
References: <C37C979D.19732%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C37C979D.19732%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Derek Murray <Derek.Murray@cl.cam.ac.uk>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

>> Alternatively, could we use the _PAGE_GNTTAB PTE flag that is used for
>> debugging? Indeed, if we did this, could be obviate the need for the
>> PTE-zapping hook, by instead catching the case where this flag is set,
>> and unmapping the grant implicitly?
> 
> Well, in the general case you don't have enough info to know which grant to
> release (a single page can be granted multiple times).

You'll also get the mm and the addr which should make it sufficiently
unique, so this looks like a doable approach to me.

ptep_get_and_clear_full() in include/asm-x86/pgtable_32.h needs to be
changed take care, but that should be possible to do and the change is
local to x86 paravirt_ops, which looks much better to me than touching
generic mm code.

cheers,
  Gerd
