From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v5 1/6] libnvdimm: nd_region flush callback support
Date: Thu, 18 Apr 2019 12:10:44 -0400
Message-ID: <x49lg07cn0b.fsf__6727.55056746013$1555603885$gmane$org@segfault.boston.devel.redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
	(Dan Williams's message of "Thu, 18 Apr 2019 09:05:05 -0700")
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
Cc: Pankaj Gupta <pagupta@redhat.com>, cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, Dave Jiang <dave.jiang@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Vishal L Verma <vishal.l.verma@intel.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>, kilobyte@angband.pl, Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Apr 12, 2019 at 6:12 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Jan Kara <jack@suse.cz> writes:
>>
>> > On Thu 11-04-19 07:51:48, Dan Williams wrote:
>> >> On Tue, Apr 9, 2019 at 9:09 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>> >> > +       } else {
>> >> > +               if (nd_region->flush(nd_region))
>> >> > +                       rc = -EIO;
>> >>
>> >> Given the common case wants to be fast and synchronous I think we
>> >> should try to avoid retpoline overhead by default. So something like
>> >> this:
>> >>
>> >> if (nd_region->flush == generic_nvdimm_flush)
>> >>     rc = generic_nvdimm_flush(...);
>> >
>> > I'd either add a comment about avoiding retpoline overhead here or just
>> > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
>> > get confused by the code.
>>
>> Isn't this premature optimization?  I really don't like adding things
>> like this without some numbers to show it's worth it.
>
> I don't think it's premature given this optimization technique is
> already being deployed elsewhere, see:
>
> https://lwn.net/Articles/774347/

The technique is fine, but that doesn't mean it should be applied
everywhere.  Is *this* code path really going to benefit from the
optimization?

-Jeff
