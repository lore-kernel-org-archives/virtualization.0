From: Seth Forshee <seth.forshee@canonical.com>
Subject: Performance regression with virtio_net
Date: Thu, 27 Jul 2017 12:09:42 -0500
Message-ID: <20170727170942.ub24lwgrl3x2outp__27967.7359424115$1509078828$gmane$org@ubuntu-hedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I'm seeing a performance regression with virtio_net that looks to have
started in 4.12-rc1. I only see it in one context though, downloading
snap packages from the Ubuntu snap store. For example:

 https://api.snapcraft.io/api/v1/snaps/download/b8X2psL1ryVrPt5WEmpYiqfr5emixTd7_1797.snap

which redirects to Internap's CDN. Normally this downloads in a few
seconds at ~10 MB/s, but with 4.12 and 4.13 it takes minutes with a rate
of ~150 KB/s. Everything else I've tried downloads as normal speeds.

I bisected this to 680557cf79f8 "virtio_net: rework mergeable buffer
handling". If I revert this on top of 4.13-rc2 (along with other changes
needed to successfully revert it) speeds return to normal.

Thanks,
Seth
