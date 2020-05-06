From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: performance bug in virtio net xdp
Date: Wed, 6 May 2020 04:08:27 -0400
Message-ID: <20200506035704-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

So for mergeable bufs, we use ewma machinery to guess the correct buffer
size. If we don't guess correctly, XDP has to do aggressive copies.

Problem is, xdp paths do not update the ewma at all, except
sometimes with XDP_PASS. So whatever we happen to have
before we attach XDP, will mostly stay around.

The fix is probably to update ewma unconditionally.

-- 
MST
