From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [GIT PULL net-2.6] vhost-net: rcu fixup
Date: Thu, 25 Nov 2010 14:23:01 +0200
Message-ID: <20101125122301.GA15990@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Please merge the following fix for 2.6.36.
Thanks!

The following changes since commit a27e13d370415add3487949c60810e36069a23a6:

  econet: fix CVE-2010-3848 (2010-11-24 11:51:47 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-net

Michael S. Tsirkin (1):
      vhost/net: fix rcu check usage

 drivers/vhost/net.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
-- 
MST
