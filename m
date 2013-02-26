From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/5] kvm: Make ioeventfd usable on s390.
Date: Tue, 26 Feb 2013 12:29:58 +0100
Message-ID: <512C9CB6.2090208__17575.813495978$1361878840$gmane$org@de.ibm.com>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
	<20130226110421.GB10915@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130226110421.GB10915@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 26/02/13 12:04, Michael S. Tsirkin wrote:
> On Mon, Feb 25, 2013 at 04:27:45PM +0100, Cornelia Huck wrote:
>> Here's the latest version of my patch series enabling ioeventfds
>> on s390, again against kvm-next.
>>
>> Patches 1 and 2 (cleaning up initialization and exporting the virtio-ccw
>> api) would make sense even independent of the ioeventfd enhancements.
>>
>> Patches 3-5 are concerned with adding a new type of ioeventfds for
>> virtio-ccw notifications on s390. The naming is now hopefully clearer.
>> We won't add ioeventfd support for the legacy s390-virtio transport.
>>
>> Please consider applying.
> 
> I just had a thought: this makes us lookup the device on the bus
> for each notification. It would be better to simply get the
> device index from guest instead.
> 
> We could validate that it matches the correct device,
> if not - fallback to the current linear scan.
> 
> We could return the index to guest for the next call.
> 
> I know this needs guest changes but it's still not too late to
> fix this for 3.9 guests so that we won't need to worry
> about compatibility going forward.
> 

Hmm, this would certainly have the best scalability, but such
a change would require adotions to the virtio spec and getting this
fully tested till 3.9 seems somewhat dangerous. 
So I would prefer to actually improve the lookup (e.g. with a tree or hash)
in kvm_io_bus_write or something like that as a first step.

We also have some guests in the wild  (sles11sp3 beta) that already
use the current interface, so compatibility is already a an interesting
aspect (does being a beta counts?)

Just thinking loud here, we might be able to do this in a compatible way.
The vq number that we pass is 64bit, but we dont need such a big range. The
guest could use the upper 32 bit as a cookie (old code will have 0 ---> list
traversal). We must have a query cookie function, that will return 0 on
older qemus, though. Such an optimization could be added later on without
needing to rush.

Ideas, opinions?

Christian
