From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 0/7] Add virtio-iommu driver
Date: Fri, 12 Oct 2018 19:55:40 +0100
Message-ID: <17f1406e-a7a0-591f-749d-21cbda37dbe4__4837.79878491095$1539370450$gmane$org@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
	<20181012125443-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181012125443-mutt-send-email-mst@kernel.org>
Content-Language: en-US
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, robin.murphy@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On 12/10/2018 18:00, Michael S. Tsirkin wrote:
> This all looks good to me. Minor nits:
> - I think DEBUG mode is best just removed for now
> - Slightly wrong patch splitup causing a misaligned structure
>   in uapi until all patches are applied.

Thanks a lot for the review, I'll fix these up and send a new version

> You should Cc Bjorn on the pci change - I'd like to see his ack on it
> being merged through my tree.

Argh, I don't know how I missed him. However patches 1-4 are device tree
changes, and need acks from Rob or Mark (on Cc)

> And pls Cc the virtio-dev list on any virtio uapi changes.
> 
> At a feature level I have some ideas for more features we
> could add, but for now I think I'll put this version in -next
> while you iron out the above wrinkles. Hope you can make the
> merge window.
Thanks, I also have some work lined up for hardware acceleration and
shared address spaces.

Jean
