From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 10/10] virtio: enable endian checks for sparse builds
Date: Tue, 6 Dec 2016 23:30:21 -0800
Message-ID: <20161207073021.GA26970__49352.1416945898$1481095896$gmane$org@infradead.org>
References: <1481038106-24899-1-git-send-email-mst@redhat.com>
	<1481038106-24899-11-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1481038106-24899-11-git-send-email-mst@redhat.com>
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
Cc: kvm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-scsi@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Asias He <asias@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, Jens Axboe <axboe@fb.com>, Michal Marek <mmarek@suse.com>, Stefan Hajnoczi <stefanha@redhat.com>, Matt Mackall <mpm@selenic.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 06, 2016 at 05:41:05PM +0200, Michael S. Tsirkin wrote:
> __CHECK_ENDIAN__ isn't on by default presumably because
> it triggers too many sparse warnings for correct code.
> But virtio is now clean of these warnings, and
> we want to keep it this way - enable this for
> sparse builds.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Nah.  Please just enable it globally when using sparse.  I actually
had a chat with Linus about that a while ago and he seemed generally
fine with it, I just didn't manage to actually do it..
