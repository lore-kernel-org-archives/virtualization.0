From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 12 Dec 2007 17:44:40 +0900
Message-ID: <20071212084440.GB31492%yamahata@valinux.co.jp>
References: <20071212082727.GA31492%yamahata@valinux.co.jp>
	<C3854ECD.113B3%Keir.Fraser@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <C3854ECD.113B3%Keir.Fraser@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Derek Murray <Derek.Murray@cl.cam.ac.uk>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Gerd Hoffmann <kraxel@redhat.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 12, 2007 at 08:39:41AM +0000, Keir Fraser wrote:
> We already make the VM_FOREIGN check conditional on defined(CONFIG_XEN). We
> could add defined(CONFIG_X86) as well? This would seem reasonable as a
> temporary measure for the old 2.6.18 tree.

Yes, ok for IA64.
-- 
yamahata
