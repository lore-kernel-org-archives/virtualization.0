From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Thu, 06 Dec 2007 16:21:17 +0100
Message-ID: <4758136D.1030002@redhat.com>
References: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: dgm36@cam.ac.uk
Cc: xen-devel@lists.xensource.com, 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>, "'Stephen C. Tweedie'" <sct@redhat.com>, 'Jan Beulich' <jbeulich@novell.com>, 'Glauber de Oliveira Costa' <gcosta@redhat.com>, 'Chris Wright' <chrisw@sous-sol.org>, virtualization@lists.osdl.org, 'Mark Williamson' <mark.williamson@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

D.G. Murray wrote:
> Hi Mark, 
> 
>> Maybe a change to the gntdev userspace API to allow batching 
>> of mapping requests?
> 
> Something along the lines of the following?
> 
> void *xc_gnttab_map_grant_refs(int xcg_handle,
>                                uint32_t count,
>                                uint32_t *domids,
>                                uint32_t *refs,
>                                int prot); 

Yes, except that it should actually work ;)

It doesn't for me (Fedora 8 again).  Grab xenner 0.9 (just uploaded),
edit blkbackd.c and flip the BATCH_MAPS from 0 to 1, compile, run, see
it not work.

With BATCH_MAPS being 0 blkbackd works nicely as blktap/tapdisk drop-in
replacement.

cheers,
  Gerd
