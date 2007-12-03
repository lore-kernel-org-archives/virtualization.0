From: Derek Murray <Derek.Murray@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Mon, 03 Dec 2007 13:19:08 +0000
Message-ID: <4754024C.7020905@cl.cam.ac.uk>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4753FC6A.4020601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4753FC6A.4020601@redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

I take the blame for that one. I added the hook because, if a process 
were to die whilst holding one or more grants, there were no hooks that 
would make it possible to carry out the grant-unmap. All existing hooks 
on either the device or the VMA were called *after* the PTEs were cleared.

It gets better, though. The same hook is used in the version of blktap 
in linux-2.6.18-xen (not, as far as I can see, in the sparse tree for 
xen-3.1-testing):
 
http://xenbits.xensource.com/linux-2.6.18-xen.hg?file/fd879c0688bf/drivers/xen/blktap/blktap.c

Reverting back to the old (hookless) behaviour would be a retrograde 
step IMHO.

Cheers,

Derek Murray.

Gerd Hoffmann wrote:
> Stephen C. Tweedie wrote:
>> Hi all,
>>
>>   driver domains
> 
> Looked at the gntdev (grant table mappings for user space) driver,
> noticed that one is not self-contained.  It needs a hook for page unmapping:
> 
>   http://xenbits.xensource.com/xen-3.1-testing.hg?rev/7180d2e61f92
>   plus an s/ptep_get_and_clear_full/zap_pte/ fixup a few changesets
>   later.
> 
> Upstreaming that one could become *uhm* intresting.  Nevertheless the
> gntdev functionality is quite useful for writing pure userspace
> backend drivers ...
> 
> cheers,
>   Gerd
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
