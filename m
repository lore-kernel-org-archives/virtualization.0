From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH 4/6] virtio_mmio: support non-legacy balloon devices
Date: Tue, 31 Mar 2015 13:31:35 +0100
Message-ID: <1427805095.8330.10.camel@arm.com>
References: <1427737006-23191-1-git-send-email-mst@redhat.com>
	<1427737006-23191-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427737006-23191-5-git-send-email-mst@redhat.com>
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2015-03-30 at 18:37 +0100, Michael S. Tsirkin wrote:
> virtio_device_is_legacy_only is always false now,
> drop the test from virtio mmio.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Slightly ironic ack ;-) after all the battle you fought for this:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
