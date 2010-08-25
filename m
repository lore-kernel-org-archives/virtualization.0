From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Wed, 25 Aug 2010 10:48:49 +0200
Message-ID: <20100825084849.GG2153__19344.5333083675$1282726104$gmane$org@osiris.boeblingen.de.ibm.com>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
	<1282657732-20902-2-git-send-email-agraf@suse.de>
	<20100825081630.GE2153@osiris.boeblingen.de.ibm.com>
	<FA6CB344-B4ED-45C1-8478-367038F5F95F@suse.de>
	<20100825083525.GF2153@osiris.boeblingen.de.ibm.com>
	<8A4DFC49-AAB9-4426-8124-583E448B6C98@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8A4DFC49-AAB9-4426-8124-583E448B6C98@suse.de>
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

On Wed, Aug 25, 2010 at 10:34:29AM +0200, Alexander Graf wrote:
> On 25.08.2010, at 10:35, Heiko Carstens wrote:
> > On Wed, Aug 25, 2010 at 10:20:03AM +0200, Alexander Graf wrote:
> >> On 25.08.2010, at 10:16, Heiko Carstens wrote:
> >>> On Tue, Aug 24, 2010 at 03:48:51PM +0200, Alexander Graf wrote:
> >>>> +static void hotplug_devices(struct work_struct *dummy)
> >>>> +{
> >>>> +	unsigned int i;
> >>>> +	struct kvm_device_desc *d;
> >>>> +	struct device *dev;
> >>>> +
> >>>> +	for (i = 0; i < PAGE_SIZE; i += desc_size(d)) {
> >>> 
> >>> This should be 
> >>> 
> >>> 	for (i = 0; i + desc_size(d) <= PAGE_SIZE; i += desc_size(d)) {
> >>> 
> >>> otherwise you might have memory accesses beyond the device page...
> >> 
> >> Oh, this is a simple copy&paste from the original search method.
> >> Is d valid in the first part of the loop already?
> > 
> > No, you would need to initialize it with kvm_devices if you change
> > the loop.
> 
> But even then it would take the size of the current entry, not the next
> one we're actually looking for, no? Maybe it'd be easier to just convert
> this into a while loop and explicitly open code everything.

Yes indeed. It's going to be quite ugly if you want to make sure that at
no time you're going to access memory beyond the device page. Eeek.. :)
