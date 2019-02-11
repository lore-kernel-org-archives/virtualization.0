From: Dave Chinner <david@fromorbit.com>
Subject: Re: [Qemu-devel] security implications of caching with virtio pmem
	(was Re: [PATCH v3 0/5] kvm "virtio pmem" device)
Date: Tue, 12 Feb 2019 09:29:07 +1100
Message-ID: <20190211222907.GR14116__36349.0477598802$1549987184$gmane$org@dastard>
References: <20190109144736.17452-1-pagupta@redhat.com>
	<20190204170515-mutt-send-email-mst@kernel.org>
	<888328358.132676.1549870186945.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <888328358.132676.1549870186945.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, linux-nvdimm@ml01.01.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, Andrea Arcangeli <aarcange@redhat.com>, dave jiang <dave.jiang@intel.com>, darrick wong <darrick.wong@oracle.com>, vishal l verma <vishal.l.verma@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, dchinner@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, linux-ext4@vger.kernel.org, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, imammedo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 11, 2019 at 02:29:46AM -0500, Pankaj Gupta wrote:
> Hello Dave,
> Are we okay with this?

Sure.

I'm not sure I agree with all the analysis presented, but, well, I
haven't looked any deeper because I'm tired of being shouted at and
being called argumentative for daring to ask hard questions about
this topic....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
