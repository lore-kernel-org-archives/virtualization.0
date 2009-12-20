From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/3] vhost: fix use_mm usage
Date: Sun, 20 Dec 2009 19:16:08 +0200
Message-ID: <20091220171608.GA31713__10534.8181947649$1261329584$gmane$org@redhat.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

This patchset fixes an issue, pointed out by Al Viro, in how vhost net
calls use_mm, Works fine for me, and it's pretty straightforward.  If no
one sees any issues with it, this will be a good candidate for 2.6.33
(assuming vhost net itself gets pulled :( ).


Michael S. Tsirkin (3):
  vhost: prevent modification of an active ring
  vhost: add access_ok checks
  vhost: make default mapping empty by default

 drivers/vhost/net.c   |   23 ++++++--
 drivers/vhost/vhost.c |  153 ++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/vhost/vhost.h |    2 +
 3 files changed, 157 insertions(+), 21 deletions(-)

-- 
MST
