From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] virtio-pci: fix host notifiers on bi-endian architectures
Date: Fri, 13 Mar 2015 09:03:12 +0100
Message-ID: <20150313090312.742d135c@bahia.local>
References: <20150311180212.8119.14734.stgit@bahia.local>
	<20150311210322-mutt-send-email-mst@redhat.com>
	<20150311230314.08e51843@bahia.local>
	<20150312075922-mutt-send-email-mst@redhat.com>
	<5501BDEB.5080603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5501BDEB.5080603@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 12 Mar 2015 17:25:15 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> 
> On 12/03/2015 08:08, Michael S. Tsirkin wrote:
> > But common header format is simple, it's always LE.
> > It does not depend on target.
> > To me this looks like a bug in memory_region_add_eventfd,
> > it should do the right thing depending on device
> > endian-ness.
> 
> I agree it seems to be a QEMU bug.
> 
> Paolo
> 

Yes you're right ! QEMU swaps the virtqueue id (adjust_endianness) according
to TARGET_WORDS, like it was coming from the guest but in fact it comes from
the host. The id should be fixed according to HOST_WORDS instead. Of course
this went unnoticed until TARGET_WORDS_BIGENDIAN != HOST_WORDS_BIGENDIAN,
which we have now with ppc64le hosts.

Patches to follow.

Thanks.

--
Greg
