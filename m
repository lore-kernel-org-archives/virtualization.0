From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 0/3] virtio/vhost: Add checks for uninitialized VQs
Date: Mon, 01 Apr 2013 16:51:18 -0700
Message-ID: <1364860278.20769.67.camel__29689.6465858028$1364860319$gmane$org@haakon2.linux-iscsi.org>
References: <1364531592-8368-1-git-send-email-nab@linux-iscsi.org>
	<20130331074559.GD23484@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130331074559.GD23484@redhat.com>
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
Cc: kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2013-03-31 at 10:46 +0300, Michael S. Tsirkin wrote:
> On Fri, Mar 29, 2013 at 04:33:09AM +0000, Nicholas A. Bellinger wrote:
> > From: Nicholas Bellinger <nab@linux-iscsi.org>
> > 
> > Hi folks,
> > 
> > This series adds a virtio_queue_valid() for use by virtio-pci code in
> > order to prevent opreations upon uninitialized VQs, that is currently
> > expected to occur during seabios setup of virtio-scsi.
> > 
> > This also includes a vhost specific check for uninitialized VQs in
> > vhost_verify_ring_mappings() to avoid this same case.
> > 
> > Please review.
> > 
> > --nab
> 
> Okay, and does this fix the failures in vhost_verify_ring_mappings
> that you've observed?
> 

Unfortunately, no.  I've done some more digging and will follow up with
additional details on the original thread shortly..

--nab
