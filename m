From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 0/2] macvtap, second try
Date: Thu,  3 Dec 2009 18:51:58 +0100
Message-ID: <1259862720-28432-1-git-send-email-arnd__633.445863104676$1259863031$gmane$org@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Edge Virtual Bridging <evb@yahoogroups.com>, Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>, "Fischer,
	Anna" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S . Miller \"" <davem@davemloft.net>, Anthony Liguori <anthony@codemonkey.ws>, Patrick Mullaney <pmullaney@novell.com>, virtualization@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

I did not get this ready for the merge window, but people asked what
the status of this is so I'm posting it now to solicit feedback.

The first patch just adds some hooks into macvlan.c and is less
invasive than the previous version. That part should be fine
and I'd like this to get merged into macvlan for 2.6.33 if people
agree that the approach is right.

The second patch adds the driver using it and is not ready for
integration unfortunately, but maybe it could get into staging
anyway. Please look at that patch carefully and provide feedback.

	Arnd <><
---

Arnd Bergmann (1):
  macvlan: add tap device backend

Patrick Mullaney (1):
  macvlan: Allow plugging in additional backends

 drivers/net/Kconfig        |   12 +
 drivers/net/Makefile       |    1 +
 drivers/net/macvlan.c      |  113 ++++-----
 drivers/net/macvtap.c      |  560 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/if_macvlan.h |   71 ++++++
 5 files changed, 693 insertions(+), 64 deletions(-)
 create mode 100644 drivers/net/macvtap.c
