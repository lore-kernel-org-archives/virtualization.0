From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH v7 3/6] libnvdimm: add dax_dev sync flag
Date: Thu, 9 May 2019 08:24:24 -0400 (EDT)
Message-ID: <511098535.27565704.1557404664499.JavaMail.zimbra__31766.1823284411$1557405624$gmane$org@redhat.com>
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-4-pagupta@redhat.com>
	<CAPcyv4hRdvypEj4LBTMfUFm80BdpRYbOugrkkj-3Kk_LErXPqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPcyv4hRdvypEj4LBTMfUFm80BdpRYbOugrkkj-3Kk_LErXPqQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vishal L Verma <vishal.l.verma@intel.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>, kilobyte@angband.pl, Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com, Nites
List-Id: virtualization@lists.linuxfoundation.org


> >
> > This patch adds 'DAXDEV_SYNC' flag which is set
> > for nd_region doing synchronous flush. This later
> > is used to disable MAP_SYNC functionality for
> > ext4 & xfs filesystem for devices don't support
> > synchronous flush.
> >
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [..]
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index 0dd316a74a29..c97fc0cc7167 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -7,6 +7,9 @@
> >  #include <linux/radix-tree.h>
> >  #include <asm/pgtable.h>
> >
> > +/* Flag for synchronous flush */
> > +#define DAXDEV_F_SYNC true
> 
> I'd feel better, i.e. it reads more canonically, if this was defined
> as (1UL << 0) and the argument to alloc_dax() was changed to 'unsigned
> long flags' rather than a bool.

Sure, Will send a v8 with suggested changes.

Thank You,
Pankaj

> 
