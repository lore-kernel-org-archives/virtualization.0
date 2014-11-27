From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v3 11/12] virtio-net/virtio-blk: enable virtio 1.0
Date: Thu, 27 Nov 2014 11:34:20 +0100
Message-ID: <20141127113420.2eaaa82f.cornelia.huck__14943.7186577872$1417084483$gmane$org@de.ibm.com>
References: <1417022923-1654-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417022923-1654-12-git-send-email-cornelia.huck@de.ibm.com>
	<20141126185005.GA9549@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141126185005.GA9549@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 26 Nov 2014 20:50:05 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Nov 26, 2014 at 06:28:42PM +0100, Cornelia Huck wrote:
> > virtio-net (non-vhost) and virtio-blk have everything in place to support
> > virtio 1.0: let's enable the feature bit for them.
> 
> Hmm I doubt that.
> At least not without more patches.
> 
> For block, scsi, wce and config-wce must be off, and
> it must support ANY_LAYOUT (which might be a bit more code).
> 
> For net, header size is different when mergeable bufs are off,
> and mac is read-only.

Yeah, I'll need to walk through the spec again, this was mainly to test
my changes.
