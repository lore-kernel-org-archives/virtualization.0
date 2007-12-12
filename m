From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 12 Dec 2007 08:39:41 +0000
Message-ID: <C3854ECD.113B3%Keir.Fraser@cl.cam.ac.uk>
References: <20071212082727.GA31492%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20071212082727.GA31492%yamahata@valinux.co.jp>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Isaku Yamahata <yamahata@valinux.co.jp>, Derek Murray <Derek.Murray@cl.cam.ac.uk>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

We already make the VM_FOREIGN check conditional on defined(CONFIG_XEN). We
could add defined(CONFIG_X86) as well? This would seem reasonable as a
temporary measure for the old 2.6.18 tree.

 -- Keir

On 12/12/07 08:27, "Isaku Yamahata" <yamahata@valinux.co.jp> wrote:

> This patch breaks blktap and gntdev on ia64.
> With auto translated physmap mode enabled, bktap/gntdev update
> the pte entry with vm_insert_page(). Not direct updating it with
> the hypercall.
> So when zapping the pte entry, it is necessary to release page
> reference counting, rmapping and etc. Thus vm_normal_page() have
> to return the struct page when auto translated physmap mode is enabled.
> 
> How about passing the page struct** to the zap_pte call back
> and set it to NULL if necessary?
> (or
> Can the condition be changed to check auto trasnalted physmap mode?
> or
> Should the clean up be done in zap_pte callback?)
