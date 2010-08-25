From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Wed, 25 Aug 2010 10:20:03 +0200
Message-ID: <FA6CB344-B4ED-45C1-8478-367038F5F95F__30107.6754615226$1282724760$gmane$org@suse.de>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
	<1282657732-20902-2-git-send-email-agraf@suse.de>
	<20100825081630.GE2153@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100825081630.GE2153@osiris.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, borntraeger@de.ibm.com, Carsten Otte <carsteno@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org


On 25.08.2010, at 10:16, Heiko Carstens wrote:

> On Tue, Aug 24, 2010 at 03:48:51PM +0200, Alexander Graf wrote:
>> +static void hotplug_devices(struct work_struct *dummy)
>> +{
>> +	unsigned int i;
>> +	struct kvm_device_desc *d;
>> +	struct device *dev;
>> +
>> +	for (i = 0; i < PAGE_SIZE; i += desc_size(d)) {
> 
> This should be 
> 
> 	for (i = 0; i + desc_size(d) <= PAGE_SIZE; i += desc_size(d)) {
> 
> otherwise you might have memory accesses beyond the device page...

Oh, this is a simple copy&paste from the original search method. Is d valid in the first part of the loop already?

> 
>> +		d = kvm_devices + i;
>> +
>> +		/* end of list */
>> +		if (d->type == 0)
>> +			break;
> 
> ...even if that should not happen if everything works.
> But let's be paranoid.

Yeah :). I like paranoid.


Alex
