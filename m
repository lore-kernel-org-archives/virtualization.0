From: Laura Abbott <labbott@redhat.com>
Subject: [REGRESSION] 07ec51480b5e ("virtio_pci: use shared interrupts for
	virtqueues") causes crashes in guest
Date: Wed, 22 Mar 2017 17:30:27 -0700
Message-ID: <43ffa887-a20d-f836-cba8-11196924d82d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Fedora has received multiple reports of crashes when running
4.11 as a guest

https://bugzilla.redhat.com/show_bug.cgi?id=1430297
https://bugzilla.redhat.com/show_bug.cgi?id=1434462
https://bugzilla.kernel.org/show_bug.cgi?id=194911
https://bugzilla.redhat.com/show_bug.cgi?id=1433899

The crashes are not always consistent but they are generally
some flavor of oops or GPF in virtio related code. Multiple people
have done bisections (Thank you Thorsten Leemhuis and 
Richard W.M. Jones) and found this commit to be at fault

07ec51480b5eb1233f8c1b0f5d7a7c8d1247c507 is the first bad commit
commit 07ec51480b5eb1233f8c1b0f5d7a7c8d1247c507
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Feb 5 18:15:19 2017 +0100

    virtio_pci: use shared interrupts for virtqueues
    
    This lets IRQ layer handle dispatching IRQs to separate handlers for the
    case where we don't have per-VQ MSI-X vectors, and allows us to greatly
    simplify the code based on the assumption that we always have interrupt
    vector 0 (legacy INTx or config interrupt for MSI-X) available, and
    any other interrupt is request/freed throught the VQ, even if the
    actual interrupt line might be shared in some cases.
    
    This allows removing a great deal of variables keeping track of the
    interrupt state in struct virtio_pci_device, as we can now simply walk the
    list of VQs and deal with per-VQ interrupt handlers there, and only treat
    vector 0 special.
    
    Additionally clean up the VQ allocation code to properly unwind on error
    instead of having a single global cleanup label, which is error prone,
    and in this case also leads to more code.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

:040000 040000 79a8267ffb73f9d244267c5f68365305bddd4696 8832a160b978710bbd24ba6966f462b3faa27fcc M	drivers

It doesn't revert cleanly so we haven't been able to do a clean
test. Any ideas?

Thanks,
Laura
