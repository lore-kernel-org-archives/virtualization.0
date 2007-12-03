From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Next steps with pv_ops for Xen
Date: Mon, 03 Dec 2007 13:54:02 +0100
Message-ID: <4753FC6A.4020601@redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1195682725.6726.48.camel@sisko.scot.redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Stephen C. Tweedie wrote:
> Hi all,
> 
>   driver domains

Looked at the gntdev (grant table mappings for user space) driver,
noticed that one is not self-contained.  It needs a hook for page unmapping:

  http://xenbits.xensource.com/xen-3.1-testing.hg?rev/7180d2e61f92
  plus an s/ptep_get_and_clear_full/zap_pte/ fixup a few changesets
  later.

Upstreaming that one could become *uhm* intresting.  Nevertheless the
gntdev functionality is quite useful for writing pure userspace
backend drivers ...

cheers,
  Gerd
