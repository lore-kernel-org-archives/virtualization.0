From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-pci: fix host notifiers on bi-endian architectures
Date: Thu, 12 Mar 2015 17:25:15 +0100
Message-ID: <5501BDEB.5080603@redhat.com>
References: <20150311180212.8119.14734.stgit@bahia.local>	<20150311210322-mutt-send-email-mst@redhat.com>	<20150311230314.08e51843@bahia.local>
	<20150312075922-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150312075922-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 12/03/2015 08:08, Michael S. Tsirkin wrote:
> But common header format is simple, it's always LE.
> It does not depend on target.
> To me this looks like a bug in memory_region_add_eventfd,
> it should do the right thing depending on device
> endian-ness.

I agree it seems to be a QEMU bug.

Paolo
