From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH RFC 0/8] virtio: add guest MSI-X support
Date: Tue, 28 Apr 2009 14:56:15 -0500
Message-ID: <49F75F5F.1000501__17032.3802078657$1240948756$gmane$org@codemonkey.ws>
References: <20090427123136.GA1152@redhat.com>
	<200904271600.30599.borntraeger@de.ibm.com>
	<49F5CA08.6060003@redhat.com> <20090427153936.GA2276@redhat.com>
	<49F6A672.8050704@redhat.com> <20090428174152.GA7604@redhat.com>
	<49F7420C.5070505@redhat.com> <20090428180248.GB7604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090428180248.GB7604@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> So to map vq 0 to vector 0, vq 1 to vector 1 and vq 2 to vector 2 the driver would do:
>
> struct virtio_interrupt_mapping mapping[3] = { {0, 0}, {1, 1}, {2, 2} };
> vec = map_vqs_to_interrupt(dev, mapping, 3);
> if (vec) {
>   error handling
> }
>
> and then find_vq as usual.
>   

Is it possible to just delay the msix enablement until after the queues 
have been finalized (IOW in virtio-pci.c:vp_finalize_features)?

Regards,

Anthony Liguori
