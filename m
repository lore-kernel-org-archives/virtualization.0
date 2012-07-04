From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio-balloon: fix add/get API use
Date: Wed, 04 Jul 2012 12:57:40 +0930
Message-ID: <87ipe4w6hf.fsf@rustcorp.com.au>
References: <patchbomb.1320306168@localhost6.localdomain6>
	<f3831c1617c86a51d875.1320306173@localhost6.localdomain6>
	<20120701092051.GA4515@redhat.com> <87d34fx990.fsf@rustcorp.com.au>
	<20120702073308.GB8268@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120702073308.GB8268@redhat.com>
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
Cc: virtualization <virtualization@lists.linux-foundation.org>, Rafael Aquini <aquini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2 Jul 2012 10:33:08 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> In virtio balloon virtqueue_get_buf might now run concurrently with
> virtqueue_kick.  I audited both and this seems safe in practice but
> this is not guaranteed by the API.
> Additionally, a spurious interrupt might in theory make
> virtqueue_get_buf run in parallel with virtqueue_add_buf, which is racy.
> 
> While we might try to protect against spurious callbacks it's
> easier to fix the driver: balloon seems to be the only one
> (mis)using the API like this, so let's just fix balloon.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I was thinking of a spinlock, but this is far more elegant.

And I added an explicit reference to the 'virtio: expose added
descriptors immediately.' commit in your commit msg.

Kudos!
Rusty.
