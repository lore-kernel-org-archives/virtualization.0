From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
Date: Fri, 10 Feb 2017 12:32:49 +0100
Message-ID: <c229269b-1702-ffec-62e8-002c7c142904__47144.085498485$1486726376$gmane$org@redhat.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<240c623b-2d8f-28d9-d349-d01e2c24b93a@redhat.com>
	<20170208214435-mutt-send-email-mst@kernel.org>
	<cc075b18-0913-ef89-96a8-a29869abd73e@redhat.com>
	<20170209202203-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170209202203-mutt-send-email-mst@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 09/02/2017 19:24, Michael S. Tsirkin wrote:
>> I don't know.  Power of 2 ring size is pretty standard, I'd rather avoid
>> the complication and the gratuitous difference with 1.0.
>
> I thought originally there's a reason 1.0 rings had to be powers of two
> but now I don't see why. OK, we can make it a feature flag later if we
> want to.

The reason is that it allows indices to be free running.  This is an 
example of QEMU code that requires that:

            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
            /* Check it isn't doing strange things with descriptor numbers. */
            if (nheads > vdev->vq[i].vring.num) {
                error_report("VQ %d size 0x%x Guest index 0x%x "
                             "inconsistent with Host index 0x%x: delta 0x%x",
                             i, vdev->vq[i].vring.num,
                             vring_avail_idx(&vdev->vq[i]),
                             vdev->vq[i].last_avail_idx, nheads);
                return -1;
            }

Paolo
