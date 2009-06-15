From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 15:00:47 +0100
Message-ID: <1245074447.3222.53.camel__25178.6615736366$1245075025$gmane$org@blaa>
References: <cover.1244192535.git.mst@redhat.com>
	<20090610145540.GI19375@poweredge.glommer>
	<20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org> <1244796209.16425.20.camel@blaa>
	<4A326C7E.3020309@codemonkey.ws> <1244822007.30522.68.camel@blaa>
	<4A327E87.6080005@codemonkey.ws> <1244825333.26769.20.camel@blaa>
	<4A34ADA9.80709@redhat.com> <1245056955.6891.33.camel@blaa>
	<4A36314A.8040206@redhat.com>  <4A364316.5070402@codemonkey.ws>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A364316.5070402@codemonkey.ws>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2009-06-15 at 07:48 -0500, Anthony Liguori wrote:
> Avi Kivity wrote:
> > On 06/15/2009 12:09 PM, Mark McLoughlin wrote:
> >>>>> I think the point is that you don't need version numbers if you 
> >>>>> have a
> >>>>> proper device tree.
> >>>>>
> >>>>>          
> >>>> How do you add a new attribute to the device tree and, when a supplied
> >>>> device tree lacking said attribute, distinguish between a device tree
> >>>> from an old version of qemu (i.e. use the old default) and a partial
> >>>> device tree from the VM manager (i.e. use the new default) ?
> >>>>
> >>>>        
> >>> -baseline 0.10
> >>>      
> >>
> >> That's a version number :-)
> >>
> >> (I was responding to Anthony's "you don't need a version number")
> >>    
> >
> > If you want to prevent incompatibilities, you need to make everything 
> > new (potentially including bugfixes) non-default.

No need to punish new guests in order to maintain compatibility for old
guests.

> > Eventually the 
> > default configuration becomes increasingly unusable and you need a new 
> > baseline.  You must still be able to fall back to the old baseline for 
> > older guests.  I don't think games with configuration files can hide 
> > that.
> 
> -M pc1
> -M pc2
> 
> etc.
> 
> This is pretty easy to maintain with config files.

I think this would be reasonable, but it is essentially just a version
number which you objected to on the basis that it would make
cherry-picking harder for distros.

One thing that would be nice with this '-M pc1' thing would be to retain
'-M pc' as a symlink to the latest version. We'd also need a way to read
the symlink too, so that you can query what the current latest version
is and use that in future.

How would this machine type version relate to e.g. changing the default
PCI class of virtio-blk? Would we bump the version number of all machine
types can use virtio-blk?

A per-device version number is workable alternative, but only with a
saveabi type file IMHO.

I've tried to summarise the options here:

  https://fedoraproject.org/wiki/Features/KVM_Stable_Guest_ABI

Cheers,
Mark.
