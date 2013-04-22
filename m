From: Laszlo Ersek <lersek@redhat.com>
Subject: suggesting wording fixes for virtio-spec 0.9.5
Date: Mon, 22 Apr 2013 19:55:56 +0200
Message-ID: <517579AC.2050400@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

(I'm not subscribed to either list,)

using the word "descriptor" is misleading in the following sections:

  2.4.1.2 Updating The Available Ring

  [...] However, in general we can add many descriptors before we
  update the idx field (at which point they become visible to the
  device), so we keep a counter of how many we've added: [...]

and

  2.4.1.3 Updating The Index Field

  Once the idx field of the virtqueue is updated, the device will be
  able to access the descriptor entries we've created and the memory
  they refer to. [...]

(The word "descriptor" in the above language is the reason I
mis-implemented the virtio-blk guest driver in OVMF.)

In fact the available ring tracks *head* descriptors only. I suggest

  s/many descriptors/many separate descriptor chains/
  s/descriptor entries/separate descriptor chains/

for the above.

Similarly, 2.3.4 Available Ring should start with something like

  The available ring describes what descriptor chains we are offering
  the device: each entry of the available ring refers to the head
  descriptor of a separate descriptor chain.

Thanks
Laszlo
