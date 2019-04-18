From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 1/6] libnvdimm: nd_region flush callback support
Date: Thu, 18 Apr 2019 11:14:59 -0700
Message-ID: <CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg__41205.7700146519$1555611344$gmane$org@mail.gmail.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
	<20190418161833.GA22970@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190418161833.GA22970@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Pankaj Gupta <pagupta@redhat.com>, cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vishal L Verma <vishal.l.verma@intel.com>, Matthew Wilcox <willy@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>, kilobyte@angband.pl, Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Nites
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 18, 2019 at 9:18 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
> > > > I'd either add a comment about avoiding retpoline overhead here or just
> > > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
> > > > get confused by the code.
> > >
> > > Isn't this premature optimization?  I really don't like adding things
> > > like this without some numbers to show it's worth it.
> >
> > I don't think it's premature given this optimization technique is
> > already being deployed elsewhere, see:
> >
> > https://lwn.net/Articles/774347/
>
> For one this one was backed by numbers, and second after feedback
> from Linux we switched to the NULL pointer check instead.

Ok I should have noticed the switch to NULL pointer check. However,
the question still stands do we want everyone to run numbers to
justify this optimization, or make it a new common kernel coding
practice to do:

    if (!object->op)
        generic_op(object);
    else
        object->op(object);

...in hot paths? I agree with not doing premature optimization in
principle, but this hack is minimally intrusive from a readability
perspective similar to likely()/unlikely() usage which also don't come
with numbers on a per patch basis.
