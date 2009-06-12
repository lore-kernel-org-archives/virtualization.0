From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Fri, 12 Jun 2009 17:48:53 +0100
Message-ID: <1244825333.26769.20.camel__3004.0300720886$1244825705$gmane$org@blaa>
References: <cover.1244192535.git.mst@redhat.com>
	<20090610145540.GI19375@poweredge.glommer>
	<20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org> <1244796209.16425.20.camel@blaa>
	<4A326C7E.3020309@codemonkey.ws> <1244822007.30522.68.camel@blaa>
	<4A327E87.6080005@codemonkey.ws>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A327E87.6080005@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2009-06-12 at 11:12 -0500, Anthony Liguori wrote:
> Mark McLoughlin wrote:
> > On Fri, 2009-06-12 at 09:55 -0500, Anthony Liguori wrote:
> >   
> >> Mark McLoughlin wrote:
> >>     
> >>> On Wed, 2009-06-10 at 20:27 +0100, Jamie Lokier wrote:
> >>>   
> >>> = Solution - Separate configuration from compat hints =
> >>>
> >>> As I suggested before:
> >>>
> >>>   - Allow the VM manager to dump compat hints; this would be an opaque 
> >>>     file format, more like the savevm format than a config file
> >>>   
> >>>       
> >> How is compat hints different from a device tree?
> >>
> >> In my mind, that's what compat hints is.  I don't see another sane way 
> >> to implement it.
> >>     
> >
> > A device tree with a different purpose than a config file.
> >
> > In its simplest form it could be a device tree with a version number for
> > each device[1]. 
> >   
> 
> I think the point is that you don't need version numbers if you have a 
> proper device tree.

How do you add a new attribute to the device tree and, when a supplied
device tree lacking said attribute, distinguish between a device tree
from an old version of qemu (i.e. use the old default) and a partial
device tree from the VM manager (i.e. use the new default) ?

> NB the device tree contains no host configuration information.

So, it wouldn't e.g. include the path to the image file for a block
device? That would always be specified on the command line?

Cheers,
Mark.
