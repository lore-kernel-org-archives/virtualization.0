From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: security implications of caching with virtio pmem (was Re: [PATCH v3
	0/5] kvm "virtio pmem" device)
Date: Mon, 4 Feb 2019 17:56:22 -0500
Message-ID: <20190204170515-mutt-send-email-mst__43722.0806534$1549340983$gmane$org@kernel.org>
References: <20190109144736.17452-1-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190109144736.17452-1-pagupta@redhat.com>
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
Cc: jack@suse.cz, kvm@vger.kernel.org, linux-nvdimm@ml01.01.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger.kernel@dilger.ca, zwisler@kernel.org, eblake@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, dave.jiang@intel.com, darrick.wong@oracle.com, vishal.l.verma@intel.com, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, lcapitulino@redhat.com, linux-ext4@vger.kernel.org, tytso@mit.edu, xiaoguangrong.eric@gmail.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


On Wed, Jan 09, 2019 at 08:17:31PM +0530, Pankaj Gupta wrote:
>  This patch series has implementation for "virtio pmem". 
>  "virtio pmem" is fake persistent memory(nvdimm) in guest 
>  which allows to bypass the guest page cache. This also
>  implements a VIRTIO based asynchronous flush mechanism.  


At Pankaj's request I looked at information leak implications of virtio
pmem in light of the recent page cache side channels paper
(https://arxiv.org/pdf/1901.01161.pdf) - to see what
kind of side channels it might create if any.  TLDR - I think that
depending on the host side implementation there could be some, but this
might be addressable by better documentation in both code and spec.
The fake dax approach backing the guest memory by a host page cache
does seem to have potential issues.

For clarity: we are talking about leaking information either to a VM, or
within a VM (I did not look into leaks to hypervisor in configurations
such as SEV) through host page cache.

Leaks into a VM: It seems clear that while pmem allows memory accesses
versus read/write with e.g. a block device, from host page cache point
of view this doesn't matter much: reads populate cache in the same way
as memory faults.  Thus ignoring presence of information leaks (which is
an interesting question e.g. in light of recent discard support) pmem
doesn't seem to be any better or worse for leaking information into a
VM.

Leaks within VM: Right now pmem seems to bypass the guest page cache
completely.  Whether pmem memory is then resident in a page cache would
be up to the device/host. Assuming that it is, the "Preventing
Efficient Eviction while Increasing the System Performance"
countermeasure for the page cache side channel attack would appear to
become ineffective with pmem. What is suggested is a per-process
management of the page cache, and host does not have visibility of
processes within a VM. Another possible countermeasure - not discussed
in the paper - could be modify the applications to lock the security
relevant pages in memory.  Again this becomes impractical with pmem as
host does not have visibility into that. However note that as long
as the only countermeasure linux uses is "Privileged Access"
(i.e. blocking mincore) nothing can be done as guest page cache
remains as vulnerable as host page cache.


Countermeasures: which host-side countermeasures can be designed would
depend on which countermeasures are used guest-side - we would need to
make sure they are not broken by pmem.  For "Preventing Efficient
Eviction while Increasing the System Performance" modifying the host
implementation to ensure that pmem device bypasses the host page cache
would seem to address the security problem.Similarly, ensuring that a
real memory device (e.g. DAX, RAM such as hugetlbfs, pmem for nested
virt) is used for pmem would make the memory locking countermeasure
work.  Whether with such limitations the device is still useful
performance wise is an open question.  These questions probably should
be addressed in the documentation, spec and possible qemu code.



Severity of the security implications: some people argue that the
security implications of the page cache leaks are minor.  I do not have
an opinion on this: the severity would seem to depend on the specific
configuration.


Other security implications: recent discussion seems to suggest there
are other concerns around e.g. resource management and thus DOS
potential. If that's so, it's a matter for a separate discussion
as I didn't look into that in depth.

Some or all of the above might be based on a misunderstanding of the
current pmem code, the whitepaper and linux page cache in general.
If so I apologise, do not hesitate to call out any mistakes.

Thanks!

-- 
MST
