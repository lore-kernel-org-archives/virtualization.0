From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Mon, 27 Apr 2009 20:17:24 +0300
Message-ID: <20090427171724.GB2276__43452.2762815051$1240856706$gmane$org@redhat.com>
References: <20090427123136.GA1152@redhat.com>
	<200904271600.30599.borntraeger@de.ibm.com>
	<20090427143256.GD2504@redhat.com>
	<200904271737.25546.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904271737.25546.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 27, 2009 at 05:37:25PM +0200, Christian Borntraeger wrote:
> > As  number of virtqueues <= number of vectors,
> > we could pre-allocate all vectors that host supports, but this seems
> > a bit drastic as an MSI-X device could support up to 2K vectors.
> > 
> > > In fact, the transport has to have a way of getting the number of virtqeues
> > > because find_vq returns ENOENT on invalid index numbers.
> > > 
> > > Christian
> > 
> > So again, I think this is an upper bound supported by host. Right?
> 
> Not the upper bound, but the real available virtqueues. (With current qemu
> 3 for virtio-net, 2 for virtio-console etc.)

Here's what I mean by upper bound: guest and host number of
virtqueues might be different: the host might support
control virtqueue like in virtio-net, but guest might be an older
version and not use it.

> Since I use a different transport (drivers/s390/kvm/kvm_virtio.c), my
> motiviation is to keep the virtio interface as generic as possible. I
> dont really like the new interface, but I cannot give you silver
> bullet technical reasons - its more a gut feeling. The interface would
> work with lguest and s390.
> 
> Anyway. Avis suggestion to decouple MSI count and virtqueue count looks
> like a promising approach. 

So generally, we add request_vectors which gives us the number of
available MSI vectors and then find_vq gets a vector #?
Does this sound better?

-- 
MST
