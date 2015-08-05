From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-input: reset device during remove
Date: Wed, 05 Aug 2015 16:18:20 +0800
Message-ID: <55C1C6CC.9030108@redhat.com>
References: <1438759218-30038-1-git-send-email-jasowang@redhat.com>
	<20150805104654-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150805104654-mutt-send-email-mst@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 08/05/2015 03:56 PM, Michael S. Tsirkin wrote:
> On Wed, Aug 05, 2015 at 03:20:18PM +0800, Jason Wang wrote:
>> > Spec requires a device reset during cleanup, so do it and avoid warn
>> > in virtio core.
>> > 
>> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> OK but now that I look at this driver, that's not enough.
>
> Need to also detach and free unused buffers, otherwise
> we leak memory in evt and sts queues.

Probably only sts. For evt queue, all buffer it used was an array
embedded in virtio_input structure (vi->evts[])
