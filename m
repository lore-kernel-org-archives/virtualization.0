From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Wed, 25 Aug 2010 10:16:30 +0200
Message-ID: <20100825081630.GE2153__29442.3095918775$1282724216$gmane$org@osiris.boeblingen.de.ibm.com>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
	<1282657732-20902-2-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1282657732-20902-2-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>, borntraeger@de.ibm.com, Carsten Otte <carsteno@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 24, 2010 at 03:48:51PM +0200, Alexander Graf wrote:
> +static void hotplug_devices(struct work_struct *dummy)
> +{
> +	unsigned int i;
> +	struct kvm_device_desc *d;
> +	struct device *dev;
> +
> +	for (i = 0; i < PAGE_SIZE; i += desc_size(d)) {

This should be 

	for (i = 0; i + desc_size(d) <= PAGE_SIZE; i += desc_size(d)) {

otherwise you might have memory accesses beyond the device page...

> +		d = kvm_devices + i;
> +
> +		/* end of list */
> +		if (d->type == 0)
> +			break;

...even if that should not happen if everything works.
But let's be paranoid.
