From: "D.G. Murray" <Derek.Murray@cl.cam.ac.uk>
Subject: RE: Re: Next steps with pv_ops for Xen
Date: Mon, 3 Dec 2007 18:36:37 -0000
Message-ID: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
References: <200712031718.28234.mark.williamson@cl.cam.ac.uk>
Reply-To: dgm36@cam.ac.uk
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200712031718.28234.mark.williamson@cl.cam.ac.uk>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: 'Mark Williamson' <mark.williamson@cl.cam.ac.uk>, xen-devel@lists.xensource.com
Cc: 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>, "'Stephen C. Tweedie'" <sct@redhat.com>, 'Jan Beulich' <jbeulich@novell.com>, 'Glauber de Oliveira Costa' <gcosta@redhat.com>, 'Chris Wright' <chrisw@sous-sol.org>, virtualization@lists.osdl.org, 'Gerd Hoffmann' <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Mark, 

> Maybe a change to the gntdev userspace API to allow batching 
> of mapping requests?

Something along the lines of the following?

/**
 * Memory maps one or more grant references from one or more domains to a
 * contiguous local address range. Mappings should be unmapped with
 * xc_gnttab_munmap. Returns NULL on failure.
 *
 * @parm xcg_handle a handle on an open grant table interface
 * @parm count the number of grant references to be mapped
 * @parm domids an array of @count domain IDs by which the corresponding
@refs
 * were granted
 * @parm refs an array of @count grant references to be mapped
 * @parm prot same flag as in mmap()
 */
void *xc_gnttab_map_grant_refs(int xcg_handle,
                               uint32_t count,
                               uint32_t *domids,
                               uint32_t *refs,
                               int prot); 

http://xenbits.xensource.com/xen-unstable.hg?file/3057f813da14/tools/libxc/x
enctrl.h

> blktap in userspace, if any performance problems can be 
> addressed, would seem to be a far nicer way of doing things.  
> And it's less code to merge upstream ;-)

Agreed.

Cheers,

Derek.
