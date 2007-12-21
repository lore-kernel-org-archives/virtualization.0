From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Xen-devel] Re: Next steps with pv_ops for Xen
Date: Fri, 21 Dec 2007 13:58:27 +0100
Message-ID: <476BB873.1080100__15036.1005719335$1198242035$gmane$org@redhat.com>
References: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dgm36@cam.ac.uk
Cc: xen-devel@lists.xensource.com, 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>, 'Jan Beulich' <jbeulich@novell.com>, 'Glauber de Oliveira Costa' <gcosta@redhat.com>, 'Chris Wright' <chrisw@sous-sol.org>, virtualization@lists.osdl.org, 'Mark Williamson' <mark.williamson@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

D.G. Murray wrote:
> Hi Mark, 
> void *xc_gnttab_map_grant_refs(int xcg_handle,
>                                uint32_t count,
>                                uint32_t *domids,
>                                uint32_t *refs,
>                                int prot); 

Fedora 8 has 3.1.2 packages now, still doesn't work for me though.

Bored at xmas?  Want try fixing it?  Fetch xenner 0.15 from
http://dl.bytesex.org/releases/xenner/, build ("make blkbackd"), run it
as drop-in replacement for blktap.  You have to pass the "-b" switch to
make it try batching grant maps.  Code is in ioreq_map(), blkbackd.c.

Oh, and I think the limit should better be raised.  32 requests with up
to 11 sectors each sums up to 352 pages.  Which is way beyound the
current 128 grants limit, so it may fail under heavy I/O load.

cheers and happy xmas,

  Gerd
