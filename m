From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Wed, 10 Aug 2011 15:39:28 +0100
Message-ID: <20110810143928.GA10780__3396.33642365715$1312987388$gmane$org@stefanha-thinkpad.localdomain>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<20110619071452.GA7930@redhat.com>
	<BANLkTi=fsSLNu2ybeMKvN7gtCDO5FDNfDA@mail.gmail.com>
	<20110810131801.GA12571@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110810131801.GA12571@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 10, 2011 at 09:18:01AM -0400, Christoph Hellwig wrote:
> Any progress on these patches?

Khoa ran ffsb benchmarks on his rig and we didn't see any benefit.  I
have not started investigating yet, been working on other things.

It will be necessary to compare against the old patches which did show
an improvment last year when we ran them.  Then we'll know if I broke
something in the new patches.

If you like I can send the latest patches for you to take a look.  I
will not get a chance to play with this until after LinuxCon.

Stefan
