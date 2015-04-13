From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/2] virtio-balloon: virtio 1 support
Date: Mon, 13 Apr 2015 16:20:44 +0200
Message-ID: <20150413162044.2b985a4c.cornelia.huck@de.ibm.com>
References: <1428849904-28953-1-git-send-email-mst@redhat.com>
	<1428849904-28953-2-git-send-email-mst@redhat.com>
	<20150413100258.1f2c636f.cornelia.huck@de.ibm.com>
	<20150413132110-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150413132110-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Anthony Liguori <aliguori@amazon.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Apr 2015 13:26:31 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> BTW I suspect the stats code is broken for
> cross-endian platforms: it should do LE unconditinally,
> should it not?

Stats are guest-endian for legacy, so no. Only the config space is
always LE.
