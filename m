From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Fri, 12 Jun 2009 15:48:14 +0100
Message-ID: <1244818094.30522.45.camel__40387.2398114347$1244818256$gmane$org@blaa>
References: <cover.1244192535.git.mst@redhat.com>
	<20090610145540.GI19375@poweredge.glommer>
	<20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org> <1244796209.16425.20.camel@blaa>
	<20090612135936.GA25912@redhat.com>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090612135936.GA25912@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2009-06-12 at 16:59 +0300, Michael S. Tsirkin wrote:
> On Fri, Jun 12, 2009 at 09:43:29AM +0100, Mark McLoughlin wrote:
> > = Solution - Separate configuration from compat hints =
> > 
> > As I suggested before:
> > 
> >   - Allow the VM manager to dump compat hints; this would be an opaque 
> >     file format, more like the savevm format than a config file
> 
> Why make it "like the savevm" format then?
> If they are opaque anyway, compat hints could be part of savevm format.

So a "savevm --only-compat-hints" command? It might make sense, since we
would want the compat hints with savevm too.

> >   - Use defaults where compat hints are not available; e.g. if the VM 
> >     manager specifies a device config, but no compat hints are 
> >     supplied for it, then just use default values
> > 
> >   - Make the config override compat hints; e.g. if there are compat 
> >     hints specified for a device not included in the machine config, 
> >     just ignore those hints
> > 
> > Cheers,
> > Mark.
> 
> If compat hints are opaque and only editable by qemu, we can get into a
> situation where one can't create a specific setup with a new qemu.

An example?

Cheers,
Mark.
