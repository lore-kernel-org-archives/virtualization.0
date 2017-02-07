From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] virtio: Document DMA coherency
Date: Tue, 7 Feb 2017 12:45:09 -0600
Message-ID: <20170207184509.jqswjsqf7lzjbauc@rob-hp-laptop>
References: <89fb6454e6e4b4e7ac7df2e00b96271c0045f8b9.1486053223.git.robin.murphy@arm.com>
	<6cc1be2a3ace621293157a9828c9f1d3f47147c8.1486053223.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6cc1be2a3ace621293157a9828c9f1d3f47147c8.1486053223.git.robin.murphy@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, mst@redhat.com, will.deacon@arm.com, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 02, 2017 at 04:36:21PM +0000, Robin Murphy wrote:
> Since making use of the DMA API will require the architecture code to
> have the correct notion of device cache-coherency on architectures like
> ARM, explicitly call this out in the virtio-mmio DT binding. The ship
> has sailed for legacy virtio, but let's hope that we can head off any
> future firmware mishaps.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/devicetree/bindings/virtio/mmio.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
