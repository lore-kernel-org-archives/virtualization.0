From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: 2.6.40 event idx patches
Date: Tue, 24 May 2011 12:23:45 +0300
Message-ID: <20110524092345.GA17087@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Just checking: were you going to send the following to Linus for 2.6.40?
virtio:event_index_interface.patch
virtio:ring_inline_function_to_check_for_events.patch
virtio:ring_support_event_idx_feature.patch
misc:vhost_support_event_index.patch
virtio:test_support_event_index.patch
virtio:add_api_for_delayed_callbacks.patch
virtio:net_delay_tx_callbacks.patch

I certainly hope so as these modify both host and guest which makes
testing them out of tree hard for people.
Once stuff lands on Linus' tree we can patch
qemu and get more people to try out the patches.

Also, Linus said it's going to be a short window so ...

-- 
MST
