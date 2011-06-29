From: Christoph Hellwig <hch@infradead.org>
Subject: Re: virtio scsi host draft specification, v3
Date: Wed, 29 Jun 2011 06:27:50 -0400
Message-ID: <20110629102750.GA11648__23391.2300238901$1309343310$gmane$org@infradead.org>
References: <1504884387.187692.1307716550265.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<4DF71E28.6070009@suse.de> <4E0AE36B.9010500@redhat.com>
	<BANLkTik2AXXkWvV23OP1eDdLirP2N0PC3A@mail.gmail.com>
	<20110629100752.GA27744@infradead.org> <4E0AFD2A.80102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4E0AFD2A.80102@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <chellwig@redhat.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 29, 2011 at 12:23:38PM +0200, Hannes Reinecke wrote:
> The general idea here is that we can support NPIV.
> With NPIV we'll have several scsi_hosts, each of which is assigned a
> different set of LUNs by the array.
> With virtio we need to able to react on LUN remapping on the array
> side, ie we need to be able to issue a 'REPORT LUNS' command and
> add/remove LUNs on the fly. This means we have to expose the
> scsi_host in some way via virtio.
> 
> This is impossible with a one-to-one mapping between targets and
> LUNs. The actual bus-level pass-through will be just on the SCSI
> layer, ie 'REPORT LUNS' should be possible. If and how we do a LUN
> remapping internally on the host is a totally different matter.
> Same goes for the transport details; I doubt we will expose all the
> dingy details of the various transports, but rather restrict
> ourselves to an abstract transport.

If we want to support traditional NPIV that's what we have to do.
I still hope we'll see broad SR-IOV support for FC adapters soon,
which would ease all this greatly.
