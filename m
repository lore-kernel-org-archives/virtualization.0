From: David Hildenbrand <david@redhat.com>
Subject: Re: [Qemu-devel] security implications of caching with virtio pmem
	(was Re: [PATCH v3 0/5] kvm "virtio pmem" device)
Date: Mon, 11 Feb 2019 23:58:15 +0100
Message-ID: <b2be7796-9dee-b9fd-87e5-1ae570aa7db6__48302.2518268385$1549987214$gmane$org@redhat.com>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190204170515-mutt-send-email-mst@kernel.org>
	<888328358.132676.1549870186945.JavaMail.zimbra@redhat.com>
	<20190211222907.GR14116@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190211222907.GR14116@dastard>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Chinner <david@fromorbit.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-nvdimm@ml01.01.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, Andrea Arcangeli <aarcange@redhat.com>, dave jiang <dave.jiang@intel.com>, darrick wong <darrick.wong@oracle.com>, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, dchinner@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, linux-ext4@vger.kernel.org, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, imammedo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 11.02.19 23:29, Dave Chinner wrote:
> On Mon, Feb 11, 2019 at 02:29:46AM -0500, Pankaj Gupta wrote:
>> Hello Dave,
>> Are we okay with this?
> 
> Sure.
> 
> I'm not sure I agree with all the analysis presented, but, well, I
> haven't looked any deeper because I'm tired of being shouted at and
> being called argumentative for daring to ask hard questions about
> this topic....

I think if you have concerns, they should definitely be discussed.
Making people frustrated that review code is not what we want. Not at all.

I suggest that Pankaj properly documents what we found out so far about
security concerns and properly describes intended use cases and answers
other questions you had in the cover letter / documentation of the
follow up series.

Thanks Dave!

> 
> Cheers,
> 
> Dave.
> 


-- 

Thanks,

David / dhildenb
