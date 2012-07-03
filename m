From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] virtio-blk spec: document topology info, add WCE toggle
Date: Tue,  3 Jul 2012 15:16:50 +0200
Message-ID: <1341321412-24214-1-git-send-email-pbonzini@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: virtualization@lists.osdl.org, kvm@vger.kernel.org, rusty@rustcorp.com.au
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty, here are two improvements to the virtio-blk spec.

The first documents the status quo of an extension that has already
been supported in QEMU for several releases, but never made it to the
official spec.

The second adds support for toggling the cache mode between writethrough
and writeback.  Two mechanisms are introduced for this.  One is to not
negotiate VIRTIO_BLK_F_FLUSH; it can be done only at reset time and is
more of a refinement geared towards older or limited guests, in order to
make them safe wrt power losses.  The second is via feature bits and a
new configuration field.

Paolo Bonzini (2):
  virtio-blk spec: document topology info
  virtio-blk spec: writeback cache enable improvements

 virtio-spec.lyx |  136 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 4 deletions(-)

-- 
1.7.10.2

