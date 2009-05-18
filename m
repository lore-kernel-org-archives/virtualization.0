From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv6 4/4] virtio_pci: optional MSI-X support
Date: Mon, 18 May 2009 14:01:47 +0300
Message-ID: <20090518110147.GA3037__25074.5668811307$1242644726$gmane$org@redhat.com>
References: <cover.1242297977.git.mst@redhat.com>
	<20090514105541.GE3120@redhat.com> <4A108209.4070805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A108209.4070805@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 18, 2009 at 12:30:49AM +0300, Avi Kivity wrote:
> Michael S. Tsirkin wrote:
>> This implements optional MSI-X support in virtio_pci.
>> MSI-X is used whenever the host supports at least 2 MSI-X
>> vectors: 1 for configuration changes and 1 for virtqueues.
>> Per-virtqueue vectors are allocated if enough vectors
>> available.
> 
>
> I'm not sure I understand how the vq -> msi mapping works.  Do we  
> actually support an arbitrary mapping, or just either linear or n:1?

Arbitrary mapping.

> I don't mind the driver being limited, but the device interface should  
> be flexible.  We'll want to deal with limited vector availability soon.

I agree.

The code in qemu lets you specify, for each queue, which MSIX vector you
want to use, or a special value if you don't want signalling. You also
specify which MSIX vector you want to use for config change
notifications, or a special value if you want to e.g. poll.

I think that's as flexible as it gets.

The API within guest is much simpler, but it does not need to be stable.

-- 
MST
