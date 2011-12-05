From: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [net-next RFC PATCH 2/5] tuntap: simple flow director support
Date: Mon, 5 Dec 2011 20:09:23 +0000
Message-ID: <1323115763.2887.12.camel__31439.7990274758$1323115850$gmane$org@bwh-desktop>
References: <20111205085603.6116.65101.stgit@dhcp-8-146.nay.redhat.com>
	<20111205085857.6116.99252.stgit@dhcp-8-146.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111205085857.6116.99252.stgit@dhcp-8-146.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: krkumar2@in.ibm.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, levinsasha928@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2011-12-05 at 16:58 +0800, Jason Wang wrote:
> This patch adds a simple flow director to tun/tap device. It is just a
> page that contains the hash to queue mapping which could be changed by
> user-space. The backend (tap/macvtap) would query this table to get
> the desired queue of a packets when it send packets to userspace.

This is just flow hashing (RSS), not flow steering.

> The page address were set through a new kind of ioctl - TUNSETFD and
> were pinned until device exit or another new page were specified.
[...]

You should implement ethtool ETHTOOL_{G,S}RXFHINDIR instead.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
