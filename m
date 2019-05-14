From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v8 2/6] virtio-pmem: Add virtio pmem driver
Date: Tue, 14 May 2019 11:57:05 +0200
Message-ID: <cd5572ac-14d0-f872-6321-c522daa70f49__29912.3383754463$1557827855$gmane$org@redhat.com>
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-3-pagupta@redhat.com>
	<f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com>
	<752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com>
	<86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
	<712871093.28555872.1557827242385.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <712871093.28555872.1557827242385.JavaMail.zimbra@redhat.com>
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
To: Pankaj Gupta <pagupta@redhat.com>
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, jstaron@google.com, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.or
List-Id: virtualization@lists.linuxfoundation.org

>>
>> I think you should do the same here, vdev->priv is allocated in
>> virtio_pmem_probe.
>>
>> But maybe I am missing something important here :)
> 
> Because virtio_balloon use "kzalloc" for allocation and needs to be freed. 
> But virtio pmem uses "devm_kzalloc" which takes care of automatically deleting 
> the device memory when associated device is detached.

Hehe, thanks, that was the part that I was missing!

-- 

Thanks,

David / dhildenb
